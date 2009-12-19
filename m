From: Andrew Myrick <amyrick@gmail.com>
Subject: git-svn mergeinfo support performance problem
Date: Fri, 18 Dec 2009 17:08:42 -0800
Message-ID: <6b2f9b1d0912181708g32645b48j3886b74101e77d80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 02:09:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLnoy-0002p2-1M
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 02:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976AbZLSBJF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Dec 2009 20:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754258AbZLSBJF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 20:09:05 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:60036 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909AbZLSBJD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Dec 2009 20:09:03 -0500
Received: by iwn1 with SMTP id 1so2556438iwn.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 17:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=L0NfjIdpEj/KFj+Z2my+fuFYZP7Mt/7P7SVTbI+Wu7s=;
        b=OW+mRldeyxoq+LT2KA4rNMDl7cD6Kd3tXWoKXIQ1d6Z4Z9QzpmzPG0K5sBLxFp/kKC
         eWS8Lu2b2kanivUWVvLinBUAQFWjINMON/9tLLxO6ARb1W1MJQw59LuNCXNQGFLtxR3a
         5VD6glEfX0LZFeIZDEp7vQxA/SBBiSbpFhGOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=hPvWsLKhK00WCjNOFZq1HRkdQwlvY3voOcfQuFa2KSHNqPqh5l5UN1TFOPejqWwAw+
         ThbRm/OXi3h9H//cadhmBDk6jT3FME/Aq1fK92DvVWNvsC9luSZpko4nzYSeTXcPNQV7
         3VTkuDMIWDozVaZHyi+Sn1zRANHlnOendahmU=
Received: by 10.231.125.100 with SMTP id x36mr1975965ibr.52.1261184942102; 
	Fri, 18 Dec 2009 17:09:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135452>

I've been testing git-svn v1.6.6-rc3's mergeinfo support on a large
svn repository=C2=A0(60,000+ revisions, 20+ GiB)=C2=A0that uses a very
branch-heavy integration model in which every change gets its own
branch before being committed to trunk.  As a result of the model,
there are currently over 1000 lines in the svn:mergeinfo property on
trunk.  Unfortunately, with the current implementation, git svn fetch
takes more than a minute per revision pouring through all of those
merge tickets; obviously, this is too slow to be usable for my
repository.

Are there any ideas on how git svn fetch can be sped up when facing
hundreds of mergeinfo properties? =C2=A0Alternatively, would it be poss=
ible
to add an argument that would ignore the merge info? =C2=A0Or,=C2=A0is =
there any
maintenance I could perform on the svn repository that would help
reduce the amount of work that git-svn must do? =C2=A0In the meantime, =
I'll
have to stick with git 1.6.5.*.

Regards,
Andrew

P.S. =C2=A0This is my first post to the list. =C2=A0My apologies if thi=
s issue
has already been discussed and I did not see it in the archives, or if
I have missed a more formal mechanism for filing bug reports.

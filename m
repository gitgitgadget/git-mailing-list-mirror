From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Re: [BUG] git config: cygwin git version 1.6.1.2 does not deletes 
	empty sections
Date: Wed, 6 May 2009 20:04:25 +0400
Message-ID: <85647ef50905060904w49879c57r4a5773a487f09c85@mail.gmail.com>
References: <85647ef50905060850t2e6c2051jfa6d3596b680cc74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 18:04:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1jbj-0004oJ-RH
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 18:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757308AbZEFQE1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 12:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbZEFQE0
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 12:04:26 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:42763 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756781AbZEFQEZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 12:04:25 -0400
Received: by bwz22 with SMTP id 22so223680bwz.37
        for <git@vger.kernel.org>; Wed, 06 May 2009 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=x055Xy1jgnYG4/PGKTfa0Lh1zu6YoiyPSR0cxA6MKrE=;
        b=qVR16CnmSvBv0OcAVS5Hs8qP4Ia2c5FD2b4Nspbu+sR4eXyaIajaxKmkMBfiW2ZErA
         N607NGxPsENsjkWUFZch4fuevgGgv8jkM258SaKuhgyySsje8DdgtY4BS2M1f2pwph6a
         b4q62dDdbRc3lKpt28ap88FaRj/JYc4epicBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=jAsiZq0Z+JwdF3vlB1cCYXcIHwGjvKGLROH2W6Jlc4fpJQ0vBByuLak2d340t/xo7F
         yHrg8ACCkNLVcHYs1rpH/Xdy0RcZ/vrr4dIUsX9nOnyZCyU5rGqZiJoaQSsxKM+qbslZ
         WqhaynStrVwYgwBOFqrDTv+GtPJ0a2A0W5Lcc=
Received: by 10.204.64.67 with SMTP id d3mr1348936bki.142.1241625865507; Wed, 
	06 May 2009 09:04:25 -0700 (PDT)
In-Reply-To: <85647ef50905060850t2e6c2051jfa6d3596b680cc74@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118351>

The bug is also confirmed on MSYS git version 1.6.2.2.1669.g7eaf8.

Constantine

On Wed, May 6, 2009 at 7:50 PM, Constantine Plotnikov
<constantine.plotnikov@gmail.com> wrote:
> I have encountered a bug related to git config in cygwin git version =
1.6.1.2
>
> The git config --unset might leave an empty section when the last
> property is deleted. But consequent "git config key value" does not
> uses this empty section. So the following script leaves a sequence of
> empty sections "[a]". Looks like a disk space leak to me.
>
> git config a.b a
> git config --unset a.b
> git config a.b a
> git config --unset a.b
> git config a.b a
> git config --unset a.b
> git config a.b a
> git config --unset a.b
>
> The resulting .git/config file:
>
> [core]
> =A0 =A0 =A0 =A0repositoryformatversion =3D 0
> =A0 =A0 =A0 =A0filemode =3D true
> =A0 =A0 =A0 =A0bare =3D false
> =A0 =A0 =A0 =A0logallrefupdates =3D true
> =A0 =A0 =A0 =A0ignorecase =3D true
> [a]
> [a]
> [a]
> [a]
>
> Was this bug fixed in later versions?
>
> Constantine
>

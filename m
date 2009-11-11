From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: P4 Sync problem
Date: Wed, 11 Nov 2009 09:43:42 +0100
Message-ID: <1a6be5fa0911110043i63b5c032s7924f9f1cdfe32ee@mail.gmail.com>
References: <loom.20091110T145046-137@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 09:43:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N88nt-0007nU-Nv
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 09:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbZKKIni convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 03:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbZKKIni
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 03:43:38 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:39878 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbZKKInh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 03:43:37 -0500
Received: by bwz27 with SMTP id 27so781120bwz.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 00:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OAxUenw3tp4fIL2bRRf2m7ecrjcgxNwN3CNjBmZybGA=;
        b=qNCA3QV1bw6HxzyaYW0dus23bABhL8rWiSvH6fzSVb8VMglPN2Bffq6qkJ1BibAbFc
         WF7TCNGFVY1rHClS+lxsyhaPBUFOUxDHWOXB8CaGMrdf9znobQ3tR4bgxfJMgPtLmzQI
         D6ZHx6KcLOJwNkIE6D8aJyeK1LcT3xOUXvQyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uR3hXwOQds2DYZy2zOti7Y0jz//JMVg/1SIi4L2zGj8CYQUVMOc76JARMgLYtUh3iF
         3GOdxctsYG9UdAsx0fowcWJYIzc+CI2yDEp3qMr42qRtL9T/VVLrV2OxSfMSQ84Xx5Oy
         sr28d8L/jmyjvsWOTwQ+mtfPLwCE343Fu2zRs=
Received: by 10.239.139.143 with SMTP id t15mr126446hbt.92.1257929022308; Wed, 
	11 Nov 2009 00:43:42 -0800 (PST)
In-Reply-To: <loom.20091110T145046-137@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132623>

On Tue, Nov 10, 2009 at 2:56 PM, Dmitry Smirnov <divis1969@gmail.com> w=
rote:
> Hi,
>
> I'm trying to import Perfoce client into Git repository.
> I had configured git-p4.clent=3DMYCLIENT and git-p4.useclientspec=3Dt=
rue.
>
> When runnign git p4 sync --verbose I got the follwing:
>
> c:\p4\views\Git\p4client>git p4 sync --verbose
<snip>
> Traceback (most recent call last):
> =C2=A0File "/usr/sbin/git-core//git-p4", line 1929, in ?
> =C2=A0 =C2=A0main()
> =C2=A0File "/usr/sbin/git-core//git-p4", line 1924, in main
> =C2=A0 =C2=A0if not cmd.run(args):
> =C2=A0File "/usr/sbin/git-core//git-p4", line 1676, in run
> =C2=A0 =C2=A0changes =3D p4ChangesForPaths(self.depotPaths, self.chan=
geRange)
> =C2=A0File "/usr/sbin/git-core//git-p4", line 442, in p4ChangesForPat=
hs
> =C2=A0 =C2=A0assert depotPaths
> AssertionError

Hi. So - I think the problem is that git-p4 doesn't understand what it
is you want to sync. The git-p4.useclientspec flag was created for the
purpose where your perforce depot may look like this:

//depot/project1
//depot/project1/source_code
//depot/project1/documentation
//depot/project1/some_large_collection_of_binaries

Then - if I set up my client spec like:

//depot/...
-//depot/project1/some_large_collection_of_binaries

=2E.. and do

git p4 sync //depot/project1@all

=2E.. it should get all project1 files except the
"some_large_collection_of_binaries" subdirectory (provided that you
have set the git-p4.client and git-p4.useclientspec).

-Tor Arvid-

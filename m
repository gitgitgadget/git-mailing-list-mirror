From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: 1.8.3 - gitignore not being parsed correctly on OS X; regex support is broken?
Date: Tue, 28 May 2013 21:35:01 +0000 (UTC)
Message-ID: <loom.20130528T232459-307@post.gmane.org>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 23:40:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhRct-0001Ur-Rb
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 23:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747Ab3E1VkJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 May 2013 17:40:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:58301 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757698Ab3E1VkG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 17:40:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UhRci-0001Jy-2k
	for git@vger.kernel.org; Tue, 28 May 2013 23:40:04 +0200
Received: from 233.5.200.37.customer.cdi.no ([37.200.5.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 May 2013 23:40:04 +0200
Received: from oystwa by 233.5.200.37.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 May 2013 23:40:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 37.200.5.233 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.22 (KHTML, like Gecko) Ubuntu Chromium/25.0.1364.160 Chrome/25.0.1364.160 Safari/537.22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225688>

Misty De Meo <misty <at> brew.sh> writes:

>=20
> Hi,
>=20
> Gitignore parsing no longer seems to work properly in git 1.8.3.
>=20
> One of my repositories has the following gitignore:
>=20
> /*
> !/.gitignore
> !/Library/
> !/CONTRIBUTING.md
> !/README.md
> !/SUPPORTERS.md
> !/bin
> /bin/*
> !/bin/brew
> !/share/man/man1/brew.1
> .DS_Store
> /Library/LinkedKegs
> /Library/PinnedKegs
> /Library/Taps
> /Library/Formula/.gitignore
>=20
> In 1.8.2.3 and earlier, this works as expected. However, in 1.8.3 I'm
> seeing every file in /bin/ being marked as an untracked file.
>=20
> I asked about this in #git, and was told that the culprit was the
> regex support; apparently recompiling without regex support fixes the
> specific gitignore issue. However, this doesn't seem to have been
> reported anywhere on the mailing list that I can see. I was also told
> that the issue is OS X-specific, and doesn't happen on other
> platforms.
>=20
> Thanks,
> Misty De Meo
>=20

I see a similar problem using e.g. the following .gitignore to exclude
everything except C source files and header files:

    *
    !*/
    !*.c
    !*.h

In Git 1.8.3 'git status' will show other files as untracked while in
Git 1.8.2.3 I don't have that problem. I bisected to find that the
offending commit is v1.8.2.1-402-g95c6f27.=20

I am not on OSX, however, but on Linux (Ubuntu 12.04 and RHEL 5.8) so
this may be a separate issue. I've also gotten the impression that this
is intentional. In any case I cannot create a .gitignore that achieves
the same for both older and newer versions of Git.

Best regards,
=C3=98ystein Walle

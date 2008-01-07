From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 17:05:26 +0100
Message-ID: <9D6F756F-2709-4F8E-8DBB-298DD4B49C66@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <5C0F88FD-AB2F-4BAD-ADEC-75428F14260F@zib.de> <flsu0r$m9p$1@ger.gmane.org> <Pine.LNX.4.64.0801071447320.1864@ds9.cixit.se>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Peter Klavins <klavins@netspace.net.au>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Jan 07 17:05:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBuTt-0007Iy-Uv
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 17:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbYAGQFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 11:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbYAGQFK
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 11:05:10 -0500
Received: from mailer.zib.de ([130.73.108.11]:40848 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753120AbYAGQFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 11:05:09 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m07G4LUO013256;
	Mon, 7 Jan 2008 17:04:45 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m07G4KZl018403
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 7 Jan 2008 17:04:20 +0100 (MET)
In-Reply-To: <Pine.LNX.4.64.0801071447320.1864@ds9.cixit.se>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69793>


On Jan 7, 2008, at 2:50 PM, Peter Karlsson wrote:

> Steffen Prohaska:
>
>> Per default, CRLF conversion is disabled in msysgit.  Git should
>> not convert a single file.  Does it really convert some?
>
> I didn't verify, but it was only some files that had LFs, perhaps the
> files that I added while on the Windows machine had CRLFs. That's bad.

This is a typical problem.  Once CRLFs are in your repository
autocrlf can't "just work" anymore.  You need to commit a fixed
version of the files.


> Peter Klavins:
>
>> Visual Studio in fact happily works with files that only have lf
>> endings, _except_ *.sln and *.vcproj files, which it much prefers to
>> have with cr/lf endings.
>
> The project files were added to the repository on the Windows box
> (obviously), so those are correct.
>
>
> So apparently my repository is a bit broken at the moment with LF on
> some files and CRLF on some. That's bad. I just assumed everything
> worked, it used to "just work" for CVS (except for when you actually
> tried to add binary files, of course).

"Just works" has a different meaning for git than it has for CVS.
For git, it means that once you _told_ git how to convert line
endings (that is you have correctly configured autocrlf), git
will automatically detect text files and convert them, but leave
binary files untouched.  It "just works" in the sense that you do
not need to explicitly tell git about every single binary files
(no cvs -kb needed).  Git will auto-detect the file type.

But if you does tell git to convert line endings it "just works"
as if every file was binary.  Per default, git does not modify
your content.  And for some people, "just works" means exactly
this: leave my content as is.

So it really depends on the context and therefore some
configuration is inevitable.  git requires you to configure
autocrlf.  cvs requires you to set -kb.

You may, though, set "core.autocrlf true" globally for your
account.  After you did this, git should "just work" for you; if
"just works" means convert CRLF in _all_ text files in _every_
repository.

	Steffen

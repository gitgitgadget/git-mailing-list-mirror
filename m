From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Umlaut in filename makes troubles
Date: Tue, 1 Dec 2009 13:48:59 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0912011325481.14365@iabervon.org>
References: <200912010815.14515.rick23@gmx.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-321613478-1259692903=:14365"
Cc: git@vger.kernel.org
To: rick23@gmx.net
X-From: git-owner@vger.kernel.org Tue Dec 01 19:49:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFXme-0008Dn-OS
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 19:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbZLASs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 13:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbZLASs4
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 13:48:56 -0500
Received: from iabervon.org ([66.92.72.58]:57838 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbZLASs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 13:48:56 -0500
Received: (qmail 19255 invoked by uid 1000); 1 Dec 2009 18:48:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Dec 2009 18:48:59 -0000
In-Reply-To: <200912010815.14515.rick23@gmx.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Content-ID: <alpine.LNX.2.00.0912011341590.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134244>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-321613478-1259692903=:14365
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.2.00.0912011341591.14365@iabervon.org>

On Tue, 1 Dec 2009, rick23@gmx.net wrote:

> I have problems with my repository under slackware vs. windows. I 
> created a repo in linux and every time I use it under msysgit, the 
> files containing umlauts in the filename are marked as deleted (and 
> vice versa).
> 
> For instance: the repo perfectly synced under msysgit leads to:
> 
> user@sauron:/media/disk-2$ git status |grep Auszug
> #       deleted:    "trunk/007_Literatur/Auszug aus Ergonomische 
> Untersuchung des Lenkgef\374hles.docx"
> #       "trunk/007_Literatur/Auszug aus Ergonomische Untersuchung des 
> Lenkgef\303\274hles.docx"

So the directory contains the utf-8 name, but the index contains a latin-1 
name, when you wrote it under Windows and are looking at it under Linux. 
You probably want to use utf-8 for your repository, so that it's not 
specific to your locale.

> in linux. But the file exists and is displayed correctly in the shell 
> or in dolphin (my filemanager under X):
> 
> user@sauron:/media/disk-2$ ls trunk/007_Literatur/Auszug*
> trunk/007_Literatur/Auszug aus Ergonomische Untersuchung des 
> Lenkgefühles.docx

You've got a utf-8 filesystem, so the u-with-umlaut is the two-byte 
sequence git is showing in the message as being present, not the single 
byte that it's showing as deleted. It looks like you're actually using 
utf-8 for what's on the usb stick, so you probably want the names listed 
in the repository to match that, which means that the correct one here is 
Linux.

> Can you please give me a hint what to do?

Convince Windows (or msysgit) to report filenames to git in utf-8. (I 
don't know *how*, but that's *what* you probably want to do.)

Once you've got everything agreeing on the character set used for 
filenames, you can disable "core.quotepath" to make the messages appear 
with umlauts; if you turned that off before fixing the inconsistancy, it 
would be much trickier to debug, because the "deleted" line would contain 
something that your Linux display won't consider a valid character.

	-Daniel
*This .sig left intentionally blank*
--1547844168-321613478-1259692903=:14365--

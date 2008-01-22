From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to UTF8
Date: Tue, 22 Jan 2008 09:21:56 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801220917310.20753@xanadu.home>
References: <fn1nl6$ek5$1@ger.gmane.org> <fn1pj9$kkg$1@ger.gmane.org>
 <fn1ptk$ljj$1@ger.gmane.org> <fn1q6b$ljj$2@ger.gmane.org>
 <7vve5nzdqx.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0801212025050.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Mark Junker <mjscod@web.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 15:22:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHK1G-0005VA-Ny
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 15:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbYAVOV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 09:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753444AbYAVOV6
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 09:21:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:52763 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbYAVOV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 09:21:57 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JV100JV1UKKT180@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 22 Jan 2008 09:21:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.00.0801212025050.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71452>

On Mon, 21 Jan 2008, Linus Torvalds wrote:

> First off, the common case is that the filename likely has everything in 
> plain 7-bit ascii. So rather than re-encoding by default, the first thing 
> to do is to just see if it even needs re-encoding. Even if it's as simple 
> as saying "does it have any high bits at all", that's going to be a *huge* 
> performance win.
> 
> So start off with something like
> 
> 	int is_usascii(const char *p)
> 	{
> 		char c;
> 
> 		do {
> 			c = *p++;
> 		} while (c > 0);
> 		return !c;
> 	}

You need to use "signed char" here.  On ARM a char is unsigned by 
default.  That's the case on some other systems too.


Nicolas

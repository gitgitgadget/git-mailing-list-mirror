From: Nicolas Pitre <nico@cam.org>
Subject: Re: Unresolved issues
Date: Tue, 20 Feb 2007 20:51:31 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702202003370.31945@xanadu.home>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org>
 <7vfy90v729.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702201648000.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 02:58:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJgko-00034O-KJ
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 02:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbXBUB5B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 20:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbXBUBvq
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 20:51:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11048 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824AbXBUBvc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 20:51:32 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDS00APBIHV94G0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Feb 2007 20:51:32 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0702201648000.4043@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40275>

On Tue, 20 Feb 2007, Linus Torvalds wrote:

> 
> > It's a local setup if you want auto-CRLF or not. So, why not just make it 
> > a local setting (if in config or $GIT_DIR/info/gitattributes, I don't 
> > care) which shell patterns are to be transformed on input and/or output?
> 
> That is a good point. We *could* just make it a ".git/config" issue, which 
> has the nice benefit that you can just set up some user-wide rules rather 
> than making it be per-repo.
> 
> Of course, the config language may not be wonderful for this. But we could 
> certainly have something like
> 
> 	[format "crlf"]
> 		enable = true
> 		text = *.[ch]
> 		binary = *.jpg

I think this is not generic enough.  For one thing this should not be 
used for crlf only.  There is also the binary patch generation code that 
wants to know if a file is binary or not.

What about:

	[filetype "text"]
		match=*.[ch]
		attribute=text
		crlfmangle=true

	[filetype "images"]
		match=*.jpg
		attribute=binary
		merge=special_jpg_merger

etc.


Nicolas

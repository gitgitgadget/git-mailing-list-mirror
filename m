From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add --no-reuse-delta option to git-gc
Date: Sun, 10 Jun 2007 21:51:03 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706102144080.12885@xanadu.home>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
 <11786309073709-git-send-email-tytso@mit.edu>
 <11786309072612-git-send-email-tytso@mit.edu>
 <11786309071033-git-send-email-tytso@mit.edu>
 <Pine.LNX.4.64.0705090056231.18541@iabervon.org>
 <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net> <46418E24.9020309@midwinter.com>
 <20070509191052.GD3141@spearce.org> <466BAAD0.9060408@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Steven Grimm <koreth@midwinter.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 03:51:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxZ42-0005GJ-Ps
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 03:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760073AbXFKBvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 21:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759080AbXFKBvN
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 21:51:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15288 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758585AbXFKBvM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 21:51:12 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJG00GE27T30130@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Jun 2007 21:51:03 -0400 (EDT)
In-reply-to: <466BAAD0.9060408@vilain.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49811>

On Sun, 10 Jun 2007, Sam Vilain wrote:

> Now I'm not an expert on compression algorithms but I think a large part
> of the reason gzip is blindingly faster than bzip2 is because gzip uses
> a 64k buffer and bzip2 a 900k one. Only now are CPUs getting caches
> large enough to deal with that size of buffer, the rest of the time
> you're waiting for your RAM. Moore's law was supposed to make bzip2 fast
> one of these days but I'm still waiting.
> 
> Anyway it's a free world so be my guest to implement it, I guess if this
> was selectable it would only be a minor annoyance waiting a bit longer
> pulling from from some repositories, and it would be interesting to see
> if it did make a big difference with pack file sizes.

It won't happen for a simple reason: to be backward compatible with 
older GIT clients.  If you have your repo compressed with bzip2 and an 
old client pulls it then the server would have to decompress and 
recompress everything with gzip.  If instead your repo remains with gzip 
and a new client asks for bzip2 then you have to recompress as well 
(slow).  So in practice it is best to remain with a single compression 
method.


Nicolas

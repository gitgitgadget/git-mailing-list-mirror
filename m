From: Nicolas Pitre <nico@cam.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 12:25:23 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702131219220.1757@xanadu.home>
References: <45CFA30C.6030202@verizon.net>
 <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 18:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH1PY-0006NZ-TD
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 18:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbXBMRZk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 12:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbXBMRZk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 12:25:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17465 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbXBMRZj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 12:25:39 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDE00LWZWEBF2R0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 13 Feb 2007 12:25:23 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39549>

On Tue, 13 Feb 2007, Linus Torvalds wrote:

> The *ONLY* case where we may not be able to do things automatically is 
> actually a much more subtle one: "git cat-file". If we just get a SHA1, we 
> don't know what the path to look it up was like, and thus we can never 
> know whether it's a binary or a text object. With "-p" we can trivially 
> guess, of course, but "git cat-file blob" simply must not do that!

git-cat-file, and its counter part git-hash-object, are fairly low level 
plumbing.  Anyone using them should be aware of the issue and apply the 
needed conversion.  And actually, since we're going to have the 
conversion routines in the core, we'd only need to add a --crlf argument 
to both of them to optionally perform the conversion since the user of 
those commands is more likely to know if the conversion is needed.


Nicolas

From: Nicolas Pitre <nico@cam.org>
Subject: Re: Achieving efficient storage of weirdly structured repos
Date: Sun, 06 Apr 2008 20:13:10 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0804062000240.2947@xanadu.home>
References: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com>
 <alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org>
 <1207351858.13123.52.camel@work.sfbay.sun.com>
 <alpine.LFD.1.00.0804041634180.14670@woody.linux-foundation.org>
 <4A31E284-E7F1-4748-A2CB-D8682748D3D6@sun.com>
 <alpine.LFD.1.00.0804051729230.11277@woody.linux-foundation.org>
 <20080406161003.GA24358@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Roman Shaposhnik <rvs@sun.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 07 02:13:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jiezk-0006EE-5o
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 02:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961AbYDGANM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 20:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755205AbYDGANM
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 20:13:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47234 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961AbYDGANL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 20:13:11 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JYX001GMHXY2T40@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 06 Apr 2008 20:13:10 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080406161003.GA24358@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78942>

On Sun, 6 Apr 2008, Jeff King wrote:

> My thought was something like:
> 
>   - add a new object type, multiblob; a multiblob contains zero or more
>     "child" sha1s, each of which is another multiblob or a blob. The
>     data in the multiblob is an in-order concatenation of its children.
> 
>   - you would create multiblobs with a "smart" git-add that understands
>     the filetype and splits the file accordingly (in my case, probably a
>     chunk of headers and EXIF data, and then a chunk with the image
>     data).

Well, in your example, the large image part should already be common to 
many objects due to deltas if they're really the same: different objects 
will only have different EXIF data plus a delta reference to the same 
base image object. So in a way the split is already there.  Needs only 
that some applications exploit this information at runtime.


Nicolas

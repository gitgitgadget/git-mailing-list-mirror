From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 08/13] prevent try_delta from using objects not in pack
Date: Thu, 05 Apr 2007 23:27:14 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704052320560.28181@xanadu.home>
References: <56b7f5510704051535ya98e86eu7f786f118c4fe229@mail.gmail.com>
 <alpine.LFD.0.98.0704052100420.28181@xanadu.home>
 <56b7f5510704051928l5d1f5a02yccc8e57c222e5f64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 05:27:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZf6c-0005bk-RR
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 05:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767438AbXDFD1Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 23:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767521AbXDFD1Q
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 23:27:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61946 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767438AbXDFD1P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 23:27:15 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG200J5X49E63C0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Apr 2007 23:27:15 -0400 (EDT)
In-reply-to: <56b7f5510704051928l5d1f5a02yccc8e57c222e5f64@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43898>

On Thu, 5 Apr 2007, Dana How wrote:

> On 4/5/07, Nicolas Pitre <nico@cam.org> wrote:
> > What is the purpose of this patch?
> > 
> > The try_delta() function is called with all objects before any object is
> > written to a pack to find out how to deltify objects upfront.
> 
> I set no_write for 2 different reasons in the patchset.
> (1) When the blob is too big (--blob-limit) and will never be written.
> (2) When the blob has been written to a previous, finished pack.
> 
> You're correct that this patch will never see condition (2).

Given that I proposed another way for big blobs in my previous email, 
then (1) should not be needed either.

> I think my repository statistics are a little unusual.
> Perhaps I'm getting ahead of myself here,
> but I also wanted to experiment with writing all blobs to one set
> of packs,  and all trees, commits, and tags to another set
> (but probably just one small pack).
> I would use no_write for that and it would matter here.

Again you should simply _not_ add objects you don't want to the list 
instead of adding them and marking them as unwanted.


Nicolas

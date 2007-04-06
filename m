From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 09/13] drop objects larger than --blob-limit if specified
Date: Fri, 06 Apr 2007 15:21:24 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704061511390.28181@xanadu.home>
References: <56b7f5510704051536s7de9638fs8cd811d580f6a7dc@mail.gmail.com>
 <alpine.LFD.0.98.0704052103410.28181@xanadu.home>
 <56b7f5510704051919v7daac590m6ac52c4fcabd5321@mail.gmail.com>
 <alpine.LFD.0.98.0704052257200.28181@xanadu.home>
 <Pine.LNX.4.64.0704060845120.6730@woody.linux-foundation.org>
 <56b7f5510704061109n2878a221p391b7c3edba89c63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 22:01:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZu02-0003kH-FC
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 21:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbXDFTV1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 15:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbXDFTV0
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 15:21:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30775 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbXDFTVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 15:21:25 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG300IYNCFOIJ90@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 06 Apr 2007 15:21:25 -0400 (EDT)
In-reply-to: <56b7f5510704061109n2878a221p391b7c3edba89c63@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43916>

On Fri, 6 Apr 2007, Dana How wrote:

> * To avoid offsets larger than 31 bits in .idx files.  Your proposal,
>  and what I was doing for --pack-limit && --stdout, is sufficient to
> address this.

BTW I have code for an index version 2 that allows for 64-bit offsets.  
It also adds a CRC32 for each object data as stored in the pack to make 
data reuse safer when repacking.  I only have to fix a couple loose ends 
before sending patches out.

The new index only uses 64-bit offsets when it has to.  Meaning that 
objects in front of a pack which usually are the most recent ones won't 
pay the overhead of a larger offset table at run time.


Nicolas

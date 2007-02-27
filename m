From: Troy Telford <ttelford.groups@gmail.com>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Mon, 26 Feb 2007 18:16:19 -0700
Message-ID: <200702261816.20258.ttelford.groups@gmail.com>
References: <200702261540.27080.ttelford.groups@gmail.com> <20070226235510.GF1639@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 02:16:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLqxb-0002hv-GU
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 02:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbXB0BQx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 20:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbXB0BQx
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 20:16:53 -0500
Received: from zoot.lnxi.com ([63.145.151.20]:41407 "EHLO zoot.lnxi.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbXB0BQw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 20:16:52 -0500
Received: from rygel.lnxi.com ([::ffff:192.168.40.106])
	by zoot.lnxi.com with ESMTP (TLS encrypted); Mon, 26 Feb 2007 18:16:22 -0700
User-Agent: KMail/1.9.6
In-Reply-To: <20070226235510.GF1639@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40687>

On Monday 26 February 2007, Shawn O. Pearce wrote:

> Nico and I are neck deep in our pack version 4 topic.  That topic
> hits all of the same code you touched with your patch.

It looked like that may have been the case; but I figured it wouldn't hurt.  
I've been coping with the 'too-small' index issue for about a year now, and 
have been on IRC and kept at least a lazy eye on it hoping that it would be 
attended to.

I've decided I need to start doing some C coding again, and it seemed to be as 
good an itch as any to scratch...

> Our topic also requires us to change the index file format, and
> in doing so we have decided to extend the index records to look
> something like the following[*1*]:
>
> 	object SHA-1
> 	64-bit offset within packfile
> 	32-bit index of next object in packfile
>
> The latter field is to help pack-objects reuse existing packfile
> data, as today it needs to sort everything on its own on the fly.
> Having that last field of data will help avoid that, and will keep
> the index nicely aligned for 64-bit accesses to the offset.

Exactly why I left the packfile itself alone.  Well, that and laziness.  I may 
have a huge repository, but I don't have single files so large that it needs 
a 32-bit index for the next object in the packfile.

Most of the things that large I've seen are binary anyway.

> I want to say your patch shouldn't be merged without even bothering
> to review it.  

No hard feelings on my part, it was as much a learning thing for me as 
anything else.

> The last time I was in this part of the git code 
> (implementing sliding mmap window) Nico and Junio also both went in
> here and rewrote huge chunks.  Their changes prevented sliding mmap
> window from applying.  It was 6 months before I got back around to
> rewriting the patch.

Ouch.

> Right now I'm neck deep in pack v4.  I hope to have the topic in
> pu-ready state by some time mid-next week, hopefully in time for
> Junio's git day.  I'm very unlikely to have the time to rewrite the
> topic again until late June/July if something like your patch goes
> in now.
>
> So would you mind waiting a couple of weeks for 64 bit indexes?

All I'm concerned with is being able to handle my (huge) source repository 
with git.  I wrote the patch in the hopes that it would accelerate the 
process, and that I'd learn something.  If all I have to do is wait that's 
fine.  I figured I'd at least be able to bring an idea or two to the table.  
If the code doesn't get accepted, but still get the desired functionality, I 
still met 1/2 of my goals in doing it.
-- 
Troy Telford

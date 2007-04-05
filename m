From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] git-{repack,pack-objects} accept --{pack,blob}-limit to control pack size
Date: Thu, 05 Apr 2007 23:17:58 +0200
Message-ID: <87r6qy7c6x.fsf@mid.deneb.enyo.de>
References: <56b7f5510704041340l5997b04dp853e8270a644ab28@mail.gmail.com>
	<alpine.LFD.0.98.0704041750030.28181@xanadu.home>
	<56b7f5510704041555q4e735961ra9ee8008be0d33db@mail.gmail.com>
	<20070405065433.GD5436@spearce.org>
	<Pine.LNX.4.64.0704050831520.6730@woody.linux-foundation.org>
	<20070405155306.GI5436@spearce.org>
	<Pine.LNX.4.64.0704050910590.6730@woody.linux-foundation.org>
	<20070405171432.GK5436@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 23:18:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZZLZ-0000U9-Ku
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 23:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767165AbXDEVSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 17:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767173AbXDEVSD
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 17:18:03 -0400
Received: from mail.enyo.de ([212.9.189.167]:2103 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767165AbXDEVSB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 17:18:01 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1HZZLD-0002PS-LO
	for git@vger.kernel.org; Thu, 05 Apr 2007 23:17:59 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.63)
	(envelope-from <fw@deneb.enyo.de>)
	id 1HZZLC-0005C8-8V
	for git@vger.kernel.org; Thu, 05 Apr 2007 23:17:58 +0200
In-Reply-To: <20070405171432.GK5436@spearce.org> (Shawn O. Pearce's message of
	"Thu, 5 Apr 2007 13:14:32 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43856>

* Shawn O. Pearce:

> So we'd probably have to do something like:
>
> 	#ifndef _LFS_LARGEFILE
> 	#define open64 open
> 	#define lseek64 lseek
> 	#endif
>
> and then start using the open64/lseek64 variants instead.  Or do
> the reverse #define's.  ;-)

This is actually what "#define _FILE_OFFSET_BITS 64" does.  It's
usually not a bad idea per se, but you must not use off_t in library
header files if you do this.

lseek64 and friends are under -D_LARGEFILE64_SOURCE, it seems.  Pitty
we couldn't get rid of this mess when switching to libc6. 8-(

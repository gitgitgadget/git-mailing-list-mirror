X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Teach receive-pack how to keep pack files based on
 object count.
Date: Tue, 31 Oct 2006 14:56:50 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0610311447250.11384@xanadu.home>
References: <20061031075704.GB7691@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 31 Oct 2006 19:57:59 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061031075704.GB7691@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30594>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GezjD-0003wd-Cc for gcvg-git@gmane.org; Tue, 31 Oct
 2006 20:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1945928AbWJaT4w (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 14:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945929AbWJaT4w
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 14:56:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11483 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1945928AbWJaT4v
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 14:56:51 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J800020ZNEQW9C1@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Tue,
 31 Oct 2006 14:56:50 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Tue, 31 Oct 2006, Shawn Pearce wrote:

> Since keeping a pushed pack or exploding it into loose objects
> should be a local repository decision this teaches receive-pack
> to decide if it should call unpack-objects or index-pack --stdin
> --fix-thin based on the setting of receive.unpackLimit and the
> number of objects contained in the received pack.

This works fine when used with my replacement patch for your [1/2] one.

> Currently this leaves every received pack as a kept pack.  We really
> don't want that as received packs will tend to be small.  Instead we
> want to delete the .keep file automatically after all refs have
> been updated.  That is being left as room for future improvement.

I think this should be solved before rx packs are actually stored as 
packs though.  Otherwise people will end up with unwanted .keep files 
left around.  Maybe having a much bigger default for object number 
treshold for the time being?  (unless this patch is applied to "next" at 
the same time as another one that actually deals with those .keep 
files).



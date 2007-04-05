From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-{repack,pack-objects} accept --{pack,blob}-limit to
 control pack size
Date: Thu, 5 Apr 2007 09:21:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704050910590.6730@woody.linux-foundation.org>
References: <56b7f5510704041340l5997b04dp853e8270a644ab28@mail.gmail.com>
 <alpine.LFD.0.98.0704041750030.28181@xanadu.home>
 <56b7f5510704041555q4e735961ra9ee8008be0d33db@mail.gmail.com>
 <20070405065433.GD5436@spearce.org> <Pine.LNX.4.64.0704050831520.6730@woody.linux-foundation.org>
 <20070405155306.GI5436@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dana How <danahow@gmail.com>, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 18:22:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZUj3-0004V6-Qa
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 18:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbXDEQV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 12:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbXDEQVz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 12:21:55 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42820 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134AbXDEQVy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 12:21:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l35GLYPD032664
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 Apr 2007 09:21:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l35GLXje019962;
	Thu, 5 Apr 2007 09:21:34 -0700
In-Reply-To: <20070405155306.GI5436@spearce.org>
X-Spam-Status: No, hits=-2.457 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43841>



On Thu, 5 Apr 2007, Shawn O. Pearce wrote:
> 
> Sure, OK, but that libc function doesn't exist on Mac OS X:

My bad. It's *not* linux-specific like the OSX man-page apparently says, 
it's very traditional. But the right name is "lseek64()" (and offt64_t for 
the size).

Of course, OSX didn't have some of the backwards-compatibility issues with 
decades ago, so they just made off_t 64-bit by default. Maybe they don't 
even bother to do the trivial portability things to support programs that 
try to be portable..

Anyway, we should use open64(), lseek64() and friends to be as portable as 
possible.. And if some system doesn't have them, just use the normal ops, 
and pray that they are already 64-bit safe..


		Linus

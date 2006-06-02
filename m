From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] sha1_file: avoid re-preparing duplicate packs
Date: Fri, 2 Jun 2006 10:47:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606021045580.5498@g5.osdl.org>
References: <20060602153223.GA4223@coredump.intra.peff.net>
 <7vwtbzblkf.fsf@assigned-by-dhcp.cox.net> <20060602160456.GA8957@coredump.intra.peff.net>
 <7vk67zbksv.fsf@assigned-by-dhcp.cox.net> <20060602164932.GA10216@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 19:47:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmDjy-0005EX-IK
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 19:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWFBRrP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 13:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWFBRrP
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 13:47:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932072AbWFBRrO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jun 2006 13:47:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k52Hl82g002195
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Jun 2006 10:47:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k52Hl7Ev015756;
	Fri, 2 Jun 2006 10:47:08 -0700
To: Jeff King <peff@peff.net>
In-Reply-To: <20060602164932.GA10216@coredump.intra.peff.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21172>



On Fri, 2 Jun 2006, Jeff King wrote:
> 
> This patch avoids duplicates in the packed_git list. It's not necessary
> under Linux, at least, but it just seems cleaner, and it's simple to do.

I think it's a good idea even under Linux, since on 32-bit machines, one 
of the constraints we have may simply be virtual memory space to map 
things into. With big packs, avoiding mapping them twice is a good idea.

		Linus

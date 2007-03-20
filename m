From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Mon, 19 Mar 2007 21:45:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703192132540.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172200060.18328@xanadu.home>
 <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org>
 <7v8xdunavr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703200400230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070320032947.GA29145@spearce.org> <20070320034020.GB29145@spearce.org>
 <Pine.LNX.4.64.0703192052380.6730@woody.linux-foundation.org>
 <20070320041843.GA29288@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 05:46:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTWEn-0002xl-1Y
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 05:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbXCTEqB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 00:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933988AbXCTEqA
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 00:46:00 -0400
Received: from smtp.osdl.org ([65.172.181.24]:46103 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933987AbXCTEqA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 00:46:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2K4jdcD022671
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 21:45:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2K4jc85025903;
	Mon, 19 Mar 2007 20:45:39 -0800
In-Reply-To: <20070320041843.GA29288@spearce.org>
X-Spam-Status: No, hits=-0.977 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42705>



On Tue, 20 Mar 2007, Shawn O. Pearce wrote:
> 
> I tested both patches on a PowerPC G4.  (Apple PowerBook, 1.5 GHz)
> Running on Mac OS X 10.4.8.
> 
> Might be more of a Linux<->Darwin thing; perhaps my isspace is
> significantly slower than yours is...  after all my mmap runs
> like a PC from the 1980s...  ;-)

No, we do a git-specific isspace().

But yeah, a G4 will explain the thing even more than a P4 would. The G4 
really isn't a very good uarch compared to the modern x86 ones. Not 
aggressively out-of-order with deep instruction queues and I don't think 
it does basically any memop re-ordering at all. I know Apple used to claim 
that they were the fastest PC around (both with the G4 and the G5), but 
let's face it, they lied.

The closer to in-order you are, the more instruction scheduling in sw 
tends to matter.

		Linus

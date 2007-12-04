From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make Git accept absolute path names for files within
 the work tree
Date: Tue, 4 Dec 2007 07:59:43 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712040756370.2981@woody.linux-foundation.org>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com> <20071204014326.GA21358@coredump.intra.peff.net> <Pine.LNX.4.64.0712040216220.27959@racer.site> <200712040742.24728.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.64.0712041149440.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 04 17:02:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzaDL-0006pm-EA
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 17:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250AbXLDQAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 11:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755246AbXLDQAx
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 11:00:53 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46283 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755220AbXLDQAv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Dec 2007 11:00:51 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB4Fxinm015016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Dec 2007 07:59:45 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB4FxhW9025199;
	Tue, 4 Dec 2007 07:59:43 -0800
In-Reply-To: <Pine.LNX.4.64.0712041149440.27959@racer.site>
X-Spam-Status: No, hits=-4.725 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67061>



On Tue, 4 Dec 2007, Johannes Schindelin wrote:
> 
> I do remember the hassles I went through with get_relative_cwd() until I 
> broke down and used chdir() two times (ugly).

It really is a pretty heavy and complex operation in UNIX in general (and 
open to various races too), which is why I'd generally suggest avoiding it 
if you at all can.

The sad(?) part is, it's fairly trivial to do inside the Linux kernel (but 
probably not in other operating systems - it's only because of our 
superior dcache that we could do it). So a special system call would be no 
problem at all. But obviously very unportable indeed.

			Linus

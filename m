From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pack v4 status
Date: Tue, 27 Feb 2007 13:51:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271348260.12485@woody.linux-foundation.org>
References: <20070227155042.GB3230@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 22:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMAE8-0005JI-HC
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 22:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbXB0VvB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 16:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbXB0VvB
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 16:51:01 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53677 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbXB0VvA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 16:51:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1RLoihB019388
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 13:50:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1RLohYv029724;
	Tue, 27 Feb 2007 13:50:43 -0800
In-Reply-To: <20070227155042.GB3230@spearce.org>
X-Spam-Status: No, hits=-0.436 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40817>



On Tue, 27 Feb 2007, Shawn O. Pearce wrote:
> 
> We have thus far reformatted OBJ_TREEs with a new dictionary based
> compression scheme.  In this scheme we pool the filenames and modes
> that appear within trees into a single table within the packfile.
> All trees are then converted to use a 22 byte record format:
> 
>   - 2 byte network byte order index into the string pool
>   - 20 byte SHA-1

Umm. Am I missing something, or is this totally braindamaged?

Are you really expecting there to never be more than 64k basenames? Trust 
me, that's a totally broken assumption. Anything that tracks generated 
stuff will _easily_ have several tens of thousands of random filenames 
even in a single tree, much less over the whole history of the repository.

			Linus

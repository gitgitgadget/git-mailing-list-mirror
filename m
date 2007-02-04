From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge doesn't remove files
Date: Sun, 4 Feb 2007 02:40:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702040234290.8424@woody.linux-foundation.org>
References: <20070203224819.20131.qmail@b1b53206edee41.315fe32.mid.smarden.org>
 <7vy7nezr1f.fsf@assigned-by-dhcp.cox.net> <7vd54qzoka.fsf@assigned-by-dhcp.cox.net>
 <20070204045933.GC16766@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Gerrit Pape <pape@smarden.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 11:40:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDenp-0002Bw-0N
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 11:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbXBDKk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 05:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbXBDKkz
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 05:40:55 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36218 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266AbXBDKky (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 05:40:54 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l14AedQ5001370
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 4 Feb 2007 02:40:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l14AecIk027443;
	Sun, 4 Feb 2007 02:40:38 -0800
In-Reply-To: <20070204045933.GC16766@spearce.org>
X-Spam-Status: No, hits=-0.389 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.173 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38683>



On Sat, 3 Feb 2007, Shawn O. Pearce wrote:
> 
> But that tree-ish doesn't have to be the first non-base
> argument to merge-recursive, does it?  In practice it usually is,
> but can I assume it in the code?

Yes, the first branch is supposed to be the "current" one. That's the one 
we compare to the index, and that we should already error out on if the 
index doesn't match the tree. So yeah, a file should ever be removed only 
if it existed in the old index (and by implication in the first branch, 
since otherwise we should have failed the merge as not having a clean 
tree anyway).

		Linus

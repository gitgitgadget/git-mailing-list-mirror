From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix object re-hashing
Date: Sun, 12 Feb 2006 16:16:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602121614340.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602120956130.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602121006360.3691@g5.osdl.org> <7vaccwbf6v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602121037460.3691@g5.osdl.org> <Pine.LNX.4.64.0602121101040.3691@g5.osdl.org>
 <Pine.LNX.4.63.0602130007320.9507@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 01:16:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8ROT-0005Dx-St
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 01:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWBMAQj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 19:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWBMAQj
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 19:16:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751059AbWBMAQi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 19:16:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1D0GPDZ030605
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Feb 2006 16:16:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1D0GIl0026017;
	Sun, 12 Feb 2006 16:16:22 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602130007320.9507@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16030>



On Mon, 13 Feb 2006, Johannes Schindelin wrote:
> 
> Make hashtable resizing more robust AKA do not resize in-place

You forgot to release the old array afterwards.

Anyway, I think the in-place version is fine now, even if it has a few 
subtleties. So this isn't needed, but keep it in mind if we find another 
bug, or if somebody wants to shrink the hash table less aggressively than 
with doubling it every time.

		Linus

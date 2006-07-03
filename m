From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Compression speed for large files
Date: Mon, 3 Jul 2006 09:31:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607030929490.12404@g5.osdl.org>
References: <loom.20060703T124601-969@post.gmane.org>
 <81b0412b0607030503p63b4ee31v7776bd155d3dab29@mail.gmail.com>
 <44A91C7A.6090902@fys.uio.no> <Pine.LNX.4.64.0607031030150.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Joachim Berdal Haga <cjhaga@student.matnat.uio.no>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 18:32:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxRLQ-0005GU-5t
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 18:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWGCQcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 12:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWGCQcO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 12:32:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751124AbWGCQcM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 12:32:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k63GVunW014092
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Jul 2006 09:31:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k63GVtEj024358;
	Mon, 3 Jul 2006 09:31:56 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0607031030150.1213@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23189>



On Mon, 3 Jul 2006, Nicolas Pitre wrote:

> On Mon, 3 Jul 2006, Joachim Berdal Haga wrote:
> > 
> > I can send a patch later. If it's to be a per-repo option, it's probably too
> > confusing with several values. Is it ok with
> > 
> > core.compression = [-1..9]
> > 
> > where the numbers are the zlib/gzip constants,
> >   -1 = zlib default (currently 6)
> >    0 = no compression
> > 1..9 = various speed/size tradeoffs (9 is git default)
> 
> I think this makes a lot of sense, although IMHO I'd simply use 
> Z_DEFAULT_COMPRESSION everywhere and be done with it without extra 
> complexity which aren't worth the size difference.

I think Z_DEFAULT_COMPRESSION is fine too - we've long since started 
relying on pack-files and the delta compression for the _real_ size 
improvements, and as such, the zlib compression is less important.

That said, the "core.compression" thing sounds good to me, and gives 
people the ability to tune things for their loads.

		Linus

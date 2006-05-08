From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sun, 7 May 2006 19:04:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605071853290.3718@g5.osdl.org>
References: <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org> <e3fqb9$hed$1@sea.gmane.org>
 <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org>
 <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com>
 <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net> <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com>
 <20060507075631.GA24423@coredump.intra.peff.net> <20060508003338.GB17138@thunk.org>
 <Pine.LNX.4.64.0605071744210.3718@g5.osdl.org> <20060508012632.GD17138@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 04:05:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcv7V-0002aq-6o
	for gcvg-git@gmane.org; Mon, 08 May 2006 04:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWEHCE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 22:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWEHCE6
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 22:04:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932252AbWEHCE6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 22:04:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4824ntH025597
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 May 2006 19:04:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4824mq8031727;
	Sun, 7 May 2006 19:04:49 -0700
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20060508012632.GD17138@thunk.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19749>



On Sun, 7 May 2006, Theodore Tso wrote:
> 
> I just ran the numbers on filesizes of a kernel tree I had handy,
> which happened to be 2.6.16.11.  With no object files, git files,
> etc. the average loss was 2351 bytes --- not that far away from the
> average of 2048 bytes.

Is that without compression?

git objects are compressed, and common types (trees) tend to be smaller 
than your normal C file.

So git objects tend to be _smaller_ than the regular files. By about 30%. 
In addition, the non-blob git objects themselves tend to be smaller still.

So for example, right now I have just 58 unpacked objects (I repack pretty 
often). But of those 58 objects, exactly _fifty_ are smaller than 2kB, and 
38 are smaller than 1kB. The median size is 771 bytes.

On master.kernel.org, I've not repacked as recently, so I've got 2268 
unpacked objects. But the median size there is 773 bytes, so it looks like 
the numbers are statistically pretty stable.

			Linus

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git push over http is very dangerous
Date: Mon, 16 Apr 2007 12:38:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704161212140.5473@woody.linux-foundation.org>
References: <462394AC.303@beronet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Christian <crich-ml@beronet.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 21:38:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdX24-0005gl-Mq
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 21:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030909AbXDPTia (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 15:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030915AbXDPTia
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 15:38:30 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47132 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030909AbXDPTi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 15:38:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3GJcPIs000727
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 12:38:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3GJcOfr010229;
	Mon, 16 Apr 2007 12:38:24 -0700
In-Reply-To: <462394AC.303@beronet.com>
X-Spam-Status: No, hits=-0.449 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44689>



On Mon, 16 Apr 2007, Christian wrote:
>
> We have moved from CVS to git in the beginning of last week, all went well
> until this weekend. This weekend one developer wanted to push some of his
> local modifications, unfortunately during the push his http connection seemed
> to have broken or so. Unfortunately git does not prove if the push went well.
> Therefore our repository was broken this morning.

I have to agree: pushing over http really is dangerous. It's not 
*supposed* to be (it tries to update the refs only after it has uploaded 
all objects), but it fundamentally cannot do all the validity tests that 
the "real" git transfer processes do on the receiving side.

And I think git-http-push is pretty fundamentally broken anyway. It 
doesn't really seem to check for errors. So it doesn't do some of the 
checks it *could* do.

I would strongly suggest against http pushing (I'd suggest against pulling 
too, but at least you can't screw up too badly by just reading ;)

I'd also love it if somebody were to actually look into making 
http-pushing a bit safer. It really needs somebody who cares about it, or 
it should likely just be disabled entirely (perhaps with a config option 
that you have to enable to get it - so that people *realize* that it's not 
maintained and not really supported).

		Linus

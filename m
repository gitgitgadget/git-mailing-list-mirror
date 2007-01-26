From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Seriously broken "git pack-refs"
Date: Thu, 25 Jan 2007 22:05:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701252202130.25027@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0701251636060.25027@woody.linux-foundation.org>
 <7v7iva4glo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 07:06:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAKDp-0000x3-KX
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 07:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbXAZGFl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 01:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbXAZGFk
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 01:05:40 -0500
Received: from smtp.osdl.org ([65.172.181.24]:47397 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723AbXAZGFW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 01:05:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0Q65JgP023614
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 25 Jan 2007 22:05:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0Q65IHL008942;
	Thu, 25 Jan 2007 22:05:19 -0800
In-Reply-To: <7v7iva4glo.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.588 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37802>



On Thu, 25 Jan 2007, Junio C Hamano wrote:
> 
> But I think "only packing tags" is a reasonable default

Sure, I agree. I just think that it had the unintended side effect when 
the code then didn't repack stuff that had already been packed earlier.

Which is why my fix doesn't actually change the fact that we only pack 
tags by default, but just fixes the thing that caused us to then totally 
drop previously packed non-tags.

So now the default isn't really "pack only tags", but "pack only tags *or* 
things that were already packed".

The reason, of course, is that if we don't pack stuff that used to be 
packed, it will just be dropped entirely. Oops.

		Linus

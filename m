From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Teach applymbox to keep the Subject: line.
Date: Wed, 17 Aug 2005 12:56:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508171253190.3553@g5.osdl.org>
References: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com>
 <7vek8t7bva.fsf@assigned-by-dhcp.cox.net> <7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net>
 <430375B3.3050307@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 22:03:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5U6i-0002Vu-Nw
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 22:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVHQUBs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 16:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVHQUBr
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 16:01:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41168 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751231AbVHQUBr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 16:01:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7HJupjA030046
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 Aug 2005 12:56:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7HJuoVa006317;
	Wed, 17 Aug 2005 12:56:51 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <430375B3.3050307@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 17 Aug 2005, Jeff Garzik wrote:
> 
> 1) Fix applymbox such that it understands RFC822-valid Subject lines 
> which wrap across multiple text lines.

It already should do this.

> 2) Teach it to understand MIME, and not treat the MIME headers like part 
> of the message.

But this one I really realyl disagree with.

The fact is, anybody who doesn't edit the emails that come in is BROKEN. 
There are two kinds of emails:

 - the nicely formatted ones where the author follows all the rules

   This kind of email doesn't need MIME decoding anyway.

 - the others

   This kind might need MIME decoding, but since it _also_ needs 
   hand-editing to remove all the "Hi, please apply this patch" etc crud
   that inevitably go along with this kind of patch, trying to handle it 
   automatically is WRONG WRONG WRONG.

   And if it's mime-encoded you often have trouble editing it anyway.

Ergo: if somebody sends you mime-encoded patches, hit them with a baseball 
bat (politely) and teach them not to do that. "Fixing" the tools really 
will just make things worse if it means that you apply raw emails without 
having edited them.

		Linus

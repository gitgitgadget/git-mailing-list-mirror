From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 8/8] gitweb: Remove --parents from call to git-rev-list
 in parse_rev_list
Date: Wed, 6 Sep 2006 14:08:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609061404490.27779@g5.osdl.org>
References: <11575480921132-git-send-email-jnareb@gmail.com>
 <11575761821830-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 23:08:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL4dH-0006QL-JZ
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 23:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWIFVIY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 17:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWIFVIY
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 17:08:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36827 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932080AbWIFVIW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 17:08:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k86L8KnW024627
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Sep 2006 14:08:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k86L8Ich025132;
	Wed, 6 Sep 2006 14:08:19 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <11575761821830-git-send-email-jnareb@gmail.com>
X-Spam-Status: No, hits=-1.007 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26560>



On Wed, 6 Sep 2006, Jakub Narebski wrote:
>
> Benchmarks (7 means patch before, 8 means this patch):

Btw, you should possibly look at cold-cache numbers, and numbers for 
projects that aren't fully packed. They can often be _dramatically_ 
different.

That said, the dramatic change would probably be if there were some way to 
avoid using "--full-history" (rather than "--parents", which doesn't add 
_that_ much overhead), since that "follow all parents" behaviour of 
full-history is usually what really makes a big deal.

But I guess for gitweb, you do want to use --full-history in this case ;(

			Linus

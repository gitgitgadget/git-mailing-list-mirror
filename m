From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-pull-script hates me
Date: Wed, 6 Jul 2005 14:36:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507061434010.3847@g5.osdl.org>
References: <20050706203139.GA19198@kroah.com> <Pine.LNX.4.58.0507061335100.4159@g5.osdl.org>
 <7v64vnwrwg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 23:40:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqHcw-0000Nh-B9
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 23:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVGFVjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 17:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVGFViy
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 17:38:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262537AbVGFVg5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 17:36:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j66LakjA001840
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Jul 2005 14:36:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j66LaiVi025324;
	Wed, 6 Jul 2005 14:36:44 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64vnwrwg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 6 Jul 2005, Junio C Hamano wrote:
> 
> Anybody who is interested in doing this can just move
> sq_expand() from diff.c to some public library and expose it in
> cache.h.

No, that doesn't work at all.

"sq_expand()" tries to protect things inside single quotes. That's a 
totally different problem (and btw, it does so badly: it doesn't quote '\' 
for example).

For a shell command line, there are _tons_ of special characters that you
mustn't pass through. Things like ';', '<', '>', '&' all have magic
meaning and are not valid in the destination name. Not to mention just
simple whitespace.

		Linus

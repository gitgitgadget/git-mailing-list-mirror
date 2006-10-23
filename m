From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] xdiff/xemit.c (xdl_find_func): Elide trailing white
 space in a context header.
Date: Mon, 23 Oct 2006 13:49:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610231347490.3962@g5.osdl.org>
References: <87y7r63hq6.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 22:50:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc6ka-0003V7-El
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 22:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWJWUuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 16:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWJWUuU
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 16:50:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22230 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751401AbWJWUuT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 16:50:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9NKndaX005962
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 13:49:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9NKnbVc005648;
	Mon, 23 Oct 2006 13:49:38 -0700
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <87y7r63hq6.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-2.477 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29877>



On Mon, 23 Oct 2006, Jim Meyering wrote:
>
> This removes trailing blanks from git-generated diff headers
> the same way a similar patch did that for GNU diff:

NO!

This is _wrong_

You should only remove the space IF IT IS THE ONLY THING ON THE WHOLE 
LINE!

You must not remove white-space in general.

So the patch should check something like

	if (len == 1 && rec[0] == ' ')
		len = 0;

and not like you did it.

Otherwise the patch will simply not even _apply_.

		Linus

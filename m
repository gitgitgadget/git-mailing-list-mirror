From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch
 directly
Date: Wed, 1 Mar 2006 13:28:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603011325120.22647@g5.osdl.org>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
 <200603011906.33433.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0603011023080.22647@g5.osdl.org>
 <200603012126.30797.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 22:29:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEYsA-0005cD-Uj
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 22:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbWCAV2g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 16:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWCAV2g
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 16:28:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57565 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751924AbWCAV2f (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 16:28:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k21LSRDZ028167
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Mar 2006 13:28:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k21LSPU7020527;
	Wed, 1 Mar 2006 13:28:26 -0800
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200603012126.30797.Josef.Weidendorfer@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17016>



On Wed, 1 Mar 2006, Josef Weidendorfer wrote:
> 
> So the get_sha1() magic should map "origin" to "remote/origin/master" (or instead
> hardcoded master the remote branch from the first "Pull:" line) ?

Right.

> The ambiguity here would be that shortcut names of remote repositories should not be
> used as tag or head names...

Well, it's not so much an ambiguity, since we'd always try tags and heads 
first. So it's just a fallback, the same way the short SHA1 hash is a 
fallback.

> I think a big plus of this would be that gitk can show branches tracking remote ones
> with another color.

Yes. And with a meaningful name.

> To be able to say "git log origin.." you need the above magic, too.

It would all come automagically from just extending get_sha1().

(Actually, technically you'd put it at the end of "get_sha1_basic()")

		Linus

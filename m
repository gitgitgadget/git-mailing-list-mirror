From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix silly typo in new builtin grep
Date: Mon, 15 May 2006 18:07:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605151801100.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605151743360.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue May 16 03:07:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffo1o-0007yo-Im
	for gcvg-git@gmane.org; Tue, 16 May 2006 03:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWEPBHI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 21:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWEPBHI
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 21:07:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750928AbWEPBHH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 21:07:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4G172tH004611
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 May 2006 18:07:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4G172r8023672;
	Mon, 15 May 2006 18:07:02 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605151743360.3866@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20091>



On Mon, 15 May 2006, Linus Torvalds wrote:
> 
> Me likee the new built-in grep. The ability to say
> 
> 	git grep __make_request v2.6.13 -- '*.c'
> 
> to grep for it in a specific version is well worth the fact that it 
> obviously ends up being slower than grepping in the currently checked-out 
> tree. It's doing a hell of a lot more, but despite that it's not at all 
> that slow.

Side note: it looks like the version generation really isn't much of a 
cost. Grepping in v2.6.13 isn't really noticeably slower than the 
"pre-external grep" was for grepping in the checked-out file tree.

So it looks like we _could_ improve the grepping of specific versions 
noticeably if we were to have a better regex library that was as optimized 
as what the external GNU grep seems to do. The actual revision data 
generation doesn't seem to be the biggest cost, and at least in _theory_ 
we could probably speed things up by a factor of two with a faster regex 
library.

That's good to keep in mind. It may be that the glibc regexp is just not 
very good, but quite frankly, I would personally not be surprised if it's 
better than most (ie windows, for example).

			Linus

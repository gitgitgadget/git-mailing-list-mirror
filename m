From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git show and gitweb gives different result for kernel
Date: Fri, 6 Oct 2006 12:08:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610061202060.3952@g5.osdl.org>
References: <eg65cl$cvs$1@sea.gmane.org> <20061006183054.GU2871@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 21:09:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVv3w-0003xT-FR
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 21:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422896AbWJFTIm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 15:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422897AbWJFTIm
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 15:08:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22956 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422896AbWJFTIk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 15:08:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k96J8AaX017262
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 Oct 2006 12:08:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k96J85IX008688;
	Fri, 6 Oct 2006 12:08:08 -0700
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20061006183054.GU2871@admingilde.org>
X-Spam-Status: No, hits=-0.468 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28435>



On Fri, 6 Oct 2006, Martin Waitz wrote:
> 
> But perhaps gitweb should use --cc, too.

Both have their uses.

For example, the diff against the first parent is really broken in some 
cases (if a _downstream_ developer synchronizes up with the upstream, the 
diff ends up being potentially absolutely huge, and most of the time it's 
exactly the wrogn diff to show), but in other cases it's a really 
wonderful diff.

So for the kernel, the current gitweb behaviour tends to be exactly what 
you want if it's a merge that I did, especially if it was a smallish 
merge. 

In contrast, the default for "git show" (--cc) always shows something that 
makes sense, but it's not necessarily going to always be _useful_. It just 
shows the conflicting parts, which is something that is sensible 
regardless of which way the merge went, but it obviously doesn't really 
say anything about what the real _changes_ were.

So gitweb often shows what people want it to show, but then at other times 
it shows totally pointless stuff. While --cc always shows something 
"relevant" (and often that's the empty set), but it's relevant only in a 
very specific way: it is about how the merge fixed up data conflicts, and 
that's not necessarily anything most people are even interested in.

I think it might make sense for gitweb to just have the option to show the 
diff against any of the parents _or_ to show the conflicting parts (--cc). 
Simply because different people and different uses will have different 
ideas of what they find useful.

		Linus

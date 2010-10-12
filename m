From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Can I checkout a single file without altering index?
Date: Tue, 12 Oct 2010 12:19:44 +0200
Message-ID: <4CB43640.2010402@drmicha.warpmail.net>
References: <loom.20101012T114900-532@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 12:19:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5bxG-0003De-Cx
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 12:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149Ab0JLKT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 06:19:29 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54969 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757147Ab0JLKT2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 06:19:28 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 53E1357E;
	Tue, 12 Oct 2010 06:19:28 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 12 Oct 2010 06:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=OU0DJ8qvQibWIPuX6kbY4qZCOm0=; b=ZJsGZyED8wQJEHbmYWWNzvIn1l8wREXak6/azc0IXJBJgbwRNO5XrO54N6kpovBqvZQ6+sTx2TU5lnVrrl8262MEw4pGPqc8q9hPbjw82ESP3lyyIwQ5eQ4fJbjUmnOmc1syctondfBdOGvB4cIDCCNqVQuEuEzU7wT5zdnIlM0=
X-Sasl-enc: uc5nL0CuM886g3XV+WKDxrfZ7LTzrqp+MuQhXxGQWBQT 1286878767
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 82A5A404233;
	Tue, 12 Oct 2010 06:19:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <loom.20101012T114900-532@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158829>

Christian Halstrick venit, vidit, dixit 12.10.2010 12:03:
> Can I checkout a certain file to a specific revision without also adding this 
> content to the index? I only want to alter the working-tree - no modification of 
> index or HEAD needed.
> 
> Here is why I need that: I see a bug in git controlled sources. I fix one source
> file and also add one unit test in a separate file. I checked that the test
> succeeds with my fix. The index now contains what I want to commit.
> Now I want to see whether my test fails without my fix. I want to checkout HEAD
> for the source file without destroying my index. In the end, after I saw that my
> test fails without my fix, I just want to say "git commit" without having to.
> 

I would recommend to work on top of a trial commit, i.e.

git commit -m TheFix
git checkout HEAD^ -- fixedfile.c
git reset --hard

and git commit --amend if needed. (Alternatively, use stash.)

You can also use

git show HEAD:fixedfile.c > fixedfile.c
git checkout fixed.file.c
git commit -m TheFix

but I find this more cumbersome.

Michael

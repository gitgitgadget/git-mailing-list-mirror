X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 01:44:33 -0800
Message-ID: <7vodq695ha.fsf@assigned-by-dhcp.cox.net>
References: <200612132200.41420.andyparkins@gmail.com>
	<20061213225627.GC32568@spearce.org>
	<200612140908.36952.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 09:44:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612140908.36952.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 14 Dec 2006 09:08:34 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34294>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gun8n-0000Pg-Mr for gcvg-git@gmane.org; Thu, 14 Dec
 2006 10:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932186AbWLNJof (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 04:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWLNJoe
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 04:44:34 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:39124 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932186AbWLNJoe (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 04:44:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214094433.CJSE25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Thu, 14
 Dec 2006 04:44:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id yZju1V0071kojtg0000000; Thu, 14 Dec 2006
 04:43:55 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2006 December 13 22:56, Shawn Pearce wrote:
>
>>   git cat-file -p $REV:$file
>>
>> not sure how much easier it gets than that.  Load in the bash
>> completion from contrib/completion and you can even tab complete
>> the $file part.
>
> Yes.  I was a little unfair on that one; I forgot about the REV:file syntax.  
> However, it's still not simple for a new user; I think I'd say "draw" if 
> the "-p" weren't a requirement.

I would say pretending as if cat-file is a Porcelain is the
unfair part.

> $ git-ls-tree v1.0.0
> 100644 blob 906e98492080d2fde9467a9970fc92d7a8cfeaf8    Makefile
>
> I'm a newbie:  what's that number at the front?  What's a blob?  What's that 
> great big number - I've only seen commit hashes that look like that, and that 
> isn't one.  Definitely not friendly.

Again, mistaking ls-tree as if it was a Porcelain is the true
cause of the newbie confusion.

> It could probably be fixed by making git-ls-files capable of understanding 
> tree-ish.

I think that's a wrong way to go about.  The primary purpose of
ls-files is to read the index and show information around it;
ls-tree is about reading one tree and show information around
it.  They are both plumbing and meant to be used by scripts when
they want to inspect the index or a tree respectively.

If a Porcelain level "ls" is needed (and I am doubtful about
usefulness of "svn list -r538" like command), that is the
command you would want to teach about using ls-files and ls-tree
depending on what the end users want in their workflow.

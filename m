X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb TODO
Date: Fri, 17 Nov 2006 16:04:05 -0800
Message-ID: <7vveldhb7u.fsf@assigned-by-dhcp.cox.net>
References: <200611171901.40839.jnareb@gmail.com>
	<200611172130.11631.jnareb@gmail.com>
	<7vu00xixxk.fsf@assigned-by-dhcp.cox.net>
	<200611172224.40252.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 00:04:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611172224.40252.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 17 Nov 2006 22:24:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31739>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlDgu-0006XG-Ir for gcvg-git@gmane.org; Sat, 18 Nov
 2006 01:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756059AbWKRAEK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 19:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756062AbWKRAEJ
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 19:04:09 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:20354 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1756059AbWKRAEH
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 19:04:07 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118000406.VAAU97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 19:04:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id o04C1V00a1kojtg0000000; Fri, 17 Nov 2006
 19:04:13 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> ... But for gitweb more important than producing safe patch
> is producing _readable_ patch[*1*]. Hence request for -T option 
> (or under other, better name) to git-diff which would _not_
> split patch (not create two patches for one raw difftree line).
>  
> [*1*] Well, as far as diff for symlink is readable anyway.

Honestly, I do not have strong feeling either way.  As you say,
I suspect diff to change between symlink and regular file is not
readable no matter how you present it, and it is a corner case
that is not very interesting.  It happens in real life but it is
rare enough that split patches or a single patch would not make
much difference either way.

So I would not oppose to a patch to add an option to update
git-diff to produce either format, but I doubt it is worth the
effort required to make sure that the change does not break
anything else and also to make matching adjustment to git-apply,
so that it can understand both formats.

>> I am not sure what you mean by patchset part, but if you are
>> talking about the multiway diff text, I think most of the time
>> output from "-c -p" is much less interesting than "--cc".
>
> Sorry, perhaps I was not clear. I'd like for git-diff-tree --cc
> --raw -p to output both raw part (perhaps taken from -c) and
> patch part...

I can see why somebody might want to do this, to exactly the
same degree that I can see why somebody might want to use the
combination of "--raw -p".

I think this would work in git.git itself:

	git diff-tree --cc --numstat --raw -p v1.0.0

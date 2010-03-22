From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH v3] git checkout: create unparented branch by --orphan
Date: Mon, 22 Mar 2010 07:43:44 -0500
Message-ID: <3F619EAA-288D-4310-B9C6-8121FE00E7B0@pobox.com>
References: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 13:44:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntgzi-0000yO-4s
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 13:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087Ab0CVMo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 08:44:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919Ab0CVMo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 08:44:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ADEA1A424F;
	Mon, 22 Mar 2010 08:44:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=in-reply-to
	:references:mime-version:content-type:message-id:cc
	:content-transfer-encoding:from:subject:date:to; s=sasl; bh=ivNS
	y6z3s5rv98aHFllitI4dtaQ=; b=WYlR9uHKKj8wt/ria/p0PbRaetXJuIVQChbj
	QRQgWB2ydZGE2R/JbWDBs98CGQDVE5c/MJLyQ5/A2uPXwYlL4y4xzfvlg+VbUlof
	7MhlFa+IQCnjLf+6lWrzB0cJ3lMHVhO35L6ZxYbrzZz9oZ4jeiy4g7ik8qAyT+Wy
	tFjkE6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=in-reply-to
	:references:mime-version:content-type:message-id:cc
	:content-transfer-encoding:from:subject:date:to; q=dns; s=sasl; b=
	NGFuKEb3NrwPVYiwanzaTEHpm4BRdLCSXXp/xZ2JroCtH7q7KpQVe8RBLnfdRZe3
	GOrsuPFDIo9/5YGXtQh1lvpGS1zOkSjkMiAc5W2OVJBQYi5ebHZbsd71pBhNFuXC
	E+gs9cYEByYBXImuKbwDyZd+bIC3iBU1BRKwLJ6wqds=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89275A424A;
	Mon, 22 Mar 2010 08:44:23 -0400 (EDT)
Received: from [192.168.1.241] (unknown [75.53.42.110]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F19F9A4248; Mon, 22 Mar
 2010 08:44:20 -0400 (EDT)
In-Reply-To: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com>
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: A487D9BA-35B0-11DF-ADEA-D033EE7EF46B-07245699!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142926>

On 2010 Mar 21, at 10:34, Erick Mattos wrote:
> Similar to -b, --orphan creates a new branch, but it starts without  
> any
> commit.  After running "git checkout --orphan newbranch", you are on a
> new branch "newbranch", and the first commit you create from this  
> state
> will start a new history without any ancestry.
>
> "git checkout --orphan" keeps the index and the working tree files
> intact in order to make it convenient for creating a new history whose
> trees resemble the ones from the original branch.
>
> When creating a branch whose trees have no resemblance to the ones  
> from
> the original branch, it may be easier to start work on the new  
> branch by
> untracking and removing all working tree files that came from the
> original branch, by running a 'git rm -rf .' immediately after running

Maybe use double quotes in the above command to be consistent with  
the rest of inline commands in the commit message.

> "checkout --orphan".
>
> Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
> ---

> diff --git a/Documentation/git-checkout.txt b/Documentation/git- 
> checkout.txt
> index 37c1810..5a50997 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt

> @@ -90,6 +90,25 @@ explicitly give a name with '-b' in such a case.
>  	Create the new branch's reflog; see linkgit:git-branch[1] for
>  	details.
>
> +--orphan::
> +	Create a new branch named <new_branch>, unparented to any other
> +	branch.  The new branch you switch to does not have any commit
> +	and after the first one it will become the root of a new history
> +	completely unconnected from all the other branches.
> ++
> +When you use "--orphan", a new unparented branch is created having  
> the
> +index and the working tree intact.  This allows you to start a new
> +history that records set of paths similar to that of the start-point
> +commit, which is useful when you want to keep different branches for
> +different audiences you are working to like when you have an open  
> source
> +and commercial versions of a software, for example.
> ++
> +If you want to start a disconnected history that records set of paths
> +totally different from the original branch, you may want to first  
> clear
> +the index and the working tree, by running "git rm -rf ." from the
> +top-level of the working tree, before preparing your files (by  
> copying
> +from elsewhere, extracting a tarball, etc.) in the working tree.
> +
>  -m::
>  --merge::
>  	When switching branches,

(American) English is my first language, but that does not imply that  
I speak, read, or write perfectly.

"unparented" sounds a bit awkward to me.

"unconnected from all": the usual constructions are "unconnected to",  
"connected to" or "disconnected from"; might be better as  
"disconnected from all" or "not connected to any"

"unparented" sounds odd to me, especially "unparented to". For  
"unparented branch", I would use "branch without parents", maybe  
"history-free branch".

I think the repeated uses of "unparented" in the first and second  
paragraphs, and its description can be coalesced into the the first  
paragraph, leaving the later paragraphs to describe the "common  
paths" and "no common paths" cases.

The second sentence of the second paragraph seems overly long and  
gets a bit muddled near the end. I can not parse "audiences you are  
working to". Maybe it should be "audiences you are working with" or  
"... for"?

In the third paragraph, "first clear the index and the working tree"  
bit could be taken to mean "clear the index and working tree before  
creating the new branch" (which might work, but leaves a possibly  
confusing state if the user is distracted between "rm -rf" and  
"checkout --orphan" (still on the original branch, the deletion of  
everything has been staged)). Also, use backquotes to properly format  
the example command.

Here is my take on these paragraphs:

-->8---->8--
--orphan::
	Create a new, 'orphan' branch named <new_branch>, and start it
	at <start_point>. The first commit made on this new branch will
	have no parents (it will be the root of a new history that is
	not connected to any the other branches or commits).
+
An orphan branch allows you to start a new history that records a set of
paths similar to <start_point>.
This can be useful when you want to publish the tree from a commit  
without
exposing its full history.
You might want to do this to publish an open source branch of a project
whose current tree is "clean", but whose full history contains  
proprietary
or otherwise encumbered bits of code.
+
If you want to start a disconnected history that records a set of paths
that is totally different from <start_point>, you may want to clear the
index and the working tree after creating the orphan branch.
Run `git rm -rf .` from the top level of the working tree, then prepare
your new files by copying them from elsewhere, extracting a tarball, or
otherwise populating the working tree.
--8<----8<--

-- 
Chris

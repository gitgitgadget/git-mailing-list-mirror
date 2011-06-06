From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Mon, 6 Jun 2011 14:19:32 +0200
Message-ID: <201106061419.34599.jnareb@gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DEC8322.6040200@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 06 14:19:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTYmf-0008Ni-Fw
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 14:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755625Ab1FFMTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 08:19:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62658 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab1FFMTs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 08:19:48 -0400
Received: by bwz15 with SMTP id 15so3240871bwz.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 05:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=VBOpfj0Aa0WBEWalU/fC8uymzRxSlkut/RZZfFnag8U=;
        b=dOB5Fr5Wvr3UfY52mbe1bFEKym/ApQ734MNB2XqX3UMR+0EeJ1PoFAM3ECFEQX9PoU
         8nGoCfaa/VnD/XhvGd+lFmjUClWARWrlWd57KwxeG+byJ+7ysvu24pMqpJLV9i958QHP
         TB5KvguETQlhusLhmctIJq8+FuGWYFoFUxfcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=l+LsKel03pGW7PPJjSmFBGyCANwtUjoKdCC/y0w86x++iiXhFzT/Q4XqA0omPYlgF9
         xVMLtKjWph8UFIDQ6hhZDIcVlK5YYgRI8ixq/1nxWM+PBzW0rzUQHwDen4HBB+xzD7j6
         6FuTQPlXGKjq0G9Sm4uzQe0dKUTbL00V1eqF4=
Received: by 10.204.37.76 with SMTP id w12mr5021028bkd.112.1307362786490;
        Mon, 06 Jun 2011 05:19:46 -0700 (PDT)
Received: from [192.168.1.13] (abwr100.neoplus.adsl.tpnet.pl [83.8.241.100])
        by mx.google.com with ESMTPS id x13sm3306442bkj.5.2011.06.06.05.19.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 05:19:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DEC8322.6040200@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175118>

On Mon, 6 June 2011, Michael J Gruber wrote:
> Junio C Hamano venit, vidit, dixit 06.06.2011 08:16:
>> Scott Chacon <schacon@gmail.com> writes:
>> 
>>> For example, implementation details aside, I think having something
>>> like WTREE and NEXT available would help users understand that there
>>> are these 3 trees that are important and useful in Git and re-inforce
>>> a very non-SVN style workflow in that manner.
>> 
>> That's a funny thing to say. Working tree may almost always (to put it
>> another way, "you could make it to") act like a tree, but the index does
>> not act like a tree at all in more important situations.
>> 
>> For example, how would you design the user experience of "git show NEXT"?
>> Try to write a transcript (i.e. "The user starts from this state, runs
>> these commands, and then says 'git show NEXT'. The user will see this."),
>> covering various corner cases exhaustively, including what would happen
>> before the first commit, and during a conflicted "pull" or "rebase -i".
>> 
>> It's not just the matter of "internally pretend to run write-tree with
>> 'not committed yet' as a fake commit log message and show it as if it is
>> an existing commit.
>> 
>> I wouldn't demand "implement 'git show NEXT'" here, nor "implement it
>> efficiently" here; just designing the user experience is a good first step
>> to realize that the index does not act like a tree, and I do not think you
>> should spread such a misconception to the end users.
> 
> That is why the other Michael suggested "NEXT" as opposed to "INDEX":
> The index has many aspects, only one of which is "the contents of the
> next commit if I would issue 'git commit' right now". (I would even go
> so far as using "STAGE".) Now, it's hard to argue that "the result of a
> commit" is not tree-like, isn't it? And there's no question what "git
> show NEXT" would do. Yes, if you repeat that command, you get a
> different sha1 each time (because of the time field).
> 
> I don't think anyone is seriously suggesting to replace the index by a
> pseudo commit; but the one aspect which people use most could be well
> represented like that, and this might even help emphasizing the
> different aspects of the index. Give the index an identity as an
> "object" (no, no new type, not in the object db, but as a ui object),
> not something mysterious behind the scenes!

So what you suggest would make

  $ git diff NEXT WTREE

behave differently from

  $ git diff

and

  $ git diff HEAD NEXT

behave differently from

  $ git diff --cached

Do you really think that it is good idea?

> As for WTREE: git diff against work tree does not look at non-tracked
> ignored files, so why should WTREE?

So we tailor WTREE do diff behavior?


Well, actually, lets examine each command that takes --cached or --index
and see if NEXT and WTREE would apply at all, and if apply if it would
help.

The following commands support --cached:

  git diff-index      # plumbing
  git diff
  git grep
  git ls-files
  git rm
  git submodule

The following commands support --index

  git checkout-index  # plumbing
  git stash

The following command support both --cached and --index

  git apply

I would skip "git submodule" in this analysis because I don't know enough
about it, and let's skip for the time being purely plumbing commands.
 
Of those, NEXT is not applicable at all and wouldn't help "git rm" and
"git stash", nor "git apply" commands (3/7), isn't it?

In the case of "git grep" using NEXT isn't IMVHO more helpful than using
"--cached".  Note that presence of (slightly misnamed) "--no-index" and
backward compatibility make some problems in interpreting "WTREE" for
"git diff"; natural would for "git grep WTREE" to be current "git grep",
and new "git grep" be "git grep --no-index"... or should it be in reverse,
and "git grep WTREE" to mean "git grep --no-index"?  But then your
interpretation which takes into account only tracked files fails.

In the case of "git ls-files" the "--cached" option is the default;
NEXT could only hinder here IMVHO.

That makes "git grep" and "git ls-files" places where using NEXT is
possible, but doesn't help much. (2/7).


So we are left with "git diff", where we have the following diagram
(perhaps it should made it into "git diff" manpage?):


                worktree
                 |   \    diff
                 |    \   diff NEXT WTREE
                 |     \  [add]
 diff HEAD       |      v 
 diff HEAD WTREE |    index
 [commit -a]     |     /
                 |    /   diff --cached
                 |   /    diff HEAD NEXT  # not NEXT HEAD
                 v  v     [commit]
                 HEAD

Besides, isn't this exercise a bit academic?  New to git wouldn't use
index, and would use 'git commit -a' and 'git diff'... and that would
be enough... well, perhaps except 'git add' + 'git diff'...

> Full disclosure: I love the index but hate the way we make it difficult
> to use sometimes, and even have to lookup myself what command and option
> to actually use if all I want to do is diff A against B, or take the
> version of a file from A and write it to B, when A and B are a commit,
> the index or the worktree (with a commit being the nonwritable, of course).

Note that in case of saving to worktree you can always use

  $ git show HEAD:./foo  >foo
  $ git show :0:./foo    >foo     # or just :./foo
 
> I mean, this is really crazy: We have 4 commands ("add", "rm
> [--cached]", "checkout [<commit>] --", "reset [<commit>] --") which you
> need to be aware of if all you want to do is moving file contents
> (content at a path) between a commit, the index and the worktree! And
> this is actually worse than having 6 for the 6 cases.

-- 
Jakub Narebski
Poland

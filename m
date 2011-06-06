From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Command-line interface thoughts
Date: Mon, 06 Jun 2011 15:20:06 +0200
Message-ID: <4DECD406.2010009@drmicha.warpmail.net>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DEC8322.6040200@drmicha.warpmail.net> <201106061419.34599.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 15:20:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTZj8-0002Uq-5J
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 15:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101Ab1FFNUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 09:20:12 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36670 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755009Ab1FFNUL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 09:20:11 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7098B20973;
	Mon,  6 Jun 2011 09:20:10 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 06 Jun 2011 09:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=G2hG90IG1WHdvTHZRAoXtPKLCAw=; b=QtUeyJpr1Jd6/zae+ScKLhl1MVMiFP/7onoyxN5DazLX0upOtFET50yZBEobKd8Fg15M1AH6gdBsXs+Y4G0+WYheW23gsUosIUyOtsBekVS/dqjUetPPWJsNIl3Ow1oiq4kFo+MJKQc/7soA+k/5wRmJNASglMeaivwierYY3XI=
X-Sasl-enc: iX7BXxMeNSDPRnooema/AFWgFmYQb5K3r4uq++4cepiL 1307366410
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 59D0240516B;
	Mon,  6 Jun 2011 09:20:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <201106061419.34599.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175123>

Jakub Narebski venit, vidit, dixit 06.06.2011 14:19:
> On Mon, 6 June 2011, Michael J Gruber wrote:
>> Junio C Hamano venit, vidit, dixit 06.06.2011 08:16:
>>> Scott Chacon <schacon@gmail.com> writes:
>>>
>>>> For example, implementation details aside, I think having something
>>>> like WTREE and NEXT available would help users understand that there
>>>> are these 3 trees that are important and useful in Git and re-inforce
>>>> a very non-SVN style workflow in that manner.
>>>
>>> That's a funny thing to say. Working tree may almost always (to put it
>>> another way, "you could make it to") act like a tree, but the index does
>>> not act like a tree at all in more important situations.
>>>
>>> For example, how would you design the user experience of "git show NEXT"?
>>> Try to write a transcript (i.e. "The user starts from this state, runs
>>> these commands, and then says 'git show NEXT'. The user will see this."),
>>> covering various corner cases exhaustively, including what would happen
>>> before the first commit, and during a conflicted "pull" or "rebase -i".
>>>
>>> It's not just the matter of "internally pretend to run write-tree with
>>> 'not committed yet' as a fake commit log message and show it as if it is
>>> an existing commit.
>>>
>>> I wouldn't demand "implement 'git show NEXT'" here, nor "implement it
>>> efficiently" here; just designing the user experience is a good first step
>>> to realize that the index does not act like a tree, and I do not think you
>>> should spread such a misconception to the end users.
>>
>> That is why the other Michael suggested "NEXT" as opposed to "INDEX":
>> The index has many aspects, only one of which is "the contents of the
>> next commit if I would issue 'git commit' right now". (I would even go
>> so far as using "STAGE".) Now, it's hard to argue that "the result of a
>> commit" is not tree-like, isn't it? And there's no question what "git
>> show NEXT" would do. Yes, if you repeat that command, you get a
>> different sha1 each time (because of the time field).
>>
>> I don't think anyone is seriously suggesting to replace the index by a
>> pseudo commit; but the one aspect which people use most could be well
>> represented like that, and this might even help emphasizing the
>> different aspects of the index. Give the index an identity as an
>> "object" (no, no new type, not in the object db, but as a ui object),
>> not something mysterious behind the scenes!
> 
> So what you suggest would make
> 
>   $ git diff NEXT WTREE
> 
> behave differently from
> 
>   $ git diff
> 
> and
> 
>   $ git diff HEAD NEXT
> 
> behave differently from
> 
>   $ git diff --cached
> 
> Do you really think that it is good idea?

I don't know where you're getting from that someone is suggesting to
make them different. (And even if, it's new UI, not changed.) Everyone's
been suggesting to make these more accessible.

>> As for WTREE: git diff against work tree does not look at non-tracked
>> ignored files, so why should WTREE?
> 
> So we tailor WTREE do diff behavior?

There is no WTREE and nothing to tailer. We create it so that it is most
useful and consistent, whatever that may be.

...

> Besides, isn't this exercise a bit academic?  New to git wouldn't use
> index, and would use 'git commit -a' and 'git diff'... and that would
> be enough... well, perhaps except 'git add' + 'git diff'...

But we want them to grasp and use the git concepts! That is why some of
us want to make them more accessible.

>> Full disclosure: I love the index but hate the way we make it difficult
>> to use sometimes, and even have to lookup myself what command and option
>> to actually use if all I want to do is diff A against B, or take the
>> version of a file from A and write it to B, when A and B are a commit,
>> the index or the worktree (with a commit being the nonwritable, of course).
> 
> Note that in case of saving to worktree you can always use
> 
>   $ git show HEAD:./foo  >foo
>   $ git show :0:./foo    >foo     # or just :./foo

Exactly, yet another command to add to the list below, and it's not even
all git (because of the shell redirection).

>> I mean, this is really crazy: We have 4 commands ("add", "rm
>> [--cached]", "checkout [<commit>] --", "reset [<commit>] --") which you
>> need to be aware of if all you want to do is moving file contents
>> (content at a path) between a commit, the index and the worktree! And
>> this is actually worse than having 6 for the 6 cases.

Add to this craziness the fact that "checkout -- <path>" reads from
index and writes to worktree, but "checkout <commit> -- path" does not
read from commit and write to worktree - it reads from commit and writes
to index+worktree.

Note that I'm not suggesting to change any of the beloved
reset/checkout/whatever variants.

But the more I look at the commit - index - worktree triangle and the
commands we have the more I realize how messed up the ui is, simply
because it is determined by the underlying mechanics (e.g.: checkout
writes the index to the worktree, possibly after updating the index from
a commit) rather than by the concepts.

And the bad thing is that even when you look at a single command like
reset or checkout, you can get confused easily because of the multiple
different functions they overload (e.g. checkout can change HEAD, the
index and/or the worktree), and also because of some different defaults
(HEAD vs. index). I think we lost consistency here because over time
"useful defaults" grew in the wild.

That is why I'm suggesting concept based variants (move this content
from A to B, show me the difference between A and B).

Michael

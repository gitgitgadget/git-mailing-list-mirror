From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Command-line interface thoughts
Date: Mon, 06 Jun 2011 09:34:58 +0200
Message-ID: <4DEC8322.6040200@drmicha.warpmail.net>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <m339jps1wt.fsf@localhost.localdomain> <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com> <201106051311.00951.jnareb@gmail.com> <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com> <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 09:35:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTULA-0006AP-69
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 09:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720Ab1FFHfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 03:35:07 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56030 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751014Ab1FFHfG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 03:35:06 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1E46A20D32;
	Mon,  6 Jun 2011 03:35:04 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 06 Jun 2011 03:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=/fFiC21cNyITw7cmei5L2YW5npI=; b=Y2+6iKZ9+TLul/5w/lD2UuSUHyI6oe+M+a1gE1yyMoW8rJyXYxSKePnm3/2kj+N3q+oeuiOn0NeIlgytHcztRNTdv06OGXkicuazX+KWGN2k3rS7XCHZn7ydAbZhsCIEG6pcLL2jExGyP3dLVUKVEbPy0jdu8U0E6ZmpTwFj6Zc=
X-Sasl-enc: d0ZXyYCHWRhr9u/MxmtevDTv0b/a4u9ddy3EYsC7cNq4 1307345703
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 099A14402D5;
	Mon,  6 Jun 2011 03:35:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175099>

Junio C Hamano venit, vidit, dixit 06.06.2011 08:16:
> Scott Chacon <schacon@gmail.com> writes:
> 
>> For example, implementation details aside, I think having something
>> like WTREE and NEXT available would help users understand that there
>> are these 3 trees that are important and useful in Git and re-inforce
>> a very non-SVN style workflow in that manner.
> 
> That's a funny thing to say. Working tree may almost always (to put it
> another way, "you could make it to") act like a tree, but the index does
> not act like a tree at all in more important situations.
> 
> For example, how would you design the user experience of "git show NEXT"?
> Try to write a transcript (i.e. "The user starts from this state, runs
> these commands, and then says 'git show NEXT'. The user will see this."),
> covering various corner cases exhaustively, including what would happen
> before the first commit, and during a conflicted "pull" or "rebase -i".
> 
> It's not just the matter of "internally pretend to run write-tree with
> 'not committed yet' as a fake commit log message and show it as if it is
> an existing commit.
> 
> I wouldn't demand "implement 'git show NEXT'" here, nor "implement it
> efficiently" here; just designing the user experience is a good first step
> to realize that the index does not act like a tree, and I do not think you
> should spread such a misconception to the end users.

That is why the other Michael suggested "NEXT" as opposed to "INDEX":
The index has many aspects, only one of which is "the contents of the
next commit if I would issue 'git commit' right now". (I would even go
so far as using "STAGE".) Now, it's hard to argue that "the result of a
commit" is not tree-like, isn't it? And there's no question what "git
show NEXT" would do. Yes, if you repeat that command, you get a
different sha1 each time (because of the time field).

I don't think anyone is seriously suggesting to replace the index by a
pseudo commit; but the one aspect which people use most could be well
represented like that, and this might even help emphasizing the
different aspects of the index. Give the index an identity as an
"object" (no, no new type, not in the object db, but as a ui object),
not something mysterious behind the scenes!

As for WTREE: git diff against work tree does not look at non-tracked
ignored files, so why should WTREE?

Full disclosure: I love the index but hate the way we make it difficult
to use sometimes, and even have to lookup myself what command and option
to actually use if all I want to do is diff A against B, or take the
version of a file from A and write it to B, when A and B are a commit,
the index or the worktree (with a commit being the nonwritable, of course).

I mean, this is really crazy: We have 4 commands ("add", "rm
[--cached]", "checkout [<commit>] --", "reset [<commit>] --") which you
need to be aware of if all you want to do is moving file contents
(content at a path) between a commit, the index and the worktree! And
this is actually worse than having 6 for the 6 cases.

Michael

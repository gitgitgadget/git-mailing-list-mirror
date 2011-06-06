From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Mon, 6 Jun 2011 07:45:49 -0400
Message-ID: <BANLkTimtkNQcpgDzdJWKtMOdMstTgBF6ow@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<m339jps1wt.fsf@localhost.localdomain>
	<BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
	<201106051311.00951.jnareb@gmail.com>
	<BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
	<7vwrgza3i2.fsf@alter.siamese.dyndns.org>
	<4DEC8322.6040200@drmicha.warpmail.net>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 06 13:45:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTYFp-0003By-Kf
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 13:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534Ab1FFLpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 07:45:51 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62534 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab1FFLpu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 07:45:50 -0400
Received: by bwz15 with SMTP id 15so3217306bwz.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 04:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=egKS6HavZTf8Mj6n3EA5ou+wC2m3zsRi7KtcHCjVwV0=;
        b=FgyqzYN+Zo/pLFo9C7U40+aDFQOt+LUnQ6YwSe28XtrG1vYsIcx5xUHn19WZgyLhbR
         WvKoLbeWpHOWwNLu3SI3OzjOmk4iscpf0YDkBr1bLT+wnbENt+0+pGssL+t3EyR3MQe4
         PjCLMZfEFyq9jziqagdAB0Lac8lbkN0ti900Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=vQOhxoKRPeusE/P3gOXW4oSZDUzcvyVX4l6nztJrvGJRSePxbbn3mbDAcW/upZTbU7
         +vq5SvSgT5PXVyiz7eJrogEDo4hQSZd84O3CXo1nnb63ODj6O+kp4FqEHowHxQvEOIFx
         i8EsuZmKM45MpRybKSe7zEHBD4ClbiKOIp8Rk=
Received: by 10.204.62.4 with SMTP id v4mr1862222bkh.169.1307360749187; Mon,
 06 Jun 2011 04:45:49 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Mon, 6 Jun 2011 04:45:49 -0700 (PDT)
In-Reply-To: <4DEC8322.6040200@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175117>

Thanks for all the interest!

Before getting into the contentious topics:

Is there general agreement on my item #4 that "git branch <name>"
should be replaced by "git checkout -b <name>" in the tutorial?

Concerning the semi-formal notation for describing commands, do people
thing it is useful?  Is this better covered at revctrl.org?


Okay, back to NEXT/WTREE:

I think Junio is right: The best way to think about NEXT and WTREE are
_not_ as commits.  They are "snapshots of the project".  A commit
object is a snaphot + parent commit SHAs + author + message + other
things.  Think of NEXT and WTREE as equivalent to the tree object
pointed to by a commit object.

[Perhaps "next commit" is a bad name for a snapshot]

These concepts of NEXT and WTREE are use by visual tools.  My favorite
Git documentation, Visual Git Reference, uses them.  Even "git stash
save" stores the "state of the index" and "state of the working tree"
in two commits.

My initial desire for NEXT/WTREE was to make "git diff" usage easier
for me to remember.  It ends up that this is _exactly_ the same usage
that inspired the previous emails that Jakub referenced.  I understand
that NEXT and WTREE may not have as many uses elsewhere, but I think
they have a lot of value for "git diff".

I don't think users will have trouble realizing that NEXT and WTREE
are _not_ commits.  They're writable.  Commits are not.  I do think
that NEXT has some value that users will realize that "git add
foo.txt" adds a particular version of foo.txt to the index and that
further edits to foo.txt will not make it into the next commit, unless
"git add foo.txt" is run again.

In reference as to how to report "git show NEXT", I would suggest that
the usual case would be to treat NEXT like a tree object.  I'm new to
Git and I know enough to know that I don't know all the states of the
index nor even all the commands that use it.  I will read up on the
format of the index and try to come up with some answers for the more
complex situations, but I'm also okay with saying the alias NEXT
doesn't work while in a merge conflict (where "git write-tree" would
return an error.)  Perhaps other alias do work then?
MERGE_HEAD/FETCH_HEAD come and go, right?

Mike


On Mon, Jun 6, 2011 at 3:34 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
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
>
> As for WTREE: git diff against work tree does not look at non-tracked
> ignored files, so why should WTREE?
>
> Full disclosure: I love the index but hate the way we make it difficult
> to use sometimes, and even have to lookup myself what command and option
> to actually use if all I want to do is diff A against B, or take the
> version of a file from A and write it to B, when A and B are a commit,
> the index or the worktree (with a commit being the nonwritable, of course).
>
> I mean, this is really crazy: We have 4 commands ("add", "rm
> [--cached]", "checkout [<commit>] --", "reset [<commit>] --") which you
> need to be aware of if all you want to do is moving file contents
> (content at a path) between a commit, the index and the worktree! And
> this is actually worse than having 6 for the 6 cases.
>
> Michael
>

From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Thu, 1 Dec 2011 16:02:09 -0500
Message-ID: <CABURp0oAvt4uES1kjqE0OfSiS9DR6Uj+0bf=zgUi5qkw0rqCSQ@mail.gmail.com>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 <7vlir6brjw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 22:02:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWDm9-0002JX-7k
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 22:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755Ab1LAVCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 16:02:32 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37198 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab1LAVCc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 16:02:32 -0500
Received: by faaq16 with SMTP id q16so1750807faa.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 13:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HMqfo9or/3iDuuuXXX/Bv602NU/ZInuJJLAyWRnufe8=;
        b=K2s7c0ZS/7sx4uqcQ5HaCL6G9GzjUE06Du8xgnqWPcpCQN99HzpsK+pQxMCuFKcReO
         Z0U5zQNe+M3yws6kz0vaLt8QiIOa1GRwA9tfc/y+MxDk7wtMWmLIJdEbeH1CuI44lLkI
         aBZU8eDwpWfIoqP3EMElraDpA11ZLfrl71SZ0=
Received: by 10.180.102.162 with SMTP id fp2mr951285wib.50.1322773350548; Thu,
 01 Dec 2011 13:02:30 -0800 (PST)
Received: by 10.216.61.142 with HTTP; Thu, 1 Dec 2011 13:02:09 -0800 (PST)
In-Reply-To: <7vlir6brjw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186193>

On Wed, Nov 23, 2011 at 1:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "git reset --hard HEAD" is an unambiguously descriptive good name for the
> option. It is a "hard reset" like power cycling a machinery to discard
> anything in progress and get back to a clean slate. I do not see anything
> confusing with this mode nor its name.

As a git expert-user, I agree.

But, honestly, as a git new-user, I had a lot of trouble with this
command.  It is mysterious and powerful and new users do not
understand it.  Everyone learns "git reset --hard HEAD" as a single
command.  Only much later (if ever) do they learn about the other
git-reset options.  --hard is the only useful option for the new user,
so it seems superfluous.  HEAD is a foreign concept for the new-user
and makes little sense when this command is first memorized.  And at
the early stages of the git learning curve, that's what it is:
memorized.  _The spelling is what counts; the meaning is mysterious._
(For all its flaws, though, at least "git reset --hard HEAD" serves to
introduce the new-user to the concept of HEAD.)

So, as a git new-user, what I wanted was this:
  git clean-checkout [or "git checkout --clean"]

What I found instead was this:
  git reset --hard HEAD

What does this have to do with "checking out my files from the last
commit" or "discarding my local, uncommitted edits"?  To the new-user,
nothing at all.  reset?  Meaningless.  --hard?  Whatever.  HEAD?
Shrug.

In the end it doesn't even do what I wanted.  What I really wanted was this:
  git reset --hard HEAD && git clean -fd

I think the git-reset modes should be relegated to plumbing.  I can
see how 'git reset --mixed' is useful for resetting changes out of the
index, but reset is so mired in all sorts of extra mumbo-jumbo that
this usage becomes a forgotten detail for me.  I didn't even learn
that usage until later, where it makes loads of sense on its own:

     FTH: This means that git reset <paths> is the opposite of git add <paths>.

That is beautiful, clean and useful.  If that's all it did, it would be perfect.

Problems with git-reset--hard:
 * It has no safety nets (except the reflog, another concept foreign
to new-users)
 * It requires extra switches/arguments to be useful
 * Surprisingly (at first), it can move your branch, but it's not
spelled 'branch' or 'commit' or 'move'

That last one is particularly troubling in light of the description of
'git reset --hard':
     Resets the index and working tree. Any changes to tracked
     files in the working tree since <commit> are discarded.

Maybe we should add "and by the way, your currently checked-out branch
is moved to point to <commit>".

</rant>

Phil

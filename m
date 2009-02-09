From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: Trouble testing out a patch on a branch new scratch git.git 
	repository
Date: Sun, 8 Feb 2009 16:13:00 -0800
Message-ID: <e38bce640902081613v3e93c1e3g716118c38ce861ab@mail.gmail.com>
References: <e38bce640902081256j3cd84aadn2f0cc863cfca904d@mail.gmail.com>
	 <7vy6wgwqjp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 01:15:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWJnj-0007I3-FP
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 01:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbZBIANJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 19:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502AbZBIANH
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 19:13:07 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:54182 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbZBIANF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 19:13:05 -0500
Received: by yw-out-2324.google.com with SMTP id 5so304812ywh.1
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 16:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VqytRomhww//7+uD60G5UBh0qQACKJP4CP3LVxGbll0=;
        b=c/cYVr4uws/YMlWpT+KML8f2tDLIfSpfscLvKS4bHrmns5OzlH2Pci+aYVjqtdtPG3
         fSdZMWfyNdBswn4YK/rHnJlLMJs+d0+rGK2MhHLAeLnAtIIKPpCj2buSQsvQmjSRjtt9
         GlcNZsOsOcYlDyt17/3vgIOEnXeCZUjBBmHwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gO2D1NKxnFeqB+XciaJq6P6rmkBDLue4QA/gwzdjIY+nfCOBadPaJSR0rM4ZgZfCpN
         KdryxsLIncrSRHBD7jtjRSOH/NJd5un1EAaKa4mpxQlUd01iNgXG1hQJqcHqJFfpJMff
         lExf/EGTgFq5QyobIht/NT5/pcrpF2LWXnRME=
Received: by 10.90.101.17 with SMTP id y17mr234733agb.65.1234138380559; Sun, 
	08 Feb 2009 16:13:00 -0800 (PST)
In-Reply-To: <7vy6wgwqjp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109027>

Much thanks for your extensive writeup, Junio! I will try to follow your
advice on a brand new git clone'ed repository and just reapply my
changes there into the topic branch (makes sense for these small sets
of changes; but not for larger sets ... read my comments below).

But for my education, I've interspersed below some questions where I
am still misunderstanding the situation or intent behind your
recommendation:

On Sun, Feb 8, 2009 at 1:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Now what is that topic branch is for?  Yes, it is about adding this new
> feature, and nothing else.  Don't pull other people's changes made on my
> tree into it.  That will make your topic branch "one new feature and
> everything else" and useless as a topic branch.

Fair enough, but I don't understand what is referred to by "my tree" above?

>
> What would make your life easier would be:
>
>        $ git pull ;# to get up to date with me on your master branch

I am concluding that I need to throw away (well, saving it off first) my
current repo and then do the git pull only from within a fresh git clone?

>        $ git checkout -b bg/no-progress origin/master
>        ... work on e802880 ...
>        ... test it ...
>        $ git commit ;# record that on bg/no-progress topic
>
>        $ git checkout master
>        $ git merge bg/no-progress
>        ... test the result of the merge ...

Refering to that git merge bg/no-progress command above. You said not
to merge from master to bg/no-progress at this early stage, which
makes sense, but now you are going in the reverse via master <--
bg/no-progress. And here I do not see a commit, but that command is
followed straight way with a "git checkout bg/no-progress" below.  Is
that just for testing the merge with the intent of just throwing the
changes away?  In other words, is this next "git checkout
bg/no-progress" command going to silently throw away the "git merge
bg/progress" step at this point?

>
>        $ git checkout bg/no-progress
>        ... work on style fix ...
>        ... test it ...
>        $ git commit ;# again record it on bg/no-progress topic
>
>        $ git checkout master
>        $ git merge bg/no-progress
>        ... test the result of the merge ...
>
>        $ git pull ;# to get up to date with me
>        ... resolve conflicts ...
>
> Then after you are convinced that everything on bg/no-progress is worthy
> of sending to the list [*A*], but its tip is stale because things have
> progressed on my end, you can do this:

Similar question: Is this next "git checkout bg/no-progress" below
going to loose the conflicts I would have just resolved above
(referring to the most recent "... resolve conflicts ..." line above)?

>
>        $ git checkout bg/no-progress
>        $ git rebase origin/master      ;# and rebase to the upstream
>
> which may conflict again (but that would be the same conflict you saw with
> your "git pull" from me, and rerere may remember it).

What does "rerere" mean, or is that a typo?

>
> Review and test the result and then:
>
>        $ git format-patch origin/master
>
> There can be variants in the last few steps.  For example, your commits on
> bg/no-progress may be full of "Oops, this is to fix my own mistake made in
> earlier commits since I forked from the upstream".  You would not want to
> have them in your submission (instead, you would want to pretend as if you
> never made these mistakes in the first place).  For that, you may want to
> do, after you feel the tip of bg/no-progress is in a good shape at point
> *A* above:
>
>        $ git checkout bg/no-progress
>        $ git rebase -i origin/master   ;# and rebase to the upstream
>
> and reorder, squash, and fix them.

What do you mean by "reorder, squash" mean here? Is that something
that is done as a part of the -i option to git rebase?

>
> Also you may feel that at point [*A*] what you have is very precious and
> you would not want yourself breaking it by the final rebase (which is a
> very reasonable thing to feel).  In such a case, the final rewrite could
> be:
>
>        $ git checkout bg/no-progress^0
>        $ git rebase -i origin/master   ;# and rebase to the upstream
>        ... test and review the result.
>        ... convince yourself it is indeed better than
>        ... what you earlier thought to be "very precious".
>        ... and then finally
>        $ git branch -f bg/no-progress
>        $ git format-patch origin/master ;# send this

What is the significance of the ^0 construct tacked onto the end of
"bg/no-progress" at this point, versus just "git checkout
bg/no-progress" without the "^0"?

I made the mistake of reading the "SPECIFYING REVISIONS" section in
git-rev-parse(1) manual, which states:

    A suffix ^ to a revision parameter means the first parent of that
    commit object. ^<n> means the <n>th parent (i.e. rev^ is
    equivalent to rev^1). As a special rule, rev^0 means the commit
    itself and is used when rev is the object name of a tag object
    that refers to a commit object.

I'm having a hard time translating "tag object" and "commit object"
into things I understand w.r.t. the repo I see from my end.

>
> And to finish it off, you may do:
>
>        $ git checkout master
>        $ git merge --ours bg/no-progress

The --ours option to git-merge does not seem to be documented (at
least it is not in the user manual). There is a --ours option
indicated in the git-checkout man page.

>
> The above is a suggestion based on a design to allow you keep sticking to
> your merge based workflow as much as possible, but you could instead
> choose to keep rebasing.  I have some observations at the end of
>
>    http://gitster.livejournal.com/24080.html
>
> comparing the merge based workflow and the rebase based one.
>

The rebase flow would work better for this given that I do eventually
want to send my changes upstream. So, for my/our future Googling
reference: I quote the section out of
http://gitster.livejournal.com/24080.html that I believe applied to me
_before_ I messed things up so badly:

your_blog> Another advantage of rebasing your personal patch constantly is that
your_blog> it forces you a discipline to adjust your changes to the changes in
your_blog> the upstream as early as possible.  If you do not rebase
and choose to
your_blog> use merge in your workflow, your personal changes will be buried deep
your_blog> in the history.  When one of your many later merges with the upstream
your_blog> made you resolve the conflicts with such old changes, two things
your_blog> happen:
your_blog>
your_blog>     * You do not remember what your own change was about, and have a
your_blog>       hard time resolving the conflict;
your_blog>
your_blog>     * You may be able to resolve the conflict, but what you can
your_blog>       extract from "git log --no-merges origin.." will not be
your_blog>       something you can eventually send upstream.  You will need to
your_blog>       rebase before submitting.

Again, much MUCH thanks for your assistance!

Brent

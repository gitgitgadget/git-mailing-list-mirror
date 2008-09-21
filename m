From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC PATCH] Documentation: add manpage about workflows
Date: Mon, 22 Sep 2008 00:26:20 +0400
Message-ID: <20080921202620.GG21650@dpotapov.dyndns.org>
References: <1221147525-5589-3-git-send-email-trast@student.ethz.ch> <1221147585-5695-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Sep 21 22:27:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhVWt-0003jh-PI
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 22:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbYIUU03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 16:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbYIUU03
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 16:26:29 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:50083 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbYIUU02 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 16:26:28 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1052719muf.1
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 13:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rZ7a1ih6PKdrVbH/cGu4V7hRHXEa+B2qmujJyY0idZ0=;
        b=t4gfsW+l1jghHxh5hsrI/7tDLIKSHg0DAGHMz64p3xRDuflccV/vX+qC4K6qswWp05
         UpsaGi080hMS09f7mXcivfS2vsCbV4lkHV9ASaR734e7+ULec24fHR8AFxhVMNS2I1cI
         ZZSqsttw5FMHKDS6istZ6IN0URNokuSgohCpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ob+hgCZZ0pj8cYxRmasMLQjTPqTlOyRPWRC0Si26LX/rRy8JID01RPdo8MyF52FuyW
         2hcIjujUrg/eZzAQor/lX6cLVK3ILXT/UKIARZn8/7mI1vdBFmeteovJXQWU/QhxI8KT
         o35Pg/0znwWKhlfNdoL+CHivSPEdlX72Ugmwo=
Received: by 10.103.23.20 with SMTP id a20mr2054808muj.128.1222028786059;
        Sun, 21 Sep 2008 13:26:26 -0700 (PDT)
Received: from localhost ( [85.140.171.157])
        by mx.google.com with ESMTPS id n10sm8294281mue.0.2008.09.21.13.26.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 13:26:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1221147585-5695-1-git-send-email-trast@student.ethz.ch>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96430>

On Thu, Sep 11, 2008 at 05:39:45PM +0200, Thomas Rast wrote:
> This attempts to make a manpage about workflows that is both handy to
> point people at it and as a beginner's introduction.

Thank you for your attempt. It is clearly a missing part of the Git
documentation. I have a few comments to it below.

> +SEPARATE CHANGES
> +----------------
> +
> +As a general rule, you should try to split your changes into small
> +logical steps, and commit each of them.  They should be consistent,
> +working independently of any later commits, pass the test suite, etc.

I would rather add some explanation why it is a good idea. Something
like this:

"This makes the review process much easier, as well as, makes git bisect
much more useful in finding the cause of regressions."

> +
> +To achieve this, try to commit your new work at least every couple
> +hours.  You can always go back and edit the commits with `git rebase
> +--interactive` to further improve the history before you publish it.

I like the idea of this paragraph but not its wording. Maybe this will
be better (just a variant):

"To achieve this, try to split your work in small steps from the very
beginning. It is always easier to squash a few commits together than
splitting one big commit into a few.  Don't be afraid making steps too
small or that they are not perfect yet. You can always go back later and
edit the commits with `git rebase --interactive` before you publish it."

> +
> +MANAGING BRANCHES
> +-----------------
> +
> +In the following, we will assume there are 'developers', 'testers' and
> +'users'.  Even if the "Testers" are actually an automated test suite
> +and all "Users" are developers themselves, try to think in these terms
> +as you follow a software change through its life cycle.
> +
> +Usually a change evolves in a few steps:
> +
> +* The developers implement a few iterations until it "seems to work".
> +
> +* The testers play with it, report bugs, test the fixes, eventually
> +  clearing the change for stable releases.

Perhaps, the above two points are the most controversial in my opinion.

First, I would expect developers to implement a few iterations until
it (their work) passes the automated test suite and peer review. Only
then their work is merged into 'next' (or into a similar branch, which
constitute that this series is published now).

Second, I am not sure what you meant by testers clears changes for
stable releases, especially after you stated "Testers" may be an
automated test suite.  Whether some change is included is always a
conscious decision of the project maintainer. The fact that some change
has passed all tests successfully only clears it for including into
'next'.

> +
> +* As the users work with the new feature, they report bugs which will
> +  have to be fixed.
> +
> +In the following sections we discuss some problems that arise from
> +such a "change flow", and how to solve them with Git.
> +
> +We consider a fictional project with (supported) stable branch
> +'maint', main testing/development branch 'master' and "bleeding edge"
> +branch 'next'.  We collectively call these three branches 'main
> +branches'.

The idea of 'next' is not obvious from your above explanation. When I
started to learn how Git workflow works, I read something like above
and was very puzzled what is the purpose of having two development
branches: 'master' and 'next'. Only later I realized that it is
necessary to give flexibility in making decisions of what should be
included in the next stable release and what may need more "cooking"
to prove their reliability and usefulness.

> +
> +
> +Merging upwards
> +~~~~~~~~~~~~~~~
> +
> +Since Git is quite good at merges, one should try to use them to
> +propagate changes.  For example, if a bug is fixed, you would want to
> +apply the corresponding fix to all main branches.

The first and second sentences are a bit disconnected here. I would
rather write the second one like this: "An example of such a change
can be a bug fix, which should be applied to all main branches."

Another thing is that I am not sure that the provided reason for doing
so ("Git is quite good at merges") is good enough. It can be said that
Git is quite good at cherry-picking too. Yet, we use merge, because it
allows to deal with large number of patches easier. Merge can be easily
visualized and understood as every merge point means that all changes
before it are included. However, to being able use merge, the developer
has to start from the oldest branch that will include this change. This
is a clear restriction over the anarchic nature of cherry-picking (where
you can introduce a change to an arbitrary branch and then cherry-pick
to others), but it pays off in the long run by better maintainability of
the project. Thus the recommended practice is a strong preference to use
merge over cherry-picking. It does not mean that cherry-picking should
be completely excluded. Occasionally, it may be useful.

> +
> +A quick moment of thought reveals that you cannot do this by merging
> +"downwards" to older releases, since that would merge 'all' changes.

IMHO, expressions such as "a quick moment of thought reveals..." is
more suitable for blogs than for serious documentation.

> +Hence the following:
> +
> +.Merge upwards
> +[caption="Rule: "]
> +=====================================
> +Always commit your fixes to the oldest supported branch that require
> +them.  Then (periodically) merge the main branches upwards into each
> +other.
> +=====================================

Perhaps, it is worth to note here that a non-trivial fixes can be
implemented as topic branches, which starts from the oldest branch
that needs them.

> +
> +This gives a very controlled flow of fixes.  If you notice that you
> +have applied a fix to e.g. 'master' that is also required in 'maint',
> +you will need to cherry-pick it (using linkgit:git-cherry-pick[1])
> +downwards.  This will happen a few times and is nothing to worry about
> +unless you do it all the time.
> +
> +
> +Topic branches
> +~~~~~~~~~~~~~~
> +
> +Any nontrivial feature will require several patches to implement, and
> +may get extra bugfixes or improvements during its lifetime.  If all
> +such commits were in one long linear history chain (e.g. if they were
> +all committed directly to, 'master'), it becomes very hard to see how
> +they belong together.

There is a far more important reason to use topic branches than ecstatic
pleasure from being able to see related changes grouped together in the
history. The main reason to use topic branches is to facilitate parallel
development. Though the idea that anyone commit to the main development
branch ('master') is very appealing due to its simplicity, it leads to
problems down the road. Namely, not all good sounding ideas turns out
good in reality.

In the workflow where everyone commits to 'master' there are only two
ways to deal with that. The first approach is not let developers to
commit their changes until they have completely finished their work
and passed all tests and code-review, and their work deemed important
enough to be included in the next feature release. The second approach
is to commit their work in progress in the hope that it will succeed,
and if not then to rollback changes.

Neither of these two approaches is satisfactory, especially for large
projects. The first approach means that developers are under a great
stress due to inability to save their work in progress, they accumulate
a huge patch, which is very difficult to review, often include some
other changes unrelated to the stated goal, and makes the history of
the project nearly useless for bisecting (linkgit:git-bisect[1]) when
it comes to finding a regression. The second approach means that the
project history gets contaminating with a great number of changes that
eventually didn't work out. Moreover, reverting changes that are belong
to some failed work may extremely difficult as other changes intervene
with them. So, this reverting is hardly ever done completely in practice
if it is done at all, which leads to a lot of garbage in the source
code. Obviously, the history of this project is completely useless for
bisecting as many commits do not really work if they are compiled at
all. Also, this approach leads to an extremely long stabilization period
as it is determined by the time when slowest going work will be in good
shape for release.

Using topic branches immune to that problem as feature are included
into 'master' when they are ready. Moreover, feature branches unless
they are "publish" can go through cycles of testing, review, and
interactive rebasing to edit and improve individual commits. Thus
the finally published history is clean and easy to bisect.


> +
> +Roughly speaking, there are two important workflows.

I think it would make sense to name them here.

> Their
> +distinguishing mark is whether they can be used to propagate merges.

Perhaps, it would be better to say:
"They are distinguished by the ability to propagate merges."

However, this is not the only distinguish between them. Besides, I am
not sure how this one is connected with the rest of the paragraph:

> +Medium to large projects will typically employ some mixture of the
> +two:
> +
> +* "Upstream" in the most general sense 'pushes' changes to the
> +  repositor(ies) holding the main history.

IMHO, it would be better:
s/the main history/the official history of the project/

> Everyone can 'pull' from there to stay up to date.

Would that entrench the wrong idea that one needs to do 'pull'
habitually? And the habitual 'pull' results in habitual 'merge'.

> +
> +* Frequent contributors, subsystem maintainers, etc. may use push/pull
> +  to send their changes upstream.

This is nitpicking, but you cannot use 'pull' to send changes. However,
I suppose you meant to make your repository available for other people
to pull from it.

> +
> +* The rest -- typically anyone more than one or two levels away from the
> +  main maintainer -- send patches by mail.

After reading "mixture of the two:" above, I expected these two being named,
but instead I can see three points. So, it is confusing.

> +If the maintainer tells you that your patch no longer applies to the
> +current upstream, you will have to rebase your topic (you cannot use a
> +merge because you cannot format-patch merges):
> +
> +.format-patch/am: Keeping topics up to date
> +[caption="Recipe: "]
> +=====================================
> +`git rebase upstream`
> +=====================================

Maybe, git pull --rebase is better advice here as it will also fetch
the latest changes from the upstream.

> +
> +You can then fix the conflicts during the rebase.  Presumably you have
> +not published your topic other than by mail, so rebasing it is not a
> +problem.
> +
> +If you receive such a patch (as maintainer, or perhaps reader of the
> +mailing list it was sent to), save the mail to a file and use
> +'git-am':
> +
> +.format-patch/am: Publishing branches/topics
> +[caption="Recipe: "]
> +=====================================
> +`git am < patch`
> +=====================================
> +
> +One feature worth pointing out is the three-way merge, which can help
> +if you get conflicts because of renames:

Could it not be any other reason besides renames? Maybe it is better to
drop "because of renames" here.

> `git am -3` will use index
> +information contained in patches

Because the word "index" is often used in Git in the different meaning
(a.k.a cache), I would re-write this sentence to avoid confusion as:

"`git am -3` will use information contained in index lines of patches"

> to reconstruct a merge base.  See

If I did not know how git am -3 works, reading this would make me think
that git am somehow manage to figure out a common ancestor (commit),
while it uses index lines of the patch to learn the identity of the blob
that was used as the starting point to create the patch, and if this
blob is available locally, git am -3 performs 3-way merge.

So, "reconstruct a merge base" is hardly appropriate here.


Dmitry

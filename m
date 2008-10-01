From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [RFC PATCH] Documentation: add manpage about workflows
Date: Wed, 1 Oct 2008 11:54:35 +0200
Message-ID: <adf1fd3d0810010254k5961b182ked9acda55e2aa57c@mail.gmail.com>
References: <1221147525-5589-3-git-send-email-trast@student.ethz.ch>
	 <1221147585-5695-1-git-send-email-trast@student.ethz.ch>
	 <20080921202620.GG21650@dpotapov.dyndns.org>
	 <200809301805.30753.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 01 11:55:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkyR1-0006eX-1Q
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 11:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbYJAJyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 05:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbYJAJyj
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 05:54:39 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:21747 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbYJAJyh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 05:54:37 -0400
Received: by fk-out-0910.google.com with SMTP id 18so23434fkq.5
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 02:54:35 -0700 (PDT)
Received: by 10.103.23.4 with SMTP id a4mr5675356muj.17.1222854875157;
        Wed, 01 Oct 2008 02:54:35 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Wed, 1 Oct 2008 02:54:35 -0700 (PDT)
In-Reply-To: <200809301805.30753.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97214>

On Tue, Sep 30, 2008 at 6:05 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> As a quick status update, mostly to show that I haven't forgotten
> about this topic:
>
> Thanks Santi and Dmitry for your comments.  You have raised some very
> good points, and I attempted to fix these issues.

Thanks for you document.

>
> Unfortunately, in some places I got stuck trying to work out good
> explanations for the workings of git.git, and some of the newer
> rearrangements left the lead of "Merging branches" in a dire state.
> I'll see if I can find a good solution myself, but suggestions would
> be welcome in any case.  The WIP text is below, and I'll follow up
> with an interdiff to the last version.
>
> - Thomas
>
[...]

>
> SEPARATE CHANGES
> ----------------
>
> As a general rule, you should try to split your changes into small
> logical steps, and commit each of them.  They should be consistent,
> working independently of any later commits, pass the test suite, etc.
> This makes the review process much easier, and the history much more
> useful for later inspection and analysis, for example with
> linkgit:git-blame[1] and linkgit:git-bisect[1].
>
> To achieve this, try to split your work into small steps from the very
> beginning. It is always easier to squash a few commits together than
> to split one big commit into several.  Don't be afraid of making too
> small or imperfect steps along the way. You can always go back later
> and edit the commits with `git rebase \--interactive` before you
> publish them.
>

I know it is against the recommendation but I think it makes sense to
explain how you can split big patches testing them as is explained in
gitlink:git-stash.

[...]

> Graduation
> ~~~~~~~~~~
>
> As a given feature goes from experimental to stable, it also
> "graduates" between the corresponding branches of the software.
> `git.git` uses the following 'main branches':
>
> * 'master' tracks the commits that should go into the next release;
>
> * 'maint' tracks the commits that should go into the next "maintenance
>  release", i.e., update of the last released stable version; and

The "logical" order would be 'maint', 'master', 'next', 'pu', each one
should fast-forward to the next one.

>
> * 'next' is intended as a testing branch for people who like to use
>  more experimental stuff.

The key point is not "more experimental stuff", but 'master' material
but not stable enough.

[...]

> Integration branches
> ~~~~~~~~~~~~~~~~~~~~
>
> If you followed the last paragraph, you will now have many small topic
> branches, and occasionally wonder how they interact.  Perhaps the
> result of merging them does not even work?  But on the other hand, we
> want to avoid merging them anywhere "stable" because such merges
> cannot easily be undone.
>
> The solution, of course, is to make a merge that we can undo: merge
> into a throw-away branch.
>
> .Integration branches
> [caption="Rule: "]
> =====================================
> To test the interaction of several topics, merge them into a
> throw-away branch.
> =====================================
>
> If you make it (very) clear that this branch is going to be deleted
> right after the testing, you can even publish this branch, for example
> to give the testers a chance to work with it, or other developers a
> chance to see if their in-progress work will be compatible.  `git.git`
> has such an official integration branch called 'pu'. You must never
> base any work on such a throw-away branch!

Maybe this last sentence should go in the "Rule:".

>
>
> SHARING WORK
> ------------
>
> After the last section, you should know how to manage topics.  In
> general, you will not be the only person working on the project, so
> you will have to share your work.

Sharing work is explained in the tutorials, maybe this section should
be about "distributed workflows".

>
> Roughly speaking, there are two important workflows: push/pull and
> format-patch/am.

A more descriptive name could be the "merge workflow" and the "patch workflow".

>  The important difference is that push/pull can
> propagate merges, while format-patch cannot.

Like I said in the other mail, the key is that one preserves the
history (including merges) and the other not. This is what makes
possible the push/pull workflow, that all the branches should
fast-forward (and this should be said somewhere)

>  Medium to large projects
> will typically employ some mixture of the two:

s/:/./

Although I think it should be deleted. And what about litle projects?

Different roles do uses different workflows:

>
> * "Upstream" in the most general sense 'pushes' changes to the
>  repositor(ies) holding the official history of the project.
>  Everyone can 'fetch' from there to stay up to date.

s/pushes/publishes/
s/fetch/merge/

>
> * Frequent contributors, subsystem maintainers, etc. may push to a
>  public repository to make their changes available to upstream.

s/push/publish/

Or:

* Frequent contributors, subsystem maintainers, etc. may publish to a
public repository to make their changes available to upstream, or to
their downstreams (acting as upstream to them)

>
> * The rest -- typically anyone more than one or two levels away from the
>  main maintainer -- send patches by mail.

In the "distributed workflows" this would be:

* "Upstream" merges the branches from subsystem maintainers, applies
the 'patches' from others (including themselves) and publishes to the
main repository. See link:howto/maintain-git.txt to see how it is done
in git.git)

* "Subsystem maintainers" act as "upstream" but publishes to a
different repository/branch.

* Frequent contributors, etc, publish their changes in another repository.

* The rest ...

>
> None of these boundaries are sharp, so find out what works best for
> you.
>
>
> Push/pull
> ~~~~~~~~~
>
> There are three main tools that can be used for this:

Sorry, but I don't see the point explaining how to publish the
branches, or keep them up to date.

>
> If you are a maintainer and would like to merge other people's topic
> branches to the main branches, they will typically send a request to
> do so by mail.  Such a request might say
>
> -------------------------------------
> Please pull from
>    git://some.server.somewhere/random/repo.git mytopic
> -------------------------------------
>
> In that case, 'git-pull' can do the fetch and merge in one go, as
> follows.

Or:

Then, you can merge them with just:

> .Push/pull: Merging remote topics
> [caption="Recipe: "]
> =====================================
> `git pull <url> <branch>`
> =====================================
>

Use "<url> <branch>" or "git://some.server.somewhere/random/repo.git
mytopic" in the recipies, but not both.

[...]

>
> format-patch/am
> ~~~~~~~~~~~~~~~

s/.*/patch workflow/

>
> If you are a contributor that sends changes upstream in the form of
> emails, you should use topic branches as usual (see above).  Then use
> linkgit:git-format-patch[1] to generate the corresponding emails
> (highly recommended over manually formatting them because it makes the
> maintainer's life easier).
>
> .format-patch/am: Publishing branches/topics
> [caption="Recipe: "]
> =====================================
> * `git format-patch -M upstream..topic` to turn them into preformatted
>  patch files
> * `git send-email --to=<recipient> <patches>`
> =====================================
>
> See the linkgit:git-format-patch[1] and linkgit:git-send-email[1]
> manpages for further usage notes.  Also you should be aware that the
> maintainer may impose further restrictions, such as "Signed-off-by"
> requirements.

The restrictions and the Signed-off-by also applies to the other workflows.

>
> If the maintainer tells you that your patch no longer applies to the
> current upstream, you will have to rebase your topic (you cannot use a
> merge because you cannot format-patch merges):
>
> .format-patch/am: Keeping topics up to date
> [caption="Recipe: "]
> =====================================
> `git pull --rebase <url> <branch>`
> =====================================
>
> You can then fix the conflicts during the rebase.  Presumably you have
> not published your topic other than by mail, so rebasing it is not a
> problem.
>
> If you receive such a patch (as maintainer, or perhaps as a reader of
> the mailing list it was sent to), save the mail to a file and use
> 'git-am':
>
> .format-patch/am: Publishing branches/topics
> [caption="Recipe: "]
> =====================================
> `git am < patch`
> =====================================
>
> One feature worth pointing out is the three-way merge, which can help
> if you get conflicts: `git am -3` will use index information contained
> in patches to figure out the merge base.  See linkgit:git-am[1] for
> other options.
>
>
> SEE ALSO
> --------
> linkgit:gittutorial[7],
> linkgit:git-push[1],
> linkgit:git-pull[1],
> linkgit:git-merge[1],
> linkgit:git-rebase[1],
> linkgit:git-format-patch[1],
> linkgit:git-send-email[1],
> linkgit:git-am[1]
>
> GIT
> ---
> Part of the linkgit:git[1] suite.
>
>
>

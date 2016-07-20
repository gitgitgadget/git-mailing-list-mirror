Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84B1F203C1
	for <e@80x24.org>; Wed, 20 Jul 2016 23:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701AbcGTXWd (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 19:22:33 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36465 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298AbcGTXWb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2016 19:22:31 -0400
Received: by mail-io0-f179.google.com with SMTP id b62so61273627iod.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 16:22:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mzqK2WyWV3GIs539iKVPQzYEahOLUk3cMaeEJAvQ/6w=;
        b=Q2LAT5RsL+oq+cgRkVOgarxTy8htRXYA5l8cGUC6QwJ2O0vYvXy28qRWYlcink7mtl
         1GH9BNOX4ySbyRFvoDt147FnSZTN5LD63qoR6ZyPkc/hkIIPmTArDFCMshDRi68pFcIq
         5QjF5yWFjR/NOw5vYu5A0hj05N71h6xnmk3+THZkIzm55E6JdS9Idk4MkbT22VZa73jG
         afK07xS4ktmgKall4KEYGSnzUxxfDIW40lL4oXM8YErjNViRHQjeU02E4MpH2jZFfNH1
         4XxOxss35DE6W2DdcB2IfAqo4tj5FgqCQpiU+9Jv6I0Hm5QWRzVssW9u08lECnvZCEF3
         IRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mzqK2WyWV3GIs539iKVPQzYEahOLUk3cMaeEJAvQ/6w=;
        b=I0//ZCH5aoGwapzMWf7C1pjZ55kSkCE+6DZtgFkvSTnpTuvyEGjoe/9zHpeTEBLaMJ
         gTBew8NqKuO+IC9KOa5VsWGlb3gF9TlPUbTfXhTHM6/yJ/qMD75dHBAfH/4W79F1DvD5
         AE28wqy34+cWhOl6LAx1KDwqkT1yCREGiDgsabgRrOt0M4RBW8foxzL5lvWhQ8/m+xWK
         iw0oduzBYoimE9XE68VuHfxkInnmoOdrZTu7yJYh6ugesj6Frbh5nbCzxPxLl1RdN1Wx
         j+eoIi+LyX+tVqyE480O6voHFDsYk9gzUIKmUZBtT5w0oDtKdMZRqdzNQ5CjUnaqkLqG
         wS4w==
X-Gm-Message-State: ALyK8tJ8IQwzz6K1/Wcw5MJLKNFpJ41hrHlFoAaCUOWm91xqhzfV/LSsaHh+39+NA6nIM2npjPODxgFY76EeMDRZ
X-Received: by 10.107.178.129 with SMTP id b123mr47799890iof.83.1469056949975;
 Wed, 20 Jul 2016 16:22:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 20 Jul 2016 16:22:29 -0700 (PDT)
In-Reply-To: <20160720172419.25473-4-pclouds@gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-4-pclouds@gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 20 Jul 2016 16:22:29 -0700
Message-ID: <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
To:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 10:24 AM, Nguyễn Thái Ngọc Duy
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/git-worktree.txt | 8 ++++++++
>  git-submodule.sh               | 8 ++++----
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 41350db..2a5661d 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -142,6 +142,14 @@ to share to all working directories:
>     you are sure you always use sparse checkout for all working
>     directories.
>
> + - `submodule.*` in current state should not be shared because the
> +   information is tied to a particular version of .gitmodules in a
> +   working directory.

While the submodule.* settings are copied from the .gitmodules file initially,
they can be changed in the config later. (That was actually the whole
point of it,
so you can change the submodule remotes URL without having to change history.)

And I would think that most submodule related settings (such as remote URL,
name, path, even depth recommendation) should be the same for all worktrees,
and a different value for one worktree is a carefully crafted
exception by the user.

So while the .gitmodules file can diverge in the work trees I do not
think that the
actual remotes for the submodules in the different worktrees differ
though. The change
of the .gitmodule files may be because you checked out an old commit, that
has outdated information on where to get the submodule from.

> +
> + - `remote.*` added by submodules may be per working directory as
> +   well, unless you are sure remotes from all possible submodules in
> +   history are consistent.
> +
>  DETAILS
>  -------
>  Each linked working tree has a private sub-directory in the repository's
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 4ec7546..7b576f5 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -261,7 +261,7 @@ or you are unsure what this means choose another name with the '--name' option."
>                         esac
>                 ) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
>         fi
> -       git config submodule."$sm_name".url "$realrepo"
> +       git config --worktree submodule."$sm_name".url "$realrepo"

This is in cmd_add. Actually I think this should be --not-worktree
(i.e. --local)
as when you add a submodule in one worktree, and then in another,
you may want to have the same URL. However if another worktree
already configured it you want to keep the option.
so rather:

  if git config  submodule."$sm_name".url then
      # it exists, do nothing
  else
    # it does not exist
    git config --local ...

>
>         git add $force "$sm_path" ||
>         die "$(eval_gettext "Failed to add submodule '\$sm_path'")"
> @@ -461,7 +461,7 @@ Submodule work tree '\$displaypath' contains a .git directory
>                         # Remove the whole section so we have a clean state when
>                         # the user later decides to init this submodule again
>                         url=$(git config submodule."$name".url)
> -                       git config --remove-section submodule."$name" 2>/dev/null &&
> +                       git config --worktree --remove-section submodule."$name" 2>/dev/null &&
>                         say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$displaypath'")"

This is in cmd_deinit, which is documented as:
           Unregister the given submodules, i.e. remove the whole
           submodule.$name section from .git/config together with their work
           tree. Further calls to git submodule update, git submodule foreach
           and git submodule sync will skip any unregistered submodules until
           they are initialized again, so use this command if you don’t want
           to have a local checkout of the submodule in your work tree
           anymore. If you really want to remove a submodule from the
           repository and commit that use git-rm(1) instead.

So one might wonder if the unregister should be a global unregister
or a worktree specific unregister.

From a users POV there are:
* non existent submodules (no gitlink recorded, no config set,
  no repo in place)
* not initialized submodules (gitlink is recorded, no config set,
  and an empty repo is put in the working tree as a place holder).
* initialized submodules (gitlink is recorded, the config
  submodule .<name>.url is copied from the .gitmodules file to .git/config.
  an empty dir in the working tree as a place holder)
  A user may change the configuration before the next step as the url in
  the .gitmodules file may be wrong and the user doesn't want to
  rewrite history
* existing submodules (gitlink is recorded, the config option is set
  and instead of an empty placeholder dir, we actually have a git
  repo there.)
* matching submodules (the recorded git link matches
  the actual checked out state of the repo!, config option and repo exist)

I made up these terms for these 5 states and they don't appear in any
documentation, but I think that is the exhaustive list of what a submodule
should be, when using the git-submodule command properly.

There can be more things though. As we have three indicators (existence of
gitlink, config option and repo), we can have up to 8 states, I left some out in
the above listing.

* gitlink recorded, no config set, repo is there and maybe even matches the
  recorded git link.
   What a strange thing! git treats that as a "not initialized" from above.
* no gitlink exists, no config exists, but a repo exists:
  That's just an embedded repo, never touch it!
* no gitlink, no repo, but a config exists: just a stray old config
laying around,
  ignore it
* no gitlink, but a config and a repo exists: "A deleted submodule", use
  rm -rf to purge it.

--------
The above was a wall of text to make myself aware of the pitfalls of submodules.
---

A discussion with Jonathan Nieder in office ensued and we came to the following
conclusions:
* Anything except the "existence in the working tree" shall be shared,
i.e. is a repository
  specific, not working tree specific setting.

Currently we use the submodule."<name>".url config option to determine
the existence of
a submodule (init vs non init; if init -> git submodule update will
(maybe fetch) and checkout
accordingly).

As an intermediate step forward we could do:
* introduce a submodule."<name>".existsInWorktree = [true/false]
setting, that decouples
  the check for existence from the url being present. That is the only
option per worktree, all
  other submodule."<name>".* options are shared if not overwritten
manually with care

* another approach would be to have a
submodule.includeInWorktree=<pathspec> option
  which is similar, but has slightly different naming.

Looking back at origin/sb/submodule-default-path (which is in pu for a
long time now),
which allowed a configuration submodule.defaultUpdatePath <pathspec>,
that could be
used with `git submodule update --init-default-path`.

----
So maybe we want to drop that series and first talk about a migration plan from
the current state to a world where we have the existence depending not
on the url
parameter, but a boolean variable submodule.<name>.<good_name>.
Depending on <good_name> a submodule would be ignored or tried to checkout
in e.g. `submodule update`

---
If we want to move the current behavior of submodules forward, we
would want to have
anything but the url as shared variables and then use the url variable
as a per-worktree
existence flag.

Thanks,
Stefan

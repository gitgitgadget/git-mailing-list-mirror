From: Sergey Sharybin <sergey.vfx@gmail.com>
Subject: Re: [RFC PATCH] disable complete ignorance of submodules for index
 <-> HEAD diff
Date: Mon, 25 Nov 2013 15:01:34 +0600
Message-ID: <CAErtv26e1NxmsBLH_2KuzBECiwZvyvstqXoK5Vybk9xpsaaO9Q@mail.gmail.com>
References: <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
	<CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
	<20131122151120.GA32361@sigill.intra.peff.net>
	<CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
	<CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
	<CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
	<CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
	<CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
	<528FC638.5060403@web.de>
	<20131122215454.GA4952@sandbox-ub>
	<20131123011145.GB4952@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Nov 25 10:05:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vks6a-0007oj-4Z
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 10:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087Ab3KYJBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 04:01:41 -0500
Received: from mail-ve0-f181.google.com ([209.85.128.181]:38560 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473Ab3KYJBf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 04:01:35 -0500
Received: by mail-ve0-f181.google.com with SMTP id oy12so2597426veb.40
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 01:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Pss9fQxipOQOFVjop73iqj4Dr/lw4P0yCiFGYUbkz3U=;
        b=pE6iNbvJv1iyKnwVY8WyhL6wqbcmQEnHH89BOwujFpYatNDprBlkrBDFWul9rtExZB
         6GG5zel59S8j6wAnARygaM7jNY0CtLKwOyxb0LAcwun+UbNOlQGwUHvctFJT7Zl9ub35
         Nyad20TA5NiISvGmWXWP74SWeFaybXLSWUl4nf/e/DyGvy6nGHhn8BjISHG7Zr6EWU8P
         lkCYTJa8Y6fNVHM4uS/IJzbkHLgA2qY48zengVhAmX7S4a+U5EK++n0h2eqU4wsnR8rl
         gnxT/lWXDALsPLhPzk+3l++XoZG1JHVrozZ7i5xbceiLx0oMHBFKWomz4OP5xDMpInFb
         AIsw==
X-Received: by 10.221.19.5 with SMTP id qi5mr24560406vcb.15.1385370094323;
 Mon, 25 Nov 2013 01:01:34 -0800 (PST)
Received: by 10.52.169.2 with HTTP; Mon, 25 Nov 2013 01:01:34 -0800 (PST)
In-Reply-To: <20131123011145.GB4952@sandbox-ub>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238305>

Hi,

Tested the patch. `git status` now shows the changes to the
submodules, which is nice :)

However, is it possible to make it so `git commit` lists submodules in
"changes to be committed" section, so you'll see what's gonna to be in
the commit while typing the commit message as well?

On Sat, Nov 23, 2013 at 7:11 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> If the value of ignore for submodules is set to "all" we would not show
> whats actually committed during status or diff. This can result in the
> user committing unexpected submodule references. Lets be nicer and always
> show whats in the index.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> This probably needs splitting up into two patches one for the
> refactoring and one for the actual fix. It is also missing tests, but I
> would first like to know what you think about this approach.
>
>  builtin/diff.c | 43 +++++++++++++++++++++++++++----------------
>  diff.h         |  2 +-
>  submodule.c    |  6 ++++--
>  wt-status.c    |  3 +++
>  4 files changed, 35 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index adb93a9..e9a356c 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -249,6 +249,21 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
>         return run_diff_files(revs, options);
>  }
>
> +static int have_cached_option(int argc, const char **argv)
> +{
> +       int i;
> +       for (i = 1; i < argc; i++) {
> +               const char *arg = argv[i];
> +               if (!strcmp(arg, "--"))
> +                       return 0;
> +               else if (!strcmp(arg, "--cached") ||
> +                        !strcmp(arg, "--staged")) {
> +                       return 1;
> +               }
> +       }
> +       return 0;
> +}
> +
>  int cmd_diff(int argc, const char **argv, const char *prefix)
>  {
>         int i;
> @@ -259,6 +274,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>         struct blobinfo blob[2];
>         int nongit;
>         int result = 0;
> +       int have_cached;
>
>         /*
>          * We could get N tree-ish in the rev.pending_objects list.
> @@ -305,6 +321,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>
>         if (nongit)
>                 die(_("Not a git repository"));
> +
> +       have_cached = have_cached_option(argc, argv);
> +       if (have_cached)
> +               DIFF_OPT_SET(&rev.diffopt, NO_IGNORE_SUBMODULE);
> +
>         argc = setup_revisions(argc, argv, &rev, NULL);
>         if (!rev.diffopt.output_format) {
>                 rev.diffopt.output_format = DIFF_FORMAT_PATCH;
> @@ -319,22 +340,12 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>          * Do we have --cached and not have a pending object, then
>          * default to HEAD by hand.  Eek.
>          */
> -       if (!rev.pending.nr) {
> -               int i;
> -               for (i = 1; i < argc; i++) {
> -                       const char *arg = argv[i];
> -                       if (!strcmp(arg, "--"))
> -                               break;
> -                       else if (!strcmp(arg, "--cached") ||
> -                                !strcmp(arg, "--staged")) {
> -                               add_head_to_pending(&rev);
> -                               if (!rev.pending.nr) {
> -                                       struct tree *tree;
> -                                       tree = lookup_tree(EMPTY_TREE_SHA1_BIN);
> -                                       add_pending_object(&rev, &tree->object, "HEAD");
> -                               }
> -                               break;
> -                       }
> +       if (!rev.pending.nr && have_cached) {
> +               add_head_to_pending(&rev);
> +               if (!rev.pending.nr) {
> +                       struct tree *tree;
> +                       tree = lookup_tree(EMPTY_TREE_SHA1_BIN);
> +                       add_pending_object(&rev, &tree->object, "HEAD");
>                 }
>         }
>
> diff --git a/diff.h b/diff.h
> index e342325..81561b3 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -64,7 +64,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
>  #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
>  #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
>  #define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
> -/* (1 <<  9) unused */
> +#define DIFF_OPT_NO_IGNORE_SUBMODULE (1 <<  9)
>  #define DIFF_OPT_HAS_CHANGES         (1 << 10)
>  #define DIFF_OPT_QUICK               (1 << 11)
>  #define DIFF_OPT_NO_INDEX            (1 << 12)
> diff --git a/submodule.c b/submodule.c
> index 1905d75..9d81712 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -301,9 +301,11 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
>         DIFF_OPT_CLR(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
>         DIFF_OPT_CLR(diffopt, IGNORE_DIRTY_SUBMODULES);
>
> -       if (!strcmp(arg, "all"))
> +       if (!strcmp(arg, "all")) {
> +               if (DIFF_OPT_TST(diffopt, NO_IGNORE_SUBMODULE))
> +                       return;
>                 DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
> -       else if (!strcmp(arg, "untracked"))
> +       } else if (!strcmp(arg, "untracked"))
>                 DIFF_OPT_SET(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
>         else if (!strcmp(arg, "dirty"))
>                 DIFF_OPT_SET(diffopt, IGNORE_DIRTY_SUBMODULES);
> diff --git a/wt-status.c b/wt-status.c
> index b4e44ba..34be1cc 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -462,6 +462,9 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>                 handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
>         }
>
> +       /* for the index we need to disable complete ignorance of submodules */
> +       DIFF_OPT_SET(&rev.diffopt, NO_IGNORE_SUBMODULE);
> +
>         rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
>         rev.diffopt.format_callback = wt_status_collect_updated_cb;
>         rev.diffopt.format_callback_data = s;
> --
> 1.8.5.rc3.1.gcd6363f
>



-- 
With best regards, Sergey Sharybin

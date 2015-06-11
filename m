From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/WIP v2 05/19] am: split out mbox/maildir patches with git-mailsplit
Date: Thu, 11 Jun 2015 10:45:27 -0700
Message-ID: <CAGZ79kYUK=UhfR1CQREH9GLNuo_7=AmcGwMw15_f_zYFZLarsw@mail.gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
	<1434018125-31804-6-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 19:45:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z36Xq-0004kI-CD
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 19:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933679AbbFKRpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 13:45:33 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:33473 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933688AbbFKRp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 13:45:29 -0400
Received: by yhpn97 with SMTP id n97so5074844yhp.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pG9fl/RPwMvwI2IMrmLNG9sLWj5LYgOkue+pcPCFO8Y=;
        b=bX4UyHhzhHLqDz09CtgIp7EmFdcMAzpacPNUH0dTLfLfiACGizQ4hrB5vC3yU8+U8l
         Rao0MXrIYXnUhAHx0hviAJ24rVDMHVi/+44Z3qVMl4U5zKmfBIVRYeUaxiQITkpOrgm6
         gFDOOLIUqzshqbg5FZ+4dUD9m43lUQ3cox+bd5J/IcFfi30wiR3cVu+JMx5E2xUSUQJe
         M/shUFOR7b9AGAY3PEshmGMVtiPRGGDLuLVbZFDEnlaH5hnZQK3IwqvofgorYurCRLwa
         vGlzTrV6uO1LD7logtwffVmCDD1BzvBWs+KNg0Sbe4Lsdy6rENGApdn3QWLkHCTKLhRm
         7/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pG9fl/RPwMvwI2IMrmLNG9sLWj5LYgOkue+pcPCFO8Y=;
        b=WXDYvyp2tSSIZ6v2KwsRn2E9D/ZaUd4ejhYqCzf5/0/FLIZb+wNN3Ka1D/a3il05Mk
         g5wqnHxjabOKLL+8jO2olp1lhxOrssOZHGgisduDoxEuEs+7ywrIKETQzIid9Z5/oW+n
         zS+e9QKLPnFK78kgANsg4WqgnEsjHNIpZAV50pscJnmaHplS4XJzIyCULYRyRkPTe803
         2TgPmyDh9djiIiy3vzSy0YIKYM/t5jnTp1ranb1tbN0on919z2iNcoVsk4YWEd1l9LSZ
         oKBr7m+X337s4JQxdf6xpBoAal+HGyAoGIS3fnO7ZKb94BVkwA/owqAANeO38XuJlq7x
         pNIw==
X-Gm-Message-State: ALoCoQl+Gv1q9E34rDimdRPC1SXXqpjKa1PWk3r2hTQfdRQoYbDQCukdKhBlYDqhjIYHp1el6Wb8
X-Received: by 10.13.213.212 with SMTP id x203mr13171081ywd.174.1434044728026;
 Thu, 11 Jun 2015 10:45:28 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Thu, 11 Jun 2015 10:45:27 -0700 (PDT)
In-Reply-To: <1434018125-31804-6-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271445>

On Thu, Jun 11, 2015 at 3:21 AM, Paul Tan <pyokagan@gmail.com> wrote:
> git-am.sh supports mbox, stgit and mercurial patches. Re-implement
> support for splitting out mbox/maildirs using git-mailsplit, while also
> implementing the framework required to support other patch formats in
> the future.
>
> Re-implement support for the --patch-format option (since a5a6755
> (git-am foreign patch support: introduce patch_format, 2009-05-27)) to
> allow the user to choose between the different patch formats.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>     v2
>
>     * Declare int opt_patchformat as static.
>
>     * Fix up indentation style for the switch()
>
>  builtin/am.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 103 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index f061d21..5198a8e 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -8,6 +8,12 @@
>  #include "exec_cmd.h"
>  #include "parse-options.h"
>  #include "dir.h"
> +#include "run-command.h"
> +
> +enum patch_format {
> +       PATCH_FORMAT_UNKNOWN = 0,
> +       PATCH_FORMAT_MBOX
> +};
>
>  struct am_state {
>         /* state directory path */
> @@ -16,6 +22,9 @@ struct am_state {
>         /* current and last patch numbers, 1-indexed */
>         int cur;
>         int last;
> +
> +       /* number of digits in patch filename */
> +       int prec;
>  };
>
>  /**
> @@ -26,6 +35,7 @@ static void am_state_init(struct am_state *state)
>         memset(state, 0, sizeof(*state));
>
>         strbuf_init(&state->dir, 0);
> +       state->prec = 4;
>  }
>
>  /**
> @@ -111,13 +121,67 @@ static void am_destroy(const struct am_state *state)
>  }
>
>  /**
> + * Splits out individual patches from `paths`, where each path is either a mbox
> + * file or a Maildir. Return 0 on success, -1 on failure.
> + */
> +static int split_patches_mbox(struct am_state *state, struct string_list *paths)
> +{
> +       struct child_process cp = CHILD_PROCESS_INIT;
> +       struct string_list_item *item;
> +       struct strbuf last = STRBUF_INIT;
> +
> +       cp.git_cmd = 1;
> +       argv_array_push(&cp.args, "mailsplit");
> +       argv_array_pushf(&cp.args, "-d%d", state->prec);
> +       argv_array_pushf(&cp.args, "-o%s", state->dir.buf);
> +       argv_array_push(&cp.args, "-b");
> +       argv_array_push(&cp.args, "--");
> +
> +       for_each_string_list_item(item, paths)
> +               argv_array_push(&cp.args, item->string);
> +
> +       if (capture_command(&cp, &last, 8))
> +               return -1;
> +
> +       state->cur = 1;
> +       state->last = strtol(last.buf, NULL, 10);
> +
> +       return 0;
> +}
> +
> +/**
> + * Splits out individual patches, of patch_format, contained within paths.
> + * These patches will be stored in the state directory, with each patch's
> + * filename being its index, padded to state->prec digits. state->cur will be
> + * set to the index of the first patch, and state->last will be set to the
> + * index of the last patch. Returns 0 on success, -1 on failure.
> + */
> +static int split_patches(struct am_state *state, enum patch_format patch_format,
> +               struct string_list *paths)
> +{
> +       switch (patch_format) {
> +       case PATCH_FORMAT_MBOX:
> +               return split_patches_mbox(state, paths);
> +       default:
> +               die("BUG: invalid patch_format");
> +       }
> +       return -1;
> +}
> +
> +/**
>   * Setup a new am session for applying patches
>   */
> -static void am_setup(struct am_state *state)
> +static void am_setup(struct am_state *state, enum patch_format patch_format,
> +               struct string_list *paths)
>  {
>         if (mkdir(state->dir.buf, 0777) < 0 && errno != EEXIST)
>                 die_errno(_("failed to create directory '%s'"), state->dir.buf);
>
> +       if (split_patches(state, patch_format, paths) < 0) {
> +               am_destroy(state);
> +               die(_("Failed to split patches."));
> +       }
> +
>         write_file(am_path(state, "next"), 1, "%d", state->cur);
>
>         write_file(am_path(state, "last"), 1, "%d", state->last);
> @@ -138,13 +202,33 @@ static void am_next(struct am_state *state)
>   */
>  static void am_run(struct am_state *state)
>  {
> -       while (state->cur <= state->last)
> +       while (state->cur <= state->last) {
> +
> +               /* TODO: Patch application not implemented yet */
> +
>                 am_next(state);
> +       }

When reviewing the previous patch I did look at this loop for awhile confused,
if you want to apply patches in am_next(state) and thought there might be
a better approach.

Maybe you want to move this chunk with the TODO into the previous patch,
so it's clear after reading the documentation of am_run, that the actual am is
missing there.


>
>         am_destroy(state);
>  }
>
> +/**
> + * parse_options() callback that validates and sets opt->value to the
> + * PATCH_FORMAT_* enum value corresponding to `arg`.
> + */
> +static int parse_opt_patchformat(const struct option *opt, const char *arg, int unset)
> +{
> +       int *opt_value = opt->value;
> +
> +       if (!strcmp(arg, "mbox"))
> +               *opt_value = PATCH_FORMAT_MBOX;
> +       else
> +               return -1;
> +       return 0;
> +}
> +
>  static struct am_state state;
> +static int opt_patch_format;
>
>  static const char * const am_usage[] = {
>         N_("git am [options] [(<mbox>|<Maildir>)...]"),
> @@ -152,6 +236,8 @@ static const char * const am_usage[] = {
>  };
>
>  static struct option am_options[] = {
> +       OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
> +               N_("format the patch(es) are in"), parse_opt_patchformat),
>         OPT_END()
>  };
>
> @@ -173,8 +259,21 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>
>         if (am_in_progress(&state))
>                 am_load(&state);
> -       else
> -               am_setup(&state);
> +       else {
> +               struct string_list paths = STRING_LIST_INIT_DUP;
> +               int i;
> +
> +               for (i = 0; i < argc; i++) {
> +                       if (is_absolute_path(argv[i]) || !prefix)
> +                               string_list_append(&paths, argv[i]);
> +                       else
> +                               string_list_append(&paths, mkpath("%s/%s", prefix, argv[i]));
> +               }
> +
> +               am_setup(&state, opt_patch_format, &paths);
> +
> +               string_list_clear(&paths, 0);
> +       }
>
>         am_run(&state);
>
> --
> 2.1.4
>

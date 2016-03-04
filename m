From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 1/3] pull --rebase: add --[no-]autostash flag
Date: Fri, 4 Mar 2016 23:52:43 +0800
Message-ID: <CACRoPnTqX+Qswfxmj07LRFThV1gjAvZ7c=sr1XQjxc1KHgvVPg@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 16:52:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abs26-0008RV-I1
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 16:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758743AbcCDPwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 10:52:46 -0500
Received: from mail-lb0-f194.google.com ([209.85.217.194]:36574 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758436AbcCDPwp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 10:52:45 -0500
Received: by mail-lb0-f194.google.com with SMTP id gn5so5306875lbc.3
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 07:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=zAyb9S4Xx7uX2CHyi27Nkdah5fEDcwOhL5oFl351irM=;
        b=D7rPJ83EnV/f1TVouARJiRF3v4fpX+GNNMY3DGE+SGEswI3KlfDmYA0X1VUhxCFS7k
         26SfHiE9OEEHyO1TRNVZTCjw1RP11+awHDpjmZlZgGcgDXhYfGx6NeTyQiIAR/9pLHo5
         iiFVQ04kR/6ZXBw1vFS+1mX0caa6n/unxrI6qyehEnWweKEW7zX4qZ8asCScMFT+VOLn
         Sz4+l8FmYUBpolhbCG2KIKR16VDBWEN3bHOoOw6Oa2b8lKNNKy0LrPoL8Emx11GNh/w+
         bJ9ayqOAwEeoCyJl8iVUTgPPjydVPpqyfTKpfwWSqO+tMuTG+Ti6DqNndlAO49e+/P7k
         M08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=zAyb9S4Xx7uX2CHyi27Nkdah5fEDcwOhL5oFl351irM=;
        b=Gf4Ry8AYWbWoAUwdrZc3UiAYaKHOxOYmIKEBpYi2qYeW/IC+mI6Q8DrWggVjKiZ7FP
         kKIl5A4dvBjzPV4ygf5JAEclfOxvH2gXFZ5QmgmUYSSnvcie4v1o9vWaKj+eezhdvLBn
         kdmRIGQbMkqoz9hf+dh0LQqEK26qivHB26VPPUib2nAd8EKZ+v5N2fTzCu/RKWqv33C8
         UoDaOJrSCNKEPARnOS37ftRk2PTldTBXkCTqM3VBDnoXMHJrq6KH7I1URjSpHlIFm5sA
         3ArWNBJL/vBT1cKrUfeHpXLkyXlumLA0nS3vxycGbaMNVHMRtYXBG/Hru1SjpKg7N62v
         lZew==
X-Gm-Message-State: AD7BkJIbF+EEGL6cr3NeBg1zPUA4BtW8byvCUTQ7q5VW9ytmVe285MwJfYg47m+RTKF/aToqW4yZL4rNHUuNAA==
X-Received: by 10.112.172.42 with SMTP id az10mr3318622lbc.128.1457106763368;
 Fri, 04 Mar 2016 07:52:43 -0800 (PST)
Received: by 10.112.207.74 with HTTP; Fri, 4 Mar 2016 07:52:43 -0800 (PST)
In-Reply-To: <1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288260>

On Fri, Mar 4, 2016 at 12:13 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 10eff03..b338b83 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -85,6 +85,7 @@ static char *opt_squash;
>  static char *opt_commit;
>  static char *opt_edit;
>  static char *opt_ff;
> +static int opt_autostash = -1;
>  static char *opt_verify_signatures;
>  static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
>  static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
> @@ -146,6 +147,8 @@ static struct option pull_options[] = {
>         OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
>                 N_("abort if fast-forward is not possible"),
>                 PARSE_OPT_NOARG | PARSE_OPT_NONEG),
> +       OPT_BOOL(0, "autostash", &opt_autostash,
> +               N_("automatically stash/stash pop before and after rebase")),
>         OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
>                 N_("verify that the named commit has a valid GPG signature"),
>                 PARSE_OPT_NOARG),
> @@ -789,7 +792,8 @@ static int run_rebase(const unsigned char *curr_head,
>         argv_array_pushv(&args, opt_strategy_opts.argv);
>         if (opt_gpg_sign)
>                 argv_array_push(&args, opt_gpg_sign);
> -

Minor nit: but when I wrote the code for run_rebase() I separated the
options for "Shared options" and "Options passed to git-rebase" into
different code block groups from the other code, and I would like it
if it remained that way :-(

> +       if (opt_autostash)
> +               argv_array_push(&args, "--autostash");

Hmm, interesting. If rebase.autostash=true !opt_autostash, we don't
need to pass --no-autostash to git-rebase because it will only stash
if the worktree is dirty, but a dirty worktree will be caught by
git-pull's die_on_unclean_worktree() anyway.

Still, it may be a problem because the worktree may become dirty
in-between our "worktree is clean" check and when git-rebase is run
(during the git-fetch), and the user may be surprised if git-rebase
attempted to stash in that case.

So we may wish to pass "--no-autostash" to git-rebase as well.

>         argv_array_push(&args, "--onto");
>         argv_array_push(&args, sha1_to_hex(merge_head));
>
> @@ -835,18 +839,25 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                 hashclr(orig_head);
>
>         if (opt_rebase) {
> -               int autostash = 0;
> -
>                 if (is_null_sha1(orig_head) && !is_cache_unborn())
>                         die(_("Updating an unborn branch with changes added to the index."));
>
> -               git_config_get_bool("rebase.autostash", &autostash);
> -               if (!autostash)
> +               if (opt_autostash == -1)
> +                       git_config_get_bool("rebase.autostash", &opt_autostash);
> +
> +               if (opt_autostash == 0 || opt_autostash == -1)
>                         die_on_unclean_work_tree(prefix);
>
>                 if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
>                         hashclr(rebase_fork_point);
>         }
> +       else {

Git code style puts the else on the same line, not on a new one.

> +               /* If --[no-]autostash option is called without --rebase */

Yeah, I agree with Eric that this comment should be dropped,

> +               if (opt_autostash == 0)
> +                       die(_("--no-autostash option is only valid with --rebase."));
> +               else if (opt_autostash == 1)
> +                       die(_("--autostash option is only valid with --rebase."));
> +       }

and these error messages combined.

>
>         if (run_fetch(repo, refspecs))
>                 return 1;
> --
> 2.7.1.340.g69eb491.dirty

Regards,
Paul

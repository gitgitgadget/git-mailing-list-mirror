Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBADC20968
	for <e@80x24.org>; Thu, 22 Dec 2016 21:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941314AbcLVVmB (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 16:42:01 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:32842 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938967AbcLVVl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 16:41:59 -0500
Received: by mail-yw0-f194.google.com with SMTP id s68so15648510ywg.0
        for <git@vger.kernel.org>; Thu, 22 Dec 2016 13:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UBVd8+agoYl+TCZOuHpNW7fBAkLcK9uVaBzHb4HQj3s=;
        b=CO2aDoWRnx3rcRITsjXIl46G/8j7T/NeD9jrXKOTDACdKkGN3a5VJRbI7CKLHGu1Yb
         D1511KMHexwKCmaWD+GelJFAsIrI5JgZnZn4LpaHxi/21LuUXSvG/5MwwE/nSUu7VyoU
         r5+6ndsVAy+XTcBvAFPdF/DlpwI2nD3nLTOjcGsbyKLZe1QdwNG4ZiJql03zgSgZ+dxJ
         Qztb0uFtB9zEUVMwvINBoVMGGhdztwQDVqGVf3GfE1OzDeHdlRUzSx4gUSfz21KWJeoR
         9khUGtY4nqfqdlkaq3it9UljDSO7Xnq2K7SG8cK4ClfBh0cdffdflLoI/e4JkXo/YG8+
         ViPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UBVd8+agoYl+TCZOuHpNW7fBAkLcK9uVaBzHb4HQj3s=;
        b=eTVv3nyTU6JZs4kb6YoRNj0NXpOepf5fFxQxdZYE9WUAKgn1abVjh/pXKLPtnwhtEL
         aLNIT+StiRppXmaWbiEeSb/iaWhtZBBtPTWjnTMXrQ8srvxVs3MaeiAi5odZj2RXXuE1
         TobNrs535tBzNzU9GyGwL+nB2gWf/mbs4Pa3Y+F4bR2CBfis2ercJiVGxkBTqV4N6ieu
         vAHH31hjcjcpFkjdctXALJ1KNQTaHulFvRuqyofXG7kdzvynNVPQIVHp4jjNii/J6fv+
         fIZA1O9ax3jUDB2GtwJkWuqc6YwoRIpVW1M/cJEGCohJjQCS0Syv/xScIwhd8o6UNFXd
         DROQ==
X-Gm-Message-State: AIkVDXLfbGXEfxN1JKsnIZQc8NoV/bGrQXecSea8o1EWAsfMX2NK0s3lcFt6WZ8l28gvG8B8gjH8abkBWa/Obw==
X-Received: by 10.13.254.71 with SMTP id o68mr10197260ywf.318.1482442918706;
 Thu, 22 Dec 2016 13:41:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.177.158 with HTTP; Thu, 22 Dec 2016 13:41:38 -0800 (PST)
In-Reply-To: <xmqqinqbfz2r.fsf@gitster.mtv.corp.google.com>
References: <20161217005442.5866-1-jacob.e.keller@intel.com>
 <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com> <CA+P7+xp=7h7oATwO6vunqO+nfGhvQgiRkwG0P44hC4YLW2MRhA@mail.gmail.com>
 <xmqqinqbfz2r.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 22 Dec 2016 13:41:38 -0800
Message-ID: <CA+P7+xrkp-qiUVmfeLUcaMP-RSDbH4u3vCjVoQN8=mhz25Cd3A@mail.gmail.com>
Subject: Re: [PATCH] diff: prefer indent heuristic over compaction heuristic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Norbert Kiesel <nkiesel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 22, 2016 at 1:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> I don't think we have too many config options that interact in this
>> way, so I understand that "last writing of a particular configuration"
>> makes sense, but interactions between configs is something that would
>> have never occurred to me. I'll send a patch to drop the compaction
>> heuristic since I think we're all 100% in agreement that it is
>> superseded by the new configuration (as no case has been shown where
>> the new one is worse than compaction, and most show it to be better).
>
> If I recall correctly, we agreed that we'll drop the implementation
> of compaction, but use the name --compaction-heuristics to trigger
> the new and improved "indent heuristics":
>
>     <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net>
>

That sounds familiar.

> So let's do this.
>
> -- >8 --
> Subject: [PATCH] diff: retire the original experimental "compaction" heuristics
>
> This retires the experimental "compaction" heuristics but with a
> twist.  It removes the mention of "indent" heuristics, which was a
> competing experiment, from everywhere, guts the core logic of the
> original "compaction" heuristics out and replaces it with the logic
> used by the "indent" heuristics.
>
> The externally visible effect of this change is that people who have
> been experimenting by setting diff.compactionHeuristic configuration
> or giving the command line option --compaction-heuristic will start
> getting the behaviour based on the improved heuristics that used to
> be called "indent" heuristics.
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/diff-config.txt            |  6 ++---
>  Documentation/diff-heuristic-options.txt |  2 --
>  builtin/blame.c                          |  3 +--
>  diff.c                                   | 25 ++++-----------------
>  git-add--interactive.perl                |  5 +----
>  t/t4061-diff-indent.sh                   | 38 ++++++++++++++++----------------
>  xdiff/xdiff.h                            |  1 -
>  xdiff/xdiffi.c                           | 37 +++----------------------------
>  8 files changed, 30 insertions(+), 87 deletions(-)
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 58f4bd6afa..39fff3aef9 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -171,11 +171,9 @@ diff.tool::
>
>  include::mergetools-diff.txt[]
>
> -diff.indentHeuristic::
>  diff.compactionHeuristic::
> -       Set one of these options to `true` to enable one of two
> -       experimental heuristics that shift diff hunk boundaries to
> -       make patches easier to read.
> +       Set this option to `true` to enable experimental heuristics
> +       that shift diff hunk boundaries to make patches easier to read.
>
>  diff.algorithm::
>         Choose a diff algorithm.  The variants are as follows:
> diff --git a/Documentation/diff-heuristic-options.txt b/Documentation/diff-heuristic-options.txt
> index 36cb549df9..3cb024aa22 100644
> --- a/Documentation/diff-heuristic-options.txt
> +++ b/Documentation/diff-heuristic-options.txt
> @@ -1,5 +1,3 @@
> ---indent-heuristic::
> ---no-indent-heuristic::
>  --compaction-heuristic::
>  --no-compaction-heuristic::
>         These are to help debugging and tuning experimental heuristics
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 4ddfadb71f..395d4011fb 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2596,7 +2596,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>                  * and are only included here to get included in the "-h"
>                  * output:
>                  */
> -               { OPTION_LOWLEVEL_CALLBACK, 0, "indent-heuristic", NULL, NULL, N_("Use an experimental indent-based heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
>                 { OPTION_LOWLEVEL_CALLBACK, 0, "compaction-heuristic", NULL, NULL, N_("Use an experimental blank-line-based heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
>

The unchanged context line should have its description re-worded to
something like "Use an experimental heuristic to improve diffs" as it
no longer uses only blank lines.

Everything else looked correct.

Thanks,
Jake

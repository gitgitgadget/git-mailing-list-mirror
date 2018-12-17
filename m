Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6C531F405
	for <e@80x24.org>; Mon, 17 Dec 2018 09:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbeLQJbh (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 04:31:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52509 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeLQJbh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 04:31:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so11594315wml.2
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 01:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ABbeAinQ1k4+KolNUzmBW/yzkJmspFdvZIefsxAeE9Q=;
        b=nyA9tdQ5CAWx9ANJVQ/QlfG1Ljn2QaD5H7sQC+hFaoD4BUso/PVYLCdZQV+OQLGDav
         CznCAZ1SA+FOxobllrwuQQzCpKda36CRxuo/WrFwGu8O27PpC5vqaTKxwSbM1+JcCCVG
         iYvpQL6HccLTicHYsPjeet4AWqWgJlo/VTQsqvdjEzziK+GHquZkghi+VKNB5UG4vIpQ
         Kz48onT7J9+SGneEmcMjBm9sLMc46WYR7SnJ8ySgUMMuwyqH2DlfyeisuF2VkBBrft5U
         x+K11NG1mqpfs+A/eg7ujEW54at1ZzvODOU9K9LEfR/sCEstxSqroSEDUAbRGIGqpXLG
         la5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ABbeAinQ1k4+KolNUzmBW/yzkJmspFdvZIefsxAeE9Q=;
        b=MQpC9bGjXAfioeS9fmAnSI25jEsKezeFVpXATl2hOEXRRd5mxEcUEtHCeIjnhLiUAn
         rkWfSHT6ACEg20BCmQPfr2pnGjy6fju31HhsB1NM5OExeMRRnSq+09din4DbRdOLtASC
         95WzDCh1IDSXbDvW1DSPBa5levpBdouMRst5rUfoCyxHDvmqPM4W/vfM1VW0l44zVJ0Q
         NLwbhYC+wgMt+OCDAPTVSBFyU+nbjSlxl3l9DKbUmYlSJoLP8t4V8F1/ukAaZeKEBgX2
         jdn/QM8IL6ii5/Ax70tXodPxGaKYUo3XOxBywkYpbD7gsZv2/3Q3XKekh2odKF256liN
         xWyw==
X-Gm-Message-State: AA+aEWaopAo5X4K3x6WM+a3kLkn0NqWamzkKly5evWPUuGOXvonaMhTx
        y490LkJ+BoHvF3zAutrmz9A=
X-Google-Smtp-Source: AFSGD/W7FswCz0edaXHO85mm+EteEKG08s3MQIKph9lKwHQ8NKRtbNP8BeaqBadNRnR6BEbyi0x4QQ==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr10707289wmj.142.1545039094471;
        Mon, 17 Dec 2018 01:31:34 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g188sm10868342wmf.32.2018.12.17.01.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 01:31:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Issac Trotts <issac.trotts@gmail.com>
Cc:     git@vger.kernel.org, Noemi Mercado <noemi@sourcegraph.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
References: <CANdyxMwxPqTMfLsoK-2JT3Wf3hXZnQNCPRS04aSHzsMbYJZo-Q@mail.gmail.com>
Date:   Mon, 17 Dec 2018 18:31:33 +0900
In-Reply-To: <CANdyxMwxPqTMfLsoK-2JT3Wf3hXZnQNCPRS04aSHzsMbYJZo-Q@mail.gmail.com>
        (Issac Trotts's message of "Sun, 16 Dec 2018 22:25:14 -0800")
Message-ID: <xmqqk1k8bitm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Issac Trotts <issac.trotts@gmail.com> writes:

> Make it possible to write for example
>
>         git log --format="%H,%S"
>
> where the %S at the end is a new placeholder that prints out the ref
> (tag/branch) for each commit.
>
> Using %d might seem like an alternative but it only shows the ref for
> the last commit in the branch.

Have your sign-off here (see Documentation/SubmittingPatches),

and then have a line that only has three-dashes on it,

and then any other additional info like this.

>
> This change is based on a question from Stack Overflow:
> https://stackoverflow.com/questions/12712775/git-get-source-information-in-format
> ---




>  Documentation/pretty-formats.txt |  2 ++
>  builtin/log.c                    |  2 +-
>  log-tree.c                       |  1 +
>  pretty.c                         | 10 +++++++
>  t/t4205-log-pretty-formats.sh    | 50 ++++++++++++++++++++++++++++++++
>  5 files changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 417b638cd..acfe7e0a4 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -104,6 +104,8 @@ The placeholders are:
>
>  - '%H': commit hash
>  - '%h': abbreviated commit hash
> +- '%S': ref name given on the command line by which the commit was reached
> +  (like `git log --source`)

This looks entirely out of place, among the description of the basic
basic data like the object name of the commit itself, its tree, etc.

Describe this immediately after %d and %D are explained, perhaps.

> diff --git a/builtin/log.c b/builtin/log.c
> index e8e51068b..a314ea2b6 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -203,7 +203,7 @@ static void cmd_log_init_finish(int argc, const
> char **argv, const char *prefix,
>          rev->diffopt.filter || rev->diffopt.flags.follow_renames)
>          rev->always_show_header = 0;
>
> -    if (source) {
> +    if (source || (rev->pretty_given && rev->commit_format ==
> CMIT_FMT_USERFORMAT)) {

Broken line (you let your MUA line-wrap and corrupt your patch???)

>          init_revision_sources(&revision_sources);
>          rev->sources = &revision_sources;
>      }

This means anybody who asks for say --format='%aN %s' pays the price
of keeping track of each commit's source, which is unreasonable.

Perhaps mimick the way how presence of %N is detected in
userformat_want_item() so that we do not pay the price for
init_display_notes() when a format that does not care about %N is
given?

> @@ -1149,6 +1150,15 @@ static size_t format_commit_one(struct strbuf
> *sb, /* in UTF-8 */
>          parse_object(the_repository, &commit->object.oid);
>
>      switch (placeholder[0]) {
> +    case 'S':        /* tag/branch like --source */
> +        slot = revision_sources_at(c->pretty_ctx->rev->sources, commit);
> +        if (slot && *slot) {
> +            strbuf_addstr(sb, *slot);
> +            return 1;
> +        } else {
> +            die(_("failed to get info for %%S"));
> +            return 0;
> +        }

Have this next to case arms that deal with 'd' and 'D".

>      case 'H':        /* commit hash */
>          strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
>          strbuf_addstr(sb, oid_to_hex(&commit->object.oid));

This is a tangent, but I think this existing case arm should move to
the previous block before parsing the commit, as %H only needs the
object name of the commit itself (reword the comment before that
switch to read from "independent of the commit" to "computable
without parsing the commit")..

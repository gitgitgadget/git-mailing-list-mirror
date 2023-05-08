Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B897C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 23:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjEHXm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 19:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEHXm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 19:42:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862301FD4
        for <git@vger.kernel.org>; Mon,  8 May 2023 16:42:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9e50081556so9812395276.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683589374; x=1686181374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yjjXB+6Cs7koECOPmdpGe3sdCRxakXcFkwvZ1xYg0Ng=;
        b=3cdSYyLgoGgKQOpI6jcyVjCaxrNyJCBZpqqwdNmnI4ZixOXRnP5cLqr3GNR4spxTCX
         jU9Q1r6JhDM2PwnZPuh63tvA8ql4rFGlaF4DXpD6/XagV4loQYYx+0IMo51Qeq2oMdeI
         mqOVHlj8QpOp0BJshype5ZnR2251pCc3YdR/t/aU49x5jG1QnX7J7XmPR7wWX3M64w55
         gpDTgYkU8ZlCmcIn9rHURBd8k0ftizfgQnxGLN0+FGub8dgF4PYLsTROUXuL1cr/5IDd
         p58Lrp/MPoZ/70aCN5dqDqvx2jXMz4xKJj/s+nH4sE+2H29by56Jc5XI49+UQ/Uxob9U
         LpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683589374; x=1686181374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjjXB+6Cs7koECOPmdpGe3sdCRxakXcFkwvZ1xYg0Ng=;
        b=YY7TOM4bFXARq/TrkbJlhuPswuiE4shBUmunQoMS3tOwqlUAPytgIUfGX01fBmuDIo
         90pnp9WjKDat2yyvizqSA51O9dUNjTRVjqZDp8d413Zf26u94Q73FCjL1Lzl1sXmDFT9
         gUHK7tO+TyHVFZRf62Qnk2DPGIAss/8asUOqep1K/wqrTOmnCyckbrP3ocBNDIP4VcBw
         u/emC1eiQ3bOgWGhol9i6EM8m0xQhXzeEC5aNGAwuOXxuHyhpQQZ8APoLLh80BSUAaKN
         AeN2ltmShDNIAJDP+vQrnCuiV+EGxHeXQElfvjgbFBtroRtWmkdgPpl1NeC6nVv722OD
         uZMQ==
X-Gm-Message-State: AC+VfDxvIJADApVRQcSHbvs1TlmRelCL/Gf3QQtolsMeUlGYMldmQvCM
        taduYni4DZ2rt1v5aBlx80XmbF4H1JpaHg==
X-Google-Smtp-Source: ACHHUZ5kLSOHy2THOWx6dm7o/p0Zn0akvojAGSDaE8SjSal8INGA/EQ2KIhaRts7BBDvR0u7hVnlm6YfzArLdA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a5b:5c8:0:b0:ba1:919a:8f08 with SMTP id
 w8-20020a5b05c8000000b00ba1919a8f08mr5200674ybp.2.1683589373808; Mon, 08 May
 2023 16:42:53 -0700 (PDT)
Date:   Mon, 08 May 2023 16:42:46 -0700
In-Reply-To: <e132d9494ee7d8c4eb3a7a82b6420743c8c7a9b0.1683113177.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <cover.1683113177.git.ps@pks.im> <e132d9494ee7d8c4eb3a7a82b6420743c8c7a9b0.1683113177.git.ps@pks.im>
Message-ID: <kl6lild21jbd.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 8/8] fetch: introduce machine-parseable "porcelain"
 output format
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version looks great! I only have minor comments.

Patrick Steinhardt <ps@pks.im> writes:

> A notable ommission here is that the output format does not include the
> remote from which a reference was fetched, which might be important
> information especially in the context of multi-remote fetches. But as
> such a format would require us to print the remote for every single
> reference update due to parallelizable fetches it feels wasteful for the
> most likely usecase, which is when fetching from a single remote.
>
> In a similar spirit, a second restriction is that this cannot be used
> with `--recurse-submodules`. This is because any reference updates would
> be ambiguous without also printing the repository in which the update
> happens.
>
> Considering that both multi-remote and submodule fetches are rather
> niche and likely not going to be useful for the majority of usecases
> these omissions feel acceptable. If usecases for either of these come up
> in the future though it is easy enough to add a new "porcelain-v2"
> format that adds this information.

As a point of clarification, I think these options aren't niche in
themselves, but they are more user-facing, so using them _in conjunction
with_ --porcelain is probably pretty niche, so I think this is okay for
now.

> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -78,6 +78,12 @@ linkgit:git-config[1].
>  --dry-run::
>  	Show what would be done, without making any changes.
>  
> +--porcelain::
> +	Print the output to standard output in an easy-to-parse format for
> +	scripts. See section OUTPUT in linkgit:git-fetch[1] for details.
> ++
> +This is incompatible with `--recurse-submodules=[yes|on-demand]`.
> +
>  ifndef::git-pull[]
>  --[no-]write-fetch-head::
>  	Write the list of remote refs fetched in the `FETCH_HEAD`
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> index fba66f1460..f123139c58 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -204,6 +204,15 @@ representing the status of a single ref. Each line is of the form:
>   <flag> <summary> <from> -> <to> [<reason>]
>  -------------------------------
>  
> +When using `--porcelain`, the output format is intended to be
> +machine-parseable. In contrast to the human-readable output formats it
> +thus prints to standard output instead of standard error. Each line is
> +of the form:
> +
> +-------------------------------
> +<flag> <old-object-id> <new-object-id> <local-reference>
> +-------------------------------
> +
>  The status of up-to-date refs is shown only if the --verbose option is
>  used.

I hadn't commented on the docs before, but they are very clear. Thanks!

> @@ -1830,6 +1857,7 @@ struct parallel_fetch_state {
>  	const char **argv;
>  	struct string_list *remotes;
>  	int next, result;
> +	enum display_format format;
>  };
>  
>  static int fetch_next_remote(struct child_process *cp,
> @@ -1849,7 +1877,7 @@ static int fetch_next_remote(struct child_process *cp,
>  	strvec_push(&cp->args, remote);
>  	cp->git_cmd = 1;
>  
> -	if (verbosity >= 0)
> +	if (verbosity >= 0 && state->format != DISPLAY_FORMAT_PORCELAIN)
>  		printf(_("Fetching %s\n"), remote);
>  
>  	return 1;

Here and elsewhere, I wonder if it's clearer to name the variable
"porcelain" and separate it from "enum display_format". Then we can
check "porcelain" directly instead of using "format ==
DISPLAY_FORMAT_PORCELAIN" as a proxy...

> +static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
> +{
> +	enum display_format *format = opt->value;
> +	*format = DISPLAY_FORMAT_PORCELAIN;
> +	return 0;
> +}
> +
>  int cmd_fetch(int argc, const char **argv, const char *prefix)
>  {
>  	const char *bundle_uri;
> @@ -2104,6 +2140,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
>  		OPT_BOOL(0, "dry-run", &dry_run,
>  			 N_("dry run")),
> +		OPT_CALLBACK_F(0, "porcelain", &display_format, NULL, N_("machine-readable output"),
> +			       PARSE_OPT_NOARG|PARSE_OPT_NONEG, opt_parse_porcelain),
>  		OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
>  			 N_("write fetched references to the FETCH_HEAD file")),
>  		OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),

e.g. since we are reusing the "display_format" variable, we need to make
sure we parse "--porcelain" after we read "fetch.output". I
double-checked to make sure we were doing the right thing, though it
would be nice to not have to worry about those sorts of things. This
shouldn't hold up the series though.

> +test_expect_success 'fetch porcelain with multiple remotes' '
> +	test_when_finished "rm -rf porcelain" &&
> +
> +	git clone . porcelain &&
> +	git -C porcelain remote add second-remote "$PWD" &&
> +	git -C porcelain fetch second-remote &&
> +
> +	test_commit --no-tag multi-commit &&
> +	old_commit=$(git rev-parse HEAD~) &&
> +	new_commit=$(git rev-parse HEAD) &&
> +
> +	cat >expect <<-EOF &&
> +	  $old_commit $new_commit refs/remotes/origin/force-updated
> +	  $old_commit $new_commit refs/remotes/second-remote/force-updated
> +	EOF

The only thing in this test that relies on the previous test is that
HEAD is pointing to "force-updated", and it's hard to tell where HEAD is
since the previous test is so long. Could we create a new branch
instead?

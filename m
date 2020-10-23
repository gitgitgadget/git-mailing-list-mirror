Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2085C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE512192A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U18XcFLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750275AbgJWOGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465163AbgJWOGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:06:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB19C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:06:06 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c194so1606100wme.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dl3+rP9K9Lv0dwDHtiOgLXtgGiPqZfbXTysi/JUms6I=;
        b=U18XcFLAJhnM7bxZHFiwZtPQv9b5HlYz5hzl9y0N/z6FhEZTubzi+QVqdMGd2lQD4P
         DcNNhG/0x/yD0O4DPwoM0Zzk/MScm/9HufKdXsYQf4qOAh+Rw77ZqW3bC0TGAuVYh62x
         yJdbUNc77btIWu/vjUGlDMVdTdqd4fzbS5nNIvUHury2zsGd+BiSDKi0WuSoufyFegCb
         8RwlNLgJ3r3Bsx+3S61dZVh/GT73Agm9B7752ssOQcviXsC/veFuhzilrR/mZSvym0D8
         FI/BZJ0FgeIXsn/e32MeAJ0nIdyV+UCE6v9XtqZEAFc3GG1L8xW/5Bforh+cMWSXfKNS
         hVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Dl3+rP9K9Lv0dwDHtiOgLXtgGiPqZfbXTysi/JUms6I=;
        b=rwxSY8Y9WDQdRVb20do2ruXwcdrTXsWuUU2wZ5elYgOrBhsqblyou+yloLOFfsc9Jl
         lqYDE7wcmYTXqajAcQoS7SmQ/OaFBfQw1sS/y+WR4qTPM3q23lClNYSRrLGUtBHXxAPk
         Q7no/XVZgOjAoQekTehX028VNQr9Pj8P3y5avgy99I7VEHYH0v4t+omt988UkBIyK1SJ
         DNK46wntYibJjFDJHeKaWeLTqfmZ8nGhX+29g7i9Z8/Oqpvmc6/USwRfFeEmRMRpgAyn
         aOpoyaQetGeJW6efT79FxP6zjSlm+OzuO00qEYFNpUmEt7IWfIM/AnCR4/c5ro0oysMx
         Esgg==
X-Gm-Message-State: AOAM531/woaetjpAnJauo2hk3zQ+4mpCt6WWwL6WIIMvX2IkX98LCL+1
        DiLf3SpNPOH1DOg8m9RCvtAWiNp19DE=
X-Google-Smtp-Source: ABdhPJyaLyH6KNH2gdMBTm076XdQP9H+QWoxC38XS53Qw8YEObJGGmodUU4Z8KAlVnEmZQ01vKYT+Q==
X-Received: by 2002:a1c:e455:: with SMTP id b82mr1906468wmh.47.1603461964523;
        Fri, 23 Oct 2020 07:06:04 -0700 (PDT)
Received: from [192.168.1.240] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.gmail.com with ESMTPSA id p21sm3583708wmc.28.2020.10.23.07.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 07:06:03 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/3] am, sequencer: stop parsing our own committer ident
To:     Jeff King <peff@peff.net>, VenomVendor <info@venomvendor.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20201023070747.GA2198273@coredump.intra.peff.net>
 <20201023070939.GB2913115@coredump.intra.peff.net>
 <20201023072630.GA2918369@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9acc1d9f-7646-3ef9-b744-e47c4871873d@gmail.com>
Date:   Fri, 23 Oct 2020 15:06:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201023072630.GA2918369@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 23/10/2020 08:26, Jeff King wrote:
> On Fri, Oct 23, 2020 at 03:09:39AM -0400, Jeff King wrote:
> 
>> Commit e8cbe2118a (am: stop exporting GIT_COMMITTER_DATE, 2020-08-17)
>> rewrote the code for setting the committer date to use fmt_ident(),
>> rather than setting an environment variable and letting commit_tree()
>> handle it. But it introduced two bugs:
>>
>>    - we use the author email string instead of the committer email
>>
>>    - when parsing the committer ident, we used the wrong variable to
>>      compute the length of the email, resulting in it always being a
>>      zero-length string
> 
> By the way, I wondered why we needed to do this parsing at all. The
> patch below does this in a much simpler way. It's a little bit ugly, I
> think, because we have to call getenv() ourselves. But that's the way
> fmt_ident() has always worked. We could probably improve that now that
> it takes a whose_ident flag (before that, it had no idea if we wanted
> author or committer ident).
> 
> This is on top of the fixes (but we'd perhaps just want to do those on
> 'maint' as the minimal fix).
> 
> -- >8 --
> Subject: [PATCH 4/3] am, sequencer: stop parsing our own committer ident
> 
> For the --committer-date-is-author-date option of git-am and git-rebase,
> we format the committer ident, then re-parse it to find the name and
> email, and then feed those back to fmt_ident().
> 
> We can simplify this by handling it all at the time of the fmt_ident()
> call. We pass in the appropriate getenv() results, and if they're not
> present, then our WANT_COMMITTER_IDENT flag tells fmt_ident() to fill in
> the appropriate value from the config. Which is exactly what
> git_committer_ident() was doing under the hood.

Makes sense and it simplifies the code nicely

Thanks

Phillip

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   builtin/am.c | 19 +++----------------
>   sequencer.c  | 28 ++--------------------------
>   sequencer.h  |  2 --
>   3 files changed, 5 insertions(+), 44 deletions(-)
> 
> diff --git a/builtin/am.c b/builtin/am.c
> index 4949535a7f..52206bc56b 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -98,8 +98,6 @@ struct am_state {
>   	char *author_name;
>   	char *author_email;
>   	char *author_date;
> -	char *committer_name;
> -	char *committer_email;
>   	char *msg;
>   	size_t msg_len;
>   
> @@ -132,8 +130,6 @@ struct am_state {
>    */
>   static void am_state_init(struct am_state *state)
>   {
> -	const char *committer;
> -	struct ident_split id;
>   	int gpgsign;
>   
>   	memset(state, 0, sizeof(*state));
> @@ -154,14 +150,6 @@ static void am_state_init(struct am_state *state)
>   
>   	if (!git_config_get_bool("commit.gpgsign", &gpgsign))
>   		state->sign_commit = gpgsign ? "" : NULL;
> -
> -	committer = git_committer_info(IDENT_STRICT);
> -	if (split_ident_line(&id, committer, strlen(committer)) < 0)
> -		die(_("invalid committer: %s"), committer);
> -	state->committer_name =
> -		xmemdupz(id.name_begin, id.name_end - id.name_begin);
> -	state->committer_email =
> -		xmemdupz(id.mail_begin, id.mail_end - id.mail_begin);
>   }
>   
>   /**
> @@ -173,8 +161,6 @@ static void am_state_release(struct am_state *state)
>   	free(state->author_name);
>   	free(state->author_email);
>   	free(state->author_date);
> -	free(state->committer_name);
> -	free(state->committer_email);
>   	free(state->msg);
>   	strvec_clear(&state->git_apply_opts);
>   }
> @@ -1594,8 +1580,9 @@ static void do_commit(const struct am_state *state)
>   			IDENT_STRICT);
>   
>   	if (state->committer_date_is_author_date)
> -		committer = fmt_ident(state->committer_name,
> -				      state->committer_email, WANT_COMMITTER_IDENT,
> +		committer = fmt_ident(getenv("GIT_COMMITTER_NAME"),
> +				      getenv("GIT_COMMITTER_EMAIL"),
> +				      WANT_COMMITTER_IDENT,
>   				      state->ignore_date ? NULL
>   							 : state->author_date,
>   				      IDENT_STRICT);
> diff --git a/sequencer.c b/sequencer.c
> index d76cbded00..07321a7d95 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -314,8 +314,6 @@ int sequencer_remove_state(struct replay_opts *opts)
>   		}
>   	}
>   
> -	free(opts->committer_name);
> -	free(opts->committer_email);
>   	free(opts->gpg_sign);
>   	free(opts->strategy);
>   	for (i = 0; i < opts->xopts_nr; i++)
> @@ -1460,8 +1458,8 @@ static int try_to_commit(struct repository *r,
>   		} else {
>   			reset_ident_date();
>   		}
> -		committer = fmt_ident(opts->committer_name,
> -				      opts->committer_email,
> +		committer = fmt_ident(getenv("GIT_COMMITTER_NAME"),
> +				      getenv("GIT_COMMITTER_EMAIL"),
>   				      WANT_COMMITTER_IDENT,
>   				      opts->ignore_date ? NULL : date.buf,
>   				      IDENT_STRICT);
> @@ -4467,22 +4465,6 @@ static int commit_staged_changes(struct repository *r,
>   	return 0;
>   }
>   
> -static int init_committer(struct replay_opts *opts)
> -{
> -	struct ident_split id;
> -	const char *committer;
> -
> -	committer = git_committer_info(IDENT_STRICT);
> -	if (split_ident_line(&id, committer, strlen(committer)) < 0)
> -		return error(_("invalid committer '%s'"), committer);
> -	opts->committer_name =
> -		xmemdupz(id.name_begin, id.name_end - id.name_begin);
> -	opts->committer_email =
> -		xmemdupz(id.mail_begin, id.mail_end - id.mail_begin);
> -
> -	return 0;
> -}
> -
>   int sequencer_continue(struct repository *r, struct replay_opts *opts)
>   {
>   	struct todo_list todo_list = TODO_LIST_INIT;
> @@ -4494,9 +4476,6 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
>   	if (read_populate_opts(opts))
>   		return -1;
>   	if (is_rebase_i(opts)) {
> -		if (opts->committer_date_is_author_date && init_committer(opts))
> -			return -1;
> -
>   		if ((res = read_populate_todo(r, &todo_list, opts)))
>   			goto release_todo_list;
>   
> @@ -5391,9 +5370,6 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   
>   	res = -1;
>   
> -	if (opts->committer_date_is_author_date && init_committer(opts))
> -		goto cleanup;
> -
>   	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
>   		goto cleanup;
>   
> diff --git a/sequencer.h b/sequencer.h
> index b2a501e445..f925e349c5 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -50,8 +50,6 @@ struct replay_opts {
>   
>   	int mainline;
>   
> -	char *committer_name;
> -	char *committer_email;
>   	char *gpg_sign;
>   	enum commit_msg_cleanup_mode default_msg_cleanup;
>   	int explicit_cleanup;
> 

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE16AC74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 19:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCWT2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 15:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjCWT2D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 15:28:03 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D919D3C25
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:28:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso1907850wms.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679599680;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XSIYVk5xnbxb3n6GkdBwHjWwoo3x4fqZ826OThzhz1I=;
        b=EvTwcR7X1BGax1WC/jVrhk78wj+ctXclA6hDOe1ao6/eZ5fdye4hzsuP6QnTRua863
         6/IHlAGylpH8QWhY5Z1gTyQrM5ZmPT0hXmQ+XGgNi0DPjovMZsl96KRku091z8fWO9m5
         yuppxQBV7+HSNQKomZlLZcMqzOTsUA0zokkoyzpgU3gpZXowkrXA0URExPyFNx5bdI3i
         TYHfiN8h9zcpa5jhxIYHgV7lAFAxcHMTBHNqmX2x2rORLySkRb9gsSy9gaF4LZ+kxrtw
         SWcKFp8QAqCY/oJF/EPRgb4aopNCTInYRph5nyzcIEwoD9IEi9OeQYyubsZG30Fl/xyU
         UJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599680;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSIYVk5xnbxb3n6GkdBwHjWwoo3x4fqZ826OThzhz1I=;
        b=VUyphUmSFaDQcCmf8FbboCaW/7z+OuFqVG+5XhyEFb226Sbchse/0oDiU4I+CNmx/q
         6IwVNKq4CDh1wcXYEtkkiWRjpb2MCHBAoJVIKp3mPRAOhwOLX4XLKwiCZz4N8Uf4TgCe
         dTTLHX0SqiPGY0+rQtuBuyLdaOO7V+C+FhvsnULY16/aO0Fb9AywjjKOLR4BZjowumvK
         rDBU3DRqC/vPMglRpTPUUagni/n3ep5TEnWV8dtDIp2eLua+DIThH+6P2F0y1DN2FdwN
         Rdy4aOwbxiiK6VQgu016Wg+1Dcn8rMbzveS7hdTisPDkxeUQYC4Yb5+Me61y4FfqFeu4
         ClBA==
X-Gm-Message-State: AO0yUKUJjqk6CPNWSkKDgP7DKAfyeD45y/oRy1OTF+ayAuUO43iHojmR
        tgeNQ1pSYGbcrrEz81tv6Rw=
X-Google-Smtp-Source: AK7set/ZA1zXWIzeXaZAlhujeON+fdA/9WcfTPdqV5ukb0/GXt2Rbud7InD5UhKWt2LzNg2jEngn6A==
X-Received: by 2002:a7b:c384:0:b0:3ee:5d1d:6c4e with SMTP id s4-20020a7bc384000000b003ee5d1d6c4emr575356wmj.16.1679599680302;
        Thu, 23 Mar 2023 12:28:00 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id fm15-20020a05600c0c0f00b003ede3f5c81fsm2730496wmb.41.2023.03.23.12.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 12:28:00 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <81ad705d-beef-03d5-e56b-e25a0eccea1e@dunelm.org.uk>
Date:   Thu, 23 Mar 2023 19:27:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/8] sequencer: create enum for edit_todo_list() return
 value
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-5-oswald.buddenhagen@gmx.de>
In-Reply-To: <20230323162235.995574-5-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

This is a really useful cleanup

Thanks

Phillip

On 23/03/2023 16:22, Oswald Buddenhagen wrote:
> This is a lot cleaner than open-coding magic numbers.
> 
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
>   rebase-interactive.c | 15 ++++++++-------
>   rebase-interactive.h | 11 ++++++++++-
>   sequencer.c          |  8 ++++----
>   3 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index 111a2071ae..a3d8925b06 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -94,7 +94,8 @@ void append_todo_help(int command_count, enum rebase_action action,
>   	strbuf_add_commented_lines(buf, msg, strlen(msg));
>   }
>   
> -int edit_todo_list(struct repository *r, struct todo_list *todo_list,
> +enum edit_todo_result edit_todo_list(
> +		   struct repository *r, struct todo_list *todo_list,
>   		   struct todo_list *new_todo, const char *shortrevisions,
>   		   const char *shortonto, unsigned flags,
>   		   enum rebase_action action)
> @@ -123,37 +124,37 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
>   		return error(_("could not write '%s'."), rebase_path_todo_backup());
>   
>   	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
> -		return -2;
> +		return EDIT_TODO_FAILED;
>   
>   	strbuf_stripspace(&new_todo->buf, 1);
>   	if (action != ACTION_EDIT_TODO && new_todo->buf.len == 0)
> -		return -3;
> +		return EDIT_TODO_ABORT;
>   
>   	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo)) {
>   		fprintf(stderr, _(edit_todo_list_advice));
> -		return -4;
> +		return EDIT_TODO_INCORRECT;
>   	}
>   
>   	if (incorrect) {
>   		if (todo_list_check_against_backup(r, new_todo)) {
>   			write_file(rebase_path_dropped(), "%s", "");
> -			return -4;
> +			return EDIT_TODO_INCORRECT;
>   		}
>   
>   		if (incorrect > 0)
>   			unlink(rebase_path_dropped());
>   	} else if (todo_list_check(todo_list, new_todo)) {
>   		write_file(rebase_path_dropped(), "%s", "");
> -		return -4;
> +		return EDIT_TODO_INCORRECT;
>   	}
>   
>   	/*
>   	 * See if branches need to be added or removed from the update-refs
>   	 * file based on the new todo list.
>   	 */
>   	todo_list_filter_update_refs(r, new_todo);
>   
> -	return 0;
> +	return EDIT_TODO_OK;
>   }
>   
>   define_commit_slab(commit_seen, unsigned char);
> diff --git a/rebase-interactive.h b/rebase-interactive.h
> index d9873d3497..5aa4111b4f 100644
> --- a/rebase-interactive.h
> +++ b/rebase-interactive.h
> @@ -16,10 +16,19 @@ enum rebase_action {
>   	ACTION_LAST
>   };
>   
> +enum edit_todo_result {
> +	EDIT_TODO_OK = 0,         // must be 0
> +	EDIT_TODO_IOERROR = -1,   // generic i/o error; must be -1
> +	EDIT_TODO_FAILED = -2,    // editing failed
> +	EDIT_TODO_ABORT = -3,     // user requested abort
> +	EDIT_TODO_INCORRECT = -4  // file violates syntax or constraints
> +};
> +
>   void append_todo_help(int command_count, enum rebase_action action,
>   		      const char *shortrevisions, const char *shortonto,
>   		      struct strbuf *buf);
> -int edit_todo_list(struct repository *r, struct todo_list *todo_list,
> +enum edit_todo_result edit_todo_list(
> +		   struct repository *r, struct todo_list *todo_list,
>   		   struct todo_list *new_todo, const char *shortrevisions,
>   		   const char *shortonto, unsigned flags,
>   		   enum rebase_action action);
> diff --git a/sequencer.c b/sequencer.c
> index f05174d151..b1c29c8802 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6125,20 +6125,20 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   
>   	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
>   			     shortonto, flags, action);
> -	if (res == -1)
> +	if (res == EDIT_TODO_IOERROR)
>   		return -1;
> -	else if (res == -2) {
> +	else if (res == EDIT_TODO_FAILED) {
>   		apply_autostash(rebase_path_autostash());
>   		sequencer_remove_state(opts);
>   
>   		return -1;
> -	} else if (res == -3) {
> +	} else if (res == EDIT_TODO_ABORT) {
>   		apply_autostash(rebase_path_autostash());
>   		sequencer_remove_state(opts);
>   		todo_list_release(&new_todo);
>   
>   		return error(_("nothing to do"));
> -	} else if (res == -4) {
> +	} else if (res == EDIT_TODO_INCORRECT) {
>   		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
>   		todo_list_release(&new_todo);
>   

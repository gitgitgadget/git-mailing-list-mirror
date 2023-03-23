Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0ACC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 19:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCWTfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 15:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjCWTfE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 15:35:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4E819694
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:35:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o32so7907891wms.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679600100;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IHxT0ldiiTQKO6os5tt6GBy1mT6seKKjLqzEe6Co+qM=;
        b=az0GTRNMk6So+kBCcuxeVxRjwRqR0qaaOJbovpOd3vrz5Rtx60hPVw9KiO9d59VvV/
         95H2jXpYiEDQOIfYFTSQsIa6Wo9/HmIL0rI/LhRUX66K1luZCn/z9iYDF3m33DPgcIIk
         TNW0F5FZb/534brzfSRFkw38Z3E9qKrWJSiapdAo2Hbl+QzkxB2AcKz7fHk//8VZhD+V
         ryT7T5XTbDxctp9w89sjrWImtcX/xwJfTmqTts1yv2e702qZhfozNVGq+b6giq8UqpVw
         CKQ9+vHfseMVYftLYMXbvbQMa3z5Ftp1U3yHA3r8l/i0D02Q+lsGQT4Agh3y/G5Ohp4a
         q5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679600100;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHxT0ldiiTQKO6os5tt6GBy1mT6seKKjLqzEe6Co+qM=;
        b=SzbEtdv3IJQ8O7pe693098amneA22eentgvBsaJDP5sz0Li5lp/OlpmEclcBo8B9pC
         z2GBOKnoB1iKT8kcws3HdFnv53gmVIx//cYn928S116wye1J2I7nyX2SfJlDHxUxzWiX
         rcabu1LkeyJirX7/MuQEjH7vuZ+RIZjUZ6LbAN+Ap3llucI2svjWGZlTgR8xjgZp33Zo
         EIP9mN1djo4Q6iKXAjl+NKHRuIiKyIJ9MLUx2iib6KBnBGmKqZe/AabvqcIXeLTjaVPA
         gQQ3SJJ8z+cAeBOZR+K+nTGwp3i9MdEAxZioRWm8I/7fVSCjBfLMGa0I0cP+2FARRky6
         M8Og==
X-Gm-Message-State: AO0yUKXfC9IPCMsNKeaFu0eE+FXUnF5jtpVzX/lrXXhNfdsfjBaYSpQW
        07td2hVbs/MJ9GLm1gVL/Uk=
X-Google-Smtp-Source: AK7set93cjwlB7Eki08A6KiMHyhCdTlfdRmLlt95QMFwjE2pTjg/an69sYoCyt+Uu5vQgM489VaGiw==
X-Received: by 2002:a1c:791a:0:b0:3ed:e2e6:8ddb with SMTP id l26-20020a1c791a000000b003ede2e68ddbmr499738wme.35.1679600100330;
        Thu, 23 Mar 2023 12:35:00 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id c18-20020a7bc852000000b003ed2c0a0f37sm2733224wml.35.2023.03.23.12.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 12:35:00 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a3833d93-5db0-454e-526e-04681e5e5276@dunelm.org.uk>
Date:   Thu, 23 Mar 2023 19:34:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/8] sequencer: pass `onto` to complete_action() as
 object-id
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-8-oswald.buddenhagen@gmx.de>
In-Reply-To: <20230323162235.995574-8-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 23/03/2023 16:22, Oswald Buddenhagen wrote:
> ... instead of as a commit, which makes the purpose clearer and will
> simplify things later.

given that we want onto to be a commit I'm not sure how this makes 
anything clearer.

> As a side effect, this change revealed that skip_unnecessary_picks() was
> butchering the commit object due to missing const-correctness. Slightly
> adjust its API to rectify this.

I don't think this is correct. If you look at the original code it makes 
a copy of the oid and uses the copy when calling skip_unnecessary_picks()

>   int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
>   		    const char *shortrevisions, const char *onto_name,
> -		    struct commit *onto, const struct object_id *orig_head,
> +		    const struct object_id *onto, const struct object_id *orig_head,
>   		    struct string_list *commands, unsigned autosquash,
>   		    unsigned update_refs, struct todo_list *todo_list,
>   		    enum rebase_action action)
>   {
>   	char shortonto[GIT_MAX_HEXSZ + 1];
>   	const char *todo_file = rebase_path_todo();
>   	struct todo_list new_todo = TODO_LIST_INIT;
>   	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
> -	struct object_id oid = onto->object.oid;

Here we copy the onto's oid

> @@ -6158,7 +6157,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   		BUG("invalid todo list after expanding IDs:\n%s",
>   		    new_todo.buf.buf);
>   
> -	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid)) {

Here we pass the copy to skip_unnecessary_picks()

Best Wishes

Phillip

> +	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &onto)) {
>   		todo_list_release(&new_todo);
>   		return error(_("could not skip unnecessary pick commands"));
>   	}
> @@ -6171,7 +6170,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   
>   	res = -1;
>   
> -	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
> +	if (checkout_onto(r, opts, onto_name, onto, orig_head))
>   		goto cleanup;
>   
>   	if (require_clean_work_tree(r, "rebase", NULL, 1, 1))
> diff --git a/sequencer.h b/sequencer.h
> index a1b8ca6eb1..24bf71d5db 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -188,7 +188,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>   
>   int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
>   		    const char *shortrevisions, const char *onto_name,
> -		    struct commit *onto, const struct object_id *orig_head,
> +		    const struct object_id *onto, const struct object_id *orig_head,
>   		    struct string_list *commands, unsigned autosquash,
>   		    unsigned update_refs, struct todo_list *todo_list,
>   		    enum rebase_action action);

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563B9C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 11:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345785AbiEZLRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 07:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiEZLRh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 07:17:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19B19858D
        for <git@vger.kernel.org>; Thu, 26 May 2022 04:17:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j25so1737911wrb.6
        for <git@vger.kernel.org>; Thu, 26 May 2022 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OZozo1sVaUNYNJS4cpUsYlfwMSGnb4LTKjchCBFQEOg=;
        b=nvyw+2fbJ6/QurO5KNq0P2F0sdQkoCRAMDb+4Oja3vubAfL6D0Um8pMdQA/WuT8BLB
         TSGAOxJ2Zv4QgSwKrRYoAHb9rI0qwGbMmM4de3MIh9vewnmYok9iwD3Dv1J9e52aYdOA
         /R58zEjcd6ksscqgeiEdvewnZl4mbVUclfMTPrXyPvUcNDa60uy0qqBrPM349CGpG+bN
         DSZk4mGDrXMvLuVBrjEPWwqALOSV4dg7BTfTwiStD7J5M+pUuBwFbXnYs7L2eNPsNU0/
         x3R3O9gAc4ARX5x9Q920bC2xn1b4KClEigJQhp2a/sGlbPJskYKXtEAfuaRJZA3A8X66
         PzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OZozo1sVaUNYNJS4cpUsYlfwMSGnb4LTKjchCBFQEOg=;
        b=c5rQ+XIRmxMhQrc4grF3OmSCEC/otJXXnmS+YOOjGy6x5QcjLSEtxmFI7VwePDRIUv
         QHuoJM3hpQLrSL4fYO9Q8xS4yl0L9+84Ll+RVlgMzemb7C3t15DbTD8saCucRRbRcur8
         XEUNLizK3XZGWKmjnwYy141l5E7HM52gG+Vl/kU0kcMt+nXXlm5gBqnFjbGbQp/y23Nv
         EGT1zF0zfXGEhXOyYeZ9iFsuLEyfe8eEmNvPr4eh4m9Zu5IvTbs0SOMKpS4I6PQ0p0Un
         S9/MwndJ/DKKvpux1sr5ljAbZiNrsEKd9QF1AXADdNUw3e5Xw2wKJyMrczkkJXGYL4Os
         raoQ==
X-Gm-Message-State: AOAM530Oa8ueLxwGfekjjdJNJ0wO676kosF/956jWu9KxqcoeZb+1xW+
        P5G5C4ZBpv9HcGLncxii14Q=
X-Google-Smtp-Source: ABdhPJxBY3gDwzLBPA3jx0UYitFFJCIe83mfCV4dNaBx7hp6RIA4E+w+oN+eXDWeZoa45hL8bYFUMQ==
X-Received: by 2002:adf:f704:0:b0:210:b35:3b31 with SMTP id r4-20020adff704000000b002100b353b31mr2110477wrp.200.1653563855070;
        Thu, 26 May 2022 04:17:35 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id i7-20020a1c3b07000000b003944821105esm1619330wma.2.2022.05.26.04.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 04:17:34 -0700 (PDT)
Message-ID: <4c8ea23d-1a1d-efd4-6c11-7c08f8728d59@gmail.com>
Date:   Thu, 26 May 2022 12:17:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revert: optionally refer to commit in the "reference"
 format
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsfp2b30k.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqsfp2b30k.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 22/05/2022 05:32, Junio C Hamano wrote:
> A typical "git revert" commit uses the full title of the original
> commit in its title, and starts its body of the message with:
> 
>      This reverts commit 8fa7f667cf61386257c00d6e954855cc3215ae91.
> 
> This does not encourage the best practice of describing not just
> "what" (i.e. "Revert X" on the title says what we did) but "why"
> (i.e. and it does not say why X was undesirable).
> 
> We can instead phrase this first line of the body to be more like
> 
>      This reverts commit 8fa7f667 (do this and that, 2022-04-25)
> 
> so that the title does not have to be
> 
>      Revert "do this and that"
> 
> We can instead use the title to describe "why" we are reverting the
> original commit.
> 
> Introduce the "--reference" option to "git revert", and also the
> revert.reference configuration variable, which defaults to false, to
> tweak the title and the first line of the draft commit message for
> when creating a "revert" commit.

I think this is a good idea which will hopefully improve project histories.

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 51776abea6..ada51e46b9 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -116,6 +116,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   			N_("option for merge strategy"), option_parse_x),
>   		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
>   		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> +		OPT_BOOL(0, "reference", &opts->commit_use_reference,
> +			 N_("use the 'reference' format to refer to commits")),

This option is being added to base_options which applies to cherry-pick 
as well as revert. There is a "if" statement just below this hunk which 
adds cherry-pick specific options, I think we want to add this new 
option in an else block added to that "if" statement.

>   static int do_pick_commit(struct repository *r,
>   			  struct todo_item *item,
>   			  struct replay_opts *opts,
> @@ -2167,14 +2184,19 @@ static int do_pick_commit(struct repository *r,
>   		base_label = msg.label;
>   		next = parent;
>   		next_label = msg.parent_label;
> -		strbuf_addstr(&msgbuf, "Revert \"");
> -		strbuf_addstr(&msgbuf, msg.subject);
> -		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
> -		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
> +		if (!opts->commit_use_reference) {
> +			strbuf_addstr(&msgbuf, "Revert \"");
> +			strbuf_addstr(&msgbuf, msg.subject);
> +			strbuf_addstr(&msgbuf, "\"");
> +		} else {
> +			strbuf_addstr(&msgbuf, "DESCRIBE WHY WE ARE REVERTING HERE");

In format-patch we add three asterisks to the beginning and end of the 
dummy subject and body lines to encourage the user to edit them - is 
that worth doing here as well?

Best Wishes

Phillip

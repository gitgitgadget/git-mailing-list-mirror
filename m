Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4344C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245398AbiDAP4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357433AbiDAPig (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 11:38:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A913E8AE57
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 08:14:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j18so4720310wrd.6
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eK3J3oLmx4Vb5BxZBKcAY8yR+BdG1ghdip/+zI32gSc=;
        b=NbEdyCuXSaMRBObDSYZHBxY/tuSo3SE5dnWyaOSCcDI7dNMUogK4ynnlp5j9VwGasT
         OgO4qofx/N1mu2VOJZt0Vt9mrOYjazZ7wW1vTMZB7noG2ROQIZStWHTxjBz7J1b59UVL
         MAzW5x9haWs/Vga39bT1KAVjKkRM6Q2DdSQ/mB2D/F7XY8a0T3mQoV8JyxhkL10K8jEt
         v8VZonTIhCXe7NXJ9KHkwdJsUmCZcu+iQLIz70+VIfeACtnov9NEGSrPgfZnE5jaVCOg
         ZOg1UOlH24qC+MbO9HdhlEPaRbidcUgZU4wrfrgKA7b7KL3Cn72u8XxqcXANUtXMbQ0g
         ygIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eK3J3oLmx4Vb5BxZBKcAY8yR+BdG1ghdip/+zI32gSc=;
        b=4BSW8iGwvEu7GIHS8geggdUylOUtFJKPMcEwPhJt75GHdGM4gV4JcgmgU+KxLjN7xu
         kjrvcL25CIPJS+9oqODFNTfN2k1VL98lWv0Mea3PBJp0ggABD0HYkWqRcNgvK+0uku4N
         tewjasKUGuZ3n1+A1thKTkwB4lzthezjQYG5y6ndYaC33WOQtO/0smfUfNmg/9YVDdx5
         BRFXEFtRImV7+VJQvzDp4OX+YvZyxk7S9PZHjItfAvEeWZF5n+P/uuWshcCPtiLG4bJn
         ip8gKrnu5GW7fw1uqJ+7xP6TEmumd21+d5u4DAUssZ4n8qD34OqPejoBNtMJGpRVh+1H
         eNbA==
X-Gm-Message-State: AOAM533LLgvyXLQjyd0v8sOFvhuL78pQu0vULoK1YRTlZW5ijp/hcWzT
        heX7PCn+w1gChHSGiYHWk2A=
X-Google-Smtp-Source: ABdhPJxKXFTudIxvitgRpD15g2r96APa5L0xoacWKSMO0dqcchdADuae7MZx14zckM572haWYCSBdg==
X-Received: by 2002:a05:6000:1868:b0:204:1e4f:7f9a with SMTP id d8-20020a056000186800b002041e4f7f9amr8277515wri.106.1648826032501;
        Fri, 01 Apr 2022 08:13:52 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm2106581wmq.46.2022.04.01.08.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 08:13:52 -0700 (PDT)
Message-ID: <851584aa-a31d-7446-4994-e641f298f0cd@gmail.com>
Date:   Fri, 1 Apr 2022 16:13:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 04/27] format-patch: don't leak "extra_headers" or
 "ref_message_ids"
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <patch-v4-04.27-69f0aabe38f-20220331T005325Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v4-04.27-69f0aabe38f-20220331T005325Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 31/03/2022 02:11, Ævar Arnfjörð Bjarmason wrote:
> Fix two memory leaks in "struct rev_info" by freeing that memory in
> cmd_format_patch(). These two are unusual special-cases in being in
> the "struct rev_info", but not being "owned" by the code in
> revision.c. I.e. they're members of the struct so that this code in
> "builtin/log.c" can pass information code in log-tree.c.

I'm not sure that I necessarily agree that these are owned by 
builtin/log.c. For rev.extra_headers it is set in builtin/log.c but 
never used there which makes me think we are transferring ownership to 
struct rev_info. For ref_message_ids it is less clear cut but having it 
owned by struct rev_info and freeing it in release_revisions() would 
make things clearer I think. Having some members owned by struct 
rev_info but others allocated and freed by other code is confusing and 
is likely to lead to memory errors. I don't think struct rev_info is 
borrowing a reference to these items as they are being allocated for 
it's exclusive use.

Best Wishes

Phillip

> See 20ff06805c6 (format-patch: resurrect extra headers from config,
> 2006-06-02) and d1566f7883f (git-format-patch: Make the second and
> subsequent mails replies to the first, 2006-07-14) for the initial
> introduction of "extra_headers" and "ref_message_ids".
> 
> We can count on repo_init_revisions() memset()-ing this data to 0
> however, so we can count on it being either NULL or something we
> allocated. In the case of "extra_headers" let's add a local "char *"
> variable to hold it, to avoid the eventual cast from "const char *"
> when we free() it.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/log.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index 634dc782cce..6f9928fabfe 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1747,6 +1747,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   	struct commit *commit;
>   	struct commit **list = NULL;
>   	struct rev_info rev;
> +	char *to_free = NULL;
>   	struct setup_revision_opt s_r_opt;
>   	int nr = 0, total, i;
>   	int use_stdout = 0;
> @@ -1947,7 +1948,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   		strbuf_addch(&buf, '\n');
>   	}
>   
> -	rev.extra_headers = strbuf_detach(&buf, NULL);
> +	rev.extra_headers = to_free = strbuf_detach(&buf, NULL);
>   
>   	if (from) {
>   		if (split_ident_line(&rev.from_ident, from, strlen(from)))
> @@ -2284,6 +2285,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   	strbuf_release(&rdiff1);
>   	strbuf_release(&rdiff2);
>   	strbuf_release(&rdiff_title);
> +	free(to_free);
> +	if (rev.ref_message_ids)
> +		string_list_clear(rev.ref_message_ids, 0);
> +	free(rev.ref_message_ids);
>   	UNLEAK(rev);
>   	return 0;
>   }

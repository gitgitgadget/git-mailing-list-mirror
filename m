Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ED1C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 09:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbiF3JkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 05:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiF3JkG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 05:40:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08599FC0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 02:40:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lw20so37901510ejb.4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PuT+YgJOtZYvM+N+GUmWlR419lZWKTxXhMVHBMYht/Y=;
        b=cIUAX2hqqMPMWFrvDam+Guj6dWnztzcl69/UtOChI9OOzOnRkbtcFif6jzlwpTVtM/
         b5LSjbw7UMpFuscb6q/jfXKNWTXbc2HVw+OmcFfB/941xSQPBPfkbXcoajSjWS3FvmfL
         C1tgSbIalioJ4D5DdK5HKBkyjxgPH9hKQLiHCIWpBqOJpCJ2tRTGyrtPVjeUnQmuweOw
         M+/jxtE0J4xtZtYjskCFu/F2i7v3b7KgrvSb29KrtKdWNIbCnKdI1ikOkSna9a88QkKQ
         fpsmAV0Hpj0GZZwjFBOVnGF0dp4kKL5G5+rOgIFa4zAqw/QAAgpDsWKqyiOLvd+aQGin
         r1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PuT+YgJOtZYvM+N+GUmWlR419lZWKTxXhMVHBMYht/Y=;
        b=keu9xzyUNa9UBEP4OtUJutqm5FQOaznZVtzy8u03LsuPJgY3oRak1+SyplUOz93jh5
         X7q/iBci1X+VNuZ6Zx6yMiHNVCnCF6zWxZtj3YhJ4BcPyjZ9AZtGthE5Ht1Vwt5GEEH4
         xueufsLuqEZyHB0+hZCYJdvSt/nUvIqls6MQQ+6S8m7SKyBcPSyNkg2sj9qhrDGtF0fn
         Nn0OEu0TlxMoFwGgzk2ZM5KE4seHZs7eb1bJ9SeKfgKfQEZigyUWOc9laDrK7Nttqhup
         rnW95R+NVaISYDCSjPENIUrSdvSCeLTpOy4XZbGdVbVeJ17woqyB/J2Nl6r7FsE+/b1e
         Y5nQ==
X-Gm-Message-State: AJIora+7gjM4PTHvGvgm1q3ZcQg3xadFOY5TD48eVRqnVRKlYI6PvEUz
        6BfPM9OdOayDwYkGGL+Cvuc=
X-Google-Smtp-Source: AGRyM1tTSXmR3fLmay/OcxGGZ/zsYlvIgbA2jyQRBjeB7xfCUZPbJf14hWwRx1LK0d/23eb8EibAPg==
X-Received: by 2002:a17:907:d19:b0:726:c8a0:c9ef with SMTP id gn25-20020a1709070d1900b00726c8a0c9efmr8080938ejc.435.1656582001232;
        Thu, 30 Jun 2022 02:40:01 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id jx20-20020a170907761400b00722e203633esm8676787ejc.122.2022.06.30.02.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 02:40:00 -0700 (PDT)
Message-ID: <1ce55924-c151-3d27-90d6-82fed92a4d91@gmail.com>
Date:   Thu, 30 Jun 2022 10:39:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/8] sequencer: add update-ref command
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <e95ad41d3551244ea98c43145a089ecfd2536e54.1656422759.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <e95ad41d3551244ea98c43145a089ecfd2536e54.1656422759.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/06/2022 14:25, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> Add the boilerplate for an "update-ref" command in the sequencer. This
> connects to the current no-op do_update_ref() which will be filled in
> after more connections are created.
> 
> The syntax in the todo list will be "update-ref <ref-name>" to signal
> that we should store the current commit as the value for updating
> <ref-name> at the end of the rebase.
> 
> [...]
> @@ -4431,6 +4437,12 @@ static int pick_commits(struct repository *r,
>   				return error_with_patch(r, item->commit,
>   							arg, item->arg_len,
>   							opts, res, 0);
> +		} else if (item->command == TODO_UPDATE_REF) {
> +			struct strbuf ref = STRBUF_INIT;
> +			strbuf_add(&ref, arg, item->arg_len);

It's a bit of a shame we have to faff here just to get a NULL terminated 
string. It does not matter but using xmemdupz() & free() would be one 
less line.

> +			if ((res = do_update_ref(r, ref.buf)))
> +				reschedule = 1;

Rescheduling here is good

Best Wishes

Phillip

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1784C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B7A619CB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhC3VcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 17:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhC3Vbr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 17:31:47 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12977C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 14:31:47 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so16959451oto.2
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 14:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MgmoeBhP2gEFtPDTbAygpMA2eIAt8ugg0+XE5pRg0pk=;
        b=W5UWYd/kt5J9+Ozn+qLAxuuCIgCCXP+UHylLB6eqp3DUNVGoVFtWx39S1u2fPG6i2e
         uqjgHSoHH05/3EZYZxmd5GSMn+rrOxYaP/V8sfEtRbccwbID2LLabuKEZ+RfgwRMriWQ
         w1GGP8TWnzEt6B+n/ni0MT/2PnoZ7ZoPkopFo+LvqqgfDoxy79q52LiEKyesL7LoZEjM
         EkzCodTwXV8u6XQ35ZXPjhBaXp7lAfbEGzECk9HTxlkmMgZ8bA9VyhQyZMV2ry/XRYab
         qEnnSwUvEHcSvQrUAFqhcxTVolj3x7RbyQgfHd1z2/LSj/BKfVtMaPEQl8lH9nVnIYfY
         ADnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MgmoeBhP2gEFtPDTbAygpMA2eIAt8ugg0+XE5pRg0pk=;
        b=g77cQZMhjquCnUxR1mP34xFnINTw3IJeihkGSp8C0zQaMWhKNb9AgpXu+CFbKUtGu8
         48W0rvMiy2/dd3xWq33zpyS8ivWfPzsUPkp4Qjl9GoDCPDUJYHgqSGWjjpL54mnt/Go3
         Qpz8trB0pLdxqjNuRzvsSVJcFJGoPABpmCaC/Ampp6cUs08maZ6x5sCuuz2sEmr+hTba
         3FG3n11+00ChdXiLc4imNKITZOMJXEhLwms2fZXI/gsTJqwpS9uBD15yDqzcYlECz4VK
         UJ9sOO0FN+5+mXhpPEdEAswLKY9xbLhyHuNo7YOn5WaMtK8oSt/MZRJP9aLsjiQc/qtO
         Yo2Q==
X-Gm-Message-State: AOAM530Vy6xkN4cr9I9IUd5sUsuMHUYBTmdXkBHP+XTualdE6OSWgwUM
        l4OU1WxYfi1TeIwLQXIZ2yTtDK9rCeSerg==
X-Google-Smtp-Source: ABdhPJwA1VJPDYUoWgyiPhncqTkCqMSIqawO/KZkbsFfYIrQ/AY7MpBXaNwkV2JhNN1ZrzJmI9yBcg==
X-Received: by 2002:a05:6830:204e:: with SMTP id f14mr18186734otp.38.1617139906306;
        Tue, 30 Mar 2021 14:31:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:51d7:1436:793b:b3c9? ([2600:1700:e72:80a0:51d7:1436:793b:b3c9])
        by smtp.gmail.com with ESMTPSA id g5sm57852oiy.24.2021.03.30.14.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 14:31:45 -0700 (PDT)
Subject: Re: [PATCH v5 00/21] Sparse Index: Design, Format, Tests
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
 <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
 <xmqqsg4ccsgd.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0a2e3028-8ebe-86be-d55d-b96aefb1ee53@gmail.com>
Date:   Tue, 30 Mar 2021 17:31:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqsg4ccsgd.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/30/2021 4:11 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>      @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
>>       +	 * Initialize this as off.
>>       +	 */
>>       +	r->settings.sparse_index = 0;
>>      -+	if (!repo_config_get_bool(r, "extensions.sparseindex", &value) && value)
>>      ++	if (!repo_config_get_bool(r, "index.sparse", &value) && value)
>>       +		r->settings.sparse_index = 1;
>>        }
> 
> It would be helpful to have a way for the repository owner to say
> "Even if the version of Git may be capable of handling 'sdir'
> extension, and my checkout uses sparse-cone settings, I do not want
> to use it", and the other way around, i.e. "Even if my checkout
> currently does not use sparse-cone settings, do use 'sdir'
> extension".  But for that, .sparse_index member may need to be
> tristate (i.e. forbidden, enable-if-needed, use-even-unneeded)?

I believe as presented, index.sparse=false will prevent the sdir
extension from being used. If index.sparse=true, then it will only
be used if sparse-checkout is enabled in cone mode.

I don't see the value in using the 'sdir' extension when not using
sparse-checkout in cone mode (and hence there are no sparse directory
entries in the index). What am I missing?

> We have a similar setting in index.version; I believe we always
> auto-demote 3 down to 2 when extended flags are not used, and
> I think "always auto-demote" would be sufficient (iow,
> "use-even-unneeded" may not be necessary, even though that might
> help debugging).

Yes, the same is happening here: we auto-demote to not use 'sdir'
if it the other settings are not configured as well.

There is the rare scenario where these things all occur:

1. index.sparse = true
2. core.sparseCheckout = true
3. core.sparseCheckoutCone = true
4. Every path in the index matches the cone-mode patterns.

In this case, convert_to_sparse() is called and the istate->sparse
bit is set, telling do_write_index() to add the 'sdir' extension.

This seems like a rare occurrence. Is it still worth adding logic
to avoid 'sdir' when these are all true?

Thanks,
-Stolee

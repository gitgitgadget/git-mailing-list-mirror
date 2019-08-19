Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D23A51F461
	for <e@80x24.org>; Mon, 19 Aug 2019 12:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfHSMnd (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 08:43:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36586 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfHSMnd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 08:43:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id z4so1678688qtc.3
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nlvXl0TJEnzc6YGXsRJjL96wmquBKO5mtEkjzMGp1CQ=;
        b=mxpEOXAhCNMWPoIRNgGmpiBUCl05GhAqFbi7YBp1AsC1kN1J/+uovihZc+AL/4QNW/
         ZaF+MZypv+KE+AYwrV2Epm2bpcI1J78QJkug+aNVVFotrIycyF4RN3MbssGoMudznoGV
         GDx70KyJ4BVbky0HkVlpXyeqLAZH9fSiZQkLMieyYmUl96QuZtoILxAg7irY6OL72eOz
         1r9GAMzqgtnV0S/uEfNWC06ZFpSG6wGpQLb4CLRR7lkjuhCHrgGJaODUJnu8Ql3A8ccp
         syko/ZdfpGk4jK2LLRxThtiIB91wZmnTcQ1ND9cWQMCymzB0HD6TrcGYIDmuyAKu1NY9
         VqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nlvXl0TJEnzc6YGXsRJjL96wmquBKO5mtEkjzMGp1CQ=;
        b=GueNONCU35hehmZfz/KD6zbk0FZttp0uOfQUPKP/S+oZpJ0Q0fVBbFbUcn3sCY9pAG
         lBqTlxse04SPBEDG2dZosMrJJGKtlVKOyhMbvGLbsfE73dQtv4aZirVmhH5z+w/qh58l
         Zp5fi3MTDMfJczGZdiD2/hFJ+DFCNwtwdWaIMgrGDeaGEOV5N2e9qAkECq0g9WrPHz8a
         os3/ZMb7woHF4BmeWyJWoZcOrflA4pKRvXmGgUQPQn9i6C9Dzr2rNv6fsSL1mhGB04VN
         o4ex9lO0SkiUE9WmaKUW+bVAeIEdwYXO0cg1slj6m03+mnKmFFHCjlIvsGuwPY5h9xTL
         aV3Q==
X-Gm-Message-State: APjAAAXvhIbAzdzIroml04yXKwrdJzHaFWyHEjYt++8TTVF9rBFvd5+7
        oMGBGfp2RJLc+cYqzbkpTmk=
X-Google-Smtp-Source: APXvYqxUNtqbQ1NqWhjQKNjUGm36ig+uAnhu2vVZDUilGVrQETQ2iUZ3Md11ofPb/SS8ISQToH3xpQ==
X-Received: by 2002:aed:3826:: with SMTP id j35mr19795928qte.54.1566218612538;
        Mon, 19 Aug 2019 05:43:32 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3cc4:beea:5454:ae58? ([2001:4898:a800:1010:edf9:beea:5454:ae58])
        by smtp.gmail.com with ESMTPSA id h2sm6854479qto.81.2019.08.19.05.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 05:43:31 -0700 (PDT)
Subject: Re: [RFC PATCH 4/5] line-log: more responsive, incremental 'git log
 -L'
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
 <20190818182801.7580-5-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <db9984f2-1f5d-efef-2bf6-689e3b440d26@gmail.com>
Date:   Mon, 19 Aug 2019 08:43:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190818182801.7580-5-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2019 2:28 PM, SZEDER Gábor wrote:
> To be clear: this patch doesn't actually optimize the line-level log,
> but merely moves most of the work from the preprocessing step to the
> history travelsal, so the commits modifying the line range can be

s/travelsal/traversal/

-Stolee

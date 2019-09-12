Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E568B1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 12:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbfILMrA (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 08:47:00 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44212 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbfILMq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 08:46:59 -0400
Received: by mail-yb1-f195.google.com with SMTP id y21so8596463ybi.11
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LReSjDhybwb563xQDlPiN/UGvlFgJfcbQ9R8/6tXEEU=;
        b=R6COKDjlaHnmmLXNVVOOPvEei8iR8rqypkUOzR7AfLF5Ijp+bE+ulRvWS+PKmEXoLe
         DyBNRx9LKFzRo4wnxw7khJGR4aRiQT0Ksz0887buSv74CKbp+efS/F0jQwkwPkLtFTal
         1fvBQiI0oCwslcrDDHqTfDmGqo9Zs1OzNDNxHWKwMLAaAmcL0NxwVCexEx8CCQmkAtXd
         xUcFaHNm3eENyQLh6gltI8c1GB2wqV190uyEHy2ArUH19R8jyUFwoMtlq7s427vn3MF/
         mbVMsmYJOKb32xAMEpVbujpCY6URp1nnll8scgy5Y46j85lVoCD5EKyed7pZY6RasxjX
         YX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LReSjDhybwb563xQDlPiN/UGvlFgJfcbQ9R8/6tXEEU=;
        b=Hz2Jdb4740kG7aV2DGxU/oO0hQ/7Az9tJ/77B5od5HVn7ZP/0sdKldngP6cqkaKks9
         nvPWgk9Lhl5cTCYEPCx4bUcy5Zb7+3Z4yUylXVMfvSdeTnHyp6LejaG9hOl1Rqtaigsz
         K9Pqwsxy6a0JEHXNbYkcOVqDzOqiO8D7MiWRwih5zD9ZEdE0uevjkQkYV7VdzDQXpZN+
         DU0WPetZZG5qBfYReCBG9HCqzd/kbJZkAVD1b+yNKvvDgFXWqkm+tlY63nhMvwX/cGlo
         hmW65cgPlr+D5rF0lsJqV4NT63yQwhgB9rW/Wkzk9FiRX+K436amrk/WsZ3md6osvnPf
         guAA==
X-Gm-Message-State: APjAAAVm0ZruCVaUuIeoQIB6NK9kfEK1L3znQ6ZMMNUZVpq3eOl0SpEJ
        G7aoQalPtCiSix6Nh1f6OjY=
X-Google-Smtp-Source: APXvYqx/vCldkyGJceG5U/qlJgWs0doz7QPFIyqqoOLhcia1cOFKCpOlOkMwb7q9Ai+eYUT9roAO+Q==
X-Received: by 2002:a25:6b05:: with SMTP id g5mr1650436ybc.237.1568292418882;
        Thu, 12 Sep 2019 05:46:58 -0700 (PDT)
Received: from [192.168.1.9] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id h19sm4906786ywi.33.2019.09.12.05.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 05:46:58 -0700 (PDT)
Subject: Re: [PATCH] upload-pack: disable commit graph more gently for shallow
 traversal
To:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20190912000414.GA31334@sigill.intra.peff.net>
 <20190912020748.GA76228@syl.lan>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6eb22830-a887-8bbe-412e-7ddb531d196a@gmail.com>
Date:   Thu, 12 Sep 2019 08:46:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190912020748.GA76228@syl.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2019 10:07 PM, Taylor Blau wrote:>>
>> +# A few subtle things about the request in this test:
>> +#
>> +#  - the server must have commit-graphs present and enabled
> 
> I think "enabled" may be somewhat redundant, at least since some recent
> changes to enable this by default. (As an aside, I tried to dig up the
> patches that Stolee sent to actually enable this and back up my claim,
> but I couldn't find them on 'master'. I'm not sure if that's my poor use
> of 'git log', or misremembering the fact that these were enabled by
> default.)

Commit 31b1de6 ("commit-graph: turn on commit-graph by default" 2019-08-13)
is part of ds/feature-macros and seems to be in master (at least in gitster/git).

Having core.commitGraph=true does very little if the commit-graph is not
written, but gc.writeCommitGraph is also enabled by default in that commit.

Thanks,
-Stolee

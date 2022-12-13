Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA7C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 13:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiLMNES (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 08:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiLMNEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 08:04:16 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEAB1D333
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 05:04:15 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h12so15508563wrv.10
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 05:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RSOJHItAafGeLHt7jyTGC8VqaTKY+KNldpvx3xlKjlA=;
        b=jyYK5szQgM+iAtIn4ibwFGWt9TtrpEGdBF2XmgkdYXFF5pu6DpSCR9yqB6ksdNx3TV
         0ODoNSHiWBbqjxgQQ5UH39t2PIcPrEGGOzN90haj+UiNZeziJ9x9SC/cYSdgq2KHUnOu
         yyTN/zOKPXyy7IrtTFJJEVSnOkLgV2ywGfw2gVXfkH5WC5XQF6/a2SxY3nNmJ7K9+vol
         DvSMgA9bg1MUtkoq0SrJTQfyWhodAhDiYnPkmNnIuxyDLaflyA+sFCWHT6hu3wZFycdN
         OAnQBqM5vx7+Ylwg1Tl+WJDed0J+Ptt6/aSi361eE845IcSw2wV5N3tsb+NDG487S55e
         F7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSOJHItAafGeLHt7jyTGC8VqaTKY+KNldpvx3xlKjlA=;
        b=fzqUurXyX/96oFP2BGKD1gpkFR6XTqSogxU5/fSMXtZKrc1Xj3FLjqzP3QLt8admPV
         lNME/jAtvdERTuJHkD7WDOn7/kT/P8IRrVxEXAeLRQq0if+D89i1s5DIFZrlnK8yHCYk
         095TF+DTFyCIGITxBGZidKGmTUhMFvCkT1LD8XJkgtQuMxJvsHfActi2q7yWZsD99nIX
         +nNIe6rVSVVFdX5TAywO8Zroala5MVZ5CPXvo43U1FuYbZjoHNmriDwGXtHwRfV9hegW
         EycbWvozUHvx5VVbnB2YK4dgkjAOPsAhyu0SwQzwyqT1FHsKnhCN3b55uBXF6VPk3WgJ
         ICiQ==
X-Gm-Message-State: ANoB5pmTjtLh7L33R7s9rNIblk2Ap/PQKDP6EQkvBeEn6Xa/JiCAIA+y
        f+g2/W9FcP96OPqYPT+5gkA=
X-Google-Smtp-Source: AA0mqf4/+eTFayDEvPLud/Jn4eF5O22iLUm0Gkc/BvpP130CX0ql8Oi6hV4ADxMXUgTKK5S0BDR5HQ==
X-Received: by 2002:a5d:51cd:0:b0:242:17d3:a9f9 with SMTP id n13-20020a5d51cd000000b0024217d3a9f9mr12457603wrv.68.1670936653918;
        Tue, 13 Dec 2022 05:04:13 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id b14-20020adff24e000000b002421db5f279sm11926924wrp.78.2022.12.13.05.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 05:04:13 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <51209c56-c82e-c393-6983-2a8c1a7388d3@dunelm.org.uk>
Date:   Tue, 13 Dec 2022 13:04:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/1] rebase --onto detection of already applied
 commits
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20221212113516.27816-1-cristian.ciocaltea@collabora.com>
 <xmqqlencqhxy.fsf@gitster.g>
 <f4b485c8-3bc4-fb0c-3f7a-084daac7c14d@collabora.com>
In-Reply-To: <f4b485c8-3bc4-fb0c-3f7a-084daac7c14d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian

On 13/12/2022 10:37, Cristian Ciocaltea wrote:
> Currently '--onto' works as if the user provided the 
> '--reapply-cherry-picks' flag,

--onto does not affect the cherry-pick detection. When running

	git rebase --onto new-base upstream feature

any commits in upstream have been cherry-picked from feature they will 
not be rebased. What it does not do is look for cherry-picks in 
onto...feature. It would be nice to add that but I'm not sure it is 
straight forward to do so and still exclude commits that have been 
cherry-picked from feature to upstream.

Best Wishes

Phillip

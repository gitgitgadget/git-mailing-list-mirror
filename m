Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7E6ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 15:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiISPI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 11:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiISPI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 11:08:26 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B732A71F
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 08:08:25 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c19so18747410qkm.7
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=q477xY/Ll0+wSpTZ8Cg8vEmh22PbDZJVMDHtGxyjOsA=;
        b=gp2SqhCgf5PpIicxdIYKHYcODM0pbTeApW1puuQL87rJO7y0ki4JwK59lRREgjrdQP
         P7uIa7iA6VDZA0/7UumwS0JtosV3urH/XevMA5bW8ZF3iBPgqQjYIvaJ+z708UDd4FT7
         cB8syHdD8HrThfGD6oR0nK9f/YRkGCv39dZrNoFv4tw4WfX29/l/cVx2mCpIUJyuSPvy
         J6EvfMkqnQqy07Ip2S2j2lt8KynKTH8yxpjt4mvCmH26852+XYcnnvUJ7FccYGeWwSmg
         bPHo66l8GxRtktHb3Cs/ry4R5HBvqdq1LoSnVcXFngnnCqVZfK532/biP25zxaCiHO4i
         IBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q477xY/Ll0+wSpTZ8Cg8vEmh22PbDZJVMDHtGxyjOsA=;
        b=Teh0CiNdTa846R3HN9SXpgwKASgpmsxpHDsNcYoydrMIsaCLt9BYkoyrdHhU+tpY5r
         zU6qooRnN9JCDI9TEUOAbPMelgfFWJXhHHycnJzJoX5EbU5KJdubVzEz4RaDljBKYedG
         kQlbUBZacE0K0Fx5NGAOCpnS1LVzRBq/VyZtkSoMStGCQhCO6htUp25UihrE2Vf/7MPL
         1hmTkbTWnaEK6s4ZpMb//TQ5VugWRcDyP2KUHQcYiTkPCTayy8VR2I+n823G3D7jDKC0
         YpNPiWQBMPoY35YAzZdaf7nVtADL03H+XC7p6jGuDgGzbPKIUVajP+F0ucU1prS8kGjy
         W0Vg==
X-Gm-Message-State: ACrzQf1Cn1SlJxoHe3XG4IQm0ymWs2IIvs2R0U3rR0bSjg8pYtYXilMp
        jvevw6jshnB+7F0Sq/Zz3QuH
X-Google-Smtp-Source: AMsMyM5955v2VApfdVwDFq3Y8v31VTwKUWlKqc9+GNBXo5t0n5UaYtJuLqQitMgyQyKpIY4R3yZ/AQ==
X-Received: by 2002:ae9:f117:0:b0:6cf:3b2:5f6d with SMTP id k23-20020ae9f117000000b006cf03b25f6dmr4464378qkg.706.1663600104257;
        Mon, 19 Sep 2022 08:08:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fd97:43ff:6c00:2cf8? ([2600:1700:e72:80a0:fd97:43ff:6c00:2cf8])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a425000b006b9c9b7db8bsm13800399qko.82.2022.09.19.08.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 08:08:23 -0700 (PDT)
Message-ID: <925b1e37-17aa-9168-9246-ac48e043c0d4@github.com>
Date:   Mon, 19 Sep 2022 11:08:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] Documentation: add ReviewingGuidelines
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        steadmon@google.com, chooglen@google.com
References: <pull.1348.git.1662747205235.gitgitgadget@gmail.com>
 <xmqqr10f88jm.fsf@gitster.g>
 <5685773e-db83-6b92-ff42-0d51e6e6a22e@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <5685773e-db83-6b92-ff42-0d51e6e6a22e@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/13/2022 7:11 PM, Victoria Dye wrote:
> Junio C Hamano wrote:
>> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Victoria Dye <vdye@github.com>
>>>
>>> Add a reviewing guidelines document including advice and common terminology
>>> used in Git mailing list reviews. The document is included in the
>>> 'TECH_DOCS' list in order to include it in Git's published documentation.
>>>
>>> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> Helped-by: Derrick Stolee <derrickstolee@github.com>
>>> Signed-off-by: Victoria Dye <vdye@github.com>
>>> ---
>>
>> I've commented on the text but haven't seen anybody else reviewing.
>> No interest?  Everybody silently happy?
> 
> My guess is that there aren't as many eyes on this as there might typically
> be because of Git Merge.

Yes, Git Merge took all of my attention in the past week, so I couldn't
chime in at all here.

My "Helped-by" includes some small suggestions from me, but mostly I
fully support having this kind of document. This one is an excellent
base to start from for future augmentation as we discover ideas that
could avoid sticky situations.

I particularly like how this document assumes good intent from all
parties, but recommends over-communicating to be sure that intent is
clear to everyone.

Thanks,
-Stolee

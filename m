Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CD5C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 15:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiK3PbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 10:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiK3PbO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 10:31:14 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F644F1B5
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 07:31:11 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id bp12so8245059ilb.9
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 07:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANkN0M94/34fDMhWaUCXycKEBAAOtIE+jR6AIK1b+s8=;
        b=UTosajvvjtGdKyRIULfmh44Yp8tDbl4qdkvIcmrxAazsMtlz4jEsGeVDOhX4LHJkz9
         qaKTtm2noFMYZWVYKoJMmx1sOocHVjaHhdB76f+OyIBuBoJdqWtpTDAljHHVKD5134q3
         RYT81Ap2t3s7pGL6lODWtA0xIgJNH1YaeTjlYbzGHOzh4TJs+B2raHU/6IAeCC/CVt1d
         UVqyQLrbVqr+yM8XKjdrWb1ogkEgo0xzvn402apb3O2FVqGbxtOSbqLlI4Svf99RuHt6
         2MNZqdV+dkHOXWZjykwfXS7r57R53qF6ziP+uTxSifjS0KbCCIEEs2jTLCjDjxc9FqKE
         HjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANkN0M94/34fDMhWaUCXycKEBAAOtIE+jR6AIK1b+s8=;
        b=7yJvhf8NZdo9jBnDju3sbLhiOB5osN1c+qN+LUSDMFdpsFOjnOIIso8LnVfLiqIkNt
         9y5arDqDq9ynvSU2tK1eNuQ2oBq5QJhH6o/8TpGkFXxb9VtM4LT4rZ0f93dv09H7Wnt3
         4y4CAEowFZkq57Seb8P+iEjt8wIlVKacJ3jQ/5UylhzzOE9tCMQi5f8WQVVKmUkf/M2+
         HLCP8q0FDDv4Fh0LTlqfkXCB4y1sF9GRyn1W8CWhknPAGLp6CPg8OrV6VK7P8pnBc9xw
         oUBP2g6AGmzFriO6xcZLF0QNsiIldKFg0hOhZsz/8oe3xnhfdF1ANDv/vH0Zb0eUXTjV
         qcrQ==
X-Gm-Message-State: ANoB5pkXjLbUdPfwh10eEUKFOMkSickRCtAC3AmzBSqnXt7oLf688snU
        FZ8w38TcMo9CO0O+VtW5QkJP
X-Google-Smtp-Source: AA0mqf6eyNhPc1k8CPUf/pigKDXYcR/bzaFbJubefeQR9mk7FHb+QN2HSnHwjcMFURzp7cABd2UVeQ==
X-Received: by 2002:a92:d6cd:0:b0:303:fa0:e40c with SMTP id z13-20020a92d6cd000000b003030fa0e40cmr8260058ilp.105.1669822270634;
        Wed, 30 Nov 2022 07:31:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:2d9d:31ee:c3ec:e9a5? ([2600:1700:e72:80a0:2d9d:31ee:c3ec:e9a5])
        by smtp.gmail.com with ESMTPSA id v27-20020a02cbbb000000b00389b6c71347sm683548jap.60.2022.11.30.07.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 07:31:10 -0800 (PST)
Message-ID: <c104b0e6-1287-b4ab-dd4a-b4b6eef9996c@github.com>
Date:   Wed, 30 Nov 2022 10:31:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file
 format
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com,
        Han-Wen Nienhuys <hanwen@google.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CABPp-BEZK2KJHY+=Ta3VUzNjJKY=evPiAtp5UQFTVLMD0qreVQ@mail.gmail.com>
 <0e156172-0670-2832-78cb-c7dfe2599192@github.com>
 <xmqqiljbkfg9.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqiljbkfg9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18/2022 6:31 PM, Junio C Hamano wrote:

> I have been and am still offline and haven't examined this proposal
> in detail, but would it be a better longer-term approach to improve
> reftable backend, instead of piling more effort on loose+packed
> filesystem based backend?

If reftable was complete and stable, then I would have carefully examined
it to check that it solves the problems at hand. I interpreted the lack of
progress in the area to be due to significant work required or hard
problems blocking its completion. That appears to be a wrong assumption,
so we are exploring what that will take to get it complete.

I am still wary of it requiring a clean slate and not having any way to
upgrade from an existing repository to one with reftable. I'm going to
reevaluate this to see how expensive it would be to upgrade to reftable
and how we can deploy that change safely.

These upgrade concerns may require us to eventually consider a world where
we can upgrade a repository by replacing the packed-refs file with a
reftable file, then later removing the ability to read or write loose
refs. To do so might benefit from the multi-valued extensions.refFormat
that is proposed in this RFC, even if packed-v2 does not become a
recognized value.

My personal opinion is that if reftable was not already implemented in
JGit and was not already partially contributed to Git, then we would not
choose that format or that "all or nothing" upgrade path. Instead,
incremental improvements on the existing ref formats are easier to
understand and test in parts.

But my opinion is not the most important one. I'll defer to the
community in this. I thought it worthwhile to present an alternative.

Thanks,
-Stolee


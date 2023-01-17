Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA57C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 15:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjAQPeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 10:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjAQPeO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 10:34:14 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DEE3FF38
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 07:34:13 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id q15so3565406qtn.0
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JA8nCWfW8Z+wjcu1YwKgNLXMQgmhtK2HOJMzgA9wVA=;
        b=QgRVhUYVhTChByKJ3d0LpQwdrKaFYmxyfuqJs5ZYDq9H2GEaUJmOn9eZw17HQFWv6c
         S0yP4fnoIiNm54ODpVPMuOMO98MbSM5QxzCu65jSvpyRlzNvYj7BJV7C69umh5tyDa5t
         m7KEQ2C84pSh20oKeA3b9REYY28tu11VWR6va9p3CcYreh2XQHbe7PB3cEYVqcI73DcM
         1UJp6tfSkZRe5Vp8s6wkXF2rtV+P86320y2Qt4DSEvOeAyr6OAOT0ms7212HjtDNsFs5
         VPbaBRNAjoS/dfwCWq39e//NU7pXC6mCG+lhKi0Kk/Vi7Xid/g+B/Oqwz59UJ3yWFOcZ
         S2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JA8nCWfW8Z+wjcu1YwKgNLXMQgmhtK2HOJMzgA9wVA=;
        b=NJFui/l4lfe7sB2XWw0O6/EQa1Fp0KFhIvuZDVmUg41MXKPzBPuM/YjR5WylEYqv9l
         wtGwEr5EynfVgU65znXjwutq1bTaavdAngP1vQ86dGiBRRtBrPjlQIRLCNSkfnf4L5zh
         +BlorWZtUiUJy+7QK1ZYLMbEGMZmJ7SVa5GtKl2ctlCRPDHUckrkiJGxY+pa9OvLw0MN
         ysBpEdsl/BdfhX2ePLWGiOakBPc1bDePiF6brq4OmD1OhmSqGI5Nleun0Xgvg9ZwA/xO
         hW0xEFCQ18DE6aiw6w7yc9IS3Pm9QrSxfNV3KJ/WfkFjktsLPPJE1mlylwQak7OPj4Kk
         AoCA==
X-Gm-Message-State: AFqh2kqG+8S5t0L8Umw2TkTZvwM/qaZY5Vu6F9QGtS47lVTCTTaye3Vv
        bqo1GbTj6r3Hl7fPYt0qhHlQ
X-Google-Smtp-Source: AMrXdXsX2d0bS9pxArPYYUYyDoBGk8NpwTSSYy7Njc3adKFkrcKsvtTbIHzW2RB1pT2w/zT5qcWkFg==
X-Received: by 2002:ac8:4d8d:0:b0:3af:f7f5:2b38 with SMTP id a13-20020ac84d8d000000b003aff7f52b38mr3837084qtw.59.1673969652817;
        Tue, 17 Jan 2023 07:34:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:b9ce:4130:c591:f90b? ([2600:1700:e72:80a0:b9ce:4130:c591:f90b])
        by smtp.gmail.com with ESMTPSA id z26-20020ac8101a000000b003a70a675066sm16042344qti.79.2023.01.17.07.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 07:34:12 -0800 (PST)
Message-ID: <db312853-81a1-542b-db96-d816c463516c@github.com>
Date:   Tue, 17 Jan 2023 10:34:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] treewide: always have a valid "index_state.repo" member
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <xmqqlem2coix.fsf@gitster.g>
 <patch-1.1-b4998652822-20230117T135234Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-1.1-b4998652822-20230117T135234Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/17/2023 8:57 AM, Ævar Arnfjörð Bjarmason wrote:
 
> This an updated verison of the 6/6 of [A], which per Junio's [B]
> wasn't picked up with those patches, which are now in "next".
> 
> Junio: Now that Derrick's ds/omit-trailing-hash-in-index has landed on
> "master" this can be applied on top a merge of "master" and what you
> have in "ab/cache-api-cleanup" (that topic itself being based on a
> too-old "master").
> 
> Since the v2 I changed the "Complete the double-reference" logic in
> repo_read_index() so that we're not working around a state of a
> affairs that no longer exists with this change.
> 
> A. https://lore.kernel.org/git/cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com/
> B. https://lore.kernel.org/git/xmqqtu0u2q9u.fsf@gitster.g/
> 
> Range-diff:

These changes look good to me. Thanks for dealing with the branch-
hopping.

Thanks,
-Stolee


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB0C433EF
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 22:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiGEWW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 18:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiGEWW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 18:22:56 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C882F1AF23
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 15:22:55 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id p13so8189915ilq.0
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 15:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mJBcqsZ4CVUNtLIVECaCk/FCL9e3cSPIymwe1z5Jazw=;
        b=hIL+q4cNXtbavEE84hlK3VB/dv4OREuEQ/HYs5WYkBu6MOymyGGdULG5cIeu0s1rVU
         OJ0S07evSoOhr3T5T+6BaKQDhXtO9gIFSi4UVfz21UXLER195LENisGgYLxUPS5pFSz7
         XD2VBoRwXfbyJVurCrWAaW3ZmGeg8+/SCqk9lcosFqQ33MA1dd08qwkRVLO3xdKQXyjE
         Yncc5X4+5oNAC1RRkbtUz50XPjAefG85SRoVgMANlZnpMh0guCDRLHDF3Ac9gyyqIgdl
         S1zH+9E3oIV1GWXjHt/4/sjvMvawLogUzDi/uz+odyVddLTCDZ/D3QGOuQRdxPIPkTrz
         aR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mJBcqsZ4CVUNtLIVECaCk/FCL9e3cSPIymwe1z5Jazw=;
        b=QtCl+tE1woMBK/GQ0gK3PGQ8NKE9KwFWGnVKWTNkk9lLARFZaq/xOFxZIKYaGCSE4E
         loEO8piwm1Evb7+os457Ls/V/eJMkQbW77zb8BvYN4Fv37+ArQ+VuHtFPVRlZvx4p/q3
         NouDz3e+jgd2v3wZgAu1XNci8bm8ZOQeSAbiEmNud+vK20OHr5fSF7/utMS7AJv0SMQZ
         frgZwEq9GA9yeZwTeDOUxAGbBosnWFo51PXAZZgjg1VobjHa7BL3z0lazaaujD73hKvK
         qs6lJAl0WL4Us0F76HkDu/EFCBVAn/K0NU93oKBdBv/buPpKfcHXgehXCBdHeKTU0qdY
         1ypQ==
X-Gm-Message-State: AJIora8s+eeX6Y1jYViG5bXO1XL3GZs2sPSv4kyuyt4BxBJKjvVFJhWr
        U9T4xuTpBPmjB290nvjUtiIM
X-Google-Smtp-Source: AGRyM1uwhR54A+I4RwR4tG9tWDN4977yRil8zUfd68YgyoV9ZTV6+JB3zGkweoytrO+gfjhDb2s6+w==
X-Received: by 2002:a92:d24d:0:b0:2dc:1420:d79a with SMTP id v13-20020a92d24d000000b002dc1420d79amr6984901ilg.197.1657059775190;
        Tue, 05 Jul 2022 15:22:55 -0700 (PDT)
Received: from [192.168.0.180] ([199.102.122.24])
        by smtp.gmail.com with ESMTPSA id j14-20020a056e020eee00b002dc1ea52967sm1655129ilk.34.2022.07.05.15.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 15:22:54 -0700 (PDT)
Message-ID: <84da5ea6-b6a9-7756-66f4-a3832144a68e@github.com>
Date:   Tue, 5 Jul 2022 16:22:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v3 6/8] rebase: add --update-refs option
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <918b398d6a2264a99acadd319f780c796bbafc18.1656422759.git.gitgitgadget@gmail.com>
 <CABPp-BFqLP51q9RkJr=16+Aqq7R=tYqL5mZGUq-dvfn8LL2AMQ@mail.gmail.com>
 <7dd69bb1-8bc7-3ae9-6265-bdba660b4c4a@github.com>
 <CABPp-BHOSHYLEpH_222X_Pv_hZeDwy10zLejrVgwgf6W-pFVyw@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BHOSHYLEpH_222X_Pv_hZeDwy10zLejrVgwgf6W-pFVyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/4/22 11:57 AM, Elijah Newren wrote:
> Actually, I checked out ds/rebase-update-ref just now to try it, and
> it seems like it does the right thing:
> 
>     pick 111111 first commit
>     pick 222222 second commit
>     fixup 555555 fixup! second commit
>     update-ref refs/heads/branch1
> 
>     pick 333333 third commit
>     pick 444444 fourth commit

Thanks for trying it out! This is definitely the main goal of the
feature, although it is also helpful when resolving conflicts or
doing 'edit' steps.

>     # Ref refs/heads/branch2 checked out at '...'
> 
> The last line was very disorienting to me at first and made me think
> we had a bug, but the update-refs stuff is built on top of the normal
> rebase mechanism and branch2 will be updated by that logic rather than
> by the special update-refs handling.  If I add another branch with a
> few commits on top of branch2, then branch2 is indeed updated and
> after the pick of 444444 (and the additional branch, say branch3,
> would be updated by the normal rebase logic instead of by the
> update-refs handling).  So it all works correctly, but users might get
> worried or confused along the way wondering whether it will function
> correctly.

I'll add a patch that removes the comment in the case of the HEAD
ref. Thanks for the idea!

> Another part that users might find disorienting is that at the end,
> the rebase reports:
>     Successfully rebased and updated refs/heads/branch2.
> which is correct but totally ignores the fact that it *also* rebased
> and updated other branches.

Good point. I can add an extra message at the end (as well as a
warning for any refs that did not properly update at the end).

Thanks,
-Stolee

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9023A1F405
	for <e@80x24.org>; Mon, 17 Dec 2018 14:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733209AbeLQOuz (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 09:50:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35568 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733001AbeLQOuz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 09:50:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so14346327qtc.2
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 06:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BWxJAZBZ8q12mrGVipfeaHru1A7/uKpCQzsR4ayDZ/U=;
        b=i0E8nrgyjnmnXElWiSXJDxzq4LsUddmeXSSZtr/nTnqumfyf0ZMkFW6J71S31QrbG5
         HEjB8C2s872YYhyjT5gYDqLyJ8CoRYwyuD6wi5V4nl93Z5YK1xbAOgK1TZzkuRjg/nMu
         DvquchdLi3w2w2ct2z5EXKjknAM5NSbXvhNzTWhy0KDjOdOIbIYR/562Hfa+Tuy7zMST
         hHb0ozaBo+4sBgZdXMRlQxWue2jPftRcnpt6ou4EpeEC8nK3CQblvjLUXeBKXTGLfCBM
         Gh4R8SdCKorEpZsJhaCQnQvOiCmu/+p3gJl3b1TvXX33GHitl9KlPvu9EuPVNU+OskiV
         UA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BWxJAZBZ8q12mrGVipfeaHru1A7/uKpCQzsR4ayDZ/U=;
        b=TWwwl7evArlJW/sEDRyC97/Q/oRYvXnaBsgpuCOp108WYPXwynuZZ80xgqMcrSioZJ
         MB9js05h+eB+QmhOMA+QJKTaW2Rb+X/tPGs3JHFnPz/OkcRlDMIKYL/1FJ+uJ57liOcB
         IHyiJS+Bqzt4mbjC8EfZRbUDJJBr1BiGO5IzczZoq5lh1Ly1IZtZQ+yVclQ7GtGlbUkU
         MnT4dynXRCb8jmR2zkBE2ZmZtv7Fft1zbTOZB4KzyXI7c4NjDi2aJA7165E+wTI4tToD
         VsBfInoGGhkMbYY0A/8NiZEY5khdkKJqIU/WtvajyV8Bh9pMjWB5F1qibZFyvWejdFag
         uACw==
X-Gm-Message-State: AA+aEWbTWf4ibCtnFiT2DGY1Gbp/FEW+jYMl/ZWtCF78Lzt099DhVMgU
        pSVOxq++4LAptuj01ujKrLJ9mQR2
X-Google-Smtp-Source: AFSGD/XUzs6gL1E1ZKE5mbyi11Idx+JJ2ho1Ahi0ksJ6KWxuZtryUr/Xi59jooNoOTNp3A9AOWWF8A==
X-Received: by 2002:ac8:5392:: with SMTP id x18mr13431227qtp.299.1545058253444;
        Mon, 17 Dec 2018 06:50:53 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:b986:23f4:3544:4b58? ([2001:4898:8010:2:a2ba:23f4:3544:4b58])
        by smtp.gmail.com with ESMTPSA id v53sm7817061qtb.6.2018.12.17.06.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 06:50:51 -0800 (PST)
Subject: Re: [PATCH v4 4/6] revision: implement sparse algorithm
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.89.v3.git.gitgitgadget@gmail.com>
 <pull.89.v4.git.gitgitgadget@gmail.com>
 <c44172c35ece7aafec02c7f3c8438ccca4f69023.1544822533.git.gitgitgadget@gmail.com>
 <87efaj1y77.fsf@evledraar.gmail.com>
 <867aa5c3-60e0-2467-795a-40aac58f306b@gmail.com>
 <87a7l41b78.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <161dd748-2ba6-cac7-433e-bd493d429759@gmail.com>
Date:   Mon, 17 Dec 2018 09:50:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <87a7l41b78.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/17/2018 9:26 AM, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Dec 17 2018, Derrick Stolee wrote:
>
>
>> As for adding progress to this step, I'm open to it. It can be done as
>> a sequel series.
> Okey. To clarify I wasn't complaining about the lack of progress output,
> we didn't have it before, just clarifying (as I've found out now) that
> when you're talking about "enumerating objects" in your commit message
> it's *not* what we're doing when we show the "Enumerating objects"
> progress bar, but an unrelated step prior to that.
Part of the problem is that in builtin/pack-objects.c, we have the 
following:

         if (progress)
                 progress_state = start_progress(_("Enumerating 
objects"), 0);
         if (!use_internal_rev_list)
                 read_object_list_from_stdin();
         else {
                 get_object_list(rp.argc, rp.argv);
                 argv_array_clear(&rp);
         }
         cleanup_preferred_base();
         if (include_tag && nr_result)
                 for_each_ref(add_ref_tag, NULL);
         stop_progress(&progress_state);

and the logic for walking uninteresting objects is the 
mark_edges_uninteresting() inside get_object_list() (both entirely 
contained in this progress state). Perhaps the best thing to do is to 
untangle the progress for the two modes based on 
'use_internal_rev_list'. Could we then have the progress for 
get_object_list() be "Walking objects" instead?

Thanks,
-Stolee

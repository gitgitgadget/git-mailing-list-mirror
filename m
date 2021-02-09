Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542E1C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F08B64EBD
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhBIHUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhBIHUM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 02:20:12 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06ADC061788
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 23:19:31 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id o12so16577123ote.12
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 23:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sklUMAL7vSu9Y6Wv8Wuil1ENrF+MktoM8pg+42GJHIU=;
        b=XPKL2gSlj5UDpwZ2PVWlbehSpjf+So1ep4Z+ssNMMLAIg38j1v3Z09UCX7dheDo93a
         pHk/1xlNOZEoA0Y6rfT5VNm4bg/R2LERHy2Lv9myYYh06qQh2VxJCCj5WtL6FuJxJkel
         0Myu5Dz+UE3QiACXxfCM0LdyL6SEDw8GOw7HGpydNYo3b0ebkYJMAuqGzTc49FedshQA
         A45kCHODH9LS+MWBNVs9B7KisV9UmzNVXUNIiCA/FoXOBu5KlycFSljFLwGVpwYvWMz1
         jhfmgDVowX4f/iteCpbIBhTR4yBhoQHufPOGTU6soLsTk/Gi4ifdxHu5Yt0r/f2b/toi
         8Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sklUMAL7vSu9Y6Wv8Wuil1ENrF+MktoM8pg+42GJHIU=;
        b=IQ30lT+tyCDdGv8VkKo7GCZa5bIvnpYmd6/PAXJQRQVxxgkPRZpSwQAHNgX/l5k1AV
         IWE9M8J1ku2AytdLfDcmC0aguO7fu1opuFTiogFZyNeZbjD7Ey6qaN/AdL4JmyZYtnoM
         s988cLpUnJQGWAJ452zSzvPevhJ2ZxiZkWhPqkvGPFKiTE5GLb3lag2jDpzrCEbtHZ64
         BXFsV7aegs6iagTST7mqw+lmwDsCqi12ZWt/31P0i/vdSSkaTDO8mIWQMgYzW2TBb4gX
         f1b1+yT2oefttqWS5IlbU8KkalZDSBoskSLlyTYviUwPQRGlaxjCNY/8eG1MysgHEAsZ
         m7sQ==
X-Gm-Message-State: AOAM5301zVs/q7X7fHRvtFS8jyaVIaCTr6oqxBYOJkYzDN6+9/1z/a/d
        POwnXgeyHeiUMBA8dbzQzjQlqSGdiOGZp9CZeHE=
X-Google-Smtp-Source: ABdhPJyCJ0KOgJHEXXBozi3m5CNTkKaPUHU5cLl04PtxxVMhG1ej8A6ikOkOkFCQXpNRl3ANocz6nU9EuGhNgQVhMHM=
X-Received: by 2002:a9d:6c11:: with SMTP id f17mr11988858otq.210.1612855171341;
 Mon, 08 Feb 2021 23:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210208192528.21399-1-charvi077@gmail.com>
 <xmqqsg664400.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsg664400.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 9 Feb 2021 12:49:20 +0530
Message-ID: <CAPSFM5es01OVGOgDOHpBnCrTQpb_NebB9PganVJi7us7pHnV7w@mail.gmail.com>
Subject: Re: [PATCH v2 00/11][Outreachy] Improve the 'fixup [-C | -c]' in
 interactive rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 9 Feb 2021 at 03:27, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > This patch series is build on the top of "cm/rebase-i" in the 'next' branch and
> > improves it. It fixup the source code of 'fixup [-C | -c]' command in the
> > sequencer, do some fixes in rebase -i, improves the 'fixup_-C' like commands
> > in lib-rebase.sh, update the test-script 't3437' and fixes a typo in the
> > documentation.
>
> Thanks.  I saw a couple of minor nits, but overall it was a pleasant
> read.
>

Thanks for feedback! I will fix those nits in the next version.

Thanks and Regards,
Charvi

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DB9C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 13:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiC1NM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 09:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242971AbiC1NMu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 09:12:50 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BACA5FBF
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 06:11:06 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g8so11286180qke.2
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=uG45/TJQzjs2MmAjCWXDrF0DVGnIIHzD5djkiL53++4=;
        b=IF0OiQykWIVuq00OK776coF+xL6NU9eZXRc4HoJmsrRrh8jO2PTN1FuXQ4CR1egu0r
         CGwAiFO5DS3/wbx0/1l+p1Y931F1PSQ0csGEFMrDuoeigHVzC2Y2/gtZlxZQQeoF0LlK
         0gbO03BDrhGskg4d1eVLj1ue1MedDRnBeU+50YKcubGnBHcWt/aqEtdivuhEpjq0hMSL
         xPYWA532XK4TTzoVKE1bB85XGIauh70Z3riiEflcs4hTwNd8ZIhTRDmM6Oj5VqZvoL30
         ypVGLwIr8lRS4vcQJbdluW5TJQY5YNFpxwRZ0I5qijwFGWeipeeSrQyqqQNG3jY2NQpU
         3mTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uG45/TJQzjs2MmAjCWXDrF0DVGnIIHzD5djkiL53++4=;
        b=PdeFyTn+FeevcAg8RpTHTcQ4dUsZ5i5SEKwTR9EAcY+K86uXLe6v40qjMshq2fVOmi
         ZWZtfSF2kvPkeL++70Cx5tB0kqZorGrqwPMNF7alzRQmuO//4fFvZAfh13TS028W5VxJ
         2GLUQVvWv+kXMZpjAvQQ6uDV229Lk2wv3cYYOV3I1HDtKEjr5LkIVoa3NK+MHHa4F/mK
         wC1rh7YuLv5D7n9vCN4oojdaJPhCTD4MSB9yY2T1CFTAeUa25sc85mEGe40KenfMG7ar
         jHG3LSnpnSQNN1vfzVqSH2MD7FeFEHMcFK/JRckVAEWF9RypfS4vhZsu/x+FoW7woMFj
         bWVw==
X-Gm-Message-State: AOAM532OYdZkKA4lF1A5jpvKrgnTMTmfPpVSmpnpmKgWdy2p5nzBVwvO
        cKexnlcc2DsmeXHCYK4Lz5Xx
X-Google-Smtp-Source: ABdhPJz/PQueYPTPglNzpMepd7p9OwT6JK7r8+qjqidv2fEXxkCYNwdTFX3+wQMb7jvXrcuPOFQkDA==
X-Received: by 2002:ae9:e20f:0:b0:67d:2e50:1774 with SMTP id c15-20020ae9e20f000000b0067d2e501774mr15738519qkc.430.1648473065144;
        Mon, 28 Mar 2022 06:11:05 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d21-20020a05622a101500b002e07151139fsm13447993qte.17.2022.03.28.06.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 06:11:04 -0700 (PDT)
Message-ID: <41050612-b5ba-c394-a288-000d5a49e51a@github.com>
Date:   Mon, 28 Mar 2022 09:11:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Add a "remove" subcommand to "git-sparse-checkout"
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
References: <CAJyCBORyNQX7u5=ZTdyHWyb63r-Cus4hb_yZingm4B=J4pjhkA@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAJyCBORyNQX7u5=ZTdyHWyb63r-Cus4hb_yZingm4B=J4pjhkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/27/2022 11:46 PM, Shaoxuan Yuan wrote:
> Hi all,
> 
> I'm wondering do we have a plan to add a "remove" subcommand
> to the existing "git-sparse-checkout" command set?
> 
> Because when I am messing with sparse-checkout, I sometimes want
> to remove a directory from cone, and I have to either go into
> ".git/info/sparse-checkout"
> to manually remove it, or "disable" then "init" or "set" the
> directories all over again.
> 
> I think it will be nice to "remove" a directory, then "reapply" to get
> the job done.
 
This is definitely something that can be done. I didn't include
it in the original plan (it is a natural analogue to 'add') because
of strange UX issues that arise when thinking about it a little
while.

Imagine this sequence of events:

	git sparse-checkout set A/B/C D/E
	git sparse-checkout add A/B
	git sparse-checkout remove A/B

In this sequence, A/B/C was declared as an important directory,
but then it gets removed from the sparse-checkout file because
it becomes implies by A/B.

When removing A/B, the most obvious implementation would remove
everything under A/B. But, would a user expect to have Git
remember A/B/C?

This is just a subtle point that has prevented me from building
the feature proactively. If someone else has a deeper need for
the feature, then choosing what works best for their expectations
(with enough documentation to assist anyone with a different
expectation) would be sufficient.

Also, if you implement a 'git sparse-checkout remove', then I
do not anticipate a 'reapply' being necessary afterwards. It
should update the worktree before exiting.

Thanks,
-Stolee

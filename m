Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE13AC43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 18:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbiGGSnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 14:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbiGGSm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 14:42:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B032A43E
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 11:42:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 70so6036754pfx.1
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 11:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tsx/h5MMZpOfbSABBVBxBcXs0y1vjyg6ARKKmobB3Ko=;
        b=gH/1+0x+tCYyvDoW6NNfLOSAT2KPK+HmLn+m2TxDD7RyGEjwzpISQ8TBY/iFQN4Vd4
         8H8ezQ87bpSZAbOI8lX12L+Uu0EbTfjQNf4p+NX40DNH3MRnJNrMIE3i+ueqRbvLQMwg
         6ftAALTdYgZRMaIHmT+XWz8G5zedfHSmZxPOVXbQQ9WDCbxJ6ffTVfxsZeO+2j8zTLFe
         dt6TSjOpegdIn/+H489RdRYuHhuJlfIuL3vVG/r09bE2lpdYd4i/lGtkvR47AGoI3kA3
         wAJLValBylDswF8G97HfviLYKgqAxx1QDmGhLWUzf+lh8IaewOaQVXo+r38wG/Zp9Us3
         fSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tsx/h5MMZpOfbSABBVBxBcXs0y1vjyg6ARKKmobB3Ko=;
        b=pAOmtrcauHw8QH8fvXBLJ/O9f9j92yxq5bv+gNeK1dVi5dcoJ76TM0PdSiTPLdWKZ4
         ywqUcX5TyztxY1OLh4s8LWoz9VBoz0C5sDb2VemFX9LvfEtLxPqmQK9EWdaBCtJMST3G
         a0hGjBIDood86LPZLF1AZfVPXnaQFWr0UpU9RVL4GPvn2nymZjVF/W9b6mEq7U1Ky1s/
         w5cHMViGNCZzIYJDTFD3eCOJq8zNDMg48/3N27qGx/9bPjN7+OeH0Ye4Ry+szD2fRrlG
         NN1cjOt0LczLmFSy9ZmiN8oN+aU726vzta/NAyA6BO2TYRHjOVbG3H+D5RK6jMGGFS14
         GGWQ==
X-Gm-Message-State: AJIora8vGmk8oTs4MdjRO1vVF7PwpvmA6+Cm3Hps6QZbg0T0UUQphx3x
        //EbS7JxX+rxbutWkcjFmqo=
X-Google-Smtp-Source: AGRyM1vR6HzzoLDoVAz3L++28HkHVskfg9DHIZU8E/imaMme3Nj9HN6LbWcJp0lgaM29NoN+aaDeQA==
X-Received: by 2002:a17:902:d581:b0:16b:e6b8:4080 with SMTP id k1-20020a170902d58100b0016be6b84080mr22065971plh.146.1657219377789;
        Thu, 07 Jul 2022 11:42:57 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.34])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79405000000b00528a1f8e317sm4358847pfo.166.2022.07.07.11.42.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Jul 2022 11:42:57 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/6] [GSoC] bitmap: integrate a lookup table extension to the bitmap format
Date:   Fri,  8 Jul 2022 00:12:33 +0530
Message-Id: <20220707184233.80579-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <7f7e8d91-47bc-ede4-a552-2ddc9fe98a1e@gmail.com>
References: <7f7e8d91-47bc-ede4-a552-2ddc9fe98a1e@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:

>> Correct, [1/6] indeed depends on my previous patch series[2] and it
>> is assuming that that series has already been merged.
>
> I suppose it's the opposite. A quick check shows that the patch applies
> cleanly over 'master' but fails to apply over 'next' which has the
> changes from your other patch series. So, the base branch for [1/6]
> is 'master'. The other 5 patches clearly don't conflict.

Actually by saying "[1/6] indeed depends on my previous patch series[2]
and it is assuming that that series has already been merged.", I wanted
to mean that the format followed in this patch (e.g. description list,
indentation etc.) is dependent on the format changes introduced in that
Patch series.

If you say about the base branch, yes, you're right. The base branch is
'Master'.

> Since the first hunk of 1/6 and your other series touch the same area
> of Documentation/technical/bitmap-format.txt, the changes conflict.
> Junio might be able to handle this one. If not, you would need to look
> into separate 1/6 and based it over your other series to avoid the
> conflict.

Oh, I see. I have no problem doing that :)
Let me know if Junio face any problem fixing the conflict.

Thanks :)

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3ECC433B4
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 16:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A6760FF1
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 16:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhDRQzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 12:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhDRQzw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 12:55:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000A0C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 09:55:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x19so21878155lfa.2
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iiyN0fmLDFtrs55DVpyoe1Mn80Q1KdF33qvkQiMG+cU=;
        b=TiIw8E3GbfAguBGqWIBUD+P+LRTDwRO0EGQBVkeblvMnsDFZS9TjuRxmOtSjRZEFrT
         ZJ3lHNWudagTZIS5izBnVpsF2UwuLGJUHcVdmPftDCVBBlgHqzjnRuYEm6OqU/LXzfGS
         U8ll2c/kCAczcLXS+pnNyIWq+GhPyjnibfdKLEba8G00Ou6ZFPQKuU4kh2zSudzSlgfE
         UpIw5Zu3lR81gOndxMqtfTJDa8LQmSpQAMSDWk+UVvXeInLX38XNlOIYIPExEuIgZuXs
         DoCCKSzdh5WsfPK3bweVkNdoPS6vIpM2HSaw2oSfJrwXTcRre3+36qiOgiX+O/jkMCUG
         0IMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=iiyN0fmLDFtrs55DVpyoe1Mn80Q1KdF33qvkQiMG+cU=;
        b=treSidc4YR2FoQb8gkBATTJw/bEXgngTQrRUJqUXJ/QWh0RS2Cr+NzcOR6UOIvPT/D
         YohjjJyGyvhBn1gMV2TgSzXRO6e2Rkvb/oL9mM7FcKVEmOM5JipgpGSWO1XHmrh6Ohr9
         xgDbfv0wwYVa6QrERJrCh+JVolVIK1eEXnPzKI4zj4kMA+0G71VuTIh4oNQqDL8nQtgT
         Ash4nK4S3tiX0tXlFIxlV9qppqqTMO+kKSBJScGrL147VHQfctpx06TGdc3Aezgle444
         ey9zXrAgV7F4t/1sij+iocieYaqx32sn5cDp3kQggZ3pTTpPjd3k8P4SyLkTp+odqNZN
         Y9Zg==
X-Gm-Message-State: AOAM5308MoVD7da/2XafLWAK2o8K2u6QDKzps7JcPaj0KQpmXI26gHWO
        PEmjgNPb+AQwXFoo2g59H98RlfWq6TM=
X-Google-Smtp-Source: ABdhPJzR0ReM5A+JqiqJUT/fezACnmEJmtQVgVwEy/NHTjjNLRIBr3p6qbtmip755ReqDfSPB8fSkQ==
X-Received: by 2002:a05:6512:31ca:: with SMTP id j10mr9667288lfe.459.1618764916168;
        Sun, 18 Apr 2021 09:55:16 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i20sm773789lfe.4.2021.04.18.09.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 09:55:15 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2021, #04; Thu, 15)
References: <xmqqa6pznlgq.fsf@gitster.g>
Date:   Sun, 18 Apr 2021 19:55:14 +0300
In-Reply-To: <xmqqa6pznlgq.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        15 Apr 2021 17:04:37 -0700")
Message-ID: <87zgxvttvx.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:


[...]

>
> * so/log-diff-merge (2021-04-13) 5 commits
>  - doc/diff-options: document new --diff-merges features
>  - diff-merges: introduce log.diffMerges config variable
>  - diff-merges: adapt -m to enable default diff format
>  - diff-merges: refactor set_diff_merges()
>  - diff-merges: introduce --diff-merges=on
>
>  "git log" learned "--diff-merges=<style>" option, with an
>  associated configuration variable log.diffMerges.
>
>  Seems to break t9902.

As far as I understand, it doesn't. It rather hits a deficiency of the
build system where one needs to "make install" for completion tests to
run as expected.

Thanks,
-- Sergey Organov

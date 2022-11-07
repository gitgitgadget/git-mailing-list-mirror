Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AC6C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiKGVr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiKGVrX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:47:23 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C127B3B
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:47:22 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e189so10047965iof.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJ/9krFlBlP6Op2AeWFBEwOsNayl+tC+i2sbuTpUQwU=;
        b=5hMhGH3OoY23ty1x/HW7qW3vVhHdXeQZZYagZhrohigvqWKtIhyaD6svmZqUnPj3PU
         Nqo0O87QLcSnobZVdsYzhBQN+7HF4PTlcYVlvN/OucMrdMaRpYCDwaKA77hHqQG0p3w/
         Ws+4ZnZsBOqjFbkqPdUCwRydEJCKKstAA86nsGVFCvSn96iXKGVNpjwq52BMp5/K908o
         ZNFeQfW73FoQ627H1ZEJYPtsu2u0R5wPFowVTLAjSZuS5puPr50iCCyhMjmkbmWE3LcL
         fhosr4rB5/OvWx9IPfo+67wNaQJxNCzQ7+/WOC+/JyqcPmi6g6lp+Y70KTketrVVbxpq
         rSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJ/9krFlBlP6Op2AeWFBEwOsNayl+tC+i2sbuTpUQwU=;
        b=oPHfq87Tyj6CpBEdpyzYFMud6cWZRf74M1s9ySEdMKleA21LG5U+RqzxtgsLvu+L+Z
         TrfGs79ggEdNCmfuEjxyMGprEdcafvTT9GQmhG6yawvXalHTfWSBfJPo6tT07UeFVpTN
         Db/Qfy/WNCnnL/Rm73Z8c+tb4ulXO6pQ6mj55Vs21D1Qozn6GP4PAMreIeCbzkjHHL3Y
         u2K/8F6uDhYGqvD5mig1+R8W50BAXISEOrTkytbVru+p669LpyuJzTBRqoVoUfZabws2
         mhajYJL8GrVH1Pu2OjQccgMvwggxFVUPESdvlihEIrXX22wb4Sehu3N93lphrF8sEPck
         Tllg==
X-Gm-Message-State: ACrzQf3/RHq1KshrBrf+Vqe06aN/WUPL8y/hbiyvaQEfy1E/zd6B/j6h
        SNvyeWcp10S01BBoMdKGQJOsZA==
X-Google-Smtp-Source: AMsMyM5Hz61diAis+hZExkNZb/BluW70pEq9TCB1ZM8Ha21MBOXP93jqWBMkV6SQvbXqv7n7VRKaMQ==
X-Received: by 2002:a05:6638:470a:b0:374:17a5:cee6 with SMTP id cs10-20020a056638470a00b0037417a5cee6mr31289812jab.161.1667857641757;
        Mon, 07 Nov 2022 13:47:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o1-20020a056e0214c100b002ffa449535asm3184066ilk.74.2022.11.07.13.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:47:21 -0800 (PST)
Date:   Mon, 7 Nov 2022 16:47:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
Message-ID: <Y2l86Cvbv8nSlN4X@nand.local>
References: <cover.1667828335.git.dyroneteng@gmail.com>
 <2381947abdd6b965c02e114af297fc908ed3132b.1667828335.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2381947abdd6b965c02e114af297fc908ed3132b.1667828335.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 09:57:03PM +0800, Teng Long wrote:
> From: Teng Long <dyroneteng@gmail.com>
>
> When appending to a given object which has note and if the appended
> note is not empty too, we will insert a blank line at first. The
> blank line serves as a split line, but sometimes we just want to
> omit it then append on the heels of the target note. So, we add
> a new "OPT_BOOL()" option to determain whether a new blank line
> is insert at first.

The discussion about whether this should support '--blank-line' or just
be '--no-blank-line' aside, I'm curious what motivated this change?

Thanks,
Taylor

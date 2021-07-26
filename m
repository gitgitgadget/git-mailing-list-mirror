Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE8AC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 19:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9EFA60E09
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 19:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhGZTFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhGZTFa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 15:05:30 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857E6C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 12:45:57 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t128so12314642oig.1
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 12:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=OtJzjskz9EBZUAgn1nRhG570TWIue4zfHVw1/Nq8Xh8=;
        b=YLu+ww0mc+C0le5gSPC2AzARQjU4OkxRK+U4qHRJG8l8uNfW+oeks4/dSPb+1YtmKk
         taXpBaosAVKw2RWSWT4T995vhn511LH8YOP5MsBFjV7cGGCLhdR3iVPsBPT5/FM+lu/U
         P5wf/XSQaxG7UOV2P3TBFhLwYh8jSOHX+yFQ3g8D+ju9y6qXGLFDyhQRMNGXyQ998R0P
         3s1xiAXQ5hCiqiFCzNmeIZua02FiZZlZpS34GYyWPiGuNXVqNg7d6bLx1+D9CEpJPoRK
         zBhB9AbDcjcM+hZ7MfTCjdngMYSy4C0Ry9I/iRs2v7gL9uz4KAcMDLnGDSZOs024XDvS
         CtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=OtJzjskz9EBZUAgn1nRhG570TWIue4zfHVw1/Nq8Xh8=;
        b=heTYmiU/qMVwSsBAq4mDiIf4seqYDzFxFlIkTQ1ydTSzG8UIhLWTqrfVHGWmiWGXR3
         kFnnElSwMLtpY6G/oHAUen/ik2wd6Vb/Aqvsy4VtoK/LerBKJFIve6tUPnS8Xysr5ZIB
         lFELsXS65IVuGmS2Of0pgaJboSAWZgkCeyPNjhuttzRY/UlIE6pHJ7M7A6ZQh+bHlD7l
         qJ3IqlnDHIwO1MzpDyCsE2YNqVHIpbXkRI2N7irel37udyG/tbXdYlEDaXbS5nBKN/oj
         zh0GK/ECATlo4U6kFXO0pIIHzYmV2HJQlrwMeo1pw8/hFuznnQ2YgDovHGAJS+TZc780
         GlDQ==
X-Gm-Message-State: AOAM531O387KoACzMJxh3F18KiBQ75vyRLWzmbL9by24Xvhh+M+XPKP/
        WbMruvMfLU4ehxxLFpOPkQQ=
X-Google-Smtp-Source: ABdhPJwy+cXDNWmbwWVqRCf972K/N5U/19scpyWk1ogPMxjWrAdr5An2AQFjIkJEK2LhWjZUawlrOQ==
X-Received: by 2002:aca:edce:: with SMTP id l197mr488744oih.96.1627328756928;
        Mon, 26 Jul 2021 12:45:56 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r1sm125629ooi.21.2021.07.26.12.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 12:45:56 -0700 (PDT)
Date:   Mon, 26 Jul 2021 14:45:55 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, avarab@gmail.com
Message-ID: <60ff10f378513_3b8d2085d@natae.notmuch>
In-Reply-To: <xmqqbl6pj60y.fsf@gitster.g>
References: <cover.1627292424.git.dyroneteng@gmail.com>
 <91dce385f630f4741bc6bb1540ef3c65e95a113f.1627292425.git.dyroneteng@gmail.com>
 <xmqqbl6pj60y.fsf@gitster.g>
Subject: Re: [PATCH v3 1/3] packfile-uris: support for excluding commit
 objects
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Teng Long <dyroneteng@gmail.com> writes:
> 
> > On the server, more sophisticated means of excluding objects should be
> > supported, such as commit object. This commit introduces a new
> > configuration `uploadpack.excludeobject` for this.
> 
> Please avoid adjectives that express subjective values, like
> "sophisticated".

The word "sophisticated" is not necessarily subjective, it can easily
mean "complex".

https://www.merriam-webster.com/dictionary/sophisticated

-- 
Felipe Contreras

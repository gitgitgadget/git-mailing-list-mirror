Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ED3C433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 03:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89095207C5
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 03:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgL2DMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 22:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgL2DMK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 22:12:10 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032A1C0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 19:11:30 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b5so802891pjl.0
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 19:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=X3/LNHQoh3e3hc4jPriPYh6Rvx/Ki0c5BIXkmdX8yYs=;
        b=vUrDRUXZoLVd0qjgyciHp4z/r3dd4BWoQXBI5Co4kxolQgwJrVHttLZpFsTDo/5Bcg
         R3fthlgLalsClpYrghwoTZ6V6GVCHUph9XFna5Qq2SwQpfqtF2fRkqyXQvex/63oXUEz
         vZbog7MYAnxheRpV7dF8ajpxmu2P5l4JpQAKiGJvJSdoVd9lRwoT/1OQJJP53mFgnH/0
         Uq+t5kalMkt9NC5uAGE825TLhZDFKoaJEGRQ5v05NG+SiAabWdpMpx/mGGI4e+o+23O/
         TrIjh96Gs9VTpFZW+9F/pRtsp8omQzR+HDHPkKHcD7dSpNzdpwmoO4r+gmnRfvKT6AOl
         /D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=X3/LNHQoh3e3hc4jPriPYh6Rvx/Ki0c5BIXkmdX8yYs=;
        b=NHX6yrt4+GIuQyNfN46gLl02gvn+b7+3c93rWy+CKU3YFIhm01fSP1dZ7yY8FlwXY+
         2E338p9u8fjb97bHAMfIyeMLGIRYD3OepobW96xUC5g8P+6TgFHlq/U6AW+ugp8I1vH+
         uixpGiE/GNZjOQZ3dzkn48puoTd7UCHenlLoZevcr1TTqzmUvAIxs2a0cVaT+aU3ZuIb
         Fdh1YyvG+rPoifcDG19O3AaFty3uNxHGWWIo49i5vIyPDl+PzHB0GoGW28f+ouaZqn+u
         au16NdEHD5RusUVNB2Ubp4/XYhZVeq3vjTuvEqi+QPxKH9+QA/hvCyaRbyDwewf+8xhQ
         BYRQ==
X-Gm-Message-State: AOAM530jTmhSTArzKuO2XnGWfWby45ssHzppK6uFVYYVZvHjXIK4g3Co
        x0ln1YjqiR5bI0pFmDq3ABc=
X-Google-Smtp-Source: ABdhPJwAyzuumVjjo5VLnurgTgGcb4dqum1K38AmZT7hBl4n99ZYIekYiqJr+oYMVx8Tseqzh7e5KQ==
X-Received: by 2002:a17:902:e9d4:b029:da:a2fd:476 with SMTP id 20-20020a170902e9d4b02900daa2fd0476mr41121114plk.73.1609211489503;
        Mon, 28 Dec 2020 19:11:29 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id h1sm25151003pgj.59.2020.12.28.19.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 19:11:28 -0800 (PST)
Date:   Mon, 28 Dec 2020 19:11:26 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] CoC: Update word-wrapping to match upstream
Message-ID: <X+qeXrO6e3HA6Jdx@google.com>
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
 <20201228171734.30038-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201228171734.30038-2-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> When the CoC document was added in 5cdf2301d4a (add a Code of Conduct
> document, 2019-09-24) it was added from some 1.4 version of the
> document whose word wrapping doesn't match what's currently at [1],
> which matches content/version/1/4/code-of-conduct.md in the CoC
> repository[2].
>
> Let's update our version to match that, to make reading subsequent
> diffs easier. There are no non-whitespace changes here.
>
> 1. https://www.contributor-covenant.org/version/1/4/code-of-conduct/
> 2. https://github.com/ContributorCovenant/contributor_covenant
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  CODE_OF_CONDUCT.md | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)

Makes sense.
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

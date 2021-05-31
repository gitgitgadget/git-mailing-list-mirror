Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D84C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F1E610A8
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhEaRWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbhEaRW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:22:28 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D78FC08E90B
        for <git@vger.kernel.org>; Mon, 31 May 2021 08:41:33 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id z3so12644018oib.5
        for <git@vger.kernel.org>; Mon, 31 May 2021 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=v7Ji2+2xYt/3w3CvGBm/bazJhNECKPpLrKnX4ZZsXoM=;
        b=MFajjlpzsHz+YHlkRtVIqeKt5YWJjOBOWYmriMuoMwFEnjrbUILRGfQ78hnv6B3ISr
         zdODKLTONOigo9Qqo9DG7bzNKxYPZCHHBO7jghi5dsQ62vO7PPOTsA8ZvewLGzaI/VWk
         9imdw4EKkdnbzRQFAnWs/DJaTbzs25y9gCVctdWr6cFlGIuFICIezcAKmMOcV3Lb0TKd
         ON//eGwtT+1y4JURvTKyFGm7ve6BRL5yGEZeJ0jYBF0ibuB5eTf0yfs4xDXNTsgbxcYm
         PCZyda1hXXhjDlKUcCyE8DUh0RxR7QQ1ogCEleDWOh7FJNOrG5OPkcKS57yBp1PD0sLn
         0/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=v7Ji2+2xYt/3w3CvGBm/bazJhNECKPpLrKnX4ZZsXoM=;
        b=i5yJGnn279/MUnIUq2gMAdEDKQAS5EkxEqTsxIDda/IyPbewFbnYZuf+52y/mH/xM4
         MbcuSxwkdnWYPlGUuFDhEh/er0NESGr4CgeGcLYb5wACzisyXpkMzGm3CLA4qCupPCKr
         7GozwpN81LgQdlXyvPuKw4dfpR+dlCGtCBzBZwQQRjU1MIwHZLKA37knl4wzrcJT57TO
         oJAexiV9XMy/0cHzfw4bul7JGe0lpdhTw8hrCKwZ1w1Oe9Gj9KKjPKEUIMrT+17HIY6m
         wF0XZEDvs11nb/nMFIytd7DmkMk41pe+bMMsnllrOln/h2HdjNCILep0jL82dKCguR2w
         bVvg==
X-Gm-Message-State: AOAM531N7O/rx8PD4buD4Ye+vsyLyW1ZgK5jmPRtbdnoOZMafzFM+BN2
        tzV+bqTo6ZVjsVc+16Tm3ZcOrWV0cCCc2A==
X-Google-Smtp-Source: ABdhPJwnuVRhQKCpPtDkk9lAGTzBqb+N5MrJ4uUoZpFJuBOiplYMueuBbAHUU0U3Js12Fc+ONrEvTQ==
X-Received: by 2002:aca:b883:: with SMTP id i125mr14403222oif.49.1622475692720;
        Mon, 31 May 2021 08:41:32 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m74sm2873321oig.33.2021.05.31.08.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 08:41:32 -0700 (PDT)
Date:   Mon, 31 May 2021 10:41:31 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Message-ID: <60b503ab859d_24d282087@natae.notmuch>
In-Reply-To: <e44a2ed0db596ab0e0f484c25facb7da7214369e.1622379718.git.gitgitgadget@gmail.com>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <pull.963.v2.git.1622379718.gitgitgadget@gmail.com>
 <e44a2ed0db596ab0e0f484c25facb7da7214369e.1622379718.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH v2 2/2] [GSOC] ref-filter: add %(raw) atom
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>

> +static int memcasecmp(const void *vs1, const void *vs2, size_t n)
> +{
> +	const char *s1 = (const void *)vs1;
> +	const char *s2 = (const void *)vs2;

As I explained in another mail, I think this is better:

	const char *s1 = vs1, *s2 = vs2;

> +	const char *end = s1 + n;
> +
> +	for (; s1 < end; s1++, s2++) {
> +		int diff = tolower(*s1) - tolower(*s2);
> +		if (diff)
> +			return diff;
> +	}
> +	return 0;
> +}

-- 
Felipe Contreras

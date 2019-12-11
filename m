Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D397C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 18:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606F821556
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 18:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVvTID4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfLKS5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:57:50 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40175 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfLKS5u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 13:57:50 -0500
Received: by mail-qv1-f67.google.com with SMTP id k10so4598735qve.7
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 10:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BpDeIUH5EevXAcCGsT4DQst1LSqj8hLgiLvMh4axoDw=;
        b=sVvTID4DEkTC0WkuEbdHAGys33w8JogQQSGjqm6LWsYDIRdq4Hp96q0W1KzZjHGWF9
         bFt1ZzoplXI2DUftKX0P2HiIYeX+18NBAE/duCXQZmsvqlSzAdQxUFR4yribHbelzc/M
         lmPj6WAN14f6VRkl240vV3YqckwSZoXbco/Ou9N82BmNEzeCdcElYCvDm9KcwWVvx+zq
         y4HR5PA7D6Jke0BRN8WtBWg7ZO9fNQGsRCq0eMHPmth6ejrRGnCSYkNvFSc+LRNDT7Th
         0JX+C5O/Glip5RvQPs7Tkk+KHJV1TdDcEtFESz9X4uJYk9jan03/iRagZvWjBPn+6ahG
         ysOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BpDeIUH5EevXAcCGsT4DQst1LSqj8hLgiLvMh4axoDw=;
        b=SSTt8yHcQjRJuuW0luJ7Oat0RXK2bLLkEUe7DUYEKc+8xlQtaXWeR6xyOa2IxwtY5l
         A05gHQcPuxxItWQlpyAtgeo7rItDxZYZoNb3RSYjUbJ+c5gy4rXkmw1dvAfCiPvMsVqc
         gDDAEZmgroDTsZ9ipius4uThlJkGptnRVT5dIwPzqHtWhhs1CTNEeIC3tjJxBWm6Hep1
         fxapSEayO8j1ixcBsLVPQ5cXrzkUqbUS02itmX4vuXPa3QTDhrtpiHW+uzs79Ruj5hyt
         L964qz3jQ54214YbKGVCmMCTgnUv/pRN3+j/P/hq5Y2CjkEM/Bi9n3oYju/ign+/03ve
         2koA==
X-Gm-Message-State: APjAAAUqYQYFSjrb7hLOoPQxOjt5rT0bicDhEt/QK+sLVTG160MzCwxu
        22JQPeW7V5u0tM56tSBIiRARg6JyfaU=
X-Google-Smtp-Source: APXvYqyocUqUoT3vnJUeWf7dntRvacTjGZbk5IIECWhitpFWiVJVNDPUdZfaEf97n2zpErZssxVgKg==
X-Received: by 2002:ad4:4e14:: with SMTP id dl20mr3176888qvb.62.1576090669298;
        Wed, 11 Dec 2019 10:57:49 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:3126:c1d8:6135:a84d? ([2001:4898:a800:1010:e25b:c1d8:6135:a84d])
        by smtp.gmail.com with ESMTPSA id 63sm928930qki.57.2019.12.11.10.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 10:57:48 -0800 (PST)
Subject: Re: [PATCH] remote: pass NULL to read_ref_full() because object ID is
 not needed
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <24fc1649-d80c-cc4b-8268-a7833812d39c@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a1bfb55c-21dd-12e6-186b-44c1873d1c52@gmail.com>
Date:   Wed, 11 Dec 2019 13:57:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <24fc1649-d80c-cc4b-8268-a7833812d39c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11/2019 1:46 PM, René Scharfe wrote:
> read_ref_full() wraps refs_read_ref_full(), which in turn wraps
> refs_resolve_ref_unsafe(), which handles a NULL oid pointer of callers
> not interested in the resolved object ID.  Make use of that feature to
> document that mv() is such a caller.

Double-checking the code shows this in refs_resolve_ref_unsafe():

        if (!oid)
                oid = &unused_oid;

where unused_oid is a local struct. Unfortunate that the correct code
change doesn't get any performance benefit for sending this message
of "I don't need this value".

LGTM.

-Stolee

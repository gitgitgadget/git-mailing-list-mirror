Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059B1C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 06:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8AC2311F
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 06:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbhASGlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 01:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391006AbhASFiO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 00:38:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF28FC061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 21:37:34 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j12so2409595pjy.5
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 21:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:subject:from:to:cc:date
         :message-id:in-reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=GlSSgnSNgoXq/+SLQzdyNV6TlRi2d0kOeJJsOlCgTefHwJImHtijZFsH/NIFZ+yxcz
         IOizGBLyCiPmuOgvoUzqEneaDrKqtTjfxeN3m5wWqTVyZB3W3LkrORvOt+RlSSb0SqUB
         3/XF14gU3iBkWrdkmdBEe7MuHewJZicfoi3o66cPm3YKguw/68D+A8JKn4u3MA3GUl9E
         2VA8CjbAKI/SvI9VgYo2/T5yFk1NDeA4Gs23Mgp0NiMc/4k9tari0cY6lFygvj7xyR+3
         at6hPoDRerwUyyWKnAdVZeAvIOdwUKtMgqGRjOklsRCBhKN3eFyjBuQ6eE7/xQIugZka
         P/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :from:to:cc:date:message-id:in-reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=NyQtJD2tlpI1JeyeMJoylF6hTjAOKXkXkisp5zI0MDuSFm3uYcF/LBqxmTc8BogHwF
         sb2Ka8VxIWpAajxRuV9eZOCsQzEoItC00Qb1p+v8Ve1UMlmyCO2NLnFsGYXSSzknmffV
         90u9/8pVcGItGVsxweCaFMY1kyWvk7rUUOBK/EoQVnDFFxb+ixrt9Zjqj7Uf+w/+Hhip
         rx4Q4vANOxR1OByG/QmL76a+2NgWx00mnqiuhTpG06WTQUclLPUwLhbs78Xkf70sSK/W
         CzxAQJnGxXd5QzjE2RXwixYDtKi6/ZM3uZGnW4SqXcgK4rfxJJd8xUfO/zveWtbES0uB
         LuZA==
X-Gm-Message-State: AOAM5313+k+sPfbJVw//IG9UTdBPHf7mhKQjhm6GlnGDTssTtbg79KA0
        iAXN7/I6jhRLuggj/dfQTIAyMExCZ+ikCr/y
X-Google-Smtp-Source: ABdhPJyL6d3WQStDkfumeHHTl0lLOGnJ52Teb6I1Ih/PzzfRT/KsSpcy6m7zR7SXLGHhjNyfYGEw1w==
X-Received: by 2002:a17:902:ee14:b029:de:19f0:91b4 with SMTP id z20-20020a170902ee14b02900de19f091b4mr3015307plb.78.1611034654240;
        Mon, 18 Jan 2021 21:37:34 -0800 (PST)
Received: from localhost ([193.37.32.27])
        by smtp.gmail.com with ESMTPSA id f7sm1157558pjs.25.2021.01.18.21.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 21:37:33 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: DEVEL: Help with feature implementation
From:   "Aiyee Bee" <shane.880088.supw@gmail.com>
To:     "Derrick Stolee" <stolee@gmail.com>
Cc:     <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
        "Antonio Russo" <aerusso@aerusso.net>
Date:   Tue, 19 Jan 2021 05:35:54 +0000
Message-Id: <C8MW35119PZ3.3DYS0P3OSK9ZU@localhost>
In-Reply-To: <5e5ece7c-3f34-caa1-db87-084b42c1cb62@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


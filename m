Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D5FC48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4626115A
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhFWTvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 15:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWTv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 15:51:29 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D50DC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:49:10 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so3135436oth.9
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ziaDLvB5Gzzao8jyy7l3j/0JKEQ7FZ+g4AtFI9ue1fk=;
        b=QeWpf6H72bMN7xdKhEoWxB66mLwyKNlim7ZOj5Yp8YkyWiGOjI2wem7YspjFU0GuHo
         ZGmiRpYxa5lH1w3hIQ+wxp/1tJAU2cp9r5cFPPQm73AiEJ9ZEA7OXimYGSr2zJQp842g
         LZPWJxQ5syidqc+2dApL7yRcClLegxIxPCfr8XFOpOs/KMCz4yW7Qlu5UoqvdrDUpFlv
         g74rWJCgvLnCvOyfJVskV9PiYJBOCStQJrZYCdguGxpP02XbauAIPAohYvL6/HTP+W1F
         iAHRrCPprp4BniXOZu3SiWNrYTEqoyJDpYC78KJAZi54M81mPaPwCNclJGlKK0mK8Cv8
         utJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ziaDLvB5Gzzao8jyy7l3j/0JKEQ7FZ+g4AtFI9ue1fk=;
        b=XOydlL/HTMCsMP2wpIxwctu3fN+AJngcefaRmoMWRdWpdKbgrr+roBI19QQOPcm0LU
         P4c/cgY2p2Hb5BvkclEA30JTmrYNpcNlPqYrfc4cO9JpsmuCdijP75HW06a2Ew8nwHUZ
         j4gz8K0oeJFEk1VGEa3359QDngeuHog1tMN3ritCOyDduS9ICSE9rwP3DpDoqcJMuk9c
         y9jINKyo7Gph0pWxZJXZx61XM7GAHz8VZ4RbwdDsYstBtcZ2uJAqF4cuLQGamVGij+aG
         F41rGrqw59ILUNk3QogKTmZvtmRIEz5KtzZl78pgOPhxatvqkVmYSmmE8jCuh0PU1mUl
         I/Pw==
X-Gm-Message-State: AOAM530b+1Nge1un6DXMH3p6gUWjNbCqfoqyS+yFSynSudnO42oVnmoF
        FFX/EM1jr2lEzHEOSnIyQ1E=
X-Google-Smtp-Source: ABdhPJy+qpMTNFM19R5u9Mmdiw4zwCIxd7HjHpfqp/Kw6rJwwTm5t0xkuwowcfdmLYxMyxIxpmIGpQ==
X-Received: by 2002:a9d:6287:: with SMTP id x7mr1395776otk.339.1624477750038;
        Wed, 23 Jun 2021 12:49:10 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id q12sm195981otn.2.2021.06.23.12.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 12:49:09 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:49:08 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60d390343798b_4290208e3@natae.notmuch>
In-Reply-To: <patch-3.3-67fc87665d6-20210622T141844Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
 <patch-3.3-67fc87665d6-20210622T141844Z-avarab@gmail.com>
Subject: RE: [PATCH 3/3] Makefile: don't use "FORCE" for tags targets
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Remove the "FORCE" dependency from the "tags", "TAGS" and "cscope.out"
> targets, instead make them depend on whether or not the relevant
> source files have changed.

Very nice.

> I'm also removing the "-o" option from them,

As Jeff already pointed out, this is probably "-a".

Other than that looks good to me.

-- =

Felipe Contreras=

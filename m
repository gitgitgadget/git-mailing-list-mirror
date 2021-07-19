Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EB2C07E95
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ABB06113C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353187AbhGSRLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245166AbhGSRKc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:10:32 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F36C061768
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:34:24 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id p67so21648909oig.2
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=8ZYEXUZD/Njcb2hmIShImYXofOfpmgld6VFTbaXRQi4=;
        b=sxi6DSzMIdozi6yMrPiHxKjnnKuMcOuVL2fEHMHmaPqHm0pfDNsgzCaQJKOCSV0M7L
         dS4z+RwBlfx2UdT9l0SWhxa7WL1FEIh/23bLiG5eSym4qUh5+t+coFBlENpNSkWv683/
         25Lt+1D2e5DCBtKQAbIu6hoITAiSmfU81j1Lwqk/nBTG2KgpZLHdaDaGfGaTtxN4Y+WB
         H/CJdaQFPbAWQCnFzYtPGKN1QkwYZSiWnZZWmULQqa/bFv3n6ZhQNb9UR0YLb7eIwF88
         MyRJ0qjAigZL31HgA5wp/5w76JmUELcMTl8CI3QGNlAc12JwMb5CtJ1m259sH9gRKMwc
         e3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=8ZYEXUZD/Njcb2hmIShImYXofOfpmgld6VFTbaXRQi4=;
        b=sF5DQw8ERFuPQbyoCsQr0A+7A2Uz4TWu4OgCyY4BKQqQg9xObHKbY4GvPSOYTV7xzr
         6hIZ8Q2fuhIsS8UqIPoDUj5DHP1CEUoAd9xbiFv99RpfWGc2LnpQB7wQ5Ia5NkVB/Nqh
         Q/AmeFUrZJDAlK0359cFu/YzIIYXKKAMs0l+8+wl4O92AtZpDsllf5PapUXobtc1hzRq
         WxF0Shwipvt38GASWVjPumWAQPptCOCQ95rMPVJrCy+jtYNWk4M25nqstkbYP07VjZ9k
         lvtUOueqbdzTXMk78WPsBaT/cmtVB+TTnrTAqXlDDDiQiMs5YctIJjymeBro85zss0wP
         fG6Q==
X-Gm-Message-State: AOAM532Pfz1pIOpIVXGDh4YRLJxh+vxBVR6KWREDxnsF2cSUHwFihGMq
        hRgKENZf18vmUfTizVAGAFicEXcVSsv9ow==
X-Google-Smtp-Source: ABdhPJwO5SjklFtnPtWJMcmo25uLs1S3JYKunwO8582qcyQtDIX+um5SirfbKAEEIlocg5xV6SrtFQ==
X-Received: by 2002:aca:e107:: with SMTP id y7mr23046760oig.11.1626717071807;
        Mon, 19 Jul 2021 10:51:11 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id n23sm2912880ooq.48.2021.07.19.10.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 10:51:11 -0700 (PDT)
Date:   Mon, 19 Jul 2021 12:51:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Message-ID: <60f5bb8e15329_13f2e220855@natae.notmuch>
In-Reply-To: <1cb8774e-2489-e8aa-12ce-8d7e34b700ff@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
 <60ea2eb562f26_2a69208e8@natae.notmuch>
 <1e18c4ed-6975-5041-4b4f-75c4d3d21860@mfriebe.de>
 <60ec6d91deced_a452520825@natae.notmuch>
 <54644739-2138-8086-1696-d3c52960216c@mfriebe.de>
 <60ec74c513b2b_a45252081b@natae.notmuch>
 <0d7bd249-2aba-236a-9f93-3a5b30182d15@mfriebe.de>
 <60ec93155663f_a231f208fb@natae.notmuch>
 <3a84e4c9-4e48-1cbe-4fe6-150ff56c8508@mfriebe.de>
 <60ecbe577a086_a6b702082@natae.notmuch>
 <d3678ef6-1bcd-2666-87dc-751aef2ca1a7@mfriebe.de>
 <60edb8ff814cf_ab6dd208d9@natae.notmuch>
 <02f1f12a-0ff3-ef46-fce3-e222b2867309@mfriebe.de>
 <60f1d650e2667_330208e@natae.notmuch>
 <1997ca3b-117a-e19a-0dee-7342a2f1a0e7@mfriebe.de>
 <60f1f4c3dd8b1_14cb208c1@natae.notmuch>
 <fedbfe1f-9e6d-f46f-ca41-e176a30e938c@mfriebe.de>
 <60f22aaa6a4f1_1f602081b@natae.notmuch>
 <e57f1d19-d574-5ba5-efc1-abb8ab2a8c01@mfriebe.de>
 <60f33f8a7c39b_507220823@natae.notmuch>
 <1cb8774e-2489-e8aa-12ce-8d7e34b700ff@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I already told you I don't think this extended discussion is of interest
to the mailing list, and that's why I removed it from the receipients.

I'd be more than happy to continue the discussion privately, but please
don't add the mailing list again. I won't reply here.

Cheers.

-- 
Felipe Contreras

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9D7C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 09:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347951AbiFUJXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 05:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348034AbiFUJXN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 05:23:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF0012A83
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 02:23:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k7so11995445plg.7
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 02:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fcnfxK2qg+/jvIzxZ0Rzn04TWWl6YYhz9ZYKtybL/qA=;
        b=JYX9ExEvDcwoFKFiJnFeT1o1fxayRi1hG0cLm/E1Pj28CJ1YJGF5NxZLRKN+wmpIyl
         /kVRTRkRtFUcTHImNQQzvmRRzCG0o9L9aBxjKgfNRpTUmV7lDaQooXclDXOPvI1QYVee
         i/mSJQwq2VZ3Ng1Ye5C8/hzPMVeQZIeBEYbHhG3rP9h/aK3D7DT5T3xgtrwEj73R+XN3
         QGxBx2V8Tesjz9CLoLUNBtNgXkVCC3k/mrH2OEbHLanypszTpAaHoirt33ve95drWjhL
         iqjSKQ4P/Iqp/M+2M5V2if9L9m8AiMEondvuFjDWU7pPJyBLfayMaxTCAPEif9EZhA+H
         IxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fcnfxK2qg+/jvIzxZ0Rzn04TWWl6YYhz9ZYKtybL/qA=;
        b=OXUsWmdx9sSm1kIJ/iSUffWVjL9gDRunZpcD1B4q5xCorrCZHE3C0V38dWIzMs7xjQ
         vRJTkKHORZbudhIbzU7lDR0hvPzE2lKpf1JSuNw+dz39SLMhid8Ql12IuKmCLbUXBMDN
         ta62wDOyJx0rLpPNL9fGZGkMX450FxOrBLJ6mbYg7bNSf3Hey0tvikxcd4xGfVHUIiwu
         PIeBh2HiURPSfwieb2qItO3ayVb9vv7HTdOoNHDAxZyfToDs7q7bIMbKkv7G369uH2fS
         3p4YfG1dANRK6FagL20KY2SKRF8IcBm/OP0kyRXjCD3GL/M6wJ9xNoDhk/2wVAAnD/Nr
         HviA==
X-Gm-Message-State: AJIora+5Nhe3kkGV4quV7xTpcrCnu0A/RYux30iUShaT4JmPm702+/3x
        bR/bN5ua1nAwm46cDFNAhnk=
X-Google-Smtp-Source: AGRyM1vY1zyY8Y3iVEu4JJgJpVJ1Vjl9FN25kpRAMfDpTGTILRlIOFjP9nlzrOmsNw26gJZp7kRdVw==
X-Received: by 2002:a17:90b:4b8c:b0:1ec:c7b8:7cb9 with SMTP id lr12-20020a17090b4b8c00b001ecc7b87cb9mr3151283pjb.86.1655803392060;
        Tue, 21 Jun 2022 02:23:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:4060:e8c:d9c4:a028:bb47:21:6f27])
        by smtp.gmail.com with ESMTPSA id i188-20020a62c1c5000000b005187431876fsm3368591pfg.180.2022.06.21.02.23.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jun 2022 02:23:11 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/6] Documentation/technical: describe bitmap lookup table extension
Date:   Tue, 21 Jun 2022 14:52:53 +0530
Message-Id: <20220621092253.21667-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YrCsricF+2rQXiBk@nand.local>
References: <YrCsricF+2rQXiBk@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

>     In cases where the result can be read or computed without
>     significant additional traversal (e.g., all commits of interest
>     already have bitmaps computed), we can save some time loading and
>     parsing a majority of the bitmap file that we will never read.
>
>     But in cases where the bitmaps are out-of-date, or there is
>     significant traversal required to go from the reference tips to
>     what's contained in the .bitmap file, this table provides minimal
>     benefit (or something).
>
> Of course, you should verify that that is actually true before we insert
> it into the commit message as such ;-). But that sort of information may
> help readers understand what the purpose of this change is towards the
> beinning of the series.

The performance tests cover tests for command like "git rev-list --count
--objects --all", "simulated clone", "simulated fetch" etc. And I tested
it with both the Git and Linux. In both cases, the average cost of
"Without lookup table" is bigger than "with lookup table". The margin of
difference is bigger for linux. Though, I need to fix the calculation
of xor-offset (see my reply to derrick), the fix will not affect the
performance too much. So, what you're saying is true. I think I didn't
write the bitmap out-of-date test though.

> Here and elsewhere: I typically use my <me@ttaylorr.com> address when
> contributing to Git. So any trailers that mention my email or commits
> that you send on my behalf should use that address, too.

Ohh, sorry! Will fix it.

> It the space between "(0xf)" and the first ":" intentional? Similarly,
> should there be two or three colons at the end (either "::" or ":::")?

Yes, it is intentional. My previous patch (formatting the bitmap-format.txt)
uses nested description lists. ":::" means it is the level 3 description list.
The space is required else asciidoc will assume that it is level 4 description
list.

> I remember we had a brief off-list discussion about whether we should
> store the full object IDs in the offset table, or whether we could store
> their pack- or index-relative ordering. Is there a reason to prefer one
> or the other?
>
> I don't think we need to explain the choice fully in the documentation
> in this patch, but it may be worth thinking about separately
> nonetheless. We can store either order and convert it to an object ID in
> constant time.
>
> To figure out which is best, I would recommend trying a few different
> choices here and seeing how they do or don't impact your performance
> testing.

I think at that time I thought it would add extra cost of computing
the actual commit ids from those index position. So, I didn't go 
further here.

I still have a feeling that there is some way to get rid of this
list of commit ids. But at the same time, I do not want to add
extra computation to the code.

> A couple of small thoughts here. I wonder if we'd get better locality if
> we made each record look something like:
>
>     (object_id, offset, xor_pos)
>
> Where object_id is either 20- or 4-bytes long (depending if we store the
> full object ID, or some 4-byte identifier that allows us to discover
> it), offset is 8 bytes long, and xor_pos is 4-bytes (since in practice
> we don't support packs or MIDXs which have more than 2^32-1 objects).
>
> In the event that this table doesn't fit into a single cache line, I
> think we'll get better performance out of reading it by not forcing the
> cache to evict itself whenever we need to refer back to the object_id.

Ok, will look into it.

> I mentioned in my reply to Stolee earlier, but I think that we should
> either (a) try to remember what this is for and document it, or (b)
> remove it.

Let us for now remove it.

Thanks :)

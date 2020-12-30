Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC7C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 22:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9042207A6
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 22:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgL3Wei (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 17:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgL3Wei (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 17:34:38 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019B3C061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 14:33:57 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 9so20200132oiq.3
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 14:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=YPgqCWl7FcYB/XdlArlEkFQ1xiZSilUPSDVxme998Rs=;
        b=c01W5lJDDPhBeejIbkrFtv5N2u/Cicn9sTcJLlnVCOcj6F2ISQcTamX1RZOzQN1hVJ
         caAHDdUwykeoFFShkRIsOPswAAn5S3QXJccAjzbhRmidOyFPhewaGsxGIujJty4JKfU5
         24U9kQIzip7ZBhAtTEL93QkjCLB1KL913+zHvRr+/8puWSiqRY9xnn++usPA9QhzfI3x
         DMwRWeWeiKYYisMg6BOtJB9hKjFhN4+j5Nfw4xCqgBRVP7Fuf4sSnIYiouXytMJferT4
         g2MDPOknAOyiCZ1R+swfZaTUx2zaKU4YLGB1LKvgYN+iGWznML+B7Yy+aWAwtlUkg0F3
         5qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=YPgqCWl7FcYB/XdlArlEkFQ1xiZSilUPSDVxme998Rs=;
        b=d7BkW/4QJ+NINqDQbwRYyVTR+cUVyQrOsz2MR+tEKXtu5s5xQy3Vi3Iwzk3MYczTSL
         y8JL4d1Q553Y3FDZqvpCPjHk0MAN3bAlo0housrEZ3f81lW7Z7feUFKk77FtvO6b9rw3
         jKtpwClrU5EAl84Xic6/rpz+MzLmQoBgd7P1/pO4t8Fy/ZqGCulLyyVD+GgxWOP0u4L2
         chxo8MFbZkfvXDnQmSbeLkrsfD2X/0x0jXnwIvLg7b4RzDHXLZaeFapz/Rg5N1ZTVJAI
         tbHUQbFpbfE3s3dBMFbacF2AByrl4MOGAYZNIxrRhdCJJB7j0/A7FmgoZtiy9H/9v5g/
         3D3Q==
X-Gm-Message-State: AOAM533DBqk9V7TPspxBFMqekCAjrbqalVX3cEAtIgjz4jbzE0SXG9p/
        nNFOsAYcMECynh9h7m6N5nBtX2Cn2ndN1A==
X-Google-Smtp-Source: ABdhPJxsl47tBrdLw6/WnJEHSRJ2OAex6O+ESQnVXi3Y0FmtncDjsHrngq2j4R7c+/qkiqPby3Ldjw==
X-Received: by 2002:a54:4481:: with SMTP id v1mr6319908oiv.42.1609367637311;
        Wed, 30 Dec 2020 14:33:57 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id a22sm9517982otr.75.2020.12.30.14.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 14:33:56 -0800 (PST)
Date:   Wed, 30 Dec 2020 16:33:55 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Seth House <seth@eseth.com>
Message-ID: <5fed0053494bd_8cde92081e@natae.notmuch>
In-Reply-To: <nycvar.QRO.7.76.6.2012300645400.56@tvgsbejvaqbjf.bet>
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
 <xmqqim8r36ba.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2012300645400.56@tvgsbejvaqbjf.bet>
Subject: Re: [PATCH v5 0/1] mergetool: remove unconflicted lines
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> On Thu, 24 Dec 2020, Junio C Hamano wrote:
> > This breakage is possibly a fallout from either this patch or
> > 1e2ae142 (t7[5-9]*: adjust the references to the default branch name
> > "main", 2020-11-18).
> >
> >   https://github.com/git/git/runs/1602803804#step:7:10358
> >
> > I cannot quite tell how the two strings compared with 'test' on
> > output line 10355 are different in the output, though.
> 
> I spent more time than I cared to spend on this, and still have not quite
> figured out what is the fault, but I can state with conviction that the
> problem is not even introduced by any merge into `seen`. The
> `fc/mergetool-automerge` branch itself is already broken:
> https://github.com/gitgitgadget/git/actions/runs/441233234

Yes, if you didn't have me blocked and read what I said a week ago in
[1], you would have saved yourself that time.

Seth House has claimed the patch series though.

[1] https://lore.kernel.org/git/5fe4bec2da21a_19c92085f@natae.notmuch/

-- 
Felipe Contreras

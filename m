Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD398C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C75623A58
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbgLRCGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 21:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbgLRCGU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 21:06:20 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1817C0617A7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 18:05:39 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id f132so1194618oib.12
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 18:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=UwkXmLryqzbArRue7VLisbRyX26+EQ5xixi+eqZc/kk=;
        b=KfrkU468yeBHxitwJJjGIt1QSzS5dhcYZlWxLWgf5cr4hYAAYc4rJtP+ET9iJjOA1D
         gyvy+QTVCectcRLDrqg67kur187APVyTSmPhF3gVt1aobmMZeLVafs2H9HAp8eYyO/Kg
         sJVNKmAMcCnKdbU1hTvYFYDrl5m4ZwSwScyddMR/6Gha4IsQOe9YJIPF6BZ/ac0Ik9AL
         XWZ0YPUUqP1T7wWtDafVrijRHHpGdRBm05Dhl+zA8If1nLMtt3itdWfks/gaRupnosGJ
         RHYlvIxu1Juw26jXx/ZfZIUeUSsXkNe1Yc/iZt17nxTsIbYWtpEigIY+0fPz+4JIB8Yk
         7ADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=UwkXmLryqzbArRue7VLisbRyX26+EQ5xixi+eqZc/kk=;
        b=mvp/gcq1aquoNNZ84gVIOXmEAld7+nuXMsQU4ga95vSrQxmbR+aDGrMQ8VylbsfPIS
         cIoJ/gqGHY/H7qKAeyW0tWSOxLki9je+NRZ2t9Jo/y2t1JJravGw7g42KiiRwxxV3xFF
         htdDjAfEqGddE7WT289KkYjim9vrQmFAQXMYVdn//FjC10TsRgRcExCrhNVOfgtZLpc/
         KsG5dpxpJ3WkJLZE7gboNxVZ3WV1np4g8/ae0HmCR4MDK8D421PFQ7lxb6dOY7V4qyFB
         ibiJlIFM0Sk1K8ScqPzvWIQAqvUBe5QtlRPUVRaGaYvuDPv9sGnhotQ2OIuqLL6rkpzU
         z+gg==
X-Gm-Message-State: AOAM532v56+mn41PitHmaGS/uCgdwG3oOUNfCT+jVVM2yldFN8CVmVhj
        2QPgem4I5Si6lM10zs8OAHQ=
X-Google-Smtp-Source: ABdhPJzscPN9P+KpWh1oCToo9Dqr6I0044DPreqn3ccq2UjNvFdXHVYBdt1iqfyhiWhiqORkE+LDRQ==
X-Received: by 2002:a54:448f:: with SMTP id v15mr1439493oiv.106.1608257139303;
        Thu, 17 Dec 2020 18:05:39 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q21sm1615604oog.30.2020.12.17.18.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 18:05:38 -0800 (PST)
Date:   Thu, 17 Dec 2020 20:05:33 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Message-ID: <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
In-Reply-To: <20201217175037.GA80608@ellen>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House wrote:
> On Thu, Dec 17, 2020 at 04:35:29AM -0600, Felipe Contreras wrote:
> > If you want to see the original LOCAL, REMOTE, and BASE, you can turn
> > off that option (or simply never turn it on).
> 
> Agreed.
> 
> Felipe, the functionality in the v3 version of your patch looks good to
> me and I think it's well worth including in upstream Git.
> 
> Would you mind switching the autoMerge option to be per-tool rather than
> under the main mergetool config section?

As I said; I don't see the point.

Even if I were using diffconflict, I would want this option on.

So it's not a tool configuration; it's a user preference.

> You're right that it will likely not cause any downstream errors; it's
> just a difference in preference. The tools that perform their own
> conflict resolution will likely want it off

What tools would that be?

-- 
Felipe Contreras

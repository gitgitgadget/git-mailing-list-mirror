Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6024BC433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 19:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42522613B1
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 19:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbhD0T7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbhD0T7G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 15:59:06 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E8EC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 12:58:21 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id w6-20020a4a9d060000b02901f9175244e7so1213070ooj.9
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=xiyfy58l34Ys9lsYfY26Iy0LDsVzKviTaeKL7J2OljE=;
        b=i6ZQNCiFVew2xXJxS/M5GhijPHel/j0bMKoR2NqHhiZMEZfOACyApib4VV+NG9R040
         aePECsMp7i2gFMzp4QLMaanniga5TzH4yauafTOgR8N1xQ3GBLN8oc105Kc8eA12Ui1u
         zMQLCGMfo3Xcv1fhx2qjxWip9Gv/BfkLXwNuzgRnOCUfTtogGU04htjysIeJnrzXRN6P
         eilIrwtbTFgr4WxqZ/8nZ204xNnEm10NcRP23s7um03B+JiE8cDFfq/Q0KY4DLc8Je8n
         PW0Xcv/jlqqHgfLwoE3iFnXTKGRjHq6HNRYNCSAEExlVLXX7m3eA5Im+kzxlGImNVnnp
         ypvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=xiyfy58l34Ys9lsYfY26Iy0LDsVzKviTaeKL7J2OljE=;
        b=ZrKBKgNR1t3Q9oP/e5arCdiywRqP3vqzmw28OVclIPn4DNNdaBPLBtxRKUVoVl3/AK
         7rWyu9r85HanwcoGzFe6p0Tzyxio6VLHEvtub2rZ+Fobf7kxGnED3baEbsA/JCf81JPJ
         ptiZNp1+CQimkJk8tdpgGqWLRnzsNtgqnP4vlYA7CkkkFTk7D4aQYgXZNEpG/o/lxva4
         6mHsJdX3PK1QRvE++Vx2JbNiFLIwhkDVybEmJLd8VcNJmZkc/ArH78ftKc0BWXNS1nSZ
         XyUt96Oc3va/li8SW+Yt+enaJrGdxNavJCevOFYIEsxcX/hzJoRPDGCYduiswP2V2tys
         lLqw==
X-Gm-Message-State: AOAM530rvkaML4qrRew65C6ufXDrlgwJZTzCJQtqchTVXV9X+FSY2o8U
        AIp1cUMtYxcvbD4Q2bMyOLI=
X-Google-Smtp-Source: ABdhPJybkMuO2Xm0pu9FwIQhX48rVDaX0yaxoamnSNWgB5GzEJaSEPQ/cI1ogkY1GlOd30A882N4ig==
X-Received: by 2002:a4a:db7d:: with SMTP id o29mr19165427ood.45.1619553501104;
        Tue, 27 Apr 2021 12:58:21 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id k24sm177261oic.51.2021.04.27.12.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:58:20 -0700 (PDT)
Date:   Tue, 27 Apr 2021 14:58:19 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Shoaib Meenai <smeenai@fb.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <60886cdb7c3a2_222c20818@natae.notmuch>
In-Reply-To: <87h7ju21kg.fsf@evledraar.gmail.com>
References: <79834D18-EAF4-4748-9B96-38AAA0760499@fb.com>
 <608391297345f_10cb920875@natae.notmuch>
 <87h7ju21kg.fsf@evledraar.gmail.com>
Subject: Re: [BUG] ** glob pattern in git diff doesn't match root directory
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason wrote:
> On Sat, Apr 24 2021, Felipe Contreras wrote:

> > I stumbled upoon a very similar issue (I wanted to find all the *.jpg in
> > the repository). I couldn't find another way to do it but:
> >
> >   git diff ':(glob)**/foo'
> 
> Maybe I'm missing something, but if you want to find all *.jpg isn't
> that just:
> 
>     git diff '*.jpg'
> 
> ?

Right, actually I misremembered; it was all '.gitignore' files.

If I do '*.gitignore' that matches all the files, but also any
$x.gitignore files. If I want only '.gitignore' files I need
':(glob)**/.gitignore'.

Cheers.

-- 
Felipe Contreras

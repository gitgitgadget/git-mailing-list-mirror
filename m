Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A08C48BE6
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 01:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BF0610A1
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 01:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFLBmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 21:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhFLBmA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 21:42:00 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7F8C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 18:39:46 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id q10so3487798oij.5
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 18:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=m0a8EGSBL87xaV5Q+nO+VJ4hbKTYOqhcTmFA6c7JTqs=;
        b=En2yMcrEvXbP7V55UHr303vk1f0RLgatoEvf7KEie/G/Pd8su5fe6rImIoKX86jIY3
         TCkQBD79/IgitPJYK2f21UaDNuS0Niyag96TedtLs+/wc0FwU+bmZCegXptxQaCQ0VjL
         hO79sGsjj8OWup31baXh+15Hoe9GzMdyCjFJfAb54ANGNIRLTOiUpzXaymbJxSAaJlz0
         a2pZx/mNUFb2hKp7GOKRy8WJgwph1tu5wmrNEvxJicF1Ts/MX4jz8T2nSXiJnZ9Gv3Tu
         XYpKczCfK6uJ6Rua4W+rtPZDCe0lS+IxeKsHnU38m0q1jGBCyGazDoVjhB13kuu/NBp2
         bAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=m0a8EGSBL87xaV5Q+nO+VJ4hbKTYOqhcTmFA6c7JTqs=;
        b=E7kjvBtaJP/TrrUrbtf8FQfX6Dku9qC0Y+zYmPE4hcJEeg7g0RMEQLXOcVPkFiUx1s
         Fx1E1l/BctEEQFJqanEZ2w5Q2ZPLveFXnksuyE4O/AmWGEPOy+XFbX9EK4/JbTgxazxp
         qPx0LURL2sU0JYv2HYMIXwUDTh3Woz9J0Dgtll8Ubfr3gNJaeHhyx6DLD+UWnI0gkEpq
         YtXNHDNdatnnOsvBVi8Z4BSRFRLyXDxz3ahUs+tyS6D5cnJyBfXQMLnWriI2v4OFfeLv
         xRAC9zP8d3hG1G1gi+ERf86W0NYAXUPFmg+sbK+zSfYwpeHu//jUXnWNunWRmA7ysD3X
         Y23A==
X-Gm-Message-State: AOAM532nLyo7k8f7Byb2kijvnRzzRjApWYUPoijwc8iwQiDDFvj2VE98
        xp56EBMsMWUPI1LTx3re15U=
X-Google-Smtp-Source: ABdhPJya2VJoLXBA4GFrFBGoCjWJY5rlzfJKeepX4chfmmIDn5rd6havVCbOmitA+0ndZYS18FhFPw==
X-Received: by 2002:aca:e142:: with SMTP id y63mr4199980oig.57.1623461982224;
        Fri, 11 Jun 2021 18:39:42 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x13sm1638369ote.70.2021.06.11.18.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 18:39:41 -0700 (PDT)
Date:   Fri, 11 Jun 2021 20:39:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c4105c2de76_bd9208d2@natae.notmuch>
In-Reply-To: <57c48ef2-7fac-4d3f-e74b-a3ad44c49480@gmail.com>
References: <20210611202819.47077-1-felipe.contreras@gmail.com>
 <57c48ef2-7fac-4d3f-e74b-a3ad44c49480@gmail.com>
Subject: Re: [PATCH 0/2] Avoid gender pronouns
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> Hi Felipe,
> 
> On 12/06/21 03.28, Felipe Contreras wrote:
> > The latest solution looking for a problem [1] is to use the actively
> > debated among linguists singular "they" [2].
> > 
> > Leaving aside the linguistic intricacies that not all singular "they" are
> > equal [3], and the overwhelming sentiment that these kinds of political
> > discussions don't provide value for this community [4], the "issue" can
> > be easily solved by simply using different wording.
> > 
> >    - The reviewer herself
> >    + The reviewers themselves
> > 
> > Problem solved.
> 
> So this patchset avoids any gender pronouns by changing single subject 
> to many objects (plural), right?

That is just one example. A good writer like a good programmer uses
different tools for different situations.

Another tool used in this patchset is to make use of the passive voice:
she made a mistake -> a mistake was made. Another is singular "they"
(but used properly). And another is to just completely reword the
offending sentence.

Cheers.

-- 
Felipe Contreras

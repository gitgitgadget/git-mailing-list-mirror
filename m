Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC6DC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 05:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E39236F9
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 05:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgLQFoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 00:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLQFoH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 00:44:07 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5962C061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 21:43:26 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id l207so30994458oib.4
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 21:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=EUgQn1RlspN0Bv704kMJ8PTEHueM1DFNi1gfElRQdzI=;
        b=r1MgySsn9MJAOOFqyEAd5o5/gHwQqt2X2M7f9w44n/wFezJlBaQ+TX0Co5ElPG5FqG
         dj+d3/JW1pERdLByO0jqzu7nvphAUzXZLeqGN/vjsT6ErUkJ8Sokq0t65Dn8wV4R7POE
         r5LnJELHUT7O00mw+mfMsWg+j5NUge1axCrVQB8q+K8kW62xFRlcNm/YFpV6W9rnlRB6
         RlxetORdj2Q2wvpuIGlFK+QBDQ933MPfaZNVZitnQn21dbjF7ht2Uq4m8p5ZE5x9Z2f9
         pLzlZEW3ks5QrEIcWBKvwRXyWhqWNLeGBYjzdPBbz5wzrReUk/fnHiCVyf5UYMxyqLT/
         fJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=EUgQn1RlspN0Bv704kMJ8PTEHueM1DFNi1gfElRQdzI=;
        b=TOKoBLjpHqC3xrkGNKlyVq9FTSjIQfxf0X7zb6roX75HOkTEs/Z78WxSihy9e4BY+i
         8+MPerL/ApOJVh1MJqST1L7fVw3AaxmhW+F+iapN/8+8Ej8D/zfS8NiplST2kVOUydJo
         Ezd/x7D9keCYeDi4W2IYktMFVjxtQbQjEov/gVOxX0U1g1eEFTCiBKjpZem6rjJf5m4n
         GemzWLEF1FhW1ejrAXu0uVM+e8NhQDud5P+fwb/6fB2YepDYipyX0LiYLvhRqIwd/yGr
         nsoSD75m8/IpIgoJ4W35HALXyP7Es7agBX1V0pkDdCUKAIZRZf5p7k3iLTvLZJV0c0mb
         wd5g==
X-Gm-Message-State: AOAM531MAw+h+w79KSTuQhvTOkQJbDEvrTu06gSvLXjyifBSFNqRAfXF
        HY16iE0oXfmYIomEAbzy4uY=
X-Google-Smtp-Source: ABdhPJxOpmxbt0HsXn7BNDj3Fwia5auhTxlx34DvW2/RgvuYTRIA5FDifqNH3trb9SDco/67pD7V4g==
X-Received: by 2002:aca:ef44:: with SMTP id n65mr4102530oih.90.1608183806089;
        Wed, 16 Dec 2020 21:43:26 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id w8sm1034456oos.37.2020.12.16.21.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 21:43:25 -0800 (PST)
Date:   Wed, 16 Dec 2020 23:43:24 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Message-ID: <5fdaeffc8b6c_d0e262088b@natae.notmuch>
In-Reply-To: <xmqqmtydypp4.fsf@gitster.c.googlers.com>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <5fda9b3f4979c_973f2083@natae.notmuch>
 <xmqqmtydypp4.fsf@gitster.c.googlers.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > The implementation details of the proposed patch are not relevant at
> > this point; it was just to show an example of what Seth's diffconflicts
> > vim plugin does.
> 
> Sorry for commenting on the "irrelevant" part; as the patch was
> marked with RFC label, I bothered to read it and tried to give
> comments, but it wasn't clear which part was welcoming comments
> and which parts were off limits ;-)

All parts welcomed comments.

I'm just saying the idea is what's important in my opinion.

-- 
Felipe Contreras

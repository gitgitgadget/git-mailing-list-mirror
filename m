Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3267AC433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB972073E
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/9N9hE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgFQUwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgFQUwe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 16:52:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B906C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 13:52:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x25so3165738edr.8
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to;
        bh=xR3v8wuLVfwRYG/YwBGpL3pZirEb7vNOsH+pqNnNpno=;
        b=s/9N9hE3byvIiP6OgbYw+O3EZFjUYeTCVqvryfhvwy9uKZq9jUHfjR60uDhQRaajaj
         HeklZnkJ1fMsLDgzUpnMN9s/E6pgAznAtdAFknoPxxf6blSF1lcGK61YfwHQ4Z63Im6j
         c928JLSHVgvfwxulSIGzhApYwrb8fhvdrMwMD8mW3dWTLM+6uNLERJixYze+mP2DoRdL
         D5TXswE7Y1YeBUW4+aydvPOO+QAal92KCuaZWEwkULrbtiOURJd8XGXUGbJ/OlE0YHvh
         IV8a2+YM/LU0t32+nFgxRPjlxbdGKDiqk/K7OhOseE/CkX7VWMFHNRcFxQgheyDt62n5
         LyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to;
        bh=xR3v8wuLVfwRYG/YwBGpL3pZirEb7vNOsH+pqNnNpno=;
        b=iv5mbXQhwktQr1mub+GpPfM0Yc2Rejz1Qvfzh9uzhUiDxD0U9gleRuhqL343fJPF75
         sW2k2r/CQKdSRqnziFh2EWCM9p+h2uTmxbX7oaQ+udsEftY1x2sN2VFhc+JjoxVKD+t5
         WRxHo1qm+rUDG2hZk7CkdXVwHtepmqooAHhPDBxE85CeWkfouGeMPbhAr9F82VWT2Wa4
         9q0ONQqEQHlbc7a/nB4tNdBqnLvG5xuvZ+JkUqNWwxHYRd1vCd72eYe2WwGCcV9PKdWp
         TJFlToVr3dKUNyEd7k7piB7+TPcGoXFa5CRwX6uzSmwPi95kMFmo3bUJpzIYK4awxjQr
         ojgA==
X-Gm-Message-State: AOAM5319vwITblOx4KYhITPNE63C6aEQpe5jzPtTKilg7kIEGywb04Cf
        UNtp8dr8noM1iCxW7qamIPk=
X-Google-Smtp-Source: ABdhPJyVOj1Ga8Lrn34A6KTEar9OmUvHNgpAxWdqTFv46R5pHjTqpShqd22lU8zXxaLWX9wgA1O2zg==
X-Received: by 2002:a50:f19d:: with SMTP id x29mr967371edl.215.1592427152591;
        Wed, 17 Jun 2020 13:52:32 -0700 (PDT)
Received: from localhost.localdomain (ptr-uhky5bq0ghslncy72e.18120a2.ip6.access.telenet.be. [2a02:1810:1c39:a800:a975:5a77:183c:f046])
        by smtp.gmail.com with ESMTPSA id p13sm478825edi.74.2020.06.17.13.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jun 2020 13:52:32 -0700 (PDT)
From:   ZeeVriend <zeevriend@gmail.com>
To:     lego_12239@rambler.ru
Cc:     git@vger.kernel.org, Zee Vriend <zeevriend@gmail.com>
Subject: Re: Rename offensive terminology (master)
Date:   Wed, 17 Jun 2020 22:52:07 +0200
Message-Id: <20200617205207.8240-1-zeevriend@gmail.com>
X-Mailer: git-send-email 2.11.1.windows.1
In-Reply-To: <20200617074940.GB18445@legohost>
References: <20200617074940.GB18445@legohost>
In-Reply-To: <20200617074940.GB18445@legohost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Zee Vriend <zeevriend@gmail.com>

Dear Oleg,

Thanks for your feedback. I have no knowledge from cyrillic so it is nice to hear from you! As a fact, in French "zero" also has
bad meanings. But, positive meaning exist also. Building up from nothing as example I give you.
Now if my suggestions are not ok we can try something else. I thought alternatives can be "source" and "root". Both are used A LOT
by programmers everywhere so possible they all agree! Let me tell you "source" has EXACT same meaning in French, I like it a lot.
We all write 'source code' is not?
Maybe you have other words to describe this. We can all share the best words and select the best agreement. A true inclusive collaboration
from all!
Let me wish you a good day and happy moments next!

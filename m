Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF254C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 00:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6D1613AC
	for <git@archiver.kernel.org>; Tue, 18 May 2021 00:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbhERAgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 20:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhERAgA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 20:36:00 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45441C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 17:34:42 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w22so8149088oiw.9
        for <git@vger.kernel.org>; Mon, 17 May 2021 17:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=nkKi+li5pJjI1JPmrYAblu79YW3+Q7/+cMGIyZumgQI=;
        b=OnOKp0wAGqNrWSdXccgXMlvXaZ/vMvdbZ4no0oT5ph37g2rtiF318mNm1eicVyzg7e
         gQ/mtf0YxSEndt6Zs8k+uvenqw688poX56dRs8uNu15aKKhca3+XdJt+5gRq4lpfqnHJ
         e1KaGYmHn6LHSFHSCPionk+7T4ERel2+Tr0O1HW8d6PBs9XJJcbGKEmmtHB62kYWSUzm
         ddMt03Aa6uUDONYLbxYgEPqHDPxZgPXcwkLp7yjkmQohpnDYolDb/NnPfAlOgKlTN2sa
         7OL+O71rT+/2se8amSN68QyotqyoqoR88oyn4aNOgebLhdUmv8MyZH+Hr8CkxR74oH3l
         q2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=nkKi+li5pJjI1JPmrYAblu79YW3+Q7/+cMGIyZumgQI=;
        b=Zu9Xo1wePcEw7l5rNxhmlRynVppw1RHnk3rBd5cjyL6A3tAFI2Mqaa+gC4j0IHpztQ
         Ls0m0X992RzyZzhQTLs97ne7HBZgL0eCf9gRx3jP42WRzKu4FDVZHCXog5s2KM5AwT8T
         zDfjwdeBBs/7oaNFEEx3Ryi7YrzmJyLX/gSLUOZzAmULVLrRJlw/RWCw/9PrNhJ/IT2a
         TMy2sEDZ6ofjxJGxiDGmqY6ECrANQVqKR7eKP7NZZagw2nt5RhYIfER7kUlU6McvGSC5
         +HA6ZHGS3OsVuhQ1RdPAz/h0/YVvly2hRi9orXisU/6hM+2TgkHIZsoNArfXZcuf95jB
         mDgA==
X-Gm-Message-State: AOAM533rSgW/H7aL1hdRMuoatWzmdUo5KkxHCZIaHNWSAPU+8oLlLjyq
        vsh1w8Nc/nZ+hVpT75GaCeM=
X-Google-Smtp-Source: ABdhPJxI3B/qgWXuqH1jdiCBeR4mDFy+H8/rs0Ave8kXIKudyu+fhELOa7pHMyDVao0OloWaz2LBvg==
X-Received: by 2002:a05:6808:d4:: with SMTP id t20mr217876oic.146.1621298081745;
        Mon, 17 May 2021 17:34:41 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id e20sm3292977oot.11.2021.05.17.17.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 17:34:41 -0700 (PDT)
Date:   Mon, 17 May 2021 19:34:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Pratyush Yadav <me@yadavpratyush.com>
Cc:     Allan Ford <allan.ford17@gmail.com>, git@vger.kernel.org
Message-ID: <60a30ba0da18_1461a9208eb@natae.notmuch>
In-Reply-To: <YKIyD3QXQYHJVSS0@coredump.intra.peff.net>
References: <CAL-6oQo3KDrrw+DiQsJJR_2tMjrLY3xu5ARJz0SJJ-naQqo8Rw@mail.gmail.com>
 <20210516090133.xe2cooqzr2knyt46@yadavpratyush.com>
 <YKIyD3QXQYHJVSS0@coredump.intra.peff.net>
Subject: Re: Git Gui - Searching for in Google
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Sun, May 16, 2021 at 02:31:33PM +0530, Pratyush Yadav wrote:
> 
> > I think this would be a good idea. I have added Jeff in Cc who I think 
> > maintains the git-scm.com website at [0]. Please create a Pull Request 
> > there to add the screenshots.
> > 
> > [0] https://github.com/git/git-scm.com
> 
> The site is developed and maintained collaboratively, but yes, please
> point people to making PRs at the repository you linked. :)

Ahh, so we could have actual fonts in git-scm.com for Linux? (not the
same font as <p>Hello World!</p>)

https://github.com/git/git-scm.com/pull/1604

-- 
Felipe Contreras

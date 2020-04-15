Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A95CC2BB1D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 02:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6728B206D5
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 02:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3II6MKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389778AbgDOCRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732702AbgDOCRf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 22:17:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852BEC061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 19:17:35 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x26so801287pgc.10
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 19:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UkCY9E4RJTxOZhba6DHzb3ng4jF2v4dobVTZPLh7NVM=;
        b=t3II6MKeOnBgRVfK+lHXcQj/K/M91TcTYEXaCLNhLaQ4RIutYo/fPhGpSrDWpTR4P7
         valkh2FDiA+Sshq7Ld2VUb+NRk6c66yZlEJpFE0TVOcKpmZtDyHKL6lOJScDHg7n03gg
         SvUEwzdWZ+QboZwgwUX7MNuU1RhneY6PjEYecobAfWeCBcJhthB49r5acQXqetbhM6iw
         8g/yM5iP2z4ffB4hx4k1pv8aXrU/d+veu7OXtCHE3j2Rj92VZ+vfwUzt8AJMAIVmZ3Su
         1Y7l/ac4W1fDvyVX7Z/xKlWZ4V4+eNKXrIFPS4rPZOm+pGVXugrddNZGEUPMvAwXKfq1
         wPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UkCY9E4RJTxOZhba6DHzb3ng4jF2v4dobVTZPLh7NVM=;
        b=Cl6ue/HicEhmuICSYp9MR3PTofrA4yR80+VkVXXS8/PDfDU8jxa+6ZM3U4KDyFybGF
         zYywEoe03/bT/seru97RLkywVkpwPMBw0gZMxFVU6paJpPeMGtlya2z/wsCEbV5BqTkG
         FZM3tWeNO1FKUMbLbDXyFokiIYc5QPobZoOYn/5NfXwD0RQ37D4xYkp6VgfePfcMaD+F
         +eTVVat+05KZZYkMilQ1I3PDTucDKUm8imBH5JBxNHr9NsaZDxbTZo4i69CpbafQIWrQ
         ZIfb4N3RrUYNyqnixokV4rvXHifOcblVblppErKRo+TIMVoW99KOI9OKJRfGtLY8vCn3
         JHcg==
X-Gm-Message-State: AGi0PuYT8e1wbVwkWUR3FDjKUQEn3gnlurbrQNnKTKA6XTu2H3bbzqR1
        cKrOU/EDF3d7ioLKLbO9LI8aQop/
X-Google-Smtp-Source: APiQypLTWW+9V6mfWdxKxvCmGvRPwKmH7YoREaZdk30brMNZNyx3CxSPipbUVnRtIKtxb5DmkAXtLA==
X-Received: by 2002:aa7:8b46:: with SMTP id i6mr26587792pfd.60.1586917054959;
        Tue, 14 Apr 2020 19:17:34 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id r23sm12550737pfh.162.2020.04.14.19.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 19:17:34 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:17:32 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] date.c: allow fractional second part of ISO-8601
Message-ID: <20200415021732.GC19025@danh.dev>
References: <20200414000324.GA2751707@camp.crustytoothpaste.net>
 <cover.1586856398.git.congdanhqx@gmail.com>
 <45676f4a7d001dbd25bbae531cc2ae5fc53936bb.1586856398.git.congdanhqx@gmail.com>
 <20200414201733.GB1879688@coredump.intra.peff.net>
 <20200414234958.GE2751707@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414234958.GE2751707@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-14 23:49:58+0000, "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> On 2020-04-14 at 20:17:33, Jeff King wrote:
> > On Tue, Apr 14, 2020 at 04:31:54PM +0700, Đoàn Trần Công Danh wrote:
> > 
> > > diff --git a/date.c b/date.c
> > > index b0d9a8421d..2f37397beb 100644
> > > --- a/date.c
> > > +++ b/date.c
> > > @@ -556,6 +556,8 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
> > >  	case ':':
> > >  		if (num3 < 0)
> > >  			num3 = 0;
> > > +		else if (*end == '.' && isdigit(end[1]))
> > > +			strtol(end + 1, &end, 10);
> > 
> > This just throws away the fractional part. I doubt anybody cares much
> > either way, but another option would be to round num3 up or down.
> 
> I'm happy with truncation.  It's simple and straightforward and will be
> widely and intuitively understood by programmers, who are probably the
> primary users of our ISO 8601 handling.
> 
> I do appreciate that you pointed this out, because it's a good point.
> 
> And overall, I agree that this seems like a good fix for the problem.

I'll reword the subject to "throw away fractional second part of ISO-8601"

1 second is not that big, and and the logic is simpler.

-- 
Danh

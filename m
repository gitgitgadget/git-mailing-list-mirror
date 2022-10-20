Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B66AC43219
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 19:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJTTB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 15:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJTTBW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 15:01:22 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA2B18BE22
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 12:01:20 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f8so577974qkg.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 12:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Hgp5IXxWDuAfjH16Ydro5/OIkVP8yJS2eXgdEcGUs8=;
        b=ZAp5W4Wx2HmjSC8ikQFFFarwTGsc6Hqm+RlC3CM57lPo4pUpkJVWcikkfuGILswz5Y
         HtiUYNfS28BpBlk72J78lB1QZi5rEVy0pGD25kb6ODYoHf4HjjHdNAm63yfrrT5ZUiDG
         qmKNKdYXN6Xt8rDW7JdC69IwWclChIwqcP7ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Hgp5IXxWDuAfjH16Ydro5/OIkVP8yJS2eXgdEcGUs8=;
        b=U8AQ+qxnsIGHDZ+SpX0BM+lsLcR5NKLA3WiSFSYt3GERi1BLgvFvPZZPyZ7UABuv/V
         CxuO28u1/POESnm9UzXkGRGmqkIGnHl37DercWTfy9WRVzSaVEv03tB5Zp/FQKRHfBp+
         Tm+tMks6UQQpl88MK9u3hCsGyylphiW9c+TJZK//Qgo/Dxiq+8tomhZo7di97uIXF0Gk
         UL9duRGv5AbJnvilIGmh7staFl0IgFchR8uYe/5StVqaSpBLrpE6syDucQq9SqVMSsBE
         kWTZCDllTF+upNZjq7LqNC86q65PlKZ6bszir2camxGYOXuvMkRz9o5/fgS8PqFqop0N
         K2RQ==
X-Gm-Message-State: ACrzQf1RwSS/ouWEndsvJUKKRgZ3mqaEKNCM0mu7J4rIlT0Spk5kq3s5
        y+ONMQJL8/GXJcwtsyl61ZhHwA==
X-Google-Smtp-Source: AMsMyM6N0wl88LjZRHe2+gGMiKYSQ8KnNQSQ2dn7bQuvNLz0bJjQ9F+9X3rq2fCbrf3+wGHqEwWR7w==
X-Received: by 2002:a05:620a:29c6:b0:6ee:cf89:40cb with SMTP id s6-20020a05620a29c600b006eecf8940cbmr10748312qkp.107.1666292479879;
        Thu, 20 Oct 2022 12:01:19 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id s3-20020a05620a29c300b006d1d8fdea8asm8191140qkp.85.2022.10.20.12.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 12:01:19 -0700 (PDT)
Date:   Thu, 20 Oct 2022 15:01:17 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>, git@vger.kernel.org
Subject: Re: git-send-email with GPG signed commits?
Message-ID: <20221020190117.va67kbrmvg4xxit5@meerkat.local>
References: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
 <Y1GJAart+/yFc5MR@coredump.intra.peff.net>
 <xmqqr0z2s7w4.fsf@gitster.g>
 <xmqqk04us77b.fsf@gitster.g>
 <Y1GUDbtFIGZu0BKD@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1GUDbtFIGZu0BKD@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 02:31:41PM -0400, Jeff King wrote:
> Yes, like bundles, it is losing some of the flexibility of an
> emailed-patch workflow. I haven't played with b4's attestation too much,
> but I think it slots into a patch workflow better. You are signing the
> patch, not the commit, and commits which are made later can refer back
> to the emails, which people can then verify. That's not a signature on
> the commit, but it is a paper trail that can be followed.

That is accurate -- I've looked into attempting to preserve git commit
signatures via sent patches, precisely so they could be applied back into the
tree. However, the consensus among developers was that this is almost never
useful, and since we were already providing a robust paper-trail framework in
the form of public-inbox archives, it made sense to keep patch-level
attestation and git-level attestation separate.

-K

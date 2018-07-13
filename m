Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56F081F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 20:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbeGMVOf (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 17:14:35 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:41038 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731639AbeGMVOf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 17:14:35 -0400
Received: by mail-yw0-f195.google.com with SMTP id q129-v6so9435256ywg.8
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhHANQFYUubPTOAuzBVJ9dNZzjoFqxIwPluViHBHnBc=;
        b=gJIAmyKEfyh73ahoRM/eTsVJYjGMI85253kokXBDU1HXDStRTwX1rY2CSPxDYDKI+I
         SamOiDYS+b34f6qu2kVhDFiIy9yv8AiQqLqycVyv+IlEX6YjMv1D21lvjA6OUr526vfP
         JZwPVGKGa+WHkZQO18zadPq5DWO8W/NjUrG+C2eXYu0u1CzZZnI2oVbgTqKBmG2JVUbC
         OSQsNB4ntPMSpSPPngy5ynU+gxreoKg+G7i+uTmU4roX/FH1Vg6T0/YQ/cdxwLMenLou
         B++CW/FMqaV4H3kNqz5LugwDgbKvUco8Ac7sVhv1GwetfcX1rtRPt8cIj/+g0nUEfKIG
         XyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhHANQFYUubPTOAuzBVJ9dNZzjoFqxIwPluViHBHnBc=;
        b=S1PjAC4aTGevqtpjS4Q7ddaO09nKKb+ZH3BVuqyVeq2AwX62kN3Tijwo4MerwB/VY8
         4tqcxnS4FUb/q4zdBb/kT1dCUeLYk3wanPcJ6AJWoeqy6PBijr7//aNR/CKfDJZ3qRrq
         gMdaa/WpkfkSHwPn0PSdS+J4bnXzZkCxFXCInVZhd+XjhkRX5ccqvBH6RuQQYfnFpO3L
         dGq90VweR5UN/Crinr2NFT2AisvqXD9i1If84ZMZl7Yy59Po4M+6MpKpxNC3Z3UaalOF
         wNx5Ay6CjNMSbZDpcmR95FeGKIPbDf0NhNomjMJwGlWwoA6sbRY70B1M1zIn0QRGgy2E
         ijWg==
X-Gm-Message-State: AOUpUlGfWMDM4sBjJJOFbqg0YAwyH/CRWHI2oGOF3D38VYo9XKnhAg6U
        slcO5pufwalE6EpPoSmoyjwgTWw+Y/QjnDyEQuDAIQ==
X-Google-Smtp-Source: AAOMgpf2YQ3l8XUuyr4TqXjEkV6jadBxWWOS6EuOYNoD+GHoJazsEFBbLXhE1HCmY/40Wdaefc3/1CPZB1OMWmRZIck=
X-Received: by 2002:a0d:c5c7:: with SMTP id h190-v6mr4328926ywd.421.1531515496857;
 Fri, 13 Jul 2018 13:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180713204350.GA16999@sigill.intra.peff.net>
In-Reply-To: <20180713204350.GA16999@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 13 Jul 2018 13:58:05 -0700
Message-ID: <CAGZ79kakrS_tk=x4Rb9qSu9e4RVSJ=J64eOdasKhOy=g8kV68w@mail.gmail.com>
Subject: Re: [PATCH] blame: prefer xsnprintf to strcpy for colors
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 13, 2018 at 1:43 PM Jeff King <peff@peff.net> wrote:

> ---
> Another option would just be color_parse(repeated_meta_color, "cyan").
> The run-time cost is slightly higher, but it probably doesn't matter
> here, and perhaps it's more readable.
>

Thanks for posting this again; this looks good to me!
Stefan

> I'm sad that this strcpy() wasn't caught in review. IMHO we should avoid
> that function altogether, even when we _think_ it can't trigger an
> overflow. That's easier to reason about (and makes auditing easier).

Can we somehow automatically find "bad code" either in pathces
or in new code (such as pu), e.g. as a coccicheck for these functions?

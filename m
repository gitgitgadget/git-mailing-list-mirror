Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08AE81F404
	for <e@80x24.org>; Fri,  6 Apr 2018 05:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeDFFul (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 01:50:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44906 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeDFFul (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 01:50:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id p15so18184pff.11
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nxzo59NdpefSGa/ZLCPBPH1Ryk3Gf4lsPBJL3/33RhM=;
        b=J0w7yqr513+0g3l/BZagM7IGL472FruhpuqPUNCmY8SX6C7CeGhLDyOxSMUFi4Bk7g
         o8h3Y4GYm8M03zdSC/rziKK+hUkHP91tNNKuitMv6Zmq7Wqb3q1F6edM7CVDMSi35xp6
         RlkJ6RYmAp/dGmbFYY1NuMei5vK2YLqbXIIFda0r06JOVLxMp2zaw5PRu12l6hum8DGD
         BCUnqhKSQua3nDpT1wdepAGEOQhMqxpJ3bXlScUIEDvzapmXJD0wTuykQ8u+cPNuQloe
         L6Ir/nPpprGlnkjNaK/m/T6bhPgpqANida4+l6uY4jN7Uh9xICxdH7zFqrFdRCLIlUxR
         FcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nxzo59NdpefSGa/ZLCPBPH1Ryk3Gf4lsPBJL3/33RhM=;
        b=r5iYWuWxWh2SVVrenIj3kU4SHqIog8yhxUkO0M2G5mxVMNagxS7xmCNQJBn50dJK+z
         r8xW2Gt6A7FjhUftV5HLQxPMXnYyrsmbrZAWaHarSZmsPuyZGjjEoZ6ddm5tEfzFsESb
         +m9yObk6WWXnYwzQ7PvkfpFclkj5mdHmA8zqwIvPhfmvEsSX4k2XRlcxpe+a3yxmRnN+
         0JEp4IzElOYw4y8LYwsgj2HJ5S4yesGm+fCABHjiy6YpGHgi1Eq+fZzCxjxv9Rr6xYQ3
         JcXZoHxujvnnuRsztqSToToStwf2vpG/LcS6ChUSryf6yS3Hrvq9nEovja0Yb1pcmSPR
         6xFw==
X-Gm-Message-State: AElRT7Gye+NoGJFFcGpRTPNrnqwTlgkjLP6we6TJV/z+FdKBf8nZayU9
        OF2Uif2iwZ4gLFCWnOc9Hohv/poGido=
X-Google-Smtp-Source: AIpwx4/ZFNya/UF4OXLPOgtsiinipZ3aU2Jj5llsnjQv7kCVHr3gNykH/zsvJht/2N1ZtXeVQzyH8Q==
X-Received: by 10.98.200.130 with SMTP id i2mr19155355pfk.221.1522993840243;
        Thu, 05 Apr 2018 22:50:40 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id y129sm14156243pgb.64.2018.04.05.22.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 22:50:39 -0700 (PDT)
Date:   Thu, 5 Apr 2018 22:50:37 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/3] builtin/config: introduce `--default`
Message-ID: <20180406055037.GB62593@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <cover.1522896713.git.me@ttaylorr.com>
 <20180405025912.GB49902@syl.local>
 <CAPig+cQwj8tqJToKU0_emHHC+mdtpPS666XJ7sqentMAFoLivw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQwj8tqJToKU0_emHHC+mdtpPS666XJ7sqentMAFoLivw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 06:40:03PM -0400, Eric Sunshine wrote:
> On Wed, Apr 4, 2018 at 10:59 PM, Taylor Blau <me@ttaylorr.com> wrote:
> > [...]
> > This commit (and those following it in this series) aim to eventually
> > replace `--get-color` with a consistent alternative. By introducing
> > `--default`, we allow the `--get-color` action to be promoted to a
> > `--type=color` type specifier, retaining the "fallback" behavior via the
> > `--default` flag introduced in this commit.
> > [...]
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> > diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> > @@ -235,6 +235,10 @@ Valid `<type>`'s include:
> > +--default value::
>
> This should be typeset as: --default <value>

I see; thank you for letting me know. I have updated this in the
forthcoming re-roll.

> > +  When using `--get`, and the requested slot is not found, behave as if value
> > +  were the value assigned to the that slot.
>
> And you might use "behaves as if <value>" in the body as well (though
> I think Git documentation isn't terribly consistent about typesetting
> as "<value>" in the body, so I don't insist upon it).

Since I'm here, and re-rolling anyway, I have included this change as
well.


Thanks,
Taylor

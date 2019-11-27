Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39C2C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 14:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CEF20722
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 14:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhPDbCwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfK0OhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:37:16 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44963 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0OhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 09:37:16 -0500
Received: by mail-qk1-f193.google.com with SMTP id m16so19643922qki.11
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 06:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h2G6M3EuS21EKFXUQfHpg7Mf1mbpWva4SUtMw9Jb7S4=;
        b=BhPDbCwWeqrEsGRwtld0lgj7E2w4WWdLto7PCd3ip5mNyTpBu7VCAm19jcRqsX1JuI
         oXTk4TiMhx3+uB7xeIFQJqgj1JVIFxAJW1B38Yx+J5b8nne2Gg2HtPJ8RyrjZs0LhGem
         kw5W0UJS+ZBuEYYA8PmbfCR2ZPfXy7/AVs0HG0czUtyi9q1oQcr5UcQzVi5i7/fOzk+Y
         LvaWekd9W28enX1ShqWYgeRCaiHE/K3oHw1fgpG0ZMmMUtrN3Yqlq5VGrJ0EMSQMnz5Z
         MbmgpjHZLbwl3leWUTf6ncpowsZg4a4Wy+lh4ZsOufnoKNjzWOHgfb2mKrPJQ582CEjl
         tEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h2G6M3EuS21EKFXUQfHpg7Mf1mbpWva4SUtMw9Jb7S4=;
        b=k83oMnFlbtHzOGxYrUZkzJMFEehz8DB/+0LeOvvoHCo1FWaJP/dtuMS2z1dH2bxMVm
         QOlT4O3gEHVKutzzHOBMy98/Fn9XNV0tKMa77H9QJlVYTpT9D5PfMCyq5VE72Fs5vV5S
         v0h+70xu5bCX2sIw+146do2YNEBcGglEPbKp70LNMDLus73ElHMRxFeJfZlwNORZ1Twe
         DF8LouocA1CLBJvNyR45DKm1aJ/K+a1N1z4o7jY5vAUfNrey3Mi1KcX+zUrTnJbh8++D
         JDRohXdNSClqZXqaRSkf9MqfjrxB5b6dLVSJfxQY17o7vyyTKfbnd1qV1jkw5cddbBvm
         fsMg==
X-Gm-Message-State: APjAAAVZ0WMQ9L+NLfY13+EjiG7wgnrKG2I1RRpVG3zkmMRwaqLhdVSB
        zlhiLrBIsa0VvRRFd2sRru4M4TiO
X-Google-Smtp-Source: APXvYqyg/MKnfZPOEBp2boWWVWSSaeilAbJOKBTspFpgFsz286NWH8BEQuOL3OtCvoFA2/fnGu3bMA==
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr4550759qkm.156.1574865435342;
        Wed, 27 Nov 2019 06:37:15 -0800 (PST)
Received: from [192.168.1.3] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id o201sm6895468qka.17.2019.11.27.06.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 06:37:14 -0800 (PST)
Subject: Re: [PATCH 2/2] doc: replace public-inbox links with lore.kernel.org
To:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
References: <20191127125231.GH22221@sigill.intra.peff.net>
 <20191127125404.GB27983@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8e4b5924-f8e4-0d51-0e1e-6408e29d2c66@gmail.com>
Date:   Wed, 27 Nov 2019 09:37:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191127125404.GB27983@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/27/2019 7:54 AM, Jeff King wrote:
> Since we're now recommending lore.kernel.org (and because the
> public-inbox.org domain might eventually go away), let's update our
> internal references to use it, too. That future-proofs our references,
> and sets the example we want people to follow.

This is a great idea. I clicked a few of the links to verify they 
work.

-Stolee

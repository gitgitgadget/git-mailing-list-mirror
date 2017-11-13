Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 518571F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 20:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755284AbdKMU2i (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 15:28:38 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:45827 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752445AbdKMU2h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 15:28:37 -0500
Received: by mail-io0-f172.google.com with SMTP id i38so7491474iod.2
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 12:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q87/0GhmywknoZNXF5Vtf1Az8vznQmMJ7Zw3s6QEm5Y=;
        b=Hmv8CLmU5wkUzg/JWd4hwTlenpxTVCl77xR1yaBy79tj9sDk1K5vJtGcTJP6r5phZk
         rLkVD8c2YQh3sa0joOCWohjDaF3u5oeyWUcqXgzLgDqddyOucs+arnoIInY6Fx/caTsw
         XpAJSPZRcvP1wGFq12eoijnQHbWBJm5SHB1U4siBouPj+wyXIy/fba27COSq+5OAb9Ts
         J0deX/zJ1CJfWhX5aaPidZ81g2YrBPfOAwPYgPJIvGBksRT7wZ4HQM1dG9l8elAkcGAY
         q40frqBpE5LnInSKBAgDT3GXpAJ/RKM6E1gxUdpSbqQ4hw5C1EmkluWbpaeLAInGz2KZ
         6SgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q87/0GhmywknoZNXF5Vtf1Az8vznQmMJ7Zw3s6QEm5Y=;
        b=C2l17KmRnBI+WMd+9v+79QkSyCS6NitT3bxZ+sM985xgUeO2f+2qkySCc1f56XNr7h
         G43M7r6UROP5n2l3DsHf5zpgdDI/uazwkWQWQ5vJYXtZvEIjNdM2nX3W58h4SM5e+JXT
         YLq6vvV5UJyirEtFnZEeIcnj6tQQjpcd6mOLUXHu+mVMCh7ur3RiW82d1YIvKGlR9RYG
         TLphTHt3T+m5O2POUSTkd4bEy/4pFMB8h4i1veTw2amRMXTiSTFC3qiSc79LKRMTMsAr
         fUF7X5JulusP1/sIUBGeif8IBJFxTyImPAJ4SjO5T55i+fpC2Q+e3h/6G9DQ7R/GZ6ZF
         mtag==
X-Gm-Message-State: AJaThX4nI8pxN2eX1+jsVK5SE4F8G2pB/ZJcWiY23ZL7wkEFS+Xfg5Sg
        TUV7GJPmmtE29ZCvTD+oaCoZOlbpYH4=
X-Google-Smtp-Source: AGs4zMZjPBIfzhMbuNO+3IjDfuY+qUBF4a9TXozyMio2MU5zXZ1efHzC4vaCbVmzLXdl2x43g4qKmw==
X-Received: by 10.107.137.163 with SMTP id t35mr11271038ioi.198.1510604916291;
        Mon, 13 Nov 2017 12:28:36 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:b1aa:4028:e6df:d3e])
        by smtp.gmail.com with ESMTPSA id k18sm7770478ioc.75.2017.11.13.12.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2017 12:28:35 -0800 (PST)
Date:   Mon, 13 Nov 2017 12:28:34 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] progress: fix progress meters when dealing with
 lots of work
Message-Id: <20171113122834.20a69d1e87defe95d6e0e8ed@google.com>
In-Reply-To: <20171113201600.24878-3-newren@gmail.com>
References: <20171113201600.24878-1-newren@gmail.com>
        <20171113201600.24878-3-newren@gmail.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 13 Nov 2017 12:15:58 -0800
Elijah Newren <newren@gmail.com> wrote:

> The possibility of setting merge.renameLimit beyond 2^16 raises the
> possibility that the values passed to progress can exceed 2^32.
> Use uint64_t, because it "ought to be enough for anybody".  :-)
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> This does imply 64-bit math for all progress operations.  Possible alternatives
> I could think of listed at
> https://public-inbox.org/git/CABPp-BH1Cpc9UfYpmBBAHWSqadg=QuD=28qx1oV29ZdvF4NbJw@mail.gmail.com/
> Opinions of others on whether 64-bit is okay, or preference for which alternative
> is picked?

I haven't looked into this in much detail, but another alternative to
consider is to use size_t everywhere. This also allows us to use st_add
and st_mult, which checks overflow for us.

Changing progress to use the size_t of the local machine makes sense to
me.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2432C1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeBVA3J (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:29:09 -0500
Received: from mail-pl0-f52.google.com ([209.85.160.52]:39228 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeBVA3G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:29:06 -0500
Received: by mail-pl0-f52.google.com with SMTP id s13so1915301plq.6
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VsFgENdV7sA87HP5ymWdWer2AROHr+uYA2ScQCxalwc=;
        b=I8Nb08DU0kUe/PS6PDShP8mEylGjLGZ+2ELSMn/HZWauXmTFpCP6qSMMb1gxDr/dvY
         mBWEkT4Xk7M7SnSmTXfzJ+eawoq0+XcvgEOmWmxHQXkTuh7Kl0ni3w4blarcDLZ7QTXP
         LTq3QSBiJZ/dm16sB1vyyjELOQ00efvqikfE1n69AO9q++e0jWwRAyRiSfVawckv8Lr5
         aEzONHbMsWxJ8ZjOd22xIe3Jkct3vNn0o6DvJlALMARBT/yyaLX/JCpN2QZ3Q+GFRCL8
         arHnNRQQs7V1flT64toBQmgt8P19D7XHXRDZiktc+c+WTAZjIXZrnVffbFmhnCfTgy4D
         1X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VsFgENdV7sA87HP5ymWdWer2AROHr+uYA2ScQCxalwc=;
        b=RQZiDwMWltQg4MzQPBMiXM6CkAUu6qx3CzCzIwPSEt5XiVsj+lmZH6Yd5cZSKedwet
         aLLjttWH7IS1PTgtW8Is+eOiYj46HhNYUz9cpRelqQSKFLbw9YFjWrZ98pJyJwUC2eo+
         dW05SGhwRrBeN71j3qwV9kui/8/8s0DszMvNWXWIZLQUZrMBZZCk1pArsJV7EBK7DDmu
         UfH5Hufz7GyYzlT12fLFzTk8Vpe0T0shI23bK4azdUxmF91nMffQxK6GdJioGWOjJ1HN
         64Dn+xZkVvUxlwB0hwLKDN9vwdj5psXCFpARJOf4dAP+6qaSqhT/vFc3VY9FU/vO+51h
         VFiQ==
X-Gm-Message-State: APf1xPCPweNxDxuW4zCSuKkm/1omFmFamUHKDxetV12wHTbaI7dKBVGl
        6YurEnDvx3A8auFS24pnxfRkEA==
X-Google-Smtp-Source: AH8x2257CY4KFyM3Lr63qaw5lsyupR/WGMpYGyV0zoE4RYFyBhzEDbAdQjcw7EFw0S5kgMCqrkVFmA==
X-Received: by 2002:a17:902:6184:: with SMTP id u4-v6mr4685324plj.390.1519259346257;
        Wed, 21 Feb 2018 16:29:06 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id 184sm68106813pfg.87.2018.02.21.16.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:29:05 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:29:04 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH 09/27] sha1_file: add raw_object_store argument to
 alt_odb_usable
Message-Id: <20180221162904.54c0d57808d1042c578b8778@google.com>
In-Reply-To: <20180221015430.96054-10-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
        <20180221015430.96054-1-sbeller@google.com>
        <20180221015430.96054-10-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Feb 2018 17:54:12 -0800
Stefan Beller <sbeller@google.com> wrote:

> Add a raw_object_store to alt_odb_usable to be more specific about which
> repository to act on. The choice of the repository is delegated to its
> only caller link_alt_odb_entry.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>

I checked that alt_odb_usable no longer depends on any repository-like
globals.

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

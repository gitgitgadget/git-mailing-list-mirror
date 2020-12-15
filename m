Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCAEC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 06:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48D322286
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 06:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgLOG5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 01:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgLOG53 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 01:57:29 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E4CC06179C
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 22:56:49 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id d20so428766otl.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 22:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=oEuHrMrWZQFarjcpNBKA+5mTlwc3bEdAOjg5y0RLOQs=;
        b=eAxJACiNReqQFKGT2YctxIGvbJGel0kSohS4g3WsA2rKxdqkTpoBjiffreLPsm/GcI
         1h+mZsFcSlwUSyl5dPGOyKtKDxE1b3TRqhYvXXFBaglDZUH4S5Wwb2fZpkUSB5R8tGU8
         4CAhk8niik98rnJ5zC5/F/mwgRdJ2m6j02aDomaLVMchnOFWuWDgVMj+VkIJYUWVKfxA
         swDB8uReRt8YXoGrg7Je+HAvYDRiiAVcDqE5veM0Ehsdb/755e+yaHDBru8T1X2pcoxx
         Tl40zwjIzmK3i/Eim3hBv6+VQ/5tEoSS/9FQRzGkFvvTRFk0r6GgU0kwy2sMZmN3ug7B
         aXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=oEuHrMrWZQFarjcpNBKA+5mTlwc3bEdAOjg5y0RLOQs=;
        b=BLKuiUoi/uUYUpDYzst4JRrXIUffpLhTqLRuXki4mjEtjdjMTj7B6LsNvd2fmXS0CM
         Eai1LG/X77z6cL7b6KRvFqh266rpS96fAMGOnGOxGyIu6/EcFFqenvSmaGUOjNwiGRvM
         qLV+4zcU7XnPAyfnu5r9a+9jno1ePYPPTd3O8iRJ3kukwUWttiXEsjrIxKXvs/wkSdLS
         gQ7J2UE5mHYOOVhoxHxpI2BMKMOt0EKTCCZLAoH66K8fpazB7X8sTI1SFs4VqfoD3nyR
         JJMbo0HUBOt5WczqgUqp62RkDcrLU3LvCufCs5Yusgm86Z6s1yizTJJ0AwSKNEeejbeW
         9Kbw==
X-Gm-Message-State: AOAM533O4e4PhH/8pegt7vYpKgmf0UbTcMC2sXadlvBiP73g3OleMqJ+
        SsSztJy+WmF4ysA6qePmgGs=
X-Google-Smtp-Source: ABdhPJzGQE+3Iu4YCXaXzWIzVQTuLoESHGxmwXOE9jIU+jLIuNk2zomrFKUanNdAd48r04NKJ4Ipbg==
X-Received: by 2002:a05:6830:1d0:: with SMTP id r16mr22151188ota.54.1608015409150;
        Mon, 14 Dec 2020 22:56:49 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 109sm230817otj.12.2020.12.14.22.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 22:56:48 -0800 (PST)
Date:   Tue, 15 Dec 2020 00:56:46 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Message-ID: <5fd85e2eeab1a_d7c48208f6@natae.notmuch>
In-Reply-To: <X9hJenCYkwTmxNjA@coredump.intra.peff.net>
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com>
 <X9GbIG9vZbK1pEoi@camp.crustytoothpaste.net>
 <CAMP44s33J6F60W=2Yd2WSGE78VT0XBkewi8m3unXvathBH2TOQ@mail.gmail.com>
 <X9Lf1p++YktzZMWe@camp.crustytoothpaste.net>
 <X9gT57SAHzGm3ET2@coredump.intra.peff.net>
 <5fd8279ce0696_d7c482087@natae.notmuch>
 <X9hJenCYkwTmxNjA@coredump.intra.peff.net>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Ideally we'd combine the autoloader for BufRead and FileType, but it
> seems non-trivial to do so. I think:
> 
>   au BufNewFile,BufRead /path/to/git/* if &filetype == "c" | setl ... | endif
> 
> works, though it's a little clunky, as each line would need to repeat
> it.

Yeah, that works, *temporarily*. If the user has configured
~/.vim/after/ftplugin/c.vim, that would override those autocommand
settings when the file is reloaded. Which is precisely why the above is
not recommended.

> I don't think we need to solve "here's how to trigger some settings
> for some directories" for everyone. We should let them integrate the
> settings as they see fit.

Yeah. But how?

I already explored this at dept, and I arrived at only one sensible
option.

-- 
Felipe Contreras

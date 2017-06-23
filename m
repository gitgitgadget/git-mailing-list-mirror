Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2DE20282
	for <e@80x24.org>; Fri, 23 Jun 2017 20:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbdFWUHO (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 16:07:14 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34055 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754854AbdFWUHN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 16:07:13 -0400
Received: by mail-pf0-f196.google.com with SMTP id d5so8839575pfe.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KRt6ieTEn4MRbRuCleak39SN53epzR6xoeNiMaB0j8g=;
        b=p3wXD7UGh/pFHw4Vt6tdnnt5Ric5YUP29R8Z74zqMvOo33bewtLcM7Lv18Err5GPkR
         l4JjkEv6qm53kcpBKTvQnO2ZjkFBbCPxXCBAb8ubRDxnjWqptFezWDPLL2wHGtd+fQcX
         2eyKiFQsgFtgnd+Fb38j3K9czpIFLbmXnblACK/28CJaHDjQVeQduhlK82A/0Fo1RzWV
         OxfeRkjRniKzw3ftRqmbS7j9XjSJ7SHfc7sRSRpedKtHHa5VeiHnrFRFl0586j6xipP5
         uQifvr8xvhF11jxt3hZyxpCMI4e0E+UKEuUxRO1sjBVEK5ylVIi/CZT6ahxhjDIs01dR
         QUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KRt6ieTEn4MRbRuCleak39SN53epzR6xoeNiMaB0j8g=;
        b=E0pGdvOfjt5wuP+4OscDVaRY6v7WKU6qbV9BDXF+iPqsDLiWJPINViCoBGYKG5uSvp
         E4qpqDm2XtpvGeUhrjA+8voY1Zme5gg+92OkebTNB5B8fnFJc38hNX6rr5V4YlFvM6U2
         K5gVq44p+LaxQDxnD9+DWqFx/4ovsPKYFzQzZFn0pYVUN7qjufoGV6PtCeXTV+joSneL
         nMOnTDeJyBF/xVBpYUH/HN+lgGoAs0yRkunDMJXpOG55WeZ2lyYsENkVW39u3Nv6fP0N
         yszvwOryxg7udw3toW6WH6hWVDD+IC41pJLec0elh59DEJElCEUYLYN1Li8jUYEEMx6+
         ii6Q==
X-Gm-Message-State: AKS2vOyubqxdkmSP4w1UxDGhgD02ECFwgUZ1bqtFthl2dX8NuDUjJtYK
        EH4tSpAgXsBwVQ==
X-Received: by 10.84.175.65 with SMTP id s59mr10771592plb.20.1498248432876;
        Fri, 23 Jun 2017 13:07:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id y2sm10999971pgy.60.2017.06.23.13.07.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 13:07:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jonathantanmy@google.com,
        jrnieder@gmail.com, mhagger@alum.mit.edu, peff@peff.net,
        philipoakley@iee.org
Subject: Re: [PATCHv2 04/25] diff.c: introduce emit_diff_symbol
References: <20170620024816.20021-1-sbeller@google.com>
        <20170623012919.28693-1-sbeller@google.com>
        <20170623012919.28693-5-sbeller@google.com>
Date:   Fri, 23 Jun 2017 13:07:11 -0700
In-Reply-To: <20170623012919.28693-5-sbeller@google.com> (Stefan Beller's
        message of "Thu, 22 Jun 2017 18:28:58 -0700")
Message-ID: <xmqqa84yeads.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>     diff --git a/new.txt b/new.txt
>     index fa69b07..412428c 100644
>     Binary files a/new.txt and b/new.txt differ
>
>   could be buffered as
>      DIFF_SYMBOL_DIFF_START + new.txt
>      DIFF_SYMBOL_INDEX_MODE + fa69b07 412428c "non-executable" flag
>      DIFF_SYMBOL_BINARY_FILES + new.txt

Hopefully this is an oversimplified example and I'd assume that you
will do the right thing when showing a renamed filepair by allowing
both old and new paths that could be different?


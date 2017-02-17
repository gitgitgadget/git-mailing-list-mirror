Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9187F20136
	for <e@80x24.org>; Fri, 17 Feb 2017 19:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755881AbdBQT3e (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 14:29:34 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33486 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755721AbdBQT3d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 14:29:33 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so5630180pgj.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 11:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3MkTxHidMSzanPcip4n1DPs40ZLhXSAEwsVGp7aBXDc=;
        b=W/sktaQMG0eCZSvGNalDhwmbMb+dwevYIGuyLD9y2r+f5OWZv8tde0hkKVgjuTyWYZ
         yvbZEXVXBk67GDAeY/JPRTCCg3bjeYQBzKD8HCyeTPZfd6oLpY/Y7RY3XcmYiPApj8Xu
         CNhAn+BlM1fRmlk+kwhWozALc/gLyveAezK9gp1NWSIf3CKdlANT7cBmNX32X+DtoG4o
         lE4u3qupy0vGyTXCJIzi31+kB1mAnwkmfRSo4T51qFtRMwXadKBGKF5hoB3TsdsqWTE8
         5TYD3qj+01qNvWdJsI8piphvNYBM5iEZHomDsBfSYobFjSCkJusn1spAq3r5yW4OfS1D
         0dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3MkTxHidMSzanPcip4n1DPs40ZLhXSAEwsVGp7aBXDc=;
        b=A9bIXFWmsIWw9jVBqqYyqilu9QRjDa9FfN0d9com8N2JoVpdD4NC79ZovvxApmfF/R
         l8u6UXvgXqAsQM6xxvnZmQil18XmgJ43l7kv/tdrpSsfe/haZh35XLyWTNMUlmrd3yjD
         SLoFf9wcGsMm8Zi6gFxjGijcJEcXoP2Hzvlp6zt98Y6U1ZBvc1ZjPsv2Ae9thDn72Gf4
         frYj38y+xG/OP3oh2DjAMshjyWC77labjp9fvQaMzbtBWma37QPO2miP7ZOrb5cpoDaX
         wAPiMdxRgWoA+FfoJNEFImXwT83xWDEF5/1J89x6eYf3HPgaUNJuaVFOt/FyoF+kevPa
         lPMQ==
X-Gm-Message-State: AMke39mKfgJPgMZfuAoKBD159Onl5jT65C828oGdkWmKR3xwA5Y5U+HSF9h3L+IQh1zEJQ==
X-Received: by 10.84.139.36 with SMTP id 33mr13410972plq.61.1487359773000;
        Fri, 17 Feb 2017 11:29:33 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id q80sm21083351pfi.13.2017.02.17.11.29.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 11:29:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
Subject: Re: [PATCH v3 11/16] refs.c: kill register_ref_store(), add register_submodule_ref_store()
References: <20170216114818.6080-1-pclouds@gmail.com>
        <20170217140436.17336-1-pclouds@gmail.com>
        <20170217140436.17336-12-pclouds@gmail.com>
Date:   Fri, 17 Feb 2017 11:29:31 -0800
In-Reply-To: <20170217140436.17336-12-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 17 Feb 2017 21:04:31 +0700")
Message-ID: <xmqqh93ssjj8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This is the last function in this code (besides public API) that takes
> submodule argument and handles both main/submodule cases. Break it down,
> move main store registration in get_main_ref_store() and keep the rest
> in register_submodule_ref_store().

Very nice.

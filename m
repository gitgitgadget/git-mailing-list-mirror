Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B5D1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 20:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932549AbeAXUxU (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 15:53:20 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41562 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932378AbeAXUxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 15:53:18 -0500
Received: by mail-pg0-f67.google.com with SMTP id 136so3547722pgd.8
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 12:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vHwTWDn7rm1aKP/vz93QYez3+7nw+nrFm6lczeli54I=;
        b=hbSspGqc9r0JF3DbL2Fxt9o+R4cuougnZAfTrlElJu11YfpQ2qcLxjIWT0Yt8xMgfo
         tE8fmej/w4XfNrShnoidxt/LIt4RakuZH88Y2JoARB/Il2V/vqI7Z++u7ezo8zVCyZL8
         obBFdvBDQp9SRxhz0Mkgi7ud0BdO3nLKrtS7kCGXgU5xKDwm1jGsfb0W6EBtXaslGses
         RqGDCX6GklORAfrsS+jx/bQ6GHi/34DpMWCRV1gNychaSbaCxaIJJk3aXc6VTFQGJWHR
         jzoKmV8PIvIbeuFWAkP7JE2Wy5uVMGlExs7rguJDjr6pgdeIAjmOb2/PbEhCDIAivYvv
         H/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vHwTWDn7rm1aKP/vz93QYez3+7nw+nrFm6lczeli54I=;
        b=kRfnvIjSgwQHh6rWmOUw3X/nub2lDKyTDe4pL7kDE1mHLKGdY4Xha8kBgCiiQKqraL
         KSP3vaN0IJwpunKJ62OTvM8X0ukiU6FHCWO/Rkxj61ahWk+HAxyyub5zl6HryGnSceKb
         jP90yAQSQO+BoXMaI/yvGJlrnwf/kEZxhVxS9QVL1+ThekZ2LxZOCidOh8puy+MTL+vA
         MTMkYk1nKCMvaCmC+gcGW4nZx4IvUxtAnfkAj6mgofFgnm2F7YruQvoRNIhsLilQxwrM
         ovKSRXRqw49c8dLyJxgXAweo78IAZ5we36hlB62tJFmFhdRD1zom/tVyo3jXWYBznmmp
         mvxA==
X-Gm-Message-State: AKwxytfxfR+zzw8xyN5eVxIiHOgjkjLsxXL+7Pg6yQEwMd5FXli3sD9S
        g3pky4GexyIK46JA40nloxA=
X-Google-Smtp-Source: AH8x227HKKcIzttBHcOa44B0kLS1KQ+oPzaN5+3voAZlSPrXrYdYRHJ7lpgE+qQBID2kwIPJ70nnIg==
X-Received: by 10.99.161.26 with SMTP id b26mr2556986pgf.322.1516827197659;
        Wed, 24 Jan 2018 12:53:17 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id y79sm10801370pfb.177.2018.01.24.12.53.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 12:53:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 02/11] fetch: stop accessing "remote" variable indirectly
References: <20180123221326.28495-1-avarab@gmail.com>
        <20180121000304.32323-1-avarab@gmail.com>
        <20180123221326.28495-3-avarab@gmail.com>
Date:   Wed, 24 Jan 2018 12:53:16 -0800
In-Reply-To: <20180123221326.28495-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 23 Jan 2018 22:13:17 +0000")
Message-ID: <xmqqk1w7c72b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> remote->prune-tags field, but without hte use of the gtransport

s/-tags/_tags/; s/hte/the/;

No need to resend for fixing the above, as I've done so locally
before queuing.

Thanks.

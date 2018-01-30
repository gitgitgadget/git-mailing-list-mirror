Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D541F404
	for <e@80x24.org>; Tue, 30 Jan 2018 19:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeA3TPY (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 14:15:24 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55751 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeA3TPX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 14:15:23 -0500
Received: by mail-wm0-f68.google.com with SMTP id 143so3332758wma.5
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 11:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=PjESnEGZFnw4FKokNsuLZonmvmIoJBZfFikLTwvvIxo=;
        b=BXKc/AnQiMxhHhEBWlQXUzpsCw3blcsZojTruS3PkYUsUEzbg2oFTnbrC1FDzKTJV+
         5uawzpd48KQay6XvFEGqaLBwO9UptPGHW1REbbZEurgLeLC9lxsrgqxFu4+NIwSqPAcb
         zocdx4joT/ihprnWMqCfBhSGyUwrCdCFrV6za0vBaVew4UAWkgEMODwpiT2/PwQPBDN1
         FDueNZEAReSpTuayEAhFGJveKC/PXgnlpzD0ytkY03OxXr4KAgt0+4LaohPma3TGUwuQ
         /zFHSTwpDRHYZSFTAg6dfE8nTeVSjjC6w1KQtAERbZ9kY9/33d8cIuSZ1MIiLHmc0bT0
         fN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=PjESnEGZFnw4FKokNsuLZonmvmIoJBZfFikLTwvvIxo=;
        b=atGg1xXaCnelYObIOtXZn7Zdz89ALMHzmF8mV6EdqZuigGER2igcVuxDk004LaU5+W
         yKvHVJ1rCJhNaEdJZSbT7T9Fd21Jez1UVAdXjSqE+df35J11h0u551nvYUNOzzWPQKM5
         AAWTvaAubZ+Wedz//kRQpsa9ckJGmtS59Ipa2mLFovCsKWu0rbT/ljXRgfu6wOUIvMje
         MLrCXdo1O2+yIulK6sB0iJ6f8jYXnle5Mj2czG+9ooJU41jWxIwnBYdvUFF6wLQXqJ3h
         bWqXKjpqhCeF1IP4STPPUwX8M1Mv75oli1uuKqKpPoc2jZC70crrAyUpmHqfWAG8oQBn
         dPsA==
X-Gm-Message-State: AKwxytfHrdoFfyHt4tSU7FYRHKeYXdEeIGbdW6gHKdIILpQ3ZblsVtQi
        YI/q1ZIgsfItiXTGl2yNaPc=
X-Google-Smtp-Source: AH8x227RZ3rmG5rBStTCaM+aXaUQDdrAuTDF7InCCy7hunSCJ/BF/sshX8At43Qk2ZHDjTMvaezHqA==
X-Received: by 10.28.111.23 with SMTP id k23mr17695771wmc.69.1517339722350;
        Tue, 30 Jan 2018 11:15:22 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 188sm14406594wmg.29.2018.01.30.11.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 11:15:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        --to=larsxschneider@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v5 4/7] utf8: add function to detect a missing UTF-16/32 BOM
In-Reply-To: <20180129201905.9355-1-tboegi@web.de> (tboegi@web.de's message of
        "Mon, 29 Jan 2018 21:19:05 +0100")
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
        <20180129201905.9355-1-tboegi@web.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
Date:   Tue, 30 Jan 2018 11:15:20 -0800
Message-ID: <xmqq4ln3upiv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> If the endianness is not defined in the encoding name, then let's
> be strict and require a BOM to avoid any encoding confusion. The
> has_missing_utf_bom() function returns true if a required BOM is
> missing.
>
> The Unicode standard instructs to assume big-endian if there in no BOM
> for UTF-16/32 [1][2]. However, the W3C/WHATWG encoding standard used
> in HTML5 recommends to assume little-endian to "deal with deployed
> content" [3]. Strictly requiring a BOM seems to be the safest option
> for content in Git.

I do not have strong opinion on encoding such policy-ish behaviour
as our default, but am I alone to find that "has missing X" is a
confusing name for a helper function?  "is missing X" (or "lacks
X") is a bit more understandable, I guess.

> +int has_missing_utf_bom(const char *enc, const char *data, size_t len)
> +{
> +	return (
> +	   !strcmp(enc, "UTF-16") &&
> +	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
> +	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
> +	) || (
> +	   !strcmp(enc, "UTF-32") &&
> +	   !(has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
> +	     has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
> +	);
> +}

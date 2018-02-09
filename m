Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B2DC1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 19:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeBIT26 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 14:28:58 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38548 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbeBIT25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 14:28:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id 141so18144431wme.3
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 11:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JA9xXxTr1kS6uSqGsyHFl9InTARzDUyA29BCO+kTyBw=;
        b=pqpwSGolo+9MMyD5OdomVVHralZUWuIDUIL/PQXd1QdWyYiWzheJgCKBi/mQEYnYZf
         h845CF93MlN8VJrg+hk9zK0pHqD9iha3ijE5zC4U8mCLCo+tXH3v+uSAA5nAFYFUPG25
         Rm2q2IsvcVGUJ1m3NS+4FFOuQ3kcUXjg1P1o3prme6UjG/h94xCDOyISBw6PdnaGnkPq
         E4lJACAhV8Y1YfCwwjIPULiSKknlrNRmmS8eIrM/Trd7kKmxQbogck8PyfcFFn2qSRhR
         EnoQsiCoTAWHtDgkiFCwcKfL1YyBRL1Yeb1KTS6Cfej/zajHZZmx7oFmqwv80i7Sf2kv
         NkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JA9xXxTr1kS6uSqGsyHFl9InTARzDUyA29BCO+kTyBw=;
        b=euyNIOvl/y5OgwRvDX9FArIBiZ4VnzWiDMcR/xosjrCzyZEA+zBCes5Ve0Abi9Vib6
         01RtLdxfJsNoy3+Jo+D3vzP1+pLKlUgIh1WMQr/oQpuRpHGjqZEVIu4rDVTGLRB5wTRT
         3PDjVg2oQtdQRjnnxv4X7YMfUnuovuCoqFyv6/NGnr+WVFgiur7j6r27VtsxPghaxVgO
         B/QI8vK+CYd+4cp6EoizUeP/9d0DueXyNUCFsSJuRIPS9eQWH/HAnSvPAyU4PaIKMpR7
         AGTCS8L2cGihDStIu+4HvaN37QTFgqKYBgxKE65BkwSop2CIBmcCMhUx5Vx6916VgHr7
         6WGg==
X-Gm-Message-State: APf1xPBkppeRhhR2CkaVAxqkbzWgla9a1pqwvQ49R+g2VoqfL9WUVlGZ
        hTfv6FqlXHPdHwmAMlkWrLY=
X-Google-Smtp-Source: AH8x226K2ICiFUgkRTcal0iT0R999faZ4jkW+F2IrgeGXJLbOBV/BGW6/ZkKZLiW/Aem52nIlUF3TQ==
X-Received: by 10.28.25.129 with SMTP id 123mr3157456wmz.2.1518204535505;
        Fri, 09 Feb 2018 11:28:55 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u98sm3733992wrc.69.2018.02.09.11.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 11:28:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v6 4/7] utf8: add function to detect a missing UTF-16/32 BOM
References: <20180209132830.55385-1-lars.schneider@autodesk.com>
        <20180209132830.55385-5-lars.schneider@autodesk.com>
Date:   Fri, 09 Feb 2018 11:28:53 -0800
In-Reply-To: <20180209132830.55385-5-lars.schneider@autodesk.com> (lars
        schneider's message of "Fri, 9 Feb 2018 14:28:27 +0100")
Message-ID: <xmqqshaavu6i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> If the endianness is not defined in the encoding name, then let's
> ...
> [3] https://encoding.spec.whatwg.org/#utf-16le
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>
> utf
> ---

Huh?

>  utf8.c | 13 +++++++++++++
>  utf8.h | 16 ++++++++++++++++
>  2 files changed, 29 insertions(+)

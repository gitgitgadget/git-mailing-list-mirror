Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A48251F404
	for <e@80x24.org>; Wed, 24 Jan 2018 13:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933641AbeAXNhY (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 08:37:24 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:40780 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933556AbeAXNhX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 08:37:23 -0500
Received: by mail-lf0-f50.google.com with SMTP id h92so5273495lfi.7
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 05:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Jq+AGGC8qpBjujnqoRf3ZHBJRqnfIqpfCcVX3VHdlM=;
        b=RC4wbFvU3SI0hH0QcSuihznvWNgsqzAGs+aJ2IGXVRcNt44AZZQbTtE4ZVdFiBMM6l
         mrEWwNcO19CNge14rh7gc6obvgiH1sN5WJuAVe6/GxiU3LQp4hzAN6U7RZOtcorHEuhf
         oG9ABtyAgZMLHaKk/mpSF8WKzVHPBPa5nRKffPUOngrtRmwgqLHBKMVRw/rOUbPk7iqL
         liIV+2NOhk4CLjv8awjfB7I7dfA1tuuJwOGvt0d7CyWkmmNb7KSV3eREonQ2SUT4ziqx
         1aI0XjxDqvZHZCGVwH2HujjdWKr1zfVKwwpAd1H9AzXIp6uWHeFl96rxvQ6YRmaSFxuF
         sMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Jq+AGGC8qpBjujnqoRf3ZHBJRqnfIqpfCcVX3VHdlM=;
        b=DaTbLqWPuZ4stxL6JrLq/X0sBYJsy9s1r5EXimv64jwgRE3tVYpnCpjImE5nMGgyHQ
         GvRqPkMuZa9PLg+2aABcnLuETedvRZDS/0j/GIC0cISTofTWm15ko5zr4up0FfctVhvd
         zjMHgCrvg9/JuRgCnY6aa1vUqpjaY7sM1H9asFr8N8LoOvuLYK0RALCI/PkCmBOyrBvS
         yXoCgziCMeiTNBXBUaGgFnjxW6uDw77UelLK0bvBYAqO44qRtv2zmR7QJ+qjP9Hk+nVC
         dllBbee6K8Bbnp9GrfAXAjL5Zboplj45uQpBzd/VTmSPPY36i7uG2kA18XlDVgDgMWSz
         XVCw==
X-Gm-Message-State: AKwxytfx5SxjZXQzgGBN6ioK70forVvlaWw3p3rVAp+FN4QTLOfkewGa
        YC6bQU7/ic1ot2Q+XG3dzy8=
X-Google-Smtp-Source: AH8x2271k1uirs5HM2+PvvjdHqtnywCfI+2C3hrcekEMad7MelrI0uOgySfUJb9crO1vR4ufeYR44g==
X-Received: by 10.46.97.2 with SMTP id v2mr3554966ljb.71.1516801042544;
        Wed, 24 Jan 2018 05:37:22 -0800 (PST)
Received: from [192.168.1.138] ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id p7sm71511ljc.46.2018.01.24.05.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 05:37:21 -0800 (PST)
Subject: Re: [PATCH] setup: recognise extensions.objectFormat
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>
References: <66fb698096ed14ee58b2611f41f2e3e5dfa49059.1516798941.git.patryk.obara@gmail.com>
From:   Patryk Obara <patryk.obara@gmail.com>
Message-ID: <4e6004e6-0917-6705-f6a6-25cff116b732@gmail.com>
Date:   Wed, 24 Jan 2018 14:37:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <66fb698096ed14ee58b2611f41f2e3e5dfa49059.1516798941.git.patryk.obara@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Argh! Forgot to sign-off the commit…

-- 
| ← Ceci n'est pas une pipe
Patryk Obara

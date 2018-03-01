Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CC3A1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 20:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161698AbeCAUvd (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 15:51:33 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54183 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161666AbeCAUu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 15:50:27 -0500
Received: by mail-wm0-f66.google.com with SMTP id t74so14701967wme.3
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 12:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=50+1eaQTrvJHmDPrxFUKbuKq/JBLqKF2c8/KzPM0gmU=;
        b=J7LvT6mJsuglyZincKEehKPOsJWSdyiWAakRFY3mGKSMjzDjhi8rp3EpQHxYmklE0Z
         pk9T0je+gLymQ3Vtr3iR4C5uL+l0hTr1vIPEjOKF9jB+LruCB1FAc+9e69MY0YoTNzgu
         eCOisxc/hJzLPbEn9Vp3lOreDQNvJMqQnKjcL4u6/qd64tnHHXQtf86klTwhFzfh3aEk
         3a15unikUCJ3XtvrBLUikxqhPn7+zdRI1zbdK6T22OinONpiGNkboMSnZyxiQQJE8NBE
         Z4qtfGX17X7NeXleG7Now6FgWTQWBdE7Nyw5d4B3eQWNpAv7OTVSdftKat2xW1BUVZbs
         fmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=50+1eaQTrvJHmDPrxFUKbuKq/JBLqKF2c8/KzPM0gmU=;
        b=PAsDUD203i8byf1qskTxV5hRy9+eOt+1mpU9vlW1L1Cu0uDHR1nwjPHVjcR9RJ8Qqc
         y4JoVhMcvLu/I8akBD9vI46vFtqb98f7TJtc3BWp3d6rMdHrUuB0YdHxoX1B5gTd1j8M
         ZxIIJ3x0Vl8dv/h4PtXoPE5qHB2hSO0cn9wYGsOVpx8G82Cw2R3XTkdwtRO9cb/WUGEq
         hr5tHSYUNnS3XeDADtj2pia2byK7FxgAbo63blw0ElzgVVivc6YLt5c7wWFPAozMb5kJ
         y6WMgx/I8J1aoApsIbaJ3jhVGhZT+NG+TRY5cklFE93XiW4P3f7s+etL+NsxPA4QIwM4
         UMdQ==
X-Gm-Message-State: AElRT7FVINcwun3TNwhzQwRNqde3Liz0YSkNdTSMNL4kh7FCPgpNZ8p3
        yxVtXHvkUIs/ZO5/fujWtPjxOGk6
X-Google-Smtp-Source: AG47ELuyfh8+MKEPotuj/e0bTPZw82qFnCfpBsQoOLlzwJ8a0YTzkA3I2l8j2o+fMtqPAm7ClHQuBg==
X-Received: by 10.28.150.138 with SMTP id y132mr3000379wmd.104.1519937425597;
        Thu, 01 Mar 2018 12:50:25 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y34sm10604810wry.19.2018.03.01.12.50.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 12:50:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 03/35] pkt-line: add delim packet support
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-4-bmwill@google.com>
Date:   Thu, 01 Mar 2018 12:50:24 -0800
In-Reply-To: <20180228232252.102167-4-bmwill@google.com> (Brandon Williams's
        message of "Wed, 28 Feb 2018 15:22:20 -0800")
Message-ID: <xmqqfu5jfrlb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> One of the design goals of protocol-v2 is to improve the semantics of
> flush packets.  Currently in protocol-v1, flush packets are used both to
> indicate a break in a list of packet lines as well as an indication that
> one side has finished speaking.  This makes it particularly difficult
> to implement proxies as a proxy would need to completely understand git
> protocol instead of simply looking for a flush packet.

Good ;-) Yes, this has been one of the largest gripe about the
smart-http support code we have.

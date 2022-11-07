Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982B2C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 20:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiKGUtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbiKGUtc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 15:49:32 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF7327DCD
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 12:49:30 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id x21so7985228qkj.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 12:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOh2c7aazofnCu/bEFOfS+ApO5t10F5iF4iGtHUpWBo=;
        b=CjBaoV642tLSN5fkRloQmrY3e9dScyDtXUel88oPpnKlv8bRnGAViINHZB8A/AB3GQ
         Q+8EaO2U5rUeiXIG7jfGGxJ4xjxfKcaQrx848ax3jQBSExObc9MZ06QONl+fjDLl+QZb
         ENhIVj2H7QY5JeJeFJwzeTGIWPiOK66OQSb4qrv+GW/r1Pf/6iWzsA9dORUsA1gYp3rN
         TSaY8Jra/fkXRpaXYQ0OepLoIq1dkhpTkMAjp+R0hd/j7TOKbuwojPNUYPw1+IXXbMlh
         X9TcZcLzW6AQtWsC0KiU1o0TXvGhpe1hMmey4b3zr4WcTx9z47KpKrTxs4oxxubPbhIZ
         r7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOh2c7aazofnCu/bEFOfS+ApO5t10F5iF4iGtHUpWBo=;
        b=5waCVlUp84xp0hc6qPJKFY7AZGBv68gJyjgy1z+9ur6p96795ewLHSYTqVZrrejkjn
         xn1+8IeMPhoau1EZDI7YlAcy2hJS5xRWvqy/m6PY4UuxmQmDk0zb1XB+jDfLnYHlKlk6
         p39VoNKsFoj90rsJqCC30uk+KfjsOGpDkwUS8gWnaZ/fcJKB8CH3CiGJm1OUY0B7Jpgv
         KKQVf32k3/lMELN2sKUsVW58Mnkhz+MouABS8jZaZWm+0BAKx2ZqdoH+HX/yXAGp7Q7/
         6tt8PSGsawv3YtlYjcRvWpr9cUmYFP+dhXDstkr81SemCbWZ+4Mvs8MQOctGBS5JFznh
         igVA==
X-Gm-Message-State: ACrzQf0BCmaIIXBZ++ADste1ysiZWEdIhn9ddJR/lQz/MuKYcxoHElSS
        r8E6FVYIKTnh2SQ71Y+eRzZ2
X-Google-Smtp-Source: AMsMyM4h8V5E8OCRmPLrfMImGsKK+7EZ7dA2oMIGpWqqLWdyuDgkEw/y1rRReP/czE8FZ+1GSKP6ww==
X-Received: by 2002:a05:620a:25c8:b0:6ae:2408:6e9a with SMTP id y8-20020a05620a25c800b006ae24086e9amr37472688qko.222.1667854169545;
        Mon, 07 Nov 2022 12:49:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id a84-20020ae9e857000000b006f8665f483fsm7517970qkg.85.2022.11.07.12.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:49:29 -0800 (PST)
Message-ID: <22a74e0f-f389-7b9c-f2cc-b3581c246c75@github.com>
Date:   Mon, 7 Nov 2022 15:49:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] maintenance: add option to register in a specific
 config
Content-Language: en-US
To:     Ronan Pigott <ronan@rjp.ie>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Clement Moyroud <clement.moyroud@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Thomas Ackermann <th.acker@arcor.de>
References: <20221105184532.457043-1-ronan@rjp.ie>
 <20221105184532.457043-3-ronan@rjp.ie>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20221105184532.457043-3-ronan@rjp.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/5/22 2:45 PM, Ronan Pigott wrote:
> maintenance register currently records the maintenance repo exclusively
> within the user's global configuration, but other configuration files
> may be relevant when running maintenance if they are included from the
> global config. This option allows the user to choose where maintenance
> repos are recorded.

Taylor already provided most of the feedback that I would have given.

>  static char const * const builtin_maintenance_register_usage[] = {
> -	"git maintenance register",
> +	"git maintenance register [--config <file>]",

The only recommendation I have remaining is to rename this option to
`--config-file=<file>` since it is unclear from just "--config" if it
is a config _file_ or a config _key_.

Thanks,
-Stolee

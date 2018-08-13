Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C71D71F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbeHMVs5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:48:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50289 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbeHMVs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:48:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so9943607wmc.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YwWxCm5rXgtB/WYXXud1ptSFC9YpLXs5Ae20jla7vKA=;
        b=MFUi5T+yAncW8ZalB6lP58orGARXh0OtTlYNEwRfJo+qLmegjy/xQxIdm3JiPWtSBt
         6rA3GBRPGHsL/4a7vAQb4lTKFAXxFMoS2fQZM5pkTOUMRY3DElWkuAq7CT4siXcm/gHG
         qiau33q3W809DFPUpapoYYINPSY7lRRsn6DiW8MWgfoWqM4auTwSkfTxFzrxxzQSZxey
         zcigI1XSO0rYdUR5UBqdeHMYzbO4JRr4uaEsolZwUXc9yThKfLHdhhQ6AKq9xfh2jwNc
         mr2DaMO4SxcRw08UHmJW5C2ubg/stNE3cfAHJHtxtp0Nzw4sn8YUhL7npDw7ohP+eoGu
         z3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YwWxCm5rXgtB/WYXXud1ptSFC9YpLXs5Ae20jla7vKA=;
        b=NYm3x9OJPSp4JWXLokA9jtG86WomoaNh4IyMvKsGCPt7favIXU/64FhO2TqUBi2T/E
         NUzQ9QP8NISb1uxKYyeK3LTcPbUbPfDwebE/XrLyg0dTfyQGJYvJy0s7FKJuzOjFQwuh
         P4Imf4GhEZ4hNs9QozZ0MQkueXFaXtPu/uUnvioNRKwfpIBnRtnspYc9VYRdt0VDOXqI
         qjW6ckfu1Lmp3IO8fC0FELgGlOlWjxjtkHGOnkp09rY2eneCezRKPFA29jkRNGzUWhqe
         ZbJWqX2vOJR5Qdum09ybldN9Hdoc8PJXoMJkK4wDsRg0veRMCKxAHJwmQQRzhB9EbOzE
         Jlag==
X-Gm-Message-State: AOUpUlGcUzb/CQQq8d7Qali/bWT2P5wuXtaRR+GhPaCLFTiZMeOVEjB3
        fbOiWm5Asu9/bOD87Nm50n0=
X-Google-Smtp-Source: AA+uWPweSy7381QNKcct5zeVB7BKmCKzg2f0uvohw4s2/59dKPak8gHQ8ElE8CyjwEi7ahVbxthSSQ==
X-Received: by 2002:a1c:28c2:: with SMTP id o185-v6mr9007828wmo.40.1534187126153;
        Mon, 13 Aug 2018 12:05:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t15-v6sm22035678wrn.34.2018.08.13.12.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 12:05:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] t5318: avoid unnecessary command substitutions
References: <b2f5b69806c4c4a4009267701245aee4cabd2cf1.1531348540.git.jonathantanmy@google.com>
        <20180813003010.17610-1-szeder.dev@gmail.com>
Date:   Mon, 13 Aug 2018 12:05:24 -0700
In-Reply-To: <20180813003010.17610-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 13 Aug 2018 02:30:10 +0200")
Message-ID: <xmqqa7pq5bpn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> -	echo $(git -C repo log --pretty="%ct" -1) \
> -		$(git -C repo rev-parse one) >expect &&
> +	{
> +		git -C repo log --pretty=format:"%ct " -1 &&
> +		git -C repo rev-parse one
> +	} >expect &&

Heh, "format:"%ct " to make the first one end with an incomplete
line?  Neat trick.

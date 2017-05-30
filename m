Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79C6E20D0A
	for <e@80x24.org>; Tue, 30 May 2017 05:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdE3FnY (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 01:43:24 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33356 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdE3FnX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 01:43:23 -0400
Received: by mail-pf0-f194.google.com with SMTP id f27so15487097pfe.0
        for <git@vger.kernel.org>; Mon, 29 May 2017 22:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nc7lwHvRWxTkcaradnCu/1nZZTT/zobOihe6ra+OvyI=;
        b=VzoHsqWynPdJxMEWYg8E6zgtrZN9tp3aHetQH4YPoOI13dTn8G02F+mB1Uvr4Ftkce
         +kp3vRabtIGZ5paYEdPRRLEymQIdrGcpM3Ig1qZGDhm6q8DU4A6VsBTzPfks9YkY7Wsx
         2vqs1m85pmWHNOuKja4HSxoTxI4ygECBFr78ULsKVt7WCCXyobvslad/9iiGjd9IQJJD
         qk+XjPZFNQzZiSbbhOlLP+we4XHb/l9jSferXZFuGTe99LbSslTAlmny6bKDaCKIMIVb
         4OlLH29MHx3SEWFbppKsWOzpDtTEezDgm5lfRnh4T0kcXe3gqPUBn+0TXH2rLr/KussS
         mRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nc7lwHvRWxTkcaradnCu/1nZZTT/zobOihe6ra+OvyI=;
        b=hixLlUZXQoarjHsvj+46tECU49gL6T4YZitVrSh3+smkhg4w9xAqW4d0Dgxu6te9PI
         NoPWDPyAdPZVwkOqpUDSxorN16qclaqjYasF6i23z58jOOFht7kRtJex+Lo09sDDSzPl
         l+7hUEePeLFZD/d9nGnRszeCD5D6Ng8veDl2rk1zCyEHc3mS3FV1X5SaLv7FR0p/uuD/
         Ef1twRyvUei0NmoOtk44qnS3my1zqLsGPrz1VqRhykD0/0Xr36NLMBdvzB7GPZH3FIs7
         +i/xe+VD51B3M5nMRTJ6ZwRev9x8uTEcrm+Ppm53nSxBvmap34PSqe94cxmEtrnuu02o
         6avw==
X-Gm-Message-State: AODbwcC52JELMC1ErAjK3lMI0T7O0yvvwmlxJZD2hkYvirem9at4dhwi
        WOCliQLGvxjByA==
X-Received: by 10.98.217.154 with SMTP id b26mr21382371pfl.136.1496123003157;
        Mon, 29 May 2017 22:43:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id q194sm18808482pfq.56.2017.05.29.22.43.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 22:43:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/8] am: handle "-h" argument earlier
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
        <20170530051122.u6uu3dohtilkk7ia@sigill.intra.peff.net>
Date:   Tue, 30 May 2017 14:43:21 +0900
In-Reply-To: <20170530051122.u6uu3dohtilkk7ia@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 30 May 2017 01:11:23 -0400")
Message-ID: <xmqq60gidhmu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We can't easily move that setup to after the parse_options()
> call; the point is to set up defaults that are overwritten
> by the option parsing. Instead, we'll detect the "-h" case
> early and show the usage then. This matches the behavior of
> other builtins which have a similar setup-ordering issue
> (e.g., git-branch).

Thanks.  And this structure of the series is very much appreciated.


> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/am.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 0f63dcab1..5ee146bfb 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2311,6 +2311,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>  
> +	if (argc == 2 && !strcmp(argv[1], "-h"))
> +		usage_with_options(usage, options);
> +
>  	git_config(git_am_config, NULL);
>  
>  	am_state_init(&state);

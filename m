Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341171F462
	for <e@80x24.org>; Tue, 18 Jun 2019 13:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfFRNgg (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 09:36:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46445 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729556AbfFRNgf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 09:36:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so21764071edr.13
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=fBGojJkHQUShDfnKEjJvZETUPzVYnDUuaPcmGPsXUVA=;
        b=sS76UQCtjRdDvP3FgSGo7ZLgJ5y+RsqvUOcZ3mQ+HeXFJ/HwQc6F1mxBvXsKkZUbOb
         aRoteqOJxHqknzi2ixkpzL4e9NAa0/xKoRgafQZms/xnwkluv5NAmkemtIAcQHq3L++e
         R8kVhSUIy3GDCZpu/Y/GY8EcjWK8FwDUE9/zIKpMbABPXVg0NhcbdO/KCH2Cbc1m3tKd
         BSGFvPWYhhBFF7mH4+fil/KaJFxTufTcuRLKO/HWaZru78PvIb5zkByLVU5OTE3tBDoT
         tH1X9/NWhq/a2UA2rEwqQ6LVshuOswB861qIIdSxDTKFQlrSyTDSOy22qL+vJzyxv/iQ
         O+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=fBGojJkHQUShDfnKEjJvZETUPzVYnDUuaPcmGPsXUVA=;
        b=f/jpUAYZDK06RV8VWYUKhiUZ/FwZmDmHTqQAj8ffS9+LSSXf0AqLXHRZnmxciljNtt
         tbc7FpBXiVsYzwOInMhYJ7mGQMq2HngcKe+4zVX8d2ld0h3Bu7TF1/GcS0Kik5WxFtCD
         tKZPNM+DomqaGrjiIRNlzi9MVUq24U0s6GGm3jeWmayCg4i0p3OI72dMZtjJpM04+F8c
         zOAMLPpKxtcoovrHhkgkagO40invYgsJ+O+F+908WHtJiY0FNROElagJ/V6Lz3C8xpEw
         s9goXarVNnjPsKztXWhy2DK3Nqxaq3vpHQsnceVXVVs3fB6eJ1Pu/0ICAxdCzwDkD+ou
         LZCA==
X-Gm-Message-State: APjAAAWuoEo+FtsrDbuPjVRhE6dHfCkFtg0GMGVttrZm/wZ7cOmz7a1N
        BDDx8asEkwEsmBa39bsW1K6AufNF
X-Google-Smtp-Source: APXvYqwN4EQwCV0BvhdR6UB7GlIm+7LUm9B+AVUnYBXDBK78eNQ7ycF8oKpuAZqVIYWsksdaSQgJIA==
X-Received: by 2002:a17:906:3043:: with SMTP id d3mr4147783ejd.93.1560864993797;
        Tue, 18 Jun 2019 06:36:33 -0700 (PDT)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id 34sm4799388eds.5.2019.06.18.06.36.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 06:36:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com
Subject: Re: [PATCH v4] fetch-pack: support negotiation tip whitelist
References: <20180625193752.255319-1-jonathantanmy@google.com> <20180702223944.224755-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20180702223944.224755-1-jonathantanmy@google.com>
Date:   Tue, 18 Jun 2019 15:36:31 +0200
Message-ID: <87o92v817k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 03 2018, Jonathan Tan wrote:

> During negotiation, fetch-pack eventually reports as "have" lines all
> commits reachable from all refs. Allow the user to restrict the commits
> sent in this way by providing a whitelist of tips; only the tips
> themselves and their ancestors will be sent.

I discovered a bug in this...

> @@ -230,7 +246,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>  	if (args->stateless_rpc && multi_ack == 1)
>  		die(_("--stateless-rpc requires multi_ack_detailed"));
>
> -	for_each_ref(rev_list_insert_ref_oid, negotiator);
> +	mark_tips(negotiator, args->negotiation_tips);
>  	for_each_cached_alternate(negotiator, insert_one_alternate_object);
>
>  	fetching = 0;

Here we blindly add objects found in an alternate repo. I found and
debugged this with this:

    diff --git a/fetch-negotiator.h b/fetch-negotiator.h
    index 9e3967ce66..cbe71c9c8d 100644
    --- a/fetch-negotiator.h
    +++ b/fetch-negotiator.h
    @@ -33,2 +33,3 @@ struct fetch_negotiator {
            void (*add_tip)(struct fetch_negotiator *, struct commit *);
    +       int done_adding;

    diff --git a/fetch-pack.c b/fetch-pack.c
    index 3f24d0c8a6..6b43b4f8f1 100644
    --- a/fetch-pack.c
    +++ b/fetch-pack.c
    @@ -238,2 +238,3 @@ static void mark_tips(struct fetch_negotiator *negotiator,
                                        &negotiation_tips->oid[i]);
    +       negotiator->done_adding = 1;
            return;
    diff --git a/negotiator/default.c b/negotiator/default.c
    index 4b78f6bf36..4e45f05f25 100644
    --- a/negotiator/default.c
    +++ b/negotiator/default.c
    @@ -137,2 +137,4 @@ static void add_tip(struct fetch_negotiator *n, struct commit *c)
     {
    +       if (n->done_adding)
    +               return;
            n->known_common = NULL;
    @@ -166,2 +168,3 @@ void default_negotiator_init(struct fetch_negotiator *negotiator)
            negotiator->add_tip = add_tip;
    +       negotiator->done_adding = 0;
            negotiator->next = next;

Perhaps something like that with an assert() is a good idea for the
negotiation backend code in general? It seems rather fragile to depend
on there being no other codepath that calls add_tip() again after some
other code (--negotiation-tip=*) that expects it not to be called again.

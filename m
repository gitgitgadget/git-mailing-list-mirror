Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63CF1FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 09:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761125AbdDSJe6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 05:34:58 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36134 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760784AbdDSJe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 05:34:56 -0400
Received: by mail-io0-f182.google.com with SMTP id o22so17686756iod.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y57DRAIn6BefGWAqFKGN5eSHh2vQgXic5JSa/FfnYzM=;
        b=HItXYxIrGvofyf+eBf3tJQe8ZWlqz6N+zcWakRfeQ2KWi4um6rgCKU06nF7WKalvmr
         p4QiOFHdFA2182ipbSWMm1c3fCfb2uYiSx3bZ9r7bJy5Xa7bbz1mKVfJOVdCSqpSeCO4
         qcoq6blxaQ2zAscvFq7bTJr3kd8AJwqkDHRT1BUIZnfJxb2kwjk11xeCATNqcHpc+IdA
         C4XKeWkIyofYaWCSxIDT7jA3q2GKjfcX6wAjaF4dZpOepBmDW97vS+g37LicxhAtf9yW
         tKJxHANg2F05Xw2/JYg/ny0vUo0BhutyQEHEIIM5/+wdd4KGbcmTXfaBI04lbFES4Wm8
         K9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y57DRAIn6BefGWAqFKGN5eSHh2vQgXic5JSa/FfnYzM=;
        b=Gt6f2mWG8MiLpE0QmENiC0dlEDJPZAWHhhyYD2+re4+Ds54lgNWYhBFBaFhu7EGlGn
         V5oklKrfaqSqTNiVIhsihMeh9LKu+Bcx8D9nMBc9aJCSGUebTqWybl8mrNWKvAy4PFi9
         FIWmrd1k8B0frBNY5YFj8oSEjD5P0IJP/2SnpsVwlOdx5BxMCjvEpG0nzaahPtmz9SI6
         B77Xf9WLUAkEHfCcUlxUqUTmjidMfbEzkKiqBvrAv03PpsDSNRxW6X5GxLCyjPyCk6U6
         EIP7SsPUbIOTL5IK1f3lGs90L2ftXr3yQS9sk4ozhfu6dut5MBPnDE0aSMnmJi7DkBdA
         v+ow==
X-Gm-Message-State: AN3rC/4jxJzbCMKTzNF4ks92g+P+e9QJU1AgMFYnZtoLn8Wp/FrLI1wL
        0KGP7AqGwNEqukvPaq8VTlNqlSSnyQ==
X-Received: by 10.107.32.199 with SMTP id g190mr2244995iog.117.1492594495911;
 Wed, 19 Apr 2017 02:34:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.169.85 with HTTP; Wed, 19 Apr 2017 02:34:34 -0700 (PDT)
In-Reply-To: <20170419090820.20279-1-jacob.e.keller@intel.com>
References: <20170419090820.20279-1-jacob.e.keller@intel.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 19 Apr 2017 11:34:34 +0200
Message-ID: <CACBZZX5_fJ9w_K4H8R-NMi7kiR5QkR35pRqvzDRr_=rhMSQvfg@mail.gmail.com>
Subject: Re: [RFC PATCH] parse-options: disallow double-negations of options
 starting with no-
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 11:08 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> Many options can be negated by prefixing the option with "no-", for
> example "--3way" can be prefixed with "--no-3way" to disable it. Since
> 0f1930c58754 ("parse-options: allow positivation of options
> starting, with no-", 2012-02-25) we have also had support to negate
> options which start with "no-" by using the positive wording.
>
> This leads to the confusing (and non-documented) case that you can still
> prefix options beginning with "no-" by a second "no-" to negate them.
> That is, we allow "no-no-hardlinks" to negate the "no-hardlinks" option.
>
> This can be confusing to the user so lets just disallow the
> double-negative forms. If the long_name begins with "no-" then we simply
> don't allow the regular negation format, and only allow the option to be
> negated by the positive form.

Looks good to me. Addresses the bug I was trying to fix much better
than my patch.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C742023D
	for <e@80x24.org>; Wed, 28 Jun 2017 20:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbdF1Ug7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 16:36:59 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33008 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbdF1Ug5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 16:36:57 -0400
Received: by mail-pf0-f177.google.com with SMTP id e7so39018509pfk.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U9gNl6uwkvXrI2pIRPZiyHCL3T/HSbpMaHq3EnmISjk=;
        b=JifWsWWWr9FSGAaL7Ru7mkbrrDJwVvU8vZnbQnlHaVvqhT+34R38o6//ihA0RVQ2Hc
         L6YfLNSbZkbMxQcIBtUiNv1GhN2HzO4VYnHknQMOlhT4/mLeSZWgvRX/lDlUJBl812A1
         jpg6riVZD4Ue/6AwEwltPMVOLgmNa4wgxqS/v2f3nYfxVQ+IGBM0LHuXWitKotMg6D/C
         n5T25f+8fC2GJR6iwoz9hu9Gud4m3TlIeM1lXi9SfBkwvuTrp77FNfe/8MBjz/XVd9Do
         pk276XVN8osgA0dRDNKlcfIa72nkXW6RHxF1OB8fNFlaB0FxdXSs1bGMK9mBzRmliIUS
         86IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U9gNl6uwkvXrI2pIRPZiyHCL3T/HSbpMaHq3EnmISjk=;
        b=VOWj1h4UxcsIxgJBkOkyzk5RWvYNsI4fNwUYmFNalcV6YOsA109BwA062zTq6gGd7b
         e0ckVWsQpCHMs/lXjeX3C0oZkbYYKCD2GB0qHkm6azKxNzHvhh4e5MCmVh1oN+4Z3NLa
         n0L6J58rLNHoZC7mPYpImj+5dTTesd9xWJ+M1EXidkof5zQDATHsuy7d+Z53h5hEUeCL
         RJiu3g0617OKEk2yKGtGg4l/RmpoJNPI9WIH9DRlcuc3/SgUiWjjIHXlEeMQ69vV0jQx
         yFhUL243ISV7XnlYV/MznhkL1xzWkI2PIVPk5Ybk/dtmHamMm4N5PEMQin2YYIFbbjkc
         vTmw==
X-Gm-Message-State: AKS2vOzy7DjKDjMRAJkMDLgNPTPByBNHfAJbaFAeiXti90vSEhtcrE9+
        kVPhREiZFq687L0wKSCFRNAM/DnN9WwqGk9T7g==
X-Received: by 10.99.141.76 with SMTP id z73mr12256088pgd.40.1498682216788;
 Wed, 28 Jun 2017 13:36:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Wed, 28 Jun 2017 13:36:56 -0700 (PDT)
In-Reply-To: <xmqq37akya3j.fsf@gitster.mtv.corp.google.com>
References: <20170628005651.8110-1-sbeller@google.com> <20170628005651.8110-7-sbeller@google.com>
 <xmqqshikye0o.fsf@gitster.mtv.corp.google.com> <xmqq37akya3j.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Jun 2017 13:36:56 -0700
Message-ID: <CAGZ79kbsAi95+ZgjMem+MViKiXby7gZnGyg4Hbua5xw6TaPz_w@mail.gmail.com>
Subject: Re: [PATCH 6/6] diff.c: detect blocks despite whitespace changes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2017 at 10:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Looking at the implementation of get_ws_cleaned_string() that is the
>> workhorse of emitted_symbol_cmp_no_ws(), it seems to be doing wrong
>> things for various "ignore whitespace" options (i.e. there is only
>> one implementation, while "git diff" family takes things like
>> "ignore space change", "ignore all whitespace", etc.), though.
>
> This probably deserves a bit more illustration of how I envision the
> code should evolve.
>
> In the longer term, I would prefer to see emitted_symbol_cmp_no_ws()
> to go and instead emitted_symbol_cmp() to take the diff options
> so
> that it can change the behaviour of the comparison function based on
> the -w/-b/--ignore-space-at-eol/etc. settings.  And compare two strings
> in place.

ok, in-place is no problem. But passing down the diff options into the
compare function is a bit hard.

Originally I wanted to do that, see prep work in [1], but Jeff explained that
the additional pointer in the compare function is **not** supposed to be
a additional payload (such as the diff options specifying the white space
options.)

[1] https://public-inbox.org/git/20170512200244.25245-1-sbeller@google.com/

However as we no settled on the struct emitted_diff_symbol,
that has a 'flags' field in there, which ought to contain everything we
know about whitespace settings, we should be able to do that from there.

>         emitted_symbol_eqv(struct emitted_diff_symbol *a,
>                            struct emitted_diff_symbol *b,
>                            const void *keydata) {
>                 struct diff_options *diffopt = keydata;

The prep work mentioned, would allow for this, as keydata
would be passed through as-is in all calls of the hashmap API,
such that the user can decide if they use it as the actual 'keydata'
or rather as an additional payload.

Thanks for outlining the idea in code, but maybe we need to
reconsider the hashmap API before that.

By not considering the change in the hashmap API, the current
implementation tried to get away by having different compare functions.

Thanks,
Stefan

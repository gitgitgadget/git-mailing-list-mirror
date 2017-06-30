Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66163201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 17:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbdF3RUP (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 13:20:15 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35895 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbdF3RUO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 13:20:14 -0400
Received: by mail-pg0-f53.google.com with SMTP id u62so66561973pgb.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 10:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hcbLYVBfuuK7ykwtrZHhZUXeKJ2E6YAT3T7rHTcmkvs=;
        b=lz5eBaiO50nxTapixK5ys4Qb2zjsvllx4M3p1ke9j6jq883VnAcshP6Ckm1rnpxtVs
         CdkCs51rZTihAPcSlU7DDHAkXWseBP3oIwrmj181xrKuX6BOwuk/FtozQEGTjNQ+sEYU
         Cc9V4YzZU+geaXlVrc+AKgn8ODQKW4O0zPALTATkT/qYVzoDMRiickxUkpaZCMlbXv4a
         Dizy2/9oD4YGRJYEBB/5mU2JskuI5WrGxW0/64lRqRVJlYc9VX9uHoTumZVhGn+Wai4A
         H6YH6kSdur8Hd5DZeIKtmsco4BppsFXJlwkShakAsHYKDvF5ZWwpFK3sa23UQV1ULTVq
         zzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=hcbLYVBfuuK7ykwtrZHhZUXeKJ2E6YAT3T7rHTcmkvs=;
        b=A2XM4YPe3+5E6bZmDNB9m0uDbIQDewChPfW5MTQEeovP/qZ/YKy/56rQPSV9gC1rCx
         NIvcPCQB3v6/TSL1hZrFQmfuWLoZHZnCXfEs1oteIh1ELUIs1qTfaY1ufgDbdBcwwoL8
         O021aeujk46dzgAcGf9QmR2eVmMikBsvAH/UB2ibKR7MEdK/wijFKcMUqOah4VgkGDpM
         Mg+pdW9zOXWt2PpheQZ1Jf4n4TXOCOj0+tlT/0mN1uJcBjWuWchGmISJSptFiox5AljE
         s/gVBOOHlHqVK5geT/N2jqmaTIxl50etm+71tPYeNUNW4v6YLg8GKuIHi3LzqjE0+Bk6
         OpZw==
X-Gm-Message-State: AKS2vOx10mhG7DwO3FYUEME/EH9Tg1e4AbXjrJrvD2hVfLAF1VlUutGJ
        ndJMVMRw7eB0QQ==
X-Received: by 10.99.115.2 with SMTP id o2mr22388233pgc.48.1498843213210;
        Fri, 30 Jun 2017 10:20:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id z82sm22430058pfk.1.2017.06.30.10.20.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 10:20:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v2 5/6] grep: remove regflags from the public grep_opt API
References: <20170629222222.4694-1-avarab@gmail.com>
        <20170628215809.23060-1-avarab@gmail.com>
        <20170629222222.4694-6-avarab@gmail.com>
Date:   Fri, 30 Jun 2017 10:20:11 -0700
In-Reply-To: <20170629222222.4694-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 29 Jun 2017 22:22:21 +0000")
Message-ID: <xmqqwp7ts88k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> @@ -169,6 +167,24 @@ void grep_init(struct grep_opt *opt, const char *prefix)
>  
>  static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
>  {
> +	/*
> +	 * When committing to the pattern type by setting the relevant
> +	 * fields in grep_opt it's generally not necessary to zero out
> +	 * the fields we're not choosing, since they won't have been
> +	 * set by anything. The extended_regexp_option field is the
> +	 * only exception to this.
> +	 *
> +	 * This is because in the process of parsing grep.patternType
> +	 * & grep.extendedRegexp we set opt->pattern_type_option and
> +	 * opt->extended_regexp_option, respectively. We then
> +	 * internally use opt->extended_regexp_option to see if we're
> +	 * compiling an ERE. It must be unset if that's not actually
> +	 * the case.
> +	 */
> +	if (pattern_type != GREP_PATTERN_TYPE_ERE &&
> +	    opt->extended_regexp_option)
> +		opt->extended_regexp_option = 0;

Good to have the reasoning in an in-code comment like the above.
But after reading these two paragraphs and then before reading the
three line code, a more natural embodiment in the code of the
commentary that came to my mind was

	if (pattern_type != GREP_PATTERN_TYPE_ERE)
		opt->extended_regexp_option = 0;

The end-result is the same as yours, of course, but I somehow found
it match the reasoning better.

Now, I wonder if this can further be tweaked to

	opt->extended_regexp_option = (pattern_type == GREP_PATTERN_TYPE_ERE);

which might lead us in a direction to really unify the two related
fields extended_regexp_option and pattern_type_option.

Even if that were a good longer term direction to go in, it is
outside the scope of this step, of course.  I am merely bringing it
up as an conversation item ;-).


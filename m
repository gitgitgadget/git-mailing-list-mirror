Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BFE31F404
	for <e@80x24.org>; Sun,  8 Apr 2018 23:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeDHXSW (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 19:18:22 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36452 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbeDHXSV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 19:18:21 -0400
Received: by mail-wr0-f179.google.com with SMTP id y55so7021682wry.3
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 16:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=SxTM8tDZh9FNZKjIv1n5AZ8SkNlInKKlgcywUbyYj3I=;
        b=WRn7ah0F61uzQ9yvqB4YM8j9/21xDdX5//Lbeysytaq1uV3dRc4mP+5L0e1il6yobv
         1ySNO3LWi1JzXFTPctZf/MSzlIWKdvOJFCbrMlg2woWwl0NsnMh+zyiidVYMaUSoEbqb
         XerfM28I1H7tRhHR6hHETuz1+WKd24r5wFetcknEJw6BVII8cvfxrNU8x2Whr7SzS1Q1
         frsziui1ohDSebuEXixipt/a6ciwrq6g6Z5OTMJGPrtICYkyEv+B9F1Y9IQ05r4qIQXd
         57Cl/1eXgIHWuyjz+Q47gVuHI7JloKrXr/s5mrDHErcemRRCOeAjngJrNlXai3PeuaDc
         CNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=SxTM8tDZh9FNZKjIv1n5AZ8SkNlInKKlgcywUbyYj3I=;
        b=GH4h7cxU/sjK2ZYeNeEOi/4jtQtxnyqaYfEFO9tfQ42pTcL2WXTty02e/zgj6wLIQt
         KFxB/z8jhAVw8K/lpVRswbvkRIzokR/JfsSnc+zmflwFy9kvNfbV37E7R+aK3txkjfQG
         B3eZXsWNO0fSQIMmz6G+mStkIksm2sV2dZG1J1Ex3hjqCCr8Hm9H6c6Mok/E69Tfch0z
         ZMiH7wNgDzxEA9OtiRXlS4iBNS/e6pzN1vGOmrDEqDN8cTw8m2T28mG+HwmbTzDIavSd
         yuteAQEcs6UQ15pFxyV9PNVf9RSd/3fPNd7uc+h3d1e/nBoA8+8Enqo6CGsSqAUFD4N+
         Vb0w==
X-Gm-Message-State: AElRT7FcVWsJRnmHSg7VyLC9RCJwTioDmlyu4tFFmCr+wWh6eO43RG0m
        IHIXC7K6zx/bh1/ddk9eARM=
X-Google-Smtp-Source: AIpwx4/57bvC7Y8uDSvMr2Flcj6GDeaDyDlG+qgsaEITvmqWL6tWSVcTp0kWhpIkarIbTqbf62ci2w==
X-Received: by 10.223.142.164 with SMTP id q33mr23484406wrb.72.1523229500037;
        Sun, 08 Apr 2018 16:18:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n47sm15151918wrf.41.2018.04.08.16.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 16:18:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com
Subject: Re: [PATCH v4 1/3] builtin/config: introduce `--default`
References: <20180329011634.68582-1-me@ttaylorr.com>
        <cover.1522896713.git.me@ttaylorr.com>
        <20180405025912.GB49902@syl.local>
        <20180405222949.GC29117@sigill.intra.peff.net>
Date:   Mon, 09 Apr 2018 08:18:18 +0900
Message-ID: <xmqq60518eyt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Apr 04, 2018 at 07:59:12PM -0700, Taylor Blau wrote:
>
>> @@ -286,6 +288,16 @@ static int get_value(const char *key_, const char *regex_)
>>  	config_with_options(collect_config, &values,
>>  			    &given_config_source, &config_options);
>>  
>> +	if (!values.nr && default_value) {
>> +		struct strbuf *item;
>> +		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
>> +		item = &values.items[values.nr++];
>> +		strbuf_init(item, 0);
>> +		if (format_config(item, key_, default_value) < 0) {
>> +			exit(1);
>> +		}
>> +	}
> ...
>
> It's obvious in this toy example, but that config call may be buried
> deep in a script. It'd probably be nicer for that exit(1) to be
> something like:
>
>   die(_("failed to format default config value"));

Together with key_ and default_value, you mean?

>
>> +test_expect_success 'does not allow --default without --get' '
>> +	test_must_fail git config --default quux --unset a >output 2>&1 &&
>> +	test_i18ngrep "\-\-default is only applicable to" output
>> +'
>
> I think "a" here needs to be "a.section". I get:
>
>   error: key does not contain a section: a

"section.var"?  That aside, even with a properly formatted key, I
seem to get an empty output here, so this may need a bit more work.



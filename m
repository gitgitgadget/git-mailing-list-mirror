Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E0620401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbdFUVzl (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:55:41 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35380 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbdFUVzk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:55:40 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so30146318pgc.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Tli10KTUJdLUokKLI4/fVQUlGu0xyV1V8Yyb/q8yvNI=;
        b=hHLp+uY5lQWt2p52vSCub0aud4yb936nHc6aru2QzK3SS5j5FdVyc111gd0nqcydse
         D10v344TsK2iuoiY6cgYwiFWqpzzxYYMSJ+tpajUQ9aeaiZXNPoECdwYq3NUIHxxJxKo
         FOu+rD5NVp3ts4zys4rc2k7qJIxyT5C/fxQWZtZ6qcQI+YGudQ3gCmo+AmLsM5gTZMO/
         xjNLAekjkbh+ShWIg4ETSVTSPKgo5nSNPrTnfQRHP/+GfJb1dSoZETwEzhEosGKlersW
         An/vtG6PLzGGDm6LQ38yE3mr3SK73/yuB2UiFACTKPF6yBD+f2R5bLhGnl0LNYhvLr9d
         Nd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Tli10KTUJdLUokKLI4/fVQUlGu0xyV1V8Yyb/q8yvNI=;
        b=nvP4T81eTaGLKSZRh8Ddv2jzRHeDGiRDM1iqNDzIzguNZPBlCMk6TdRd3YwNwO11xJ
         aaB1d1Uyl/T3ux8druKlk5oFf/m5Po/x/mE7Y3TwQlALcsjrD+6Wth8u0v/Jp+V7r5RU
         wsAZILPHCfeTMZGNUW8rvj+s85aNhqcINY4vMuS+7gdh9DPXWLg4vlYcVOYaMN01xfVh
         jtEhNWLpQd/egVdRmYWQ4/kLs/VYfjYQoL0tcdp/Lb0ODxGq5HegHgyE2kiow4Tsg/Zq
         ja6qhTiWaVLHfKm09/U4kuiY1TWOhrgENiyDGZxC+q2/9kPbWsW5irUzE12cKumz/++/
         hp9w==
X-Gm-Message-State: AKS2vOzMAT0pXNK7rmbl1V2J2UEwm/sCbW/wOjXCtYGCa2GOOWdVk5H+
        FTXcKV9DJ0a8Vw==
X-Received: by 10.99.96.85 with SMTP id u82mr39356248pgb.214.1498082139493;
        Wed, 21 Jun 2017 14:55:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id 25sm15110979pfj.59.2017.06.21.14.55.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 14:55:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: Re: [showing-off RFC/PATCH 26/26] diff.c: have a "machine parseable" move coloring
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-27-sbeller@google.com>
        <20170621215104.GF53348@google.com>
Date:   Wed, 21 Jun 2017 14:55:38 -0700
In-Reply-To: <20170621215104.GF53348@google.com> (Brandon Williams's message
        of "Wed, 21 Jun 2017 14:51:04 -0700")
Message-ID: <xmqqh8z9m2ed.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 06/19, Stefan Beller wrote:
>> Ævar asked for it, this is how you would do it.
>> (plus documentation, tests, CLI knobs, options)
>> 
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  diff.c | 15 +++++++++++----
>>  diff.h |  2 ++
>>  2 files changed, 13 insertions(+), 4 deletions(-)
>> 
>> diff --git a/diff.c b/diff.c
>> index 7756f7610c..61caa057ff 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -997,6 +997,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>>  	static const char *nneof = " No newline at end of file\n";
>>  	const char *context, *reset, *set, *meta, *fraginfo;
>>  	struct strbuf sb = STRBUF_INIT;
>> +	int sign;
>
> should this be a char instead of an int?

Perhaps.  Once we start adding things other than + and -, I think
they should no longer be called "sign", though.

If Stefan chose '*' as a replacement for '+' because both makes
things larger (yes, I am a positive person and my numbers are all
positive), probably the replacement for '-' should be '/' (or '%'),
not '_'.  But that is just bikeshedding.


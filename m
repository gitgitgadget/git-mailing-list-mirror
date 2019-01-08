Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82337211B4
	for <e@80x24.org>; Tue,  8 Jan 2019 19:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbfAHTpK (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 14:45:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32941 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731360AbfAHTpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 14:45:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so5328276wrr.0
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 11:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bkp4d0CablNqcsbRj8j1tAkJZ6i5DSE0RaeI9+zdyVo=;
        b=alUWbsShw0Dh9xosdJMdHFALZNSoJqGu2dv84svgTb8mUhSNSjl4afMwj0UZ93Z+yn
         4h7sbvr9AiW96SxgPFCDCwqHJimt/w4VOnupxyAGMJLLoIb/6/l3636OFlyTsA78gcBl
         AwS7q3IWQkEilSGNMtPqRLLgPi89JoopF4k2vF/4VouKxpQ26H1T8Db9Dji4dm2Au+dq
         24MSah0dANA/3pQLLOyNVQMXTRv5dg0OinfgD6Auimlsl1gFd7QNowqH8TRyr+ksGfej
         h+/3Ss5+bX7JXUHByNC8JbrO/N9AkJQXh1b6K5v+QcgRrK514Qt3g1X8A2XpkCPTyILP
         CaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bkp4d0CablNqcsbRj8j1tAkJZ6i5DSE0RaeI9+zdyVo=;
        b=G2aJ9c9ZW1/tG24bcBOulLSq2gzrjk6+3p0i1VDkmtBKQvr1mg6N4OVDfUGDBq8XH+
         rKq6RVL50a3xr6614VyATsDx5pqHWt9FOwIpwPYjDnicQSqj1pmGTppw5B8LTR2aV8dB
         d5WFrgNtOQVeqf7am5RvLBXZK0ZF7tayCM2pafVETIwtAwDIeti78XPnGfRQD/1pOTvf
         NpbwobDXPWlA5qg1sJTqcxoYGsyrGsPThG2Vo9hyVfwb4+AmGYVShLxh6xBhtGK5r7cT
         sQq7hVZ0OYWhLWh+WVVdFmVZziMolOJwP6361bfQNOACGmAsOTFiXzdPJkXgsmGZ8dyk
         vwkw==
X-Gm-Message-State: AJcUukdZFVb0q3o5QFf35u+20M8A9hLzjxs86Mp8YWP5Wbf/I+NgaP5T
        vnvi62x05S+/AZN3+GzNLAA=
X-Google-Smtp-Source: ALg8bN68v+v1kR9QrGDrk2cH1mEbAi45sovDaSb1Jgc+C4+Gl1vyq3sPKopwT5IaSjcekm+P9jKWJg==
X-Received: by 2002:adf:9521:: with SMTP id 30mr2304098wrs.192.1546976707463;
        Tue, 08 Jan 2019 11:45:07 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h17sm54016777wrt.59.2019.01.08.11.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 11:45:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 4/4] fetch-pack: support protocol version 2
References: <20181213155817.27666-1-avarab@gmail.com>
        <20181217224054.4376-5-avarab@gmail.com>
Date:   Tue, 08 Jan 2019 11:45:06 -0800
In-Reply-To: <20181217224054.4376-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 17 Dec 2018 23:40:54 +0100")
Message-ID: <xmqqva2z3pdp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> From: Jonathan Tan <jonathantanmy@google.com>


I was looking at the topics in 'pu' and noticed that I had v2 of
this series, wanted to update to v3, but major part of it was
superseded by another topic (jk/proto-v2-hidden-refs-fix).  That
leaves only this patch in the v3 of this series.

Is this one still relevant?

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 086f2c40f68..49c540b1e1d 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -439,15 +439,23 @@ test_expect_success 'setup tests for the --stdin parameter' '
>  	) >input.dup
>  '
>  
> -test_expect_success 'fetch refs from cmdline' '
> -	(
> -		cd client &&
> -		git fetch-pack --no-progress .. $(cat ../input)
> -	) >output &&
> -	cut -d " " -f 2 <output | sort >actual &&
> -	test_cmp expect actual
> +test_expect_success 'setup fetch refs from cmdline v[12]' '
> +	cp -r client client1 &&
> +	cp -r client client2
>  '
>  
> +for version in '' 1 2
> +do
> +	test_expect_success "protocol.version=$version fetch refs from cmdline" "
> +		(
> +			cd client$version &&
> +			GIT_TEST_PROTOCOL_VERSION=$version git fetch-pack --no-progress .. \$(cat ../input)
> +		) >output &&
> +		cut -d ' ' -f 2 <output | sort >actual &&
> +		test_cmp expect actual
> +	"
> +done
> +
>  test_expect_success 'fetch refs from stdin' '
>  	(
>  		cd client &&

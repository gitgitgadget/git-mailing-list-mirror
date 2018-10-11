Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4DA1F97F
	for <e@80x24.org>; Thu, 11 Oct 2018 07:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJKOhn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 10:37:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44193 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKOhm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 10:37:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id m18-v6so5861494lfl.11
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 00:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+XCTrGHx8JfpMRQZqRtB4mUeWXp2Hf6ZEOcXq2Zh2N4=;
        b=BCUqd2bcViyAjy+7yIAjnxabn98lviGgb+2L19GJQOENzdvunBwFWP+jky9B4mZkto
         bE54LvdXPnstb/mB7GpTSpAGRVtTpswCIHPQqlhzwYJMEhDAgZnzTmvjAHup44KGTrz5
         hX9YMALeHZDLCwUb/r1Q2HqvvG1DGEAAOCoBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+XCTrGHx8JfpMRQZqRtB4mUeWXp2Hf6ZEOcXq2Zh2N4=;
        b=aGgwkvvVMwZXSdTD5njDmgDvZbW5oY8O6WvscUQ0Mwi2p8NtOIrj7mx+d1k8wX0csc
         K2pAaanxhurP3/BP+tqHOq8hi5rYRtRTOPHbh9dQANKW9vxBk6NdDAilKhvRIs9vReQ2
         KHDugntM8OF2aFvyMAXPkfuyv/nZaKM72+O1x2SlPrDOggZt9kF9f7HYvK59MeYQ5YXN
         Of5Ab5eYPNeZyFuCupliA3VydPUMgTtoojiMAUIS6CVVJhgl+SIqdFT1Xh5MVzwECjkh
         eay6YJTJAphWpseSSlxprHy36dImbOxTuN7fUJbJ/csBC3ORot9y2rSkFcBk1gkxa1a9
         Tzkw==
X-Gm-Message-State: ABuFfoi0RhOusWt+C/DBK+NJ9PeiTZrDV0PYBmje0OFGDR6Apn5bTs/s
        87mA8oCTH+JL3tRy1RWGxywbQw==
X-Google-Smtp-Source: ACcGV60V1unKbBU6xm/VoNxm+QSiUuVLB5QqzQAMhqFo8G4E8W5I7yQ8cTFtWaOyWJRZbrHKEZwKxA==
X-Received: by 2002:a19:2a8c:: with SMTP id q12-v6mr266909lfq.95.1539241904763;
        Thu, 11 Oct 2018 00:11:44 -0700 (PDT)
Received: from [192.168.0.189] (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id z142-v6sm5404067lff.82.2018.10.11.00.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 00:11:44 -0700 (PDT)
Subject: Re: [PATCH 3/3] send-email: also pick up cc addresses from -by
 trailers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Joe Perches <joe@perches.com>
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
 <20181010111351.5045-4-rv@rasmusvillemoes.dk>
 <xmqqd0shgg66.fsf@gitster-ct.c.googlers.com>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Message-ID: <5651069a-4879-096d-082d-58d8f0158958@rasmusvillemoes.dk>
Date:   Thu, 11 Oct 2018 09:11:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqd0shgg66.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-10-11 08:18, Junio C Hamano wrote:
> Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

>  we now ...
> 
>> +				next if $suppress_cc{'sob'} and $what =~ /^Signed-off-by$/i;
> 
> ... must make sure what we have is _exactly_ "signed-off-by" when
> 'sob' is suppressed.  Makes sense.
> 
>> +				next if $suppress_cc{'misc-by'}
>> +					and $what =~ /-by$/i and $what !~ /^Signed-off-by$/i;
> 
> And this is the opposite side of the same coin, which also makes sense.

Yup, I started by just adding the misc-by line, then remembered that
people sometimes use not-signed-off-by variants, and went back and
anchored the s-o-b case. So now it's no longer so minimal, and...

> I wonder if it would make it easier to grok if we made the logic
> inside out, i.e.
> 
> 	if ($sc eq $sender) {
> 		...
> 	} else {
> 		if ($what =~ /^Signed-off-by$/i) {
> 			next if $suppress_cc{'sob'};
> 		} elsif ($what =~ /-by$/i) {
> 			next if $suppress_cc{'misc'};
> 		} elsif ($what =~ /^Cc$/i) {
> 			next if $suppress_cc{'bodycc'};> 		}

...yes, that's probably more readable.

Thanks,
Rasmus

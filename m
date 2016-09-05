Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761AB20193
	for <e@80x24.org>; Mon,  5 Sep 2016 05:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754159AbcIEFR4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 01:17:56 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35423 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753023AbcIEFRz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 01:17:55 -0400
Received: by mail-it0-f67.google.com with SMTP id c198so7914000ith.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 22:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=fDsnsSg6J4NI1JBxDPJMmeNQjlmgH1piIM10bRjFWjU=;
        b=gzJCtXpIeTyodDk6me5hT8/IrCtcJpe0yOAhBnhPTBhiVQWJH5hs5+2wCIDjgC9eQO
         9QcAJBwgYuN4xZh3XDsoH2lCdi7iwIJ58h2vOhDhjtaNRjj1/SpwMY2TvGUywzfzPugu
         /vEueyKW4NZr8r8k4ZfCFkDId54iALoLo62RzztGsE40GQra6m2MCZ5kDjA6s1JGd5Ox
         SWvpnCUjFekZKs5wYqM91ay2JYRWV1ot6t46AGqAUjh5i4MdqgNueNZG0D5Cv9DAqvHD
         R0MjsE+U7YUDc9gMKuRsWDq/cOoIBTSfbjERLtclLFNcObmlxa+Hz0XmS117L8+RGD7B
         K0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=fDsnsSg6J4NI1JBxDPJMmeNQjlmgH1piIM10bRjFWjU=;
        b=L6L/C/MxtnC6tySHnxx7AxwEV1KMBAyLFZZGTWpyrrJZRauL7lTHoT9POspcCK6bw4
         X4dd1Y6m6aqcyLBAFgaMDrB5NuBsrj0wlpo8ys9FqC0I3+sAFLg0bI4N6hh0/9MjOnfO
         TBbltXZ3iwkfHbS5mowbIJJ8g/zL4rVpPQGLd5VWoqeU7kbZUcQ7PvmCKsDinoscWcdw
         hOur1Da03gF4GE8bm6zsGYpWROV6U+eFeoefry+6AJ3EcQw9wySXlFtpMYGy4lTG4a2v
         7DjGx8U2N4WMrhrYS5Oa8y/+ST7dhs/ycgIKxE+BJ2qUeuw3T/he39tspEmgqAURUP/I
         NKgw==
X-Gm-Message-State: AE9vXwPTZEPEqUWiNRufDWGe34tqy9kwrT/hjnJcJrA3K+OA93Z+GiPY+B+j5mUTQBHYzQ==
X-Received: by 10.36.208.68 with SMTP id m65mr19885603itg.20.1473052674938;
        Sun, 04 Sep 2016 22:17:54 -0700 (PDT)
Received: from [192.168.2.2] (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.googlemail.com with ESMTPSA id x203sm9299025itb.11.2016.09.04.22.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Sep 2016 22:17:54 -0700 (PDT)
Subject: Re: [PATCH v2 05/38] refs: create a base class "ref_store" for
 files_ref_store
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
 <39277c75122a374b360057d6e1f6d889a90f6fb4.1473003902.git.mhagger@alum.mit.edu>
 <1473021637.6035.27.camel@frank>
 <c6ae77bf-e2e2-c108-648d-75b5164b7ba2@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
From:   Stefan Beller <stefanbeller@gmail.com>
Message-ID: <d04e8a6c-15c8-a39a-2200-ef20b0cd3a42@gmail.com>
Date:   Sun, 4 Sep 2016 22:17:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <c6ae77bf-e2e2-c108-648d-75b5164b7ba2@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04.09.2016 20:53, Michael Haggerty wrote:
> On 09/04/2016 10:40 PM, David Turner wrote:
>> On Sun, 2016-09-04 at 18:08 +0200, Michael Haggerty wrote:
>>
>>> +/* A linked list of ref_stores for submodules: */
>>> +static struct ref_store *submodule_ref_stores;
>>
>> I don't like the per-submodule stores being in a linked list, which
>> requires a linear search.  Stefan has, I think, been doing a bunch of
>> work to scale git to support on the order of thousands of submodules,
>> which this potentially breaks.  What about a hashmap?

Well I did mostly usability up to this point, not efficiency in terms
of fast execution.

> 
> I agree it's not ideal, but this linked list is not new. Before this
> patch the same code was in `files-backend.c`, and before patch [03/38]
> essentially the same linked list was stored as `submodule_ref_caches`.
> So this is not a regression, and I'd rather not address it in this patch
> series.
> 
> CC Stefan in case he'd like to put it on his radar. Honestly, I've never
> checked how often the submodule reference cache is used in real life.

I think I need to spend some time on the data structures eventually.

Thanks for cc'ing

Stefan


> 
> Michael
> 


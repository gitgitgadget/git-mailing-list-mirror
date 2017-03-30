Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 023DF20958
	for <e@80x24.org>; Thu, 30 Mar 2017 06:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755321AbdC3GYj (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 02:24:39 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34213 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755275AbdC3GYi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 02:24:38 -0400
Received: by mail-lf0-f66.google.com with SMTP id x137so3640619lff.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 23:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wDvYB6xY6Dm+rXLX4TDrRkUWQEu0jMTHnuFr0reS4Ac=;
        b=jSKOwybMAa6ClhXFmW4zDKkbxj6jypQoiPTUzXwjjuw6+AmxTM0wn0xyuEpDunSiK3
         VcFBSJ1XEkMgZNgZ2jMRamBQnpyn4vcGLt8dIFBbnZe/R9n+JmFgPGeHD99ImLgyeUg/
         /ugqqlM43+5VrUelZZ1QaZ8iR0mWbJT9EDeNNT4wej5TGRdzltOCYP7w3ubZECpBVwsC
         lgppeGUHl+vZjHjFeepeIuSTshMGuqiy6qSP5ZPXZrwi/e1ZUbl8xCGlI9oKhyHR9C5u
         8Z1TZisb5XFwSM0m/0264r5644RES+VeueAHq5i2+KjUgJfJ9udaGbvEEsFn45gUAUtM
         9V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wDvYB6xY6Dm+rXLX4TDrRkUWQEu0jMTHnuFr0reS4Ac=;
        b=NQKU47mIxSjGqvr8n4fQm+6KcEFoUq5J/kWZYR7XWPxbhrywrM5aex9VPP08uqUvrd
         bL337oKMlgnQb9cg9U8ePWWGpTtcQG7M8XGYRzR+2l6PcxMWQGK8DlRnVvMLEnUlAajU
         dMLjEb+/R1xF0x2V2KATAyZT36mDWBisy27kOCqnPtSp4qENOCYUkQxNpcVD2LOh03ID
         nwwwM6Ps+EVKYC3vAyYT1jPGuc8ZWYYLnFsKO19/cPDEGv3vDmfPQIqhLKYstubQMj1D
         nhO/WUyjOZqEiRihMCXvCZAt6PnwklifmmKXJ+fhLQycWmSSfjRKfnEJ8DrNY0vtkTPC
         sfkg==
X-Gm-Message-State: AFeK/H2JYV7GoeOPP9Pw4BXArT+y3tczFaTXki2WYb0/BSkuP6vVBvQmbglsOtkQfgWROvTFhy2orNASfES+rw==
X-Received: by 10.25.190.88 with SMTP id o85mr1127231lff.151.1490855076005;
 Wed, 29 Mar 2017 23:24:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.10 with HTTP; Wed, 29 Mar 2017 23:24:35 -0700 (PDT)
In-Reply-To: <20170330032858.rdklpoipmvwjov4d@sigill.intra.peff.net>
References: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
 <1453877887-11586-5-git-send-email-chriscool@tuxfamily.org> <20170330032858.rdklpoipmvwjov4d@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 30 Mar 2017 08:24:35 +0200
Message-ID: <CAP8UFD1co8V++3EY7--Ubxk9G8R0909pMCCzUVggde_=MgUJzg@mail.gmail.com>
Subject: Re: [PATCH v8 04/11] update-index: add untracked cache notifications
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        David Turner <dturner@twopensource.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 5:28 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 27, 2016 at 07:58:00AM +0100, Christian Couder wrote:
>
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index 62222dd..369c207 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -130,7 +130,7 @@ static int test_if_untracked_cache_is_supported(void)
>>       if (!mkdtemp(mtime_dir.buf))
>>               die_errno("Could not make temporary directory");
>>
>> -     fprintf(stderr, _("Testing "));
>> +     fprintf(stderr, _("Testing mtime in '%s' "), xgetcwd());
>
> Coverity points out that this is a leak (xgetcwd returns an allocated
> buffer).

Thanks!

http://public-inbox.org/git/20170330062208.29018-1-chriscool@tuxfamily.org/

should fix it.

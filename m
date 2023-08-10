Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC0FC001E0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 01:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjHJBp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 21:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjHJBp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 21:45:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2530210DA
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 18:45:56 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686efb9ee0cso360075b3a.3
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 18:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691631955; x=1692236755;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfmfL6eQrXATwUtMvvePZukFC/YKu5hs1dnxGZDeQQ8=;
        b=g3kHxTxjoYoOFPGbBfLPpZuz58XS4wi4dSsVKIahd0/jaWFSnQqcxxG+9/Gno/mpBq
         OeSGfMz04qho6HCWI3Itgp+zBOLs1FQnlyMf1aK74mzjzQKoap/upJfA1XgY/SgeT0O9
         Af9HKUEkPO7ORu9Wjb+cjM8ljykKicKaWhdvQ+sGbv1WOxN3Sh133dYHwz1NWkoOIv9s
         zwvTdvV3W1GtHLAEHW75vr1zZur4dGY8HOWEr3BDkQPOfhl7OEvPD+U0o7jMedaNDi/D
         1JFCMaS89ZqKdqFUmt+LZgvtYfCEIMKf7MOmzf6od9umaAgYgvWPtzKEZvTwY19c7owL
         no7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691631955; x=1692236755;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfmfL6eQrXATwUtMvvePZukFC/YKu5hs1dnxGZDeQQ8=;
        b=OnF9Ax8oXavNboohuSFefIFV9L8ib+fCkQeneazJZW5IxcTykrdbYPVl3/ZOauJTqi
         Q7ZXVh7kbQGbeeZM/m/9FB1abNT0QisMDJzEoLZoPAxS10vHf6TO5FpTqY7yE198lVA1
         JHqCuK4N76zmu3RrzttlGCOUzPXehJC7Lzk+bzgbG2DI/5DEl/5ektwBwNTNVVGd5z9y
         hq1JYybDHEV5KtlvmzKkoBPQCOgZh3gzltoa9nXy+9TtkfCqdhHOIHiBfUQGVYuAZ3r5
         EYoVYN0k1Yk0r42vUeTdRMGeq0tA1uGoPEt8mNiRhNAbVccYOg7OM81ca9OK/u34WSca
         BniQ==
X-Gm-Message-State: AOJu0YxPpnEJkme83/vdbr5wjsW8bR4freXkXl7mFafdnrvTEQfqkpld
        qAjRfEqWjiXtu50fPVhxRBkcOw2GO6c=
X-Google-Smtp-Source: AGHT+IE4zz3urTQwabkZ1QozTUgSpQlIb48hXp/qv2f5U7PVoIiQdxv7sqsASyJO2bTBUOSWMb1S9w==
X-Received: by 2002:a05:6a20:8f01:b0:140:694:cd8e with SMTP id b1-20020a056a208f0100b001400694cd8emr1349630pzk.28.1691631954891;
        Wed, 09 Aug 2023 18:45:54 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id i11-20020aa7908b000000b0066f37665a6asm241025pfa.117.2023.08.09.18.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 18:45:54 -0700 (PDT)
Message-ID: <f6ef3689-820a-f85c-68a7-9c87a5eabe27@gmail.com>
Date:   Thu, 10 Aug 2023 08:45:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] Fix grammar in git push man page
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Wesley Schwengle <wesleys@opperschaap.net>, git@vger.kernel.org
References: <20230810004044.1420385-1-wesleys@opperschaap.net>
 <ZNRANBdZG9kAnjxq@debian.me>
Content-Language: en-US
In-Reply-To: <ZNRANBdZG9kAnjxq@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/2023 08:41, Bagas Sanjaya wrote:
> On Wed, Aug 09, 2023 at 08:40:25PM -0400, Wesley Schwengle wrote:
>> -When neither the command-line nor the configuration specify what to
>> +When neither the command line nor the configuration specifies what to
> 
> IMO either command-line or command line is correct...
> 

Oops, I mean both forms (with and without dash) are correct.

-- 
An old man doll... just what I always wanted! - Clara


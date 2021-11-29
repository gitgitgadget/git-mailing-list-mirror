Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC2FC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbhK2XFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbhK2XDl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:03:41 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DCAC0C0869
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:37:16 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id be32so35981742oib.11
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+u35hOSCwaSuF95EALWnkicWGc3QukCRVzmuOgGsEQg=;
        b=e6QFv3Njsa5bE3ynaS3LBJvgtI4kafkH1l5ykGo5ehZGLzNjatp6IhmZLdvEsbSQ+N
         fvTrOMmw0E5vGM9CgtPBdSGh7xEpZ6ffZGH2v/RtIM3PXxhULE50OWEdfPR4q+qRNhfw
         OZCHRSJawapPHOyQ1/NO1rEzYM8KJ/C+O5hYX/h1tawc3+fadO7e281NP/eON/TLWBsd
         hFRJUhn0WA1a88uBtOCovdVXRqqnm7RtWMbsftkQzj3WPEQ2Yog7TJwBSAeseX0E6Xs4
         zRILUC2vmoB6qqE7/9AX/uScBp1gK0sg4rZg/acym0g8fxX1KCcD/M77OzXuOHdZMR1h
         mOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+u35hOSCwaSuF95EALWnkicWGc3QukCRVzmuOgGsEQg=;
        b=2hBmNDXlAjnMm3L3BFMrhY7PB0n19Y0c4cjKydltUxGTZdE/mL/NascJndkRIiXDuV
         8LPTRGBoH802VVyOyGpxNw4gSQlzsEdMY7y/4OkOzGjY79DribK4El0hp8qYo/cv2njp
         d+wtNnFBibSciwulw9P4EUlF4fWnloCMOMhipnqs5KQYVkv1gdVRAuWpkJn0v6h3Gu04
         CGcyQbQoLZ3I6+itrYOeTygKRc24XemI96wuqn86S4D/D013XjGalN4WuM+C3wzqFG1b
         0tHAi+x4y1ouk+iDqnKr7Y0SpCDct/ASDgpIr28RnbMe7EZ8A2yapZqOQygc+BsrHOBr
         Lgrg==
X-Gm-Message-State: AOAM5305YXxg+hbo2YBfgR7Iniv5jROiM5yJTacZcRLdtDHvyTBOXj/t
        6lcKPbV9Bs+YFqaDbUCVI9Y=
X-Google-Smtp-Source: ABdhPJwLPWz/00b4zXT3Zln81fHe/ChUsGt3qCO6Q7KQ4DKrPC9lerH+PBZvh6ROF0yMo5kFtL5qwg==
X-Received: by 2002:aca:ab86:: with SMTP id u128mr42315505oie.41.1638207435379;
        Mon, 29 Nov 2021 09:37:15 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3085:654c:eb81:848b? ([2600:1700:e72:80a0:3085:654c:eb81:848b])
        by smtp.gmail.com with ESMTPSA id s26sm3207204oiw.19.2021.11.29.09.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 09:37:14 -0800 (PST)
Message-ID: <8ff89e50-1b80-7932-f0e2-af401ee04bb1@gmail.com>
Date:   Mon, 29 Nov 2021 12:37:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 5/5] unpack-objects: unpack_non_delta_entry() read data
 in a stream
Content-Language: en-US
To:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
 <20211122033220.32883-6-chiyutianyi@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20211122033220.32883-6-chiyutianyi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21/2021 10:32 PM, Han Xin wrote:
> From: Han Xin <hanxin.hx@alibaba-inc.com>
> 
> We used to call "get_data()" in "unpack_non_delta_entry()" to read the
> entire contents of a blob object, no matter how big it is. This
> implementation may consume all the memory and cause OOM.
> 
> By implementing a zstream version of input_stream interface, we can use
> a small fixed buffer for "unpack_non_delta_entry()".
> 
> However, unpack non-delta objects from a stream instead of from an entrie
> buffer will have 10% performance penalty. Therefore, only unpack object
> larger than the "big_file_threshold" in zstream. See the following
> benchmarks:
> 
>     $ hyperfine \
>     --prepare 'rm -rf dest.git && git init --bare dest.git' \
>     'git -C dest.git unpack-objects <binary_320M.pack'
>     Benchmark 1: git -C dest.git unpack-objects <binary_320M.pack
>       Time (mean ± σ):     10.029 s ±  0.270 s    [User: 8.265 s, System: 1.522 s]
>       Range (min … max):    9.786 s … 10.603 s    10 runs
> 
>     $ hyperfine \
>     --prepare 'rm -rf dest.git && git init --bare dest.git' \
>     'git -c core.bigFileThreshold=2m -C dest.git unpack-objects <binary_320M.pack'
>     Benchmark 1: git -c core.bigFileThreshold=2m -C dest.git unpack-objects <binary_320M.pack
>       Time (mean ± σ):     10.859 s ±  0.774 s    [User: 8.813 s, System: 1.898 s]
>       Range (min … max):    9.884 s … 12.192 s    10 runs

It seems that you want us to compare this pair of results, and
hyperfine can assist with that by including multiple benchmarks
(with labels, using '-n') as follows:

$ hyperfine \
        --prepare 'rm -rf dest.git && git init --bare dest.git' \
        -n 'old' '~/_git/git-upstream/git -C dest.git unpack-objects <big.pack' \
        -n 'new' '~/_git/git/git -C dest.git unpack-objects <big.pack' \
        -n 'new (small threshold)' '~/_git/git/git -c core.bigfilethreshold=64k -C dest.git unpack-objects <big.pack'

Benchmark 1: old
  Time (mean ± σ):     20.835 s ±  0.058 s    [User: 14.510 s, System: 6.284 s]
  Range (min … max):   20.741 s … 20.909 s    10 runs
 
Benchmark 2: new
  Time (mean ± σ):     26.515 s ±  0.072 s    [User: 19.783 s, System: 6.696 s]
  Range (min … max):   26.419 s … 26.611 s    10 runs
 
Benchmark 3: new (small threshold)
  Time (mean ± σ):     26.523 s ±  0.101 s    [User: 19.805 s, System: 6.680 s]
  Range (min … max):   26.416 s … 26.739 s    10 runs
 
Summary
  'old' ran
    1.27 ± 0.00 times faster than 'new'
    1.27 ± 0.01 times faster than 'new (small threshold)'

(Here, 'old' is testing a compiled version of the latest 'master'
branch, while 'new' has your patches applied on top.)

Notice from this example I had a pack with many small objects (mostly
commits and trees) and I see that this change introduces significant
overhead to this case.

It would be nice to understand this overhead and fix it before taking
this change any further.

Thanks,
-Stolee

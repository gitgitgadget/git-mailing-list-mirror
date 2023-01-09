Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66D2C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 14:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjAIOU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 09:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjAIOUN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 09:20:13 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AF615721
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 06:20:12 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-15027746720so8690569fac.13
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 06:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWg+xwleFAU5zHslnrJxCIWWXTsIRuq+Pv9ktuPt8MA=;
        b=gy+fs5jm56YV8I0bG5NtbOLIyYEoYgbBkVFCsT1fXIs05XvtOD46edryr/lLatBMUz
         HRMalR909wURPS0oWwS/+T1oKdZirg2c+NhfhXfen9pryyHPCOu8fNfP9jQ1rls34+Qq
         +HJFvawkuQRqH5/Y+ljc/NZXIBUNgIqS5PNtIWcHNnfrhwpXN8R725fQ9MrrVL16+HIU
         YWobprpIF10C4ab2ilApsL3BAc/WWYIPFo616Q/XvAHX8k1LJTtWnDFRywjKLrO6D5T/
         1VRQxRfuBaH0OBVy2udcMOq914WZ+rBaJB+TY7Rvbzt9laYyVO8TQVNquytHeJYnH5Jj
         YM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWg+xwleFAU5zHslnrJxCIWWXTsIRuq+Pv9ktuPt8MA=;
        b=OntjjMk4M0wG2dO4BMqbqLSQo7Kdk0TnmF8nSwYNB3m6pffBjhGlHFCl4Jm3gtrh9+
         xyqnmct+Ciu8jHvNN043h1j3QRdutemJh9Cv5RmboMDFoTK7gwJt1eC/rdhE9vM/yQyq
         qrjMQJnZf7bw7lKQbdxYAEpPBp/Bzz/lH/EZSpWGJeMojeNg2ot1bDPn6tO3iqczJKsN
         6h2j0TaWDG5nMTdhiyp6FyflLlygruk3b16OM6w2K8AnYFaj4krLQtWz2Xm8VtQy3Or6
         CoimPBLl5Zg/lXgeJXRYtcmbFVSBpO4Md5aJ+LsCIk9iBkCxonaaEssqCqHpNw8eqTC4
         /o9w==
X-Gm-Message-State: AFqh2krSVy3wN3cQ9c+GXO8FzhWTTRjhfrAH8Mgif9OgsKFUJUCHd/D1
        ENaAVqsYlFxjT2YlFWTfJsNA
X-Google-Smtp-Source: AMrXdXvpoAWhnskkdZJGmL5jYu+Bse3qj5v6ZewXhnhCygk5qW/F02ZdDnsgf0Q6N4UncRLpX+h6jQ==
X-Received: by 2002:a05:6870:9e85:b0:150:8c83:b019 with SMTP id pu5-20020a0568709e8500b001508c83b019mr16340630oab.3.1673274012059;
        Mon, 09 Jan 2023 06:20:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:9803:bdc5:6740:d9fa? ([2600:1700:e72:80a0:9803:bdc5:6740:d9fa])
        by smtp.gmail.com with ESMTPSA id m22-20020a4ac696000000b0049bfbf7c5a8sm4240620ooq.38.2023.01.09.06.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 06:20:11 -0800 (PST)
Message-ID: <35bcfd1f-ff54-fc2a-0477-6454bca03a87@github.com>
Date:   Mon, 9 Jan 2023 09:20:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/8] bundle-uri: parse bundle.heuristic=creationToken
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <9007249b9488c23f00c2d498ffd520e4af8b37a4.1673037405.git.gitgitgadget@gmail.com>
 <xmqqilhgxwj4.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqilhgxwj4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2023 9:38 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +static const char *heuristics[] = {
>> +	[BUNDLE_HEURISTIC_NONE] = "",
>> +	[BUNDLE_HEURISTIC_CREATIONTOKEN] = "creationToken",
>> +};
> 
> Ideally it would require the least amount of maintenance if we could
> define BUNDLE_HEURISTIC__COUNT as ARRAY_SIZE() of this thing, but it
> being a file scope static, it might not be easy to arrange that.  As
> a lessor altenative, would it make it safer to size this array more
> explicitly using BUNDLE_HEURISTIC__COUNT macro?
> 
> 	static const char *heuristics[BUNDLE_HEURISTIC__COUNT] = {
> 		...
> 	};

Yes, I should have used this size indicator.
 
> or is it more-or-less moot point to aim for safety because nobody
> enforces that these [indices] used to define the contents of this
> array are dense?
> 
> That is ...
> 
>> @@ -142,6 +150,19 @@ static int bundle_list_update(const char *key, const char *value,
>>  			return 0;
>>  		}
>>  
>> +		if (!strcmp(subkey, "heuristic")) {
>> +			int i;
>> +			for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
>> +				if (!strcmp(value, heuristics[i])) {
>> +					list->heuristic = i;
>> +					return 0;
>> +				}
>> +			}
> 
> ... this strcmp() will segfault if heuristics[] array is sparse, or
> BUNDLE_HEURISTIC__COUNT is larger than the array (i.e. you add a new
> heuristic in "enum bundle_heuristic" before the __COUNT sentinel,
> but forget to add it to the heuristics[] array).
> 
> "You are worrying too much.  Our developers would notice a segfault
> and the current code, which may look risky to you, is something they
> can live with", is a perfectly acceptable response, but somehow I
> have this nagging feeling that we should be able to make it easier
> to maintain without incurring extra runtime cost.

You're right. I was following an established pattern of linking
enums to values, but I'm not sure that those other examples will
loop over the array like this looking for a value.

A safer approach would be to have an array of (enum, string) pairs
that could either be iterated in a loop (fast enough for a small
number of enum values, such as this case) or used to populate a
hashmap at runtime if needed for a large number of queries.

>> diff --git a/bundle-uri.h b/bundle-uri.h
>> index d5e89f1671c..ad82174112d 100644
>> --- a/bundle-uri.h
>> +++ b/bundle-uri.h
>> @@ -52,6 +52,14 @@ enum bundle_list_mode {
>>  	BUNDLE_MODE_ANY
>>  };
>>  
>> +enum bundle_list_heuristic {
>> +	BUNDLE_HEURISTIC_NONE = 0,
>> +	BUNDLE_HEURISTIC_CREATIONTOKEN,
>> +
>> +	/* Must be last. */
>> +	BUNDLE_HEURISTIC__COUNT,
>> +};
> 
> The only reason to leave a trailing comma is to make it easy to
> append new values at the end.  By omitting the trailing comma, you
> can doubly signal "Must be last" here (not suggesting to remove the
> comment; suggesting to remove the trailing comma).

This is a great example of "doing the typically right thing" but
without thinking of _why_ we do that thing. Thanks for pointing this
out.

Thanks,
-Stolee

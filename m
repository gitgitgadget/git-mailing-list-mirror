Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D5BC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 14:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiKVOdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiKVOce (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 09:32:34 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DCE6A6BE
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:31:57 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id cl5so25001491wrb.9
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a13QVWQKOFa+ypomezkq1n/768xI0mAYRNXY9KyPp1E=;
        b=WJcwhvZpImUyx/uKndLBjFjNOiJ9Y2BldAoOOE6aYylwZmiPDoccaUigR1Xjbv54Zt
         8Ic5D2HjGcYGMOLrNo8z4weO2skPFb8W+4i0eJvfEbwTOhlYpx2ntCKe1a2BntGE1Yni
         9wKujnuCzCcpU1g4/syuxXOsmpDSjBcdNwu2pMTKIDSiBf/bMiO1CI1FBSUsh/wXgWOd
         ZRI+6FqVd12VTbx33lXYnPXMW9y7ZzVyB965lJDal8hyCwywU1GE2HML4SA/vaDfKbCm
         37gGfvymZQxlQQeDVeg3PH5JPZ+EDml2giqvmWIXfGb6yFyFjADHnueNdp+mKO1vCamX
         6Z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a13QVWQKOFa+ypomezkq1n/768xI0mAYRNXY9KyPp1E=;
        b=kswSvjgt2by8hBiECwJdAOQ5ZutweImSyUN9f8Z1d7USdoBhGaxg0AbvXlsU2/3XFE
         7mcuT1mzact/PvPMdcEGX8UUJHAqlJ7RTpcxBcEMcccSdiFSK4LwqmY2qSN9SHGcViSe
         kIYswcmwc94h/xlM+ngqFU8k51rnRR8tdMS3p53JiIzrkspPO695XmqtvDAr/ag2lybi
         O0N/tZEOC1lFDlD0pxzBtGZuFX2qieylHLEJADvVTpSvFePiwPTDEJ3l/DNTbH5V9oUC
         oyelDWAC6n5sYEsDzKetuCYKKNi597LcMv/6kgDx4vPCCpru8YH/bHA/RarcojSFMhwT
         3whQ==
X-Gm-Message-State: ANoB5pnBNTk9VVsWVCjbc9/utRWFZ+qscL97z8xFDiOQgU83FHSxoB+s
        Um9DxT5YTJGFH+OKkQJ/8sI=
X-Google-Smtp-Source: AA0mqf7jeO1oH/tMqcNuQW+zrV34eucbuP0q61xEqngyLY+JxnC/DqD/CxNf/AmEMaIYa/mgDYOjdw==
X-Received: by 2002:adf:e30b:0:b0:236:aacc:ea87 with SMTP id b11-20020adfe30b000000b00236aaccea87mr14629886wrj.414.1669127515838;
        Tue, 22 Nov 2022 06:31:55 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b003cff309807esm23338024wmo.23.2022.11.22.06.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 06:31:55 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <9c0ecaff-3d66-2b83-eb78-64632d1fcddd@dunelm.org.uk>
Date:   Tue, 22 Nov 2022 14:31:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
 <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
 <221122.864juraxl2.gmgdl@evledraar.gmail.com>
In-Reply-To: <221122.864juraxl2.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/2022 14:01, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Nov 21 2022, Johannes Schindelin via GitGitGadget wrote:
> 
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> +`os`::
>> +	The data that follows this keyword is taken as the name of an
>> +	Operating System, e.g. `Linux` or `Windows`; If it matches the
>> +	current Operating System, the include condition is met.
>> +
>>   A few more notes on matching via `gitdir` and `gitdir/i`:
> 
> The reste of the "includeif" use glob matching and "/i" for icase. IOW
> this is how this new feature would fit in:
> 	
> 	|--------+--------+----------+----------+------------------+----|
> 	|        | gitdir | gitdir/i | onbranch | hasconfig:remote | os |
> 	|--------+--------+----------+----------+------------------+----|
> 	| icase? | N      | Y        | N        | N                | Y  |
> 	| glob?  | Y      | Y        | Y        | Y                | N  |
> 	| path?  | Y      | Y        | Y        | Y                | N  |
> 	|--------+--------+----------+----------+------------------+----|
> 
> I think at least flipping that "glob" to "Y" so you could match e.g.
> "*BSD" would be useful, and easier to explain in context, rather than
> why the rest use wildmatch() and this doesn't.

Globbing could be useful for the BSDs.

One other thing I thought of is will users know "Darwin" means MacOS?

> For matching the uname the case doesn't really matter, but for
> consistency of the interface I think making it case-sensitive or adding
> an "os/i" would make sense. I.e. let's consistently use "/i" if & when
> something's case-insensitive.

All the other items listed in your table such as branch names are case 
sensitive. The os name is not so it is of no benefit at all to the user 
to match it case sensitively. Let's consistently test case sensitive 
keys cases sensitively and case insensitive keys case insensitively.

Best Wishes

Phillip

>> +test_expect_success '[includeIf "os:..."]' '
>> +	test_config x.y 0 &&
>> +	echo "[x] y = z" >.git/xyz &&
>> +
>> +	if test_have_prereq MINGW
>> +	then
>> +		uname_s=Windows
>> +	else
>> +		uname_s="$(uname -s)"
>> +	fi &&
>> +	test_config "includeIf.os:not-$uname_s.path" xyz &&
>> +	test 0 = "$(git config x.y)" &&
>> +	test_config "includeIf.os:$uname_s.path" xyz &&
>> +	test z = "$(git config x.y)"
>> +'
> 
> As I pointed out in the v1, this still:
> 
>   * Hides segfaults in "git config", let's check the exit code.
>   * Doesn't test the "icase" semantics you're introducing. Let's do that
>     if it's intentional.

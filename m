Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BC0C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 13:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbiHDNa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 09:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbiHDNaz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 09:30:55 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED022521
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 06:30:54 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id s16so6305322ilp.3
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=kgsShCv8cHs1bo+P9J93tCCQE/ura/SndvnaIbGJKYo=;
        b=c07yURTCqvSjJjMrdL2ClV9beSFwSsnLPjX7g0H+AfAY2t2U1faWjSv0dwpnDsIYia
         2ZUxqWpd+WH11oDoM8hhBj/bwqkH88Zfm+5LVeEzM5VszbJaN5MxhVuzB4tWWwamzgFR
         DUzc2P6Nm2zBENYSxR9vhkgfQ4Gf0yV6HR5i7lKkrxSu1V4o2MdIw9eRtCd38s71TvmB
         rbUXKxciQYf8VZqs+l0gYvaZlXWscUWWwsdMCHXo/BZvRWTDlvj9cdUthOWIboTVdN6K
         i0y+cmW23NdTbjxdMxaSBGPmlH+OcvZPgTeUTnc/Vg+7zVlhPIkO8OjeQTNMu3JYJQry
         SY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kgsShCv8cHs1bo+P9J93tCCQE/ura/SndvnaIbGJKYo=;
        b=4NyT27v8hU+m3YpVPqki1OZANc5Tm8EJldItbNyhm4rzjcYB8gvblZaA7vjN6VeKb7
         tiMZAoNDrtTjTYSvrQi+YjHHj2U9nuig1EOnOmKX4fLx+fCcBXIB+PGEdzI2tmgg/v8b
         w8oU1ZuoVYYsINLQlJq53ZcApM7uEhmyCAcecwIa2ovgPQpyuIi0IkEj+OMTZHXPT7Vm
         lqSaZsfEl1q7exohrne02GX0PL9X5nwJIOr6NNhjN/rhfzcguYYI6JdIGVxDKBlqA4Yp
         XwKwipRkqPW5FMmiMYY49T7xGh6P+VT+epEBsYYtxPQJin/HIB5fC7k/bfVTBI6HGmZ9
         85cg==
X-Gm-Message-State: ACgBeo1ak3DUi2x96Qojoq81Xiid5ow6o0134E8IGf/BPPCCZI4kVWn9
        c6P7X2jE3tu7OmVxQ/VQCWbD
X-Google-Smtp-Source: AA6agR4Z6PeCsRp6SOPoWCLY0HetGzROaCemy5+SqTqQXn14kUOkQ+N56b0skjDOJ4//CyW2fHM19w==
X-Received: by 2002:a92:d80a:0:b0:2dd:360c:a2e4 with SMTP id y10-20020a92d80a000000b002dd360ca2e4mr895833ilm.67.1659619854050;
        Thu, 04 Aug 2022 06:30:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8b6:bc6e:e88:13d9? ([2600:1700:e72:80a0:8b6:bc6e:e88:13d9])
        by smtp.gmail.com with ESMTPSA id d15-20020a92d78f000000b002dd0ff02527sm433891iln.55.2022.08.04.06.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 06:30:53 -0700 (PDT)
Message-ID: <d77c25f6-aab1-58e3-faae-36cfa3204925@github.com>
Date:   Thu, 4 Aug 2022 09:30:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 04/10] refs: use ref_namespaces for replace refs base
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <8da0b0a31810c8221ad3ab13b8c41cf1a266c2c0.1659122979.git.gitgitgadget@gmail.com>
 <Yur49obfOHwu2B5t@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yur49obfOHwu2B5t@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 6:38 PM, Josh Steadmon wrote:
> On 2022.07.29 19:29, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/log-tree.c b/log-tree.c
>> index d0ac0a6327a..bb80f1a94d2 100644
>> --- a/log-tree.c
>> +++ b/log-tree.c
>> @@ -141,10 +141,12 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
>>  	enum object_type objtype;
>>  	enum decoration_type deco_type = DECORATION_NONE;
>>  	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
>> +	const char *git_replace_ref_base;
>>  
>>  	if (filter && !ref_filter_match(refname, filter))
>>  		return 0;
>>  
>> +	git_replace_ref_base = ref_namespaces[NAMESPACE_REPLACE].ref;
> 
> Is there a reason not to initialize this as soon as we declare it?

No, there is not. Thanks!
-Stolee

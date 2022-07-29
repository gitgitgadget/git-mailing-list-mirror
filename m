Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDBEC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 13:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbiG2NXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 09:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiG2NXd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 09:23:33 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A216248C
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 06:23:32 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id u12so3292385qtk.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HoC6DC+Ev4MitpfKKdKRL66THQalwTFrzBUh2VvpK20=;
        b=TXpWd888wMH5oGAbwDJyDSERJDO5cKU3L1JBbU/8ljjrAr9qvQQ6boElz7BriEJ7p5
         UDhQMaUG+mTARHUyQJe+h48SFQFgoR2zpd+vXYhl582Fdw2Mkd1SSwI9j6upF2+tbdoe
         lhJRKAeBbntq9/GOsrCmabjBU6PnzNN+KVMDtV6qAEI0AqWt8PxrfPAqW7EjZlKdw4nP
         JTUtgaclkB3P2gSxXYZP9x0vRRxeTDT9aJ40GQmd8AfFBxIg9YaRXS8ns5GVnAv7eS/r
         fufrn7n2l/U6cMV8H9EggTsHO3Upq5QdXur/S6Vp3+HEziSyLORBKLCs8r+VyECnzBpI
         e19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HoC6DC+Ev4MitpfKKdKRL66THQalwTFrzBUh2VvpK20=;
        b=tKf3YnJU/PvfU+sL+Hf0pB3u0kdMjtCxoAI9T8+fnzOxUrab2n1gXlMA4cQRc09Mpo
         V0bSdgYB8xqUU+N+sGmpZZTuEC8I8BDk8fdKPU63C39IvPo9K2zcFiVWhgsrGOLdJ9iU
         r7iDCBkiH+s12980rzUzyAPUuq6kGyqf53unUNso0zU7IEh/LlRvauJSijyYdUuLlilx
         XTzGjm7Wp8PJFGPjR2U0kM+AFlQX/04EvBqTILpKqEx3x+1f0IP9t5c10fb6Lu6eLUcy
         sWQO8FlbgRR2kBkCb90VbcNETkhHEOZ9MOPgDf+is2dL4tuDIm4FCNQyb3/VM/HuuoSX
         aZcQ==
X-Gm-Message-State: AJIora88wUbHpEkS0jLxXqcfeDD/QYuHCTUhN3gWfQVmoueXfbmNHWeH
        RxUYeBYk/2jlSuj/jAfFrJcT
X-Google-Smtp-Source: AGRyM1tTKgsWNF9y6T83KSWh0eJwB4hyyoba1HLA2Ae8hVYTsMWkkQRnqQvEzAmP2mwgQlu2iGsU2Q==
X-Received: by 2002:ac8:5a4c:0:b0:31f:2017:7c7f with SMTP id o12-20020ac85a4c000000b0031f20177c7fmr3322531qta.102.1659101011524;
        Fri, 29 Jul 2022 06:23:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:994a:ecce:40c:c0b7? ([2600:1700:e72:80a0:994a:ecce:40c:c0b7])
        by smtp.gmail.com with ESMTPSA id c27-20020ac8009b000000b0031bba2e05aesm2173620qtg.58.2022.07.29.06.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 06:23:31 -0700 (PDT)
Message-ID: <2bd24a6d-24a0-3910-3418-34e111a11a21@github.com>
Date:   Fri, 29 Jul 2022 09:23:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] refs: allow "HEAD" as decoration filter
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <c2e5a0b3a50237f3b7f5ceb5d05faa83fd41de68.1658844250.git.gitgitgadget@gmail.com>
 <220726.86lesfnc0y.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220726.86lesfnc0y.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/26/2022 11:10 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jul 26 2022, Derrick Stolee via GitGitGadget wrote:
>>  	if (prefix) {
>>  		strbuf_addstr(&normalized_pattern, prefix);
>> -	}
>> -	else if (!starts_with(pattern, "refs/"))
>> +	} else if (!starts_with(pattern, "refs/") &&
>> +		   strcmp(pattern, "HEAD"))
>>  		strbuf_addstr(&normalized_pattern, "refs/");
> 
> Arguably a digression for this series, but I think it would be very nice
> to have a pre-step where we'd create some pre-step to centrally declare
> these magical refs in some struct whose flags would cover these various
> cases.
> 
> E.g. we have this hardcoded in should_autocreate_reflog(), in log-tree.c
> (which AFAICT is the reference to "HEAD" here), refs.c etc. etc.
 
It's a good idea to collect our known ref namespaces into a
single place so we can update them together when a new feature
is added. This could help avoid the inconsistencies that already
exist (such as not filtering "HEAD" or not coloring "refs/notes/").

Thanks,
-Stolee

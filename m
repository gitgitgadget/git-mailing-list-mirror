Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16EFECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 15:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiH3PDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 11:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiH3PDP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 11:03:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7FD10D4F7
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 08:03:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m16so14586009wru.9
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=qcCOoEQg1XfPMz7K4EWD2ZPv1xXzYEy50pQbjNMGJIs=;
        b=dBzxifCaRQnQQgCxhB4SEE6OR7bsIRa8Bb/76qG6wM4uYNTOZidwNYboBgtA3/AIsg
         7NGUYYMj1VnccDURpYZ6+ELYt5Z6bNBi8up9vGDjK3P5YgfkGDBUR/51WCpNPc4rmI1K
         MQU7mzuKqbHQ71U2i7jFWe5WfC0Juh5aoG1AZe0afOpfFRSvyRr9ZZheGG9lZJK2oheP
         Avl2bCUUnu5qZh7NGWZQQjMKD6H3ug+kpnmCUq2A2WerUiWCSaZ1bohmzFb0Ty81Z7WP
         yNCb2f85yK6AIIy111HrzIirU3K+Uox9+XGV/waqrkk5ugOF6TICHQ+bhMbZWIKSWZQu
         jHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=qcCOoEQg1XfPMz7K4EWD2ZPv1xXzYEy50pQbjNMGJIs=;
        b=Sina7QIqu2Udp+lDr7wTm+BmYdV9earsCvU+cImrVUs3GNGRWCxA1p9FY7/IyLIu2j
         av99XvdzLYGl0teCTzArDifQ/Js0jvWPZMzhetFvq7yePq8z+t93/GyxI1pL/arXsB5t
         XRjCWPhr1XYbWeFdyr9lCFpeMIAtXvcH7+5WlyZnqk0bT+iOvpzIm8cNzEQDHEw9RLNX
         xfNQEuI548arOBu66VTuKDbZBzmyKkiapAAa10nMZ3beXGSZRQchoGuhM/1eWBvhYECc
         EWmu3273g/hzMPOhpPbiBxABH3pdRTuM5dn8/16ANR78rx4uowRqt6trJWXuKiiy9B9X
         8r5A==
X-Gm-Message-State: ACgBeo2ZT3Ea8nrJMQ0ZimzShmOgC2kb2gir0Gv5cQMUP3LG2jYjKtiF
        d274dNC/B4wzIm+6CRILaONa6dgJtF5zhA==
X-Google-Smtp-Source: AA6agR48UDEh3lPsDzrvILImJvXJUaceqzVhcGj6RNOvhKRrP8AwyAX5bA9fjTv5GfDVxzdHkLTMXw==
X-Received: by 2002:a5d:5289:0:b0:225:4852:4248 with SMTP id c9-20020a5d5289000000b0022548524248mr8832773wrv.228.1661871793257;
        Tue, 30 Aug 2022 08:03:13 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id r28-20020adfa15c000000b0021db7b0162esm9960663wrr.105.2022.08.30.08.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 08:03:12 -0700 (PDT)
Message-ID: <dc1b42fa-0420-6d15-03ab-60d34a42ed73@gmail.com>
Date:   Tue, 30 Aug 2022 16:03:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/5] rebase: factor out merge_base calculation
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20220824220251.1682480-1-jonathantanmy@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220824220251.1682480-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan

Thanks for taking a look at this series

On 24/08/2022 23:02, Jonathan Tan wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> @@ -1668,7 +1678,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   			die(_("Does not point to a valid commit '%s'"),
>>   				options.onto_name);
>>   	}
>> -
>> +	if (keep_base) {
>> +		oidcpy(&merge_base, &options.onto->object.oid);
>> +	} else {
>> +		fill_merge_base(&options, &merge_base);
>> +	}
>>   	if (options.fork_point > 0)
>>   		options.restrict_revision =
>>   			get_fork_point(options.upstream_name, options.orig_head);
> 
> This patch makes sense, except for this part: why is fill_merge_base()
> only called for non-keep_base, but it seemed to be unconditionally
> called before? For what it's worth, all tests pass even with this diff:

It's an optimization, we have already calculated the merge base above in 
the "onto" calculation when --keep-base is given. This is what I meant 
by "avoid calculating the merge-base twice when --keep-base is given" in 
the commit message, maybe I should  try and come up with some clearer 
wording.

Best Wishes

Phillip


>    -       if (keep_base) {
>    -               oidcpy(&merge_base, &options.onto->object.oid);
>    -       } else {
>    -               fill_merge_base(&options, &merge_base);
>    -       }
>    +       fill_merge_base(&options, &merge_base);

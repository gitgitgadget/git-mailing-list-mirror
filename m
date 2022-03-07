Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3445C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbiCGQLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiCGQLy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:11:54 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC50F28E2B
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:10:59 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d194so2669630qkg.5
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 08:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A3J8sUQKsUcr8UUHhsZncaYM0d8SHI9GfXKkNDeB1kg=;
        b=PgBOOzHmWGKmsTOjOSnzPnX4xwHbm0kNH6K9k+cDaMmMIIfkUSZrTU8xYPneVXqaJ/
         Fcq66b8mEBvQ6Dr9Y97W4kn38FtFwZVJaUP+3Rzh7lV//IAz3fEpc7v0TlLaVI0gpQ0E
         +ha1vRG+H+mWLwPE0QbVxAXwrQeT3XejVwJCc0ZhF2SjtS5BP9lvF91tVJLPHeNxm+nS
         3MuGwXad70xuv8ZdxJZw1uQCgJqvdSYByLXAYC0kQXBbq+TBLdT3VjTEP9u90BUjQl70
         8KP50HAHn4Ueq9OoirVfoVROHiRnpjHFE+eWMVeFhereXuM18WHX8LTqQ/vUlhFdXJ7y
         iDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A3J8sUQKsUcr8UUHhsZncaYM0d8SHI9GfXKkNDeB1kg=;
        b=dymTyzcnX0egNl9cZCpCfBnCQ058Jbvb+DGJOSUM+wNR8189YD1Ra8UxTwuVIkt/qg
         JBzCkz67oDiPKyuW8MdvLzARdyvL9BBWv5dtJ3iukWw9fvByRIsNTk959SZT+Q26HqVG
         Ml7MRlbKlZ6rLtnW7AkugwDLaxXlHt4bUp8uO/ZJVSDNjk5T3lrrEzUEdf7o9DKnPqPg
         a5P/lnRdyQgDr2KVlXL/y6cAKPkbaRo8T1NmF0VOiv4RaNeMlz1HQKuV9lHUkIDlnLHJ
         itGGkgukBZOH1L6cSp1F27sgq4CgZNmT0s2zbwB2uxxs4tD73vhFXING3gHFnHpWifGz
         +vcg==
X-Gm-Message-State: AOAM532FO5snIE9EuvBErQNfXnslpYK5zJTAe8ReYTyoVP9IYXszY3oJ
        3C51n2uUEt4/oOp72m2Mt55h
X-Google-Smtp-Source: ABdhPJyaz2k3X/gpmrgUQtHd6z/b3z+Z1anyH3R3kV4XXrK+IlXJ9s+yDfQJ4XBecH//rWsvIsD0+A==
X-Received: by 2002:a37:b885:0:b0:606:f607:d820 with SMTP id i127-20020a37b885000000b00606f607d820mr7168526qkf.124.1646669458960;
        Mon, 07 Mar 2022 08:10:58 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w3-20020a05620a094300b00605b33b1bd4sm6166069qkw.55.2022.03.07.08.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 08:10:52 -0800 (PST)
Message-ID: <27509b95-c8c3-fe9d-1f0c-31a13dadfb66@github.com>
Date:   Mon, 7 Mar 2022 11:10:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 11/11] bundle: unbundle promisor packs
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <ec51d0a50e6e64ae37795d77f7d33204b9b71ecd.1645638911.git.gitgitgadget@gmail.com>
 <220307.8635jtzrvg.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220307.8635jtzrvg.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 10:47 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> In order to have a valid pack-file after unbundling a bundle that has
>> the 'filter' capability, we need to generate a .promisor file. The
>> bundle does not promise _where_ the objects can be found, but we can
>> expect that these bundles will be unbundled in repositories with
>> appropriate promisor remotes that can find those missing objects.
>>
>> Use the 'git index-pack --promisor=<message>' option to create this
>> .promisor file. Add "from-bundle" as the message to help anyone diagnose
>> issues with these promisor packs.
>>
>> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>> ---
>>  bundle.c               | 4 ++++
>>  t/t6020-bundle-misc.sh | 8 +++++++-
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/bundle.c b/bundle.c
>> index e284ef63062..3d97de40ef0 100644
>> --- a/bundle.c
>> +++ b/bundle.c
>> @@ -631,6 +631,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
>>  	struct child_process ip = CHILD_PROCESS_INIT;
>>  	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
>>  
>> +	/* If there is a filter, then we need to create the promisor pack. */
>> +	if (header->filter)
>> +		strvec_push(&ip.args, "--promisor=from-bundle");
>> +
>>  	if (extra_index_pack_args) {
>>  		strvec_pushv(&ip.args, extra_index_pack_args->v);
>>  		strvec_clear(extra_index_pack_args);
>> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
>> index 39cfefafb65..344af34db1e 100755
>> --- a/t/t6020-bundle-misc.sh
>> +++ b/t/t6020-bundle-misc.sh
>> @@ -513,7 +513,13 @@ do
>>  		The bundle uses this filter: $filter
>>  		The bundle records a complete history.
>>  		EOF
>> -		test_cmp expect actual
>> +		test_cmp expect actual &&
>> +
>> +		# This creates the first pack-file in the
>> +		# .git/objects/pack directory. Look for a .promisor.
>> +		git bundle unbundle partial.bdl &&
>> +		ls .git/objects/pack/pack-*.promisor >promisor &&
>> +		test_line_count = 1 promisor
>>  	'
>>  done
> 
> Aside from what Junio mentioned, the preceding commit seems to be
> incomplete here. I.e. I'd expect to see this replace a case where we
> died or whatever before. What happened if we invoked "unbundle" before?

Looking closely, I think the only difference is that this patch
adds the .promisor file. I can push my expanded test to be
earlier in the series so we can verify this.

Thanks,
-Stolee

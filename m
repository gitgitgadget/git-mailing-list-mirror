Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996E41F461
	for <e@80x24.org>; Mon, 19 Aug 2019 09:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfHSJzc (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 05:55:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51135 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfHSJzc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 05:55:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so1034249wml.0
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 02:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D4JRl2sNTZJajuhq+tZak0HAAPTD2vwWLnCY0l6incg=;
        b=aZzOQIqvSvNjPk0Iubi6E9ye3xBCWHS/iBF2mZ7OovVEOxW/hhHMTO/PaAhTA7N9Qd
         R+MMaVJw+NFlYXRhuwdQVPuERJdpqZ89fhE4rcbKrC01xug7BtV9hiC85B3DSi3sjo5M
         fCnAiQcDOWn2Cb8ImrGAWu4dG4Szv4O4PmUOCbF1sujI1KcSKP5kk3nkZ6sBkf9lrzhq
         UwoLj2PoDfkcCA2DChvAxzDW8abBffHCjUJpe2qJFAxGGk313TrynirYObz3JSaxypEw
         WQEAZj9uD0ZskKbxK0hm2OYFuNcsr9r5EYZ3EGWJZieTPOcCpwW83UU+uXFp+SvvVW/k
         f9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:from:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=D4JRl2sNTZJajuhq+tZak0HAAPTD2vwWLnCY0l6incg=;
        b=oJAfYkTzGff4LfK4jd8xL9Cs4abTyXpB0muMg+FRCz+GDKHHcMSPu5ySsTN9iJl4LB
         HHmbjE27zuLtUUMDBKfVR7i2i/W6iBxPXet/fHPX7phliC2er+bxwdzDiqMLR+VyyUbd
         G/5+U7KSq0my55QxpugYd7h2//82k9e8/R+GfxSe/Mim4mbnPiXCWP9od6PAIcqPUWxR
         9DUAEvx7tCCKv95oIN98DlbJVvS6eKyUqq8K72xp4nR1BZpY3QWCVdVo5wSxiQuDJtgj
         4gyRnP3dm+CxtUwVex0THc52/3CAISaSw+GMbbcSpXVbQekzUW2f3oX/Jf0IYcSxPAwJ
         vl+A==
X-Gm-Message-State: APjAAAWet2XJb0NRrttnobcRpKn8PAUVOaGsyCnuudvrgiE37nngEseh
        YE8KHZK7r4ZsV/fwkBVzpbE=
X-Google-Smtp-Source: APXvYqzUOOWFuxF690f3WuVKyarIDvE5rQrV3oqxpRpt0GQUuqUd/Qb+puFEweOyC38xafWS5d+CYg==
X-Received: by 2002:a05:600c:2111:: with SMTP id u17mr20424639wml.64.1566208529235;
        Mon, 19 Aug 2019 02:55:29 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-12-34.as13285.net. [92.22.12.34])
        by smtp.gmail.com with ESMTPSA id n14sm45428796wra.75.2019.08.19.02.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 02:55:28 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] apply: reload .gitattributes after patching it
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-3-sandals@crustytoothpaste.net>
 <9b940950-666a-0c4c-58c0-1e61ac9e654c@gmail.com>
Message-ID: <2c33a668-4c7d-2114-41b1-8907c4384a15@gmail.com>
Date:   Mon, 19 Aug 2019 10:55:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9b940950-666a-0c4c-58c0-1e61ac9e654c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/08/2019 10:41, Phillip Wood wrote:
> [...]
>> diff --git a/convert.c b/convert.c
>> index 94ff837649..030e9b81b9 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -1293,10 +1293,11 @@ struct conv_attrs {
>>       const char *working_tree_encoding; /* Supported encoding or 
>> default encoding if NULL */
>>   };
>> +static struct attr_check *check;
> 
> I was concerned about the impact adding a file global if we ever want to 
> multi-thread this for submodules, but looking through the file there are 
> a couple of others already so this isn't creating a new problem.

Doh, I've just realized it was static already - ignore that.

One thing did occur to me though - does this patch reset attributes like 
the merge marker length (they're less critical though if there is a 
conflict after an attribute change it would be nice to have the correct 
length) or just the ones for filtering files?

Best Wishes

Phillip

> 
> Best Wishes
> 
> Phillip
> 
>> +
>>   static void convert_attrs(const struct index_state *istate,
>>                 struct conv_attrs *ca, const char *path)
>>   {
>> -    static struct attr_check *check;
>>       struct attr_check_item *ccheck = NULL;
>>       if (!check) {
>> @@ -1339,6 +1340,12 @@ static void convert_attrs(const struct 
>> index_state *istate,
>>           ca->crlf_action = CRLF_AUTO_INPUT;
>>   }
>> +void reset_parsed_attributes(void)
>> +{
>> +    attr_check_free(check);
>> +    check = NULL;
>> +}
>> +
>>   int would_convert_to_git_filter_fd(const struct index_state *istate, 
>> const char *path)
>>   {
>>       struct conv_attrs ca;
>> diff --git a/convert.h b/convert.h
>> index 831559f10d..3710969d43 100644
>> --- a/convert.h
>> +++ b/convert.h
>> @@ -94,6 +94,12 @@ void convert_to_git_filter_fd(const struct 
>> index_state *istate,
>>   int would_convert_to_git_filter_fd(const struct index_state *istate,
>>                      const char *path);
>> +/*
>> + * Reset the internal list of attributes used by convert_to_git and
>> + * convert_to_working_tree.
>> + */
>> +void reset_parsed_attributes(void);
>> +
>>   /*****************************************************************
>>    *
>>    * Streaming conversion support
>> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>> index 80b23fd326..23469cc789 100755
>> --- a/t/t3400-rebase.sh
>> +++ b/t/t3400-rebase.sh
>> @@ -301,6 +301,42 @@ test_expect_success 'rebase --am and 
>> --show-current-patch' '
>>       )
>>   '
>> +test_expect_success 'rebase --am and .gitattributes' '
>> +    test_create_repo attributes &&
>> +    (
>> +        cd attributes &&
>> +        test_commit init &&
>> +        git config filter.test.clean "sed -e 
>> '\''s/smudged/clean/g'\''" &&
>> +        git config filter.test.smudge "sed -e 
>> '\''s/clean/smudged/g'\''" &&
>> +
>> +        test_commit second &&
>> +        git checkout -b test HEAD^ &&
>> +
>> +        echo "*.txt filter=test" >.gitattributes &&
>> +        git add .gitattributes &&
>> +        test_commit third &&
>> +
>> +        echo "This text is smudged." >a.txt &&
>> +        git add a.txt &&
>> +        test_commit fourth &&
>> +
>> +        git checkout -b removal HEAD^ &&
>> +        git rm .gitattributes &&
>> +        git add -u &&
>> +        test_commit fifth &&
>> +        git cherry-pick test &&
>> +
>> +        git checkout test &&
>> +        git rebase master &&
>> +        grep "smudged" a.txt &&
>> +
>> +        git checkout removal &&
>> +        git reset --hard &&
>> +        git rebase master &&
>> +        grep "clean" a.txt
>> +    )
>> +'
>> +
>>   test_expect_success 'rebase--merge.sh and --show-current-patch' '
>>       test_create_repo conflict-merge &&
>>       (
>>

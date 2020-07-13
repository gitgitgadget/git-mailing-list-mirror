Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF2EC433E0
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8DA206F5
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vak+ZLin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGMTlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMTlX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 15:41:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A23C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:41:23 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j10so10933544qtq.11
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YYD8JvaqV516Pa2AZZUa6lTWu5m2yknTuDC25SnE7AI=;
        b=vak+ZLinPZoiBFfkZZasO57K6E2d03lepXJNB1GZPwb2cIslP+zsd4coDKDbnjJkOT
         tPWZrtBlAJ/PgBgoZPSuPTX1nJD919ApW6kwtBWhlQmP8fgMGdcwJx/CbNbHNKhlLBZB
         HfCmAm9cEhfkTkFEXkjrjrvI6eHa60dPg4j3B61QIVqXBCEZgRgQrR1JLe3PTQpYxT+q
         dXYmZkyDqJ2S+3/k5EwSwVOtUAdYMW3czDyn9jNDAZKiV0cHrQGUYdUynumGElhMJos2
         5y3JW2xykaYGgMh6nRxD3TLRcMClv50/DZX7CRLu6TxG1AaabVf2TKh+/FzUnIhjB2io
         4+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YYD8JvaqV516Pa2AZZUa6lTWu5m2yknTuDC25SnE7AI=;
        b=eHcESx4kya3unpdbMLo7l+eVds4QkleZRMGGgYf4W0j229p8ns8AoyQJSziH2QtDjV
         956pVeLU3HyBsGYKnTGy3Gvl1WhJYgXbrVJh3rCHwOgBJbooM6jkka8saNP3iPN0F0hl
         pLANV0lGxyp3Z0iFhyDuaj/vUiLKzQoN5BKnfWBX3DjsfK2bNJgXR/7IJ8m6sg/WGjOm
         TmehUmF2bjMYKJjf3d/+IxkpxR9dGed46So6Sj3m8G4gMeVe47M92vXLNLmhlBvfQT+r
         iIxpBatA1m1DVQZ/l7deyDbbWYM2tFZ5Snf90bQg8zURx4MB9DzprqwEG8Hqi+0OqXbY
         igAQ==
X-Gm-Message-State: AOAM5300qfnhuytO3ampPsCSvlps1sOqdLBk8bQuQpGKBdGZ6u/m3uEi
        nAuL5f8HVN8o/h4yUcgGDP4=
X-Google-Smtp-Source: ABdhPJwWVnHZKws2j0iaFpfWvxNWD7LRBAlmv84RvMl+HLdthwLQe1tlBEm24JlnZPOyIx7U/GlsRA==
X-Received: by 2002:aed:247a:: with SMTP id s55mr987030qtc.247.1594669282505;
        Mon, 13 Jul 2020 12:41:22 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t35sm21528502qth.79.2020.07.13.12.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 12:41:21 -0700 (PDT)
Subject: Re: [PATCH] setup: warn if extensions exist on old format
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, delphij@google.com,
        peff@peff.net, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
 <20200713193405.GC77607@syl.lan>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <95c338d0-dbf0-669d-59a3-8c2d6c87c8fc@gmail.com>
Date:   Mon, 13 Jul 2020 15:41:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200713193405.GC77607@syl.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/2020 3:34 PM, Taylor Blau wrote:
> s/upgrae/upgrade
> s/ocnfigured/configured

Oh man, what was going on with me when I was typing this message.

Thanks for the thorough inspection.

>> diff --git a/setup.c b/setup.c
>> index eb066db6d8..6ff6c54d39 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -542,6 +542,11 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
>>  		}
>>  	}
>>
>> +	if (candidate->version == 0 && candidate->has_extensions) {
>> +		warning(_("some extensions are enabled, but core.repositoryFormatVersion=0"));
>> +		warning(_("if you intended to use extensions, run 'git config core.repositoryFormatVersion 1'"));
>> +	}
>> +
>>  	return 0;
>>  }
>>
>> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
>> index 88cdde255c..d249428f44 100755
>> --- a/t/t1091-sparse-checkout-builtin.sh
>> +++ b/t/t1091-sparse-checkout-builtin.sh
>> @@ -68,6 +68,15 @@ test_expect_success 'git sparse-checkout init' '
>>  	check_files repo a
>>  '
>>
>> +test_expect_success 'warning about core.repositoryFormatVersion' '
>> +	test_when_finished git -C repo config core.repositoryFormatVersion 1 &&
>> +	git -C repo status 2>err &&
>> +	test_must_be_empty err &&
>> +	git -C repo config --local core.repositoryFormatVersion 0 &&
> 
> I don't think it's that difficult to see that this patch is correct, but
> it might be worth testing this for the case that
> 'core.repositoryFormatVersion' is unset, too.

You were absolutely right to check this, since this diff causes
the test to fail:

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index d249428f44..b5de141292 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -74,6 +74,9 @@ test_expect_success 'warning about core.repositoryFormatVersion' '
        test_must_be_empty err &&
        git -C repo config --local core.repositoryFormatVersion 0 &&
        git -C repo status 2>err &&
+       test_i18ngrep "some extensions are enabled, but core.repositoryFormatVersion=0" err &&
+       git -C repo config --local --unset core.repositoryFormatVersion 0 &&
+       git -C repo status 2>err &&
        test_i18ngrep "some extensions are enabled, but core.repositoryFormatVersion=0" err
 '
 

I'll investigate why the "unset" case is different than the "0" case.

Hopefully the "should we do this?" question can continue being discussed
while I work on a v2.

Thanks,
-Stolee

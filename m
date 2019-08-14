Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F87B1F45C
	for <e@80x24.org>; Wed, 14 Aug 2019 18:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfHNSdS (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 14:33:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41188 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNSdR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 14:33:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so6911725pfz.8
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=fxDyKfkvLXxiFl2SIALqKmFgxdk0njqCrhRC6Pqk7gY=;
        b=QDnsUsMhDz4MEAJTpnNFDz1z/vyYoPg9m0wYrD5kgB3oB9pVT/MzBTLXc0726p/pGC
         srnG8rVcLxa3cLKx1r98Sic7BuRbwus844X5fQN/aKb5D83hhkTUjYFEJ0yNsOtFKrWY
         BFkM1CTlsZMHugfGtSY2DxkMQl7dNIzknjr7NQuJL+EKyeyH0CkewWA4mr8GBWZaIhC/
         quR0f0aK+zYkGRGb6HPW0CGuPtCVQBajwBCLcOA2NIUwHAHxHL8/kbyZdyWEtzXgnEM4
         a2VehuFuAOfIJ1KwM54Zsvlts045dxVz44JzqhYGZDzSEfft+wrZcCIG4Kryf0KOeeEp
         o7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=fxDyKfkvLXxiFl2SIALqKmFgxdk0njqCrhRC6Pqk7gY=;
        b=Zc76GoVZiJ75Z0xdMz31tS5Qspeue3Kzx5yq2PsYQueK0vqgFc/IJ+CI1TG+fgtfY1
         YxSZfKBq3dY+wQMOJG/35aZpfQ4RFQ7/XP2pfXokyXWdZ9pIISQOCa/Hjb6SS0lbPIYV
         f9Pq/bnkWo/uqtVWo3BxAzIJPICALIQqYBqjsc9xUz1/CffvncWOVB8YYqmw8YEmwZe4
         bGO5ltT5Y34Tmnqqq1ECUivkBNtmoSZW1oAyCltf122s5bOf3x+YyRlK5f76+SsaVV5V
         f7fel87zveS4rUzkDJqYUScvOjnmMZX0aGNzGK6W3ULv3bPHPwglu60ajO+g/PAaDKAC
         MENA==
X-Gm-Message-State: APjAAAVKlAezRZKgn7ruDj8mMOhPVZ+4/xsxPS2UR/XaUi62ktGQy7MI
        zEWZ1qsKPeYYrsHjcIkDUZrdx8VrrtExcA==
X-Google-Smtp-Source: APXvYqzXrGbeHmlFxsYbD9H0JfH+29FfLO6jPyMZ9Yth5rd4/xO+n+NLOvuYj1IGLiOukvWYqvRkDg==
X-Received: by 2002:a63:1b66:: with SMTP id b38mr490772pgm.54.1565807596350;
        Wed, 14 Aug 2019 11:33:16 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h20sm502433pfq.156.2019.08.14.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:33:15 -0700 (PDT)
Date:   Wed, 14 Aug 2019 11:33:15 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Aug 2019 11:32:34 PDT (-0700)
Subject:     Re: [PATCH v2 5/5] fetch: Make --jobs control submodules and remotes
In-Reply-To: <20190814083245.GP20404@szeder.dev>
CC:     git@vger.kernel.org, peff@peff.net, e@80x24.org,
        chriscool@tuxfamily.org, gitster@pobox.com,
        jonathantanmy@google.com, tboegi@web.de, bwilliams.eng@gmail.com,
        jeffhost@microsoft.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     szeder.dev@gmail.com
Message-ID: <mhng-0d288d1c-02fc-4280-bd8f-b7f611af3e8a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 14 Aug 2019 01:32:45 PDT (-0700), szeder.dev@gmail.com wrote:
> On Mon, Aug 12, 2019 at 02:34:48PM -0700, Palmer Dabbelt wrote:
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 67d001f3f78b..41498e9efb3b 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -114,6 +114,20 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
>>  	return git_default_config(k, v, cb);
>>  }
>>
>> +static int parse_jobs_arg(const struct option *opt, const char *arg, int unset)
>> +{
>> +	int jobs;
>> +
>> +	jobs = atoi(arg);
>> +	if (jobs < 1)
>> +		die(_("There must be a positive number of jobs"));
>> +
>> +	max_children_for_submodules = jobs;
>> +	max_children_for_fetch = jobs;
>> +
>> +	return 0;
>> +}
>> +
>>  static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
>>  {
>>  	BUG_ON_OPT_NEG(unset);
>> @@ -142,12 +156,13 @@ static struct option builtin_fetch_options[] = {
>>  		    N_("fetch all tags and associated objects"), TAGS_SET),
>>  	OPT_SET_INT('n', NULL, &tags,
>>  		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
>> -	OPT_INTEGER('j', "jobs", &max_children_for_submodules,
>> +	{ OPTION_CALLBACK, 'j', "jobs", NULL, N_("jobs"),
>> +		    N_("number of parallel tasks to run while fetching"),
>> +		    PARSE_OPT_OPTARG, &parse_jobs_arg },
>
> These changes result segmentation faults in the tests '--quiet
> propagates to parallel submodules' and 'fetching submodules respects
> parallel settings' in 't5526-fetch-submodules.sh'.
>
> If the number of jobs is specified as '-j 2' or '--jobs 7', i.e. as an
> unstuck argument of the option, as opposed to '-j2' or '--jobs=7',
> then 'arg' in the parse_jobs_arg() callback is NULL, which then causes
> the segfault somewhere inside that atoi() call.

Thanks, I'll fix that in the v3.

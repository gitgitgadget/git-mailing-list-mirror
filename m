Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA8A1F609
	for <e@80x24.org>; Thu, 30 May 2019 17:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfE3RV5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 13:21:57 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42655 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfE3RVz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 13:21:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so7877737qtk.9
        for <git@vger.kernel.org>; Thu, 30 May 2019 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jT6znG29NjtFJmSFNcehpKaJ/Nyzs77ZpgkM+7MhGJs=;
        b=kjlsy01+S2d4N4IHDqmf4/QFxjxJn3b4XfYgVGUxjmDUJp5evirU0+41C9V2FO7hUM
         eknhv5q2+oqz4VEp6XxDImOYui1WMClSSi98O5jYvY981K2wxLrfCC5xHTBDcc9BsMfO
         VnvvigzUDlp7TO8anjg7HacV9jEcU51xn3mVF+UOxIT2ftw5WkgU7d7BMEd7rBEwT1LW
         DyVFMqKRt0IwJ1VgH/d3WVCppVZECE6Dq64NPovRORunztPCV3LSWlrs/7JYwMUaT8yf
         kl1jSJcbg88Yl0MBvsCAutznh5AbySakhKCn0nGcMtBCYuYRNSDskFyr85l88R5kAIxS
         WUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jT6znG29NjtFJmSFNcehpKaJ/Nyzs77ZpgkM+7MhGJs=;
        b=nyulQnGesj20SK2qSX8v9St3jaOdLcxxjYJdDkyqiGhG2H4lt6ULsHXbcXo83fqzdK
         ugmK5CCa9GK02qpxjXZEkZwgN2WAlgjLFE1BiH7EWEiil2gUQz+2glP7RjBX2RDn8EOx
         H7exftW0V1O5WeA5gfTsmF65A+dZsEd/W+1GVL4LTpwnBDOnmiru/5Wu/sj2jBpVUb4G
         g/R4m+s2q6r48TDL5CvotRok5J02Uj8Y3+rXaroeIA1mooGvuy6+rNXqT847OPboTR0W
         mQDMVq8R05fi3szagvr0oTC5APYzOxPSTkI/a75QvUNJPmTFAovIOzpSIi67NaHRCgjW
         MKTw==
X-Gm-Message-State: APjAAAWpffytY6VlRlIXj4mtpgCbgEBOarAphk5PtHi3dmYzwS1jSsvK
        JaVq2TzrSd8kSZMmOGK+cFY=
X-Google-Smtp-Source: APXvYqyPJdCGj3hpsaANfDPsGIgiyJ5wOnmQy/NQnLPJ4NOOR+xQeCYkhwRLlbuOYe7FEsgYvXspWw==
X-Received: by 2002:ac8:7349:: with SMTP id q9mr2693886qtp.151.1559236914572;
        Thu, 30 May 2019 10:21:54 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id d16sm2169589qtd.73.2019.05.30.10.21.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 10:21:53 -0700 (PDT)
Subject: Re: [PATCH v5 04/16] promisor-remote: implement
 promisor_remote_get_direct()
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
 <20190409161116.30256-5-chriscool@tuxfamily.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b4d69d2b-dc0d-fffb-2909-c54060fe9cd1@gmail.com>
Date:   Thu, 30 May 2019 13:21:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190409161116.30256-5-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/9/2019 12:11 PM, Christian Couder wrote:
> From: Christian Couder <christian.couder@gmail.com>
> 
> This is implemented for now by calling fetch_objects(). It fetches
> from all the promisor remotes.

Hi Christian,

Sorry for jumping on the thread late, but I noticed some peculiarities
when looking at the test coverage report.

> +static int remove_fetched_oids(struct object_id **oids, int oid_nr, int to_free)

This method does not seem to be covered by the test suite at all.
Is this scenario difficult to set up for a test?

> +{
> +	int i, missing_nr = 0;
> +	int *missing = xcalloc(oid_nr, sizeof(*missing));
> +	struct object_id *old_oids = *oids;
> +	struct object_id *new_oids;
> +	int old_fetch_if_missing = fetch_if_missing;
> +
> +	fetch_if_missing = 0;

This global 'fetch_if_missing' swap seems very fragile. I'm guessing you are using
it to prevent a loop when calling oid_object_info_extended() below. Can you instead
pass a flag to the method that disables the fetch_if_missing behavior?

> +
> +	for (i = 0; i < oid_nr; i++)
> +		if (oid_object_info_extended(the_repository, &old_oids[i], NULL, 0)) {

A use of "the_repository" this deep in new code is asking for a refactor later to remove it.
Please try to pass a "struct repository *r" through your methods so we minimize references
to the_repository (and the amount of work required to remove them later).

> +			missing[i] = 1;
> +			missing_nr++;
> +		}
> +
> +	fetch_if_missing = old_fetch_if_missing;
> +
> +	if (missing_nr) {
> +		int j = 0;
> +		new_oids = xcalloc(missing_nr, sizeof(*new_oids));
> +		for (i = 0; i < oid_nr; i++)
> +			if (missing[i])
> +				oidcpy(&new_oids[j++], &old_oids[i]);
> +		*oids = new_oids;
> +		if (to_free)
> +			free(old_oids);
> +	}
> +
> +	free(missing);
> +
> +	return missing_nr;
> +}
> +
> +int promisor_remote_get_direct(const struct object_id *oids, int oid_nr)
> +{
> +	struct promisor_remote *r;
> +	struct object_id *missing_oids = (struct object_id *)oids;
> +	int missing_nr = oid_nr;

Note that for this method, "missing_nr" actually means "number of oids still in the list".

> +	int to_free = 0;
> +	int res = -1;
> +
> +	promisor_remote_init();
> +
> +	for (r = promisors; r; r = r->next) {
> +		if (fetch_objects(r->name, missing_oids, missing_nr) < 0) {

This block hits if we have any missing objects. This is not currently hit by the test
suite.

> +			if (missing_nr == 1)
> +				continue;

But we skip the call below if there is exactly one object in the list, as it must be the one
missing object. So, to be interesting we need to try fetching multiple objects.

> +			missing_nr = remove_fetched_oids(&missing_oids, missing_nr, to_free);

Here is the one call, and after this assignment "missing_nr" does mean the number of missing objects.
However, I do think this could be clarified by using remaining_nr and remaining_oids.

> +			if (missing_nr) {
> +				to_free = 1;
> +				continue;
> +			}

Now this block took a bit to grok. You use to_free in the if(to_free) free(missing_oids); below.
But it also changes the behavior of remove_fetched_oids(). This means that the first time
remove_fetched_oids() will preserve the list (because it is the input list) but all later
calls will free the newly-created intermediate list. This checks out.

What is confusing to me: is there any reason that missing_nr would be zero in this situation?
I guess if the fetch_objects() failed to find some objects, but we ended up having them locally
in a new call to oid_object_info_extended(). That's a fringe case that is worth guarding against
but I wouldn't worry about testing.

> +		}
> +		res = 0;
> +		break;
> +	}
> +
> +	if (to_free)
> +		free(missing_oids);
> +
> +	return res;
> +}

While the test coverage report brought this patch to my attention, it does seem correct.
I still think a test exposing this method would be good, especially one that requires
a fetch_objects() call to multiple remotes to really exercise the details of remove_fetched_oids().

Thanks,
-Stolee


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AC4221845
	for <e@80x24.org>; Tue,  1 May 2018 11:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754477AbeEALLL (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:11:11 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34530 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753851AbeEALLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:11:09 -0400
Received: by mail-qt0-f176.google.com with SMTP id m5-v6so14181805qti.1
        for <git@vger.kernel.org>; Tue, 01 May 2018 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZSL/GhCVwJzCYhMpjRF3II2sGLfPBoq1qf5f9vdYq3s=;
        b=K6xcqRIbOyYI91HA0+Dg6Zueki1u8TZbydZ2w4u136Eq32aTO/CW1PEqNksAzR0Xhl
         TwNsi9QkYmoab06icuY/rNdnZ+OmTAcLBlkD6zRSYu4yZq1G1AamVlCO/rRK52cIhJ0b
         oJ+RnzhU5Yh4fU6LZMM2tomtITwNjTU3sTNfrTyTYKvDZcJuQA+bcvKZlav3YMkk6GwI
         qtgQRYXG8s15I2QWMMwD8nZQe45BDLzLwpHF0t8pZklwBt2vaicgS5AGYkRzwePVgwIg
         GsBw6LIjuIVy+9PHV5EbEEZbg5uKNFVix7wjYMwUWHfNnZ60zZb+u//LH8wSuiZSkxgt
         tjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZSL/GhCVwJzCYhMpjRF3II2sGLfPBoq1qf5f9vdYq3s=;
        b=b1Q3YMiTMeOqjvswebiUkGrmM7bJ6Rb51SDvnWUG9TOtWdOnDeqvt3Lx7V8xlaSaj0
         0VIbUDVDrf35kGnXP6hjFc/VJBvub3+bcZrsvheZGKRIZ7MwL2YF2bcUZhrS+m4+3M0m
         Zl4/AqQ/zVxefuvC5MEZDEVVbVgpLeduwIcivxYtyujBX4jGc2oILs8SYPgLV8R0IdVn
         2JHX39ZN5ydNl/AIS3fbcQY4vg5cKY9J25Wx90coXBDvnXqE7CjxPAGXPKgaIpCNoMw3
         ZGJl3rB17C61AZ3m1+o1hbrlSE/PyY8gGjkCls5bOeWhNL6NbR5tfi0zwJmjj4vP7hDN
         K3tA==
X-Gm-Message-State: ALQs6tDKAgyaM6z3auHWKWrzdeNCSu+PgqnSIz2YN8Pashw7ENZWfOBb
        Nn63QyUSpbuWf6543M/rApg=
X-Google-Smtp-Source: AB8JxZoXQh7MJ3OIfit1POorQHgqOvQ9+rrar+y1IeYmIbCSfMiX8pKrhF0X1iZuqjiSOvkrJ97M3w==
X-Received: by 2002:ac8:2753:: with SMTP id h19-v6mr3687231qth.185.1525173068709;
        Tue, 01 May 2018 04:11:08 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id l52-v6sm9059171qtc.45.2018.05.01.04.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 04:11:08 -0700 (PDT)
Subject: Re: [PATCH 4/9] get_short_oid: sort ambiguous objects by type, then
 SHA-1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20180430220734.30133-1-avarab@gmail.com>
 <20180430220734.30133-5-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5f8b1ec1-258d-1acc-133e-a7c248b4083e@gmail.com>
Date:   Tue, 1 May 2018 07:11:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430220734.30133-5-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/30/2018 6:07 PM, Ævar Arnfjörð Bjarmason wrote:
> Change the output emitted when an ambiguous object is encountered so
> that we show tags first, then commits, followed by trees, and finally
> blobs. Within each type we show objects in hashcmp(). Before this
> change the objects were only ordered by hashcmp().
>
> The reason for doing this is that the output looks better as a result,
> e.g. the v2.17.0 tag before this change on "git show e8f2" would
> display:
>
>      hint: The candidates are:
>      hint:   e8f2093055 tree
>      hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique detached HEAD abbreviated object name
>      hint:   e8f21d02f7 blob
>      hint:   e8f21d577c blob
>      hint:   e8f25a3a50 tree
>      hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from jeffhostetler/jeffhostetler/register_rename_src
>      hint:   e8f2650052 tag v2.17.0
>      hint:   e8f2867228 blob
>      hint:   e8f28d537c tree
>      hint:   e8f2a35526 blob
>      hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior for multiple remote.url entries
>      hint:   e8f2cf6ec0 tree
>
> Now we'll instead show:
>
>      hint:   e8f2650052 tag v2.17.0
>      hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique detached HEAD abbreviated object name
>      hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from jeffhostetler/jeffhostetler/register_rename_src
>      hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior for multiple remote.url entries
>      hint:   e8f2093055 tree
>      hint:   e8f25a3a50 tree
>      hint:   e8f28d537c tree
>      hint:   e8f2cf6ec0 tree
>      hint:   e8f21d02f7 blob
>      hint:   e8f21d577c blob
>      hint:   e8f2867228 blob
>      hint:   e8f2a35526 blob
>
> Since we show the commit data in the output that's nicely aligned once
> we sort by object type. The decision to show tags before commits is
> pretty arbitrary, but it's much less likely that we'll display a tag,
> so if there is one it makes sense to show it first.

Here's a non-arbitrary reason: the object types are ordered 
topologically (ignoring self-references):

tag -> commit, tree, blob
commit -> tree
tree -> blob

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   sha1-array.c | 15 +++++++++++++++
>   sha1-array.h |  3 +++
>   sha1-name.c  | 37 ++++++++++++++++++++++++++++++++++++-
>   3 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/sha1-array.c b/sha1-array.c
> index 838b3bf847..48bd9e9230 100644
> --- a/sha1-array.c
> +++ b/sha1-array.c
> @@ -41,6 +41,21 @@ void oid_array_clear(struct oid_array *array)
>   	array->sorted = 0;
>   }
>   
> +
> +int oid_array_for_each(struct oid_array *array,
> +		       for_each_oid_fn fn,
> +		       void *data)
> +{
> +	int i;
> +
> +	for (i = 0; i < array->nr; i++) {
> +		int ret = fn(array->oid + i, data);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>   int oid_array_for_each_unique(struct oid_array *array,
>   				for_each_oid_fn fn,
>   				void *data)
> diff --git a/sha1-array.h b/sha1-array.h
> index 1e1d24b009..232bf95017 100644
> --- a/sha1-array.h
> +++ b/sha1-array.h
> @@ -16,6 +16,9 @@ void oid_array_clear(struct oid_array *array);
>   
>   typedef int (*for_each_oid_fn)(const struct object_id *oid,
>   			       void *data);
> +int oid_array_for_each(struct oid_array *array,
> +		       for_each_oid_fn fn,
> +		       void *data);
>   int oid_array_for_each_unique(struct oid_array *array,
>   			      for_each_oid_fn fn,
>   			      void *data);
> diff --git a/sha1-name.c b/sha1-name.c
> index 9d7bbd3e96..46d8b1afa6 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -378,6 +378,34 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
>   	return 0;
>   }
>   
> +static int sort_ambiguous(const void *a, const void *b)
> +{
> +	int a_type = oid_object_info(a, NULL);
> +	int b_type = oid_object_info(b, NULL);
> +	int a_type_sort;
> +	int b_type_sort;
> +
> +	/*
> +	 * Sorts by hash within the same object type, just as
> +	 * oid_array_for_each_unique() would do.
> +	 */
> +	if (a_type == b_type)
> +		return oidcmp(a, b);
> +
> +	/*
> +	 * Between object types show tags, then commits, and finally
> +	 * trees and blobs.
> +	 *
> +	 * The object_type enum is commit, tree, blob, tag, but we
> +	 * want tag, commit, tree blob. Cleverly (perhaps too
> +	 * cleverly) do that with modulus, since the enum assigns 1 to
> +	 * commit, so tag becomes 0.
> +	 */

I appreciate this comment. Clever things should be marked as such.

> +	a_type_sort = a_type % 4;
> +	b_type_sort = b_type % 4;
> +	return a_type_sort > b_type_sort ? 1 : -1;
> +}
> +
>   static int get_short_oid(const char *name, int len, struct object_id *oid,
>   			  unsigned flags)
>   {
> @@ -409,6 +437,8 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
>   	status = finish_object_disambiguation(&ds, oid);
>   
>   	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
> +		struct oid_array collect = OID_ARRAY_INIT;
> +
>   		error(_("short SHA1 %s is ambiguous"), ds.hex_pfx);
>   
>   		/*
> @@ -421,7 +451,12 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
>   			ds.fn = NULL;
>   
>   		advise(_("The candidates are:"));
> -		for_each_abbrev(ds.hex_pfx, show_ambiguous_object, &ds);
> +		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
> +		QSORT(collect.oid, collect.nr, sort_ambiguous);

I was wondering how the old code sorted by SHA even when the ambiguous 
objects were loaded from different sources (multiple pack-files, loose 
objects). Turns out that for_each_abbrev() does its own sort after 
collecting the SHAs and then calls the given function pointer only once 
per distinct object. This avoids multiple instances of the same object, 
which may appear multiple times across pack-files.

I only ask because now we are doing two sorts. I wonder if it would be 
more elegant to provide your sorting algorithm to for_each_abbrev() and 
let it call show_ambiguous_object as before.

Another question is if we should use this sort generally for all calls 
to for_each_abbrev(). The only other case I see is in builtin/revparse.c.

> +
> +		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
> +			BUG("show_ambiguous_object shouldn't return non-zero");
> +		oid_array_clear(&collect);
>   	}
>   
>   	return status;


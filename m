Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 482DE215F4
	for <e@80x24.org>; Tue,  1 May 2018 13:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755345AbeEANjO (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 09:39:14 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:54124 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755249AbeEANjL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 09:39:11 -0400
Received: by mail-wm0-f54.google.com with SMTP id a67so10203896wmf.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=geqvrtpQHXT25Bw86ULH0E42qh0RRPv30MDCYO3DJzE=;
        b=BBPCdzCdJEHeEPkgznC4aWjZEYAAflJLpnO2ujyuoNJ03QXW370KTmbTob1iEk6T40
         zQBCzokCyRoUHymgvIdDZ+3l1EnxrwXqhUsGGx17y/vysEHDdVDIRZGL1pB2Fdmx7LG4
         g2iLmcg3BdwpaQV8W98b1ZonoY2vBuWGeUTDR+Nw1ZgrjMu+OQKXiLOa9wOdIPzydGD8
         WMBQ0Jac+FWW+7fnbD18DHxi0IBDVmzMpoNu3ZPXiQqr3aIMUb5xu7oe0OP/ms+RbLBV
         bA/E6r1wbEGedKlcdoKO0owN5SK9skwioemVzCr7u6YiE0kHvwnug8X6muKb5kGc4KwD
         WiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=geqvrtpQHXT25Bw86ULH0E42qh0RRPv30MDCYO3DJzE=;
        b=R5PLveeFPiIhaqw2cZ7lUtIxbe0cL7lBopY3ACgX1AcbISHhamq7D9F29LJo85ZltV
         F/avcLTtpjLVKmm3XtZChjGOJRpfrAhFe6nuhcs3VjS0Pw+Bo2F3TWL06cO8goDjcxAU
         n2WzdVoOWceSiSucQyXLGrIkO/PN+nhLAPQvwsuGZC2CnDV3ZfMgFHqv3HXQga4xMG6A
         erGl/gPhwBduYRiAa+pLAK8mCDoI/NdjY96ai+NSO12GH/YRdyYV3+iEvm+yPUN3mCe8
         ipSjyoKx3E+Ad+6ZQT28IQ9JqJuzv96/GW6qX8hW+eiYoKLH/O5kM0uDplO+/9cIGHOE
         kKmg==
X-Gm-Message-State: ALQs6tDOO89M/M8IzlSC/m1Ix5O7pRAzNZ13MRqhRfJmGJOreduhAIJk
        Ex4zkd/biz3tOm6xYW16NyY=
X-Google-Smtp-Source: AB8JxZocO4cWjCOQxZlLiDVKGZZCQ1TkApfBCWvUN7j6b9GIcqPZa8g5IxFKSW3JZLMRn+Mm5qQKtg==
X-Received: by 2002:a50:9196:: with SMTP id g22-v6mr21030106eda.24.1525181950434;
        Tue, 01 May 2018 06:39:10 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id l1-v6sm5513139edi.54.2018.05.01.06.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 06:39:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "stolee\@gmail.com" <stolee@gmail.com>
Subject: Re: [PATCH v2 06/11] get_short_oid: sort ambiguous objects by type, then SHA-1
References: <20180501120651.15886-1-avarab@gmail.com> <20180501130318.58251-1-dstolee@microsoft.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180501130318.58251-1-dstolee@microsoft.com>
Date:   Tue, 01 May 2018 15:39:08 +0200
Message-ID: <876047ze9v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 01 2018, Derrick Stolee wrote:

> From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>
> Here is what I mean by sorting during for_each_abbrev(). This seems to work for
> me, so I don't know what the issue is with this one-pass approach.
> [...]
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
> +	a_type_sort = a_type % 4;
> +	b_type_sort = b_type % 4;
> +	return a_type_sort > b_type_sort ? 1 : -1;
> +}
> +
>  static int get_short_oid(const char *name, int len, struct object_id *oid,
>  			  unsigned flags)
>  {
> @@ -451,6 +479,9 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
>  	find_short_object_filename(&ds);
>  	find_short_packed_object(&ds);
>
> +	QSORT(collect.oid, collect.nr, sort_ambiguous);
> +	collect.sorted = 1;
> +

Yes this works. You're right. I wasn't trying to intentionally omit
stuff in my recent 878t93zh60.fsf@evledraar.gmail.com, I'd just written
this code some days ago and forgotten why I did what I was doing (and
this is hard to test for), but it's all coming back to me now.

The actual requirement for oid_array_for_each_unique() working properly
is that you've got to feed it in hash order, but my new sort_ambiguous()
still does that (barring any SHA-1 collisions, at which point we have
bigger problems), so two passes aren't needed. So yes, this apporoach
works and is one-pass.

But that's just an implementation detail of the current sort method,
when I wrote this I was initially playing with other sort orders,
e.g. sorting SHAs regardless of type by the mtime of the file I found
them in. With this approach I'd start printing duplicates if I changed
the internals of sort_ambiguous() like that.

But I think it's extremely implausible that we'll start sorting things
like that, so I'll just take this method of doing it and add some
comment saying we must hashcmp() the entries in our own sort function
for the de-duplication to work, I don't see us ever changing that.

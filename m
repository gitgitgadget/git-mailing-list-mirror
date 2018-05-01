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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C669215F4
	for <e@80x24.org>; Tue,  1 May 2018 14:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755507AbeEAOKq (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 10:10:46 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:55583 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755259AbeEAOKn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 10:10:43 -0400
Received: by mail-wm0-f42.google.com with SMTP id a8so17934787wmg.5
        for <git@vger.kernel.org>; Tue, 01 May 2018 07:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hltEpCvnNQp49Fe8J9s8bvssPWShbls2YVUYHvt1D6Q=;
        b=Y/+8SQRNRS/CReQEhiBhlJc1Kq8NYgTwAZGE+MzlXvfVRHn94tegOlDEf9EdIy3+FF
         T45oXO7g5wnSd0FN/qQvkyVi5eoIztoFUzyvHu//YOzJISHEBwLyVi3+lMSvSxTNSU3A
         /ZhiezM8QqhMx29dhTB2i0ER/HVlTRBKMlLHeURcYumyMh/Jj8VdqtXj3EdtMCuQQuW+
         n++Pt6OxevLT8YevgbKFrtdlNV2lbwwL263eeVvCQVBEKi2jP5GblMDyY+GUSWcti7BD
         3d6WrlcDE/3tsTrdXByBV1nfQ9FRIMfr3lpR85VQG2xZ6NjiPhkjdV9rb9ciPc9r0TfI
         0oPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hltEpCvnNQp49Fe8J9s8bvssPWShbls2YVUYHvt1D6Q=;
        b=nRc3I47+3eVbasGOGlk7Zow9oyadzaT5n9imvOCxVhlJgFzWThF0/6bY7qBtB6r1Ka
         YJPmHPSurwDuigErdvDT5bgn9ZvqgGPmueXBtxCPKBKOAczfs8Y4Zr8umx7Ll6t24LKD
         8QlGnP7FkjxTKBOs2ubRTQLLU2/QV/eVx+RL2BLShPYj3d46EspHCmgRUC9dq0o/a+SX
         xBeSE6bRqCopscOse4LA70+IbtQ7Bv4atjnhAvKM1Ka0kTsJSFCmWdNFxQPmUNhRc7ev
         kyyxzLwZlHw14Xaa/ZEZwh8rJ0I1lHyKcw1Z1Vd3q+A+c86WOO+d99jC2I58H+putmzp
         1zQQ==
X-Gm-Message-State: ALQs6tBASz2FEyanQZVTqhwAiq30fq0IZmGTRq9/582EOvtDHkbhCz4d
        s0ZLTlSUwCfUbYqC2X57jkhVCFGU
X-Google-Smtp-Source: AB8JxZpavLvDMzu2/GX8zJckE3grv5JgiGpfM9LgupjFZJLjpVUGNCgAm7IvizjxF8Mjuxqiiw/ifw==
X-Received: by 2002:a50:b1b5:: with SMTP id m50-v6mr21612314edd.66.1525183841708;
        Tue, 01 May 2018 07:10:41 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id z42-v6sm5876547edz.36.2018.05.01.07.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 07:10:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2 06/11] get_short_oid: sort ambiguous objects by type, then SHA-1
References: <20180501120651.15886-1-avarab@gmail.com> <20180501130318.58251-1-dstolee@microsoft.com> <876047ze9v.fsf@evledraar.gmail.com> <40868abd-6d2f-3f05-e099-6f0d06cc0683@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <40868abd-6d2f-3f05-e099-6f0d06cc0683@gmail.com>
Date:   Tue, 01 May 2018 16:10:39 +0200
Message-ID: <874ljrzctc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 01 2018, Derrick Stolee wrote:

> On 5/1/2018 9:39 AM, Ævar Arnfjörð Bjarmason wrote:
>> On Tue, May 01 2018, Derrick Stolee wrote:
>>
>>> From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>>
>>> Here is what I mean by sorting during for_each_abbrev(). This seems to work for
>>> me, so I don't know what the issue is with this one-pass approach.
>>> [...]
>>> +static int sort_ambiguous(const void *a, const void *b)
>>> +{
>>> +	int a_type = oid_object_info(a, NULL);
>>> +	int b_type = oid_object_info(b, NULL);
>>> +	int a_type_sort;
>>> +	int b_type_sort;
>>> +
>>> +	/*
>>> +	 * Sorts by hash within the same object type, just as
>>> +	 * oid_array_for_each_unique() would do.
>>> +	 */
>>> +	if (a_type == b_type)
>>> +		return oidcmp(a, b);
>>> +
>>> +	/*
>>> +	 * Between object types show tags, then commits, and finally
>>> +	 * trees and blobs.
>>> +	 *
>>> +	 * The object_type enum is commit, tree, blob, tag, but we
>>> +	 * want tag, commit, tree blob. Cleverly (perhaps too
>>> +	 * cleverly) do that with modulus, since the enum assigns 1 to
>>> +	 * commit, so tag becomes 0.
>>> +	 */
>>> +	a_type_sort = a_type % 4;
>>> +	b_type_sort = b_type % 4;
>>> +	return a_type_sort > b_type_sort ? 1 : -1;
>>> +}
>>> +
>>>   static int get_short_oid(const char *name, int len, struct object_id *oid,
>>>   			  unsigned flags)
>>>   {
>>> @@ -451,6 +479,9 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
>>>   	find_short_object_filename(&ds);
>>>   	find_short_packed_object(&ds);
>>>
>>> +	QSORT(collect.oid, collect.nr, sort_ambiguous);
>>> +	collect.sorted = 1;
>>> +
>> Yes this works. You're right. I wasn't trying to intentionally omit
>> stuff in my recent 878t93zh60.fsf@evledraar.gmail.com, I'd just written
>> this code some days ago and forgotten why I did what I was doing (and
>> this is hard to test for), but it's all coming back to me now.
>>
>> The actual requirement for oid_array_for_each_unique() working properly
>> is that you've got to feed it in hash order,
>
> To work properly, duplicate entries must be consecutive. Since
> duplicate entries have the same type, our sort satisfies this
> condition.
>
>> but my new sort_ambiguous()
>> still does that (barring any SHA-1 collisions, at which point we have
>> bigger problems), so two passes aren't needed. So yes, this apporoach
>> works and is one-pass.
>>
>> But that's just an implementation detail of the current sort method,
>> when I wrote this I was initially playing with other sort orders,
>> e.g. sorting SHAs regardless of type by the mtime of the file I found
>> them in. With this approach I'd start printing duplicates if I changed
>> the internals of sort_ambiguous() like that.
>
> That makes sense.
>
>> But I think it's extremely implausible that we'll start sorting things
>> like that, so I'll just take this method of doing it and add some
>> comment saying we must hashcmp() the entries in our own sort function
>> for the de-duplication to work, I don't see us ever changing that.
>
> Sounds good.

Actually I'm having second thoughts about that and thinking I might keep
my original approach (with a better explanation).

A few more lines of code seems worthwhile in order to not break the
assumptions a documented API is making, no matter how briefly, so I set
about documenting this case and supporting it, since
e.g. oid_array_lookup() will completely fail with the hack of setting
the .sorted member, and came up with this:

diff --git a/Documentation/technical/api-oid-array.txt b/Documentation/technical/api-oid-array.txt
index b0c11f868d..ff87260220 100644
--- a/Documentation/technical/api-oid-array.txt
+++ b/Documentation/technical/api-oid-array.txt
@@ -16,6 +16,20 @@ Data Structures
 	the actual data. The `nr` member contains the number of items in
 	the set.  The `alloc` and `sorted` members are used internally,
 	and should not be needed by API callers.
++
+Both the `oid_array_lookup` and `oid_array_for_each_unique` functions
+rely on the array being sorted. For the former it's an absolute
+requirenment that the internal `oid_array_sort` function has been
+called on it, bu for the latter it's enough that the elements are
+ordered in such a way as to guarantee that identical object IDs are
+adjacent in the array.
++
+This is useful e.g. to print output where commits, tags etc. are
+grouped together (barring a hash collision they won't have the same
+object ID), in such cases the `custom_sorted` member can be set to `1`
+before calling `oid_array_for_each_unique`, and it'll skip its own
+sorting. Once it's been set calling e.g. `oid_array_lookup` without it
+being cleared again will cause an internal panic, so use it carefully.

 Functions
 ---------
diff --git a/sha1-array.c b/sha1-array.c
index 466a926aa3..cbae07ff78 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -18,6 +18,7 @@ static void oid_array_sort(struct oid_array *array)
 {
 	QSORT(array->oid, array->nr, void_hashcmp);
 	array->sorted = 1;
+	array->custom_sorted = 0;
 }

 static const unsigned char *sha1_access(size_t index, void *table)
@@ -28,6 +29,13 @@ static const unsigned char *sha1_access(size_t index, void *table)

 int oid_array_lookup(struct oid_array *array, const struct object_id *oid)
 {
+	if (array->custom_sorted)
+		/*
+		 * We could also just clear custom_sorted here, but if
+		 * the caller is custom sorting and then calling this
+		 * that's likely something they'd like to know about.
+		 */
+		BUG("PANIC: Cannot lookup OIDs in arrays with a custom sort!");
 	if (!array->sorted)
 		oid_array_sort(array);
 	return sha1_pos(oid->hash, array->oid, array->nr, sha1_access);
@@ -39,6 +47,7 @@ void oid_array_clear(struct oid_array *array)
 	array->nr = 0;
 	array->alloc = 0;
 	array->sorted = 0;
+	array->custom_sorted = 0;
 }

 int oid_array_for_each_unique(struct oid_array *array,
@@ -47,7 +56,7 @@ int oid_array_for_each_unique(struct oid_array *array,
 {
 	int i;

-	if (!array->sorted)
+	if (!array->sorted && !array->custom_sorted)
 		oid_array_sort(array);

 	for (i = 0; i < array->nr; i++) {
diff --git a/sha1-array.h b/sha1-array.h
index 1e1d24b009..bfa77ba1e4 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -6,6 +6,7 @@ struct oid_array {
 	int nr;
 	int alloc;
 	int sorted;
+	int custom_sorted;
 };

 #define OID_ARRAY_INIT { NULL, 0, 0, 0 }
diff --git a/sha1-name.c b/sha1-name.c
index b81e07adbb..d190800db0 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -490,9 +490,11 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 	find_short_packed_object(&ds);

 	QSORT(collect.oid, collect.nr, sort_ambiguous);
-	collect.sorted = 1;

+	collect.custom_sorted = 1;
 	ret = oid_array_for_each_unique(&collect, fn, cb_data);
+	collect.custom_sorted = 0;
+
 	oid_array_clear(&collect);
 	return ret;
 }

So maybe I should just stop worrying and YOLO it, it just seems wrong to
leave such a fragile setup in place where we set .sorted=1 and some
future refactoring reasonably tries to call oid_array_lookup() on it and
silently fails.

What do you think?

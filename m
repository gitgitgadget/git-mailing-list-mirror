Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F1EEB64DD
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 00:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjF3AxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 20:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjF3AxU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 20:53:20 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6A62112
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 17:53:18 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53450fa3a18so1023521a12.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 17:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688086398; x=1690678398;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4AsSi+T/YPY3jQA12XwiwSlr3ZT0dRZXRCnayg44jy8=;
        b=XOzXj0foF/gDS8FGwpD+oeCg3CRLoFNynM/uKplCTQn73lLSwwkjka0alUUAU+upFs
         WkvJ4LNAvpCeJZDSaYFLAzDnbZ16zMrvXiEewq8rPqDhyT9BRbTjyLnVJdyuIClN+xni
         IF/nlB3T5McwNG5eRylTyexWTQpcwvHu8f0Efx76G3YZsumUATnDRkxRc08QOJomHUEh
         CEnQGPs47PG0CumAoxU/zxocpTeSzVLGMUyQtOuTMOZQqw4RzWyT9BAq4iUBRkWRdczj
         W5K2hStdnen3kITSGu589Dam/NS0Etxg5HDYMpQlXoDF/lLuKN4MK1KisCrIJViLcp5U
         6nnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688086398; x=1690678398;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4AsSi+T/YPY3jQA12XwiwSlr3ZT0dRZXRCnayg44jy8=;
        b=K/tdpWGyf12B2licJRjego61No4k5qjTKcz5FiZvE2G0HErcxMY2a5I9umgE1dLwuC
         qd6Ut6Fs9RGMue90/2Qeh0Z9vL28Ta2ZrEu+6Dja4oyI9iFpvhny5xg47OzK8h8DIWT6
         Yjlnxu1uLYhwS6tktWugzRdXi/N6eBRpM0SABCaslKAniIOhURoYLjuEAwHt29ElUAaQ
         UCzhxAqgrUNAL12rX4QFRenefx12xF6Dgvpw4geeMsw23oh3D/7pTrFBolDrDXdbaWeO
         O1QNTuHy9osvWGtMy2Nukwxz6SHRjM4x6HckD2dt+IyesigZXBe7ZzpZqbvgIWw8vcXu
         9jMA==
X-Gm-Message-State: ABy/qLYMZEnp2CJUXbfUb/VSzw+2K1lnyZIoyIYcGZ0avM3JHtxfKkH8
        09iKFnP0FSyMB3kbeQ4lwqshe22vX1VIsQ==
X-Google-Smtp-Source: APBJJlGYuUmS7/DnxGWkjN2JKg1iJjagMvQteT0mNwjEfPG3Zpl3NLsSdgYmMna303/YiXzHRXbQeq2Ftm7+iw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:4443:0:b0:55a:c91e:4121 with SMTP id
 t3-20020a634443000000b0055ac91e4121mr280283pgk.5.1688086398032; Thu, 29 Jun
 2023 17:53:18 -0700 (PDT)
Date:   Thu, 29 Jun 2023 17:53:16 -0700
In-Reply-To: <20230627132026.3204186-1-siddhartth@google.com>
Mime-Version: 1.0
References: <20230531155142.3359886-1-siddhartth@google.com> <20230627132026.3204186-1-siddhartth@google.com>
Message-ID: <kl6l8rc1rcsj.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH v2] khash_test.c : add unit tests
From:   Glen Choo <chooglen@google.com>
To:     Siddharth Singh <siddhartth@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Singh <siddhartth@google.com> writes:

> - rewrote the code keeping coding style guidelines in mind.

I noticed several style issues in the patch. I'll avoid commenting on
those here so that we can focus on the other, big questions.

> I'm also very new to writing unit tests in C and git codebase in general, so I'll appreciate constructive feedback and discussion..

Okay. I think this is a good chance for the ML to decide on what sorts
of unit test practices we want too.

> What are the unit test cases to include in khash.h?
> What are the other types of tests that would be useful for khash.h?

For a third party library, I mostly agree with upthread commenters that
testing the correctness of the _library_ code isn't that valuable on its
own, but unit tests are also useful for demonstrating how the code
should be used. In a lot of projects, unit tests are a pseudo-official
demonstration of how an interface should be used, and that's sometimes
better than seeing the code in production, because unit tests are
typically a lot simpler and easier to reason about.

As an aside, this is something that a unit test framework will do _much
better_ than test-tool, because it makes it easy to read and write these
idtiomatic demos without worrying about how the test-tool executable
will be used.

I think that if we consider these two factors together (correctness and
developer education), the fact that we don't have great documentation of
khash.h in-tree, and that the external docs aren't that comprehensive
either, I think it would be useful to exercise each of the khash
'functions' to show how they work.

As Taylor mentioned upthread, I think the most valuable thing to test is
the way our code uses khash.h (not the library code itself). IOW:

  KHASH_INIT(oid_set, struct object_id, int, 0, oidhash_by_value, oideq_by_value)
  KHASH_INIT(oid_map, struct object_id, void *, 1, oidhash_by_value, oideq_by_value)
  KHASH_INIT(oid_pos, struct object_id, int, 1, oidhash_by_value, oideq_by_value)

So we would focus on oidhash_by_value and oideq_by_value in particular,
since that's provided by us. It would be very useful to verify that
these functions are doing exactly what we think they should be doing,
and we could do this with _every_ khash function to really explore the
API surface.

In fact... I suspect that they _not_ doing what we think they should,
or at the very least, might be displaying some very unintuitive
behavior. object_id contains both the hash value _and_ the hash
algorithm that generated it. If we have the same hash value, but
generated by different algorithms, are they considered the same equal or
not? To me, the intuitive answer is "no", but oidhash_by_value() only
considers the hash value and ignores the algorithm altogether! I think
that testing collisions between SHA1 and SHA256 values would be very
useful.

> +/*
> +  These tests are for base assumptions; if they fails, library is broken
> +*/
> +int hash_string_succeeds() {
> +  const char *str = "test_string";
> +  khint_t value = __ac_X31_hash_string(str);
> +  return value == 0xf1a6305e;
> +}
> +
> +int hash_string_with_non_alphabets_succeeds() {
> +  const char *str = "test_string #2";
> +  khint_t value = __ac_X31_hash_string(str);
> +  return value == 0xfa970771;
> +}

For a unit test, it is a best practice to test the external interface
that callers are depending on, and to avoid implementation
details/internals. If we do the latter, we end up with brittle tests
that break on non-important changes. E.g. we definitely should not be
testing the exact value of the hash function. The khash library
maintainer could decide to change the hash function, and we should not
be broken by that.

For khash.h, it appears that that anything prepended with "__" is meant
to be internal, and everything else is external. E.g.
__ac_X31_hash_string is certainly not meant to be used directly by end
users., especially since there's a human-friendly macro for it:

  #define kh_str_hash_func(key) __ac_X31_hash_string(key)

However, because something is external, doesn't mean we need to be
testing its implementation - we still shouldn't be testing the
return value of kh_str_hash_func(). We may want to test certain
_properties_ of the external function (e.g. does it provide good
collision resistance?), but in this case, I think we can trust that what
the library author wrote is a good default.

> +KHASH_INIT(str, const char *, int *, 1, kh_str_hash_func, kh_str_hash_equal);

As mentioned earlier, I think testing oid_[set|map|pos] would be much
more useful, and we should try to demonstrate each of the
macros/functions and how they interact, e.g. if I kh_put_*, I should
expect to be able to kh_get_* afterwards.

> +
> +int initialized_hashmap_pointer_not_null() {
> +  kh_str_t *hashmap = kh_init_str();
> +
> +  if(hashmap != NULL){
> +    free(hashmap);
> +    return 1;
> +  }
> +  return 0;
> +}

I don't think this is a useful test. It would be extremely weird for the
return value to be NULL in regular usage.

> +int put_key_into_hashmap_once_succeeds() {
> +  int ret, value;
> +  khint_t pos;
> +  kh_str_t *hashmap = kh_init_str();
> +  pos = kh_put_str(hashmap, "test_key", &ret);
> +  if(!ret)
> +    return 0;
> +  return pos != 0;
> +}

I don't think it makes sense to only check the return value, we should
check that it had the intended effect - that we can read back the value.
There is a later test that does this, so I'd prefer we remove this.

Comment on the test framework, not the test: I think it makes sense to
assert that "ret" is nonzero, but this "if..return" way of asserting
makes it impossible to tell what has broken. It also adds a lot of
cognitive overhead when trying to parse the assertion. I'll echo Phillip
Wood's comments and say that I think this is definitely not a framework
I want to use.

> +int put_same_key_into_hashmap_twice_fails() {
> +  int first_return_value, second_return_value, value;
> +  khint_t pos;
> +  kh_str_t *hashmap = kh_init_str();
> +  kh_put_str(hashmap, "test_key", &first_return_value);
> +  kh_put_str(hashmap, "test_key", &second_return_value);
> +  return !second_return_value;
> +}

This test seems reasonable.

> +int put_value_into_hashmap_once_succeeds() {
> +  int ret, value = 14;
> +  khint_t pos;
> +  kh_str_t *hashmap = kh_init_str();
> +  pos = kh_put_str(hashmap, "test_key", &ret);
> +  if (!ret)
> +    return 0;
> +  kh_key(hashmap, pos) = xstrdup("test_key");
> +  kh_value(hashmap, pos) = &value;
> +  return *kh_value(hashmap, pos) == value;
> +}

Checking the inserted value makes sense to me I don't really understand
khash.h, but is this the recommended way to get values back? kh_value()
looks like just a small macro around an internal array, so we are just
checking that *&value == value. I would have expected that we would call
kh_get to get "pos", then call kh_value on that.

Also, do we have to kh_put_str("some_key") and then immediately set it
again with kh_key(pos)? That seems odd, and I don't see other callers
doing that all the time.

Since this is the second time I see "if (!ret)", I should ask whether
this is meant as an assertion (checking the correctness of the code), or
for flow control (the code might return either 0 or 1, and I need to
handle both). If it is the former, I think it's unnecessary to
assert on it multiple times. The latter does not belong in a unit test -
we should already _know_ what we want to be returned. Btw, it is a huge
flaw in the test framework that both look exactly the same, so I'll say
again that I really don't like it.

> +int put_same_value_into_hashmap_twice_fails() {
> +  int first_return_value, second_return_value, value = 14;
> +  khint_t pos;
> +  kh_str_t *hashmap = kh_init_str();
> +  pos = kh_put_str(hashmap, "test_key", &first_return_value);
> +  if (!first_return_value)
> +    return 0;
> +  kh_key(hashmap, pos) = xstrdup("test_key");
> +  kh_value(hashmap, pos) = &value;
> +  kh_put_str(hashmap, "test_key", &second_return_value);
> +  return !second_return_value;
> +}

I don't see how this is different from the previous test that tested for
collisions.

> +int get_existing_kv_from_hashmap_succeeds() {
> +  int ret, value =14;
> +  int expected = value;
> +  khint_t pos;
> +  kh_str_t *hashmap = kh_init_str();
> +  pos = kh_put_str(hashmap, "test_key", &ret);
> +  if (!ret)
> +    return 0;
> +  kh_key(hashmap, pos) = xstrdup("test_key");
> +  kh_value(hashmap, pos) = &value;
> +  return *kh_value(hashmap, kh_get_str(hashmap, "test_key")) == expected;
> +}

Isn't this identical to put_value_into_hashmap_once_succeeds()?

Also, this assertion is harder to read than necessary because we have
both "expected" and "value" - the different names suggest that they are
different, but they're really the same. Let's just use one of them.

> +int get_nonexisting_kv_from_hashmap_fails() {
> +  int value = 14;
> +  khint_t pos;
> +  kh_str_t *hashmap = kh_init_str();
> +  return !kh_get_str(hashmap, "test_key");
> +}

Looks reasonable.

> +int deletion_from_hashmap_sets_flag() {
> +  int ret, value = 14;
> +  khint_t pos;
> +  kh_str_t *hashmap = kh_init_str();
> +  pos = kh_put_str(hashmap, "test_key", &ret);
> +  if (!ret)
> +    return 0;
> +  if(!kh_exist(hashmap, pos))
> +    return 0;
> +  kh_key(hashmap, pos) = xstrdup("test_key");
> +  kh_value(hashmap, pos) = &value;
> +  kh_del_str(hashmap, pos);
> +  return !kh_exist(hashmap, pos);
> +}

What is the "flag" being set? If it is the khash-internal flag that
marks that an entry is deleted, that's an unimportant implementation
detail - the important thing is that the value is deleted. Let's just
rename this to "deletion_works" or something.

> +
> +int deletion_from_hashmap_updates_size() {
> +  int ret, value = 14, current_size;
> +  khint_t pos;
> +  kh_str_t *hashmap = kh_init_str();
> +  pos = kh_put_str(hashmap, "test_key", &ret);
> +  if (!ret)
> +    return 0;
> +  kh_key(hashmap, pos) = xstrdup("test_key");
> +  kh_value(hashmap, pos) = &value;
> +  current_size = hashmap->size;
> +  kh_del_str(hashmap, pos);
> +  return hashmap->size + 1 == current_size;
> +}

The interface is kh_size(), so let's use that instead of referencing the
.size member correctly.

> +int deletion_from_hashmap_does_not_update_kv() {
> +  int ret, value = 14, current_size;
> +  khint_t pos;
> +  kh_str_t *hashmap = kh_init_str();
> +  pos = kh_put_str(hashmap, "test_key", &ret);
> +  if (!ret)
> +    return 0;
> +  kh_key(hashmap, pos) = xstrdup("test_key");
> +  kh_value(hashmap, pos) = &value;
> +  kh_del_str(hashmap, pos);
> +  return !strcmp(kh_key(hashmap, pos),"test_key");
> +}

Interesting! If we kh_del_(pos) but read it back with kh_key(), we can
still read it back. This has some implications on how khash should be
used - we should be extremely careful if we pass around a returned value
from kh_get_ or kh_put_ because we don't know if it's deleted or not.
Instead, we should prefer kh_get_(). Very useful demonstration.

> +int update_value_after_deletion_succeeds() {
> +  int ret, value1 = 14, value2 = 15;
> +  khint_t pos1, pos2;
> +  kh_str_t *hashmap = kh_init_str();
> +  // adding the kv to the hashmap
> +  pos1 = kh_put_str(hashmap, "test_key", &ret);
> +  if (!ret)
> +    return 0;
> +  kh_key(hashmap, pos1) = xstrdup("test_key");
> +  kh_value(hashmap, pos1) = &value1;
> +  // delete the kv from the hashmap
> +  kh_del_str(hashmap, pos1);
> +  // adding the same key with different value
> +  pos2 = kh_put_str(hashmap, "test_key", &ret);
> +  if (!ret)
> +    return 0;
> +  kh_key(hashmap, pos2) = xstrdup("test_key");
> +  kh_value(hashmap, pos2) = &value2;
> +  // check if the value is different
> +  return *kh_value(hashmap, kh_get_str(hashmap, "test_key")) == value2;
> +}

Looks reasonable.

> +int hashmap_size_matches_number_of_added_elements() {
> +  int ret, value1 = 14, value2 = 15, value3 = 16;
> +  khint_t pos1, pos2, pos3;
> +  kh_str_t *hashmap = kh_init_str();
> +  pos1 = kh_put_str(hashmap, "test_key1", &ret);
> +  if (!ret)
> +    return 0;
> +  kh_key(hashmap, pos1) = xstrdup("test_key1");
> +  kh_value(hashmap, pos1) = &value1;
> +  pos2 = kh_put_str(hashmap, "test_key2", &ret);
> +  if (!ret)
> +    return 0;
> +  kh_key(hashmap, pos2) = xstrdup("test_key2");
> +  kh_value(hashmap, pos2) = &value2;
> +  pos3 = kh_put_str(hashmap, "test_key3", &ret);
> +  if (!ret)
> +    return 0;
> +  kh_key(hashmap, pos3) = xstrdup("test_key3");
> +  kh_value(hashmap, pos3) = &value3;
> +  return kh_size(hashmap) == 3;
> +}

Looks reasonable.

I would also exercise kh_end, kh_begin, kh_clear, kh_foreach and
kh_foreach_value

kh_destroy might be useful to test too, in case there are oddities
there, but it's probably not that interesting

kh_n_buckets doesn't seem useful to test - it looks too specific to the
impkementation. kh_resize looks like an implementation detail that we
shouldn't test either.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD841F954
	for <e@80x24.org>; Sun, 19 Aug 2018 19:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeHSWxJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 18:53:09 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33566 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeHSWxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 18:53:09 -0400
Received: by mail-qk0-f196.google.com with SMTP id z78-v6so7332978qka.0
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 12:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nHI4SnrQ2pSTi8xPNpxZ5oMIoMppWd0UnagyPZ3VxI=;
        b=NkzqcnuwAnuCY8CuQ6VqTqgEruELQwgBuxqalIgfoGq1P8wxBsujy6lC9rw5/hGqFU
         G4MkHQKZ8/lVxm0Ys8FLnlTNMrFl9Ds94pll1cc87lgs1NPO25MMIssX4eLntakPfQ71
         rrayU+tAxFqmk54cSnqRVUw+UJI0v8QqwJCK4jY3X9ti6vusyKcKK9VuQXVfB2K58jIy
         tOTlRksjXPrgopfi7LvppmqBETAOR0Fv0+Dm/o12CPNrazUnGRhQQPX2ye+TBI7ftuuN
         kemtA3JRsdvR6CfU/t48CGcaGUBolS7JgPszLN+N9ZyG3j3ArLFuAxh6A5E5eE3gEiiI
         iDOQ==
X-Gm-Message-State: AOUpUlGqL+H7Oh3Al3saPGQl8roV9Ih1e6wIR+YuszamqDelbgbhE5US
        E8MKTl1M03qjpRXvowcoBLxkkyyGWN1DjiCMKx0=
X-Google-Smtp-Source: AA+uWPyJbQB9aHWm0q3g9vZWXIIUqJ0a31VmlBnKwPzz08cOszt3jBcoYKnYE2lL837QdG18HnfmaYnXCv1VFBp926A=
X-Received: by 2002:a37:4951:: with SMTP id w78-v6mr39093584qka.2.1534707633346;
 Sun, 19 Aug 2018 12:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180819175351.449973-1-sandals@crustytoothpaste.net> <20180819175351.449973-2-sandals@crustytoothpaste.net>
In-Reply-To: <20180819175351.449973-2-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Aug 2018 15:40:22 -0400
Message-ID: <CAPig+cRZsJ00wNW08-jxmD=aW0V1hJJYEa9EVTMQT4=r0B+jeQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] t: add tool to translate hash-related values
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 19, 2018 at 1:54 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> diff --git a/t/oid-info/oid b/t/oid-info/oid
> @@ -0,0 +1,29 @@
> +# All zeros or Fs missing one or two hex segments.
> +zero_1         sha1:000000000000000000000000000000000000000
> +zero_2         sha256:000000000000000000000000000000000000000000000000000000000000000
> +zero_2         sha1:00000000000000000000000000000000000000
> +zero_2         sha256:00000000000000000000000000000000000000000000000000000000000000

Too many zero_2's. I guess the first one should be zero_1.

> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> @@ -821,6 +821,35 @@ test_expect_success 'tests clean up even on failures' "
> +test_oid_cache hash-info oid
> +
> +test_expect_success 'test_oid_info provides sane info by default' '

Is "test_oid_info" in the test title outdated? I don't see anything by
that name. Same question regarding the other new tests.

> +       test_oid zero &&
> +       test_oid zero >actual &&

If the lookup "test_oid zero" fails, it's going to fail whether
redirected or not, so the first invocation can be dropped.

> +       grep "00*" actual &&

Do you want to anchor this regex? ^00*$

Same comment regarding the other new tests.

> +       test "$(test_oid hexsz)" -eq $(wc -c <actual) &&
> +       test $(( $(test_oid rawsz) * 2)) -eq "$(test_oid hexsz)"
> +'

If $(test_oid rawsz) fails to find "rawsz" and returns nothing, this
expression will be "*2", which will error out in a
less-than-meaningful way. Perhaps it would make more sense to dump the
results of the two test_oid() to file and use test_cmp()?

Similar comment regarding all the other "test ... -eq ..." expressions
here and below: I wonder if it would be better to dump them to files
and compare the files.

> +test_expect_success 'test_oid_info can look up data for SHA-1' '
> +       test_detect_hash sha1 &&
> +       test_oid zero >actual &&
> +       grep "00*" actual &&
> +       test $(wc -c <actual) -eq 40 &&
> +       test "$(test_oid rawsz)" -eq 20 &&
> +       test "$(test_oid hexsz)" -eq 40
> +'
> +
> +test_expect_success 'test_oid_info can look up data for SHA-256' '
> +       test_when_finished "test_detect_hash" &&

Should the previous test also do this test_when_finished() to protect
against someone coming along and re-ordering them some day? Or someone
inserting a test between the two?

> +       test_detect_hash sha256 &&
> +       test_oid zero >actual &&
> +       grep "00*" actual &&
> +       test $(wc -c <actual) -eq 64 &&
> +       test "$(test_oid rawsz)" -eq 32 &&
> +       test "$(test_oid hexsz)" -eq 64
> +'
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -1147,3 +1147,39 @@ depacketize () {
> +test_detect_hash () {
> +       if test -n "$1"
> +       then
> +               test_hash_algo="$1"
> +       else
> +               test_hash_algo='sha1'
> +       fi
> +}

Mmph. Outside of t0000, do you expect other callers which will need to
set the hash algorithm to an explicit value? If not, this sort of
polymorphic behavior adds extra, perhaps unnecessary, complexity. Even
if you do expect a few other callers, a dedicated test_set_hash()
function might be clearer since test_detect_hash() has a very specific
meaning.

> +test_oid_cache () {
> +       test -n "$test_hash_algo" || test_detect_hash
> +       if test -n "$1"
> +       then
> +               while test -n "$1"
> +               do
> +                       test_oid_cache <"$TEST_DIRECTORY/oid-info/$1"

What is the benefit of placing test-specific OID info in some
dedicated directory? I suppose the idea of lumping all these OID files
together in a single oid-info/ directory is that it makes it easier to
see at a glance what needs to be changed next time a new hash
algorithm is selected. However, that potential long-term benefit comes
at the cost of divorcing test-specific information from the tests
themselves. I imagine (for myself, at least) that it would be easier
to grok a test if its OID's were specified and cached directly in the
test script itself (via test_oid_cache <<here-doc). I could even
imagine a test script invoking test_oid_cache<<here-doc before each
test which has unique OID's in order to localize OID information to
the test which needs it, or perhaps even within a test.

So, I'm having trouble understanding the benefit of the current
approach over merely loading OID's via here-docs in the test scripts
themselves. Perhaps the commit message could say something about why
the current approach was taken.

> +                       shift
> +               done
> +               return $?

Why, specifically, return $? here, as opposed to simply returning?

> +       fi

Mmph. This polymorphic, recursive behavior in which test_oid_cache()
can load data from a list of files or from its own standard input adds
complexity. One alternative would be to have a separate
test_oid_cache_file() function. However, I'm wondering why such
functionality needs to be built in, in the first place, as opposed to
clients merely doing the redirect themselves (test_oid_cache
<whatever). I see that you want to support specifying multiple files
for a single invocation, but is that likely to come up (aside from
t0000)?

> +       while read _tag _rest
> +       do
> +               case $_tag in \#*)
> +                       continue;;
> +               esac

This handles "# comment" lines, but what about blank lines?

> +               _k="${_rest%:*}"
> +               _v="${_rest#*:}"

Should this be doing any sort of validation, such as complaining if _k
or _v is empty? Or if _k contains weird characters?

> +               eval "test_oid_${_k}_$_tag=\"$_v\""
> +       done
> +}
> +
> +test_oid () {
> +       eval "printf '%s' \"\${test_oid_${test_hash_algo}_$1}\""
> +}

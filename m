Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FA8C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 18:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E39A42076E
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 18:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJw8B0Pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgKKSfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 13:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbgKKSff (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 13:35:35 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9ECC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 10:35:33 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id m143so3280920oig.7
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 10:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqa3XklvXygcUwJ971nmpkFzJwBiGdth2dfnFJsrc4I=;
        b=uJw8B0PrsQC2w9AdZaNirzZ5lAfcXJuzeoi166gKonI4FK4aLFftXf1MqdvJgr/QFL
         otw7C8MGsxGbs5wfvJ02MyvjZNz/UIAVqd5idwbVFZq/GlnyKG0vOUG2cHuzafj00CyM
         ft/8WezcPWv2meqpY3nMAzt54z0GgUi1TcP1A9G8gprd8jmaWZ43Opg9bslSy+Uj78UX
         F+BE83KHLPmXLvfVI5c7qFuCKFSTDk3V/F7mQJO6VQujcqy0UuLquJ+wqMYUi0QQgofL
         X3kWzqxNzNfKru7DFZGkrSbAlZHOVOdQcFC3gGZ9fqNxTsAbMa8XECtJkX79bhzP56xk
         W+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqa3XklvXygcUwJ971nmpkFzJwBiGdth2dfnFJsrc4I=;
        b=RNVmtdKpbWq1l4AuMVzLpNPmVxBzs7hZyivdS9hLJzWA9XGDVW+Y+5lHGSYmhNQm3n
         3shLMJctHNgHfLRDJLSmFWFNReyinJZjyR4gebe0zNN/HNVOkn1IuuM9ijFdTr/Soj9F
         q4CiUitNpxDaPGMK/DyeH/4nIRk2HlvBaj9ngfiRNxuCr7gA9I6vGMilWuNm6LdojiQP
         GBdRR/bYWSdtynbm2G8MwlTDJLl11fUHtm5DC6SGMTbOjpXujzz30OG4+sglC+1+bvIz
         w0jDvGAxK81jM69axhv3LxHYn8nIN/j4SLyw7G3SYGQtzoZsK9e8pBfRkca4ITOFnf/Q
         fNVA==
X-Gm-Message-State: AOAM531trXJiUOHc7EskzrNLpmWX+rvckWWBxPQ0fApQAZnZ58Kg+oHZ
        zlAX2LiMAeN4O1UqTXhIscbL3EG04vvbpqU57XCbqH72uEJ8bg==
X-Google-Smtp-Source: ABdhPJz4/l+8vVN/S1SXPsUfygw01DD6gie7ncFxMMUoiyLob2AAMRIhXjJ6GhzA2QMnSO4GTpnDQKHKM5U9JrHAcik=
X-Received: by 2002:aca:b4d7:: with SMTP id d206mr3159148oif.39.1605119732750;
 Wed, 11 Nov 2020 10:35:32 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-1-newren@gmail.com> <75170ee7-525e-31fc-f6bd-6dfac12b00c8@gmail.com>
In-Reply-To: <75170ee7-525e-31fc-f6bd-6dfac12b00c8@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Nov 2020 10:35:21 -0800
Message-ID: <CABPp-BF=+-ieP8fCxWWuvhe2dTTMKVGnYSTJuV6H9Z+zYs0SNg@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] fundamentals of merge-ort implementation
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 9:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/2/2020 3:43 PM, Elijah Newren wrote:
> > Elijah Newren (20):
> >   merge-ort: setup basic internal data structures
> >   merge-ort: add some high-level algorithm structure
> >   merge-ort: port merge_start() from merge-recursive
> >   merge-ort: use histogram diff
> >   merge-ort: add an err() function similar to one from merge-recursive
> >   merge-ort: implement a very basic collect_merge_info()
> >   merge-ort: avoid repeating fill_tree_descriptor() on the same tree
> >   merge-ort: compute a few more useful fields for collect_merge_info
> >   merge-ort: record stage and auxiliary info for every path
> >   merge-ort: avoid recursing into identical trees
> >   merge-ort: add a preliminary simple process_entries() implementation
> >   merge-ort: have process_entries operate in a defined order
>
> I got this far before my attention to detail really started slipping.
>
> >   merge-ort: step 1 of tree writing -- record basenames, modes, and oids
> >   merge-ort: step 2 of tree writing -- function to create tree object
> >   merge-ort: step 3 of tree writing -- handling subdirectories as we go
> >   merge-ort: basic outline for merge_switch_to_result()
> >   merge-ort: add implementation of checkout()
> >   tree: enable cmp_cache_name_compare() to be used elsewhere
> >   merge-ort: add implementation of record_unmerged_index_entries()
> >   merge-ort: free data structures in merge_finalize()
>
> I'll try to take another pass on these commits tomorrow.
>
> For the series as a whole I'd love to see at least one test that
> demonstrates that this code does something, if even only for a very
> narrow case.
>
> There's a lot of code being moved here, and it would be nice to have
> even a very simple test case that can check that we didn't leave any
> important die("not implemented") calls lying around or worse accessing
> an uninitialized pointer or something.

We absolutely left several die("not implemented") calls lying around.
The series was long enough at 20 patches; reviewers lose steam at 10
(at least both you and Jonathan have), so maybe I should have left
even more in there as an attempt to split up this series more.

However, if you run the testsuite with GIT_TEST_MERGE_ALGORITHM=ort,
then this series drops the number of failures in the testsuite from
around 2200, down to 1500.  So, there's about 700 testcases for you.

Also, there were several preparatory series all designed for getting
the testsuite in order for this new merge algorithm.  See the
following currently cooking topics:
  * en/merge-tests topic
  * en/dir-rename-tests
and the following topics that were previously merged:
  * 36d225c7d4 ("Merge branch 'en/merge-tests'", 2020-08-19)
  * cf372dc815 ("Merge branch 'en/test-cleanup'", 2020-03-09)
  * ac193e0e0a ("Merge branch 'en/merge-path-collision'", 2019-01-04)
  * c99033060f ("Merge branch
'en/t7405-recursive-submodule-conflicts'", 2018-08-02)
  * e6da45c7cd ("Merge branch 'en/t6036-merge-recursive-tests'", 2018-08-02)
  * 84e74c6403 ("Merge branch
'en/t6042-insane-merge-rename-testcases'", 2018-08-02)
  * bba1a5559c ("Merge branch 'en/t6036-recursive-corner-cases'", 2018-08-02)
  * 93b74a7cfa ("Merge branch 'en/merge-recursive-tests'", 2018-06-25)
and maybe others I missed.

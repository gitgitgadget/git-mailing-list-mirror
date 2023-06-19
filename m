Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DA2EB64D9
	for <git@archiver.kernel.org>; Mon, 19 Jun 2023 16:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjFSQ5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jun 2023 12:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjFSQ5U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2023 12:57:20 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B254E7C
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 09:57:17 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-763aba072b9so2715285a.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687193836; x=1689785836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+G410xd3ubuOzyOLzUs8NUkUJDOILq0NwW0v90JdjA=;
        b=sphFe6XPYQylxp7GE4KrNtzAPHG4acW0dBj6QlKYEbvhB9GS1oa0OeW3ngCLwoyH4G
         tr8grTUB6cD3Vmpib/q3q7YwYGgeV4NRSQAN3r2BDGliG0bbyT1DmnyGGyqogYaa0R/M
         2ozKvPnLcZU7nTq8k9V747X93HJb1AMIjPZ4Erx7VqinJPj8nAnjL0FkXkb8Fc29DGie
         U028TR/ss3Uyzy0ZftoaY/kI9GvwduYwfbNckVVatzYBJdVUk7UmLrNVlM1hLXPc0DSM
         YmKi7vx3JIWsIaHI5O4mNEtVMhuMGjQKkJwGq+DTzWDz3pkXcrl+XmBR2O7SJKNZKilS
         9s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687193836; x=1689785836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+G410xd3ubuOzyOLzUs8NUkUJDOILq0NwW0v90JdjA=;
        b=any/xB3sWmfOGraSvGX/77YH5Fw+2sOLT7ktikAP7EV/EcB5inzubBznceV2jkAiDK
         IpGb4GcOaMXCtXuI9VgW09jTdbSDlCTq4bh4fpaAa5HDPnzGhzpCR/D0HkoeuyX7umda
         9mvXcL+2TCaeekRKD9ouZ3G4SnFsuSuSHBWRARah5ZbVg8/YTew1qJ9xscGN+cBL3JYB
         OSyajmgPUNyW0k0h09YaYalb0POwbOfmdlbmtTh4ORK8XeZVipWN+q94yLMQVQOpWcHF
         eUQbnPvvtjr13cBoDpXj9e4vnX80JnEOu69Eg8HMlnQ/YtZETqpatFYoQEhkSJDH7jH8
         t6oQ==
X-Gm-Message-State: AC+VfDzrqLj5Pm327jWA1biBfy9a0iS0zOeRt9TCvmPiN7IbQeGq7hJ5
        V6ZN0vKNFxVopHXp6Q44mkp9eA==
X-Google-Smtp-Source: ACHHUZ7gQVkuIqejHIaTjjVkw5sOJ/2YN3B/Ib76UVUNxO3hY0ESwQVmn5rQn+mLpBa+OT8lF9sonA==
X-Received: by 2002:a05:620a:480c:b0:75b:23a1:833d with SMTP id eb12-20020a05620a480c00b0075b23a1833dmr10633650qkb.56.1687193836309;
        Mon, 19 Jun 2023 09:57:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l64-20020a0dc943000000b0056ffdec590csm49779ywd.41.2023.06.19.09.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:57:15 -0700 (PDT)
Date:   Mon, 19 Jun 2023 12:57:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2023, #04; Wed, 14)
Message-ID: <ZJCI6FHtbuOKPlV1@nand.local>
References: <xmqqedmdwput.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedmdwput.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I am back from a week off, and wanted to give an update on the status of
my outstanding topics. I'll be off next week, too, and then back on July
5th onward.

I plan on getting all of the ones with outstanding review comments
replied to and/or rerolled tomorrow.

On Wed, Jun 14, 2023 at 05:06:50PM -0700, Junio C Hamano wrote:
> * tb/pack-bitmap-index-seek (2023-03-20) 6 commits
>  - pack-bitmap.c: factor out `bitmap_index_seek_commit()`
>  - pack-bitmap.c: use `bitmap_index_seek()` where possible
>  - pack-bitmap.c: factor out manual `map_pos` manipulation
>  - pack-bitmap.c: drop unnecessary 'inline's
>  - pack-bitmap.c: hide bitmap internals in `read_be32()`
>  - pack-bitmap.c: hide bitmap internals in `read_u8()`
>
>  Clean-up the pack-bitmap codepath.
>
>  Kicked back to 'seen' out of 'next'.
>  There is a BUG() on data errors that needs to be fixed.
>  source: <cover.1679342296.git.me@ttaylorr.com>

Let's discard this one for now. It's not super high up on my to-do list
and it's not worth the burden of carrying in 'seen'.

> * tb/collect-pack-filenames-fix (2023-06-12) 1 commit
>  - builtin/repack.c: only collect fully-formed packs
>
>  Avoid breakage of "git pack-objects --cruft" due to inconsistency
>  between the way the code enumerates packfiles in the repository.
>
>  Will merge to 'next'?
>  source: <20230607101617.ges6tnMry4E52lDGld43QgtNUsIS4YQq6w-t71hEfkQ@z>

Yes, this one is ready to go (and has been running at GitHub for a week
or so, for what that's worth ;-)).

> * tb/open-midx-bitmap-fallback (2023-06-12) 1 commit
>  - pack-bitmap.c: gracefully degrade on failure to load MIDX'd pack
>
>  Gracefully deal with a stale MIDX file that lists a packfile that
>  no longer exists.
>
>  Will merge to 'next'.
>  source: <f123b68cb8a277fbf105b1789a84b9405a499b79.1686178854.git.me@ttaylorr.com>

Thanks. I am somewhat embarrassed to have not caught that when writing
it, but better late than never.

> * tb/submodule-null-deref-fix (2023-05-25) 1 commit
>   (merged to 'next' on 2023-06-13 at 5eb6a7948d)
>  + builtin/submodule--helper.c: handle missing submodule URLs
>
>  "git submodule" code trusted the data coming from the config (and
>  the in-tree .gitmodules file) too much without validating, leading
>  to NULL dereference if the user mucks with a repository (e.g.
>  submodule.<name>.url is removed).  This has been corrected.
>
>  Will merge to 'master'.
>  source: <ae6cf3fa461b85e346f034371dae56a2790dfa20.1684957882.git.me@ttaylorr.com>

Thanks for picking this one back up post-release.

> * tb/refs-exclusion-and-packed-refs (2023-06-12) 16 commits
>  - ls-refs.c: avoid enumerating hidden refs where possible
>  - upload-pack.c: avoid enumerating hidden refs where possible
>  - builtin/receive-pack.c: avoid enumerating hidden references
>  - refs.h: let `for_each_namespaced_ref()` take excluded patterns
>  - refs/packed-backend.c: ignore complicated hidden refs rules
>  - revision.h: store hidden refs in a `strvec`
>  - refs/packed-backend.c: add trace2 counters for jump list
>  - refs/packed-backend.c: implement jump lists to avoid excluded pattern(s)
>  - refs/packed-backend.c: refactor `find_reference_location()`
>  - refs: plumb `exclude_patterns` argument throughout
>  - builtin/for-each-ref.c: add `--exclude` option
>  - ref-filter.c: parameterize match functions over patterns
>  - ref-filter: add `ref_filter_clear()`
>  - ref-filter: clear reachable list pointers after freeing
>  - ref-filter.h: provide `REF_FILTER_INIT`
>  - refs.c: rename `ref_filter`
>
>  Enumerating refs in the packed-refs file, while excluding refs that
>  match certain patterns, has been optimized.
>  source: <cover.1686134440.git.me@ttaylorr.com>

Thanks for your review on this one. I am just getting back from a week
of vacation (and then off again next week, then back in early July). I
had intended to respond to your review today, but I didn't quite get to
it today.

On my list for tomorrow, hopefully the rerolled version should be ready
to pick up.

> * tb/gc-recent-object-hook (2023-06-12) 2 commits
>  - gc: introduce `gc.recentObjectsHook`
>  - reachable.c: extract `obj_is_recent()`
>
>  "git pack-objects" learned to invoke a new hook program that
>  enumerates extra objects to be used as anchoring points to keep
>  otherwise unreachable objects in cruft packs.
>
>  Will merge to 'next'.
>  source: <cover.1686178684.git.me@ttaylorr.com>

Thanks.

> * tb/pack-bitmap-traversal-with-boundary (2023-05-08) 3 commits
>  + pack-bitmap.c: use commit boundary during bitmap traversal
>  + pack-bitmap.c: extract `fill_in_bitmap()`
>  + object: add object_array initializer helper function
>  (this branch is used by ds/disable-replace-refs.)
>
>  The object traversal using reachability bitmap done by
>  "pack-object" has been tweaked to take advantage of the fact that
>  using "boundary" commits as representative of all the uninteresting
>  ones can save quite a lot of object enumeration.
>
>  Will merge to 'next'.
>  source: <cover.1683567065.git.me@ttaylorr.com>

Thanks on this one, too.

Thanks,
Taylor

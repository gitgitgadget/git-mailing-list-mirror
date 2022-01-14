Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3E9C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 18:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbiANSXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 13:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiANSXC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 13:23:02 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86587C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 10:23:02 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w16so36942108edc.11
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 10:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rxU4EW1VMzFJ5UY6SYmAe92SZmp1+GcRVR0RjQfUKUU=;
        b=LoIMOhNxmkbMuJoCLJVIlJj1iJt7qJAx8FSGGx5UUbXC/pRLwGYrrXp19vZ4N9dv7K
         iRB+rRm488H4Iwr5oRHOVLycSJ8FZsswwl5n2Vk+wQySr9YQ6wRr0g4JgfSS0mW+kHeG
         dlLSp+RvDKoUYdqfhmz7AfF/cbNAWIBd0jgOXJ6/q6OSVaIOu2g4yGsdrUjfOdzyJJMa
         RS2VZbGqgUAbfpoRkVy3pJ24F1JBMtb7WxtgbZ9YtKvh9solJhBBF4Vzt6xuyEMDz0lZ
         fMDAtPzoA5jQ3hbEdmeqFUD85ZOKturL7g3IaSq397vsafA515zke76kcDNNhmY66ZuC
         DRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rxU4EW1VMzFJ5UY6SYmAe92SZmp1+GcRVR0RjQfUKUU=;
        b=de2DVhObCL1N7QzhseQDE4OgiFJRYomGBfNi7xGUe0ObIaYFXrIhaoX29y51mNA3iR
         4q9U5ctuKf/m6uwyiQ5WfqxyTOTKvtt4sMfRtmEX69he/aSyJF0qYy+wUMkGfnaQDs63
         M+A+XABdVDakaenPgv3K4c2HD7V+/g8RaCuzRtZT41hA44BQaykES/UknEmZdC7ShiKJ
         5LYVvd5aagkueyOAnOVbm1BWRpbQ7kvZ7FZrint0hbzTuf/yd+IvWjl0UcoYKhdU5/LL
         99EdVikrk7pdDfWmQp5tvumXCknYbC6kqb6XY2PbsnEQlvHeyJgnxnGkovGRxIicg6Fy
         4upg==
X-Gm-Message-State: AOAM531ZifZUTdoQcfZAxVX2fNKzVtY0TXa5Sgw5AsncLeeQ7qUMW/Aa
        b9y3QE7n8OaSOj4PkOCuCHDfXu8UwJo=
X-Google-Smtp-Source: ABdhPJzB7jDaOYEMQ6xiOjmC3WWnEbhu7nOgogboCubImD0xUcHoXb+5Fh4u3bpuI2ksFfi6fm7vxg==
X-Received: by 2002:a17:906:c156:: with SMTP id dp22mr7985703ejc.283.1642184580970;
        Fri, 14 Jan 2022 10:23:00 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g11sm2614944edq.46.2022.01.14.10.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 10:23:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8RE3-001CDi-VR;
        Fri, 14 Jan 2022 19:22:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking in git.git (Jan 2022, #03; Thu, 13)
Date:   Fri, 14 Jan 2022 19:12:15 +0100
References: <xmqq35lrf8g4.fsf@gitster.g> <xmqqk0f3dk5o.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqk0f3dk5o.fsf@gitster.g>
Message-ID: <220114.86fspqrxbw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> There are a few "oops, what we merged recently is broken" topics
>> that still are not in 'master', but otherwise what we have should
>> be pretty much what we'll have in the final one.
>>
>>  - I am reasonably happy with ab/refs-errno-cleanup (just one patch)
>>    that fixes the incorrect state of the code left by the earlier
>>    parts of the topic that have already been merged during this
>>    cycle.
>>
>>  - I am also OK with ab/reftable-build-fixes (two patches), one for
>>    general type correctness fix, the other for helping older sub-C99
>>    compilers.
>>
>> If there are fixes for regressions that we introduced during this
>> cycle other than these two topics, I certainly am missing them, so
>> please holler loudly and quickly, hopefully in time for me to tag
>> the -rc1 tomorrow.
>
> Oh, by the way, the tip of 'seen' has consistently failing the
> leak-check test.  I didn't have chance, time or energy to see if
> they are failing merely because an existing test script that used to
> be leak-clean gained a use of command that has been known to be
> leak-unclean without introducing any new leaks, or our recent change
> did introduce new leaks to commands that have been leak-clean.
> Somebody with too much time on their hand should go in and check to
> help, before CI testing on 'seen' becomes useful again.

It's a regression in
ps/avoid-unnecessary-hook-invocation-with-packed-refs, Patrick could you
look into it? On your current "seen" doing a:

    git revert -m 1 48b388cbf31

Will make those 3x failing tests pass:
https://github.com/git/git/runs/4811683950?check_suite_focus=true

(That commit being: 48b388cbf31 (Merge branch
'ps/avoid-unnecessary-hook-invocation-with-packed-refs' into seen,
2022-01-13))

I didn't have much time to look now, but this mostly untested fix-up
fixes up the topic under SANITIZE=leak (but may break something else). I
ran the broken tests with SANITIZE=leak, and the normal tests without
SANITIZE=leak, but didn't have time for further testing:

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index ff96ee482a0..b8012f97009 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1577,6 +1577,7 @@ int packed_refs_delete_refs(struct ref_store *ref_store,
                        error(_("could not delete references: %s"), err.buf);
        }
 
+       ref_transaction_free(transaction);
        strbuf_release(&err);
        return ret;
 }

I.e. the moving around of the ref_transaction_free() is at fault
somehow, probably...

Junio: Is there something you're doing to hide
https://github.com/gitster/git/actions ? My version of that is visible
without being logged-in, but yours is a 404 (maybe it needs to be set
up?)

If CI is setup to run on your topic push-outs it'll become easier both
for you & others to see what topics in "seen" may be broken. Usually it
would be a matter of browsing the page of pushed-out topics for failures
(except in cases where the merger causes the faulure...)

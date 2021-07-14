Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92A6C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 02:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C566136E
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 02:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbhGNCzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 22:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbhGNCzR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 22:55:17 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D5EC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 19:52:25 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id r16so98188ilt.11
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 19:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gQlttY/o7DsSLC139HHdIPCwLJaPrqmG8paUnfThR+U=;
        b=nmvZwJXhKagomlNhi5EvkJtRLwqIiJUu+7aSg9/YZqeVxUW+PiQIiEnRgZ4l2IQ2XD
         aQDimp0jxscK9eV6YBIHWMxUgUmbsVYpr8enp0dqairWwbH76MMoMjtYc7m51f6ofV+K
         XHInUn7tzWbIRvzUi5Aa2UGIpN737QXkEvURfBBcNi6JM/bnAGu994PKbPUUYWM3WTrb
         wycX/s2kOXRHHP1E0/4TNM7zeehBYyYCNCMtXKK+ZQNKxB9Djj1IZgr7YVoB8ClvJvM7
         08GMgUXwf/+PyK4/23SuvvbkJCNhbs0Zb/Y6q9BLQ6xzTwvaDzcRkvxDaYq0Y7FcQs61
         EM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gQlttY/o7DsSLC139HHdIPCwLJaPrqmG8paUnfThR+U=;
        b=c/5SBqOcqjDjC/dfoatbwpjWtGTpJxdj6M1wwSZvQSPbzfMNLppZEIylvqohKU2Wf4
         ozZsThwuasVBKbpwHh+qdf9U8ibANGVBZE451mJzvx5kufyiXyW6Z+wrQc7t4W6rZ+Sw
         +HkM50Vszj9ioePtH4EvDxcW7BsjVLb8iPDjOrQrhf/vwj4jREuo32WwA4TtqlB/cXzt
         ey0zgN04svJ2zTcB+YLtS6dsNyy1H374vAoS/xHjKtSxuRwOzl3he8KYvPAqDgmdriYj
         9/1dxZUUWF7MtkJM7QOwq82jbRzcGp3GMVpEjBeJFLoibs7weN3lH0lMTEDp16KOCbA5
         38lA==
X-Gm-Message-State: AOAM533XdQz+/QZ9egmNdE5vbhyI5cMLVMFBZE8jm8SNgJuWiUIsUMvs
        +kGBt3zT1Zbacel8b71y9wlMFw==
X-Google-Smtp-Source: ABdhPJxUNP/RqgT2yFgPC7wesCumslcW1nZXBVm7qADAvg+jv7CTUzSerVoqSSmPLwFkgLVYRn5aQw==
X-Received: by 2002:a92:c64a:: with SMTP id 10mr5165532ill.159.1626231144866;
        Tue, 13 Jul 2021 19:52:24 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:3a49:b835:9d82:9993])
        by smtp.gmail.com with ESMTPSA id b21sm422568iot.35.2021.07.13.19.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 19:52:24 -0700 (PDT)
Date:   Tue, 13 Jul 2021 22:52:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sun Chao <16657101987@163.com>
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
Message-ID: <YO5RZ0Wix/K5q53Z@nand.local>
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <87wnpt1wwc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnpt1wwc.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 03:39:18AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Hrm, per my v1 feedback (and I'm not sure if my suggestion is even good
> here, there's others more familiar with this area than I am), I was
> thinking of something like a *.bump file written via:
>
>     core.packUseBumpFiles=bool
>
> Or something like that, anyway, the edge case in allowing the user to
> pick arbitrary suffixes is that we'd get in-the-wild user arbitrary
> configuration squatting on a relatively sensitive part of the object
> store.
>
> E.g. we recently added *.rev files to go with
> *.{pack,idx,bitmap,keep,promisor} (and I'm probably forgetting some
> suffix). What if before that a user had set:
>
>     core.packMtimeSuffix=rev

I think making the suffix configurable is probably a mistake. It seems
like an unnecessary detail to expose, but it also forces us to think
about cases like these where the configured suffix is already used for
some other purpose.

I don't think that a new ".bump" file is a bad idea, but it does seem
like we have a lot of files that represent a relatively little amount of
the state that a pack can be in. The ".promisor" and ".keep" files both
come to mind here. Some thoughts in this direction:

  - Combining *all* of the pack-related files (including the index,
    reverse-index, bitmap, and so on) into a single "pack-meta" file
    seems like a mistake for caching reasons.

  - But a meta file that contains just the small state (like promisor
    information and whether or not the pack is "kept") seems like it
    could be OK. On the other hand, being able to tweak the kept state
    by touching or deleting a file is convenient (and having to rewrite
    a meta file containing other information is much less so).

But a ".bump" file does seem like an awkward way to not rely on the
mtime of the pack itself. And I do think it runs into compatibility
issues like Ævar mentioned. Any version of Git that includes a
hypothetical .bump file (or something like it) needs to also update the
pack's mtime, too, so that old versions of Git can understand it. (Of
course, that could be configurable, but that seems far too obscure to
me).

Stepping back, I'm not sure I understand why freshening a pack is so
slow for you. freshen_file() just calls utime(2), and any sync back to
the disk shouldn't need to update the pack itself, just a couple of
fields in its inode. Maybe you could help explain further.

In any case, I couldn't find a spot in your patch that updates the
packed_git's 'mtime' field, which is used to (a) sort packs in the
linked list of packs, and (b) for determining the least-recently used
pack if it has individual windows mmapped.

Thanks,
Taylor

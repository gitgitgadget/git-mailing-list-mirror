Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAA5C35DE1
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 12:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3147E218AC
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 12:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CztyLv4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgBYMKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 07:10:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44974 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgBYMKr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 07:10:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id q8so13714081ljj.11
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 04:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Hx7HYN6xUynO5vLWUyFVIm76SJEZHkP5bWUMJyZj/30=;
        b=CztyLv4rxZC7d/obcO28+OrYgABE/cdWHyKrrMqepjMFuD1trqRWJIUvllYJJ8HXAD
         Z6qWLNPy5wi/B6w5dAKyRvECfdHhiPiAVzyBwQR3hqGtNV5HeKNOKFAtKDuA4XJLErEh
         sUX+mFSAQ50OZSU2NpRhi10l8Ye7IJHxs5vH0Bt5UHS9XoYzg4IKW7X6PSGy1UCXpbiT
         6XUy5KtG8wVfsykOHxnm8xSYl749scxXvRqZh8ajOXtIHDLP/eAltoS1u6/capmHdFnk
         I3r52YrLhFUCGMhyky/aD9vl4Ba4DE6V9pA7vaLJkzzUhUZx6UL3cC/bxoUTBbfITjmv
         tDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Hx7HYN6xUynO5vLWUyFVIm76SJEZHkP5bWUMJyZj/30=;
        b=RtUpHgeQBFqsPZeZHlCakoAeUVc2xkbMYO61is9cp8pmj7UyvXZOGmxUjGd0pNAcog
         Nvk4Sd8Egoppra+3Plh2FJBwbBHoL7Eh9sLTZSjMQwQjBRcSxstAcAddggh6sapN+aVU
         frA7DIjFm2yOPgpV6N5+ff+vW/Oib8cfKbmo1dRzk+NN1tvfKfGTsBK8JI083AgBLxAA
         u/JD4qwaT3UdR4sykbcVy5i5hX9yk3ZvCSpd1zvGP6c8gaKexmxXmhfnApp16vOgj02z
         Yb1TGNYefd/kvL+km5XDzdsgi0FkDnVCECzlfnR3CtuAQKFeKBRJY7WFOi+SJZJnuQEJ
         8heA==
X-Gm-Message-State: APjAAAUoIUe7kbzPWktXzsQhIA3h5/pqWqmfKuTfw3O5MlyrgJHMHXAA
        WR7Cu0rzvnAAEpE6vuyHlPY=
X-Google-Smtp-Source: APXvYqxbOYFjSSWIn5KGXPYtNlTWuPYTeL8xk9uJ6wyiItCDFJjwRDknOg46X2yAxQi2rnMo5FDMYQ==
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr8069312ljj.253.1582632644514;
        Tue, 25 Feb 2020 04:10:44 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 ([158.75.53.82])
        by smtp.gmail.com with ESMTPSA id v7sm7737244ljd.12.2020.02.25.04.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Feb 2020 04:10:43 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Garima Singh <garimasigit@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 09/11] commit-graph: add --changed-paths option to write subcommand
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <3d7ee0c96955dc15c87d04982d8cdec8b62750b2.1580943390.git.gitgitgadget@gmail.com>
        <86y2sxdmw9.fsf@gmail.com>
        <56150788-c477-5526-2d6d-e9325ccb4da6@gmail.com>
Date:   Tue, 25 Feb 2020 13:10:41 +0100
In-Reply-To: <56150788-c477-5526-2d6d-e9325ccb4da6@gmail.com> (Garima Singh's
        message of "Mon, 24 Feb 2020 16:51:48 -0500")
Message-ID: <86fteyc1fi.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garima Singh <garimasigit@gmail.com> writes:
> On 2/20/2020 3:28 PM, Jakub Narebski wrote:
>> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

[...]
>>> --- a/Documentation/git-commit-graph.txt
>>> +++ b/Documentation/git-commit-graph.txt
>>> @@ -54,6 +54,11 @@ or `--stdin-packs`.)
>>>  With the `--append` option, include all commits that are present in the
>>>  existing commit-graph file.
>>>  +
>>> +With the `--changed-paths` option, compute and write information about=
 the
>>> +paths changed between a commit and it's first parent. This operation c=
an
>>> +take a while on large repositories. It provides significant performanc=
e gains
>>> +for getting history of a directory or a file with `git log -- <path>`.
>>> ++
>>=20
>> Should we write about limitation that the topmost layer in the split
>> commit graph needs to be written with '--changed-paths' for Git to use
>> this information?  Or perhaps we should try (in the future) to remove
>> this limitation?
>
> Given that this information is going to be used best effort, it would be=
=20
> superfluous to describe every case and conditional that decides whether=20
> this information is being used.

I can somewhat agree with this reasoning.

However what I would like to avoid is surprising users.  If one creates
base commit-graph with Bloom filters data, but then when creating
new layer of commit-graph (updating it incrementally), it may be
surprising that `git log -- <path>` is now much slower.

On the other hand if one would update commit-graph in a non-incremental
way (rewriting the commit-graph file), loosing the Bloom filter
information and performance of `git log -- <path>` because one forgot to
include `--changed-paths` is not that unexpected.

Anyway, in the future when this mechanism will be controlled by
appropriate config variable, this whole discussion would become somewhat
moot.


Thought for the future: perhaps `git commit-graph verify` could detect
that split graph has Bloom filters only for some layers, and inform the
user?  But that is almost certainly out of scope of this patch series.

>>> @@ -143,6 +146,8 @@ static int graph_write(int argc, const char **argv)
>>>  		flags |=3D COMMIT_GRAPH_WRITE_SPLIT;
>>>  	if (opts.progress)
>>>  		flags |=3D COMMIT_GRAPH_WRITE_PROGRESS;
>>> +	if (opts.enable_changed_paths)
>>> +		flags |=3D COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
>>>=20=20
>>>  	read_replace_refs =3D 0;
>>=20
>> All right.  This actually turns on calculation Bloom filters for changed
>> paths, thanks to
>>=20
>>  	ctx->changed_paths =3D flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : =
0;
>>=20
>> that was added by the "[PATCH v2 04/11] commit-graph: compute Bloom
>> filters for changed paths" patch.
>>=20
>> Though... should this enabling be split into two separate patches like
>> this?
>
> The idea is that in 4/11 We compute only if the flag is set.=20
> And between that patch and this one: we prepare the foundational code=20
> that is now ready for that flag to be set via an opt-in by the user.=20

All right.

Choosing how to split large change into series is not easy.  One one
hand one would want for each change to be small and self contained.  On
the other hand it would be good if each change was testable (test-tool
can help here).

Best,
--=20
Jakub Nar=C4=99bski

Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E7EC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 07:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5127320578
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 07:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm+Ycj0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgHYHdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgHYHda (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 03:33:30 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09460C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 00:33:30 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y26so5588819lfe.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 00:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hM17SeJwMEcUmTJpkd1NiW5lBGL4kgmkO2QG/WYO4M4=;
        b=fm+Ycj0+/r6kQDVWIFdGs5lfYVKYEvVUPxqf1HeKkob4ZUkXQRjC86PeKVcS2CIMK6
         +Rq+cjNc/iHNesI15aCeuysvkABwKWIdYyezeRfLaXiUsgVMLllnPOcgSH+UHUGgSf/p
         kY7FZDl4F3kK2OWs2N3F0qnGfUlnwNMRhXptGQ01w97rXfkYOuy8kpwUD/+t3HtMPyEL
         D2LC0Virvus+VUUGtf1dVOpIoySj0rxZbntg7pLrbTrmkfV/ymTmnCpxhVF9QI9aNNco
         IQr7tCogxLsCsb71L1TAgbjDroc4LdenPqdk5eGN6q9FTje+YlbgMsvZH87s6Z20L9Iu
         E5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=hM17SeJwMEcUmTJpkd1NiW5lBGL4kgmkO2QG/WYO4M4=;
        b=AONy/EO0KHXc8MA3hsBPFcoWYqJO0le/wHafhDxnkccXWya6eBKbsMTbhoN/Rd4AnG
         CDW+eWmUGzzvbCf6Wl8G3bTgDhbxDJOA9RQFIhnxtQ8/gmHzm/tRRuNj9uoNvwNQpu6i
         g2uD4bGJd6zWluW2XxoFaBB0vQJwl7k4ZritvSUtwlacvqFChPL4cscLOrLvioUYvWgN
         d4hk0QrP4tLPdtu89sUXz57zCRmqh1pjDJF18MxMh34jEY7YIGgngVNOUXnlcS7z8t63
         rUI9dSqNgYdQmYKdpA+SjmmIVW3SL2jvOdcaET4pLN9txx5nzP34Vn1zwUKdLWQ51NEP
         Ja2w==
X-Gm-Message-State: AOAM531iLW/J0NtVQoeTRENMoukSWEiJCzr9+9EWMgJOZEWNeILIQfQm
        RwimwUMYwBNaYQghiqzGWIW9DzG3E6mAkg==
X-Google-Smtp-Source: ABdhPJyKf8Nuk9B1BK+7QBoP0dmH3iUPe105sZkATwrRbh7UBya7J8CWmZIUVOFIu8ypvmfdjGfE+g==
X-Received: by 2002:ac2:55a2:: with SMTP id y2mr4231919lfg.37.1598340808246;
        Tue, 25 Aug 2020 00:33:28 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id a17sm2629101ljd.123.2020.08.25.00.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 00:33:27 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 06/11] commit-graph: add a slab to store topological levels
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <b347dbb01b9254ab8d79fbbd0f7c2b637efde62e.1597509583.git.gitgitgadget@gmail.com>
        <85d03jlu05.fsf@gmail.com> <20200825061418.GA629699@Abhishek-Arch>
Date:   Tue, 25 Aug 2020 09:33:26 +0200
In-Reply-To: <20200825061418.GA629699@Abhishek-Arch> (Abhishek Kumar's message
        of "Tue, 25 Aug 2020 11:44:18 +0530")
Message-ID: <855z97dvsp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> On Fri, Aug 21, 2020 at 08:43:38PM +0200, Jakub Nar=C4=99bski wrote:
>> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
[...]
>>> @@ -1335,11 +1341,11 @@ static void compute_generation_numbers(struct w=
rite_commit_graph_context *ctx)
>>>  					_("Computing commit graph generation numbers"),
>>>  					ctx->commits.nr);
>>>  	for (i =3D 0; i < ctx->commits.nr; i++) {
>>> -		uint32_t generation =3D commit_graph_data_at(ctx->commits.list[i])->=
generation;
>>> +		uint32_t level =3D *topo_level_slab_at(ctx->topo_levels, ctx->commit=
s.list[i]);
>>
>> All right, so that is why this 'generation' variable was not converted
>> to timestamp_t type.
>>
>>>
>>>  		display_progress(ctx->progress, i + 1);
>>> -		if (generation !=3D GENERATION_NUMBER_V1_INFINITY &&
>>> -		    generation !=3D GENERATION_NUMBER_ZERO)
>>> +		if (level !=3D GENERATION_NUMBER_V1_INFINITY &&
>>> +		    level !=3D GENERATION_NUMBER_ZERO)
>>>  			continue;
>>
>> Here we use GENERATION_NUMBER*_INFINITY to check if the commit is
>> outside commit-graph files, and therefore we would need its topological
>> level computed.
>>
>> However, I don't understand how it works.  We have had created the
>> commit_graph_data_at() and use it instead of commit_graph_data_slab_at()
>> to provide default values for `struct commit_graph`... but only for
>> `graph_pos` member.  It is commit_graph_generation() that returns
>> GENERATION_NUMBER_INFINITY for commits not in graph.
>>
>> But neither commit_graph_data_at()->generation nor topo_level_slab_at()
>> handles this special case, so I don't see how 'generation' variable can
>> *ever* be GENERATION_NUMBER_INFINITY, and 'level' variable can ever be
>> GENERATION_NUMBER_V1_INFINITY for commits not in graph.
>>
>> Does it work *accidentally*, because the default value for uninitialized
>> data on commit-slab is 0, which matches GENERATION_NUMBER_ZERO?  It
>> certainly looks like it does.  And GENERATION_NUMBER_ZERO is an artifact
>> of commit-graph feature development history, namely the short time where
>> Git didn't use any generation numbers and stored 0 in the place set for
>> it in the commit-graph format...  On the other hand this is not the case
>> for corrected commit date (generation number v2), as it could
>> "legitimately" be 0 if some root commit (without any parents) had
>> committerdate of epoch 0, i.e. 1 January 1970 00:00:00 UTC, perhaps
>> caused by malformed but valid commit object.
>>
>> Ugh...
>
> It works accidentally.
>
> Our decision to avoid the cost of initializing both
> commit_graph_data->generation and commit_graph_data->graph_pos has
> led to some unwieldy choices - the complexity of helper functions,
> bypassing helper functions when writing a commit-graph file [1].
>
> I want to re-visit how commit_graph_data slab is defined in a future seri=
es.
>
> [1]: https://lore.kernel.org/git/be28ab7b-0ae4-2cc5-7f2b-92075de3723a@gma=
il.com/

All right, we might want to make use of the fact that the value of 0 for
topological level here always mean that its value for a commit needs to
be computed, that 0 is not a valid value for topological levels.
- if the value 0 came from commit-graph file, it means that it came
  from Git version that used commit-graph but didn't compute generation
  numbers; the value is GENERATION_NUMBER_ZERO
- the value 0 might came from the fact that commit is not in graph,
  and that commit-slab zero-initializes the values stored; let's
  call this value GENERATION_NUMBER_UNINITIALIZED

If we ensure that corrected commit date can never be zero (which is
extremely unlikely, as one of root commits would have to be malformed or
written on badly misconfigured computer, with value of 0 for committer
timestamp), then this "happy accident" can keep working.

  As a special case, commit date with timestamp of zero (01.01.1970 00:00:0=
0Z)
  has corrected commit date of one, to be able to distinguish
  uninitialized values.

Or something like that.

Actually, it is not even necessary, as corrected commit date of 0 just
means that this single value (well, for every root commit with commit
date of 0) would be unnecessary recomputed in compute_generation_numbers().

Anyway, we would want to document this fact in the commit message.

Best,
--=20
Jakub Nar=C4=99bski

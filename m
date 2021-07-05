Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441A8C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FBFC6141C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhGETd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhGETd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 15:33:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF57C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 12:31:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j11so24811261edq.6
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 12:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=IujD7gpUjRNNZyjlY41pBAFT9O5/r2o6gX8UCYIw7KM=;
        b=ODZMu8dkstsRHLFEVruKRjV2NdNxKjAq9slsudHGCZ00JQ/YhYEyDVvC9l4aU2z2La
         78ReLi9FN1JUGoUjIv7anOof56Mxq6dtoz3V+0AXa5XXqyIY/y6B1zI8xvwW5ahaDGDC
         gkZE2MDF60qFZmna9nJRhD9Qpyy0aUeSplkuPcT4HS8SwRLhR/QAMteSVFNo1euO6g3v
         Eh5mNJd8I+Tn3QaEN1UtYfXnZF+5qvL93+IZRpiKT0YM46uosgIh8kYSp3Gpy+V6FRjm
         K3P0scEsW3sV2pEbOvzUO6bAPIfc3ubDvcWNqXoBx1KB8cw+aaDns6qqEmJEVudpXJ6F
         Ekfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=IujD7gpUjRNNZyjlY41pBAFT9O5/r2o6gX8UCYIw7KM=;
        b=RnQq99BPkAzUkPZ4/Lx+uJGJCMzU6sUo6cuuhxJhEUHLiuyoRYgVFW9Eq6oKBRVXWD
         d66WBUUxfiHXK0cDpSqvuJS9Hh7HLqjcxNAtm9Grc0Lgvq64z7loV5u5E/Cyt/+BHNv1
         GvktqzjO/CHt77ZheerLZPrcDoO/tkFcg8z1NiadQ39InaOvDgf/OKHncJxslLuLXfT/
         KVcdYQFF2qKHSkryPpiq/C4WxBs2q/BnQVfwfcTPsdZkOH9Bhos8B8uC46/2znK+zH4+
         5U4n5N+W9YUVqVvllEYTNk+CUufCzh4C75VNDzIeqLzEnNWB2Su3L30QsctPMt8IpNIO
         nQPQ==
X-Gm-Message-State: AOAM531BIbogdrofBKFrwpJGf/NgrIHLE31s1aW7uS/3KNCoxu0rf6wN
        iMjul/btUSEpHfqINb3b21/C3sITuRQ=
X-Google-Smtp-Source: ABdhPJwx2jvDtQelmwFll7ZrzxivGGuecwhVHWzOpUr2PTCNaUkeShrH6UphJSbObj/G1jdatqhxYA==
X-Received: by 2002:aa7:c0c5:: with SMTP id j5mr18001798edp.59.1625513477021;
        Mon, 05 Jul 2021 12:31:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s5sm6010795edi.93.2021.07.05.12.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 12:31:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 8/8] refs: explicitly propagate errno from
 refs_read_raw_ref
Date:   Mon, 05 Jul 2021 21:08:50 +0200
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
 <2a9ebe43deac3da9baf241ff1e494f8210c27981.1623329869.git.gitgitgadget@gmail.com>
 <8735sydvzs.fsf@evledraar.gmail.com>
 <CAFQ2z_OeO8ALHPv6JzL2UDWqEb6Um8e8nPYMWBH8mmaMvibMhQ@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAFQ2z_OeO8ALHPv6JzL2UDWqEb6Um8e8nPYMWBH8mmaMvibMhQ@mail.gmail.com>
Message-ID: <877di47e2j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 05 2021, Han-Wen Nienhuys wrote:

> On Thu, Jul 1, 2021 at 3:06 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>> > -     const char *result =3D refs_resolve_ref_unsafe_implicit_errno(
>> > -             refs, refname, resolve_flags, oid, flags);
>> > -     *failure_errno =3D errno;
>> > -     return result;
>> > +     int ignore;
>> > +     return refs_resolve_ref_unsafe_with_errno(refs, refname, resolve=
_flags,
>> > +                                               oid, flags, &ignore);
>> >  }
>>
>> Okey, so here we have something like the "caller should explicitly
>> ignore it" I suggested in <878s2qdy8y.fsf@evledraar.gmail.com>. We no
>> longer set "errno" at all for the benefit of the callers of that
>> function, but instead explicitly throw it away, our
>> refs_resolve_ref_unsafe_with_errno() no longer sets errno.
>>
>> But this end-state seems to have resulted in introducing new bugs. A
>> bunch of functions are thin wrappers for
>> refs_resolve_ref_unsafe(). Previously they could inspect errno on a -1
>> return, now they can't.
>>
>> I didn't look at them all, but just the second one I looked at,
>> refs_read_ref_full() has a verify_lock() caller which calls it, and that
>
> It looks like you were lucky. I looked at the output of

Maybe so...

> egrep -A7 -B7 --color -nH -e
> '(refs_resolve_refdup|resolve_refdup|refs_read_ref_full|read_ref_full|rea=
d_ref|refs_ref_exists|ref_exists|resolve_gitlink_ref|index_path)\('
> *.[ch] */*.[ch]

FWIW this gives better results:

    git grep -E -W '\b(refs_resolve_refdup|resolve_refdup|refs_read_ref_ful=
l|read_ref_full|read_ref|refs_ref_exists|ref_exists|resolve_gitlink_ref|ind=
ex_path)\('

> and the case you pointed out is the only one which inspects errno
> after calling resolve_ref_unsafe (transitively through the grepped
> functions.)

Isn't the `errno =3D=3D EISDIR` in files_copy_or_rename_ref() another one?
It's just after calling refs_read_ref_full().

Yes, but aside from that it does look like I got lucky. I assumed this
issue was more widespread. Phew!

>> function then expects a meaningful errno that it in turn ferries up with
>> "can't verify ref". It in turn is called by lock_ref_oid_basic(), it
>> ferries up that strbuf with the error, which'll now have a meaningless
>> strerror(0) in it.
>>
>> So it seems to me that the refactoring being done here is halfway done,
>> [..]
>> of what you're starting here. I.e. we have a low-level function that may
>> encounter an errno, and then callers removed from that via:
>>
>>     index_path() -> resolve_gitlink_ref() -> refs_resolve_ref_unsafe()
>>..
>> Where the common case for index_path() is to report the error we got,
>> but it doesn't call die_errno() or error_errno() now, but really should,
>
> "but really should": Why?
>
> Why should all functions that resolve a ref print out system level
> errors? For example, that would entail large changes to sequencer.c
> which does "error" =3D=3D "does not exist".
>
> Also, the errors you print out will be fundamentally limited. An error
> in resolving HEAD could be caused by a problem in any of the following
> files
>
>    .git/HEAD
>    .git/packed-refs
>    .git/refs/
>    .git/refs/heads/
>    .git/refs/heads/main
>
> Since we have no way of reporting the filename involved, what is a
> user going to do with the error message ("file doesn't exist")? I
> think refs_verify_refname_available() provides a more realistic
> approach: create custom error messages for situations that a user is
> more likely to encounter.

Let me rephrase: "we really shouldn't", as in I agree that this API
sucks and that refs_verify_refname_available() is a much better
approach.

But as long as errno was the abstraction we were passing around it
seemed like e.g. callers like process_directory() should be getting the
errno and using the *_errno() error functions, but of course it would be
much better if they used a better error return flow.

But having looked at the grep above with fresh eyes I think it's fine to
leave it at the refs_resolve_ref_unsafe_with_errno() boundary. The error
messages are clear enough, and we're trying to phase out errno anyway.

I was more paranoid about things that would actually do equality checks
against the errno, as it appearsfiles_copy_or_rename_ref() is still
doing.

> Also, for something like the reftable backend, there are error classes
> that have no direct errno counterpart. For example, if reftable finds
> corrupt zlib data, should it invent a bogus errno code so it can work
> with the errno reporting system?

No, that would be crazy. We should be moving away from errno
entirely. My concern is only that we might be introducing subtle bugs
further up the callstack now that we clear "errno" ...

> I'll take from this review that I should elide the part where errno is
> cleared, and leave it to someone else to figure out a more holistic
> strategy to error reporting.

...or if we don't clear errno introducing those sorts of subtle bugs
when we use reftable instead of the files backend. I.e. no, we really
should be clearing errno, if not in this series then in some other
pre-reftable series.

To not do so would be kicking this particular can down the road, and
leaving those bugs for reftable users to find. Which given that I've
found a few cases with no test coverage...

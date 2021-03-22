Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21E2C433E0
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 16:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D4C61990
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 16:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhCVQlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhCVQkk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 12:40:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16AFC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 09:40:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w18so20202805edc.0
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 09:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/XMKuwsgfdoVNYiRBhYu7T6Uf1ncMZWC1tzMv+TnluE=;
        b=aBlll1bzl6gBzRp96Cs4PSflm5vb68xt3708cUv44gpVZKtN6FzEfvhLANLZJmzV6L
         hyLBNELmgChpQm6eGk4VWzH6md2z4pqPCvjN9QIybsolnJCHQDXfuJCXnu4FpobcYH9d
         eN5194QdkJLTdFUanGNyQA2YDXDQ/mXutO50GAvyHWEQHZVeTTz6s8S1rMacZRhB0J95
         UlEbrYWux6o/7G6BuHrLnJrE14yx27teA6mOsOuOFbz3WjwRtt1LEIQf/74/KMAs+p+2
         nPdpaI88tkjNNhHBa7XJ1FUqyozdZ3PG8clxfgcUNd0qaezJVsfmn9Cz1KxG7hh14KSB
         agLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/XMKuwsgfdoVNYiRBhYu7T6Uf1ncMZWC1tzMv+TnluE=;
        b=KPQWN1zlPjmdFtC7apy/97DOyuy2gc7a/FnX/CUnIKc5QPe+elHVIWUd90F/FaFJLu
         qTu4bHlZjkdcBGmT36yXltnvgQgJxxf8u8Tr3YyPAJ2a2xzIbYw2Z4JWaY35iZlXf4Pj
         ZL6NEOWU9RH69yvlnBC0g+PHVm8vGg052Mq4cLyR3XkG8TFJS7X3TRQlS5ygoXfmQC7B
         HJWiPoAfXaC9fKIsjt6F1zRi0tGPjhmt/UquhXoAbyhQGmg2TMxVGEK5Jzyy5EtCDd8Q
         2M6I0W9k0BpDPJvUhAZoh5Sc/dqYZq+z+J0EDK2nyBQF5M7XjtakpfixdSrnKDFQOgPY
         xHrg==
X-Gm-Message-State: AOAM533Ve8aVB3g20YstSnQJSKE40UEGpiuMCspO71UDDgtDhKjnsB8q
        BPNGjDRrNqfjKHV6Tst+W04=
X-Google-Smtp-Source: ABdhPJzBztQbV9rrY+wpFAk7Oes3TeNFGBFAy1S9a1mw2Cbv019on9heloP080Rbjt7QOlwk14OUmA==
X-Received: by 2002:a05:6402:4244:: with SMTP id g4mr494735edb.204.1616431238292;
        Mon, 22 Mar 2021 09:40:38 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r19sm9776305ejr.55.2021.03.22.09.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:40:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Martin Fick <mfick@codeaurora.org>
Subject: Re: Distinguishing FF vs non-FF updates in the reflog?
References: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
 <87eeg7qpyr.fsf@evledraar.gmail.com>
 <CAFQ2z_NSh3XxjGx56r=xBP2WBk7ggUjh4rXSb5ivPtkS_r4iBQ@mail.gmail.com>
 <87blbbqju3.fsf@evledraar.gmail.com>
 <CAFQ2z_ML8s0Gk4Zmg+2mxzkfP1AbL=zkeUG0yKEtoege7it-vA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAFQ2z_ML8s0Gk4Zmg+2mxzkfP1AbL=zkeUG0yKEtoege7it-vA@mail.gmail.com>
Date:   Mon, 22 Mar 2021 17:40:37 +0100
Message-ID: <878s6fqgze.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 22 2021, Han-Wen Nienhuys wrote:

> On Mon, Mar 22, 2021 at 4:39 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> We can know with !strcmp(rows[0][1], rows[1][0]) whether the latest
>> update is a ff or non-ff (it is). As opposed to:
>>
>>     $ cut -d ' ' -f1-2 .git/logs/refs/remotes/origin/seen | head -n 2
>>     8b26a41f4bf7e7c0f097cb91012d08fe8ae30e7f 0f3a981cbd5be5f97e9504ab770=
cd88f988fe820
>>     0f3a981cbd5be5f97e9504ab770cd88f988fe820 fdd019edfe6bc60d0100d5751c4=
1e4f6ad28a2ef
>>
>> Where the rows[0][1] value is not the same as rows[1][0].
>
> I'm confused.
>
> rows[0][1] =3D=3D "0f3a981cbd5be5f97e9504ab770cd88f988fe820"
> rows[1][0] =3D=3D "0f3a981cbd5be5f97e9504ab770cd88f988fe820"
>
> they are the same. I don't understand your argument.

Sorry, I mean same =3D ff update, not the same =3D non-ff. So I flipped
those around in describing it.

But in any case, the point is that you can reliably tell from a log of
updates whether individual updates are ff or non-ff, as long as you:

1. Look at two records but not one, or rather the ff-ness of the update
   you're looking at now depends on <oldvalue> of that update matching
   the <newvalue> of the update before that.

2. The log is guaranteed to be in the same order as the update-ref
   calls, and not to be pruned in the middle.

3. Don't care about the FF-ness of the first entry in the reflog
   (e.g. prune it at N entries or 2 weeks, you can't see if the oldest
   entry you have is a FF or not)

So as I noted I've materialized this in a RDBMS before as something like
ENUM('delete', 'create', 'ff', 'non-ff'), but that was:

A. In the delete/create case as much about the convenience of
   selecting/grouping as anything else, easier to select operation =3D
   "delete" than {old,new} =3D "<copy paste or calefully type exactly 40 x
   '0'>"

B. In SQL it's a PITA both typing and index-wise to get information
   about a record based on a "previous" record when the relation between
   the two is a a UNIQUE INDEX and AUTO-INCREMENT id. I.e. for an
   AUTO_INCREMENT UNIQUE INDEX of repo,refname,id to get the "last"
   record you need to select where repo && refname is the same, and id <
   current_id LIMIT 1.

C. You're accessing the data ad-hoc & manually via SQL, not some
   Git-specific query language/wrapper.

But in the case of reftable I'm wondering what the use-case is, since
presumably whatever API now serves up the reflog from it can just as
well look at one more record and fill in a matrialized "ff" or "non-ff"
field for the current record based on that.

Also: If you're adding more values a genuinely useful value to log (that
I've seen custom logging for) is "was this a forced push? || update-ref
without the <oldvalue>?", which is *not* the same as "not a
fast-forward". I.e. it's the difference between "update this with this
<oldvalue>" (ff or non-ff) v.s. "I don't care what the oldvalue is, just
update it" (f orce or not).

(To complicate matters and make them even more harder to explain, the
whole "force with lease" thing is not actually a "force push" in that
sense, it's just an update-ref with an oldvalue you expect to result in
a non-ff update).

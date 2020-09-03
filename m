Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFB2C433E9
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 14:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE3920658
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 14:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owC57vMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgICO6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbgICOHw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 10:07:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A0CC061A14
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 06:42:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b19so3718671lji.11
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 06:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4dVfaGDoIxNq4XOLMncA5kYiDaLmjs2+htwccNKK9Pc=;
        b=owC57vMm/iv2H9AEc9mJssnu9+HsmZSUf3ueygPb7rJalVgFLD6zFAsRpCkC96xtJy
         jXzXB6kHJZY8otKAgef7tXAsadB7yV+Qgwp9d0jxkzzT8IAToxDUlsDUho0IBC/z4Nn6
         LIfYtG7GrwwJRpeT0nZR01f0OOtdqSXMJnY1KTvKp1D/XciSXGzDfJVMoAy7e7SZtGnU
         6yCKukGkkjt+Qjg5p3pFk8VML9ys4S7s80aKj8ED/Dkowmbwb8nLa6gPFbGn8m+QYuSQ
         ZuiXcE5ADe2Z2YxpF63jbXF0qwaVjWklpYlnMoKqJwqUkce7L6dErPnJTT9VTx0LMJJe
         +SKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=4dVfaGDoIxNq4XOLMncA5kYiDaLmjs2+htwccNKK9Pc=;
        b=WSwN5GiNipRRJvGEqKv/RVeMDMyrfp4Drb7tGr00+ZY7//nsSk1xo94tKo2EVCbGvG
         zUunBX9g2HI82mBuxdBAK+bxYPxRiBrJs2NOVdIzCCULkkP3sQA4VTgOCKjHgttI3kx1
         pZrv816sA/fnC0z7m2ErXNiCKP5aN7GbkRSV9Phr9tbrYpEdPjDcTXzXsSEL1G/x1C/d
         Xjb8OOazqHJJeClzFKtIsY2Gsa6TkwV5hJ+vV1l7Yo9boJbhIstgjooYlZtc/ZHf9+uK
         2WCOKI5iAJ90+OJ2kC2h5lDxhWf39VdZXjzIf5RXyMENnRBB1SdZrXfuQjX3+4bdOmBU
         dOzg==
X-Gm-Message-State: AOAM533I9rNgCitrJ7eumFo0TFbrLJ6c1ZWsn9jWWpP/19Hf2v7J/8J/
        Hm838Ailvc4Vx1nqeZkH0FI=
X-Google-Smtp-Source: ABdhPJzr2nyqGFaFTq3jsZOmp04oyuk2H9oYfECwr+FllBFhkUgs2TtN970le8/KrSxuzEol1rq+sw==
X-Received: by 2002:a2e:b4fc:: with SMTP id s28mr1292926ljm.305.1599140565963;
        Thu, 03 Sep 2020 06:42:45 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id n21sm617319ljc.89.2020.09.03.06.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 06:42:45 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 05/11] commit-graph: return 64-bit generation number
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <6be759a9542114e4de41422efa18491085e19682.1597509583.git.gitgitgadget@gmail.com>
        <85d03km98l.fsf@gmail.com> <20200825050448.GA21012@Abhishek-Arch>
        <85ft8adilr.fsf@gmail.com> <20200901120653.GA59580@Abhishek-Arch>
Date:   Thu, 03 Sep 2020 15:42:43 +0200
In-Reply-To: <20200901120653.GA59580@Abhishek-Arch> (Abhishek Kumar's message
        of "Tue, 1 Sep 2020 17:36:53 +0530")
Message-ID: <851rjjasdo.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> On Tue, Aug 25, 2020 at 02:18:24PM +0200, Jakub Nar=C4=99bski wrote:
>> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
>>=20
>> ...
>>=20
>> However, as I wrote, handling GENERATION_NUMBER_V2_OFFSET_MAX is
>> difficult.  As far as I can see, we can choose one of the *three*
>> solutions (the third one is _new_):
>>=20
>> a. store 64-bit corrected commit date in the GDAT chunk
>>    all possible values are able to be stored, no need for
>>    GENERATION_NUMBER_V2_MAX,
>>=20
>> b. store 32-bit corrected commit date offset in the GDAT chunk,
>>    if its value is larger than GENERATION_NUMBER_V2_OFFSET_MAX,
>>    do not write GDAT chunk at all (like for backward compatibility
>>    with mixed-version chains of split commit-graph layers),
>>=20
>> c. store 32-bit corrected commit date offset in the GDAT chunk,
>>    using some kind of overflow handling scheme; for example if
>>    the most significant bit of 32-bit value is 1, then the
>>    rest 31-bits are position in GDOV chunk, which uses 64-bit
>>    to store those corrected commit date offsets that do not
>>    fit in 32 bits.

Note that I have posted more detailed analysis of advantages and
disadvantages of each of the above solutions in response to 11/11
https://public-inbox.org/git/85o8mwb6nq.fsf@gmail.com/

I can think of yet another solution, a variant of approach 'c' with
different overflow handling scheme:

c'.  Store 32-bit corrected commit date offset in the GDAT chunk,
     using the following overflow handling scheme: if the value
     is 0xFFFFFFFF (all bits set to 1, the maximum possible value
     for uint32_t), then the corrected commit date or corrected
     commit date offset can be found in GDOV chunk (Generation
     Data OVerflow handling).

     The GDOV chunk is composed of:
     - H bytes of commit OID, or 4 bytes (32 bits) of commit pos
     - 8 bytes (64 bits) of corrected commit date or its offset
=20=20=20=20=20
     Commits in GDOV chunk are sorted; as we expect for the number
     of commits that require GDOV to be zero or a very small number
     there is no need for GDO Fanout chunk.
=20=20=20=20=20
   - advantages:
     * commit-graph is smaller, increasing for abnormal repos
     * overflow limit reduced only by 1 (a single value)
   - disadvantages:
     * most complex code of all proposed solutions
       even more complicated than for solution 'c',
       different from EDGE chunk handling
     * tests would be needed to exercise the overflow code

Or we can split overflow handling into two chunks: GDOI (Generation Data
Overflow Index) and GDOV, where GDOI would be composed of H bytes of
commit OID or 4 bytes of commit graph position (sorted), and GDOV would
be composed oly of 8 bytes (64 bits) of corrected commit date data.

This c'') variant has the same advantages and disadvantages as c'), with
negligibly slightly larger disk size and possibly slightly better
performance because of better data locality.

>
> Alright, so the third solution leverages the fact that in practice,
> very few offsets would overflow the 32-bit limit. Using 64-bits for all
> offsets would be wasteful, we can trade off a miniscule amount of
> computation to save large amounts of disk space.

On the other hand we can say that we can trade negligible increase of
commit-graph disk space size (less than 7% in worst case: no octopus
merges, no changed-path Bloom filter data, using SHA-1 for object ids,
large repository so header size + OIFD is negligible) for simpler code
with no need for overflow handling at all (and a minuscule amount of
less computations).

>>
>> This type of schema is used in other places in Git code, if I remember
>> it correctly.
>>=20
>
> Yes, it's a similar idea to the extra edge list chunk, where the most
> significant bit of second parent indicates whether they are more than
> two parents.

Yes and no.  Yes, the solution 'c' uses exactly the same mechanism as
the pointer from Commid Data chunk into Extra Edges List chunk:

      [...]  If there are more than two parents, the second value
      has its most-significant bit on and the other bits store an array
      position into the Extra Edge List chunk.

On the other hand we need to have some kind of overflow handling for the
list of parents, as the number of parents is not limited in Git (there
is no technical upper limit on the number of parents a commits can
have), as opposed to for example Mercurial.  This is not the case for
storing corrected commit date (or corrected commit date offset), as 64
bits is all we would ever need.

> It's definitely feasible, albeit a little complex.
>
> What's the overall consensus on the third solution?

Still waiting for others to weight in.

Best,
--=20
Jakub Nar=C4=99bski

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B7D200B9
	for <e@80x24.org>; Thu, 24 May 2018 22:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034731AbeEXWIh (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 18:08:37 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35334 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034727AbeEXWIc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 18:08:32 -0400
Received: by mail-wm0-f52.google.com with SMTP id o78-v6so9431416wmg.0
        for <git@vger.kernel.org>; Thu, 24 May 2018 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=M2d6n2EsTZ85QAYZWVQlifjzeL0ex7sblnmbv4Sbh7I=;
        b=q4uAJuZbq0lrWC1jyyTEiiDiFzJXyVD1vyrMWrER8uyLzcmWYGoEf6T5zvJcZwgQmd
         apaW075lVZDnuiaRx5vphM2gnh3jS40/LOzR/eiPznCZvqD/VM02+YXgPDuMxwo9wYbU
         6nOwPK/jEs7+lVre3/X9OR14xERP5ifgwniR8ohsLlaBCsE8m/qT3o5bPQAn/eRyfY39
         PRRZOlV5RbW1Kf+1UKeSh03SclRRX4FuejiRyG5hxU/g32hXASdbnak5ai2QGCkkT6PD
         rJZjBN1SP2rV7SbcvPJYtFquLGYWtKo59rj3DCTT/nnKXmACHUZoZNXzyxpumi+rgoyW
         NwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=M2d6n2EsTZ85QAYZWVQlifjzeL0ex7sblnmbv4Sbh7I=;
        b=kN5jS0AIFTFOn9fc3Vh2UjmlIJwj7kdxOEWhdmMSTRTs/31L3g+uDrerzq/z32iBl0
         woLQsg7JWKF73s/7KQiDlIAkCpH9QRmMwfi8jYlI63T0FGVQk63Nik2565rvAy2RIeYT
         w2fRAuw3oTPaYRiDf2BdKHz5QAVxp9cozc1c0SO7sxBsB8pZz0NrU2Zwoa1qS1RX12nI
         EQGD5OM9Dg4aNGn5eUgbLXaLsjMsLCXhNkCBbiJu79WeJ01NXW7F/R4BmCN1OWkiL2HO
         UMECRdoiX3TRnhxa+TtG9NlB1jH1v6rd0liPNYvnIVmaTx6i5M9lDYUtUoqb8rbmM0j3
         sH6Q==
X-Gm-Message-State: ALKqPwd/8IpbjeR1AtrplpW0jrebUxOqAdTYiIV5qniM9tpagpkV9P4q
        O0ouhCKw0BIW97LzAHyncOw=
X-Google-Smtp-Source: AB8JxZqI7wFejxtqxPnD7auObTuirmh7fKan/YeI2vP0FUhn7J4NNn/nUqhueCISQ1iOgD/X67PcIA==
X-Received: by 2002:a1c:c386:: with SMTP id t128-v6mr8801600wmf.113.1527199711132;
        Thu, 24 May 2018 15:08:31 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egm229.neoplus.adsl.tpnet.pl. [83.21.76.229])
        by smtp.gmail.com with ESMTPSA id z192-v6sm4916699wmc.10.2018.05.24.15.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 15:08:29 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: commit-graph: change in "best" merge-base when ambiguous
References: <e78a115a-a5ea-3c0a-5437-51ba0bcc56e1@gmail.com>
        <3705af00-00b7-b620-cc77-eef8f0a73bc1@alum.mit.edu>
        <8b480e9e-1fd3-35ff-2974-653fadd49fa7@gmail.com>
Date:   Fri, 25 May 2018 00:08:28 +0200
In-Reply-To: <8b480e9e-1fd3-35ff-2974-653fadd49fa7@gmail.com> (Derrick
        Stolee's message of "Tue, 22 May 2018 08:48:04 -0400")
Message-ID: <86o9h41zc3.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 5/22/2018 1:39 AM, Michael Haggerty wrote:
>> On 05/21/2018 08:10 PM, Derrick Stolee wrote:
>>> [...]
>>> In the Discussion section of the `git merge-base` docs [1], we have the
>>> following:
>>>
>>>  =C2=A0=C2=A0=C2=A0 When the history involves criss-cross merges, there=
 can be more than
>>> one best common ancestor for two commits. For example, with this topolo=
gy:
>>>
>>>  =C2=A0=C2=A0=C2=A0 ---1---o---A
>>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 \ /
>>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 X
>>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 / \
>>>  =C2=A0=C2=A0=C2=A0 ---2---o---o---B
>>>
>>>  =C2=A0=C2=A0=C2=A0 both 1 and 2 are merge-bases of A and B. Neither on=
e is better than
>>> the other (both are best merge bases). When the --all option is not
>>> given, it is unspecified which best one is output.
>>>
>>> This means our official documentation mentions that we do not have a
>>> concrete way to differentiate between these choices. This makes me think
>>> that this change in behavior is not a bug, but it _is_ a change in
>>> behavior. It's worth mentioning, but I don't think there is any value in
>>> making sure `git merge-base` returns the same output.
>>>
>>> Does anyone disagree? Is this something we should solidify so we always
>>> have a "definitive" merge-base?
>>> [...]
>> This may be beyond the scope of what you are working on, but there are
>> significant advantages to selecting a "best" merge base from among the
>> candidates. Long ago [1] I proposed that the "best" merge base is the
>> merge base candidate that minimizes the number of non-merge commits that
>> are in
>>
>>      git rev-list $candidate..$branch
>>
>> that are already in master:
>>
>>      git rev-list $master
>>
>> (assuming merging branch into master), which is equivalent to choosing
>> the merge base that minimizes
>>
>>      git rev-list --count $candidate..$branch

Is the above correct...

>> In fact, this criterion is symmetric if you exchange branch =E2=86=94 ma=
ster,
>> which is a nice property, and indeed generalizes pretty simply to
>> computing the merge base of more than two commits.

...as it doesn't seem to have the described symmetry.

>>
>> In that email I also included some data showing that the "best" merge
>> base almost always results in either the same or a shorter diff than the
>> more or less arbitrary algorithm that we currently use. Sometimes the
>> difference in diff length is dramatic.
>>
>> To me it feels like the best *deterministic* merge base would be based
>> on the above criterion, maybe with first-parent reachability, commit
>> times, and SHA-1s used (in that order) to break ties.
>
> Thanks, everyone, for your perspective on this. I'm walking away with
> these conclusions:
>
> 1. While this is a change in behavior, it is not a regression. We do
> not need to act immediately to preserve old behavior in these
> ambiguous cases.
>
> 2. We should (eventually) define tie-breaking conditions. I like
> Michael's suggestion above.

One thing I'd like to point out is that when searching for some
algorithm to speed up merge-base calculation (which is called lowest
common ancestor in graph theory, and for which I have currently found
only an algorithm with O(|V|*{E|) preparation time, and U(1) query)
I have found instead attempts to rigorously define single representative
lowest common ancestor.  It might be worth a look how it is done.

Another possible source to compare against is the algorithm used by
Mercurial (which as far as I know doesn't use recursive merge strategy,
so it needs to chose one merge base).

HTH,
--=20
Jakub Nar=C4=99bski

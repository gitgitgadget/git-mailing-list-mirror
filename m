Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9322B1F404
	for <e@80x24.org>; Thu, 26 Apr 2018 09:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754015AbeDZJCK (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 05:02:10 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34581 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752964AbeDZJCH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 05:02:07 -0400
Received: by mail-wm0-f52.google.com with SMTP id w2so7744167wmw.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 02:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lO73prfpqIrtzasMvwrkvNAg/rShfRYjjPL5qxr0oyw=;
        b=VvtvUUHx9M3Fpn0s3lIuEAoeY6nivF5pJfBhkVgHWob18vR5SB4sx1ZkKyqcC8EA71
         l3BGv8QUJnbblEACMhJnFwOiO456XgYo5T/KrWV8mBZTTgR6G0rOt6tTJXyLahu4iuk/
         jR0AmQrWlvQDAloPJ4NsWEjYGgGwQBveZzo5RFyrep0VmadLGqtm6YkUmVA0fkmsaLuE
         cN1fw0tOkK4R7qO2WoOtkHCo0nzg5R24QvDq4uQ/y8K2fJvyDkWqcFTpkL12bnIq7Jt5
         GU+/atYh3iMPdT6aabBSa8Mps4U5hnAjAH8bd+u5oSvJwjmxvReh5Z2wj2KGY6+sWE4L
         ZiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=lO73prfpqIrtzasMvwrkvNAg/rShfRYjjPL5qxr0oyw=;
        b=pLwpXBsN6QMpgCoj3MiITKUzdWDdzbNS/dL+KMIO/UkqqbKyOmlG1QRNGUFKwTHtNa
         BeWRdQ2FkpDhovml4ksHTRLvukiFUPq99tVZaRqJwu6UGF/O19YJ4J9tqFCO2r0uaUrq
         Y/FsSaAXW4WDbfvVg7Y7kO8l346t7v39sM75J8LRWMT8Dga6XJzpQ7JwSlh5bnosTfH3
         YgmJTWOgND6E+Phhg8LoJ/M1BXpyDESSKk6mfqKiF89cWilWW4wouKNijCRm+t7nptae
         xU0nQ2hoZVGw7zipNhQKMAz1PE9dRTQDxjWSKVQqY1Ji+wjrlDrWzT/K9w/sUQHjQwRb
         12Cw==
X-Gm-Message-State: ALQs6tAoPFnc7RHLrgOtdXEFkZ0IsWhkTR6zUfOfqRmWG6wmaC8P/JkR
        UgiOIY55h+c8iP7zIjSDxGw=
X-Google-Smtp-Source: AIpwx48pugyF6ownNqFEBARKcn+s5W41a7EMqriH8LniueiQuRXLKjX3xORqULdJR9Yshfxj+QlubQ==
X-Received: by 10.28.12.129 with SMTP id 123mr17001378wmm.75.1524733325574;
        Thu, 26 Apr 2018 02:02:05 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (efc10.neoplus.adsl.tpnet.pl. [83.21.40.10])
        by smtp.gmail.com with ESMTPSA id o12-v6sm20708708wri.78.2018.04.26.02.02.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Apr 2018 02:02:04 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 04/10] commit: use generations in paint_down_to_common()
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-5-dstolee@microsoft.com>
        <xmqqr2n23b4o.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 26 Apr 2018 11:02:02 +0200
In-Reply-To: <xmqqr2n23b4o.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 26 Apr 2018 12:22:15 +0900")
Message-ID: <86tvryjq7p.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> Define compare_commits_by_gen_then_commit_date(), which uses generation
>> numbers as a primary comparison and commit date to break ties (or as a
>> comparison when both commits do not have computed generation numbers).
>>
>> Since the commit-graph file is closed under reachability, we know that
>> all commits in the file have generation at most GENERATION_NUMBER_MAX
>> which is less than GENERATION_NUMBER_INFINITY.
>
> I suspect that my puzzlement may be coming from my not "getting"
> what you meant by "closed under reachability",

It means that if commit A is in the commit graph, then all of its
ancestors (all commits reachable from A) are also in the commit graph.

>                                                but could you also
> explain how _INF and _ZERO interact with commits with normal
> generation numbers?  I've always assumed that genno will be used
> only when comparing two commits with valid genno and otherwise we'd
> fall back to the traditional date based one, but...
>
>> +int compare_commits_by_gen_then_commit_date(const void *a_, const void =
*b_, void *unused)
>> +{
>> +	const struct commit *a =3D a_, *b =3D b_;
>> +
>> +	/* newer commits first */
>> +	if (a->generation < b->generation)
>> +		return 1;
>> +	else if (a->generation > b->generation)
>> +		return -1;
>
> ... this does not check if a->generation is _ZERO or _INF.=20=20
>
> Both being _MAX is OK (the control will fall through and use the
> dates below).  One being _MAX and the other being a normal value is
> also OK (the above comparisons will declare the commit with _MAX is
> farther than less-than-max one from a root).
>
> Or is the assumption that if one has _ZERO, that must have come from
> an ancient commit-graph file and none of the commits have anything
> but _ZERO?

There is stronger and weaker version of the negative-cut criteria based
on generation numbers.

The strong criteria:

  if A !=3D B and gen(A) <=3D gen(B), then A cannot reach B

The weaker criteria:

  if gen(A) < gen(B), then A cannot reach B


Because commit-graph is closed under reachability, this means that

  if A is in commit graph, and B is outside of it, then A cannot reach B

If A is in commit graph, then either _MAX >=3D gen(A) >=3D 1,
or gen(A) =3D=3D _ZERO.  Because _INFINITY > _MAX > _ZERO, then we have

  if _MAX >=3D gen(A) >=3D 1 || gen(A) =3D=3D 0, and gen(B) =3D=3D _INFINITY
  then A cannot reach B

which also fullfils the weaker criteria

  if gen(A) < gen(B), then A cannot reach B


If both A and B are outside commit-graph, i.e. gen(A) =3D gen(B) =3D _INFIN=
ITY,
or if both A and B have gen(A) =3D gen(B) =3D _MAX,
or if both A and B come from old commit graph with gen(A) =3D gen(B) =3D_ZE=
RO,
then we cannot say anything about reachability... and weak criteria
also does not say anything about reachability.


Maybe the following ASCII table would make it clear.

             |                      gen(B)
             |            ................................ :::::::
gen(A)       | _INFINITY | _MAX     | larger   | smaller  | _ZERO
-------------+-----------+----------+----------+----------+--------
_INFINITY    | =3D         | >        | >        | >        | >
_MAX         | < Nn      | =3D        | >        | >        | >
larger       | < Nn      | < Nn     | =3D n      | >        | >
smaller      | < Nn      | < Nn     | < Nn     | =3D n      | >
_ZERO        | < Nn      | < Nn     | < Nn     | < Nn     | =3D

Here "n" denotes stronger condition, and "N" denotes weaker condition.
We have _INFINITY > _MAX > larger > smaller > _ZERO.


NOTE however that it is a *tradeoff*.  Using weaker criteria, with
strict inequality, means that we don't need to handle _INFINITY, _MAX
and _ZERO corner-cases in a special way; but it also means that we would
walk slightly more commits than if we used stronger criteria, with less
or equals.

For Linux kernel public repository commit graph[1] we have maximum of 512
commits sharing the same level, 5.43 sharing the same commit on average,
and 50% of time only 2 commits sharing the same level (median, or 2nd
quartile, or 50% percentile).  This is roughly the amount of commits we
walk more with weaker cut-off condition.

[1]: with 750k commits, but which is not largest commit graph any more :-0

>> +	/* use date as a heuristic when generations are equal */
>> +	if (a->date < b->date)
>> +		return 1;
>> +	else if (a->date > b->date)
>> +		return -1;
>> +	return 0;
>> +}

HTH
--=20
Jakub Nar=C4=99bski

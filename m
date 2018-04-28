Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A70681F428
	for <e@80x24.org>; Sat, 28 Apr 2018 14:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbeD1Oig (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 10:38:36 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:50753 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbeD1Oif (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 10:38:35 -0400
Received: by mail-wm0-f48.google.com with SMTP id t11so6792565wmt.0
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+wy2i4uC7/m8p5JqMrq/UWCJtUjtPTtcJpkIAk7ujcE=;
        b=p5Z1XbDEvo669706GB2wrJ484zQ7vp0SqyDAgZQS5ZpjF8WKT8mIG7Ax/xMZjpHPa5
         dp6yYUZ8icC00Xh3GrBfUWhByvvU0tRGYkPWlnHAYPMsyKq6UtfaSaQtHES9I2NgZuRV
         BdzP3bONxZykABm9W0M3s7jpsrtsPQHhAvv/0WW9sUaYYFWqimJgI2OP7CrZ5Nsot9Kz
         IyDFlAucC4sAfan0RGJj52Os0XnTyqm4xbzo2xmlGz1/iqltKcn/S+hLg/lUWcxZYNk0
         Yw3PwMAAzSeTB+6+QH/tLfcEwC96QUDI5bB1EyOJYxOQsejqtG8oCd2ex5BVJ7Lk/DoH
         YZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=+wy2i4uC7/m8p5JqMrq/UWCJtUjtPTtcJpkIAk7ujcE=;
        b=Y1zEmtfZ8eDIxnukOhuF+GFnTd1ZGQENeXlxfolePj1yBJntyj77SUevMwSEAbWm/F
         6wIi+NlMeLdXYG0q20PAj3gOXJAw5NxUAPgvAcS2ZWgG5j03N5gB0kgEIWZZHcdUv2ZS
         tLNEHUG5tGf96n6RINGMsmztzhA8MWgctq2xxuE7M0a7f6COl3j8hMabxMOJJscLNwld
         Y16JhGdshIeQxT6B9Wf+zuAEzn0+hW5sB/HBcbIbZxk9cZBMFwFO9m6Cdf4rslbuSCFl
         LHc5IaJngQiBMhYLQceYjj6gjKXQvgv7Mh4ggZTbl0c26UTf+gigLU5tCDQy0+uGWdOm
         KdwA==
X-Gm-Message-State: ALQs6tB6X5C7h0Q92RX35xDZfxrCwt98TXmSb+TMfTnofR1UXgnoGJHc
        KZ9vuJZUS0Tk5WHz0fHPou8=
X-Google-Smtp-Source: AB8JxZqrBP0o6/eCVrs2ZkY8KRTE/w4xoz+33ybWYzjGKXAadY3Tftg9cSLou8j6/Uv9bXNvO9cwFQ==
X-Received: by 10.28.183.215 with SMTP id h206mr3959824wmf.2.1524926312585;
        Sat, 28 Apr 2018 07:38:32 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abps22.neoplus.adsl.tpnet.pl. [83.8.60.22])
        by smtp.gmail.com with ESMTPSA id y100sm7306086wmh.2.2018.04.28.07.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Apr 2018 07:38:31 -0700 (PDT)
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
        <86tvryjq7p.fsf@gmail.com>
Date:   Sat, 28 Apr 2018 16:38:29 +0200
In-Reply-To: <86tvryjq7p.fsf@gmail.com> (Jakub Narebski's message of "Thu, 26
        Apr 2018 11:02:02 +0200")
Message-ID: <86o9i3jt0a.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:
> Junio C Hamano <gitster@pobox.com> writes:
>> Derrick Stolee <dstolee@microsoft.com> writes:
[...]
>>> +int compare_commits_by_gen_then_commit_date(const void *a_, const void=
 *b_, void *unused)
>>> +{
>>> +	const struct commit *a =3D a_, *b =3D b_;
>>> +
>>> +	/* newer commits first */
>>> +	if (a->generation < b->generation)
>>> +		return 1;
>>> +	else if (a->generation > b->generation)
>>> +		return -1;
>>
>> ... this does not check if a->generation is _ZERO or _INF.=20=20
>>
>> Both being _MAX is OK (the control will fall through and use the
>> dates below).  One being _MAX and the other being a normal value is
>> also OK (the above comparisons will declare the commit with _MAX is
>> farther than less-than-max one from a root).
>>
>> Or is the assumption that if one has _ZERO, that must have come from
>> an ancient commit-graph file and none of the commits have anything
>> but _ZERO?
>
> There is stronger and weaker version of the negative-cut criteria based
> on generation numbers.
>
> The strong criteria:
>
>   if A !=3D B and gen(A) <=3D gen(B), then A cannot reach B
>
> The weaker criteria:
>
>   if gen(A) < gen(B), then A cannot reach B
>
>
> Because commit-graph is closed under reachability, this means that
>
>   if A is in commit graph, and B is outside of it, then A cannot reach B
>
> If A is in commit graph, then either _MAX >=3D gen(A) >=3D 1,
> or gen(A) =3D=3D _ZERO.  Because _INFINITY > _MAX > _ZERO, then we have
>
>   if _MAX >=3D gen(A) >=3D 1 || gen(A) =3D=3D 0, and gen(B) =3D=3D _INFIN=
ITY
>   then A cannot reach B
>
> which also fullfils the weaker criteria
>
>   if gen(A) < gen(B), then A cannot reach B
>
>
> If both A and B are outside commit-graph, i.e. gen(A) =3D gen(B) =3D _INF=
INITY,
> or if both A and B have gen(A) =3D gen(B) =3D _MAX,
> or if both A and B come from old commit graph with gen(A) =3D gen(B) =3D_=
ZERO,
> then we cannot say anything about reachability... and weak criteria
> also does not say anything about reachability.
>
>
> Maybe the following ASCII table would make it clear.
>
>              |                      gen(B)
>              |            ................................ :::::::
> gen(A)       | _INFINITY | _MAX     | larger   | smaller  | _ZERO
> -------------+-----------+----------+----------+----------+--------
> _INFINITY    | =3D         | >        | >        | >        | >
> _MAX         | < Nn      | =3D        | >        | >        | >
> larger       | < Nn      | < Nn     | =3D n      | >        | >
> smaller      | < Nn      | < Nn     | < Nn     | =3D n      | >
> _ZERO        | < Nn      | < Nn     | < Nn     | < Nn     | =3D
>
> Here "n" denotes stronger condition, and "N" denotes weaker condition.
> We have _INFINITY > _MAX > larger > smaller > _ZERO.
>
>
> NOTE however that it is a *tradeoff*.  Using weaker criteria, with
> strict inequality, means that we don't need to handle _INFINITY, _MAX
> and _ZERO corner-cases in a special way; but it also means that we would
> walk slightly more commits than if we used stronger criteria, with less
> or equals.

Actually, if we look at the table above, it turns out that we can use
the stronger version of negative-cut criteria without special-casing all
the possible combinations.  Just use stronger criteria on normal range,
weaker criteria if any of generation numbers is special generation
number.

  if _MAX > gen(A) > _ZERO and
     _MAX > gen(B) > _ZERO then

    if A !=3D B and gen(A) <=3D gen(B) then
      A cannot reach B
    else
      A can reach B

  else /* at least one special case */

    if gen(A) < gen(B) then
      A cannot reach B
    else
      A can reach B


NOTE that it specifically does not matter for created here
compare_commits_by_gen_then_commit_date(), as it requires strict
inequality for sorting - which using weak criteria explains why we don't
need any special cases in the code here.

Best,
--=20
Jakub Nar=C4=99bski

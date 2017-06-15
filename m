Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8706D20401
	for <e@80x24.org>; Thu, 15 Jun 2017 22:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbdFOWBQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 18:01:16 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33003 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdFOWBP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 18:01:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id w12so3057853pfk.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 15:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=aBJRRbXksbKgleG1LGWche2ADr/v+N58TntH1bFW/58=;
        b=L5Tgq6MIf5kEWpVvtjj1NUZABTIpROR7RXzDKd5AouPv8Ulu6sjmacgPO6naEts+wO
         I2dolXhiLhv0VuD7HuTW7yetMWK0cSGGy/gA0E0lyuUhTx+EpF+3mTDvcGDyP8dwErdJ
         kkg6JYriT/G/51sWUohYb8zxNdJjQWtImu3JrvBehNsSyJa7xHnUuSc5pR5nXJY9/kov
         C8M75KUpQP8DI4nEIWxIVJOeDVqr4w/sJcBmsk38zUsvqmCKIzPE+6mxwhK5/A3UStKC
         QP0AmTOyDpLP9qXWaghfWMvE29GkwN8wvjGNf+XrcoPbAmLqj3GXHdagTElHQiOuRoGk
         DhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=aBJRRbXksbKgleG1LGWche2ADr/v+N58TntH1bFW/58=;
        b=jCQXuzjjJ2wQx+8PuuvQL6ccj0Mfo6dj1da7sdAG3clL/d4miALY4EO+ZtmXHeQswo
         E9QX7PH930sipeJruQb+0GyEEe4ZFwdQYDXr5KayDAS8ImsCeLwpn330CH/EBWC6b/Wj
         dR6s3RH1bFo1XrHmjbLgZVa5m/1UnfYpG2S7l/hqFGLsoAMG1s6r+fTg/3ZCc586QxR2
         pCJf8mU0PIu2CzXRUjvhUhWEc4FmP3cOeW0Qg4mO8eAo1flXyzBwucrGgzG5xeREFnBQ
         nTmSULOYKRaq8mPAOR4gUjEIK87I6EiGEZe/Fua3y6gKkI2cpqFOr6/Sa0cmZonPphFb
         camA==
X-Gm-Message-State: AKS2vOzgW1BhCon1M+O3t7AvYXnLvWwvsyLTwEv2L45dbyQi2F1ymaK7
        sPULGiHB7WO2kA==
X-Received: by 10.84.231.136 with SMTP id g8mr8875027plk.257.1497564075083;
        Thu, 15 Jun 2017 15:01:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id g10sm439699pgr.18.2017.06.15.15.01.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 15:01:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] wildmatch test: cover a blind spot in "/" matching
References: <CAPc5daWy3eq-ODwDSbvhvRPH87QR0WMttZQUhmKfcZxs4qvdaQ@mail.gmail.com>
        <20170615211041.22768-1-avarab@gmail.com>
Date:   Thu, 15 Jun 2017 15:01:13 -0700
In-Reply-To: <20170615211041.22768-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 15 Jun 2017 21:10:41 +0000")
Message-ID: <xmqq60fwzz9y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> A negated character class that does not include '/', e.g. [^a-z]:
>
>  - Should match '/' when doing "wildmatch"
>  - Should not match '/' when doing "pathmatch"
>
> Add two tests to cover these cases.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>
> Now with updated commit message, no other changes. Sorry about the
> delay.

Thanks.  I completely forgot about this topic ;-)

>
>  t/t3070-wildmatch.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
> index 7ca69f4bed..8fd70d3aa2 100755
> --- a/t/t3070-wildmatch.sh
> +++ b/t/t3070-wildmatch.sh
> @@ -82,6 +82,7 @@ match 1 0 'foo/bar' 'foo/**/bar'
>  match 1 0 'foo/bar' 'foo/**/**/bar'
>  match 0 0 'foo/bar' 'foo?bar'
>  match 0 0 'foo/bar' 'foo[/]bar'
> +match 0 0 'foo/bar' 'foo[^a-z]bar'
>  match 0 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
>  match 1 1 'foo-bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
>  match 1 0 'foo' '**/foo'
> @@ -225,6 +226,7 @@ pathmatch 0 foo/bba/arr 'foo/*z'
>  pathmatch 0 foo/bba/arr 'foo/**z'
>  pathmatch 1 foo/bar 'foo?bar'
>  pathmatch 1 foo/bar 'foo[/]bar'
> +pathmatch 1 foo/bar 'foo[^a-z]bar'
>  pathmatch 0 foo '*/*/*'
>  pathmatch 0 foo/bar '*/*/*'
>  pathmatch 1 foo/bba/arr '*/*/*'

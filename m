Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5FE920285
	for <e@80x24.org>; Wed, 28 Jun 2017 22:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbdF1WA2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 18:00:28 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34965 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbdF1WA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 18:00:27 -0400
Received: by mail-pf0-f181.google.com with SMTP id c73so39898279pfk.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 15:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TPUm8g1TaLJ3keABlzWhT6uaorKdxoQWrIlH+PW0QrY=;
        b=ZuXZCYqB27H/SiQkAUWoEfmo2RkuJtxkMn4YzMLuX5SXTYySfEerWDM5CNhnGbEegO
         fFjJI2SZXXY5Cl5x3wg5sYnAhmzmWQyy7EvoemwzqfhUJV9djLdf99/IlDsenk3/DUtT
         qaNe0e+uA6g88Rwm9FiolihIhjjBmZkbJbo3TK/5qw0ixFs/yYnx85i52HKPsLYAyUbs
         l2hgpL5OtYq9NQasrPS7LcA0v5kb2bcimED+23/XjZti/FodvrYr4FSsH6LWb2Ux91GI
         5NU5AK1xCRvhEU2I/51u5F38/+G6pM6ZUWGG7J7mI+d1Yook6W+PTEwlBL5FC6CKLuhd
         lADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TPUm8g1TaLJ3keABlzWhT6uaorKdxoQWrIlH+PW0QrY=;
        b=C32BagIqBh79iEwS9rcIgbu3rEc8xIsc++qmlJjSq5NG3PF2CM3djbUVTentvrwd+s
         uEiJ/iAWtLryh/c/RgRYF2RGkgNqHF2RYA6yg/BMuPP9fo9b6ZjSx/Ned2Qshb57+ajT
         3hIaQKsdvpTIYPXLx3zuzQsKLVgnH0IkbrzdfTXP3oqMgUjMOGEW8heTMaEUW+saZnQo
         gKVQdjA5fZ3Y9Y506e+ZXOHwWAwUEvs+KjdoLOqdAHST9OlFhfvHyG4/ZUdWtPd0X39L
         aaAb/F6RSx7l4iztsxU7/4rN2sy3sHqBVozWF9L5/VNC9qzZsdBiLUUYEhim1yevkJZ+
         1HYw==
X-Gm-Message-State: AKS2vOwj8WwKji/I0LOMN5bJHfYQ5S/CZGCy3rSW4ghbPXmncje7Z11Q
        Gvi/Yq8yija0mQ==
X-Received: by 10.84.231.141 with SMTP id g13mr13901728plk.157.1498687226169;
        Wed, 28 Jun 2017 15:00:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88a2:2d61:9b86:f64d])
        by smtp.gmail.com with ESMTPSA id p65sm7781192pfj.8.2017.06.28.15.00.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 15:00:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH v4 4/6] coccinelle: add a rule to make "expression" code use FREE_AND_NULL()
References: <20170615231549.20085-1-avarab@gmail.com>
        <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
        <20170615231549.20085-5-avarab@gmail.com>
        <xmqq7f0byayu.fsf@gitster.mtv.corp.google.com>
        <2122b01f-7627-cd1b-c7df-751c076f90ff@web.de>
        <87injfkd0j.fsf@gmail.com>
Date:   Wed, 28 Jun 2017 15:00:24 -0700
In-Reply-To: <87injfkd0j.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Wed, 28 Jun 2017 23:39:40 +0200")
Message-ID: <xmqqlgobvklj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Late reply, sorry. What version of coccinelle are you running? I have
> 1.0.4 (from Debian) and can't get this to produce the same results as
> what I have.
>
> On top of next, I did:
>
>         Revert "*.[ch] refactoring: make use of the FREE_AND_NULL() macro"
>         Revert "coccinelle: make use of the "expression" FREE_AND_NULL() rule"
>         Revert "coccinelle: make use of the "type" FREE_AND_NULL() rule"
>
> And then generated the patch as usual with `make coccicheck`, and
> applied it. This has your change.
>
> I then re-applied the manual "*.[ch] refactoring" changes
>
> This results in this diff with next:
> ...
>
> These are all cases where we now miss things that should use
> FREE_AND_NULL(), e.g.:
>
>     diff --git a/builtin/am.c b/builtin/am.c
>     index c973bd96dc..2f89338ed7 100644
>     --- a/builtin/am.c
>     +++ b/builtin/am.c
>     @@ -484,7 +484,8 @@ static int run_applypatch_msg_hook(struct am_state *state)
>             ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
>
>             if (!ret) {
>     -               FREE_AND_NULL(state->msg);
>     +               free(state->msg);
>     +               state->msg = NULL;
>                     if (read_commit_msg(state) < 0)
>                             die(_("'%s' was deleted by the applypatch-msg hook"),
>                                     am_path(state, "final-commit"));
>
> So it looks to me like removing the "type T" rule breaks a lot of
> things, but that the change you made to the expression rule is good, and
> we should do that for the "type" rule as well. Your commit says the
> "expression rule already covers it", but this doesn't seem to be the
> case at all.

OK, if an older version of the tool that is otherwise still usable
needs two rules, let's keep the "type T" one by reverting the change
out of 'next' and then have a patch that only rearranges the lines,
something like the attached.

-- >8 --
From: René Scharfe <l.s.r@web.de>
Date: Sun, 25 Jun 2017 10:01:04 +0200
Subject: [PATCH] coccinelle: polish FREE_AND_NULL rules

There are two rules for using FREE_AND_NULL in free.cocci, one for
pointer types and one for expressions.  Both cause coccinelle to remove
empty lines and even newline characters between replacements for some
reason; consecutive "free(x);/x=NULL;" sequences end up as multiple
FREE_AND_NULL calls on the same time.

Rearrange the lines to place the addition of FREE_AND_NULL between
the removals, which causes coccinelle to leave surrounding
whitespace untouched.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/coccinelle/free.cocci | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
index f2d97e755b..179c185d85 100644
--- a/contrib/coccinelle/free.cocci
+++ b/contrib/coccinelle/free.cocci
@@ -15,12 +15,12 @@ type T;
 T *ptr;
 @@
 - free(ptr);
-- ptr = NULL;
 + FREE_AND_NULL(ptr);
+- ptr = NULL;
 
 @@
 expression E;
 @@
 - free(E);
-- E = NULL;
 + FREE_AND_NULL(E);
+- E = NULL;
-- 
2.13.2-659-g904a3dfd54


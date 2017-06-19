Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1FC51FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 22:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbdFSWiG (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 18:38:06 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35358 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdFSWiF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 18:38:05 -0400
Received: by mail-pf0-f169.google.com with SMTP id c73so37923pfk.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 15:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+xHIgxJNzGo1NINSsWOt8j+RTJGdMYX4LEN1hxcugS4=;
        b=jfzT4haU6OpqUu/7QKZUEI44RKOTUsx8CNxaBlC/bm8l0ANAgIGPO8U79aW2EBjxGy
         E7WOaURZQezbHzpMZ5SY2woYFq8FdAlka4k0+h1juo21ix8Gkxl3WzpsnXrOz+GpR/Yn
         7ENKWvVuV0vNBHXSe6zYmQfYOooUQ+de2tLnAV+gpvqzO7pX72wJURvQg8MviWCjvC80
         ZasjNMk0wwgZfPjdYR1fG6uJPQzBMqEYmRh228zDqy/u22gKASuqyZ8N5+7doGTBp+Oq
         VIuPWr/CQlN5hjJw8bHSNh0B+sgXAXVn1XHvLarQLU9U3NHVmcQSby6k9zqoeSg6hIx1
         uLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+xHIgxJNzGo1NINSsWOt8j+RTJGdMYX4LEN1hxcugS4=;
        b=sqEYrh6VmtVl2kN0z33u+TSKCju3hWjvmxVlIckVFScdRZQNO0ar4PIRs1vf0rK7xF
         eoWq1qBcpJjSFvIEN8841BbuO/my393r772AtsgYRgsK+dTbvhWBChJ4H7a2ssvXx6lL
         HGHG1AMyHorW5SqWHGV1hjmPi7NGI/ytAfh9P/r2QhrfJ1JiQqy3fI0eqBYCxVyKzYb4
         z9lz6Fj7W8ZL63qjQWhEk8ZmqcL3+wIcZhueb7s8RxRpdur0jPxXLvq2Gu26ipOAC4vC
         ZHsVwcLsuH37ICSFX6T9SV+xxVaed1cZA2kJqAiOMdRqbwaSBnFFXzpM5d5vZT2I30d1
         o8Lw==
X-Gm-Message-State: AKS2vOwFz4PSW2V/d5hcOEBrIkxa/KIudotY3R8az1o60htB5P4n0rVX
        SoXxmxmIjIUGAUWoVWI5XoTE/Jj/XPku
X-Received: by 10.84.131.101 with SMTP id 92mr28788710pld.279.1497911884913;
 Mon, 19 Jun 2017 15:38:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 19 Jun 2017 15:38:04 -0700 (PDT)
In-Reply-To: <87podz8v6v.fsf@gmail.com>
References: <20170619220036.22656-1-avarab@gmail.com> <CAGZ79kaHXX4ne_hfjVs7PaeLzHc+CbVSZ1hCNz0ebG5F3uJEzg@mail.gmail.com>
 <87podz8v6v.fsf@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Jun 2017 15:38:04 -0700
Message-ID: <CAGZ79kbfQfFkQKANrs5TEKQGF5_kiEf5WR9wyZP6jcixbaqwZQ@mail.gmail.com>
Subject: Re: [PATCH] die routine: change recursion limit from 1 to 1024
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 3:32 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Jun 19 2017, Stefan Beller jotted:
>
>>> Now, git-grep could make use of the pluggable error facility added in
>>> commit c19a490e37 ("usage: allow pluggable die-recursion checks",
>>> 2013-04-16).
>>
>> I think we should do that instead (though I have not looked at the downs=
ides
>> of this), because...
>
> It makes sense to do that in addition to what I'm doing here (or if the
> approach I'm taking doesn't make sense, some other patch to fix the
> general issue in the default handler).
>
> I'm going to try to get around to fixing the grep behavior in a
> follow-up patch, this is a fix for the overzealous recursion detection
> in the default handler needlessly causing other issues.
>
>>>
>>> So let's just set the recursion limit to a number higher than the
>>> number of threads we're ever likely to spawn. Now we won't lose
>>> errors, and if we have a recursing die handler we'll still die within
>>> microseconds.
>>
>> how are we handling access to that global variable?
>> Do we need to hold a mutex to be correct? or rather hope that
>> it works across threads, not counting on it, because each thread
>> individually would count up to 1024?
>
> It's not guarded by a mutex and the ++ here and the reads from it are
> both racy.
>
> However, for its stated purpose that's fine, even if we're racily
> incrementing it and losing some updates some will get through, which is
> good enough for an infinite recursion detection. We don't really care if
> we die at exactly 1 or exactly 1024.
>
>> I would prefer if we kept the number as low as "at most
>> one screen of lines".
>
> In practice this is the case in git, because the programs that would
> encounter this are going to be spawning less than screenfull of threads,
> assuming (as is the case) that each thread might print out one error.
>
> The semantics of that aren't changed with this patch, the difference is
> that you're going to get e.g. N repeats of a meaningful error instead of
> N repeats of either the meaningful error OR "recursion detected in die
> handler", depending on your luck.
>
> I.e. in current git (after a few runs to get an unlucky one):
>
>     $ git grep -P --threads=3D10 '(*LIMIT_RECURSION=3D1)(*LIMIT_MATCH=3D1=
)-?-?-?---$'
>     fatal: recursion detected in die handler
>     fatal: recursion detected in die handler
>     fatal: recursion detected in die handler
>
> Or if you're lucky at least one of these will be the actual error:
>
>     $ git grep -P --threads=3D10 '(*LIMIT_RECURSION=3D1)(*LIMIT_MATCH=3D1=
)-?-?-?---$'
>     fatal: recursion detected in die handler
>     fatal: pcre_exec failed with error code -8
>     fatal: recursion detected in die handler
>     fatal: recursion detected in die handler
>     fatal: recursion detected in die handler
>
> But with this change:
>
>     $ ~/g/git/git-grep -P --threads=3D10 '(*LIMIT_RECURSION=3D1)(*LIMIT_M=
ATCH=3D1)-?-?-?---$'
>     fatal: pcre2_jit_match failed with error code -47: match limit exceed=
ed
>     fatal: pcre2_jit_match failed with error code -47: match limit exceed=
ed
>     fatal: pcre2_jit_match failed with error code -47: match limit exceed=
ed
>
> (The error message is different because I compiled with PCRE v2 locally,
> instead of the system PCRE v1, but that doesn't matter for this example)
>
> Over 1000 runs thish is how that breaks down on my machine, without this
> patch. I've replaced the recursion error with just "R" and the PCRE
> error with "P", and shown them in descending order by occurrence, lines
> without a "P" only printed out the recursion error:
>
>     $ (for i in {1..1000}; do git grep -P --threads=3D10 '(*LIMIT_RECURSI=
ON=3D1)(*LIMIT_MATCH=3D1)-?-?-?---$' 2>&1|perl -pe 's/^fatal: r.*/R/; s/^fa=
tal: p.*/P/' | tr '\n' ' '; echo; done)|sort|uniq -c|sort -nr|head -n 10
>         247 R R
>         136 P R R
>         122 P R
>         112 R R R
>         108 R
>          59 R P R
>          54 R P
>          54 P
>          31 P R R R
>          21 R R P
>
> There's a long tail I've omitted there of alterations to that. As this
> shows in >10% of cases we don't print out any meaningful error at
> all. But with this change:
>
>     $ (for i in {1..1000}; do ~/g/git/git-grep -P --threads=3D10 '(*LIMIT=
_RECURSION=3D1)(*LIMIT_MATCH=3D1)-?-?-?---$' 2>&1|perl -pe 's/^fatal: r.*/R=
/; s/^fatal: p.*/P/' | tr '\n' ' '; echo; done)|sort|uniq -c|sort -nr|head =
-n 10
>         377 P P
>         358 P P P
>         192 P
>          63 P P P P
>           8 P P P P P
>           2 P P P P P P
>
> We will always show a meaningful error, but may of course do so multiple
> times, which is a subject for a fix in git-grep in particular, but the
> point is again, to fix the general case for the default handler.
>
> Something something sorry about the long mail didn't have time to write
> a shorter one :)
>

Actually this convinced me (and it would be lovely to have such observation=
s
in the commit message).

Thanks,
Stefan

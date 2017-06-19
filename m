Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6681B1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 22:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbdFSWdB (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 18:33:01 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34971 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbdFSWdA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 18:33:00 -0400
Received: by mail-wm0-f45.google.com with SMTP id x70so5794342wme.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gjDi1QBRm3QrLW9FrFTkZWdHP1Tv1E+tmFTF21QvlPY=;
        b=lz8sQD4t/SXGS8xU2GzXVOKdEKsWqwOKVG0t9yDkFCxrfUnbRCWgpHhVqadyeEEYfH
         fqb9Yb8k8n4Vd+OQ3BeuGvtok+crvyV9wRFWTNdXlNqBmXLsPHJwUnElBvD5EHy7pZog
         aDWHGPtXIPMVMFQ31WoOag27NPCbEVcucnPJZJa+qqk55EfEEl7GGr+8JkMYNI3dNVHq
         Zsa3KcmMN4AwowtJRIpE/VbWEp30dtM2znzqyeeqYGoST6R+t2hG3XxHMUqD0e0ck128
         O7iK1xLgfE/RQdtRD6ezXfA9ARK/50Dhs7jOV0mCrTLY5pgsUN58/kVp3F5UcWBdHxbe
         kXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=gjDi1QBRm3QrLW9FrFTkZWdHP1Tv1E+tmFTF21QvlPY=;
        b=TTTCYsoEvkl6lFxMjAbU2wonq5S9LXATVy7OYCh8IWwNn1eLSz1TDtrdHEUUMiibxC
         DwMgrQ+td5BxKbPhCPfP6BKtA9xIwbw33DQ2xyUb3TFYcOcjQe4TwArmc0GCj1j9n691
         SAggqQH56JWmWHeMQLmicoJyptFWhN7Fk7w7raEFSKkUGo62VY9NKGz5SWIERZ3PKHff
         FP2w90oKDsz6l1tkYCFcss40Kt8cnvBIF+3RIXrUvmAq+kehyii4IwrFOM4iMk6zf+Gb
         u5M7S9STTVgWOgpn7S9PSapbsFH7EAAXPTleXvp5JCABavl9P+jtJr6HbO1osqMf2qti
         B1Fg==
X-Gm-Message-State: AKS2vOzwlXRfM5RRcEeoBVfW5bd5peFnsaLkCvqv2K3oRQE1L/ENFEnp
        hMrMQKkTURqA4Q==
X-Received: by 10.80.214.89 with SMTP id c25mr2792838edj.13.1497911578785;
        Mon, 19 Jun 2017 15:32:58 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id e17sm6370434ede.14.2017.06.19.15.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 15:32:57 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dN5E8-0005YD-GX; Tue, 20 Jun 2017 00:32:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] die routine: change recursion limit from 1 to 1024
References: <20170619220036.22656-1-avarab@gmail.com> <CAGZ79kaHXX4ne_hfjVs7PaeLzHc+CbVSZ1hCNz0ebG5F3uJEzg@mail.gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAGZ79kaHXX4ne_hfjVs7PaeLzHc+CbVSZ1hCNz0ebG5F3uJEzg@mail.gmail.com>
Date:   Tue, 20 Jun 2017 00:32:56 +0200
Message-ID: <87podz8v6v.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 19 2017, Stefan Beller jotted:

>> Now, git-grep could make use of the pluggable error facility added in
>> commit c19a490e37 ("usage: allow pluggable die-recursion checks",
>> 2013-04-16).
>
> I think we should do that instead (though I have not looked at the downsides
> of this), because...

It makes sense to do that in addition to what I'm doing here (or if the
approach I'm taking doesn't make sense, some other patch to fix the
general issue in the default handler).

I'm going to try to get around to fixing the grep behavior in a
follow-up patch, this is a fix for the overzealous recursion detection
in the default handler needlessly causing other issues.

>>
>> So let's just set the recursion limit to a number higher than the
>> number of threads we're ever likely to spawn. Now we won't lose
>> errors, and if we have a recursing die handler we'll still die within
>> microseconds.
>
> how are we handling access to that global variable?
> Do we need to hold a mutex to be correct? or rather hope that
> it works across threads, not counting on it, because each thread
> individually would count up to 1024?

It's not guarded by a mutex and the ++ here and the reads from it are
both racy.

However, for its stated purpose that's fine, even if we're racily
incrementing it and losing some updates some will get through, which is
good enough for an infinite recursion detection. We don't really care if
we die at exactly 1 or exactly 1024.

> I would prefer if we kept the number as low as "at most
> one screen of lines".

In practice this is the case in git, because the programs that would
encounter this are going to be spawning less than screenfull of threads,
assuming (as is the case) that each thread might print out one error.

The semantics of that aren't changed with this patch, the difference is
that you're going to get e.g. N repeats of a meaningful error instead of
N repeats of either the meaningful error OR "recursion detected in die
handler", depending on your luck.

I.e. in current git (after a few runs to get an unlucky one):

    $ git grep -P --threads=10 '(*LIMIT_RECURSION=1)(*LIMIT_MATCH=1)-?-?-?---$'
    fatal: recursion detected in die handler
    fatal: recursion detected in die handler
    fatal: recursion detected in die handler

Or if you're lucky at least one of these will be the actual error:

    $ git grep -P --threads=10 '(*LIMIT_RECURSION=1)(*LIMIT_MATCH=1)-?-?-?---$'
    fatal: recursion detected in die handler
    fatal: pcre_exec failed with error code -8
    fatal: recursion detected in die handler
    fatal: recursion detected in die handler
    fatal: recursion detected in die handler

But with this change:

    $ ~/g/git/git-grep -P --threads=10 '(*LIMIT_RECURSION=1)(*LIMIT_MATCH=1)-?-?-?---$'
    fatal: pcre2_jit_match failed with error code -47: match limit exceeded
    fatal: pcre2_jit_match failed with error code -47: match limit exceeded
    fatal: pcre2_jit_match failed with error code -47: match limit exceeded

(The error message is different because I compiled with PCRE v2 locally,
instead of the system PCRE v1, but that doesn't matter for this example)

Over 1000 runs thish is how that breaks down on my machine, without this
patch. I've replaced the recursion error with just "R" and the PCRE
error with "P", and shown them in descending order by occurrence, lines
without a "P" only printed out the recursion error:

    $ (for i in {1..1000}; do git grep -P --threads=10 '(*LIMIT_RECURSION=1)(*LIMIT_MATCH=1)-?-?-?---$' 2>&1|perl -pe 's/^fatal: r.*/R/; s/^fatal: p.*/P/' | tr '\n' ' '; echo; done)|sort|uniq -c|sort -nr|head -n 10
        247 R R
        136 P R R
        122 P R
        112 R R R
        108 R
         59 R P R
         54 R P
         54 P
         31 P R R R
         21 R R P

There's a long tail I've omitted there of alterations to that. As this
shows in >10% of cases we don't print out any meaningful error at
all. But with this change:

    $ (for i in {1..1000}; do ~/g/git/git-grep -P --threads=10 '(*LIMIT_RECURSION=1)(*LIMIT_MATCH=1)-?-?-?---$' 2>&1|perl -pe 's/^fatal: r.*/R/; s/^fatal: p.*/P/' | tr '\n' ' '; echo; done)|sort|uniq -c|sort -nr|head -n 10
        377 P P
        358 P P P
        192 P
         63 P P P P
          8 P P P P P
          2 P P P P P P

We will always show a meaningful error, but may of course do so multiple
times, which is a subject for a fix in git-grep in particular, but the
point is again, to fix the general case for the default handler.

Something something sorry about the long mail didn't have time to write
a shorter one :)

>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  usage.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/usage.c b/usage.c
>> index 2f87ca69a8..1c198d4882 100644
>> --- a/usage.c
>> +++ b/usage.c
>> @@ -44,7 +44,9 @@ static void warn_builtin(const char *warn, va_list params)
>>  static int die_is_recursing_builtin(void)
>>  {
>>         static int dying;
>> -       return dying++;
>> +       static int recursion_limit = 1024;
>> +
>> +       return dying++ > recursion_limit;
>>  }
>>
>>  /* If we are in a dlopen()ed .so write to a global variable would segfault
>> --
>> 2.13.1.518.g3df882009
>>

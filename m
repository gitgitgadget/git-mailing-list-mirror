Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFEED20899
	for <e@80x24.org>; Mon, 14 Aug 2017 23:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbdHNX37 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 19:29:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60487 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752665AbdHNX36 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 19:29:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10BC39430A;
        Mon, 14 Aug 2017 19:29:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1WfnTvzck0SI4pHNL5+ku6gdnmM=; b=ds0sO2
        FniY372O8u1UlEIAVoTauywctjYH7RfGXViTH1C+KQ8OBAmvWQuEFR8ARc6YbxUJ
        T3W0Dy19qE9v2I7dv0/IG/tw8MbZ8Z/18V53U3FE53cxtlRfHIgTSujdPGoBA8ur
        zUNCV6sbAMfV/cZrz9S98IVtq8XTN/4qLyfeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ekeXeQX5A6aRotNk0n0H2MvZ/49z/SX7
        ywaYWR5C7vuQZo1jkQpB+KC21YRnM3FWv0OKGu97QHF+XdwYmWTqnhgfZhFaIMTG
        Hf2ZH8k/eRGbs7y8gtvcJNwwDy6CNcDHO79sXB5cY0+uHi4cOFcyuyrv+FIubSpr
        fxcBVMPGIF0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0841A94308;
        Mon, 14 Aug 2017 19:29:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49ED294304;
        Mon, 14 Aug 2017 19:29:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: add style build rule
References: <20170808012554.186051-1-bmwill@google.com>
        <20170814213046.107576-1-bmwill@google.com>
        <20170814213046.107576-3-bmwill@google.com>
        <xmqqd17xu6qg.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbAp0p8-y-UpamU0J65A2P0B9r7KEWM0ZCBv=x4E77sGw@mail.gmail.com>
        <20170814225716.p5airw6j5o6dszbn@sigill.intra.peff.net>
Date:   Mon, 14 Aug 2017 16:29:56 -0700
In-Reply-To: <20170814225716.p5airw6j5o6dszbn@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 14 Aug 2017 18:57:16 -0400")
Message-ID: <xmqqzib1sp6z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BDD315E-8148-11E7-8B83-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I suspect the "-p" version is going to be the one people invoke the most
> often. Should it take the coveted "make style" slot, and the diff get
> pushed off to another target?
>
> I was also confused at first that the "-p" version requires you to stage
> the changes first. I don't know if we can make that less confusing via a
> "make style". Or if it's just something people would get used to. But
> sadly it makes the command not-quite orthogonal to "make test" in the
> workflow. You can't "make style && make test && git add -p".  You have
> to add first, then check style, then you'd want to test that result to
> make sure it didn't change the meaning of the code.

Perhaps.

By the way, I do not know which vintage of /usr/bin/git-clang-format
I happen to have on my box, but I needed a crude workaround patch
(attached at the end) to get it even run.  The first thing it does
is to call load_git_config() and it barfs because I have boolean
configuration variables set to true in the correct way, which it
does not seem to recognise.

As to what it does, the first example I tried may not have been a
great one.  I got this:

        git clang-format --style file --diff --extensions c,h
        diff --git a/cache.h b/cache.h
        index 73e0085186..6462fe25bc 100644
        --- a/cache.h
        +++ b/cache.h
        @@ -1498,11 +1498,8 @@ struct checkout {
                const char *base_dir;
                int base_dir_len;
                struct delayed_checkout *delayed_checkout;
        -	unsigned force:1,
        -		 quiet:1,
        -		 not_new:1,
        -		a_new_field:1,
        -		 refresh_cache:1;
        +	unsigned force : 1, quiet : 1, not_new : 1, a_new_field : 1,
        +		refresh_cache : 1;
         };
         #define CHECKOUT_INIT { NULL, "" }
 
which is not wrong per-se, but I have a mixed feelings.  I do not
want it to complain if the original tried to fit many items on a
single line, but if the original wanted to have one item per line,
I'd rather see it kept as-is.

Anyway, we cannot have perfect checker from the day one, and
considering this is an initial attempt, I'd say it is a good start.

Thanks.

diff --git a/git-clang-format b/git-clang-format
index 60cd4fb25b..e8429b2750 100755
--- a/usr/bin/git-clang-format
+++ b/usr/local/google/home/jch/g/Ubuntu-14.04-x86_64/gitstuff/bin/git-clang-format
@@ -191,10 +191,13 @@ def load_git_config(non_string_options=None):
   out = {}
   for entry in run('git', 'config', '--list', '--null').split('\0'):
     if entry:
-      name, value = entry.split('\n', 1)
-      if name in non_string_options:
-        value = run('git', 'config', non_string_options[name], name)
-      out[name] = value
+      if '\n' in entry:
+        name, value = entry.split('\n', 1)
+        if name in non_string_options:
+          value = run('git', 'config', non_string_options[name], name)
+        out[name] = value
+      else:
+	out[entry] = "true";
   return out
 
 

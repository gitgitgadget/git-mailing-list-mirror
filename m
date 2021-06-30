Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DC2C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 18:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56DBF61468
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 18:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhF3SSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 14:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhF3SSY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 14:18:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5C2C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 11:15:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x12so4562250eds.5
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ahGiqgRF0+p7p+4XfwN08ki+AY6NNIcFrjwle6aVWQY=;
        b=PwHjJikrr4PMZPIIihGOFQImtngtu7UuKEsnIhcIW0nH3Vc1lAphyInMU4q6yt5+bS
         vLC1nbjGxcfFoKIPB6MmDxqye0bmzsCWd/VSzERPHY8XtheBmfZyBaeQL8qGtWtieIdh
         yDVTMewbD3nkNPae7EdB0Euip+bxKlSUeGPxH3fS77CTcJFuK4UcO1EleZeeh/baxhuu
         PAcl2d02k8RpzLJg3MmVI8lU1aBKQS6nDe8bBvl9P+qJKmrdUYOs89OHJU7JdhlhPEjV
         3yOVxgewrTZ4QpKruwvbd0MiL9jsYKQFdCPjY/FI0A6UdZvHqLLEz9GjgaUbzwqrWOMC
         YxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ahGiqgRF0+p7p+4XfwN08ki+AY6NNIcFrjwle6aVWQY=;
        b=h66v0OHr/0SKWi3JDge+jrOT0o649wnGDtN+EIbAjDQuLvhenS+awloBwkEMCHKJrm
         YLQXuSZOC2P1frSiuoFHWfgA+XtNpuujIaPtwR//l+pd2zMD/yt3skjkkxC9Y2u/2eNl
         GTHhh/IVlt5VClzpviq6BdiluhT5HWDXdOeYDWOK36geYLxkQWnjlg/Wd1bejAhOCZzd
         2fT90Y8mxUTgNFbe9Z4Rwvwv/rvI3dDhQ8W443J/vpMy771i27uYlD/p0kH1xvoqumWJ
         Xw68TJ536MQTc9IAjKgju2oVuup3E09JsIEtk6/OOOkPopn8H3pQBqR/8/siKvvN5qAN
         lKDQ==
X-Gm-Message-State: AOAM532+i8TUeDXJ9ciJJBr4wcabyOsHveCPmfo92m9hdPk2nRlZ8/+9
        B2jBbbjWSLNUU8zXdqCoLAg=
X-Google-Smtp-Source: ABdhPJxJ/8SObTBEhlmdA746qeO2XkFYH2zWgbwQZgXpSmuQhW0lRIL9245QJa+TvstbyWschQnEZg==
X-Received: by 2002:aa7:db94:: with SMTP id u20mr48502141edt.381.1625076952514;
        Wed, 30 Jun 2021 11:15:52 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a11sm2085159eds.96.2021.06.30.11.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 11:15:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 1/3] bundle cmd: stop leaking memory from
 parse_options_cmd_bundle()
Date:   Wed, 30 Jun 2021 20:00:50 +0200
References: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
 <patch-1.3-3d0d7a8e8b5-20210630T140339Z-avarab@gmail.com>
 <YNypPeoZTRiOxPPQ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YNypPeoZTRiOxPPQ@coredump.intra.peff.net>
Message-ID: <87v95vdxrc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 30 2021, Jeff King wrote:

> On Wed, Jun 30, 2021 at 04:06:14PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Fix a memory leak from the prefix_filename() function introduced with
>> its use in 3b754eedd5 (bundle: use prefix_filename with bundle path,
>> 2017-03-20).
>>=20
>> As noted in that commit the leak was intentional as a part of being
>> sloppy about freeing resources just before we exit, I'm changing this
>> because I'll be fixing other memory leaks in the bundle API (including
>> the library version) in subsequent commits. It's easier to reason
>> about those fixes if valgrind runs cleanly at the end without any
>> leaks whatsoever.
>
> Thanks, this looks good to me.
>
> One thing, though...
>
>> An earlier version of this change went out of its way to not leak
>> memory on the die() codepaths here, but that was deemed too verbose to
>> worry about in a built-in that's dying anyway. The only reason we'd
>> need that is to appease a mode like SANITIZE=3Dleak within the scope of
>> an entire test file.
>
> Obviously you changed this as I asked, but this final sentence makes me
> think we're not on the same page with respect to die(). I don't think
> any kind of mode matters here. When we call die(), whatever we have on
> the stack is _not_ a leak, by LSan's or valgrind's standards. Because we
> still have access to those bytes. And nor can we ever get rid of such
> cases. If we ever do:
>
>   void foo(const char *str)
>   {
> 	char *x =3D xstrdup(str);
> 	bar(x);
> 	free(x);
>   }
>
>   void bar(const char *x)
>   {
> 	if (!strcmp(x, "foo"))
> 		die("whatever");
>   }
>
> Then "x" will always still be allocated when we die(). We cannot free it
> in bar(), where it is read-only. We cannot free it in foo() before we
> call bar(), because it is needed there. But control never returns to the
> free() statement.
>
> So this code is perfectly fine and unavoidable. In the case you were
> touching it was foo() that was calling die() directly, so we could work
> around it with some conditionals. But from the leak-checker's
> perspective the two cases are the same.

I've got you to blame for introducing SANITIZE=3D*. Now I've got these
leak checkers all mixed up :)

Yes you're right, FWIW I (re-)wrote this commit message just before
sending and should have said "a heap leak checker" instead of
"SANITIZE=3Dleak", I really meant valgrind.

I originally ended with the "we are about to die" tracking because I was
tracing things with valgrind, which does complain about this sort of
thing. I.e.:
=20=20=20=20
     24 bytes in 1 blocks are still reachable in loss record 8 of 21
        at 0x48356AF: malloc (vg_replace_malloc.c:298)
        by 0x4837DE7: realloc (vg_replace_malloc.c:826)
        by 0x3C06F1: xrealloc (wrapper.c:126)
        by 0x380EC9: strbuf_grow (strbuf.c:98)
        by 0x381A14: strbuf_add (strbuf.c:297)
        by 0x20ADC5: strbuf_addstr (strbuf.h:304)
        by 0x20B66D: prefix_filename (abspath.c:277)
        by 0x13CDC6: parse_options_cmd_bundle (bundle.c:55)
        by 0x13D565: cmd_bundle_unbundle (bundle.c:170)
        by 0x13D829: cmd_bundle (bundle.c:214)
        by 0x1279F4: run_builtin (git.c:461)
        by 0x127DFB: handle_builtin (git.c:714)

Re what I mentioned/asked in
https://lore.kernel.org/git/87czsv2idy.fsf@evledraar.gmail.com/ I was
experimenting with doing leak checking in the tests.

In this case we have 21 in total under --show-leak-kinds=3Dall (and it was
20 in v2 of this series).

I've found that only including the file tho builtin is in cuts down on
it to a meaningful set of leaks. I.e. to throw out everything not
including /\bbundle\.c:/. We leak in a lot of things we call from
common-main.c, git.c, exec-cmd.c etc.

Maybe if we do end up with a test mode for this we shouldn't care about
checkers like valgrind and only cater to the SANITIZE=3Dleak mode.

I'm still partial to the idea that we'll get the most win out of
something that we can run in the tests by default, i.e. we'll only need
to have a valgrind on the system & have someone run "make test" to run a
(limited set of) tests with this.

Whereas SANITIZE=3Dleak is always a dev-only feature people may not have
on all the time.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D795C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 21:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJRVsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 17:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJRVsh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 17:48:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E9CBB06F
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 14:48:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r17so35575574eja.7
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b32Wppes7NnJfVQOmayh4h73EaCI6+qLT/ZAQ6viEDw=;
        b=q65cve84KQcfxeHBLI+OWFy6d+78hRAS5ZPasWR7jYalTKgjsiXSayUTbTkyYEuHWq
         nC8oByqWRUp3qd0tH/wOIW98bF1WJ9iDyyN8EBPgmeX54v2t4dtHgOPiu27iKoafFq5T
         PguuCooNuObgJ9qWBdI5mtAJLd2cg7NljDPrJSAQsT8IDT+BoZwHq3G7TPQcCSDyEIAS
         csL3XRVKSg3Jo6i3JfynZvGFkB/kxDazxcFO1e2yOJFcGVa7Y/heu4cWOFJZ7w7uwNsm
         7nUNsAmi3JS31Yz/Hk8/sXZxGo4whiLd/WFAg1okwCFoanBMjiThnkwkq3FtpHdPns9D
         Z4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b32Wppes7NnJfVQOmayh4h73EaCI6+qLT/ZAQ6viEDw=;
        b=IyHf+b4XPH96TP7h6QuVpgAOR2ZZBRBwGvQUStbcP4fB9s0JMEaWYZtCuaqPre4NrL
         MHalAtGYi8JY4a8GBSEMd+5K32npyNGsuE5ZpFjUYRbpPt7YeDehJ3H/E1OzSoOdGwP4
         7zfGv3i1432BqDG+jV6Wgt66DN1VI2ukTvarEfVE45T5XZbSpvhpQ09ZDW1vsik34b0e
         hMnL55T2/fquDeSTHszPn3w0BHli38ijALKcSejC8syUsqH8aKVv0iuV+muTy90AMAM6
         Mjg7DD/9LM8UamDH7ZlNzljRQXEFY4luV7uof8VgQfApuNTfKIH0i5W8V+DhIWB1NVPF
         FcYQ==
X-Gm-Message-State: ACrzQf0mUmqmbMe0Ma02r8XXxtTInG50VZ+sbk75BqJXZ4FhAdQhFkiX
        n0e+/fLOaQ2zDA4mmbmfjz0=
X-Google-Smtp-Source: AMsMyM45sLuNApIFlZ0HNeVnM5b1TaVcGwxWNdRz0l/t/mMlinh4nluIVAjMKvCscvQ0USa+etiHZQ==
X-Received: by 2002:a17:907:8a23:b0:78d:b042:eece with SMTP id sc35-20020a1709078a2300b0078db042eecemr4000805ejc.494.1666129714455;
        Tue, 18 Oct 2022 14:48:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j18-20020a508a92000000b00458b8d4f4d5sm9556160edj.57.2022.10.18.14.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 14:48:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okuRs-005sD1-2F;
        Tue, 18 Oct 2022 23:48:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: force -O0 when compiling with SANITIZE=leak
Date:   Tue, 18 Oct 2022 23:00:54 +0200
References: <Y07yeEQu+C7AH7oN@nand.local>
 <Y08BPbWBj7SNluXq@coredump.intra.peff.net>
 <Y08JZVDgJpJvrBiz@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y08JZVDgJpJvrBiz@coredump.intra.peff.net>
Message-ID: <221018.86k04whkgf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 18 2022, Jeff King wrote:

Note that we're discussing two different leak here,
git_config_push_env() one in
https://lore.kernel.org/git/Yxl91jfycCo7O7Pp@coredump.intra.peff.net/;
and now another one that originates in the exit() behavior in
git.c. They're both triggered from t1300, but they're otherwise
unrelated.

> On Tue, Oct 18, 2022 at 03:40:45PM -0400, Jeff King wrote:
>
>> > I suppose we could temporarily mark t1300 as not passing with
>> > SANITIZE=3Dleak turned on, but I tend to agree with Peff that that fee=
ls
>> > like a hack working around compiler behavior, that will ultimately
>> > result in us playing whack-a-mole.
>> >=20
>> > So my preference would be to run the linux-leaks build with `-O0` in i=
ts
>> > CFLAGS, optionally with a newer compiler if one is available for Focal.
>>=20
>> Yes, I still think disabling optimizations is the best path forward. Not
>> just to avoid whack-a-mole, but this is also something we'd eventually
>> need to confront when the code base really is leak-free.
>
> So here's a patch that does so. I think one of =C3=86var's reservations in
> the other thread was not wanting to have to switch optimization levels
> manually for various builds. I think the patch below should make things
> Just Work, whether in CI or running a custom build locally.

No, the opposite. I want to try out various combinations of compile
flags & optimization levels and not have SANITIZE=3Dleak second-guess it.

Now if I want to compile with -O2 and SANITIZE=3Dleak I'll need to
monkeypatch the Makefile.

I'd prefer not to need to do that, because while non-O0 is noisy
sometimes, I've also found that it points (at least indirectly) to some
useful edge-cases.

> The compiler may eliminate "str" as a stack variable, and just leave it
> in a register. The register is preserved through most of the function,
> including across the call to some_func(), since we'd eventually need to
> free it. But because die() is marked with NORETURN, the compiler knows
> that it doesn't need to save registers, and just clobbers it.
>
> When die() eventually exits, the leak-checker runs. It looks in
> registers and on the stack for any reference to the memory allocated by
> str (which would indicate that it's not leaked), but can't find one.  So
> it reports it as a leak.
>
> Neither system is wrong, really. The C standard (mostly section 5.1.2.3)
> defines an abstract machine, and compilers are allowed to modify the
> program as long as the observable behavior of that abstract machine is
> unchanged. Looking at random memory values on the stack is undefined
> behavior, and not something that the optimizer needs to support. But
> there really isn't any other way for a leak checker to work; it
> inherently has to do undefined things like scouring memory for pointers.
> So the two things are inherently at odds with each other. We can't fix
> it by changing the code, because from the perspective of the program
> running in an abstract machine, there is no leak.

In the abstract program yes, there is a leak, and you can see that it
leaks with e.g. valgrind regardless of optimization level:

	$ valgrind --leak-check=3Dfull --show-leak-kinds=3Dall ./git --config-env=
=3Dfoo.flag=3D config --bool foo.flag
        [...]
	=3D=3D6540=3D=3D 13 bytes in 1 blocks are still reachable in loss record 3=
 of 17
	=3D=3D6540=3D=3D    at 0x48437B4: malloc (vg_replace_malloc.c:381)
	=3D=3D6540=3D=3D    by 0x40278B: do_xmalloc (wrapper.c:51)
	=3D=3D6540=3D=3D    by 0x402884: do_xmallocz (wrapper.c:85)
	=3D=3D6540=3D=3D    by 0x4028C0: xmallocz (wrapper.c:93)
	=3D=3D6540=3D=3D    by 0x4028FD: xmemdupz (wrapper.c:109)
	=3D=3D6540=3D=3D    by 0x402962: xstrndup (wrapper.c:115)
	=3D=3D6540=3D=3D    by 0x342F53: strip_path_suffix (path.c:1300)
	=3D=3D6540=3D=3D    by 0x2B4C89: system_prefix (exec-cmd.c:50)
	=3D=3D6540=3D=3D    by 0x2B5057: system_path (exec-cmd.c:268)
	=3D=3D6540=3D=3D    by 0x2C5E17: git_setup_gettext (gettext.c:109)
	=3D=3D6540=3D=3D    by 0x21DC57: main (common-main.c:44)

I think I elaborated on some of this in
https://lore.kernel.org/git/220218.861r00ib86.gmgdl@evledraar.gmail.com/

The tl;dr is that I think you use "leak" in the sense that valgrind
talks about "still reachable" leaks, which is conceptually where
-fsanitize=3Dleak draws the line. I.e. it's not a malloc()/free() tracker,
but tries to see what's "in scope".

This is getting a bit academic, but I don't see how you can both say
that the "compilers are allowed to modify the program as long as the
observable behavior of that abstract machine is unchanged" *and* claim
that e.g. the git_config_push_env() case isn't a real leak.

Because surely the thing that makes it a "leak" by your definition (and
what LSAN strives for) is that it's attributed to a variable that's "in
scope", but the compiler is free to re-arrange all of that.

Anyway, one reason I wanted to punt on that "git --config-env" issue is
because we can entirely avoid the malloc()/free() there. See the "-- >8
--" below, but if we just malloc() after we do our assertions we can
un-confuse clang.

And that seems like a good idea in general, and re whether the "leak" is
gone, at that point valgrind will stop reporting it, so we're really not
leaking at all, not just in the "still reachable" sense.

The reason I mention all of that is to try to define the problem here. I
haven't seen cases where the compilers get it wrong about there being a
leak, it's just that they're mis-categorizing them as "still reachable"
or not, re your "abstract machine" summary.

> This has caused real false positives in the past, like:
>
>   - https://lore.kernel.org/git/patch-v3-5.6-9a44204c4c9-20211022T175227Z=
-avarab@gmail.com/
>
>   - https://lore.kernel.org/git/Yy4eo6500C0ijhk+@coredump.intra.peff.net/
>
>   - https://lore.kernel.org/git/Y07yeEQu+C7AH7oN@nand.local/

Now, the other cases in t1300 are from git.c using exit() instead of
retur-ing to our main().

Among numerous other leak fixes I have queued up I have a fix for that,
which fixes the other t1300 cases that have been reported now:
https://github.com/avar/git/tree/avar/git-c-do-not-exit

So as fuzzy as the "abstract machine" can be sometimes, I've found this
useful.

-- >8 --
Subject: config.c: do sanity checks before xmemdupz()

Adjust the code added in 1ff21c05ba9 (config: store "git -c" variables
using more robust format, 2021-01-12) to avoid allocating a "key"
until after we've done the sanity checks on it.

There was no reason to allocate it this early in the function, except
because we were using the "env_name" pointer we were about to
increment, let's save a copy of it instead.

As a result of this early allocation the "clang" at higher
optimization levels would report that we had a leak here. E.g. with
Debian clang 14.0.6-2 with CFLAGS=3D"-O3 -g":

	$ ./git --config-env=3Dfoo.flag=3D config --bool foo.flag
	fatal: missing environment variable name for configuration 'foo.flag'

	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	=3D=3D18018=3D=3DERROR: LeakSanitizer: detected memory leaks

	Direct leak of 9 byte(s) in 1 object(s) allocated from:
	    #0 0x55e40aad7cd2 in __interceptor_malloc (/home/avar/g/git/git+0x78cd=
2) (BuildId: b89fa8f797ccb02ef1148beed300071a5f9b9ab1)
	    #1 0x55e40ad41071 in do_xmalloc /home/avar/g/git/wrapper.c:51:8
	    #2 0x55e40ad41071 in do_xmallocz /home/avar/g/git/wrapper.c:85:8
	    #3 0x55e40ad41071 in xmallocz /home/avar/g/git/wrapper.c:93:9
	    #4 0x55e40ad41071 in xmemdupz /home/avar/g/git/wrapper.c:109:16
	    #5 0x55e40abec960 in git_config_push_env /home/avar/g/git/config.c:521=
:8
	    #6 0x55e40aadb8b9 in handle_options /home/avar/g/git/git.c:268:4
	    #7 0x55e40aada68d in cmd_main /home/avar/g/git/git.c:896:2
	    #8 0x55e40abae219 in main /home/avar/g/git/common-main.c:57:11
	    #9 0x7fbb5287e209 in __libc_start_call_main csu/../sysdeps/nptl/libc_s=
tart_call_main.h:58:16
	    #10 0x7fbb5287e2bb in __libc_start_main csu/../csu/libc-start.c:389:3
	    #11 0x55e40aaac130 in _start (/home/avar/g/git/git+0x4d130) (BuildId: =
b89fa8f797ccb02ef1148beed300071a5f9b9ab1)

	SUMMARY: LeakSanitizer: 9 byte(s) leaked in 1 allocation(s).
	Aborted

This has come up before, with an earlier proposed fix of mine[1] to
sweep this under the rug.

The actual meaningful fix here is that we don't need to do this
allocation at all. The only reason it's needed is because there's no
variant of "sq_quote_buf()" in quote.c that takes a "len"
parameter (but I have one locally).

If we had that we could just pass a "key" and "key_len" to
git_config_push_split_parameter() instead and avoid the allocation
altogether. But in lieu of that better fix (which other API users of
quote.c would benefit from) let's defer the allocation, which happens
to fix the leak reporting on

1. https://lore.kernel.org/git/patch-1.1-fb2f0a660c0-20220908T153252Z-avara=
b@gmail.com/

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index cbb5a3bab74..e49fd87bbd3 100644
--- a/config.c
+++ b/config.c
@@ -512,13 +512,14 @@ void git_config_push_parameter(const char *text)
 void git_config_push_env(const char *spec)
 {
 	char *key;
+	const char *p;
 	const char *env_name;
 	const char *env_value;
=20
 	env_name =3D strrchr(spec, '=3D');
 	if (!env_name)
 		die(_("invalid config format: %s"), spec);
-	key =3D xmemdupz(spec, env_name - spec);
+	p =3D env_name;
 	env_name++;
 	if (!*env_name)
 		die(_("missing environment variable name for configuration '%.*s'"),
@@ -529,6 +530,7 @@ void git_config_push_env(const char *spec)
 		die(_("missing environment variable '%s' for configuration '%.*s'"),
 		    env_name, (int)(env_name - spec - 1), spec);
=20
+	key =3D xmemdupz(spec, p - spec);
 	git_config_push_split_parameter(key, env_value);
 	free(key);
 }
--=20
2.38.0.1093.gcd4a685f0b1


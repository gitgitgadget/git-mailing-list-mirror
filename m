Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52D0C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DA960C40
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhJ1SlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhJ1Sk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 14:40:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3566BC061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:38:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h7so29147650ede.8
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=I9V7NrHTe3QvvYK/L6Hfs4Lxp0nuETM88wSn0+4wfEI=;
        b=k19wiutXsfEKHW+K3GZoQbThand44sA8HgDLgtBvA+BUUV8pFlBujuKecOvN9dgjyD
         /h3FDuBdTDI8TB++e80AevKdHmpnCHbmrx242s0DmNPw7m7iPN1h5zCN9NE3nNE+p5oY
         yQCrOd2GRAJDYBKM3YnCE7JE0Mbptz6k+8T+LV0mMVwRysoF9NMYhpK3yjL5dNcR/HLK
         65BDKf+pljq5qsT37y7OrlUdSlh4RFRsTwDjl7McPl/Irktonp2zk0rAE2Iazepv9XJU
         eiGwg+IqeFx05EpJUPhuMZHFp39iyWlug++/lUQ7JtHiW2XgbWkFgAAjxRbk9ZEvonvF
         4FMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=I9V7NrHTe3QvvYK/L6Hfs4Lxp0nuETM88wSn0+4wfEI=;
        b=GBhegbqo39iG3d3WwgFzT8LMgnQ3quifYOjyoqUzG4L3mMbkpwO1qq0gqqmR2tIQP5
         uFnnwqqnJuWKc54wgPJisEVg7ONTt1IaV/YLN1M+dB8zKg7wmkPx3Wjdihg4DaP+/ZxF
         xr3E86mYJEKKVNyMQg5nLX0QD/beSZQKQb11XriSlRAa6u1W73qRtpq2yxl5TymjFs5z
         KmF37FrPurl9V12fRT+DC5OCrq+evnR05oH7PTErskOPSYkursmfScb/GzicCie/zZge
         ty19FwLRsdI2n9P3CEMW2Nm7/OuchMZRZcLaKh/kqn4B8/czyhvHNZXmE3x1xmAIWB9O
         Fzrw==
X-Gm-Message-State: AOAM532q9gV8L7XZoK9Hf2RtHXCZGzeKTXedg0cGMz4rt7snCrRZwfXF
        ZxtxI931ocCsLizbKS/WUtA=
X-Google-Smtp-Source: ABdhPJxuuDRfZUPJm5Y5dZco1nOlPM7HVHoNFuoMJpvEqCq7zcZMGCXDzRyk420wNfalh6XWCQW8LA==
X-Received: by 2002:a05:6402:17db:: with SMTP id s27mr110961edy.325.1635446307645;
        Thu, 28 Oct 2021 11:38:27 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b9sm2161464edk.62.2021.10.28.11.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:38:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mgAIE-0023px-JN;
        Thu, 28 Oct 2021 20:38:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Documentation/Makefile: fix lint-docs mkdir dependency
Date:   Thu, 28 Oct 2021 20:30:13 +0200
References: <YXeu4Hl2cmIPqobd@coredump.intra.peff.net>
 <xmqqlf2et3r3.fsf@gitster.g> <211028.861r45y3pt.gmgdl@evledraar.gmail.com>
 <YXq1OE/p5VoPR3WZ@coredump.intra.peff.net> <xmqqzgqtrtd1.fsf@gitster.g>
 <YXrYh9aPA8csq+UQ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXrYh9aPA8csq+UQ@coredump.intra.peff.net>
Message-ID: <211028.86o879vvtp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 28 2021, Jeff King wrote:

> On Thu, Oct 28, 2021 at 09:45:14AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>=20
>> > There's an in-between, I'd think, where the many "foo/bar/baz/$@"
>> > targets have an order-dependency on "foo/bar/baz", and that single rule
>> > uses "mkdir -p" to create all of the directories.
>> >
>> > It doesn't buy us much simplification in this case, though, because
>> > various rules independently depend on .build/gitlink/lint-docs/howto,
>> > .built/gitlink/lint-docs, and .build/gitlink, etc. So we still end up
>> > with roughly the same number of rules, though the directory rules don't
>> > have to depend on one another.
>> >
>> > It also means that these "mkdir -p" may race with each other, though in
>> > general I'd hope that most "mkdir" implements could handle this.
>> >
>> > Something like this works, I think:
>>=20
>> Hmph, what I actually meant was to make sure that the recipe to
>> create the files to have "mkdir -p $(basename $@)" in front, instead
>> of having "we need to prepare the containing directory in order to
>> have a file there" in the makefile.
>
> Yeah, I agree that's simpler, and is what =C3=86var showed. But it is slo=
wer,
> because we run a bunch of redundant "mkdir -p" calls, one per file.

Here's a method that's both less verbose in lines & also faster, but
maybe too clever a use of GNU make features, on top of "next".

It relies on $(wildcard) returning an empty list on a non-existing
filename, and then on $(if) to either expand to "mkdir -p $(@D)", or
nothing, and (perhaps in an ugly way?) piggy-backs on an existing $@
rule, so one rule has two $(QUIET_*) uses.

With:

    HEAD~2 =3D next
    HEAD~1 =3D unconditional mkdir -p, upthread <211028.861r45y3pt.gmgdl@ev=
ledraar.gmail.com>
    HEAD =3D the below patch

We get these results, i.e. it's also faster:
=20=20=20=20
    $ hyperfine --warmup 5 -m 30 -L s ",~,~2" -p 'git checkout HEAD{s} -- M=
akefile; rm -rf .build' 'make -j8 lint-docs R=3D{s}' -c 'git checkout HEAD =
-- Makefile'
    Benchmark #1: make -j8 lint-docs R=3D
      Time (mean =C2=B1 =CF=83):     628.5 ms =C2=B1  43.2 ms    [User: 2.3=
85 s, System: 0.445 s]
      Range (min =E2=80=A6 max):   605.6 ms =E2=80=A6 787.7 ms    30 runs
    Benchmark #2: make -j8 lint-docs R=3D~
      Time (mean =C2=B1 =CF=83):     770.2 ms =C2=B1  12.7 ms    [User: 3.4=
46 s, System: 0.666 s]
      Range (min =E2=80=A6 max):   756.3 ms =E2=80=A6 831.4 ms    30 runs
    Benchmark #3: make -j8 lint-docs R=3D~2
      Time (mean =C2=B1 =CF=83):     696.9 ms =C2=B1   3.5 ms    [User: 2.9=
67 s, System: 0.600 s]
      Range (min =E2=80=A6 max):   691.2 ms =E2=80=A6 706.2 ms    30 runs
    Summary
      'make -j8 lint-docs R=3D' ran
        1.11 =C2=B1 0.08 times faster than 'make -j8 lint-docs R=3D~2'
        1.23 =C2=B1 0.09 times faster than 'make -j8 lint-docs R=3D~'

The one negative thing is that we'll return an inconsistent set of
"mkdir" lines, since it's racy, but here we're using the race to our
benefit. It doesn't matter for the end result if we e.g. created a more
nested directory first, or needed two "mkdir -p" calls because we did a
shallower one first.

Do you think it's worth submitting that as a non-throwaway?

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ed656db2ae9..99c2f9d02cf 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -234,6 +234,7 @@ ifndef V
 	QUIET_DBLATEX	=3D @echo '   ' DBLATEX $@;
 	QUIET_XSLTPROC	=3D @echo '   ' XSLTPROC $@;
 	QUIET_GEN	=3D @echo '   ' GEN $@;
+	QUIET_MKDIR_P	=3D @echo '   ' MKDIR -p $(@D);
 	QUIET_STDERR	=3D 2> /dev/null
 	QUIET_SUBDIR0	=3D +@subdir=3D
 	QUIET_SUBDIR1	=3D ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
@@ -463,25 +464,10 @@ quick-install-html: require-htmlrepo
 print-man1:
 	@for i in $(MAN1_TXT); do echo $$i; done
=20
-## Lint: Common
-.build:
-	$(QUIET)mkdir $@
-.build/lint-docs: | .build
-	$(QUIET)mkdir $@
-
-## Lint: gitlink
-.build/lint-docs/gitlink: | .build/lint-docs
-	$(QUIET)mkdir $@
-.build/lint-docs/gitlink/howto: | .build/lint-docs/gitlink
-	$(QUIET)mkdir $@
-.build/lint-docs/gitlink/config: | .build/lint-docs/gitlink
-	$(QUIET)mkdir $@
 LINT_DOCS_GITLINK =3D $(patsubst %.txt,.build/lint-docs/gitlink/%.ok,$(HOW=
TO_TXT) $(DOC_DEP_TXT))
-$(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink
-$(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink/howto
-$(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink/config
 $(LINT_DOCS_GITLINK): lint-gitlink.perl
 $(LINT_DOCS_GITLINK): .build/lint-docs/gitlink/%.ok: %.txt
+	$(if $(wildcard $(@D)),,$(QUIET_MKDIR_P)$(shell mkdir -p $(@D)))
 	$(QUIET_LINT_GITLINK)$(PERL_PATH) lint-gitlink.perl \
 		$< \
 		$(HOWTO_TXT) $(DOC_DEP_TXT) \
@@ -492,23 +478,19 @@ $(LINT_DOCS_GITLINK): .build/lint-docs/gitlink/%.ok: =
%.txt
 lint-docs-gitlink: $(LINT_DOCS_GITLINK)
=20
 ## Lint: man-end-blurb
-.build/lint-docs/man-end-blurb: | .build/lint-docs
-	$(QUIET)mkdir $@
 LINT_DOCS_MAN_END_BLURB =3D $(patsubst %.txt,.build/lint-docs/man-end-blur=
b/%.ok,$(MAN_TXT))
-$(LINT_DOCS_MAN_END_BLURB): | .build/lint-docs/man-end-blurb
 $(LINT_DOCS_MAN_END_BLURB): lint-man-end-blurb.perl
 $(LINT_DOCS_MAN_END_BLURB): .build/lint-docs/man-end-blurb/%.ok: %.txt
-	$(QUIET_LINT_MANEND)$(PERL_PATH) lint-man-end-blurb.perl $< >$@
+	$(if $(wildcard $(@D)),,$(QUIET_MKDIR_P)$(shell mkdir -p $(@D)))
+	$(QUIET_LINT_MANEND)$($(PERL_PATH) lint-man-end-blurb.perl $< >$@
 .PHONY: lint-docs-man-end-blurb
 lint-docs-man-end-blurb: $(LINT_DOCS_MAN_END_BLURB)
=20
 ## Lint: man-section-order
-.build/lint-docs/man-section-order: | .build/lint-docs
-	$(QUIET)mkdir $@
 LINT_DOCS_MAN_SECTION_ORDER =3D $(patsubst %.txt,.build/lint-docs/man-sect=
ion-order/%.ok,$(MAN_TXT))
-$(LINT_DOCS_MAN_SECTION_ORDER): | .build/lint-docs/man-section-order
 $(LINT_DOCS_MAN_SECTION_ORDER): lint-man-section-order.perl
 $(LINT_DOCS_MAN_SECTION_ORDER): .build/lint-docs/man-section-order/%.ok: %=
.txt
+	$(if $(wildcard $(@D)),,$(QUIET_MKDIR_P)$(shell mkdir -p $(@D)))
 	$(QUIET_LINT_MANSEC)$(PERL_PATH) lint-man-section-order.perl $< >$@
 .PHONY: lint-docs-man-section-order
 lint-docs-man-section-order: $(LINT_DOCS_MAN_SECTION_ORDER)

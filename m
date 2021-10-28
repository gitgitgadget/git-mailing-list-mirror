Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91000C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 08:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77929610C7
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 08:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhJ1IHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 04:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1IHb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 04:07:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F085EC061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 01:05:04 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r4so20795293edi.5
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 01:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=rsdkFIJJoZHZoBvIvUWPv3M1sRJ/ptR0OVA6DA1a2fE=;
        b=Ut4jsSgdS2us0kzX2Dy2lkL4nWB+eC8rfqjcEt58HkH1nmlgIwV7P1/Tstdem3vlfU
         LWmAfErof9dqOxxFU60CEz5lxoFMDP8l4gH4YkzaxLlzT0DEJYBam4WW5enw4gzhY9AT
         Vzn30b5rbcCnd/RA1GoAJPSceoC43vHTwGJUm38hpMiRszgCBNc8U98+F9ILlqQKHjGK
         dumWk/rfvJeu58EVpnFuJ/C4weJ84r6p62CRCol8oCnAI9JwJSeVY5jTJiIW4xsKFigi
         T4jROVEQnX02VIiOautV8goCOkmGrilw4iJScYV9po8+BGv6k7SRi+NCE89ERAfv2HFJ
         PnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=rsdkFIJJoZHZoBvIvUWPv3M1sRJ/ptR0OVA6DA1a2fE=;
        b=g97URsJXsfh/i7axAS/FK2Q5DXsLmeVuzrPCK6myYDo+p+VGpaUERSaviWhBEve3i2
         iWeQ6WILnP+3fCKjLA3dTVBDdQ7/Jlpkgm+47ApaA9QngAWsc36mKTiXUpZfKT5wd5Uv
         SfSH37sK/u5pFYeqpXtiQXMtTLATAaLnoVfdW6vxAd2bCIUEQ5kihOK2OuAdLWkCOIHm
         bJfq/gNMopF2Pw1MlmF5vdrlD6gw5l/TSPYdO7Zn1BlCUlyjn+zorEGxzEhAUViQjTcR
         KPPjzYcJJgrUZp68HtvKSMnJCtBWMn0XQDjQk301gzmUhfteeQqztOb+IAQKPwDscYeZ
         trIg==
X-Gm-Message-State: AOAM533BN1Gurm2E7Myo49sLd3ipQWNfNn882n2wRnr8SSAvU9s0JK5A
        bkQLr11+G1RX+zJP2iWGT1s9Ff4ekD0=
X-Google-Smtp-Source: ABdhPJwiRW+Pjqb5D024F7pt+UxPez10uSdvmCA+OJrMCDX5WJosrkgNPXbdmBdH5jeia04XuBBA6w==
X-Received: by 2002:a17:906:1451:: with SMTP id q17mr3437583ejc.36.1635408303359;
        Thu, 28 Oct 2021 01:05:03 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h10sm1167998edf.85.2021.10.28.01.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 01:05:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mg0PG-0022FO-JZ;
        Thu, 28 Oct 2021 10:05:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] Documentation/Makefile: fix lint-docs mkdir dependency
Date:   Thu, 28 Oct 2021 09:48:51 +0200
References: <YXeu4Hl2cmIPqobd@coredump.intra.peff.net>
 <xmqqlf2et3r3.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqlf2et3r3.fsf@gitster.g>
Message-ID: <211028.861r45y3pt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 27 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> Since 8650c6298c (doc lint: make "lint-docs" non-.PHONY, 2021-10-15), we
>> put the output for gitlink linter into .build/lint-docs/gitlink. There
>> are order-only dependencies to create the sequence of subdirs like:
>>
>>   .build/lint-docs: | .build
>>           $(QUIET)mkdir $@
>>   .build/lint-docs/gitlink: | .build/lint-docs
>>           $(QUIET)mkdir $@
>>
>> where each level has to depend on the prior one (since the parent
>> directory must exist for us to create something inside it). But the
>> "howto" and "config" subdirectories of gitlink have the wrong
>> dependency; they depend on "lint-docs", not "lint-docs/gitlink".
>
> Thanks.
>
> I wonder if we can somehow avoid this unwieldy chain of commands,
> perhaps with using "mkdir -p" somewhere, or make the lint scripts
> create the necessary leading paths.  From the looks of the tail end
> of Documentation/Makefile, the latter may be the cleaner solution.

Simplest would be to simply do the "mkdir -p" unconditionally, which we
do in some other places. The diff below on top of next would do that.

I didn't do it because it slows things down quite a bit. Here HEAD is
the diff below:
=20=20=20=20
    $ hyperfine --warmup 5 -m 30 -L s ",~" -p 'git checkout HEAD{s} -- Make=
file; rm -rf .build' 'make -j8 lint-docs R=3D{s}' -c 'git checkout HEAD -- =
Makefile'
    Benchmark #1: make -j8 lint-docs R=3D
      Time (mean =C2=B1 =CF=83):     709.7 ms =C2=B1  25.7 ms    [User: 3.5=
84 s, System: 0.696 s]
      Range (min =E2=80=A6 max):   691.4 ms =E2=80=A6 833.1 ms    30 runs
=20=20=20=20=20
    Benchmark #2: make -j8 lint-docs R=3D~
      Time (mean =C2=B1 =CF=83):     647.3 ms =C2=B1   5.5 ms    [User: 3.0=
81 s, System: 0.635 s]
      Range (min =E2=80=A6 max):   638.4 ms =E2=80=A6 670.6 ms    30 runs
=20=20=20=20=20
    Summary
      'make -j8 lint-docs R=3D~' ran
        1.10 =C2=B1 0.04 times faster than 'make -j8 lint-docs R=3D'

You can do this with make macros via $(eval) calling a $(foreach) loop,
i.e. just generate the boilerplate we have now. For this case I thought
it wasn't worth it, but figured I could eventually loop back to it
if/when we use a nested structure inside a ".build directory more
widely.

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ed656db2ae9..8a185e89e55 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -463,26 +463,11 @@ quick-install-html: require-htmlrepo
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
-	$(QUIET_LINT_GITLINK)$(PERL_PATH) lint-gitlink.perl \
+	$(QUIET_LINT_GITLINK)mkdir -p $(@D) && \
+	$(PERL_PATH) lint-gitlink.perl \
 		$< \
 		$(HOWTO_TXT) $(DOC_DEP_TXT) \
 		--section=3D1 $(MAN1_TXT) \
@@ -492,24 +477,20 @@ $(LINT_DOCS_GITLINK): .build/lint-docs/gitlink/%.ok: =
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
+	$(QUIET_LINT_MANEND)mkdir -p $(@D) && \
+	$(PERL_PATH) lint-man-end-blurb.perl $< >$@
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
-	$(QUIET_LINT_MANSEC)$(PERL_PATH) lint-man-section-order.perl $< >$@
+	$(QUIET_LINT_MANSEC)mkdir -p $(@D) && \
+	$(PERL_PATH) lint-man-section-order.perl $< >$@
 .PHONY: lint-docs-man-section-order
 lint-docs-man-section-order: $(LINT_DOCS_MAN_SECTION_ORDER)
=20

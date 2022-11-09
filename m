Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCECC433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 01:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiKIB5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 20:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKIB5t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 20:57:49 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7FD66C8A
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 17:57:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id a5so25146825edb.11
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 17:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W55OCrDyCmPA3ODpDIjKUpDJncDsFu2uaFN1CaJgtH8=;
        b=PAZgsxxX+UOL+q1XXWnun972GnK+KtzGV/WBAP5O4NaJGSBY9Xxg8+i02nOnSJCyJD
         xlvTyi+YmE1i3+H2LHH3bHWvpLJwM9JTQRY9j8plbXrc33dd9gq4If5s9jY7wBj6GJro
         cnhADRsyeiTm60AfrvoIjVB4wjn99hk1fC+dTjLDHiuhjXWPj2sklzbMEAIJAZG9LhNm
         XanbHpOlOMspsOga14lqdMQ03ebFMTRM3hyAO7adrXVI+fDRbpbZuSmpG0xi6X/r00i/
         bm0hSJVRp+XLO+86W01MDlPFMBYUWGVlaXIXdmDldmRc6vIpQConfBzXD8ZesC9DA0ZN
         YA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W55OCrDyCmPA3ODpDIjKUpDJncDsFu2uaFN1CaJgtH8=;
        b=sbW8k3T26f+azqNVe7GQ2Q6Y79muUKNhr1X3dlMaH+Zpu1AXHhYEwsd/P11obtroSA
         ye+KnJrIAW+iupdgDR0uPSnIM7sibUs5ApTzVpnbDbRl2DMy8AeGRwFVAZ2gjYSTYvlG
         TklA09XBN+Hifr6TEsy0sA09lj+qNSkNeB8E+qTUExH7LEpDU+CtjVdt9Oi8skbR858j
         hRsMGpBTwtBZz+SZ6IU1dlG0kymRPLxJmPL4Jo5Kt3fd5sJnG7vlykCQwHmn4YWTzeqE
         aBusJNX2xh/Q3gk8PgzsvZAsQy9k0jw53c5GA6mEX5RBrp6xfSY4vaYGksCCgcgESdHh
         yBAQ==
X-Gm-Message-State: ACrzQf2bdIP1ja+nIfd1InwAHWS8wJPUVJmZh+J81LCR+R4VFx+7JsI7
        ky+rLrYnJ2bqRUf+YME9U3T2DpOZJd6bgw==
X-Google-Smtp-Source: AMsMyM6vtSF2bXSH8J/9sMbWk53pKuub0HaHF3x58XLPgnhKVZVSjieNDtZVtfMB+MPo8Sq5SYR/0A==
X-Received: by 2002:a05:6402:5483:b0:45c:1336:6d9b with SMTP id fg3-20020a056402548300b0045c13366d9bmr59103507edb.100.1667959064748;
        Tue, 08 Nov 2022 17:57:44 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id g22-20020a50ee16000000b004616b006871sm6299700eds.82.2022.11.08.17.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 17:57:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osaLX-000mrm-1j;
        Wed, 09 Nov 2022 02:57:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v8 06/12] docs: move commit-graph format docs to man
 section 5
Date:   Wed, 09 Nov 2022 02:34:03 +0100
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
 <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
 <patch-v8-06.12-df3ef265d45-20220804T162138Z-avarab@gmail.com>
 <20221108180417.GB1731@szeder.dev>
 <221108.86mt91qmkq.gmgdl@evledraar.gmail.com>
 <20221108212741.GC1731@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221108212741.GC1731@szeder.dev>
Message-ID: <221109.86bkpgriso.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 08 2022, SZEDER G=C3=A1bor wrote:

> On Tue, Nov 08, 2022 at 08:16:49PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Tue, Nov 08 2022, SZEDER G=C3=A1bor wrote:
>>=20
>> > On Thu, Aug 04, 2022 at 06:28:35PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >> Continue the move of existing Documentation/technical/* protocol and
>> >> file-format documentation into our main documentation space.
>> >>=20
>> >> By moving the documentation for the commit-graph format into man
>> >> section 5 and the new "developerinterfaces" category. This change is
>> >> split from subsequent commits due to the relatively large amount of
>> >> ASCIIDOC formatting changes that are required.
>> >
>> > So after this series I got a couple of gitformat-* manpages, but,
>> > alas, most of them render improperly: a lot of paragraphs are for some
>> > reason fixed width even in a fullscreen terminal window, and their
>> > width is more than 80 chars, so they are rather awkward in a
>> > standard-width terminal.  This also affects the html version, where
>> > those paragraphs are rendered with a fixed-width font.
>>=20
>> Do you have examples of that
>
> Here's the description of two chunks copy-pasted from 'man
> gitformat-commit-graph' in a full-screen terminal, the first being
> properly formatted (i.e. line length adjusted to the width of the
> terminal), the latter having fixed-width:
>
>        Generation Data Overflow (ID: {G, D, O, 2 }) [Optional]
>            =E2=80=A2   This list of 8-byte values stores the corrected co=
mmit date offsets for commits with corrected commit date offsets that canno=
t be stored within 31 bits.
>
>            =E2=80=A2   Generation Data Overflow chunk is present only whe=
n Generation Data chunk is present and atleast one corrected commit date of=
fset cannot be stored within 31 bits.
>
>        Extra Edge List (ID: {E, D, G, E}) [Optional]
>                This list of 4-byte values store the second through nth pa=
rents for
>                all octopus merges. The second parent value in the commit =
data stores
>                an array position within this list along with the most-sig=
nificant bit
>                on. Starting at that array position, iterate through this =
list of commit
>                positions for the parents until reaching a value with the =
most-significant
>                bit on. The other bits correspond to the position of the l=
ast parent.
>
> There are similar formating issues in 'gitformat-index' and
> 'gitformat-pack' as well.  I can see these both with AsciiDoc and
> Asciidoctor.

Yeah, they look pretty bad.

>> and are these cases where the formatting
>> was different before the move from Documentation/technical/*
>>=20
>> I'm aware of e.g. gitformat-commit-graph(5) being somewhat funny, and
>> may have missed some cases, but I think that was also the case before...
>
> I'm not sure about "before", because 'make man' never built and
> installed these gitformat-* manpages before this series.

In the case of "gitformat-commit-graph" there was never a "html" version
of it before c0f6dd49f19 (Merge branch 'ab/tech-docs-to-help',
2022-08-14). But if you check out c0f6dd49f19^1 and:
=09
	diff --git a/Documentation/Makefile b/Documentation/Makefile
	index 4f801f4e4c9..d7a066a68d0 100644
	--- a/Documentation/Makefile
	+++ b/Documentation/Makefile
	@@ -96,6 +96,7 @@ TECH_DOCS +=3D SubmittingPatches
	 TECH_DOCS +=3D ToolsForGit
	 TECH_DOCS +=3D technical/bitmap-format
	 TECH_DOCS +=3D technical/bundle-format
	+TECH_DOCS +=3D technical/commit-graph-format
	 TECH_DOCS +=3D technical/cruft-packs
	 TECH_DOCS +=3D technical/hash-function-transition
	 TECH_DOCS +=3D technical/http-protoco

Then "make html" you'll see what the formatting was like before. Here's
generated versions of those & git-scm.com's version for comparison:

	https://vm.nix.is/~avar/noindex/2022-11-09-gitdocs/commit-graph-format.html
	https://git-scm.com/docs/gitformat-commit-graph
        https://vm.nix.is/~avar/noindex/2022-11-09-gitdocs/index-format.html
	https://git-scm.com/docs/gitformat-index
        https://vm.nix.is/~avar/noindex/2022-11-09-gitdocs/pack-format.html
        https://git-scm.com/docs/gitformat-pack

They should obviously be fixed, but I left that out of scope of that
series. If it was a fix-syntax-nits-while-at-it it would have been a lot
longer, and some of it's in some pseudo-syntax that was never quite
valid markdown. E.g. commit-graph-format.txt tried to use link:* syntax
in block-quoted text.

What I found *mostly* worked was to use "=3D=3D" for sections, which
e.g. for gitformat-commit-graph ends up formatting it nicely as long as
it's followed by a bullet-point list, but as you show with "This lits of
4-byte..." that doesn't do the trick when it's not a list, instead it
uses the literal formatting (which almost the entire body of the text
used before).

I think the most minimal way of fixing it is to de-indent the opening
line of those sections, e.g.:
=09
	diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitf=
ormat-commit-graph.txt
	index 31cad585e23..84df4a3ed03 100644
	--- a/Documentation/gitformat-commit-graph.txt
	+++ b/Documentation/gitformat-commit-graph.txt
	@@ -67,17 +67,17 @@ All multi-byte numbers are in network byte order.
=09=20
	 =3D=3D=3D CHUNK LOOKUP:
=09=20
	-  (C + 1) * 12 bytes listing the table of contents for the chunks:
	+(C + 1) * 12 bytes listing the table of contents for the chunks:
	       First 4 bytes describe the chunk id. Value 0 is a terminating label.
	       Other 8 bytes provide the byte-offset in current file for chunk to
	       start. (Chunks are ordered contiguously in the file, so you can inf=
er
	       the length using the next chunk position if necessary.) Each chunk
	       ID appears at most once.
=09=20
	-  The CHUNK LOOKUP matches the table of contents from
	+The CHUNK LOOKUP matches the table of contents from
	   the chunk-based file format, see linkgit:gitformat-chunk[5]
=09=20
	-  The remaining data in the body is described one chunk at a time, and
	+The remaining data in the body is described one chunk at a time, and
	   these chunks may be given in any order. Chunks are required unless
	   otherwise specified.
=09=20
	@@ -126,7 +126,7 @@ All multi-byte numbers are in network byte order.
	       be stored within 31 bits.
=09=20
	 =3D=3D=3D=3D Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
	-      This list of 4-byte values store the second through nth parents for
	+This list of 4-byte values store the second through nth parents for
	       all octopus merges. The second parent value in the commit data stor=
es
	       an array position within this list along with the most-significant =
bit
	       on. Starting at that array position, iterate through this list of c=
ommit
=09
Seems to fix those "flow" issues for me, i.e. it's now a normal
paragraph, instead of a block-quoted fixed-width text.

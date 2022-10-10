Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D58C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 20:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJJUiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiJJUiI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 16:38:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109263DBC3
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 13:38:04 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 34D701CCF58;
        Mon, 10 Oct 2022 16:38:04 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mjFRlPok0O1a
        XoGdaG4s4zELdClVxqvGJjuUtr4LKVk=; b=GFgYmrmdHDGSBXV+0BSJxpx4BxZ9
        3PAhPdFD8oh8hOxYUw7YxV4E6nm8iG/MWOUve4PM9MwOAnWBlq6iAnN+gX5Zg/aT
        mBukkzMb0H9dMTxL3CxGkHEPcmFwfHnmuej94KsHbFCOv3wO1S3tEPrqmofIRNzb
        PTM2/A6wsNkDGIc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D10B1CCF57;
        Mon, 10 Oct 2022 16:38:04 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 66A9D1CCF55;
        Mon, 10 Oct 2022 16:38:01 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/5] CodingGUidelines: C99 updates
Date:   Mon, 10 Oct 2022 13:37:55 -0700
Message-Id: <20221010203800.2154698-1-gitster@pobox.com>
X-Mailer: git-send-email 2.38.0-140-gc6454a6c7f
In-Reply-To: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 6EEBF402-48DB-11ED-8CEE-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As this is otherwise clearly good series, I got sick of waiting for
a trivial update, so here is what I did to update them myself.

Updates are in patches 3 and 4.  We promised to revisit the issue of
allowing "for (int i =3D 0; ..." in November this year, so we are
merely "proposing" to go ahead and allow it with this patch, and
will merge only after gaining consensus.  The wording has been
redone to avoid sounding like it is a fait accompli.

Patch 4 has been updated to avoid starting the latter clause with a
capitalized word in two independent clauses joined with a semicolon.


=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
  CodingGuidelines: update for C99
  CodingGuidelines: mention dynamic C99 initializer elements
  CodingGuidelines: allow declaring variables in for loops
  CodingGuidelines: mention C99 features we can't use
  CodingGuidelines: recommend against unportable C99 struct syntax

 Documentation/CodingGuidelines | 34 ++++++++++++++++++++++++----------
 revision.c                     |  7 -------
 2 files changed, 24 insertions(+), 17 deletions(-)

Range-diff against v1:
1:  3e3dd9cbd5 =3D 1:  3e3dd9cbd5 CodingGuidelines: update for C99
2:  fb6c58ef52 =3D 2:  fb6c58ef52 CodingGuidelines: mention dynamic C99 i=
nitializer elements
3:  719e235f9f ! 3:  f3237c88f8 CodingGuidelines: allow declaring variabl=
es in for loops
    @@ Commit message
         cb2607759e2 (merge-ort: store more specific conflict information=
,
         2022-06-18) released with v2.38.0.
    =20
    -    As November 2022 is within the window of this upcoming release l=
et's
    -    update the guideline to allow this, and revert the recent
    -    6983f4e3b20 (test-parse-options.c: don't use for loop initial
    -    declaration, 2022-09-05).
    -
    -    It's better to update the guidelines than to have back & forth c=
hurn
    -    like that, we clearly don't have portability issues related to t=
his
    -    syntax.
    +    As November 2022 is within the window of this upcoming release,
    +    let's update the guideline to allow this.  We can have the promi=
sed
    +    "revisit" discussion while this patch cooks, and drop it if it t=
urns
    +    out that it is still premature, which is not expected to happen =
at
    +    this moment.
    =20
         Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    @@ revision.c: static inline int want_ancestry(const struct rev_info =
*revs);
      	for (const char *p =3D name; *p && *p !=3D '\n'; p++)
      		fputc(*p, out);
      	fputc('\n', out);
    -
    - ## t/helper/test-parse-options.c ##
    -@@ t/helper/test-parse-options.c: int cmd__parse_options(int argc, c=
onst char **argv)
    -=20
    - static void print_args(int argc, const char **argv)
    - {
    --	int i;
    --	for (i =3D 0; i < argc; i++)
    -+	for (int i =3D 0; i < argc; i++)
    - 		printf("arg %02d: %s\n", i, argv[i]);
    - }
    -=20
4:  3d1edfd825 ! 4:  9d2479220d CodingGuidelines: mention C99 features we=
 can't use
    @@ Documentation/CodingGuidelines: For C programs:
     +
     +   . %z and %zu as a printf() argument for a size_t (the %z being f=
or
     +     the POSIX-specific ssize_t). Instead you should use
    -+     printf("%"PRIuMAX, (uintmax_t)v); These days the MSVC version =
we
    ++     printf("%"PRIuMAX, (uintmax_t)v).  These days the MSVC version=
 we
     +     rely on supports %z, but the C library used by MinGW does not.
     +
       - Variables have to be declared at the beginning of the block, bef=
ore
5:  139b0f8cfd ! 5:  ef22b1756a CodingGuidelines: recommend against unpor=
table C99 struct syntax
    @@ Commit message
    =20
      ## Documentation/CodingGuidelines ##
     @@ Documentation/CodingGuidelines: For C programs:
    -      printf("%"PRIuMAX, (uintmax_t)v); These days the MSVC version =
we
    +      printf("%"PRIuMAX, (uintmax_t)v).  These days the MSVC version=
 we
           rely on supports %z, but the C library used by MinGW does not.
     =20
     +   . Shorthand like ".a.b =3D *c" in struct assignments is known to=
 trip

--=20
2.38.0-167-gf9a88ca9e9


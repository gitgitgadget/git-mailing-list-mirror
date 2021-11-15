Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6342C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 01:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDFD61A4E
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 01:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241931AbhKPBpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 20:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241617AbhKOSYH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 13:24:07 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B69C03D7BA
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 09:42:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g14so11790721edb.8
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 09:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:user-agent:message-id:mime-version
         :content-transfer-encoding;
        bh=ISQ2CKhPpTc40IamoET3cALPt92rGs2mxTpdu5n+bJA=;
        b=E+3AIpAxSgezyP6Spp61lIn69jaMuda9m3e4EQas79IOB1i0Ggg1IdmR51O/iGs2sE
         +lR/JAi9+DClf2mhboLQj6x3mZbUPXIrPHhv2JV6MpBuWxeGs1ceFOkyipkxcrCnp3xO
         2N2Q/qt6/ugKy2zsArfywUkOiX/uxJP3Erc+NlZfrCJ5fqDZwioLz4QYT5zuqbuFt9u6
         AyCFWhV908FBZaBnw74CFSJntwrDzMfZ3/UNJsjy15TaJYnzgdnGa+959M/sy+v3ABR8
         QPeVOejRR0+VUu/O0yeEGt2+3/+9f7j8N0lzfG6DqGF1TJ7hXt51f3t8rZexwGdBuxE3
         aNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:user-agent:message-id
         :mime-version:content-transfer-encoding;
        bh=ISQ2CKhPpTc40IamoET3cALPt92rGs2mxTpdu5n+bJA=;
        b=OUe/Pv2KWykbOYfFBmEs9FQ8ndO6OdPluSfh3sGeO8q3Tu+G1CgstlBwwcc1Y1VDsk
         G8WYLTmVm5HInLMx7lZV477SKpOkbd5tve/QOyTm/FOvdIn4dfRlRIOfWMifgKev4kiG
         UwBkSam7YGUiMVpEHXdXLBI4bmJQ+qLqfym87R7GDidOOn+5USeEoCvKQ76sIGxWKcWS
         28rANsq1wIR687pbFjciasriSTh6y3557V0Lv3Mm/tx92XLd3KTY7y3+NIv79K4wPJcN
         sHknDSCHo0QJc5R0UmftjbvVwj47FC/5QexJkzCq3y0BfKTtFe1c5VCl9WAqB3kxLiuD
         vr5w==
X-Gm-Message-State: AOAM530kU6GiWELMh2w3T5NPkidUWjr6aL714RsEyPOe9Mkmm6oFWgmM
        TcuuEiCc9unZPWnH3IsVVv5y0lJ5mfw=
X-Google-Smtp-Source: ABdhPJxnXpYHKv8Xb7/f4dRh0JaFwZfDE6OQ2plGuxiNJV6iwCjyhqm7J+UX4DXK126R2d2zCpt7eQ==
X-Received: by 2002:a50:fe1a:: with SMTP id f26mr717369edt.132.1636998173631;
        Mon, 15 Nov 2021 09:42:53 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f18sm8333506edd.10.2021.11.15.09.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 09:42:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmg0K-001A6I-5x;
        Mon, 15 Nov 2021 18:42:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: New-ish warning in refs.c with GCC (at least 11.2) under -O3
Date:   Mon, 15 Nov 2021 18:41:00 +0100
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
Message-ID: <211115.86a6i5s4bn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Sent earlier as <211115.86ee7hsa58.gmgdl@evledraar.gmail.com>, but I
typo'd the list address)

This happens on "master", but is old, going back to at least v2.25.0 (I
didn't bother to test older versions):
=20=20=20=20
    $ gcc --version
    gcc (Debian 11.2.0-10) 11.2.0
    [...]
    $ make refs.o CC=3Dgcc CFLAGS=3D-O2
        * new build flags
        CC refs.o
    $ make refs.o CC=3Dgcc CFLAGS=3D-O3
        * new build flags
        CC refs.o
    In file included from hashmap.h:4,
                     from cache.h:6,
                     from refs.c:5:
    In function =E2=80=98oidcpy=E2=80=99,
        inlined from =E2=80=98ref_transaction_add_update=E2=80=99 at refs.c=
:1065:3,
        inlined from =E2=80=98ref_transaction_update=E2=80=99 at refs.c:109=
4:2,
        inlined from =E2=80=98ref_transaction_verify=E2=80=99 at refs.c:113=
2:9:
    hash.h:262:9: error: argument 2 null where non-null expected [-Werror=
=3Dnonnull]
      262 |         memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from git-compat-util.h:177,
                     from cache.h:4,
                     from refs.c:5:
    refs.c: In function =E2=80=98ref_transaction_verify=E2=80=99:
    /usr/include/string.h:43:14: note: in a call to function =E2=80=98memcp=
y=E2=80=99 declared =E2=80=98nonnull=E2=80=99
       43 | extern void *memcpy (void *__restrict __dest, const void *__res=
trict __src,
          |              ^~~~~~
    cc1: all warnings being treated as errors
    make: *** [Makefile:2500: refs.o] Error 1

I don't have time to dig into it right now, but if anyone's
interested...

It seems like the whole business of passing REF_HAVE_{NEW,OLD} is at
least partially redundant to simply checking the relevant
variables. Maybe.

I.e. our entire test suite passes with the patch below. We "could"
unconditionally check the variable name itself, but I haven't dug enough
to see if that's introducing a subtle bug we're not testing for, or just
a lot of redundant work.

diff --git a/refs.c b/refs.c
index d7cc0a23a3b..335244f756f 100644
--- a/refs.c
+++ b/refs.c
@@ -1061,10 +1061,22 @@ struct ref_update *ref_transaction_add_update(
=20
 	update->flags =3D flags;
=20
-	if (flags & REF_HAVE_NEW)
+	if (new_oid && flags & REF_HAVE_NEW)
 		oidcpy(&update->new_oid, new_oid);
-	if (flags & REF_HAVE_OLD)
+	else if (!new_oid && flags & REF_HAVE_NEW)
+		BUG("would have passed NULL to memcpy() with REF_HAVE_NEW");
+	else if (new_oid && !(flags & REF_HAVE_NEW))
+		oidcpy(&update->new_oid, new_oid);
+		//BUG("missed a memcpy() new_oid due to no REF_HAVE_NEW");
+
+	if (old_oid && flags & REF_HAVE_OLD)
 		oidcpy(&update->old_oid, old_oid);
+	else if (!old_oid && flags & REF_HAVE_OLD)
+		BUG("would have passed NULL to memcpy() with REF_HAVE_OLD");
+	else if (old_oid && !(flags & REF_HAVE_OLD))
+		oidcpy(&update->old_oid, old_oid);
+		//BUG("missed a memcpy() old_oid due to no REF_HAVE_OLD");
+
 	update->msg =3D normalize_reflog_message(msg);
 	return update;
 }

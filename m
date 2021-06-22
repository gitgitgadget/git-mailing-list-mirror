Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC95C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 18:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3866109E
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 18:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhFVS42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFVS41 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 14:56:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD4AC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 11:54:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m14so129499edp.9
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 11:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RN3WLQDXqf+SroC/EPQOJmQ1BuAoYVmP+f8S3KRpoHA=;
        b=Tqzhy2MpwhEZMBgYO5PY0vtPcCPSpOCNsop3G2C8VcTYFYfPOz3jLo74VaKBG5M+Fz
         iVrI7E1peFumtWV4XnUj/9wOQR+QzbcoJlrvgAzSkVlS/v3XekTCt98TisqujPxYw6jS
         g+5XCNWOGZ3IjPXJUSOUkrnWS7kJr8rplUW7BcWRuOIgZa9ghXncSg3gcbAPh/Gx7yd1
         bdLu0z3GEVIRPHqE0sMjF/IB0siM/o95y814wGppiELmFL15agll2Fsa9XJRyflmYQ0j
         OtksujZJWsBeEWOP60Wh2OWgWy7KamdzTWJ7IWROLdFyTppQtMBCjz4km75dmNeF4CZx
         3Dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RN3WLQDXqf+SroC/EPQOJmQ1BuAoYVmP+f8S3KRpoHA=;
        b=ezyCCjGv1/j0WozXgl1V7Sq9tgmbehFR9CEtHqQ4FlsESoN20lApranvlymdbdM5gr
         8Qn8JcDLkyMsB5TbHxNW05uA/M3Ab7lVvOVsdPzPrACC+Ct5UA2DbpAeaHZR+6FsdvUd
         IqJ7teKhl+QmAO+XtDYPLkTQkAU3x7iGAxVBGAtnUihfeMBjI34P+s+Gh68cPWTKtuhf
         6o8Cwe5+CMvlWXGCgFzydVbKhqWl1PemcyEW3tOqGJ8O+J5O69Lr2zpUl2yR6dVuUdlJ
         D1IK4/a/saThnnTnEIVqxqd+eEh4wRt5OERVt/iWuveKW77+NSu26WAO/nEzh1fG2d/M
         SnvQ==
X-Gm-Message-State: AOAM5328LyAJton4IRqWQoTtSHiihwCKfhxCm/pbJuYuXOUGrgfgMUky
        oTiWrsiC7nJ8vMzTlyEHtEI=
X-Google-Smtp-Source: ABdhPJz+xjvRbOgWE4K11stdsXJ9yB5L8ME/i70LhNMz/75oj6ZMSE/I1Lxo7F+pcu80q9Z+8K/1wQ==
X-Received: by 2002:a50:fd0d:: with SMTP id i13mr7134489eds.123.1624388049620;
        Tue, 22 Jun 2021 11:54:09 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i18sm4383678edc.7.2021.06.22.11.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 11:54:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/5] load_ref_decorations(): avoid parsing non-tag objects
Date:   Tue, 22 Jun 2021 20:27:53 +0200
References: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
 <YNILCDz3LpHX7OX0@coredump.intra.peff.net>
 <a93690bc-1d33-0fe0-5ca8-0e8baa9c66e6@gmail.com>
 <YNIYqFFFti73UT5+@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <YNIYqFFFti73UT5+@coredump.intra.peff.net>
Message-ID: <87zgvh20j3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 22 2021, Jeff King wrote:

> On Tue, Jun 22, 2021 at 12:35:46PM -0400, Derrick Stolee wrote:
>
>> On 6/22/2021 12:08 PM, Jeff King wrote:
>>=20
>> > -	obj =3D parse_object(the_repository, oid);
>> > -	if (!obj)
>> > +	objtype =3D oid_object_info(the_repository, oid, NULL);
>> > +	if (type < 0)
>> >  		return 0;
>>=20
>> Do you mean "if (objtype < 0)" here? There is a 'type' variable,
>> but it is an enum decoration_type and I can't find a reason why
>> it would be negative. oid_object_info() _does_ return -1 if there
>> is a problem loading the object, so that would make sense.
>
> Whoops, thanks for catching that. I originally called it "enum
> object_type type", but then of course the compiler informed that there
> was already a "type" variable in the function. So I renamed it to
> "objtype" but missed updating that line. But it still compiled. Yikes. :)

[Enter Captain Hindsight]

If you use a slightly different coding style and leverage the
information the compiler has to work with you'd get it to error for you,
e.g. this on your original patch would catch it:

	diff --git a/log-tree.c b/log-tree.c
	index 8b700e9c142..7e3a011b533 100644
	--- a/log-tree.c
	+++ b/log-tree.c
	@@ -157,9 +157,12 @@ static int add_ref_decoration(const char *refname, co=
nst struct object_id *oid,
	 	}
=09=20
	 	objtype =3D oid_object_info(the_repository, oid, NULL);
	-	if (type < 0)
	+	switch (type) {
	+	case OBJ_BAD:
	 		return 0;
	-	obj =3D lookup_object_by_type(the_repository, oid, objtype);
	+	default:
	+		obj =3D lookup_object_by_type(the_repository, oid, objtype);
	+	}
=09=20
	 	if (starts_with(refname, "refs/heads/"))
	 		type =3D DECORATION_REF_LOCAL;

IMO the real problem is an over-reliance on C being so happy to treat
enums as ints (well, with them being ints). If you consistently use
labels you get the compiler to do the checking. For me with gcc and
clang with that on top:
=09
	log-tree.c:161:2: error: case value =E2=80=984294967295=E2=80=99 not in en=
umerated type =E2=80=98enum decoration_type=E2=80=99 [-Werror=3Dswitch]
	  case OBJ_BAD:
	  ^~~~
	log-tree.c:161:7: error: case value not in enumerated type 'enum decoratio=
n_type' [-Werror,-Wswitch]
	        case OBJ_BAD:
	             ^

I think we've disagreed on that exact point before recently, i.e. you
think we shouldn't rely on OBJ_BAD in that way, and instead check for
any negative value:
https://lore.kernel.org/git/YHCZh5nLNVEHCWV2@coredump.intra.peff.net/

This sort of thing is a good reason to pick the opposite pattern. You
get the same type checking you'd usually get with anything else in C.

Yes, it is more verbose e.g. in this case, and particularly (as noted
downthread of what I linked to) because "enum object_type" contains so
many uncommon things, and really should be split up.

In practice I don't think it's too verbose, because once you start
consistently using the pattern you'll usually not be doing conversions
all over the place, and would just do this sort of thing via a helper
that does the type checking, e.g. something like this (or anything else
where you don't lose the type & labels):
=09
	diff --git a/log-tree.c b/log-tree.c
	index 8b700e9c142..a61fb01ba3f 100644
	--- a/log-tree.c
	+++ b/log-tree.c
	@@ -130,6 +130,30 @@ static int ref_filter_match(const char *refname,
	 	return 1;
	 }
=09=20
	+static enum object_type oid_object_info_ok(struct repository *repo,
	+					   struct object_id *oid,
	+					   enum object_type *typep,
	+					   unsigned long *sizep)
	+{
	+	enum object_type type =3D oid_object_info(repo, oid, sizep);
	+	*typep =3D type;
	+	switch (type) {
	+	case OBJ_BAD:
	+		return 0;
	+	case OBJ_COMMIT:
	+	case OBJ_TREE:
	+	case OBJ_BLOB:
	+	case OBJ_TAG:
	+		return 1;
	+	case OBJ_NONE:
	+	case OBJ_OFS_DELTA:
	+	case OBJ_REF_DELTA:
	+	case OBJ_ANY:
	+	case OBJ_MAX:
	+		BUG("the enum_object type is too large!");
	+	}
	+}
	+
	 static int add_ref_decoration(const char *refname, const struct object_id=
 *oid,
	 			      int flags, void *cb_data)
	 {
	@@ -156,8 +180,7 @@ static int add_ref_decoration(const char *refname, con=
st struct object_id *oid,
	 		return 0;
	 	}
=09=20
	-	objtype =3D oid_object_info(the_repository, oid, NULL);
	-	if (type < 0)
	+	if (!oid_object_info_ok(the_repository, oid, &type, NULL))
	 		return 0;
	 	obj =3D lookup_object_by_type(the_repository, oid, objtype);
=09=20

With that pattern GCC narrowlry pulls ahead with showing 4 warnings just
about the loss of the type, with Clang at 3 :)

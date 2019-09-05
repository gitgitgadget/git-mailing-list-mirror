Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775331F461
	for <e@80x24.org>; Thu,  5 Sep 2019 19:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfIET7u (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 15:59:50 -0400
Received: from mout.web.de ([212.227.15.4]:44297 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfIET7u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 15:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567713582;
        bh=I4s5h0hBS+r2f6MiS0GhWZ7g5pPYNV7CX61+Kdeqazg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=WzxOFAfJQOVtpIf/EK7YiKJ3v5u3khScWVLpAAJ6TcR+22LUg+03Y0ka83xiulyD9
         BCkVNf1Jvg9sTF4q53aAgqNhXP59zC5P3eyk7R2M6MwD90RUcS6bHwRqAJBunyN13L
         fOKnREkKhKWmLG+Jqg3ZKBM8s219mASzIdXWALv0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZDga-1hrarK29gC-00Kyuh; Thu, 05
 Sep 2019 21:59:42 +0200
Subject: [PATCH 2/2] use get_tagged_oid()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Sperling <stsp@stsp.name>
References: <1385c954-d9ef-7ef6-6185-0dad885531ec@web.de>
Message-ID: <eaafa812-33cc-843b-391c-a9f8e9725777@web.de>
Date:   Thu, 5 Sep 2019 21:59:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1385c954-d9ef-7ef6-6185-0dad885531ec@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R4VRL0ReEsYqtjjn2j/V95jabad/XVKstKHoiVrP9zwy9RM0qU2
 cK2x6xu7BGFGJklgU7gCI3aNwph6MgbnWNkgoFRmFEnE+H2/GXyGWUQUGTu8/KM2NEIXBKq
 Nutz32XfPiba13qJWinvqIUESxYWBWiZOWgfqGVMMH/hPSnf2Mdlto6/Ri/kjPeMBebsJZF
 QWm+LWsMqpGTyCEmDSDag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HvWFT4+84wY=:l1CPmretFAM6eWx54McNIj
 9atrNuW9seczogS9rDaazkeiQWVLQzTfjw+PtgXi9j+Mce9mdNnFU9+6M49gzHD1h7a7HXuA6
 h143O7IXFlE/k5dqXaAiR0aDVb7MNZEzF+KwAMFVb5pyAVUDvT8SoOvHhjsa1jLUEBagK+Ltt
 ru4dDtn/7P/vvS0rajHoY4G2SR50Nvb56xzMarVyZPL49ZmxreemizPXPhPSGUj/LWuzOC90e
 MaX9JBCjR74Pxh5Epeh3RByNKDlxZdNXiHviBtvbzeNcMxgrvl9Qi4EIMYsevaNMmPBZQ32My
 GGbgEhWZqm+mvH2Sz0LGWlgqAz3Yjn8ppLp6kZq3g0GvB+VInw5TxJwdBb4KGTEIkHNbRMP32
 0Hzy2iJ8TST8Ab6i0faLhxmc5m3c7tYgiKhWem88jUQywOCG6cXKfEBSuM8zh8EIBPcA5DOWp
 rQtpb3f2uPkc9/fEn4Mj8ihb4NjFnM5c7kCt8Dq1tdN0Zbf8JBkDrtCWiOkbyqRhv/8KgVEFg
 35ETUUkXOgO1pt7HI8vQfg3GjrRc7QCXF5WCBI9mfilQKpCQy80x3LuStFQHZqOjyrDfpVHmA
 F1s0CwRxbdfMvX2GkWltUdNFq77Zo73lkZDkbwMU43Ed/SgoQ0jxb+3v7wkEVgZzKkBX1fLYp
 f4XnnUJrQI0F+ZplfSkMpQaguxXisKYUg/d70VsAgppB/USACEYY9VZiZ3lO2FHm2ys/G5GuY
 c379RbUJqCv28Fx/Fx4IXMLkSlGtlRHvnqbA0hGxPXiDN3mLaoA+rESLpL3AJ3zXYC4/Ttf9T
 8sSvy5sJwjWpN9iooAN/Db/cDsciYVwjeYomrPAORv8SYqvktDr8oAi7Q5aWrjNAUMtlmbLVo
 I4G5oIRf6mE2QjvaXS6VxsTN4aJ6RXoWuqSwxqsrk/N+ij+wEHeWvUoNUfwxxeDou2DZqRYIZ
 j2PzV/lrvYl5ijAx+DYKcEA5vqYBnQJdO1mJfbtL+5+CDlJlV+tMJeXoCxM7ctc2KxXtKr1hK
 SaAgS5EBTWcU1l9za0jdciifYeFcP+n5iqQqYb30BsvauMELZafZXvW/xIbp8qDVLmlTKkGkE
 LcMxp4D9/NskLZpH+8CHnHMpux+P6VQuSnI1tmC+bhszvTOLEJqWEsTJBiMGFB8N7/pOfiZ0u
 83/gtFOEWs/MxohfLcgjqHXUPG5VIbp0AXVp9wHlgVHIK0Fgi765Jtu7718uc4+I+5y1E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid derefencing ->tagged without checking for NULL by using the
convenience wrapper for getting the ID of the tagged object.  It die()s
when encountering a broken tag instead of segfaulting.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/describe.c | 2 +-
 builtin/log.c      | 5 +++--
 builtin/replace.c  | 2 +-
 packfile.c         | 2 +-
 ref-filter.c       | 4 ++--
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 200154297d..e048f85484 100644
=2D-- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -313,7 +313,7 @@ static void describe_commit(struct object_id *oid, str=
uct strbuf *dst)
 		 */
 		append_name(n, dst);
 		if (longformat)
-			append_suffix(0, n->tag ? &n->tag->tagged->oid : oid, dst);
+			append_suffix(0, n->tag ? get_tagged_oid(n->tag) : oid, dst);
 		if (suffix)
 			strbuf_addstr(dst, suffix);
 		return;
diff --git a/builtin/log.c b/builtin/log.c
index 44b10b3415..c4b35fdaf9 100644
=2D-- a/builtin/log.c
+++ b/builtin/log.c
@@ -627,6 +627,7 @@ int cmd_show(int argc, const char **argv, const char *=
prefix)
 			break;
 		case OBJ_TAG: {
 			struct tag *t =3D (struct tag *)o;
+			struct object_id *oid =3D get_tagged_oid(t);

 			if (rev.shown_one)
 				putchar('\n');
@@ -638,10 +639,10 @@ int cmd_show(int argc, const char **argv, const char=
 *prefix)
 			rev.shown_one =3D 1;
 			if (ret)
 				break;
-			o =3D parse_object(the_repository, &t->tagged->oid);
+			o =3D parse_object(the_repository, oid);
 			if (!o)
 				ret =3D error(_("could not read object %s"),
-					    oid_to_hex(&t->tagged->oid));
+					    oid_to_hex(oid));
 			objects[i].item =3D o;
 			i--;
 			break;
diff --git a/builtin/replace.c b/builtin/replace.c
index 644b21ca8d..2a4afb3b93 100644
=2D-- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -421,7 +421,7 @@ static int check_one_mergetag(struct commit *commit,
 		if (get_oid(mergetag_data->argv[i], &oid) < 0)
 			return error(_("not a valid object name: '%s'"),
 				     mergetag_data->argv[i]);
-		if (oideq(&tag->tagged->oid, &oid))
+		if (oideq(get_tagged_oid(tag), &oid))
 			return 0; /* found */
 	}

diff --git a/packfile.c b/packfile.c
index fc43a6c52c..a62ab4cb17 100644
=2D-- a/packfile.c
+++ b/packfile.c
@@ -2139,7 +2139,7 @@ static int add_promisor_object(const struct object_i=
d *oid,
 			oidset_insert(set, &parents->item->object.oid);
 	} else if (obj->type =3D=3D OBJ_TAG) {
 		struct tag *tag =3D (struct tag *) obj;
-		oidset_insert(set, &tag->tagged->oid);
+		oidset_insert(set, get_tagged_oid(tag));
 	}
 	return 0;
 }
diff --git a/ref-filter.c b/ref-filter.c
index f27cfc8c3e..8dcc17c049 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -1766,7 +1766,7 @@ static int populate_value(struct ref_array_item *ref=
, struct strbuf *err)
 	 * If it is a tag object, see if we use a value that derefs
 	 * the object, and if we do grab the object it refers to.
 	 */
-	oi_deref.oid =3D ((struct tag *)obj)->tagged->oid;
+	oi_deref.oid =3D *get_tagged_oid((struct tag *)obj);

 	/*
 	 * NEEDSWORK: This derefs tag only once, which
@@ -1997,7 +1997,7 @@ static const struct object_id *match_points_at(struc=
t oid_array *points_at,
 	if (!obj)
 		die(_("malformed object at '%s'"), refname);
 	if (obj->type =3D=3D OBJ_TAG)
-		tagged_oid =3D &((struct tag *)obj)->tagged->oid;
+		tagged_oid =3D get_tagged_oid((struct tag *)obj);
 	if (tagged_oid && oid_array_lookup(points_at, tagged_oid) >=3D 0)
 		return tagged_oid;
 	return NULL;
=2D-
2.23.0


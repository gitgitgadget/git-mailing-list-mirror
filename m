Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE62C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 07:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351061AbhLCHFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378758AbhLCHFX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 02:05:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D749C061757
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 23:02:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d9so3679478wrw.4
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 23:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=USO2JAKJqpOPHL0exB2jcq1EPX6zp2qgL3t7hvXh6d8=;
        b=GVE3i8JHfGkZhuTOsKEkZfYH2eUvojBbwSGCmNM38LPQSOm087o5XrLokxhmdKzXEk
         afuk/d3q9N+gw5+zHz8JtC1z3ep6+q55CDHLIYbNXG479RnfNFpOxrL8QF8T7qtPg6/j
         AHKXzHgYXTYM0gNJkLg0QB1rIIrCpIOrmsxRZR6KAPumhtTXDaictJANXtNYHgVZ0nzq
         QJbRfm2d4tWG3sfbuQ8s6Qyd9F17mHfofQmCUi4X4EZpSk3asjEtOJnKeMxQ8tHG5fok
         MiB3cQEtro2+JryctJV8dwSRZMWd1E9BnHHbHUMsroN9TcQHyAQKvqwahR62HJQ1gVmu
         pcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=USO2JAKJqpOPHL0exB2jcq1EPX6zp2qgL3t7hvXh6d8=;
        b=0jgbYhsZQVHu748KJJbxniFhIi+sAPV609vYjPbirI5BPLv5cR0ghpc+lQuWmAeWJq
         4qL4JoDHIOH/7enzfq97aqUlRa+v6O3d8MUJoaXlDOAk5lq5xuDuD7PpKFUrgYgNpZa6
         k5lrm6D6XyDACXW8880au0zTjuzoq9zzuIL4n8xb/JV+CrWz4mzr1d2c5D+eBDK8ZFzV
         DjftM86Y4l3mBzjEepWGdTYzrunDtkhRVDa96nT+57nxBtL/orjUU1H1mcCji4afj/ad
         OLMXxtqsa6xsy3EwSW6NrLms79OdLz8dHPKLRndO3q9XtRoH4U2wFsDLL6WnJrcxGC39
         PndQ==
X-Gm-Message-State: AOAM532Sf5peStVTTMusndmMpE3vQ/ImpXSLei9FwXmiIeitqvuR+VRh
        l033qBO0qApRltEOt7vO/62DUJeo9cI=
X-Google-Smtp-Source: ABdhPJyxSxFJOrAmnoAeMpySbvBSzpMEIdDWp/Js//qtqQ6Wl3LlkozJ1lnwKU5iGR1rrerk7DV1Mg==
X-Received: by 2002:a5d:4343:: with SMTP id u3mr20070622wrr.450.1638514918860;
        Thu, 02 Dec 2021 23:01:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm4245407wmh.8.2021.12.02.23.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 23:01:58 -0800 (PST)
Message-Id: <4c2df4522a10163946d3d63821dcceffb4a312bc.1638514910.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 07:01:47 +0000
Subject: [PATCH 08/10] i18n: refactor "unrecognized %(foo) argument" strings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 ref-filter.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 08a3f839c97..554c2ba1b17 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -341,7 +341,7 @@ static int objectsize_atom_parser(struct ref_format *format, struct used_atom *a
 		else
 			oi.info.disk_sizep = &oi.disk_size;
 	} else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(objectsize) argument: %s"), arg);
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "objectsize", arg);
 	return 0;
 }
 
@@ -374,7 +374,7 @@ static int subject_atom_parser(struct ref_format *format, struct used_atom *atom
 	else if (!strcmp(arg, "sanitize"))
 		atom->u.contents.option = C_SUB_SANITIZE;
 	else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(subject) argument: %s"), arg);
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "subject", arg);
 	return 0;
 }
 
@@ -428,7 +428,7 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
 		if (strtoul_ui(arg, 10, &atom->u.contents.nlines))
 			return strbuf_addf_ret(err, -1, _("positive value expected contents:lines=%s"), arg);
 	} else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(contents) argument: %s"), arg);
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "contents", arg);
 	return 0;
 }
 
@@ -440,7 +440,7 @@ static int raw_atom_parser(struct ref_format *format, struct used_atom *atom,
 	else if (!strcmp(arg, "size"))
 		atom->u.raw_data.option = RAW_LENGTH;
 	else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(raw) argument: %s"), arg);
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "raw", arg);
 	return 0;
 }
 
@@ -531,7 +531,7 @@ static int align_atom_parser(struct ref_format *format, struct used_atom *atom,
 		else if ((position = parse_align_position(s)) >= 0)
 			align->position = position;
 		else {
-			strbuf_addf(err, _("unrecognized %%(align) argument: %s"), s);
+			strbuf_addf(err, _("unrecognized %%(%s) argument: %s"), "align", s);
 			string_list_clear(&params, 0);
 			return -1;
 		}
@@ -557,7 +557,7 @@ static int if_atom_parser(struct ref_format *format, struct used_atom *atom,
 	} else if (skip_prefix(arg, "notequals=", &atom->u.if_then_else.str)) {
 		atom->u.if_then_else.cmp_status = COMPARE_UNEQUAL;
 	} else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(if) argument: %s"), arg);
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "if", arg);
 	return 0;
 }
 
-- 
gitgitgadget


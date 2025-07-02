Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55C1487C3
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 01:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418497; cv=none; b=auF2AqBGED5ufwglySWqTXIAC2Dn920jan33BdSQt7rq0COhs+jSOhKTrB5QFaTZEn6c5xqx1yZ2RphoITFDT8w6VlIOPhgn+3dEoTvzzzapde/qkBlbuNzN0t3Jf5SaJl1J/y/ZDhQCB3gucSofG7xVvTFiKMaMd35iAJvJ3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418497; c=relaxed/simple;
	bh=4n+36m/oYsHvbn+8q2kCzA3YuecXRmpJgexueLezM58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeYzp3NjMhrruPotxyLmPHV8XPeq61qrlVLJeipC8FMuViOLJrXN+iqzoBRyeRpIIfRFfikfQnSdiHBiv4mRCaNBTS1jY19rMtwuW3EAPEVr2/0fs2YEl+chVrhoXNYc/bbm9GDxbg1FhlEbKuCum1MJcFeq450AK13AdeKV3BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcQGlCTk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcQGlCTk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234fcadde3eso50798795ad.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 18:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751418495; x=1752023295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLYnOcwdJy6KRaXnsfZfYzCPI4p6HkcX+tfoVe9tksc=;
        b=CcQGlCTk/GCDUIJECXIdT5TFOR/VpSEBWrf1Juz8VC+oxjf9Elo/6hpSSkFONoSVci
         A1XPf/RtrBYXkkBPEqTwYvWuPhDYE/PAPiWeVDvKBzRr1GB32ycmC7D7M0Lq1Sc92qrD
         VM7kk9lSYRwKmHEagKO0KVyPu4oex1D7ojFOUewitm0Hl1Qtb+A2POTT5tZEUyASS4mA
         f4GTazxX/6VOvgIf8B5RH0MsgKuZf+OV8jRnhf1b5HgNEkVkc89X1OjisKwiE1CAJMGE
         K13LeC9630vR0Lzqn/toC0E3TR9yb67LVAJQDDkAPl/EVRoc3JyQejaDP83dS2VKaVjx
         vPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751418495; x=1752023295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLYnOcwdJy6KRaXnsfZfYzCPI4p6HkcX+tfoVe9tksc=;
        b=AqcIDP9GBc7GX583mGmFije4qNR7w6QDFx9F94jyVmNQlA5cp0X8zwN4xKAmDLi3RT
         aUVIXCdi/8VjQHzvOOH8C6QnRCQWkokNQPo1MvkjoeiUyGrDmxP+Mib3VVZ10saIsOYs
         Qsr1FMOcKA0dgSkK2tnklxrop+eXrpener320rYBEubZe6u3743Ok2KPLbADzWxB7N0S
         bYhde7IjtGeEWhZeCHcouIRBgpXV2rY0HY9O7MqlXYnYtMDdc+Dt4VDiWNIValrXK1ue
         5BS0frLXi6/rOLUF6KluFIDlAybIX23+mNI3b0fNAr/lO5TPOmgK2oLstSik5/D7UuBw
         n0Yw==
X-Forwarded-Encrypted: i=1; AJvYcCU9vzxRr0qRB55MCScmBJTou29yUenzwEvMJKEpm0cQM6iCSgM7Y4APtfEehbuAyyFFZH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7d8UfN3KM5iBbcT2fWut0XsIVYFN6teAv/7wqCzpxlISJBhV
	h+9ldOlvTxMPymTuP6eFax9jZ7IUxJ7eRCPbjTokRsZdmU5W4vGxhDsT
X-Gm-Gg: ASbGncuyPOm+xJBlmyp4nDgbzTob99Od8hhdminaAJA73zs5dCQC6n1DxkY3RQUD9eW
	mrL8b7udBE2Og09xHdrJR7vd1ygRTbM3iE6LrVQLTQuXFFESbtdVOBkcv+nkjXS9lkxVZGTdM/C
	8zC00ozdidmmZzZmvtp92jpPMLDz87CHZiRkwqEJiOn99qGX8wEH5odGFND1tBdGg7Q1zwSHpum
	Z4r7Wa9JC1BDAVn/vBr0XaTnWaw6rc6gT896FdeBMpK28gaAj76xt7I+6+SHvW4qAHxtGnsZ9Wf
	/soc2bXiSmWZ+GWt7iDGq1onGOCRvKPuVOBazjOch0V8QD6iz6U+QNt6XvU=
X-Google-Smtp-Source: AGHT+IHscTgLDR9CqEk/Lfyc3TZx8BkXuJ/Qz/3bY3alKWBnY9iYdIGSNTp+bgOxeF5PWp08Cil3SQ==
X-Received: by 2002:a17:903:3bac:b0:235:eb71:a398 with SMTP id d9443c01a7336-23c6e5fd262mr12607965ad.53.1751418494775;
        Tue, 01 Jul 2025 18:08:14 -0700 (PDT)
Received: from dev-phord.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e258csm124433705ad.38.2025.07.01.18.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 18:08:14 -0700 (PDT)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: gitster@pobox.com
Cc: peff@peff.net,
	git@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Phil Hord <phil.hord@gmail.com>
Subject: [PATCH v3 2/2] clean up interface for refs_warn_dangling_symrefs
Date: Tue,  1 Jul 2025 17:58:38 -0700
Message-ID: <20250702005837.2813893-4-phil.hord@gmail.com>
X-Mailer: git-send-email 2.50.0.149.g2f19833911.dirty
In-Reply-To: <20250702005837.2813893-2-phil.hord@gmail.com>
References: <20250702005837.2813893-2-phil.hord@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Hord <phil.hord@gmail.com>

The refs_warn_dangling_symrefs interface is a bit fragile as it passes
in printf-formatting strings with expectations about the number of
arguments. This patch series made it worse by adding a 2nd positional
argument. But there are only two call sites, and they both use almost
identical display options.

Make this safer by moving the format strings into the function that uses
them to make it easier to see when the arguments don't match. Pass a
prefix string and a dry_run flag so the decision logic can be handled
where needed.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 builtin/fetch.c  |  5 +----
 builtin/remote.c |  5 +----
 refs.c           | 17 +++++++++++------
 refs.h           |  3 ++-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 04d10c9e781a..fc72f2119c56 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1384,9 +1384,6 @@ static int prune_refs(struct display_state *display_state,
 	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
 	struct strbuf err = STRBUF_INIT;
 	struct string_list refnames = STRING_LIST_INIT_NODUP;
-	const char *dangling_msg = dry_run
-		? _("   %s will become dangling after %s is deleted")
-		: _("   %s has become dangling after %s was deleted");
 
 	for (ref = stale_refs; ref; ref = ref->next)
 		string_list_append(&refnames, ref->name);
@@ -1417,7 +1414,7 @@ static int prune_refs(struct display_state *display_state,
 		}
 		string_list_sort(&refnames);
 		refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
-					   stderr, dangling_msg, &refnames);
+					   stderr, "   ", dry_run, &refnames);
 	}
 
 cleanup:
diff --git a/builtin/remote.c b/builtin/remote.c
index 4de7dd373ae5..f672799e0d92 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1521,9 +1521,6 @@ static int prune_remote(const char *remote, int dry_run)
 	struct ref_states states = REF_STATES_INIT;
 	struct string_list refs_to_prune = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
-	const char *dangling_msg = dry_run
-		? _(" %s will become dangling after %s is deleted!")
-		: _(" %s has become dangling after %s was deleted!");
 
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
@@ -1555,7 +1552,7 @@ static int prune_remote(const char *remote, int dry_run)
 	}
 
 	refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
-				   stdout, dangling_msg, &refs_to_prune);
+				   stdout, " ", dry_run, &refs_to_prune);
 
 	string_list_clear(&refs_to_prune, 0);
 	free_remote_ref_states(&states);
diff --git a/refs.c b/refs.c
index 07197c239e33..5602c18dbd5b 100644
--- a/refs.c
+++ b/refs.c
@@ -439,7 +439,8 @@ struct warn_if_dangling_data {
 	struct ref_store *refs;
 	FILE *fp;
 	const struct string_list *refnames;
-	const char *msg_fmt;
+	const char *indent;
+	int dry_run;
 };
 
 static int warn_if_dangling_symref(const char *refname, const char *referent UNUSED,
@@ -447,7 +448,7 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
 				   int flags, void *cb_data)
 {
 	struct warn_if_dangling_data *d = cb_data;
-	const char *resolves_to;
+	const char *resolves_to, *msg;
 
 	if (!(flags & REF_ISSYMREF))
 		return 0;
@@ -458,19 +459,23 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
 		return 0;
 	}
 
-	fprintf(d->fp, d->msg_fmt, refname, resolves_to);
-	fputc('\n', d->fp);
+	msg = d->dry_run
+		? _("%s%s will become dangling after %s is deleted\n")
+		: _("%s%s has become dangling after %s was deleted\n");
+	fprintf(d->fp, msg, d->indent, refname, resolves_to);
 	return 0;
 }
 
 void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
-				const char *msg_fmt, const struct string_list *refnames)
+				const char *indent, int dry_run,
+				const struct string_list *refnames)
 {
 	struct warn_if_dangling_data data = {
 		.refs = refs,
 		.fp = fp,
 		.refnames = refnames,
-		.msg_fmt = msg_fmt,
+		.indent = indent,
+		.dry_run = dry_run,
 	};
 	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
 }
diff --git a/refs.h b/refs.h
index 07f21824d480..25bed4d792e7 100644
--- a/refs.h
+++ b/refs.h
@@ -453,7 +453,8 @@ static inline const char *has_glob_specials(const char *pattern)
 }
 
 void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
-				const char *msg_fmt, const struct string_list *refnames);
+				const char *indent, int dry_run,
+				const struct string_list *refnames);
 
 /*
  * Flags for controlling behaviour of pack_refs()
-- 
2.50.0.149.g2f19833911.dirty


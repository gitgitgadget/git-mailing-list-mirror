Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61BE389E02
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302059; cv=none; b=to1i9/sOxqWeeT9W1x39799+yaq69rX32ExkZZ+/IXES36MXmwOTchASIKvl1DdG2Pl0XrIeII+buRb8rFcQS20D4vc12nM+Tp4ThXAMTgjy+nUFc8xCj3IblZnP4jQjQStPctSnzWlNBcrpWsfU9GG2sK9WmEQtJc/XZAdP5ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302059; c=relaxed/simple;
	bh=zn6ZJ/WPmaPt60o7LWB+XQY3Dt7yOeCUchlEBy5aOKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pjKqnQwFzkbQULBg9nRArikc91Sie0h3Qv+VNWjkI4emzVa4EpVmegikp22gbjRQhHeSG9w+utiq/IyGAP9q7zfVogb2pno5c53IUSWHDonELuhFuJa+0ep+VZ+jzkAG860ucbM2JZTt7eydGuv1W1nk5+fZ70nvR+bbp1AWTDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sm37irOP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i7VMZERC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sm37irOP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i7VMZERC"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 0292CEC0128;
	Mon,  1 Jun 2026 04:20:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 01 Jun 2026 04:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302057;
	 x=1780388457; bh=WMfm+54JzoTG4hWatw3E70Jm7Eyn++71ZQAT4fgw0t4=; b=
	sm37irOPEGsDpwQmD19lBm5s9b8Lpns2d1QmL8L+uZ4GNb/+G7IlhO5s74rdWqgD
	7S9rjP0Svt98o5evLnAbVfXioaSTdwfiDR/3+97z8fCGxs0z29U4QQQHZOdJER3O
	HV4w2P0j4OOTf0a1dFT/t5fG3T4BS1YjUGS/nO9evn6QY2I1tQvK8/CxpTOAvjNI
	254RPQy8rmZBGjjkhk2Kqft1SPrOzSa9Tgew06UuZqJydCfi/ZzJ6dib02wgMFZn
	Se/YW/naKP2ummOlMPSTkL8Sb6NS22yO5kOxl+ZzfOL6L4INeXiRchKPcepcKuq4
	E/zy1Gkmtaxe9R/Hl96yhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302057; x=
	1780388457; bh=WMfm+54JzoTG4hWatw3E70Jm7Eyn++71ZQAT4fgw0t4=; b=i
	7VMZERCcquL8bGv2U6GssEjuTfXRM/chmtD+uRrl8zVGZkyJ8astgpSlA+iOQKRg
	/DGDQ6VMKpQ3egS1sQJ5uRyiQ70YIzpZgiOEX7G+DdIqh2l648rCS4E/x5mwcW3O
	QSKq7Y8o/oZtQzYkWiKJY8jcqjXElYMsvNI1Yj3FxqGLhRMJMq+Fd2E07Pw0WYF+
	FFyMlbIDcU+xPZYPYgvPW3AA8gyqsXtlc9qJ7JtQ9GzpPzrtN97cuLiZhk9z6ecQ
	rgbFjb6fnJ8owb/HN67R8Y1kq5KKW8aXhga+gfXFWE7xBp35XGetRf0/GlYzf8t+
	461aSGf9yUVzAoPfUNJXg==
X-ME-Sender: <xms:6UAdas7Zbb2xH-gtJ8aA4e-U6JrEWYPi-sOAqV8_0JzeVnXd-sG8Ag>
    <xme:6UAdaj5w8J99Z77v2omt_puzE11eSC1lK6w2OreiN5Z48RObisraB_GJPQDymaYho
    BFjN6cpsY6lUD9gx_KryrOOFQVIWxtUYEMMWtYCd2e_POs6oZDDyw>
X-ME-Received: <xmr:6UAdapF0qI8u3zm33WlAcccT0kItkqjJ9tAeNVI-mtsZpBMO1PDHBrqEgOQejJhWYsl5HWLrn-FXbKj17jbtWpaLmN4Pi8QgrunYt99FSkvd>
X-ME-Proxy-Cause: dmFkZTGtPD+c7lPFsIEsM2WXtx7/rFB1gs4iYuqNGZ2s8j5if3uh7gqJku0Xe9LPv1JdSH
    hXEPNej7TAWEGAjOawOhqeyKxk0+n7s1GYfYjSvsy/XaKQoUj+DG9djmfNdVHsiSwnyrFN
    9pKgtBkjwHjQeevtTE/43HUbZP7GqhZbkLA6CwaM5M3QMCCmDHsg5qGxPm3kXLqHtzIsCr
    7sDZu5Hvk/2l3eNhPqwrcie+40nGKhmyL1uZe1IXI+OP1YD1N1UNCnoKK+DL9P6FK4PFMT
    W+VXpmbHKgCRuqUeyL77FAo0yRoPdRkz7Jcw9FOxqKn+R2tXv0w6ed+M7a9XYSYfQ+KfD0
    SOJ0EPSlZ5UZQZ4JDJ5Kt7rfrNcUjpVflca6ORA0a9HQVQQWHfpp8HQf3SN+XTNRLTqNCx
    7NE1XCmU67bKcJ6pk16rkRctcwJlwgahfxwPrQ1XUIobOHFaLkXjK5sgTmxjPXxwHAq5Sf
    mdObL6lLymaqzSSTr7m7KBHtNeH6k+siu7cK4w2070SIVwb2oXX3FBL6TdWW1l8Fh3tZ6Y
    hMyqL6Ihim4DX34CRIb71+f5hka1nlqRZVIpjZYOikHt1b2CbOOT9kWta6bIBqEINGW/aa
    wbA+viS2OZVvsg907tu2msiya+BQ6gfOExYxF5mkBthgdMeTKsdmB2rMwQZw
X-ME-Proxy: <xmx:6UAdasQw-t4VMrHA2bxeSnQSul3SlikAQpULpcbSRzhBmYKeQHbGRw>
    <xmx:6UAdaitZzY4osdl-veKd8VHQbzLeFKUGMsck-FPLX70rul8_-WUvug>
    <xmx:6UAdaryEx2ZzosTwNEXkPCRcVJG-eH59hIaQAIS3n1o_SHMI4w93KQ>
    <xmx:6UAdas4eGUWr5bjnumKYa_YGsSqWxc2VaRVNacJIfL5sE5aRSBqE5Q>
    <xmx:6UAdagTnad_DWcQPqIq4EjEZr_5wCzmSTS8KW7Aa_9RJL-y9gm4kKmMa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:20:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d3587652 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:20:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:34 +0200
Subject: [PATCH v2 11/18] odb/source-loose: drop
 `odb_source_loose_has_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-11-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The function `odb_source_loose_has_object()` checks whether a specific
object exists as a loose object on disk by using lstat(3p). This
interface is somewhat redundant, as we typically check for object
existence in a generic way via `odb_source_read_object_info()`.

In fact, these two calls are redundant in case the latter is called in a
specific way: when called without an object info request and without the
`OBJECT_INFO_QUICK` flag, then we will end up doing the same call to
lstat(3p) in `read_object_info_from_path()`.

Drop the function and adapt callers to instead use the generic
interface so that its calling conventions align with that of other
sources.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 12 ++++++++----
 object-file.c          | 12 ++++--------
 object-file.h          |  8 --------
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 480cc0bd8c..a6be3d659f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1750,9 +1750,11 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		 * skip the local object source.
 		 */
 		struct odb_source *source = the_repository->objects->sources->next;
-		for (; source; source = source->next)
-			if (odb_source_loose_has_object(source, oid))
+		for (; source; source = source->next) {
+			struct odb_source_files *files = odb_source_files_downcast(source);
+			if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0))
 				return 0;
+		}
 	}
 
 	/*
@@ -4135,9 +4137,11 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 			struct odb_source *source = the_repository->objects->sources;
 			int found = 0;
 
-			for (; !found && source; source = source->next)
-				if (odb_source_loose_has_object(source, oid))
+			for (; !found && source; source = source->next) {
+				struct odb_source_files *files = odb_source_files_downcast(source);
+				if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0))
 					found = 1;
+			}
 
 			/*
 			 * If a traversed tree has a missing blob then we want
diff --git a/object-file.c b/object-file.c
index 9b2044de37..c83136cf70 100644
--- a/object-file.c
+++ b/object-file.c
@@ -96,12 +96,6 @@ static int check_and_freshen_source(struct odb_source *source,
 	return check_and_freshen_file(path.buf, freshen);
 }
 
-int odb_source_loose_has_object(struct odb_source *source,
-				const struct object_id *oid)
-{
-	return check_and_freshen_source(source, oid, 0);
-}
-
 int format_object_header(char *str, size_t size, enum object_type type,
 			 size_t objsize)
 {
@@ -1000,9 +994,11 @@ int force_object_loose(struct odb_source *source,
 	int hdrlen;
 	int ret;
 
-	for (struct odb_source *s = source->odb->sources; s; s = s->next)
-		if (odb_source_loose_has_object(s, oid))
+	for (struct odb_source *s = source->odb->sources; s; s = s->next) {
+		struct odb_source_files *files = odb_source_files_downcast(s);
+		if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0))
 			return 0;
+	}
 
 	oi.typep = &type;
 	oi.sizep = &len;
diff --git a/object-file.h b/object-file.h
index bc72d89f54..506ca6be40 100644
--- a/object-file.h
+++ b/object-file.h
@@ -23,14 +23,6 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 struct object_info;
 struct odb_source;
 
-/*
- * Return true iff an object database source has a loose object
- * with the specified name.  This function does not respect replace
- * references.
- */
-int odb_source_loose_has_object(struct odb_source *source,
-				const struct object_id *oid);
-
 int odb_source_loose_freshen_object(struct odb_source *source,
 				    const struct object_id *oid);
 

-- 
2.54.0.926.g75ba10bac6.dirty


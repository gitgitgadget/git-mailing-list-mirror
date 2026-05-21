Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297263AC0D4
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351781; cv=none; b=YN79wemxL1oXyiILF4YBEGnq1tZ0AWKLLGAgTE13ozpGSwS7BlOVxhDhzmvZ0ZLbI4UmLs4CXvgScY1WZS+KH4HVL+q4Sq0QLJwgJ4mzluekF8lQ2b/blGa/m0FV5yKp+Y1p5n+w9cbOfW0Yun38fE6ynO7G95iJCSbwM4kDOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351781; c=relaxed/simple;
	bh=zn6ZJ/WPmaPt60o7LWB+XQY3Dt7yOeCUchlEBy5aOKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jRVVfu2wld2vnNR6tfQsmcgtSCrdE2JLT0Z1fzl7A4CXNxwVVk5tUMoJAtSrCxXCNaEQwpQO7RgZ9wtwXUEX5xVVHhbLHYwnexTlThBtPl+4iBWAAFpIkcFqfmdlJcoVHEke+EoVMWxe8X6r9+VM+0eBsOFrFoJ6CPlVGBIiCF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UBFVb4P/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vEtcfiAN; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UBFVb4P/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vEtcfiAN"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 552C31400081
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:22:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 21 May 2026 04:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351779;
	 x=1779438179; bh=WMfm+54JzoTG4hWatw3E70Jm7Eyn++71ZQAT4fgw0t4=; b=
	UBFVb4P/3RwCyFhQ1KlLFG5IfhXCLHxFfgYTZJAtEAkMEBPnk6nSJggPiwrDIGrt
	XlsPEIFN1I4dwzuzvBJtSwOr6KsCvRRYhRJE94iY0E4xMQ2hg1OGn9zQNbeQN43U
	iCmVYYazXEpdjIAuJRN1EF6jx5Q4bXVAMr/RCvUKgNeAnIlCqDbyNKuI9TejKlgc
	/e3Q/OBe+HRzorrCkqMs1BCvhDS0SLDboH7imYSLOwysScyPOaptvuLIiFb3bPKJ
	HoBug3YLdnE5MK2lIMCEZfq0CpXF3keVv7VVO07j6BOvqoj3EluJfIcybu/2apD2
	7HbBiuOFndSN1iSie8ju/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351779; x=
	1779438179; bh=WMfm+54JzoTG4hWatw3E70Jm7Eyn++71ZQAT4fgw0t4=; b=v
	EtcfiANcGRl6RNdx8IjxUhXUAl/kMR+LqDaFO7VTzk54mx/AqYsp1FTmSFPn5rbo
	1vjONi/YOhWo6p7p31UlBSCva/UeAmsBsOB0pYWWJroRHsG8wrxOpmf9wbGjOiaz
	iFbD0A2hbkpQ+9oTu+Ykz5auuX8BKOSn11iDMzFmhSXFuyUiwryD9nT2iRSj9Mgi
	IS/mkhOJb2xjbJRnuMvkaCuKfYZODbkP11I8tLnZyXLsxedhygFsU1f1WlDiWf/J
	D67yI8MzSCHbR8VbZ/vnVfKC7pIfvnssqIvQhl7ghg4CbrwQ8uB+U6YMr1clTAup
	YphbYOuo6RauxZi4eDZKA==
X-ME-Sender: <xms:48AOaqViHC-sjxd_3JbtNkkp7bDkb_9553ouK6g7R5Mgflr8fo8zdg>
    <xme:48AOathScjwrWTBmlfX2ReUUN1it2jvWuY-LSdMHfprSHf4OmbQaJ8TNqe4McW6pf
    3cMnYWrk4oZWZzRH9p_OTkl7HFsSzhv9CdYJ932lhymD6xVSdy0>
X-ME-Received: <xmr:48AOakDBXZ7Gvc-2zPy0CnwZ9booFxpGYSIpM8MvQeyDfE7pA2F9hngPWCPJTeriIm2McUVwABjbVOpkffo9e2VHQ7nyOjh_mjYxeHB35E8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:48AOamdJALnyqpimJC5U3O9ZyxmuljSTlcbxLvfOk54vwV9sWIliTw>
    <xmx:48AOakfAKqX9qdiNqS6RCexzQXZL0CYyde5fn9JJ6R9zDr2Ua6wjIQ>
    <xmx:48AOaiiVElEKDnuOmi_0LAFicbZYyDgEsgWX5SCXEm5cubp0ylSWpw>
    <xmx:48AOaoR7ynbkhkbb_vXnrcO8GPQwImmqnDt7pQac2FXJL1NryD6J1Q>
    <xmx:48AOapnART579P9byT3GiH_FmAdWeB1JyTOeSzEQd0e90j9gHDYchJZ6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:22:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 31034c60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:22:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:31 +0200
Subject: [PATCH 11/18] odb/source-loose: drop
 `odb_source_loose_has_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-11-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
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


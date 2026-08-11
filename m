Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533036E494
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470868; cv=none; b=Ax3vE5hx8AtR7rGHB1DqkNq+bbeIxXCzqX0ctvmVqQxURsBeihceorqyEhvxB6vbgdXI/isA4Y57QKvxyvQMlD3C79TQXhdzJ11Q2TgiFGr8khnaN36XqmUQnsinZvDroxVAX9hIikoz2G+nsFrVX+w4y+Rtc67ZO0J3AHa0Rxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470868; c=relaxed/simple;
	bh=OUcPbGuzbb8pyxjQfjzDOet+UytgnIupsjg34HviTYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIr54KOPHgrImJQ0kGMH0zM05ldMYDxZAiuimOV9y04SszC29O8PTaSKGpafgYkWwcMeR3ZmqT6e3SG72Rp10J6kjvJNaVfAs3kn5WmOTPXxr/NBCSDCArrNHva9JCsq+Gg8q/RWwAheXRJJD+oHF+ZzN0Uc/X0oPBZ0ns+tjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfJclWS5; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfJclWS5"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-456395f4e7bso31547fac.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 10:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786470866; x=1787075666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nR0aPcfVmssE2DVb9TZbTLcTDzeN9M3h3j9cx5My4TA=;
        b=KfJclWS5qRD3GyI3X/vHqKnQaobZR89u6k3TCue/60wEedTrIgJre6btSBMU3OuqJG
         6UTbCQmbrPokheew4w/KAadYRz5XP8GgBEDpgl/P4XZUjpEuk1ZiMTb+7s3SxOgadWVM
         bsloEXFpKdP+iOy6NLfZ2uaJsLuZohdJ7H4TSkX9LldE2jeZB2OUXZWed3v+JxDbpN/h
         KO3f8q/G6Eonp5YS40+B7ufRiml4OpSsQcm53beVdQJkW2OjQ29JVycIQMNw4tHCkAZL
         PL9rdN4U4HSw5TmUNq8NuWKMbFyojnAGS8yyZSXcC+MB5CldE6Z7oZ7850+XkrFilHIE
         wUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786470866; x=1787075666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nR0aPcfVmssE2DVb9TZbTLcTDzeN9M3h3j9cx5My4TA=;
        b=ZxddJn8ln3yw0SVQIs0Yx/SZm2MHh93Rh8OwmonxZprO4SUt7LmnM7foy1+XFwNpxu
         whHekPrShOmQ8wZHRYx1k8qVGBjFMkRmVEcClvQrpyFDgabrX22iajWUBD+T3mL8VQYT
         noaVC9CXxyc3gCtPN/6R9PCCzuuF2DjbJKKDxN/xMG5QTHPNXH+sr6AadoDlKR7ToH0D
         M/WQ+tanSFIfzIr5h1qWEn2gjyWem7jnrnD7t0KsEdlwDQKzN682fd1MGOV6Gt5vsPc0
         bSd4FIaRo2eP5408v3e/L5i77jFoOPz46nUpveoPa9ZTuQL5pNvMmAJgf2W26+AviJZb
         jayQ==
X-Gm-Message-State: AOJu0Ywm8BbzLGfPwa/Pq4cPrR8Gq8+CRC+mAWBWLJkh8mc3Oo8qlOI3
	TQ9GDyFTjxPEEH57pp5E38OgXeqOrqnVKNmmfQIgXerZJCmrVGrJGw1aXseCBA==
X-Gm-Gg: AR+sD13Z6zIEJ+rgZFVUnYpwI7vPlCG8YxPR1AZXyNthNLjV0WjMeQCCedtFW5JQpzX
	VqSyszO93cswDe5NeUelBbSp+vFNtRZCUnUTBvWZPr+mBNcChT28r11LLDaiXn+5sfN/sY5Rp3U
	TKKZNDGLtfGypxOM2bV+WHvT2zvjtL1o3ceqA0MTRw0VlcqcEWukz4TrQNUACX5f9UiuiKjg4I7
	m6TyFHn6ZHd3f7D1PE6SxxFVEjOcOxXkXiV/EMGUsWORWY56qDy6YBpzmZMwKsJZdVzocl8uCHR
	JxufOJyAvSheHjDj+uWxyVGuB0B/hJPRFjI0X887XPUIxgotUBZjhhvSzxDRQY77KPqFX5V3b9q
	jy5Ib831s4WqUffXsbcOmKI5vyiUK6mcgGffbuGW2VgbyaAiQxNFDVY+uyhkIUawJOssLxMY0j8
	GbDjJWAqX4c/5eI5WyK+oPZhUURiyFtlJTqjI0MsKX5rI86P490X5PG23XkqoNSoH5O1uP
X-Received: by 2002:a05:6808:6808:b0:495:d7ec:b6be with SMTP id 5614622812f47-4b1fd8c88ecmr3567951b6e.18.1786470866030;
        Tue, 11 Aug 2026 10:54:26 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2001331d2sm1241489b6e.11.2026.08.11.10.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:54:25 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/9] builtin/receive-pack: pass shallow file explicitly
Date: Tue, 11 Aug 2026 12:54:09 -0500
Message-ID: <20260811175415.2044235-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260811175415.2044235-1-jltobler@gmail.com>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If shallow information is provided during `unpack()`, a temporary
shallow file is created and stored in global state. In a subsequent
commit, the `unpack()` logic is moved behind a generic ODB transaction
interface to handle writing packfiles and thus can no longer rely on
such global state. Lift the setup of the temporary shallow file out of
`unpack()` and wire it through to its call sites explicitly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ed1edcbe93..135105deae 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -86,7 +86,6 @@ static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
-static const char *alt_shallow_file;
 static struct strbuf push_cert = STRBUF_INIT;
 static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
@@ -2334,8 +2333,8 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
 }
 
-static const char *unpack(int err_fd, struct shallow_info *si,
-			  struct odb_transaction *transaction)
+static const char *unpack(struct odb_transaction *transaction,
+			  const char *shallow_file, int err_fd)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -2354,10 +2353,9 @@ static const char *unpack(int err_fd, struct shallow_info *si,
 		return hdr_err;
 	}
 
-	if (si->nr_ours || si->nr_theirs) {
-		alt_shallow_file = setup_temporary_shallow(si->shallow);
+	if (shallow_file) {
 		strvec_push(&child.args, "--shallow-file");
-		strvec_push(&child.args, alt_shallow_file);
+		strvec_push(&child.args, shallow_file);
 	}
 
 	odb_transaction_env(transaction, &child.env);
@@ -2433,14 +2431,14 @@ static const char *unpack(int err_fd, struct shallow_info *si,
 	return NULL;
 }
 
-static const char *unpack_with_sideband(struct shallow_info *si,
-					struct odb_transaction *transaction)
+static const char *unpack_with_sideband(struct odb_transaction *transaction,
+					const char *shallow_file)
 {
 	struct async muxer;
 	const char *ret;
 
 	if (!use_sideband)
-		return unpack(0, si, transaction);
+		return unpack(transaction, shallow_file, 0);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2449,13 +2447,14 @@ static const char *unpack_with_sideband(struct shallow_info *si,
 	if (start_async(&muxer))
 		return NULL;
 
-	ret = unpack(muxer.in, si, transaction);
+	ret = unpack(transaction, shallow_file, muxer.in);
 
 	finish_async(&muxer);
 	return ret;
 }
 
-static void prepare_shallow_update(struct shallow_info *si)
+static void prepare_shallow_update(struct shallow_info *si,
+				   const char *shallow_file)
 {
 	int i, j, k, bitmap_size = DIV_ROUND_UP(si->ref->nr, 32);
 
@@ -2495,12 +2494,13 @@ static void prepare_shallow_update(struct shallow_info *si)
 	 * command. check_connected() will be done with
 	 * true .git/shallow though.
 	 */
-	setenv(GIT_SHALLOW_FILE_ENVIRONMENT, alt_shallow_file, 1);
+	setenv(GIT_SHALLOW_FILE_ENVIRONMENT, shallow_file, 1);
 }
 
 static void update_shallow_info(struct command *commands,
 				struct shallow_info *si,
-				struct oid_array *ref)
+				struct oid_array *ref,
+				const char *shallow_file)
 {
 	struct command *cmd;
 	int *ref_status;
@@ -2519,7 +2519,7 @@ static void update_shallow_info(struct command *commands,
 	si->ref = ref;
 
 	if (shallow_update) {
-		prepare_shallow_update(si);
+		prepare_shallow_update(si, shallow_file);
 		return;
 	}
 
@@ -2711,11 +2711,17 @@ int cmd_receive_pack(int argc,
 		if (!si.nr_ours && !si.nr_theirs)
 			shallow_update = 0;
 		if (!delete_only(commands)) {
+			const char *alt_shallow_file = NULL;
+
+			if (si.nr_ours || si.nr_theirs)
+				alt_shallow_file = setup_temporary_shallow(si.shallow);
+
 			if (odb_transaction_begin(the_repository->objects, &transaction, ODB_TRANSACTION_RECEIVE))
 				unpack_status = "unable to start object transaction";
 			else
-				unpack_status = unpack_with_sideband(&si, transaction);
-			update_shallow_info(commands, &si, &ref);
+				unpack_status = unpack_with_sideband(transaction, alt_shallow_file);
+
+			update_shallow_info(commands, &si, &ref, alt_shallow_file);
 		}
 		use_keepalive = KEEPALIVE_ALWAYS;
 		execute_commands(commands, unpack_status, &si, transaction,
-- 
2.55.0.424.g13c7afec21


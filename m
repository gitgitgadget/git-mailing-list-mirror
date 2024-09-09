Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB0175D20
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914843; cv=none; b=gap1u+SH+COxkhvV0Xsz0GxyS9R54WF9KXO6pTdJnBA4iIoO6oqq/utNTaViUpRQkJWLzYIkk5LnLzsd81WoBhO6CzQjceuhm3GMc1+WtFvTSTHAV70CS54O3eYdDEVZ2gGwoeH2LAo5ioEsaDNFPDFSB0rm8438TGWkvNqSuiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914843; c=relaxed/simple;
	bh=pBB/h8bHbgkNCMVV+xwRsboUHNzISdN2I0Vw95sriXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nSXAv0+FIq9sXTuVY3QL5wmd3AmwALD6YDbvk313HOfgoRuaOSq2UWJKnScR3cYbQUxOW88hyeD6d2butkA1fjOdHkLUKV0PBu/xEst8vn10yyNjpR8/KNhu+10AURv9jQHXsIvdPDpBfr5Kipd8ZCxpZUVPkhwpcPvniPlNBOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=u++W20Hj; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u++W20Hj"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BCDE232E5;
	Mon,  9 Sep 2024 16:47:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pBB/h8bHbgkNCMVV+xwRsboUHNzISdN2I0Vw95
	sriXw=; b=u++W20HjjwcPKLNG5FStvLUux7g4JLAN0b6+ImxwFhewx5I/CDqviO
	Gpcj3N5d78HnyNW8+N1A3C2iIF7HcqW0ZZoj7dkug3t9Yk6e/Wy0uSr4SKFzXStj
	l7y3A3G3ro7cJq4BKhHKMBhgwJKqW69nYIqdwEYKK/rQgwMwDkqAc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 80B18232E4;
	Mon,  9 Sep 2024 16:47:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBCC9232E3;
	Mon,  9 Sep 2024 16:47:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org,  steadmon@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com,
  mh@glandium.org,  sandals@crustytoothpaste.net,  Jason@zx2c4.com,
  dsimic@manjaro.org
Subject: Re: [PATCH v3 5/6] libgit: add higher-level libgit crate
In-Reply-To: <xmqqv7z8tjd7.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	06 Sep 2024 17:09:24 -0700")
References: <20240906221853.257984-1-calvinwan@google.com>
	<20240906222116.270196-5-calvinwan@google.com>
	<xmqqv7z8tjd7.fsf@gitster.g>
Date: Mon, 09 Sep 2024 13:47:18 -0700
Message-ID: <xmqqcylcpnah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B4F77172-6EEC-11EF-AE07-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> +struct libgit_config_set *libgit_configset_alloc(void)
>> +{
>> +	return git_configset_alloc();
>> +}
>
> git_configset_alloc() returns "struct config_set *" while this thing
> returns an incompatible pointer.  
>
> Sent out an outdated version or something?  This wouldn't have
> passed even a compile test, I suspect.

The "shim" layer should hide the details of interfacing to the git
proper from callers, as well as it should hide the callers' from the
git proper.  So if you really want to hide "struct config_set" from
your library callers, you may need to do something like the
attached, perhaps?  At least this does pass compilation test.

 .../libgit-rs/libgit-sys/public_symbol_export.h    | 11 +++++++++
 .../libgit-rs/libgit-sys/public_symbol_export.c    | 26 ++++++++++++----------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git c/contrib/libgit-rs/libgit-sys/public_symbol_export.h w/contrib/libgit-rs/libgit-sys/public_symbol_export.h
index 3933698976..70701ca63e 100644
--- c/contrib/libgit-rs/libgit-sys/public_symbol_export.h
+++ w/contrib/libgit-rs/libgit-sys/public_symbol_export.h
@@ -1,6 +1,17 @@
 #ifndef PUBLIC_SYMBOL_EXPORT_H
 #define PUBLIC_SYMBOL_EXPORT_H
 
+/* shim */
+struct libgit_config_set {
+	struct config_set cs;
+	/* 
+	 * the shim layer may want to add more members below, but then
+	 * it may need to wrap underlying config_set differently,
+	 * e.g., store a pointer of an allocated config_set in this
+	 * shim structure.
+	 */
+};
+
 const char *libgit_setup_git_directory(void);
 
 int libgit_config_get_int(const char *key, int *dest);

diff --git c/contrib/libgit-rs/libgit-sys/public_symbol_export.c w/contrib/libgit-rs/libgit-sys/public_symbol_export.c
index 07d6bfdd84..6f5eb3b249 100644
--- c/contrib/libgit-rs/libgit-sys/public_symbol_export.c
+++ w/contrib/libgit-rs/libgit-sys/public_symbol_export.c
@@ -3,12 +3,13 @@
 // avoid conflicts with other libraries such as libgit2.
 
 #include "git-compat-util.h"
-#include "contrib/libgit-rs/libgit-sys/public_symbol_export.h"
 #include "common-init.h"
 #include "config.h"
 #include "setup.h"
 #include "version.h"
 
+#include "contrib/libgit-rs/libgit-sys/public_symbol_export.h"
+
 extern struct repository *the_repository;
 
 #pragma GCC visibility push(default)
@@ -35,32 +36,33 @@ int libgit_parse_maybe_bool(const char *val)
 
 struct libgit_config_set *libgit_configset_alloc(void)
 {
-	return git_configset_alloc();
+	void *cs = git_configset_alloc();
+	return (struct libgit_config_set *)cs;
 }
 
-void libgit_configset_clear_and_free(struct libgit_config_set *cs)
+void libgit_configset_clear_and_free(struct libgit_config_set *lgcs)
 {
-	git_configset_clear_and_free(cs);
+	git_configset_clear_and_free(&lgcs->cs);
 }
 
-void libgit_configset_init(struct libgit_config_set *cs)
+void libgit_configset_init(struct libgit_config_set *lgcs)
 {
-	git_configset_init(cs);
+	git_configset_init(&lgcs->cs);
 }
 
-int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename)
+int libgit_configset_add_file(struct libgit_config_set *lgcs, const char *filename)
 {
-	return git_configset_add_file(cs, filename);
+	return git_configset_add_file(&lgcs->cs, filename);
 }
 
-int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest)
+int libgit_configset_get_int(struct libgit_config_set *lgcs, const char *key, int *dest)
 {
-	return git_configset_get_int(cs, key, dest);
+	return git_configset_get_int(&lgcs->cs, key, dest);
 }
 
-int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest)
+int libgit_configset_get_string(struct libgit_config_set *lgcs, const char *key, char **dest)
 {
-	return git_configset_get_string(cs, key, dest);
+	return git_configset_get_string(&lgcs->cs, key, dest);
 }
 
 const char *libgit_user_agent(void)

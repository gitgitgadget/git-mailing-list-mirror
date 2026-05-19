Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C44A2E1E
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207910; cv=none; b=jZ0EGFyZ4mzaN1Fgchcu51EKin8EQs3E1ap8LpHqag7Be9bQ+9a3ZuhOnw45LgAtbPXdVX7S65W6zNdarukPVvx+b18YZP6QZ/htdCHz2e0yhKaprR5XOAPf8NNXu5+aOhDp4OjWbqTlY5M1x73uU/O17HSpDMCp4IEROHjImWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207910; c=relaxed/simple;
	bh=iR2EMsTNPafYNPE5oOzrxnq0/wW5ZDda2Tbncpmy3CE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N/5n+QuawhYw/NsAwYJhS4JsXSVirnIMpp4DrvXBLO2wQH7dipf7wq+R2adl/dpNegMD3Y22ictR8WenKDB1/HAWB/TvZe/qcNXmWjfF96rLl12m3x52GRa+Tf2KZfYmox654lP7kdTh7jGqyf/d91F0YeI/WYxWlvEHSYoEB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE1I744u; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE1I744u"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1309f4ee97fso4228174c88.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779207908; x=1779812708; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxG5pArIlA5tKLz9QH/q/tZ15z+OcH1TdSTAe4RlIa0=;
        b=IE1I744ukQpsRpT/TPkMLsskaGVsyo7Z54lN6W6loOiEMKHKdXLHdZuyLJACFRhrfv
         VC+ZUnAuq993NBinZnWTCSddqJYwLKACKRiVOVqniF740XiE7O2SKw5pftHrZgWERWva
         TJ6iOFqqKmoOn9AUaIfqbcAvc3TFWdYKf6ldih0xRo4FWwtY8wC9ItxCRfPGnjKs+H4Q
         KZnW/tj1wXZssMnRPvhK6RWp7WXHZOYoUnAQWm31vyn88IaMVNh5t52kvUhwCTTmN32s
         Phi7prQqy2+sk6xjGhn+XSAa9ip+p7ESs4Z8FtSetRnxs9QfgakEmtm8IAwAPC1and9p
         Utyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207908; x=1779812708;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hxG5pArIlA5tKLz9QH/q/tZ15z+OcH1TdSTAe4RlIa0=;
        b=p8Lo3poWRUlKtAFfwJRnq12uvSU1XPwOCDWF/GZyr9aEjysaUHXvjQwu+Lkgw5cF9c
         kRWLX9+GIt71tDuCm0GT6ZNWqt8EPn61wDJFO52vUUwCQhYPaBCw0NnfRIWPOhPPfuRD
         y2LLJrDQtxHtB0Gebg1Nv5rDGsJUpmy7Fvqlj+ZNk/C6lmiIzmT6ksAAFDFy6aCc91+Y
         ZGYZf7il1mIJI0R3YYSFEKKuUSEaMJF2sFiZeLrB7Ss24ZL6+QsPV59+kQjLGli3lf81
         e2QcbDsUS/qQOoeixEPmM4lgEaT+0zRenLZM0FUTqIsY1AOf1BuWACEI2zQkM+/bGpip
         r7KQ==
X-Gm-Message-State: AOJu0YwfLaZbaHutg2SHvG178VqxiWM7Kc8hRFB+yeapw/XO2oNTyugK
	+Jm/JaFQq5GOAPlDHCBPMeqGUhH1P5Lfo4K8cRnC84GGgtyM6oUM2knWBC2+Kw==
X-Gm-Gg: Acq92OHualzxsemSWq5qv95LzRn4G/8OZ+Bw+ViTTL0TK2cPz3Np1lR8u9Xrqbygu9T
	1tiljy7+SIkOryONhOvcdnaSyw/lVrmGvXcHWglKdHRaqOOwWsDqajMxTfadi6oDfuHvgT/1HTA
	OVcWTCRI0oubvN5xNEg6zw1wvg9pD10otRhSLwF8iY+dAx2A61v9KzUqLr9D4UsCz4jsw5lF535
	2/Dj4FZsIvcI2Lq1VEJ//Vg09RBXKQ7D6Vu2uY19H+zqCkcgS3EUo8drTawERbu2S5OAvqjWl/m
	50cDKDVwG2RUOUkCPB3PiA0KzdoI6hFm7ELm0/n6L7iJ4Dgsevr7KyrsASuL59mDQex/dxrmEF3
	zV4+2FHi9VGHjF+ZvFcKhVdDn4bMsKg+ESgexDfObp9PTMwuhIa3z7LkdbIWxi6FQBG1eMSueog
	BiWPqlZr3dxg60pORELnObg9TdzMCAFUoHBIuMSfk=
X-Received: by 2002:a05:7300:5726:b0:2d9:bc8d:f62a with SMTP id 5a478bee46e88-3039868cd4fmr8831126eec.16.1779207908419;
        Tue, 19 May 2026 09:25:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2352f2sm23418766c88.10.2026.05.19.09.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:25:07 -0700 (PDT)
Message-Id: <c69ca2e919b22de69b880c494084d8b707622277.1779207896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
References: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
	<pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 May 2026 16:24:55 +0000
Subject: [PATCH v6 8/8] send-pack: pass negotiation config in push
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    ps@pks.im,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When push.negotiate is enabled, 'git push' spawns a child 'git fetch
--negotiate-only' process to find common commits.  Pass
--negotiation-include and --negotiation-restrict options from the
'remote.<name>.negotiationInclude' and
'remote.<name>.negotiationRestrict' config keys to this child process.

When negotiationRestrict is configured, it replaces the default
behavior of using all remote refs as negotiation tips. This allows
the user to control which local refs are used for push negotiation.

When negotiationInclude is configured, the specified ref patterns
are passed as --negotiation-include to ensure their tips are always
sent as 'have' lines during push negotiation.

Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/remote.adoc |  6 ++++++
 send-pack.c                      | 37 ++++++++++++++++++++++++++------
 send-pack.h                      |  2 ++
 t/t5516-fetch-push.sh            | 30 ++++++++++++++++++++++++++
 transport.c                      |  2 ++
 5 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 1951df154e..eb9c8a3c48 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -122,6 +122,9 @@ command-line option.  If `--negotiation-restrict` (or its synonym
 `--negotiation-tip`) is specified on the command line, then the config
 values are not used.
 +
+These values also influence negotiation during `git push` if
+`push.negotiate` is enabled.
++
 Blank values signal to ignore all previous values, allowing a reset of
 the list from broader config scenarios.
 
@@ -147,6 +150,9 @@ negotiation algorithm still runs and advertises its own selected commits,
 but the refs matching `remote.<name>.negotiationInclude` are sent
 unconditionally on top of those heuristically selected commits.
 +
+These values also influence negotiation during `git push` if
+`push.negotiate` is enabled.
++
 Blank values signal to ignore all previous values, allowing a reset of
 the list from broader config scenarios.
 
diff --git a/send-pack.c b/send-pack.c
index 3d5d36ba3b..d18e030ce8 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -433,28 +433,48 @@ static void reject_invalid_nonce(const char *nonce, int len)
 
 static void get_commons_through_negotiation(struct repository *r,
 					    const char *url,
+					    const struct string_list *negotiation_include,
+					    const struct string_list *negotiation_restrict,
 					    const struct ref *remote_refs,
 					    struct oid_array *commons)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	const struct ref *ref;
 	int len = r->hash_algo->hexsz + 1; /* hash + NL */
-	int nr_negotiation_tip = 0;
+	int nr_negotiation = 0;
 
 	child.git_cmd = 1;
 	child.no_stdin = 1;
 	child.out = -1;
 	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
-	for (ref = remote_refs; ref; ref = ref->next) {
-		if (!is_null_oid(&ref->new_oid)) {
+
+	if (negotiation_restrict && negotiation_restrict->nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, negotiation_restrict)
 			strvec_pushf(&child.args, "--negotiation-restrict=%s",
-				     oid_to_hex(&ref->new_oid));
-			nr_negotiation_tip++;
+				     item->string);
+		nr_negotiation = negotiation_restrict->nr;
+	} else {
+		for (ref = remote_refs; ref; ref = ref->next) {
+			if (!is_null_oid(&ref->new_oid)) {
+				strvec_pushf(&child.args, "--negotiation-restrict=%s",
+					     oid_to_hex(&ref->new_oid));
+				nr_negotiation++;
+			}
 		}
 	}
+
+	if (negotiation_include && negotiation_include->nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, negotiation_include)
+			strvec_pushf(&child.args, "--negotiation-include=%s",
+				     item->string);
+		nr_negotiation += negotiation_include->nr;
+	}
+
 	strvec_push(&child.args, url);
 
-	if (!nr_negotiation_tip) {
+	if (!nr_negotiation) {
 		child_process_clear(&child);
 		return;
 	}
@@ -528,7 +548,10 @@ int send_pack(struct repository *r,
 	repo_config_get_bool(r, "push.negotiate", &push_negotiate);
 	if (push_negotiate) {
 		trace2_region_enter("send_pack", "push_negotiate", r);
-		get_commons_through_negotiation(r, args->url, remote_refs, &commons);
+		get_commons_through_negotiation(r, args->url,
+					       args->negotiation_include,
+					       args->negotiation_restrict,
+					       remote_refs, &commons);
 		trace2_region_leave("send_pack", "push_negotiate", r);
 	}
 
diff --git a/send-pack.h b/send-pack.h
index c5ded2d200..13850c98bb 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -18,6 +18,8 @@ struct repository;
 
 struct send_pack_args {
 	const char *url;
+	const struct string_list *negotiation_include;
+	const struct string_list *negotiation_restrict;
 	unsigned verbose:1,
 		quiet:1,
 		porcelain:1,
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index ac8447f21e..177cbc6c75 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -254,6 +254,36 @@ test_expect_success 'push with negotiation does not attempt to fetch submodules'
 	! grep "Fetching submodule" err
 '
 
+test_expect_success 'push with negotiation and remote.<name>.negotiationInclude' '
+	test_when_finished rm -rf negotiation_include &&
+	mk_empty negotiation_include &&
+	git push negotiation_include $the_first_commit:refs/remotes/origin/first_commit &&
+	test_commit -C negotiation_include unrelated_commit &&
+	git -C negotiation_include config receive.hideRefs refs/remotes/origin/first_commit &&
+	test_when_finished "rm event" &&
+	GIT_TRACE2_EVENT="$(pwd)/event" \
+		git -c protocol.version=2 -c push.negotiate=1 \
+		-c remote.negotiation_include.negotiationInclude=refs/heads/main \
+		push negotiation_include refs/heads/main:refs/remotes/origin/main &&
+	test_grep \"key\":\"total_rounds\" event &&
+	grep_wrote 2 event # 1 commit, 1 tree
+'
+
+test_expect_success 'push with negotiation and remote.<name>.negotiationRestrict' '
+	test_when_finished rm -rf negotiation_restrict &&
+	mk_empty negotiation_restrict &&
+	git push negotiation_restrict $the_first_commit:refs/remotes/origin/first_commit &&
+	test_commit -C negotiation_restrict unrelated_commit &&
+	git -C negotiation_restrict config receive.hideRefs refs/remotes/origin/first_commit &&
+	test_when_finished "rm event" &&
+	GIT_TRACE2_EVENT="$(pwd)/event" \
+		git -c protocol.version=2 -c push.negotiate=1 \
+		-c remote.negotiation_restrict.negotiationRestrict=refs/heads/main \
+		push negotiation_restrict refs/heads/main:refs/remotes/origin/main &&
+	test_grep \"key\":\"total_rounds\" event &&
+	grep_wrote 2 event # 1 commit, 1 tree
+'
+
 test_expect_success 'push without wildcard' '
 	mk_empty testrepo &&
 
diff --git a/transport.c b/transport.c
index fa54928966..a2d8958cb8 100644
--- a/transport.c
+++ b/transport.c
@@ -921,6 +921,8 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
 	args.push_options = transport->push_options;
 	args.url = transport->url;
+	args.negotiation_include = &transport->remote->negotiation_include;
+	args.negotiation_restrict = &transport->remote->negotiation_restrict;
 
 	if (flags & TRANSPORT_PUSH_CERT_ALWAYS)
 		args.push_cert = SEND_PACK_PUSH_CERT_ALWAYS;
-- 
gitgitgadget

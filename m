Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A46430E0EF
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871559; cv=none; b=ZeVqkp92sGFD2Ix+V3cN6IbS3+buLNtoKKcySe4GcI+zyifQKczDl/cjjMgombnh/hWxNLe6qQCIhLtW+adQ4G4l/Vyg+FdewzKkyVEPHAtFpnCz1JVuRSk+Lz/DmtzEcLxqmpkV0jlaK1HbbFy2053EOlj4yNNXwmMTGtRefwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871559; c=relaxed/simple;
	bh=nggAsERb6c7u88h1gXRKSfEbR5LPBXAb9N65eTLpBGU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V/mcBaIRKjZ6/bLenVkUsa9ZBnxVeE648zEVYFV7TFsLB4wy5w1JyIQ0oA3oTXBslBNkDAAGJ+YgYSirA+mnExqtPx47vD6gUcIWr8SVmzbKR6qIcfl48iIkFA5wfQhG80OM3m1rz02MLC0IZxdmNCbPbg1MBtm2AHFL5wxATnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIz/RjxE; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIz/RjxE"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso933128c88.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871552; x=1777476352; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tk6I83P7zFD5mRkXJ76BrCZ0BRxBeNTZ5M5DJEYTK2I=;
        b=TIz/RjxEjX20seo+o2dAJD3cz2DWsvRY9u5uqfYXbcBM/437UnmQG4SCWq9szzhJaI
         pUBIAnQlLH13PXMiAR3FZ6KwZNoCbuDCi7HRAui8i89zzXO4pxGIjlwxcn3A9vBNJIkb
         Q9yY6tXPQ6ZVDdcJx1Vt+qQs5i4kpvz4r1pTFjLC03cJ7U7Ke6alTtb4xSDK1Gwjoesu
         l0YeoiDjG2CuMD5kU+83BQ+sulM5BZW3MU6CXqSqdrTFF58IocfxjDgw+WdwjsUSRB3A
         bkWzfjfPXEACRu2OiIIx7GPrdnCnkuihJ1hbZAswSNoz+iS5UIbs/CBrb9NA5ycWhTtF
         6o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871552; x=1777476352;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tk6I83P7zFD5mRkXJ76BrCZ0BRxBeNTZ5M5DJEYTK2I=;
        b=co/gP85OhL2zAuK4vMKmbh5bAwF0D2yPWUFQIR9h9MAAyDPhOA2P6pkTld/QtO4ccP
         JjjGv6VjfBiNPyDjF8Lj4uCtu5phqTJZh/IEEE4KIj1YPBpVjafyRIxd9oRi6d5YHiZz
         QTT8D9YI/j6Dn4enSISsyMukOFeFxlSSv2ErBFmFAssJfO27FRFz4kMt0YiTQf+1hdMj
         nV4Zv6mU5qM3WDv3i1N0dYIg+QsnLmIvf0PZ89U0bE82fPA8ES2wWhK588QeQSUv6pQt
         W6wYFv9gfuDfDn57TuVoADw+ygU3h8w5XgU/nlcd7EfH88TVHZwm7nPcxtoqdecO9znA
         OPaA==
X-Gm-Message-State: AOJu0YywfV2NvAFtUUcUjAaPX5SUf3euU3lGkh3eFUAjhbsAuYYsmWD9
	7DC8kxFlj3XA78LvzEqyWfCzVDSfbQKLnaeGiUCXVC7cDfR/KO1e0UehrfwNnA==
X-Gm-Gg: AeBDievlIkyL4PfCo8dBYtQClnczKb8YovCDcpqJ6Bfo3hDQjd2RxiL4se+eeK96EBx
	NdjJe1RovDNC/wWpnHNXw6lXK9BD6am0z2DGHr9ihM9R+aV8TxWlrSb+o3UQVjdrQszfKUh++Ka
	x3ljhEXUaPo5IIfhD2e/ppmkjHp/391Lw8xoE+iBt7L2NcPEEqsU28rP519xZo2MLvD+fGRLrdg
	1OpWMm+fwAn+wIUfPLmLUsQQ2R7sVbNNrU/YDe68fagmRmIvSADph+HrkNbVZXq7DEwTxzP+REC
	TF4JKR7EMgP0a3gvzdjXcgQPnYwIj0jRSetKv3pGMHima75DH+i7v0EAXw5Pdeilw3mgh8kcHhM
	OGa5+aeevxXwStkNl70lNksK3rP2bWzVYe3KFJALwFOCyb9K01tmD4IOOqqWuCYFAHmlmvvQywL
	/KKsuWzGVimoA6IEKX0k+s7iuOZ+DKFJIDfsOqJQ==
X-Received: by 2002:a05:7022:4586:b0:12d:b7bb:4f54 with SMTP id a92af1059eb24-12db7bb5581mr3444422c88.3.1776871551755;
        Wed, 22 Apr 2026 08:25:51 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.246])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm30073313c88.14.2026.04.22.08.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:25:51 -0700 (PDT)
Message-Id: <fe875399a851ba27ab193463cb6a1faf62aa6835.1776871546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
	<pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Apr 2026 15:25:41 +0000
Subject: [PATCH v3 2/7] fetch: add --negotiation-restrict option
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The --negotiation-tip option to 'git fetch' and 'git pull' allows users
to specify that they want to focus negotiation on a small set of
references. This is a _restriction_ on the negotiation set, helping to
focus the negotiation when the ref count is high. However, it doesn't
allow for the ability to opportunistically select references beyond that
list.

This subtle detail that this is a 'maximum set' and not a 'minimum set'
is not immediately clear from the option name. This makes it more
complicated to add a new option that provides the complementary behavior
of a minimum set.

For now, create a new synonym option, --negotiation-restrict, that
behaves identically to --negotiation-tip. Update the documentation to
make it clear that this new name is the preferred option, but we keep
the old name for compatibility. Mark --negotiation-tip as an alias of the
new, preferred option.

Update a few warning messages with the new option, but also make them
translatable with the option name inserted by formatting. At least one
of these messages will be reused later for a new option.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/fetch-options.adoc |  4 ++++
 builtin/fetch.c                  | 13 ++++++++-----
 builtin/pull.c                   |  3 +++
 t/t5510-fetch.sh                 | 25 +++++++++++++++++++++++++
 t/t5702-protocol-v2.sh           |  4 ++--
 5 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 81a9d7f9bb..c07b85499f 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -49,6 +49,7 @@ the current repository has the same history as the source repository.
 	`.git/shallow`. This option updates `.git/shallow` and accepts such
 	refs.
 
+`--negotiation-restrict=(<commit>|<glob>)`::
 `--negotiation-tip=(<commit>|<glob>)`::
 	By default, Git will report, to the server, commits reachable
 	from all local refs to find common commits in an attempt to
@@ -58,6 +59,9 @@ the current repository has the same history as the source repository.
 	local ref is likely to have commits in common with the
 	upstream ref being fetched.
 +
+`--negotiation-restrict` is the preferred name for this option;
+`--negotiation-tip` is accepted as a synonym.
++
 This option may be specified more than once; if so, Git will report
 commits reachable from any of the given commits.
 +
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4795b2a13c..fc950fe35b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1558,8 +1558,8 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 		refs_for_each_ref_ext(get_main_ref_store(the_repository),
 				      add_oid, oids, &opts);
 		if (old_nr == oids->nr)
-			warning("ignoring --negotiation-tip=%s because it does not match any refs",
-				s);
+			warning(_("ignoring %s=%s because it does not match any refs"),
+				"--negotiation-restrict", s);
 	}
 	smart_options->negotiation_tips = oids;
 }
@@ -1599,7 +1599,8 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 		if (transport->smart_options)
 			add_negotiation_tips(transport->smart_options);
 		else
-			warning("ignoring --negotiation-tip because the protocol does not support it");
+			warning(_("ignoring %s because the protocol does not support it"),
+				"--negotiation-restrict");
 	}
 	return transport;
 }
@@ -2565,8 +2566,9 @@ int cmd_fetch(int argc,
 			       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
 		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
 		OPT_IPVERSION(&family),
-		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
+		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
 				N_("report that we have only objects reachable from this object")),
+		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
 		OPT_BOOL(0, "negotiate-only", &negotiate_only,
 			 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
@@ -2657,7 +2659,8 @@ int cmd_fetch(int argc,
 	}
 
 	if (negotiate_only && !negotiation_tip.nr)
-		die(_("--negotiate-only needs one or more --negotiation-tip=*"));
+		die(_("%s needs one or more %s"), "--negotiate-only",
+		    "--negotiation-restrict=*");
 
 	if (deepen_relative) {
 		if (deepen_relative < 0)
diff --git a/builtin/pull.c b/builtin/pull.c
index 7e67fdce97..821cc6699a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -999,6 +999,9 @@ int cmd_pull(int argc,
 		OPT_PASSTHRU_ARGV(0, "negotiation-tip", &opt_fetch, N_("revision"),
 			N_("report that we have only objects reachable from this object"),
 			0),
+		OPT_PASSTHRU_ARGV(0, "negotiation-restrict", &opt_fetch, N_("revision"),
+			N_("report that we have only objects reachable from this object"),
+			0),
 		OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
 			 N_("check for forced-updates on all updated branches")),
 		OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5dcb4b51a4..dc3ce56d84 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1460,6 +1460,31 @@ EOF
 	test_cmp fatal-expect fatal-actual
 '
 
+test_expect_success '--negotiation-restrict limits "have" lines sent' '
+	setup_negotiation_tip server server 0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 --negotiation-restrict=beta_1 \
+		origin alpha_s beta_s &&
+	check_negotiation_tip
+'
+
+test_expect_success '--negotiation-restrict understands globs' '
+	setup_negotiation_tip server server 0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=*_1 \
+		origin alpha_s beta_s &&
+	check_negotiation_tip
+'
+
+test_expect_success '--negotiation-restrict and --negotiation-tip can be mixed' '
+	setup_negotiation_tip server server 0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 \
+		--negotiation-tip=beta_1 \
+		origin alpha_s beta_s &&
+	check_negotiation_tip
+'
+
 test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
 	git init df-conflict &&
 	(
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index f826ac46a5..9f6cf4142d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -869,14 +869,14 @@ setup_negotiate_only () {
 	test_commit -C client three
 }
 
-test_expect_success 'usage: --negotiate-only without --negotiation-tip' '
+test_expect_success 'usage: --negotiate-only without --negotiation-restrict' '
 	SERVER="server" &&
 	URI="file://$(pwd)/server" &&
 
 	setup_negotiate_only "$SERVER" "$URI" &&
 
 	cat >err.expect <<-\EOF &&
-	fatal: --negotiate-only needs one or more --negotiation-tip=*
+	fatal: --negotiate-only needs one or more --negotiation-restrict=*
 	EOF
 
 	test_must_fail git -c protocol.version=2 -C client fetch \
-- 
gitgitgadget


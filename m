Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3547F2FD
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207910; cv=none; b=ViaDzY0XE8uAEDvNNSTZDwCBrfGVI1EAbYM9EXue0vqH8YzX0JP0A3nPzK5fKiBai4n/pzwY4JzRRx3RGV0DT8Cc7O+J8I/OMm6YloEnLkJOGN3OtxdU1I/IsNJzDXVU7DEgtkuXZzAQ6n8f/MveeiV7bDQ/nLviQ3UBSziNGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207910; c=relaxed/simple;
	bh=sieQbRtle6NDMD3LCIlpjdCqWELwOoi3/sjSmBlZcp4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jXGour3Q/IhXQRPOe1XuYgFjF9rrJRvTaR9ZyqjhH0e5hzBGxn5ru++vz5UBwqwrNTyWlKW+fN7UjIeS7CbltwqYI2+T4vtIa2KJqBWquWs6hNiV5448KA5pDEXlTvjCfk82q+E52FmKQpdlR8XK4fS2YrfBRQXnfGYZMmzss9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+hc9wc3; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+hc9wc3"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-130c9dcbd25so2965483c88.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779207907; x=1779812707; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPBbT8ei2SQKaAxlVGfxNf2sdgXrMUu6DKVa58vTXb0=;
        b=F+hc9wc37jEUjL13Bh31rr8EToYylrEuXOBzma7IH9zw2Ckwr5eHyXwEqCWhMkG/i2
         Jzjo+U7WdPKvFX+NiLwwKT4EFPWX9lsBfFgLKwp/t9tep6qk3H0OI8WWHsy8fIc5e1gi
         6DJWU+/c2uB9pJH035Yw2E1D4BxXDnWTQ4xLxORkY7JTsnYXIR/spbm9eOLzNhT0WLAM
         8KqwSkfQt6eZZ1pqMN72b7w1JKzO4RmyMZWTQ3Bb9GlKk8ZBgoB22+jXNQq6OynQ3uB4
         ONHJ8cM03OvgAQj/rBqmZPYGZk2IxSK9NW3kyn1pbwynwoHzKDBexfFpkD/PgpOjh2yP
         Bwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207907; x=1779812707;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPBbT8ei2SQKaAxlVGfxNf2sdgXrMUu6DKVa58vTXb0=;
        b=Y+/J0qOGioZazhk9h2UkKBfgu3wVIVRPru8c98Gghupd7td8usBxipMbHyXdDul0M3
         +nrX0JxJ64WfYPsEFUkqnVR31z/sHwpsFRqvapkVG3JGJHiASqQDIbnbmf3LHhAD5Rcj
         VYqHhB/Soe35iHYXkIX/QjQGcJSPXUBmFt/BSCqoq341ofRXLOC+97AEHKOH4yofGpcm
         YXKlQOVR5hXbxPRxNe6vhr7udXGPYKWZiV6lkFHXlhB9kXhr7u8Spez2w7iJpCaHWdXp
         OUOz5kYHUE2MN6kqIpDDbPRHYX/sX0QLRAI6xCe/R5pQ8+MKiii2pw5iIuMlK4M3Xh9U
         sw2g==
X-Gm-Message-State: AOJu0Ywb5p94PpZop3573MyMqKlbcZ9fY0hQF5ShtT2IrejDeCdYJPVN
	S8JnnIX4TapNnsw/ypdsa/xLPJYKXlXG2TDl8tZc9SOTKQGPIOjoHmz42Lxe4Q==
X-Gm-Gg: Acq92OGuXZMRbua+rrQ80mKqbckrTdA087JtUKID0YbwOJ4pCLIybGV678pyCShv0BI
	6ydGRASuVCguuA2X8Eu/0qwRg2xrlF2ouv3Giizec2EXgM+dcZ67zhbn+AhWXlEg8XYKqhBaexm
	xneV11/65fY1P7+kaezLdK4sm6uef+uqCBznFs2eha8tJles7tEvLOU4gQQHbGK1kT/NLcrjQUL
	fmqhAVvdb/KdvOJznRIZDhyJpdVLeAYSceINCsrk1sHxijGKc9KINRPtTEDlSjCYoxNvWSGtX4t
	8pYEWKwePkWVHgAbzAhLB4MxpIHVhXse4QkvC4t0cQJ4uqZJo1KH9wg+shiJ/zk+2GnMBhLGLcV
	NezgeSPtTRKsq5bFiicaaJI3fEBWH74+wkC65n7XeWSCMLBOiY7b5y6o5TFh8pDTlmGtiKDstkA
	P0eFZSZ6sQ60noeRODVv47HBgrM1ow
X-Received: by 2002:a05:7022:43a8:b0:12c:81b:c74b with SMTP id a92af1059eb24-134c880b9a3mr9446706c88.1.1779207906950;
        Tue, 19 May 2026 09:25:06 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a67csm22897753c88.13.2026.05.19.09.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:25:06 -0700 (PDT)
Message-Id: <05a4b69b9b9b7c9b1ae1351fef32cf6ec8b7fb45.1779207896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
References: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
	<pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 May 2026 16:24:54 +0000
Subject: [PATCH v6 7/8] remote: add remote.*.negotiationInclude config
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

Add a new 'remote.<name>.negotiationInclude' multi-valued config option that
provides default values for --negotiation-include when no
--negotiation-include arguments are specified over the command line.  This
is a mirror of how 'remote.<name>.negotiationRestrict' specifies defaults
for the --negotiation-restrict arguments.

Each value is either an exact ref name or a glob pattern whose tips should
always be sent as 'have' lines during negotiation. The config values are
resolved through the same resolve_negotiation_include() codepath as the CLI
options.

This option is additive with the normal negotiation process: the negotiation
algorithm still runs and advertises its own selected commits, but the refs
matching the config are sent unconditionally on top of those heuristically
selected commits.

Similar to the negotiationRestrict config, an empty value resets the value
list to allow ignoring earlier config values, such as those that might be
set in system or global config.

Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/remote.adoc | 25 ++++++++++++++++
 Documentation/fetch-options.adoc |  4 +++
 builtin/fetch.c                  | 12 ++++++++
 remote.c                         |  5 ++++
 remote.h                         |  1 +
 t/t5510-fetch.sh                 | 49 ++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 4dcf81fbce..1951df154e 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -125,6 +125,31 @@ values are not used.
 Blank values signal to ignore all previous values, allowing a reset of
 the list from broader config scenarios.
 
+remote.<name>.negotiationInclude::
+	When negotiating with this remote during `git fetch`, the client
+	advertises a list of commits that exist locally.  In repos with
+	many references, this list of "haves" can be truncated. Depending
+	on data shape, dropping certain references may be expensive. This
+	multi-valued config option specifies references, commit hashes,
+	or ref pattern globs whose tips should always be sent as "have"
+	commits during fetch negotiation with this remote.
++
+Each value is either an exact ref name (e.g. `refs/heads/release`), a
+commit hash, or a glob pattern (e.g. `refs/heads/release/*`).  The
+pattern syntax is the same as for `--negotiation-include`.
++
+These config values are used as defaults for the `--negotiation-include`
+command-line option.  If `--negotiation-include` is specified on the
+command line, then the config values are not used.
++
+This option is additive with the normal negotiation process: the
+negotiation algorithm still runs and advertises its own selected commits,
+but the refs matching `remote.<name>.negotiationInclude` are sent
+unconditionally on top of those heuristically selected commits.
++
+Blank values signal to ignore all previous values, allowing a reset of
+the list from broader config scenarios.
+
 remote.<name>.followRemoteHEAD::
 	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
 	when fetching using the configured refspecs of a remote.
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 7b897a7202..8074004377 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -91,6 +91,10 @@ The pattern syntax is the same as for `--negotiation-restrict`.
 If `--negotiation-restrict` is used, the have set is first restricted by
 that option and then increased to include the tips specified by
 `--negotiation-include`.
++
+If this option is not specified on the command line, then any
+`remote.<name>.negotiationInclude` config values for the current remote
+are used instead.
 
 `--negotiate-only`::
 	Do not fetch anything from the server, and instead print the
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ba56e9022b..1af6500c1d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1634,6 +1634,18 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 		else
 			warning(_("ignoring %s because the protocol does not support it"),
 				"--negotiation-include");
+	} else if (remote->negotiation_include.nr) {
+		if (transport->smart_options) {
+			add_negotiation_tips(&remote->negotiation_include,
+					     &transport->smart_options->negotiation_include_tips,
+					     "--negotiation-include");
+		} else {
+			struct strbuf config_name = STRBUF_INIT;
+			strbuf_addf(&config_name, "remote.%s.negotiationInclude", remote->name);
+			warning(_("ignoring %s because the protocol does not support it"),
+				config_name.buf);
+			strbuf_release(&config_name);
+		}
 	}
 	return transport;
 }
diff --git a/remote.c b/remote.c
index 620086e16e..6fb5758820 100644
--- a/remote.c
+++ b/remote.c
@@ -153,6 +153,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	refspec_init_fetch(&ret->fetch);
 	string_list_init_dup(&ret->server_options);
 	string_list_init_dup(&ret->negotiation_restrict);
+	string_list_init_dup(&ret->negotiation_include);
 
 	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
 		   remote_state->remotes_alloc);
@@ -181,6 +182,7 @@ static void remote_clear(struct remote *remote)
 	FREE_AND_NULL(remote->http_proxy_authmethod);
 	string_list_clear(&remote->server_options, 0);
 	string_list_clear(&remote->negotiation_restrict, 0);
+	string_list_clear(&remote->negotiation_include, 0);
 }
 
 static void add_merge(struct branch *branch, const char *name)
@@ -567,6 +569,9 @@ static int handle_config(const char *key, const char *value,
 	} else if (!strcmp(subkey, "negotiationrestrict")) {
 		return parse_transport_option(key, value,
 					      &remote->negotiation_restrict);
+	} else if (!strcmp(subkey, "negotiationinclude")) {
+		return parse_transport_option(key, value,
+					      &remote->negotiation_include);
 	} else if (!strcmp(subkey, "followremotehead")) {
 		const char *no_warn_branch;
 		if (!strcmp(value, "never"))
diff --git a/remote.h b/remote.h
index e6ec37c393..d8809b6991 100644
--- a/remote.h
+++ b/remote.h
@@ -118,6 +118,7 @@ struct remote {
 
 	struct string_list server_options;
 	struct string_list negotiation_restrict;
+	struct string_list negotiation_include;
 
 	enum follow_remote_head_settings follow_remote_head;
 	const char *no_warn_branch;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index bc2e2af959..33f61ac12a 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1587,6 +1587,55 @@ test_expect_success '--negotiation-include avoids duplicates with negotiator' '
 	test_line_count = 1 matches
 '
 
+test_expect_success 'remote.<name>.negotiationInclude used as default for --negotiation-include' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	# test the reset of the list on an empty value
+	git -C client config --add remote.origin.negotiationInclude refs/tags/alpha_1 &&
+	git -C client config --add remote.origin.negotiationInclude "" &&
+	git -C client config --add remote.origin.negotiationInclude refs/tags/beta_1 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=beta_2 \
+		origin alpha_s beta_s &&
+
+	ALPHA_1=$(git -C client rev-parse alpha_1) &&
+	test_grep ! "fetch> have $ALPHA_1" trace &&
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace
+'
+
+test_expect_success 'remote.<name>.negotiationInclude works with glob patterns' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	git -C client config --add remote.origin.negotiationInclude "refs/tags/beta_*" &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 \
+		origin alpha_s beta_s &&
+
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace &&
+	BETA_2=$(git -C client rev-parse beta_2) &&
+	test_grep "fetch> have $BETA_2" trace
+'
+
+test_expect_success 'CLI --negotiation-include overrides remote.<name>.negotiationInclude' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	git -C client config --add remote.origin.negotiationInclude refs/tags/beta_2 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 \
+		--negotiation-include=refs/tags/beta_1 \
+		origin alpha_s beta_s &&
+
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace &&
+	BETA_2=$(git -C client rev-parse beta_2) &&
+	test_grep ! "fetch> have $BETA_2" trace
+'
+
 test_expect_success '--negotiation-include avoids duplicates with v0' '
 	test_when_finished rm -f trace &&
 	setup_negotiation_tip server server 0 &&
-- 
gitgitgadget


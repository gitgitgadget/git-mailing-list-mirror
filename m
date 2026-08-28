Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C3F39DBFD
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957532; cv=none; b=tOrhEuNRxOTODszZM1WeXjaz2AUWCPaxlEWtnCMQxa1RwJ3Lj2xfnX+AC6lL7aJS1uZzSLfe58h+1EUAb8bX+mh7QdIb6Trxn9WaMy0Lxdb8VJvJggpGcBlQHkrr3ojT8E/GGeaGO8R13Wp0FLLjWUoW0rdHqEPBug48uEHcp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957532; c=relaxed/simple;
	bh=C/6bvV3xbEAyRhwZCGxK/iIUe9kKzQyRyRyb+cSKwIM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ke02hCI3a1Eb3HYydoP3R6NXSWmZlNqIY95px4/iw/B4RS1sOhyWZUlEi/Gp+Z/QJaNH4ecIK5Z31m6RdRW5guTZzBmKZj0FulvlsdPHii2ad3WGbL3hndquPyxndDwoPMMMkFcvnKh8IoPd1nnxUZNnbFstEPD45C08TulJ0yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pGISQ6Ks; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JsPRXFcd; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pGISQ6Ks";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JsPRXFcd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B16CB1D0006D;
	Fri, 28 Aug 2026 18:52:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 28 Aug 2026 18:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787957529; x=
	1788043929; bh=MYek03ZCs14bk2awhmk73XshEkKZDz1uvK2uSltNs4A=; b=p
	GISQ6KsCEEZ/zWUehTsApCvX7UDcZUqQn/64Bn1R9I6AJiaVlGWKxWtwJtnXAUOp
	S5HZJX5rhxP2JQQFlyeEL4HAn3jiaQu/my0YmDxwR6BXMK//kknH/ty3EV1SZ6Kh
	z8vaKRQwmcG9ThURqPSFENgf9dyL8Gb73FGvyqhnw4UrcRKZFe5wOyEceMb2CmVP
	EkFS5I+M6SWZcMlBO4+IDk7nivL5GxJVTsGc3IH5K06lQX529maI00Hl+3DDMvl2
	Y2a57J1QCxv7tryQL+UMhMGYxIQ65VqaSvXtMP1gQj599mAORAzwvS+fM8PFKdR3
	3z4xziz9qDQsceH6ia+Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787957529; x=1788043929; bh=MYek03ZCs14bk2awhmk73XshEkKZ
	Dz1uvK2uSltNs4A=; b=JsPRXFcd5/krmmWTTQmXAvPsQwIMuNfThl4eE86Om/Sf
	y7vyaXpDxyduifbq+G7gVYJy+l/ZoXSplepfVIKM4zaSG8ax47oMdoDl1wn+SKO0
	wZJvqD/d+RaHUun8zrN0XYzfEZ54LSCYULnvMHKoruSeqALdLRGxPwOIDuRANLIq
	EERhLz4LlB04mFoLbeCPvG5uP6hGM8M2pghCRcu485lZIb8Tb7P7Vnrhu0/U55y2
	ABVJk8M2h3kaYCfW+6T0k02P4P4wcjjwdzsE1DgyeT0IRI/EAgphqNvXzK2DagMV
	TSmeEWTMW6L10XwrEDjeLfdtoESPXkkp+/n3gHzvmg==
X-ME-Sender: <xms:GRGSagE_3PZjZwd65gYwrVq0MOjlhQsLJKOTWKMQ1R45U8DmhUrTWQ>
    <xme:GRGSavVY4cc39pR7kEtjtmsNGfY07ELxWYcXYQNHSuO3XiYGpe9JMWjBccDGcq-8S
    9Vw_KynNDUz2I2ib0HRGrKRbPmiMkg67WDvR8JoIO0M1AdcLde7>
X-ME-Received: <xmr:GRGSanz0Az3rsvkqkGJV99z7Eje699AgIXamqOsZTGjF_fGzkJj5A5ORA5PFupqgKQ_7XcpUuSIf269PrLnkevv2t952exxYAg>
X-ME-Proxy-Cause: dmFkZTEC+LQSNrvb6E/M1Xll0EuUaS4YcEOHyU7TsRVWIW+NQMTY7E+vmioirGGvNQl4jA
    owPQNp1nmr/zh39kFmIJE1YssyS0h8se6+MSIHYg6w7oxBCDO5CM/zG42gSevsm1iQzpgo
    4xpJ7l6Fpl3IhZBppALJCr4SbUF+BpDWO283+tGMT/7Jk9fYxTp7Ad7msHZobwxjUK9V8P
    X/1o2zSHVxUEa4rJhJWoHrEaGWceEuk1qoqamZqqTrNQ7Xy/RtJRNu52YDg4SN2hm8kq9+
    05QB1LTaUCwEyOSc88uKmq1PzT8WLFQlzwa/MAXdoybCaJZFy8AHh7zk8SRV9lPgZOqfoN
    qjCTNRtZSf+QyHvqwUT54tT1AbPfR2TK/T+GX6fRBJ9hmcML/QdIJUIwOVphW6l3WyiWvF
    n13Wqt9io8fPztXqNgRSbUK1T6dZVYkGEXvMfhZQWNsDgA4w5rxX6JoEEs7KnEU17aJa+B
    UulX0k7LajUXUt7bzR88rhwYQSK/4WaaYWIVz5yusFeGRQLtZEjiVKYPipLHPQrYme/w0F
    7lt1yNAXH2fWQplh9DFfCKIgv5c8+Y1kMKhQOYdZIRvI9B0xaT+ma6tJTi+NJcaUdu3B+L
    15acRsDeMt6OsESrWZUcYMV5gAoo+C4HGOzM44GkaJ2PAnhITBV58DRqDgVQ
X-ME-Proxy: <xmx:GRGSatPJgJpfHTuV8EFRdb6CArvUPj2gEH0EjpQYFuYLnyTUcjasww>
    <xmx:GRGSao7-c3DyeYj3GVfyNXoZmOsAANDqhpbIkNIjF_i2LYGyDnJkgg>
    <xmx:GRGSauPhloRa94W17aB3a59CoApWoNo9QZBXZxSzKVmgZTmb39AXZg>
    <xmx:GRGSamnSCPYqTYImR8uhGPECFDKwhXk3zW8JhmcqaXpm8qzhzAZ1_Q>
    <xmx:GRGSarfhKV6RqU1eVU9U2wlgIYAKFG6ofzMKQA8fcng-wYqBQI6A8UFx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 18:52:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/8] checkout: pass cb_option explicitly to branch name parsers
Date: Fri, 28 Aug 2026 15:51:59 -0700
Message-ID: <20260828225206.310500-2-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260828225206.310500-1-gitster@pobox.com>
References: <xmqqh5kd3lm3.fsf@gitster.g>
 <20260828225206.310500-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file-scope static variable 'cb_option' is used to record whether
a new branch is being created via '-b' (in 'git checkout') or '-c'
(in 'git switch'), primarily for error reporting and advice messages
in parse_remote_branch().

Global mutable state makes the code harder to reason about and refactor.

Pass 'cb_option' explicitly as a parameter to parse_remote_branch()
and parse_branchname_arg(), removing the file-scope static variable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 55e3a89a85..774e4fd5b3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1346,7 +1346,7 @@ enum checkout_command {
 static char *parse_remote_branch(const char *arg,
 				 struct object_id *rev,
 				 int could_be_checkout_paths,
-				 enum checkout_command which_command)
+				 char cb_option)
 {
 	int num_matches = 0;
 	char *remote = unique_tracking_name(arg, rev, &num_matches);
@@ -1361,16 +1361,15 @@ static char *parse_remote_branch(const char *arg,
 	    if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
 		    const char *cmdname;
 
-		    switch (which_command) {
-		    case CHECKOUT_CHECKOUT:
+		    switch (cb_option) {
+		    case 'b':
 			    cmdname = "checkout";
 			    break;
-		    case CHECKOUT_SWITCH:
+		    case 'c':
 			    cmdname = "switch";
 			    break;
 		    default:
-			    BUG("command <%d> should not reach parse_remote_branch",
-				which_command);
+			    BUG("unexpected cb_option '%c'", cb_option);
 			    break;
 		    }
 
@@ -1394,7 +1393,7 @@ static char *parse_remote_branch(const char *arg,
 
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
-				enum checkout_command which_command,
+				char cb_option,
 				struct branch_info *new_branch_info,
 				struct checkout_opts *opts,
 				struct object_id *rev)
@@ -1505,7 +1504,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		if (recover_with_dwim) {
 			remote = parse_remote_branch(arg, rev,
 						     could_be_checkout_paths,
-						     which_command);
+						     cb_option);
 			if (remote) {
 				*new_branch = arg;
 				arg = remote;
@@ -1832,9 +1831,6 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 	return newopts;
 }
 
-/* create-branch option (either b or c) */
-static char cb_option = 'b';
-
 static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct checkout_opts *opts, struct option *options,
 			 enum checkout_command which_command)
@@ -1842,6 +1838,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	int parseopt_flags = 0;
 	struct branch_info new_branch_info = { 0 };
 	int ret;
+	char cb_option = (which_command == CHECKOUT_SWITCH) ? 'c' : 'b';
 
 	static const char * const checkout_usage[] = {
 		N_("git checkout [<options>] <branch>"),
@@ -1997,7 +1994,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->dwim_new_local_branch &&
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
-		int n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
+		int n = parse_branchname_arg(argc, argv, dwim_ok, cb_option,
 					     &new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
@@ -2174,8 +2171,6 @@ int cmd_switch(int argc,
 	options = add_common_options(&opts, options);
 	options = add_common_switch_branch_options(&opts, options);
 
-	cb_option = 'c';
-
 	return checkout_main(argc, argv, prefix, &opts, options,
 			     CHECKOUT_SWITCH);
 }
-- 
2.55.0-884-g76cf8659c2


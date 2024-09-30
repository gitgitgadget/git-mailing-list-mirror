Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918E818872C
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687667; cv=none; b=b/6LZcLWM8JaJb8Dg58NCSXzp+paMqMEtkJqZ4Jb2it9jg3x1fy2G/60en6AWyMn1sl9tWWTiZOCnZKtD69AxAhQN4gFRM4zrsu1jjuMckm+g0ecaycatGOtoCzkrrQCDl41E3ROd0gHnkQ9OAvGFGNq76G9mM6ec6XSyRVwAWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687667; c=relaxed/simple;
	bh=eaZqn79u/7oYCeX+s7XpSBmad/TjzIy3m5fJZj2lNX8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKCLpsWZpNmQM2Ke+RM6gWcg4h0KsxkmvyLD1JpBHoFxB8t7IPv/n6HFPjBM/GZ/uAXvg4rCVlZ/P/WroyM0rnnJNTnkepYDDpTdqWehz2uy0BkWh/wNW37q4u6hquWOInNzc3znGrj94GiZIkJhOpR0ivaFDWxLrhRYBOqwVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pC/HpZLu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eCJm60QK; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pC/HpZLu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCJm60QK"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F06D011401C0
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 30 Sep 2024 05:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687664; x=1727774064; bh=xTy/xewVGj
	5N+/EcHcerJV1MlB9lb7Ibq+YDiiPvIfw=; b=pC/HpZLuJaPtK0O+Tg9qKjbszv
	bxcVgCsSsGdr8gTUziYOLg0UUh4qiTbLmzIlHGWSNyP4IoonIYGW07MNInmWHacs
	/2u7kXhPUmsz2CJaCCXaoDLaKoJpoMKyD4W7hwt6WoJYvRIBu8e+wY7fDD9++9po
	b6ByLp9evfRnl+Ki5YY/qDc4Lff+ryVh7wkiQq/Umzma99IZRcombJfqHzNBMPES
	JuiH85yRciZ3h93SR8zqLoyfiI6MjhO0auNLS2sWlqi0TX4F0tXDx/7XqN1OeNbp
	d2ZS4EXZNKqMrXmEH9TtcqAh7moyY368wjrMosMD1SAS2y3KW7TmZRK8hzCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687664; x=1727774064; bh=xTy/xewVGj5N+/EcHcerJV1MlB9l
	b7Ibq+YDiiPvIfw=; b=eCJm60QKVFvFWLHcODWqhV5ijIh0zUP1oHMrRGNW7bp3
	dk1fhTuCjqsP5LOtzq3RDNMC9jhOwR0LnekMZo+YtY4ReEbYBkkkZBdkHWCf9UBs
	Wle7FkI3GFlwCV9LaAHTwuVRG/AVs/lcETXxaB+2YnOR0JOL1jt4HSaonAMwZcjz
	FQ4z6bxyokFouZaMA0N8itJCq68escR56Hi2nXfYDBHxB/oGeG+HTYFAEuWi/mru
	xSakqe9u3wPMyAZy9mtcumSXauNP76yqHNVcbQoZ4dst1/a6RbUzPNb/sXJlMIHd
	OKzL7ISwmH8aOOJIBQSb04mq9wMcD3CZ7KucbJQ3cg==
X-ME-Sender: <xms:8Gv6Zkgm8dysMsYqDV_k1lKRBGU2EYL_wyBnSHFBVp_ZeFdSZ_z9rg>
    <xme:8Gv6ZtAYaL3X73qHDh0_X6DsZi2MQ0YydFHAUDsWsaYt7GZlarE2SB37OdC3Q__sE
    1AN3ioUGl5JPPEBtg>
X-ME-Received: <xmr:8Gv6ZsHIvWKQmmLJPP3Pk2lb6Aoowvypm6tqaGAaWXy36P3058UJBXdJ6GsmsetnsxHb4aMQ3zia8YhzdMGxuMQ-GepPXn3ZNyl9zW-9FEjfnWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8Gv6ZlRM-0EdGLubwVBehVQ5zVVv0CLHrHOPTwHwx-8zHLFVENFj3w>
    <xmx:8Gv6Zhy8RlCxgvae4OTpSDLaQ5U-s7uDEE77_aowa8ImW6fZPJuTSg>
    <xmx:8Gv6Zj7c1e23pHepLjAi2PbE7KCl4zBqOb95Cdq_489NK9wv0hU7wQ>
    <xmx:8Gv6ZuwLtKe6JyqzyWgBD-b4mLTBkBQBNliBRpLZIXhzlKPI11FGJg>
    <xmx:8Gv6ZioOSOUUMm7e0X-1Md-csLbE-UYd3eIqSp_UygeMi3qhKbMjRwxc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9a28d7c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:13:38 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:14:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 22/23] remote: fix leaking push reports
Message-ID: <e94ee74ebdf0ed0fb096254982da2dd5e9500b5f.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

The push reports that report failures to the user when pushing a
reference leak in several places. Plug these leaks by introducing a new
function `ref_push_report_free()` that frees the list of reports and
call it as required. While at it, fix a trivially leaking error string
in the vicinity.

These leaks get hit in t5411, but plugging them does not make the whole
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/receive-pack.c |  5 ++++-
 remote.c               | 15 +++++++++++++++
 remote.h               |  4 +++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 536d22761d..ab5b20e39c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -374,6 +374,7 @@ static void write_head_info(void)
 struct command {
 	struct command *next;
 	const char *error_string;
+	char *error_string_owned;
 	struct ref_push_report *report;
 	unsigned int skip_update:1,
 		     did_not_exist:1,
@@ -1083,7 +1084,7 @@ static int read_proc_receive_report(struct packet_reader *reader,
 		hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
 		if (!strcmp(head, "ng")) {
 			if (p)
-				hint->error_string = xstrdup(p);
+				hint->error_string = hint->error_string_owned = xstrdup(p);
 			else
 				hint->error_string = "failed";
 			code = -1;
@@ -2054,6 +2055,8 @@ static void free_commands(struct command *commands)
 	while (commands) {
 		struct command *next = commands->next;
 
+		ref_push_report_free(commands->report);
+		free(commands->error_string_owned);
 		free(commands);
 		commands = next;
 	}
diff --git a/remote.c b/remote.c
index e291e8ff5c..cd2091ac0c 100644
--- a/remote.c
+++ b/remote.c
@@ -868,6 +868,20 @@ struct strvec *push_url_of_remote(struct remote *remote)
 	return remote->pushurl.nr ? &remote->pushurl : &remote->url;
 }
 
+void ref_push_report_free(struct ref_push_report *report)
+{
+	while (report) {
+		struct ref_push_report *next = report->next;
+
+		free(report->ref_name);
+		free(report->old_oid);
+		free(report->new_oid);
+		free(report);
+
+		report = next;
+	}
+}
+
 static int match_name_with_pattern(const char *key, const char *name,
 				   const char *value, char **result)
 {
@@ -1122,6 +1136,7 @@ void free_one_ref(struct ref *ref)
 	if (!ref)
 		return;
 	free_one_ref(ref->peer_ref);
+	ref_push_report_free(ref->report);
 	free(ref->remote_status);
 	free(ref->tracking_ref);
 	free(ref->symref);
diff --git a/remote.h b/remote.h
index ad4513f639..c5e79eb40e 100644
--- a/remote.h
+++ b/remote.h
@@ -126,13 +126,15 @@ int remote_has_url(struct remote *remote, const char *url);
 struct strvec *push_url_of_remote(struct remote *remote);
 
 struct ref_push_report {
-	const char *ref_name;
+	char *ref_name;
 	struct object_id *old_oid;
 	struct object_id *new_oid;
 	unsigned int forced_update:1;
 	struct ref_push_report *next;
 };
 
+void ref_push_report_free(struct ref_push_report *);
+
 struct ref {
 	struct ref *next;
 	struct object_id old_oid;
-- 
2.46.2.852.g229c0bf0e5.dirty


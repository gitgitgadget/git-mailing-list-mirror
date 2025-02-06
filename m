Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FEB225A4E
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828697; cv=none; b=IYSpOZu9K/FlBbq/uFw8jAsTErkxuE3iTIsQQh5txMIPqb8AD2FcsYGNHiSg8CMjdTsngeP0z0+yXHDksexCoGXxmr9hY2R4w4K0mEWfX8AUCzyeiqQRFmlptdR/xl2qyCjHNXHz+Ff57v+dtL6s9eGJG5h8aJqJm0EBHHeKNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828697; c=relaxed/simple;
	bh=nF88Nu/wR9maTgZCRBwwmNSSZ1LrWt+0L+iGldetw84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LK9nh2EJaz4U9AU1cvL4VQBJIG1BNHMBaI/jctYSER52K/g74CLJo51jKVW/rvGCeBlp8Hccz0V6TBDc3LBQfTpw284bnQaOQNi/VQwEpneGRt2jjphtISrchO5eA0DjOYpr4Wu5F16sE3zHqOKCyeTqbWeNrOf4t4GQ/rZ/ntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sBdbIRFV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B1wZSGyp; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sBdbIRFV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B1wZSGyp"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE13D11401B6
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:58:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 06 Feb 2025 02:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828695;
	 x=1738915095; bh=AGD/73TEmuDe7vl0Shjgp6rtxAt+A6hOvzPVJoTdxis=; b=
	sBdbIRFVkQmbchBx2U1XGVNCIHv595KDcNNzUIW8WGF1ExkGQNtwR+OzcesdujBZ
	ClZqpbT2SVLQx7sdjLdmYiiTnaGWQus1FvfgF999NYvQvi2FP8M/LdeTvwiNIaT/
	I/n8saq8S63tNSVcObawYVJxmJGqUoUv33QQwAe0LSoBkur5uDeLJWUOoaDoU688
	cToj8YoDTbBD/XLpZLE9N3ziw3jmIQd/R0IA3hgSzxbUD4ly+gmGRXcPWGSsj/pZ
	zS4q0TlgPk8QjyGbex7tihACreZxiK8/IyxeoPkuaRwRUbUdN0ORK8t35dsRJXT5
	YoM49J3r825HQh2kmVhing==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828695; x=
	1738915095; bh=AGD/73TEmuDe7vl0Shjgp6rtxAt+A6hOvzPVJoTdxis=; b=B
	1wZSGyp44FG8DDan5adrvAd7xO2eYw0Gsvtnu5vu/4Te4zunCRrYw1XeDT5cuPxd
	x+VaiCQmFwRceHoyd4xIlq5FSZU8wlKTxcbxFjw81/yctqKS22NCqEL9mEqzw1PN
	ZY13JnLXLndqvyPGyfbaFoY/KUeY/Y1EFC63lK8CuHWJayHPp9BXczqfIin1hwxc
	WdvwEOVVkK6Q9ITMvZlqiu8Tfx4/H7lTN5FHV1CxP6NawP6ZPT4a8sQBtsLeRjVO
	eAB4T/WiB0VjbgGy3YWeqE3nzEhOqktCaSUKCarVUZP5onuJNuXUJdOtJmisxYYw
	rIqSgaf8TTAqTe0tCpQsA==
X-ME-Sender: <xms:l2ukZwmzKi7PryPuz6NdtoKXw8ysRCeJIlBJe96706bIuKkJ_NjTIw>
    <xme:l2ukZ_1sSicgO8AHhJybUKF79zo8A8cZ2-nRKAkXoIobxF2kn-_B0DQYrrX_Uge5v
    cCXbxt37SWET7kaDg>
X-ME-Received: <xmr:l2ukZ-oNOG_64cW4GDzSxv6nE9Siug4c8m8Ef8vmADRnxsVmBf2oEQiw6Ugz84YImNgEZw1SL3tJ8rdj0m6eWY196kEPsdkDQV5aZfMB92P0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:l2ukZ8mU-bsnUMffDsPoQKRtS0YwlC8cFAfAY4LrGxq0KPZaTLsYDA>
    <xmx:l2ukZ-2zgPjg3A-RhK7lmZxWYtVjwmXygW-g77LRmK0U-PPfe_P-bw>
    <xmx:l2ukZzsm1lWBBuehkLJMh2ZEGABeCR30fdw-6jDkW-j0G-ibfPUgVQ>
    <xmx:l2ukZ6XaiM20pZScaD0olar5LhaJ0sYterZ-VhM64IChk-1v1rioxQ>
    <xmx:l2ukZz8Q-bGutaAKouUMXsbKQTl8gYjJ5X-Kz1TAYpAhp5qVcyqAdF2M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Feb 2025 02:58:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a01b55ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Feb 2025 07:58:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:58:09 +0100
Subject: [PATCH 13/16] repo-settings: introduce function to clear struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-b4-pks-path-drop-the-repository-v1-13-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We don't provide a way to clear a `struct repo_settings`, and instead
open-code this in `repo_clear()`. This is mixing up concerns and means
that developers have to touch multiple files whenever they add a new
field to the structure in case the associated resources need to be
released.

Provide a new `repo_settings_clear()` function to improve this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repo-settings.c | 10 ++++++++--
 repo-settings.h |  1 +
 repository.c    |  2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/repo-settings.c b/repo-settings.c
index 9d16d5399e..719cd7c85c 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -21,7 +21,6 @@ static void repo_cfg_int(struct repository *r, const char *key, int *dest,
 
 void prepare_repo_settings(struct repository *r)
 {
-	const struct repo_settings defaults = REPO_SETTINGS_INIT;
 	int experimental;
 	int value;
 	const char *strval;
@@ -35,7 +34,7 @@ void prepare_repo_settings(struct repository *r)
 	if (r->settings.initialized)
 		return;
 
-	memcpy(&r->settings, &defaults, sizeof(defaults));
+	repo_settings_clear(r);
 	r->settings.initialized++;
 
 	/* Booleans config or default, cascades to other settings */
@@ -143,6 +142,13 @@ void prepare_repo_settings(struct repository *r)
 		r->settings.packed_git_limit = ulongval;
 }
 
+void repo_settings_clear(struct repository *r)
+{
+	struct repo_settings empty = REPO_SETTINGS_INIT;
+	FREE_AND_NULL(r->settings.fsmonitor);
+	r->settings = empty;
+}
+
 enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo)
 {
 	const char *value;
diff --git a/repo-settings.h b/repo-settings.h
index 93ea0c3274..c4f7e3bd8a 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -73,6 +73,7 @@ struct repo_settings {
 }
 
 void prepare_repo_settings(struct repository *r);
+void repo_settings_clear(struct repository *r);
 
 /* Read the value for "core.logAllRefUpdates". */
 enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo);
diff --git a/repository.c b/repository.c
index 648cd88474..6cbaf2e3da 100644
--- a/repository.c
+++ b/repository.c
@@ -380,7 +380,7 @@ void repo_clear(struct repository *repo)
 	parsed_object_pool_clear(repo->parsed_objects);
 	FREE_AND_NULL(repo->parsed_objects);
 
-	FREE_AND_NULL(repo->settings.fsmonitor);
+	repo_settings_clear(repo);
 
 	if (repo->config) {
 		git_configset_clear(repo->config);

-- 
2.48.1.538.gc4cfc42d60.dirty


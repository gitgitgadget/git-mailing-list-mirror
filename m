Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF46175A9F
	for <git@vger.kernel.org>; Wed, 27 May 2026 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890433; cv=none; b=Z4XndWDp9Bv3d+VVJtuiozY4REwEtCwsvFF7+Tn5WCBjibBfaxiOU5ToBxf9qabvpCi4DrW4orhi65FA0Yh+iwSJe4lRBjXxYuGku+v/Oi+v9xpzM+OmvbjDqceQDHs5BW8HnidyWgq2sCXxWDWNbsJ68oa0feqVuN23xQIYEuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890433; c=relaxed/simple;
	bh=FFMdo/vF/M3lr67juTTrY9EeqHai64APKroqVgTVIvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyxpZuL46L+C7qwdYbwE1VhrE4KFv378p10y/BN/M+HS5GgWlbMzaV/viXbV1o8P+e2VgKpi/FDoSk16RaxASRzaPqvCnaIxM2JMI2M9om8/E2UyicebjMWUcTu8Us4wpqK1dvXxvttq+ERHcJI7A/7YFBpWNsaqcdo6OGMtIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=L0XRhDiF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v8QYSRQ3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="L0XRhDiF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v8QYSRQ3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F15A9140016D;
	Wed, 27 May 2026 10:00:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 27 May 2026 10:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779890430;
	 x=1779976830; bh=a8N+d/rtAEDDB65OwtX4cKq+kUtLyqF/SGacH40nVJg=; b=
	L0XRhDiFcAW26jRJjuwGsy/szpVK96DaNY1It2sROUtG1oP8Y7rc+bkIdxU8AcGj
	eIsGGigkFtA1rHLUkVkrefDtTcIRHKCXFMEhKCA41VHK9SFx9uXtNuE9xiO5D8w/
	ZvtZQ34bosSgWS8VGPOoLYzARm2vdwV7TqzcG6kMcRC4ewJPlc2o0n4W/hGqzPm5
	w1j9rUChstmRs1KXr5Hnh2T8PFhm1tSjENuMqflZ1ZGPaIl/Vms4Cd9yDNBHwKu3
	eAapVQMVCaeb8/eae8D/lVndgzuUZHJQfByotvq+74BeCcGz3di0FPeuhoz0KA1o
	YYAvLc0FdMK4OceLxoTykw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779890430; x=
	1779976830; bh=a8N+d/rtAEDDB65OwtX4cKq+kUtLyqF/SGacH40nVJg=; b=v
	8QYSRQ3oFqgkTYFheiePdYcIMZCeA2Wr+MXI5iJNDSog7odd9D/Tr7DaK8XsajbQ
	pYwjGpAyF1bo1nRdP8hd+BsuuzDAoHTaNA+PkqBMOS/K4JTo9SZ90nidS1vg8QGT
	HfeF4KTVrbkHTIYGlYzb9G9bpzqzgAY3LOd9/mOJUDqkHfEhKXRZkW7O8SZjckUj
	t43VyWng44qvPjuLqrP0BUjOsEVrk8NWS9nIJj0z1pSMHA8zl0XoAmIuVfg0i9+l
	h6BGGTgjnDnQrYCB3y/0y8nMFUI5tPV3iPbtAdVf9JvnUVujrYJvh29XlokZ2ORC
	tj7xPtbCrAix9/NYV+m+A==
X-ME-Sender: <xms:_vgWarPOH24Jz5jbbE3Zcc_D9xYjOxNHXQAz_xZ3OAicApovx40o6Do>
    <xme:_vgWatbLFfAejkjAUX_rsRNwbj8GyrrXwX2uoco-1phQ9Z4TS0yL-zQTsVe27CZYX
    JZN6J7mJzSKgY47VLs7aDQPi-qyVhp2mMWXdcW5ssi_Yh-bgEjyDA>
X-ME-Received: <xmr:_vgWanoWMIA1a3DHlXULR54dj8d4HsO-8M4z3UBHR_aOtm5bo7LDCXPOeGawIZ51y-g0IKvrjPJc_jjg2HanOT500UjVIuq6F2gUI3A>
X-ME-Proxy-Cause: dmFkZTGG2hpARLeqnRSHOIc+SFB5kVpJ+N3zRoTnNFgYt5uPAI182xgK+W6SP7PZlvTPO8
    7yKAbnl4ucHwBCBs3ayhyIQgpspj3oxyVEC5ngscETt4wkBsXW27loxD+Ruwn534YAZLF+
    W5GapvBB7ri/AmWqURclKomLDAEvV3Fz2z0As/rO5ITHksAml7YOQ9Xqr7dbCv6tK4hkg9
    jtozJo4w3ckAi3ltKO5rzTU/WANX0/GShkyFrmYMxl3ql0Fmj3EaP79uCdjjIxYoOjlg+3
    wmO8TEck2uqt1mOJrqf72vi5i4CRoRPt+bOHwYqhIM3vgq8uBNXRpuqgtL+nufMS9oQKXa
    Gr9ejCouL/mwdNK+TZAWS0vKrUdRCP6j/0/P8aISZHezQvHw0Oek4rXNF6Q83f1Tmu5dSn
    LdKZgYmCFD9FgNNM3akbiHc0mZcg+BhwFh6t/8B64oyoCfagU3LCqwlWJOwPZiaei03QSw
    oX09OLKzQthtW41UPNWssqHJUZ8H1QjlexA/Uc2keZtWAYDWOTp66bi9gV00mvH/0Zp74d
    JGsqwvdAfLqbdYKiU1dRJ4GWYafgCkCnc62S3QBP5GDsXfC9GOeSz0PpB6AlHY9X3SYLbZ
    ZaQCcxqscmCUs9CpCERIRB8EEAAN73cNwlq9rAxQ/Ew6nmkYMNTikSm7KmPQ
X-ME-Proxy: <xmx:_vgWapax7TVAY-vrifXLbarictmhkCTJuhopISs3GiS3WUyHWlu3iQ>
    <xmx:_vgWanTcarimCHYzDM326lOA_MDIOgfZnkjJzjZChUYSF0nKUW392A>
    <xmx:_vgWao6WEWXjrBc_-ABLVtu_y5REon0g-aw_UJUxUBB5cockVRm5Iw>
    <xmx:_vgWaky4ezISe5a1MM7dzAxf11IxAEw0doPk8iIOHmOsq-yN7U8r5Q>
    <xmx:_vgWatjcQeQVFiIx22jvQb6ISlQKh9Ys0zSFxB9a_1U0O8GJEDf7LKZv>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 10:00:29 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/2] *: replace deprecated free_commit_list
Date: Wed, 27 May 2026 15:59:25 +0200
Message-ID: <commit.h_replace_deprecated.715@msgid.xyz>
X-Mailer: git-send-email 2.54.0.6.gf6fa7dd4140
In-Reply-To: <CV_commit.h_remove_deprecated.714@msgid.xyz>
References: <CV_commit.h_remove_deprecated.714@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Replace `free_commit_list` with `commit_list_free`. The former was
deprecated in 9f18d089 (commit: rename `free_commit_list()` to conform
to coding guidelines, 2026-01-15).

This allows us to remove all the deprecated functions in the
next commit:

• `copy_commit_list`
• `reverse_commit_list`
• `free_commit_list`

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/history.c | 4 ++--
 replay.c          | 2 +-
 upload-pack.c     | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 0fc06fb2045..091465a59e2 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -284,7 +284,7 @@ static int setup_revwalk(struct repository *repo,
 
 		commit_list_insert(original, &from_list);
 		ret = repo_is_descendant_of(repo, head, from_list);
-		free_commit_list(from_list);
+		commit_list_free(from_list);
 
 		if (ret < 0) {
 			ret = error(_("cannot determine descendance"));
@@ -892,7 +892,7 @@ static int split_commit(struct repository *repo,
 	if (index_file.len)
 		unlink(index_file.buf);
 	strbuf_release(&index_file);
-	free_commit_list(parents);
+	commit_list_free(parents);
 	release_index(&index);
 	return ret;
 }
diff --git a/replay.c b/replay.c
index 4ef8abb6077..da531d5bc68 100644
--- a/replay.c
+++ b/replay.c
@@ -120,7 +120,7 @@ static struct commit *create_commit(struct repository *repo,
 out:
 	repo_unuse_commit_buffer(repo, based_on, message);
 	free_commit_extra_headers(extra);
-	free_commit_list(parents);
+	commit_list_free(parents);
 	strbuf_release(&msg);
 	free(author);
 	return (struct commit *)obj;
diff --git a/upload-pack.c b/upload-pack.c
index 9f6d6fe48c8..2bf450ab288 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -886,7 +886,7 @@ static void deepen(struct upload_pack_data *data, int depth)
 					     data->deepen_relative, depth,
 					     SHALLOW, NOT_SHALLOW);
 		send_shallow(data, result);
-		free_commit_list(result);
+		commit_list_free(result);
 	}
 
 	send_unshallow(data);
@@ -900,7 +900,7 @@ static void deepen_by_rev_list(struct upload_pack_data *data,
 	disable_commit_graph(the_repository);
 	result = get_shallow_commits_by_rev_list(argv, SHALLOW, NOT_SHALLOW);
 	send_shallow(data, result);
-	free_commit_list(result);
+	commit_list_free(result);
 	send_unshallow(data);
 }
 
-- 
2.54.0.6.gf6fa7dd4140


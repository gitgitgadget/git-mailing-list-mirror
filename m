Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377D19ABD1
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321547; cv=none; b=ux8hzare/3JfLR2j7i/rFxq0tQtQ51K3nIW2fqLPceZ3mtMSaQVUs4X/PMYO7rZSianZlmBD1ZHnA3YsKKANO+/Y+MHEwRB4XDWN0/+YiNakPSPpzVopFPCn3gEWpImo0Cl/+N8049iVeMbs5HC1RLDekgQdNvdhCrailDYz/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321547; c=relaxed/simple;
	bh=rEl8Tyv49FyqfT9rK0zRE8Z+F5YrLLOKcz901BkzCLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjIWH8a5cyppA9n+cqj3K7jn25DBJAS2bwuVkruaoR5+F8Hi0piGWLIEkvDTh2jtS6OC6mcpaJx8kP7k9wTMit91tEu+t7pF5oy1vjLp/3EJL8OgdbbvnNJY2xbW3SR/t/KLCyVLozMGdH0prF6Ljk6UGsF3zlFMVXcPP8iNnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AvduTeZ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b7ur9su+; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AvduTeZ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b7ur9su+"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BDE081140156;
	Mon, 11 Nov 2024 05:39:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 11 Nov 2024 05:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321545;
	 x=1731407945; bh=MkzSyxy074g46aZ3KCal8VY9vo9wsfhFc6cziDpD6XY=; b=
	AvduTeZ/9biwgDf3MC6kBMCzPDsusrwtiFJUeEqpIaapMcC2vh5y+ss6tnj6Utnm
	EZuTdZgYhPGpeBQ4EKULwTpLC9/xfVJ6HHpAW2JQKy3xV3RAT6e3TQBNdiW85ODd
	fKmJhynmMaeh+gfcbI0tIocrqYQHTOGNEA9iYHdp2LxWGPoAqldDy1EPTleON7w1
	uTr9YQs6/wMUT7hJZBLWzT4qh3mWlMu3X1prcRG8hJb3RxaXyP5BYkqCOvHz6YyF
	NkOglPb+qBS+knKYW181RByTTx/VAaaoXYs+2ROqYBggNDz6QRbEeKOzYGyL6ajn
	Wxe1jQtq25rbTcsie2xMWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321545; x=
	1731407945; bh=MkzSyxy074g46aZ3KCal8VY9vo9wsfhFc6cziDpD6XY=; b=b
	7ur9su+yak+FhDhRYlOdUfM1Hh87zucUazIVFsAUF9cZtTojki1vtOVvAc1oBDw5
	h8o+WALuwKFSWJ0F/V6/f/USR/md02bvK+Tc8jN/Gv0qxUyttuDKwPb/Hg6o0mly
	/xk+4bPIfdcJBlfqFVwMiJYLpSW3fVb67VtKuFzwWn8VSZRxVGoQNSyGyISU7pg+
	KvncLZo/bqkEjulYB5ffInknWwuLFbG6ndZxN8d1R+s8+9puVKDmFs8QNDf8c8fP
	B6CPSXj+nAlE5MLSmhvd0dg30ovMNg8F/r0JaF4ycn0ZWQ1JhPvk8IWV9NvIvFcz
	P8FZx7iv7bfU6bFYNRY5w==
X-ME-Sender: <xms:yd4xZ2eTBSGUm0nEWLSfeodf1Viqfb6OIzPtffDJhy4kKK4J3-riUg>
    <xme:yd4xZwNpuI7hDcAho0Zh749p55jhsuJqVpPoyeFwbWNjg6ueeOAXhU72bO0IXUlAP
    z_QvLnM6TuIdP7bFg>
X-ME-Received: <xmr:yd4xZ3jAAdM2nxKy6Oeq5_bjWVL-lZ6kajb8S5tGIB-8mSLF-4HrgcPvKXCjUBr8w8FUGCns0FSD0K5XNTKcRxjRqq0JvzvzYf0dkmPhMgcdeY4z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yd4xZz8vLi6N1lfN9eiDHYZKuxb5nArB-4fKHONwBtOVivDcjldrQA>
    <xmx:yd4xZyt8dJRgpDae3Ci3Rde1-huyNatmySR0lTkSUx-ZFtMdgjVz5w>
    <xmx:yd4xZ6Ecsh_py-0E_2aragJ4q2Fm3MZ9WwHTD27gLjg8DzvPnTOhEA>
    <xmx:yd4xZxNomPnh1AWag4Qh0DHYluTDJdpcwn4AQBTrirPR6nwQSv_0WQ>
    <xmx:yd4xZ77DJOCTFw_e95HaNnUVR2XzmC4KN2HmXrhrTiWUU1g1UGBnHQol>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:39:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f6a216ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:50 +0100
Subject: [PATCH v2 21/27] global: drop `UNLEAK()` annotation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-21-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

There are two users of `UNLEAK()` left in our codebase:

  - In "builtin/clone.c", annotating the `repo` variable. That leak has
    already been fixed though as you can see in the context, where we do
    know to free `repo_to_free`.

  - In "builtin/diff.c", to unleak entries of the `blob[]` array. That
    leak has also been fixed, because the entries we assign to that
    array come from `rev.pending.objects`, and we do eventually release
    `rev`.

This neatly demonstrates one of the issues with `UNLEAK()`: it is quite
easy for the annotation to become stale. A second issue is that its
whole intent is to paper over leaks. And while that has been a necessary
evil in the past, because Git was leaking left and right, it isn't
really much of an issue nowadays where our test suite has no known leaks
anymore.

Remove the last two users of this macro.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 1 -
 builtin/diff.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 59fcb317a68a77eee3ca96a60720c556e044c369..e851b1475d7be8f0af78c27d4ef15467a2769a74 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1586,7 +1586,6 @@ int cmd_clone(int argc,
 	free(dir);
 	free(path);
 	free(repo_to_free);
-	UNLEAK(repo);
 	junk_mode = JUNK_LEAVE_ALL;
 
 	transport_ls_refs_options_release(&transport_ls_refs_options);
diff --git a/builtin/diff.c b/builtin/diff.c
index dca52d4221ed19d27950bee9022ae7efb1d2f17a..2fe92f373e9991489fcaeeba381bbfe017a5316a 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -628,6 +628,5 @@ int cmd_diff(int argc,
 	release_revisions(&rev);
 	object_array_clear(&ent);
 	symdiff_release(&sdiff);
-	UNLEAK(blob);
 	return result;
 }

-- 
2.47.0.229.g8f8d6eee53.dirty


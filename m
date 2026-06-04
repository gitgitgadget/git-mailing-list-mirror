Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4309D3DE458
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559217; cv=none; b=tJG2bRnOG/4T1rvTGGnZpqfaqKnDsCd/dMoz05lLCrG7S30ebeu4w4XaB3nZGwUWEDoxX0iZdIpj12ifKXgX6zemNhLP8DyVGrTOIaeVLmHcQOuRfavjECdzy83yUUsF96O9Ru6jIFOTFq2giZzgAQAY45hptCQagIZ97G/vUYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559217; c=relaxed/simple;
	bh=f35v03/92w0hizgiYfYWm59vNaIpbDYlcRVd5KjyrSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gv9bVHxuPlRuUr43tqAPaalRvsg8Jw8aYFbEw0uj2GpOx7YbNGXHdEzkcqAB1Ij0A7QTAUo4BMKSSQQx6KOVnqrSdL7v7yMwRBdb4/mnzQyEJwQbCvCBwIJIOHQjNw3KLEUIhIeYUf9RJ8YzOmqYTQ83ByhhiIGTQXr+wsTxLqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rv34FX+h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O6mi8xAA; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rv34FX+h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O6mi8xAA"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 626FB140001F;
	Thu,  4 Jun 2026 03:46:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 04 Jun 2026 03:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780559214;
	 x=1780645614; bh=6WgrJpYi4aveRyQi0r8rF53wAie2mPhkUKwh+DdlRts=; b=
	rv34FX+hLOeaUlyhSwsLSE0EGaXfDZ0xdUVDZXbdfF5bRIN9WiOQpSX/AC2HldfE
	r54euhINFwc0LcQeKo5xO3EyN/kkYTL0IJQAzFOOXEokUTaiMBUgnEpXqwKVIbo7
	qSeMu1mVlE7xbGKpjwpbE5rnmUzIUNgXhK8P/M0pJZvAhI5jPAJbGtP19Xc2DNFR
	Pw6rsuXiSVmUtE7zQK9K3fleyqtAECpnHnaWmflvunEZqICzHUcpofejwihNg3G8
	m6ZR+4F+ZqZ9iaa2ag4rOxGI3pFF6OeaLwIEj4SGTagIZ8nTG3IhQqWqRNaQWMKR
	kODDiRekDrQpXyjcmITZHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780559214; x=
	1780645614; bh=6WgrJpYi4aveRyQi0r8rF53wAie2mPhkUKwh+DdlRts=; b=O
	6mi8xAA84r6uJEj0qcl2nPCKTckImjg01rekaOT3QQ3IOvSPW7rLwOK8BbuiC32q
	mDLvREXLwn8t6qNcozDXHWguyFzJyjoVp3JflHh0ftpMSUDioU7WHuyI3giT9FAE
	wxu8gfXoZ26rhx22bObwMOXcJZZOJO94OMXJx26BMkU/zM6qwIObfFmsVHCGFvtt
	iL9v2ETZ9SVoLZ+/Pw7Tc6M3b8D3sz4noSDQg4mJ1WXeHyODU8I5cZr98u4zN1Wv
	Xl1KlJjLW4rrmIHnDYUf4TdQhONxfyMio9UUUs6NelT5quLWB06KpdkPhpq204oB
	saqtXf4kgPbIGeqO7kzkw==
X-ME-Sender: <xms:bi0har-cjMUrLd74Pe9Bb0u06Z62M9Ym6Arb3VoBoLW3uVFNWhBtCA>
    <xme:bi0hausX9fYY2ZUqcAtkp8O07IVZzcCJLExzVGAZzaMiJziyQYuwN-9Up5yGr_ea0
    BQzPxgZdRFcVb4biChoIfrL_VGYeDGpm75MdhscJFlK7xKmfPEXuA>
X-ME-Received: <xmr:bi0hauBeZp6p3NrqGl7Lso_LbhbrkbjH0NGVy37BdP5LS7wiNy6QyuHKSxyvzE69LqFMNLDFlxyfFRFFK29iinzaJ1iqOtfElx2QVRrWk2Q>
X-ME-Proxy-Cause: dmFkZTGhxnEHpPYRfkYwrVk9CvMD/gy9+RwFxuxewttP632BuodwIhLBPqS0tGa/W0UmLv
    7dRtKxJAyCQXYHS1ssdOVK4eYn6AQPxqA2nPPXNw33ZvSAryoaIVsd9m2fF98906KDu89E
    0dwdOj/gFzkYPI2rh7o0xGlm56B6RVfGjglopqL39L4tATVvd1Z2/tUfcF9LAKFfVywOx4
    9kQmC+TuR6fWOqXkOMYNzMgYGfd1SXpHm/N0LhqxKv8HZrQ4j+pd53HQ7tm61Lb1dGIavo
    hGfj9Ry8AN4Mg7aMmuQhyLLzW5lBB/9q46FjrRfoBhVa/sD93g86VYmknHPMphOd72Rxga
    uL1rp5ufBdcz4kpnay3qaG7JevJskc6u11LvIwPX7as2RB3ThWm8kzcTa9R6dU5om4O7VM
    azFtiqAnhAnwKmHkRyfVzwcJFLw8T5kGtUlmM3VmGvxoQk8YPFrImbAtduERCnQtYlZZcK
    UuhX6ZmEni8wkcFOiZy3vUA3Uo1YCDW+XuD4QaCZYsflhYNUF/4ecP2HIi+GETG5fLxmQ1
    XLNSaYyT3l83tehrM+/Bt4EZau1280KqOnUKoLN48qEx19kiVRrMLgfTPn6L1hkOm3WYcO
    eLguwPJJEQK7feRqImwTS8YJhjRd5EnA0bHftHf+tjCVFFqpH8ZnNjg9DVoA
X-ME-Proxy: <xmx:bi0hamWzc_qgNrucjmk9nBDKQ7wCXdRZ4S9eNruPepxgUgd8HXcaBA>
    <xmx:bi0hasBVzTrVClpkpGFjolNUdHeKjDMkNkaLKWpqZASgLXQQQyR2mw>
    <xmx:bi0hap9QDmBELDR_ryPRXWAc9BOrWE7svCvVLCc0Ln9ujGWTqiZ6JA>
    <xmx:bi0hajFBBn-mhcUOwQvZgZbN8lPXKjYI5w_bw0--m3duu2VrLjjmxA>
    <xmx:bi0hahjdQCpXp3H4_l4JN5-MgWQWcBqUL-dDNoKiqwZeQnaXMGJUM_zR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 03:46:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7bb5b1dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 07:46:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 09:46:30 +0200
Subject: [PATCH v3 6/8] setup: stop initializing object database without
 repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-b4-pks-setup-centralize-odb-creation-v3-6-0691834f318a@pks.im>
References: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
In-Reply-To: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The function `setup_git_directory_gently()` is responsible for
discovering and setting up a Git repository based on various environment
variables and the current working directory. The result is thus a fully
usable Git repository.

One oddity of this function is that we may set up the object database
even in the case where we don't have a repository, namely in the case
where the `GIT_DIR_EXPLICIT` environment variable is set but points to a
non-existent repository. If so, we call `setup_git_env_internal()` with
the value of the environment variable so that the repository's Git
directory is configured, even if it points to a non-existent directory.

Historically though, this function didn't only configure the repository,
but also initialized the object database. We retained this behaviour
from a preceding commit, even though it really doesn't make much sense
in the first place -- there is no repository, so we don't have an object
database either. There seemingly isn't much of a reason to construct the
object database, as we typically won't try to read objects when we don't
have an object database.

There's one exception though: git-index-pack(1) may run outside of a
repository, which can be used to perform consistency checks for a
packfile. The code path is _almost_ working: we already know to call
`parse_object_buffer()`, which can read objects without an object
database being available. And that works for all object types except for
commits, because `parse_commit_buffer()` calls `parse_commit_graph()`,
and that function doesn't handle the case where we don't have an object
database.

Fix this instance to check for the object database instead of checking
for the Git directory having been initialized. With this fixed, we can
now stop constructing an object database completely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 4 ++--
 setup.c        | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9abe62bd5a..0820cf5fb8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -740,13 +740,13 @@ static struct commit_graph *prepare_commit_graph(struct repository *r)
 	struct odb_source *source;
 
 	/*
-	 * Early return if there is no git dir or if the commit graph is
+	 * Early return if there is no object database or if the commit graph is
 	 * disabled.
 	 *
 	 * This must come before the "already attempted?" check below, because
 	 * we want to disable even an already-loaded graph file.
 	 */
-	if (!r->gitdir || r->commit_graph_disabled)
+	if (!r->objects || r->commit_graph_disabled)
 		return NULL;
 
 	if (r->objects->commit_graph_attempted)
diff --git a/setup.c b/setup.c
index 0dc9fe4565..4a8d6230b1 100644
--- a/setup.c
+++ b/setup.c
@@ -2043,13 +2043,12 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			setup_git_env_internal(repo, gitdir);
 		}
 
-		repo->objects = odb_new(repo,
-					getenv_safe(&to_free, DB_ENVIRONMENT),
-					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
-
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
 
+			repo->objects = odb_new(repo,
+						getenv_safe(&to_free, DB_ENVIRONMENT),
+						getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
 			if (apply_repository_format(repo, &repo_fmt, &err) < 0)
 				die("%s", err.buf);
 

-- 
2.54.0.1064.gd145956f57.dirty


Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B96935F5FB
	for <git@vger.kernel.org>; Thu,  7 May 2026 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178072; cv=none; b=iLgHIZA+LpiU0AqkEsZxO4O2lpkD3QEQF+pPQmooDJY4T2g5dpBlM5jOzqXxTSPFCoEjLz0yin8sccNIeJK/e3bAJwikp1zAp30gF/uFOfXZf32+BhWYsoMoT9wXxb9bnnyP2dmPcPxB75+CK9Pbhj+lgPGNPy+pFYTenjYG85k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178072; c=relaxed/simple;
	bh=jKoMespRVdAvrbEOI1Xk1wlEap+3J9pQPjg94so/6os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMMmWkE2dLW0gCkIwxTv/J6EZjukxnXqt0fF48zeX+7Q1l4JhPBLvZXEN3xbzFabK8c1UfCnBpJp0cr1uT/++fIT1AtW+vo9J5j7ekaeFtU0iuGL14SxBMhYizwegqYF7RHF+yJC4DEyo7mB1mCS+VU0sudK8LhoQUTZpqrPtEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Hj4ofMqV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h/TuPMrG; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Hj4ofMqV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h/TuPMrG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE1EC140002D;
	Thu,  7 May 2026 14:21:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 07 May 2026 14:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778178069;
	 x=1778264469; bh=i+CwtREpQMJTjL/vKW8Xmnv73Wfyh6EH/qBPREMU+jc=; b=
	Hj4ofMqVy99goiYUPBFXV6rWRdwk6DXSvkGITUiGDD0pNVr9HOP8sLedeZbqwIRf
	cKt6m+Z75E53mZ88n1whOWiHzmcXCUG9ary3C43frF+yz5EVTaIcjCP/0QnSCcrU
	o3CpjAajAhfG/KBzT5P0sfVgKCa6dF2RfDpqXQNNpngUDnWRtOhyT90elk0mwjE+
	h9zz/tFLcfY5ctGke483cUxtOJG44R5vYgM250LNnBc9iTY0MUWyX175cp91Db6u
	kcnV57QAzIglQAR4qyxo0CmNcsI3cCVDL+baLqM8kZJ2E8wGUNjHc8OXTS0VrRHG
	Y7dRvBVXUB9pGMB3CD8MPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778178069; x=
	1778264469; bh=i+CwtREpQMJTjL/vKW8Xmnv73Wfyh6EH/qBPREMU+jc=; b=h
	/TuPMrG/rbsMFVVRLfHfzpiSfD0T2UQMHBR843s+c4ZYbmHk6v+xROZvgBV+hmz2
	452U7gOX9VZqqsLaeH9fEkyX/fDQqtikKFaTG9LiXGCQspp+qkyunQ+Zo5lhWRKW
	gX0+qoK7A5BNoTag99LZ/2p1FvUIKo4BOLBKED5ZsD4V3S3y1v7R+hncfEUABmNA
	Dt05pinnKmOyEZ8icmNM9mfiv1Bj28GcR83xo1y7rOl6+z69SFAbDx+RpkkhSMkg
	W2+BGAiLHO/5lBmfR+w6fPmWUNOIVI+Tr2LCU8sZdjd54t6D0ZZj319DWVT1+u7X
	vXKqALQIpJFXxNFYCncDA==
X-ME-Sender: <xms:Fdj8afrVxTB4QLXzaTtO8bxYAZ3jlJXXQXgEJBX0EIZHqXPaQUEdv3o>
    <xme:Fdj8aRGvxEJRe4JBsFrNSvmeHegxj4CPdJkPicvAfx0G8De3b8ZjhFNn7GknWQmxZ
    rO-mUkZoUGyu-PSa7Dn4FsmO5Op6zu5BJq_SXR8PHOWlrkHlD7zhg>
X-ME-Received: <xmr:Fdj8aZnYMXnBGIJ0163p-s1scXQ8kmOfrUY9UaxZyT9DUzMtBHikIWAHkMz7mP-v2J2unTMTPjaioWuS7ecjuyP1pH8UgvuEt73TuO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdekudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:Fdj8ackyqaZbzYE73CTfpIe0hK8mlLupq8au1-gEMrwhPir70FFN_Q>
    <xmx:Fdj8aSuxWIPgWSA4Ta4kg_xxPzSPynY-2yyhSmf74fHsiOZLMBVCbw>
    <xmx:Fdj8aXmSJUSHP5LLyhCa-jTAEGucrO8JUbGuxg8Q3I-jXdW25mKWJw>
    <xmx:Fdj8aVsd9ygavOm5JOl4udMprbVQ9DzbvJ-17wafo0wFv4daPge9Xw>
    <xmx:Fdj8aZF4TNyXyfh0QOpH-Yg0sayGfjU-2_3ic7mqgahbHCP7OqOE6Jl2>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 14:21:08 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2] doc: add caveat about turning off commit-graph
Date: Thu,  7 May 2026 20:20:55 +0200
Message-ID: <V2_caveat_commit-graph.68b@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <caveat_commit-graph.671@msgid.xyz>
References: <caveat_commit-graph.671@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The doc `technical/commit-graph.adoc` says that replace objects and
commit grafts turn off commit-graph:

    Commit grafts and replace objects can change the shape of the commit
    history. The latter can also be enabled/disabled on the fly using
    `--no-replace-objects`. This leads to difficulty storing both possible
    interpretations of a commit id, especially when computing generation
    numbers. The commit-graph will not be read or written when
    replace-objects or grafts are present.

But this isn’t mentioned in the user-facing doc. Let’s mention it on
git-replace(1) and git-commit-graph(1).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: Incorporate “performance issues” suggestion on git-replace(1)

 Documentation/git-commit-graph.adoc | 6 ++++++
 Documentation/git-replace.adoc      | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/git-commit-graph.adoc b/Documentation/git-commit-graph.adoc
index 6d19026035f..f2a37e91634 100644
--- a/Documentation/git-commit-graph.adoc
+++ b/Documentation/git-commit-graph.adoc
@@ -146,6 +146,12 @@ $ git show-ref -s | git commit-graph write --stdin-commits
 $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
 ------------------------------------------------
 
+CAVEATS
+-------
+
+The existence of replace objects or commit grafts turns off reading or
+writing to the commit-graph. See linkgit:git-replace[1].
+
 CONFIGURATION
 -------------
 
diff --git a/Documentation/git-replace.adoc b/Documentation/git-replace.adoc
index 0a65460adbd..436a0e58caf 100644
--- a/Documentation/git-replace.adoc
+++ b/Documentation/git-replace.adoc
@@ -145,6 +145,13 @@ commit instead of the replaced commit.
 There may be other problems when using 'git rev-list' related to
 pending objects.
 
+CAVEATS
+-------
+
+The existence of replace objects or commit grafts turns off reading or
+writing to the commit-graph, which can cause performance issues. See
+linkgit:git-commit-graph[1].
+
 SEE ALSO
 --------
 linkgit:git-hash-object[1]

Interdiff against v1:
  diff --git a/Documentation/git-replace.adoc b/Documentation/git-replace.adoc
  index 2c0ea07724d..436a0e58caf 100644
  --- a/Documentation/git-replace.adoc
  +++ b/Documentation/git-replace.adoc
  @@ -149,7 +149,8 @@ CAVEATS
   -------
   
   The existence of replace objects or commit grafts turns off reading or
  -writing to the commit-graph. See linkgit:git-commit-graph[1].
  +writing to the commit-graph, which can cause performance issues. See
  +linkgit:git-commit-graph[1].
   
   SEE ALSO
   --------

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.54.0.13.g9c7419e39f8


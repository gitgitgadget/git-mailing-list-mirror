Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41230648A
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766441110; cv=none; b=FV25PkqAhH+PfFNebvhqv2JWEptTU8br+1ESP1Q+p1fCLr00I5zqaOdhlu5fTGWaeoo2AIi8PbJZewWOteFcOcLm+Wgl3dfjnXywyA9WX9BNHNNw+Q3ullEkXJAQaVUa4TxxjcuGlpXu7lgGasvyLemKjO1LRC2DMiYTLMPraVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766441110; c=relaxed/simple;
	bh=Uk7hD1CmoyzIqO7UH4p0Npq80uqHQVcRqAgCLfKIZa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EW6COqw/52c/O9/AhreN8H+Xgf1ol0urrS36HJNg0zN+F5G+vVGXqwEfxr+pHGVz08qMJYMe26uW3KRuiVy3UsOnkkrTRHeb4JY0OSnGnRXdlTY67SE4wX4t2UqCRldHzW/0W5eRjdXHD3rK5krDoxg2DT0PLX7acjiYKmM7hlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TMtJzEI8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yLJYHOr0; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TMtJzEI8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yLJYHOr0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 828307A0073;
	Mon, 22 Dec 2025 17:05:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 22 Dec 2025 17:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766441107;
	 x=1766527507; bh=8PL1KGFeZuV24mTl3LRMTk61bcRXNaiOYnOX6Ez0KNc=; b=
	TMtJzEI8nI3Ct57h6Me5aoMkg2Uuw8wvYproiNf5dlydXxI8RpvGZYXvsWvZnBJL
	TFdloumzBwFTAWHlieLNb9/6tl8HKrdq6ANnC1l7+n7W7mExy/X9l8kCAY+00QE5
	aIxjscmEoS8ttq+cPy0DSD3UC/BtvOEnd5phanAhqgFAQCVl8v/dDSnh0K8ELpoi
	DXKeSgisTMt1NxBko8P3wYZeLsGDgTBHLwjDXh1rYrk+9yquBorh5owM55YxLG1D
	eOmHiBcSUn7OZ1f1vdLhvilBW8yuTD7Uz3Z2BSS7mYnz2FhA3TJh0PmpYh+jWzab
	mOuCdlAsuS+sgqHqzIW4xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766441107; x=
	1766527507; bh=8PL1KGFeZuV24mTl3LRMTk61bcRXNaiOYnOX6Ez0KNc=; b=y
	LJYHOr0Y0Ej5idMEg8rhsk17w4Tmg+FC00gBDdkdajz1IWq5QXjFjHnRCHzCEojW
	reaf9X/IjG6YmduCmizBTSQejngpeyRNbHKKfa2JcFgmiyWv8v4ZUTQGkXXbmWZt
	QBlcnBJzrPhuV60JolkpJPSz0jF8ktpdEe3pqo1YkDu8RVp57QMw87U70rVlMxZD
	uEEb8wRkMHvLfqAk5fGWHJ7whvFWL8+TLTykWuWLALOZ4OznmEVUGNRUf2pwUIPG
	lIQPq/MyuRk6/7Kfx3X8EBJO/U9DdAxR7s/KCKOrujZ1FU/V/3v0cwf91tcDhmmK
	JYGj/WqjlRI4MExjS0l/g==
X-ME-Sender: <xms:k8BJaee71SSRCvNN7H7rrDyJe_bPNzUyqmpT8YVcpSfCNSY_2sZrqos>
    <xme:k8BJafFx81u04YLni5icvidusTYFriwGW5Ncn-PMOXZ0auCYcerNGk8P3WYYe4t44
    ZZpYeRiRTNtvWpqApFXMca1moYwGKW8w-2aB3gTuX62LNOZUtUfvA>
X-ME-Received: <xmr:k8BJaX2cRIp3gdUd1wBXtbCGqSTgz69Hk1GH6CfHKipz059orgIp3KCdsR_kyBBB-FXV8MxFS-v8cZYKdXEbDxobTBSHcpwxlLD2-iaihw0nXhoIgSHQEHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehkedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedt
    udduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:k8BJaXkZrLLBzHpYV2D08PmexnXDnp9AsTAPmmNY9lM2ISfqmpIDZQ>
    <xmx:k8BJaX9Ly1ARaVdZawH7n-UOFKhAzYxPNa15hWB54NBvC7rllhLFug>
    <xmx:k8BJacqYc8uEqJKPvsnQqhMYJaw7PJA8gbWK_RsSPOLHoBMM0onaTA>
    <xmx:k8BJaQnS7tehPXVmp0FCCbxxhKBxWBp8FVtuk5SKALNeb1WLZj_GOw>
    <xmx:k8BJae2sQp2liH6gbPqHetw0vIxr5VvVoWsJGHGYEP3NvW4Y7sdVjlM3>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Dec 2025 17:05:05 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 1/2] replay: die descriptively when invalid commit-ish
Date: Mon, 22 Dec 2025 23:04:42 +0100
Message-ID: <replay_die_descr.140@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <CV_replay_die_descr.13f@msgid.xyz>
References: <CV_replay_die_descr.13f@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Giving an invalid commit-ish to `--onto` or `--advance` makes
git-replay(1) fail with:

    fatal: Replaying down to root commit is not supported yet!

Going backwards from this point:

1. `onto` is `NULL` from `determine_replay_mode`;
2. that function in turn calls `peel_committish`; and
3. here we return `NULL` if `repo_get_oid` fails.

Let’s die immediately with a descriptive error message instead.

Doing this also provides us with a descriptive error if we “forget” to
provide an argument to `--onto` (but we really do unintentionally):[1]

    $ git replay --onto ^main topic1
    fatal: '^main' is not a valid commit-ish

† 1: The argument to `--onto` is mandatory and the option parser accepts
     both `--onto=<name>` (stuck form) and `--onto name`. The latter
     form makes it easy to unintentionally pass something to the option
     when you really meant to pass a positional argument.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/replay.c         |  2 +-
 t/t3650-replay-basics.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 6172c8aacc9..175b64c5335 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -33,7 +33,7 @@ static struct commit *peel_committish(struct repository *repo, const char *name)
 	struct object_id oid;
 
 	if (repo_get_oid(repo, name, &oid))
-		return NULL;
+		die(_("'%s' is not a valid commit-ish"), name);
 	obj = parse_object(repo, &oid);
 	return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
 						  OBJ_COMMIT);
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 58b37599357..bfe8e01da49 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -51,6 +51,22 @@ test_expect_success 'setup bare' '
 	git clone --bare . bare
 '
 
+test_expect_success '--onto with invalid commit-ish' '
+	cat >expect <<-EOF &&
+	fatal: ${SQ}refs/not-valid${SQ} is not a valid commit-ish
+	EOF
+	test_must_fail git replay --onto=refs/not-valid topic1..topic2 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--advance with invalid commit-ish' '
+	cat >expect <<-EOF &&
+	fatal: ${SQ}refs/not-valid${SQ} is not a valid commit-ish
+	EOF
+	test_must_fail git replay --advance=refs/not-valid topic1..topic2 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'using replay to rebase two branches, one on top of other' '
 	git replay --onto main topic1..topic2 >result &&
 
-- 
2.52.0.10.g08704017180


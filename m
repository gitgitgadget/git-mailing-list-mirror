Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C0E29D29C
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642921; cv=none; b=D4aHJdAjy4BgFvPyDSkc6DhYahKQTmixCpH2j2FO16sDjNri5NBd+aeUiXzrpjiJdAS5CkUVVRQl9uIywJfKJl6aevczV0VaP/yIPy4oFRVnwqPD1N0ScNC4uc4R61fvAbmZhZJ9dhQqMCC95fLLi+Snz/vCjFuogaew1hFetj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642921; c=relaxed/simple;
	bh=rYmvL6C6rgtREQABhVzPqVXX3XrCnrFsW3PMh9FHZcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rkb1IbSTnN9ap7FugDg6tD3tplxehGgUWS+T1hzWfKruEf2vOTK1ulS5ROVEicOYG5cdnTZ0STmbPsYZxCbLecA0HaQlNqVpHblfCHVqkFpiiLQHIM2WTeJU3QGToJviE1Gw14VbNQCnM4w5iQQA7ZV+8jZXjI+MadKCnr2Dgfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mztTWmon; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LDBfxPWe; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mztTWmon";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LDBfxPWe"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 25DBD7A0092;
	Mon,  5 Jan 2026 14:55:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 05 Jan 2026 14:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767642919;
	 x=1767729319; bh=Z1oA02ket3Nt/nv54tb9E83ZRBn4tuLGKGUmaVrg2Ho=; b=
	mztTWmonAlSWCOR0UfwvWKcyFiACsBmRaxQxNzHyZTRbSu4md0SINl4LaZ+6Q83R
	iL1sd6jvGRjtMS76TRfrktPv5UmqDG02OuaDiWIscOwplpfTIzpMZL5UKop4Y4a/
	Q9eJrxLe/f/E6+6pRjl0uIhZ1ndplThxb5SUSEUqFgKOQBeHC88h3UJGKHfG4/xn
	vMesXq1KGnecskTrZh2WkBUQLF01pG9Wx1OM1Kg4gDsCJhzkV9mgjjkkPS4wxasY
	ENZ+YdhBAE83l2OiVCB2LmfF9oC1OkixgLPa/9MOQjVarUu2odgyC/iJZYlbo7Ny
	eJPwAI/5RvaT+gsdDKZUrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767642919; x=
	1767729319; bh=Z1oA02ket3Nt/nv54tb9E83ZRBn4tuLGKGUmaVrg2Ho=; b=L
	DBfxPWeDIzjeriPaXl/6YHKD8xgfQwQ6QLwlmn+AkfhHCiGtG7VQfxhGkiBXlX3+
	R1bRtBjLcX5/HyfWIn8h2xdcAtM8sb5oFMUvAyMrIhStR7TR1fOSRmpBNUQMED5g
	2Xkts96lqcsFEpzoyjLP01SXwXyJrP3VAyuhUpPc8Iank4T43cYdLnAA1lI0Fyl6
	a99V1M6nUIrEUjblDnOcgGEH3NbWFROOitvjpTsdoos9hpqWmGd1LjjOVzlAYdft
	UlU065F4NvQ135bbXOB5mh4wVN1IXxz36yhemQk9hXoh+N9TfPaoB14i3oiiA51o
	MRj2JlYP2mVUFX4/uhF6A==
X-ME-Sender: <xms:JhdcaUl3-HoIbPOwOHqz7_IaE2FjQ5x5OUPQfngRTlmNE4i3XctuwOM>
    <xme:JhdcaUjO8Wo6khhMjMEe48yET3Ar-hgYfGz13NLvn7MTC-XcJNg_1xrZ3Ar3uz-2K
    DFDvItEbg8XNDJ0dmgcMrn49Btf76cbfI18v759wQ_qvI9UgYF8Wms>
X-ME-Received: <xmr:JhdcaQ1ZXqp7nYj1BaJ2b885LkdDZAAeaS8kFm0ReuaqbgQlWDZ2nZsESGgm73ceisMB4yptOR1_lBwLMDF7tQxb-q9J34TLrrDlTp0RwMpCimGVvMNI-j2wBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelkedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculddvfedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpedulefgueeiueetkeelieefgedufeehteekhfej
    ffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiug
    guhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JhdcaVL4dv5ZHc5sU5LK0w1l0QaL5LMW83pY_JmtkAneDBjv3D4yLg>
    <xmx:JhdcaYzCM7fqk1kzdIYVPapj_rP9U9h7Zc2kvMvS9aW0AcbSOmprsg>
    <xmx:JhdcabWYTNF6IiN48o76MRyinfycOAkDtsxNwnaV_45kbqyMCTu3qg>
    <xmx:JhdcaQhhOD_iC8efQFTw3x-IUU90rrPc_Kg-v-GPWkr2dWLxPqwCYA>
    <xmx:JxdcaewR3zsuI43yycjPYl9YqLO3eIkDQu__IjeACSdA172q2fkfAzNm>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 14:55:17 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/6] replay: die if we cannot parse object
Date: Mon,  5 Jan 2026 20:53:21 +0100
Message-ID: <V3_die_cannot_parse_obj.1a9@msgid.xyz>
X-Mailer: git-send-email 2.52.0.383.gb1c58d6b301
In-Reply-To: <V3_CV_replay_die_descr.1a4@msgid.xyz>
References: <V2_CV_replay_die_descr.17b@msgid.xyz> <V3_CV_replay_die_descr.1a4@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

`parse_object` can return `NULL`. That will in turn make
`repo_peel_to_type` return the same.

Let’s die fast and descriptively with the `*_or_die` variant.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]
    
    See: https://lore.kernel.org/git/xmqqikdxriw3.fsf@gitster.g/
    
    With the `*_or_die` function we don’t have to check it at the call site.

 builtin/replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 3dde20acfef..dc46c921667 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -34,11 +34,11 @@ static struct commit *peel_committish(struct repository *repo,
 	struct object *obj;
 	struct object_id oid;
 
 	if (repo_get_oid(repo, name, &oid))
 		die(_("'%s' is not a valid commit-ish for %s"), name, mode);
-	obj = parse_object(repo, &oid);
+	obj = parse_object_or_die(repo, &oid, name);
 	return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
 						  OBJ_COMMIT);
 }
 
 static char *get_author(const char *message)
-- 
2.52.0.383.gb1c58d6b301


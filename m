Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5C39020C
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116931; cv=none; b=kiKpEODCYmD3EleRyz7SrMnUePl4H+Se59VQtA4V8aslhftXDXEaENl/qEkFeqRS42K07kCYN7rE/WE4CKB5qPewk7OxBCdPDWZRdH1sK0E3ra1eSSq5LLA1c12ocdHS2SR/LEcAjwk3wpCJGUJ7TQhqRn0YWvPyoos2q8AgOo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116931; c=relaxed/simple;
	bh=zQnGBk6jLv8y6nhWiIGyr4QYTvNDkWhDKkjtRw12lbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxhpKqVEg6cghZiZiJrZGVDQolKOt+pOsFbUdVHbpSDM3hUGTQkrYeFsQvStpsjN4vbasnOVWS8HOUc2m2cU7Zup3x03HUVJOsKFxhibKxkG3Y8CjY14vQ4EdcXDGe3Mq/Seqb1GppRzgBn280b+PT4qV+YTv+tIxNoNGUsBWyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WPvf/RaH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hREXK0On; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WPvf/RaH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hREXK0On"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D07B31D000EC;
	Mon, 22 Jun 2026 04:28:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 22 Jun 2026 04:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782116924;
	 x=1782203324; bh=Rr+8rbYtzcZ3OaSOg+SqRlPOo3vmK942WvH5x0tVTTc=; b=
	WPvf/RaHV3Kz40PvyQneuXa9aInYjDkT5H7a1OsGKduJs183Tx7VnfVaTu1xzXJ/
	XMraQlSNpUFK1X24hg4ZkKDok/eIxXg7z6Z699XXl6iICP2LAbV1tnuDmkhko25T
	B5IVna32dUVY2xwGoOw1bSXdrt3qFMMNOFMLdePjYN3lRnQ5u3AhFHxVnHvHurQm
	GXVWpFOVURBmG7ZK/VSt+llthFpF5p6dgRrD0vkaJuF176SAgOo5U5Ot6qMmUfaV
	S1KbXoKNlzRQ8yZ2Tn5L5dOlJvMvvheJTXDuDxJgzK0l+9wUnPJFmFhY7w9A4FE3
	pL5OjY7yv8HFHBiIQiEsmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782116924; x=
	1782203324; bh=Rr+8rbYtzcZ3OaSOg+SqRlPOo3vmK942WvH5x0tVTTc=; b=h
	REXK0OnYCXyNMNmz5SAmUO07SclcMygTDtnYoKW+juUf7UDVVZm8T026mNv1w371
	WJEjxQ3qaCOtlwYJZV4QeynCEyWguH4wbV93UfxkarquTgZ6gJ1whYh4sktlodeg
	0ovOPENmu3QrOQH45Jb9xSPCXSwc2S2oAPCMcTNk9KhqENq/OTxtJr0KFtULAK+q
	/dLXkRLbktTc5DU/os1UN64pK+i0//kE+4WhzRu2rOsw2uCaqBuqMVOOmaCGqQuB
	KtAkk7huoB7rGNNJk5jntrxbGBecH252r6QTCrOzpXgBO4gXv+X+wU4kkSZVo0l1
	33d/nwbuzxMyR+vMKMi2w==
X-ME-Sender: <xms:PPI4ake7TjdNo02YkbT-kqJW-fMZieKxlmcDR1KONCQK9PhEBiuGuA>
    <xme:PPI4atNHauNFUtZT0RTwS6-93lfH0DdAadBgqBoX_YzJdO7TnUON3ifx_l5m3pKVF
    lc4mMPSbB8onH1PMhFgjWNXn3kZJ0wmb9qhAGd09fG7lSkaerBd0w>
X-ME-Received: <xmr:PPI4aqg0Nu_XmLesWgCuzdLMUS1KlkrfjRS4ltcokXIGy_9KnEBBVq0pRh329uWl6thZvMiBctKuu7NTD2M8Yc4V6ieMqXNE9NQ0Gs_rfw>
X-ME-Proxy-Cause: dmFkZTFGuvhk19wP1nIdECGxwx3gbsw2ufEFYPW/bcryZRaeS0zP3zRO2BkgCLVXG+HRAu
    eDSJo9XC9+oh3Bg4ZRtWUyrhjPNmJp3YOJHUnxHZF9fRZrG2CDlLXQ1vIYWsZ6wE8vVEag
    zy9G92nuZEbjKcNWm4jg58++glxCpMiBCJ8FdiujUMh3AT0f9M3NX3x4YMlYXDCGdPE5Jo
    sF+G7mjGMycHN/Ao7CZBomtDY3FTUdRjzmq4savyltQeIxi4PefUj35UFTgtSExhYooKOd
    zIHDBAiAvQ1kUkDPooo/KXMo5cdMPFyZNxi4JoyhlbXctSkAgq/pHTp6e/bmoS79cQ0Afc
    W5rC+UWbWS8eE0sy2USq5jTUquhdes/m5ZnK5cDpVhuKIuJnZ7J9I68RLnkrcXH7rvwZ2U
    CBOgdZXmQV87v0s1JEF4ITRsGZdqrKUt00+aDRniYZMY6yD6fRwyZrIsC1yuqiZJMhwcHC
    gvQnG5cGBOttcHRgQlUy24Orw87jH8ucUyiMU7I1xz56luxj8bfaDZ4pA/BcnUD4OtkdgW
    QKSPPy1wJ/ygbxU387TMv5oXeSbNEKObFh3uI7Y6aVjJXeRTrdq3bVN8Jd0CixBTTJhyb7
    VwadEkYqN3DA7KZJdJShx6zcsCyZgzy7Ob0XU46AK5ZHqgl4JSdUOH5oVQrg
X-ME-Proxy: <xmx:PPI4ao1pY6GH-joZbU8O28EsiVkr93Dqze_YHePOA707Bt95c7ucuw>
    <xmx:PPI4asjUZUkN1AwdminO3uTA2vTS5VoxOyjtBb1HEommUn2wftpamw>
    <xmx:PPI4ageXfaR5BKvsfEgpepYmzg7hCWMtlMneiuZ8eastZ3kd5oeJ8g>
    <xmx:PPI4anmriLN7T_un5hyauzdhpx73RwZV-YCnkYhAO7REIotbll2cJw>
    <xmx:PPI4anl0KGXBTv7JMFfTFlw9a-DUnaYLSG98Z1lnkCHlF6caiStKv1-E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 04:28:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9b4299f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 08:28:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 10:28:28 +0200
Subject: [PATCH v5 06/11] repository: free main reference database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-6-018475013dbc@pks.im>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
In-Reply-To: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

While we release worktree and submodule reference databases when
clearing a repository, we don't ever release the main reference
database. This memory leak went unnoticed because its pointer is
kept alive by the "chdir_notify" subsystem.

Fix the memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/repository.c b/repository.c
index 187dd471c4..e2b5c6712b 100644
--- a/repository.c
+++ b/repository.c
@@ -421,6 +421,11 @@ void repo_clear(struct repository *repo)
 		FREE_AND_NULL(repo->remote_state);
 	}
 
+	if (repo->refs_private) {
+		ref_store_release(repo->refs_private);
+		FREE_AND_NULL(repo->refs_private);
+	}
+
 	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
 		ref_store_release(e->value);
 	strmap_clear(&repo->submodule_ref_stores, 1);

-- 
2.55.0.rc1.745.g43192e7977.dirty


Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5330ACFB
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667817; cv=none; b=GpCQeYfFJdg+Hv2IsypL6Ho7xMC82E3RjFSlnP3FzHr79k8xrwWr/PrIKOfW+q6FZeXNB532ibiHu8gcdYwa0WEGw3uz8OFlGt/C19jUgBhTPVJNFROpgZF5TRqsvnLfjWE/C5rTBJmI9tstmr8YarzkOo/Bej762eU3Ab2yO/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667817; c=relaxed/simple;
	bh=oDcJsCOqTCQyqE/JV3/o60FTjJ4QvFohceoanv8EvD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKefhS/REG7q/bG8v3EY5D7b2s87Dxjm3hFcT0aboBlijm8rplN+2DnOr+FuwL5OdwsC25PchXe34b6DIm+aD5LYY1CIDMYqdm65IW0cpAz3YajZYBXT1udvR8hTjxBNpXtZsRXCrhz/s7QkXvnjohAf69EguojwbAMVRT4iGl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=N3NhOe5Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iL0++/Ss; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="N3NhOe5Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iL0++/Ss"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93B06140011F;
	Fri,  5 Jun 2026 09:56:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 05 Jun 2026 09:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780667815;
	 x=1780754215; bh=VFO+C+bHtBYguDhFL4Z9WroQdbjp1CXyB30xm8m5NEk=; b=
	N3NhOe5QdkA0oQ+BrRWsWzHFs1aNvjSCgU9Y2pDCYZv9PojaUu1vEt4eWNSHiTPG
	bINyVqCfFOrt/bEfR8r/x5jsFkPE3MmCuowgGKPAEJE/UEGR3mipbA48bD00W9q9
	wpQj0FJQtiKlzgQUgfiZ/7awkxwyCjipxmxeyq2AITvMSYzK7mYZuvq6kRAVxCLR
	zGiUyQ5NWIb0uYyRrIb2E4WsrwrdUloaB11i0aTeOttO10ExMX6T6nxr5oyqrqkS
	Oen9cVAzFAnTYi/6IiQkYQRBsfErSzcD6dzBwBDUdvYU/xnkYbtWHl+LHwJDjbVI
	IMCO0mNfzzklA4B3jsVfig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780667815; x=
	1780754215; bh=VFO+C+bHtBYguDhFL4Z9WroQdbjp1CXyB30xm8m5NEk=; b=i
	L0++/Ss4YgDxXA+zLgVRLxi5u57muRylfzyY52ncfjJwUkKLOVqlQs3C8ZuJrYVE
	2C4eYJiKNgQP7Gk8jN3eyLb84UlERzowz7HUNsJ/pN7/bTdTB69Ug3o4CAH9zHYx
	/ha9NHBgmRdl99tdylZFpUwgQ+yS6OR5RRP2DciCEvvkPHjQ8YhFFOy447OdObx5
	H6BixUSXgrKaXp/yMyShbS0sf6WEaS88UaygnKh0L4pnYcEUQWVGEBbuhBgC2N1l
	SEmS2eCTcEb7BZPPtx3zTTF8NZGZOuCz9jglFuzRPvN2Ubu2idInC4ZlTLcurVMK
	Fa0d54Qo9bpxZ32Wq/hJg==
X-ME-Sender: <xms:p9Uiagfmmz2wzcnLvGRyIstOWMkgozxO8N5ZumKqhFwIfPNRPOD-Tw4>
    <xme:p9UiapEhrIccLj54NWdw5rAlnZwU6DGcJM8qOu2AU5hLzDRsBz-vmXUrZH-l8BDTJ
    SL2PqNhkKDO8aH0b5fZZqYy7xxDyOLWBMSQN22J_s_UMnlQqVvFTMg>
X-ME-Received: <xmr:p9Uiap0jMb3RC_JyL3T5Ch5OL78KBoGn1EcFbTs5LAGwSxOtXnzY8ByIqA_5dO-9AMrM_Chs0GIsBp9oBIN9HmBJCNWSJc7nRt1OdrU>
X-ME-Proxy-Cause: dmFkZTGvsYIBbcBckKcYFmAf2DprU/CQcsVUaSBxVzMlk2tltWKohjMLTFj2fZBFoZBsMT
    CbmwKGWeeNg0jEft8F9g8mugtV9QqiIa5evikB5SHHb4gazxVPP9SRLirwAmzkaj8btzvu
    I4ZESplgnwUSrigypLrqD+oJzTYoaxP8IS9OX2ONX9JLdJZiPAHOv5w9OgUDKd/OkVWT21
    PyilYZc9IwPg4gxTFke5nOFjTJ7zrfdMbT74FnfMG3o3b+DNTsVGiIC2rOftS+f4LNeXIt
    UPZ+U5dMI/S8VE85c9X21tODF/Gq/gEs+RbwCbGywzMlaRVf5z81qGXSWi+fYiJHB7ssYV
    2IlmpAlYlMtimBzsS+fsWvGRnunHI72HcP9GHvJALZKodp7NJvFoel58O8lZakMyUCLkTc
    4AW4ilKb+JlYyXnxWA1djvLAXrvmA1u3zAU5/kEcXeYBW2Zx5nxhiQK9hAc7nzsLbWSJHv
    vLL6h7k+Qmjph72F3TmL3MzkK6pa9g9poqiOU+ObVO0dY7EW13EaUAEWfb6MuG7ffqfkOm
    bywrnvD5kWL7heU3Zd3t+NaGvYHVO+Eqs2lx6PJP6CBtVWxDIh413p7IZtzwDdWfp3vJNf
    nLyKWkBpPrvSMk7pojt9kgk4r35pBtvzJopbfeE3qeHGaBUEgv/EvEkyCAzA
X-ME-Proxy: <xmx:p9UiahliSDRjs25KrPtDs2Zi6LQJuS_euiUO9OOpbccCOjyqEYGCqg>
    <xmx:p9Uiap_3FZ1SZ-GHR1buza6vgSTu91RczhTAuQ-5RKVIdrJE-3trKQ>
    <xmx:p9UiamqiY8u2Mqke4cgCnoKMsm8z2ocB0gcEzi49V9jvBfMFFmT8SA>
    <xmx:p9UiaimrSBk0B6zeaLDbt-9UU1Pi1GZEmOtggmcjKWgFvlKQRTBKww>
    <xmx:p9UiatVVq-0q-z2RZ5nkvhZHDLWjnX0sc6FUzeYYb_AJQ7Bu6rKoYOQb>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 09:56:54 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 2/4] doc: replay: improve config description
Date: Fri,  5 Jun 2026 15:56:00 +0200
Message-ID: <V3_doc_replay_improve_config.782@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_doc_replay_config.780@msgid.xyz>
References: <V2_CV_doc_replay_config.767@msgid.xyz> <V3_CV_doc_replay_config.780@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

First of all, this unordered list for `replay.refAction` introduces
a term with a colon. This is exactly what a description list is,
structurally. Let’s be stylistically consistent and use the desc.
list markup construct. Let’s also drop the harmless but unneeded
indentation.

We can reuse the `::` delimiter since we use an open block.
But for consistency use the typical nested description list
delimiter, namely `;;`.

Second, let’s replace the inline-verbatim `git replay` with a link
to git-replay(1), since we are naming the command. But make that
conditional so that we avoid a self-link inside git-replay(1).[1]

† 1: See e.g. e7b3a768 (doc: git-init: rework config item
     init.templateDir, 2024-03-10) for another example of
     avoiding self-linking

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Msg:[1] typo, fix to “stylistically”
    • Msg: Move the paragraph about delimiters (;;) from the *next*
      patch over here instead. This is the first place we do it. In the
      next patch we can just say that we are doing the same trans-
      formation as here.
    • Msg: Remove double-space to separate two sentences. That’s
      inconsitent for me. I moved away from that because two-space
      separation takes up too much space when linewrapping is set to 72.
    • Msg: This isn’t the option, it is `replay.refAction`
      • Copy–paste mistake? We don’t have to ask
    • Msg: ... and it’s better to call it an unordered list rather than
      bullet points
    
    † 1: Commit message
    
    ---
    
    v2:
    • Keep the description list for `replay.refAction` (Junio)
    • Now rewrite the description list like in patch 1/3 (it’s
      technically an unordered list)
    • Msg: mention a previous commit which also avoided self-linking.
      This helps establish a bit more context for why we do this.

 Documentation/config/replay.adoc | 16 ++++++++++------
 Documentation/git-replay.adoc    |  1 +
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/replay.adoc b/Documentation/config/replay.adoc
index 7d549d2f0e5..7328da9537d 100644
--- a/Documentation/config/replay.adoc
+++ b/Documentation/config/replay.adoc
@@ -1,11 +1,15 @@
 replay.refAction::
-	Specifies the default mode for handling reference updates in
-	`git replay`. The value can be:
+	Specifies the default mode for handling reference updates.
+	The value can be:
 +
 --
-	* `update`: Update refs directly using an atomic transaction (default behavior).
-	* `print`: Output update-ref commands for pipeline use.
+`update`;; Update refs directly using an atomic transaction (default behavior).
+`print`;; Output update-ref commands for pipeline use.
 --
 +
-This setting can be overridden with the `--ref-action` command-line option.
-When not configured, `git replay` defaults to `update` mode.
+ifdef::git-replay[]
+See `--ref-action`.
+endif::git-replay[]
+ifndef::git-replay[]
+See `--ref-action` for linkgit:git-replay[1] for details.
+endif::git-replay[]
diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index f9ca2db2833..4de85088d6c 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -211,6 +211,7 @@ to use bare commit IDs instead of branch names.
 
 CONFIGURATION
 -------------
+:git-replay: 1
 include::config/replay.adoc[]
 
 GIT
-- 
2.54.0.22.g9e26862b904


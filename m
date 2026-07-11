Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DD1D95A3
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783798022; cv=none; b=KsHzs++tJnbwmVqE/YI7qfGFIFqCBIODQOAohCKFy39N19b2QK1SqcGGUnZOXGOZSk8DU8tCi5xS3mpW0kPJ97ftllA6m1n1ugSzkFIemPG98zfp1vFuesgAulNaOIh9ZYZz2NnU288sdwmSiPyAVoo3tUPAkA+hAdW89KgplZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783798022; c=relaxed/simple;
	bh=yax5A79WnXmppVwJjdneY5ygdmdkmq/dHKh11TkpArw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jyl7uhFQB3mCkRSLLMJti9nJ7BioqjI+09aeS4QJdUcQVEM+/XF/0/3d3j1Xn20T8/QMB2zU/b8dIGr2H62E4qBF9RJngxzTt3dfds5Prb4XoYV6+nh5Tt0ODhIV+5mPWxjgoKpqpr2HXgIw91SE/guA3+CFHTsYOmS2aBt4+5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ik5oh2cE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V2q5RiZ9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ik5oh2cE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V2q5RiZ9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4BB3140009B;
	Sat, 11 Jul 2026 15:27:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 11 Jul 2026 15:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1783798020; x=
	1783884420; bh=Sh8GnirfpxUj5XpLvrmziDINt49bbpWwh32e2SQ8hMw=; b=I
	k5oh2cEHf7eSxxTyNSyf3g/wI1dJimqNuvnYjQo78TFuSM7qR2NBlcourQgqrzp0
	TdrneRACXo9qD6oEttysGHSAGB+QTUcg21XDq7jQElNjQakM9le61CKSwjSSLnyq
	euKHAVoDaNKvk3LlnZFWRkcjvkauNw9ULMCjZUShYbM5bHB8a7KMSnOwQfi6//Yf
	enFZPDmGR0OfTwzSm1HYIn8Ot/IY5kLsLdd/1o/8hRM2XLkwefl7QmGGLVwwK/w2
	R3wyf667oaq+mWrkHmAoucG5cRIWFM1Js1VUN8tPL8PE9qLxIdVfozSh9eVnVW56
	Ou/GjB5tRTTwg2QHoHlOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783798020; x=1783884420; bh=Sh8GnirfpxUj5XpLvrmziDINt49b
	bpWwh32e2SQ8hMw=; b=V2q5RiZ9F9TpbGTssq+38Fexx0wEJisuPndeMAJj9KQm
	zidYHxdAWSsTM/8N06xmNvyvNUylTtuWmNMy88/Yd4JC4mpgRBgpcteK+IeRO3+m
	Nca2Yt/sRZdjtuvMoJlKB+hQzO2iU5qFXTv/lDigaFQxqjOCwhsDRFE0BEahGqS7
	f+Fvr/t9x5Jdd4ywuPP+HLVfIIDfiHps0f4Gjvkm9JfOidtQITnD0mSXVpigZptn
	j+cNK15zq2176jcPqnESwWk1qCu0sQV2tAYJ0K/xfteaFdF1tbPR8sa5SSbeLUNM
	cudJMKM9Hf4Y3wI7DDusBXW2eXBi5IZUAmMcVPkKGw==
X-ME-Sender: <xms:BJlSajbPsCXbptwqjchMPUBcHdNRcfN9BFn4ginqdm9q9kyEBUhgqQ>
    <xme:BJlSaoZdzpixb7q4W7ZtuG-GCoa915lbYXbKXZ7wT9HT1EJbrxcxnpnbsYhEJjKAE
    JH4giNgY1RoRXdtDuZT3UTS7F1Vi7_YqRMPDYk5FuXdapsPJrp2yQ>
X-ME-Received: <xmr:BJlSajkstRcnGfiZIlZnKgtntiE1t83ehUsHV5ylr94CRq5q5jCx6QSk47BRLQ_3Zo_vEFba30O_Fyq0usXvDCJs6xW7HsiGxsELym8>
X-ME-Proxy-Cause: dmFkZTGmziIju8eun6XYCDLvKwN/tMRSuF/RJjSKBOGvxoS5DME1WguMzMIKPFkZRzsnGs
    P3uifJXEf6OYN0XoGh92SeypxzcKBjP8qIfgWBdpSycD2hrJd9pFic31yvBqWrz3xmFDfv
    rt51x/xaiQMvgaM9C8p+a6/KAwO3oB9R08VXrQ1hbveawleQy4ZThq6JDuMHPWYVr1w9Ob
    cqAIMjF0m7k1yx0jmninJHl2gmZ/Pa59GpR4qnMCnrqvmKZB+W1g4GnB9KANQh0JnVmEO+
    oJdLXuvsTREGToaoGaJjoKS+MA4KQSZEHth+/KKofKEr/F/zUqDpcmXlQQ+qFfkryhZ5fr
    J5XmbRjwqts9HfLebBdmuTGRCnmz0BEJMq2t1jWK2fbBaqEreoXpwC9bdcJXFaVNAly+RA
    00DoQyBC/m9TKXcdraZQuE5MvRJ7rlsZWl9xxAOuqk5BYDIgficT9gaU06D5EpqZXCC+Mi
    cUYK7frJ9dMROTaE0F08td5elOOlKH99M1h+5yD1mcuy6m/JwBGlirb71qshuqYYLK4YYf
    nMYtyUHsAZvb4s7qjEaSMzmy9aH6Gb2eQPs0MT0fJ6JAmy2P6MajebGTSa7+1+oukavTtf
    K0UU+Yt3b3lFU/4DaeYHxK8t/NGmBfhSzjB2HzkCam1mj33vgqBjl9oHablg
X-ME-Proxy: <xmx:BJlSakxTRTh62Gzv80RVY870t4YZ4gQ9fXT7t55zQIlXUAy5UjI6xg>
    <xmx:BJlSahM9MdoiCOFvrH_xmfhQzjnmVIER7YW5NgKHiZww8lr_j7DooA>
    <xmx:BJlSaoT-8YgH5bMWH9UECInW5Oko0fDHrj3dg2y9dK4L9h4RwymAQw>
    <xmx:BJlSavao-K5jXA9JoDBMkARwb-FS8zUBGB1Z2WzLAFYirwkFmZVqBQ>
    <xmx:BJlSamywm-Xk_BAZk2QUMiVKjztyPYt_U9ZE_lPXUaUN5WLuwafjyBr3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 15:27:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 6/6] SubmittingPatches: clarify the writing style of whats-cooking
Date: Sat, 11 Jul 2026 12:26:50 -0700
Message-ID: <20260711192650.2417665-7-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-391-gdf86bf5712
In-Reply-To: <20260711192650.2417665-1-gitster@pobox.com>
References: <20260711192650.2417665-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike commit log messages, that use present tense to make
observations of the current code, and imperative mood to describe
what changes the commit makes, entries in the whats-cooking report
are written mostly in past or present perfect tense to report what
has been done.

Spell it out for contributors.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 0a80358703..8917cc3805 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -714,17 +714,26 @@ line via `git format-patch --notes`.
 
 When sending a topic, you can optionally propose a topic name and/or a
 one-paragraph summary that should appear in the "What's cooking"
-report when it is picked up to explain the topic.  If you choose to do
-so, please write a 2-5 line paragraph that will fit well in our
-release notes (see many bulleted entries in the
+report when it is picked up to explain the topic.
+
+If you choose to do so, please write a 2-5 line paragraph that will
+fit well in our release notes (see many bulleted entries in the
 Documentation/RelNotes/* files for examples), and make it the first
 (or second, if including a suggested topic name) paragraph of the
-cover letter.  If suggesting a topic name, use the format
-"XX/your-topic-name", where "XX" is a stand-in for the primary
-author's initials, and "your-topic-name" is a brief, dash-delimited
-description of what your topic does.  For a single-patch series, use
-the space between the three-dash line and the diffstat, as described
-earlier.
+cover letter.
+
+If suggesting a topic name, use the format "XX/your-topic-name", where
+"XX" is a stand-in for the primary author's initials, and
+"your-topic-name" is a brief, dash-delimited description of what your
+topic does.  For a single-patch series, use the space between the
+three-dash line and the diffstat, as described earlier.
+
+TIP: When proposing a topic summary in your cover letter, write it in
+the reporting style (passive voice, past or present perfect tense
+describing the change as completed, e.g., "The XYZ subsystem has
+been updated to...") rather than the imperative mood, like you do
+in the proposed commit log messages.  This matches the format
+used in the "What's cooking" report and release notes.
 
 [[multi-series-efforts]]
 If your patch series is part of a larger effort spanning multiple
-- 
2.55.0-391-gdf86bf5712


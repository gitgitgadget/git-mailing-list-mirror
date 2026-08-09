Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90F4B0493
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306215; cv=none; b=en/lJpzUbq+10f/kw5QFWvgkWRccwQbYNBhMKvGBl4V4rBwoSgPNhLBL0vjueUBOO1L+Ndux0CxrGxqjVoTUwu4wZ5dIr9m7b1R+m4vcURBXdUtVIPO6jL9tPcbEHuTkv/qI96C0j+CbH/uoMzsY9VTuyEuZd/QJ7b7Tu2gwqpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306215; c=relaxed/simple;
	bh=nAHWpw9SW5Pyj/jgCdOR0z1EaH3UeH1BBCshaNSbc9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKmD3aF09ppFBPyj/g6/1plrMq1xQSnbJC9CUhRIGUONXYOfhm5/Ylh2GgOzoaFcA+NxiTwLp4ltc99MXwzdVFKHKxVpVh+6GKEIDe2ScZFWyiwZVtzgrhtBErQ2ZLHD8X/D1Mlh4DRscFi9xORhoDSAhDLj5fKzVxgYIesiZ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IC+MT8Ru; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YCpxpSxQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IC+MT8Ru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YCpxpSxQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C57FC7A003A;
	Sun,  9 Aug 2026 16:10:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 09 Aug 2026 16:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786306212;
	 x=1786392612; bh=QnFi4vyuvXlBJnKLyrS71tWtt+mpZyg41vkn2EqhOxs=; b=
	IC+MT8RuxTGfSl7q9QSxgo96WNK6gW4Vz4/PHTVTuR1FWPLynCObtNKARQxX6a5t
	lX7ihSL3GjuEEsywpYgE86VDeUaUe0Xn32X2oN8Nqn+L2XMkj0SxDcmSHdqHQqM5
	JUe6nL4qilff1znD7r2Jz/E0BWzIQlpHt4Fm0NKGngP6rdtGiDA/224e043CO0G7
	NaUDdxjwVtf1lXQkWSil9kFiz1dfch431z/qvJzphlZvlLICxltM1R5rtxmMig3G
	GwkNJGYuD0lZjgsBnhDBD+SoLWfcg7tMo9EXj132JsxguuvDaqgCFSJR1AurZNa1
	T3dEGOuMzP7Ax7hVn6AYKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786306212; x=
	1786392612; bh=QnFi4vyuvXlBJnKLyrS71tWtt+mpZyg41vkn2EqhOxs=; b=Y
	CpxpSxQJCeOoPELJd1dotFcgDtYJyU6kRUK0L27AVy4QposKV9QSTSaNmLG9IcDt
	2ZlZoz4hq7vZyyRf6U+aRSk33HyZkuzcAhpZ/RKIPx6Hon6qJYS9yG2dweIZKjn3
	vaq2eHgOc4TF98b3xjhDch6iR4TIXgJyQAIWMbZmPl2NuSTMq+WkXTnqsKwE4dm0
	qv9c1SjTAp726+BnnTeNYR3pwGWX+54gUdP3TA7B862D6zDdY9OVKyqMLp2dtoT3
	eWxds+yBRGnCaA4RbGr4Rcb7EhB/J3W5odJGrZ7uKeSfAbUj1EyNhQjxNevmXg5S
	e+qDbM6jNV6H4gL99uUmw==
X-ME-Sender: <xms:pN54aoL3BDfIu1hhPNgW5fzyOlLfLA7-RDChxPTo2zXhBdCJ6stJD1Q>
    <xme:pN54anMpvVmIim2Lui-1EXsBEWLQC_yTGu8BPErMUnrU41M51vUs2cq-kq2IeIwKp
    2Rk3VSeOUd71Rc3N2ZuAywIlf4DiORwMqzkHwkeC1118BAipEDTOw>
X-ME-Received: <xmr:pN54au61WKzYxQsI0ZlYXT7TzpEFrdRBzhuP9_mUfPqNjSoQZpIUAmj8_dYmE1KnVGvQ-yozppA5hlT6jcbqoQXh8d63InUc0S52j2tNyoK_GbnnAeAtehE>
X-ME-Proxy-Cause: dmFkZTEcdI7FD+6TWE4ETRG7ILyNt0FJmLCkf4B7Rh7bvO9LDSLJTh+a8sSGJMVUTrqw4H
    t+TcTQVn0225EKdTVhRDBQrL3gn3hH52gWv+bGIdmXvmIP18dxA6walyfMaaYln20G1xoF
    kRKdLe8RsVLgQpNI5NFqcuau5PlG11BgHlUCxZ0O5jphPzlOd3qmyr13Ux4UWy+vN/oWHF
    50/FAfD9zQHH9iGUl2Xc/1q2la1VviA1N0mKCTbiLbIiGg1/ZCTG3pL2DaODFhu8wNIiUr
    9P3zZ85qGs2o7yRcd1dFb7Azn2UrkJrazICMpJpdxrrQnz7x8H+iHPqNcRNEv9rHIIH1HL
    ysT9dn0mzc+yMKEb5pcxLxqvbLKZbnvtVgaxgVNyNjboDYKEMR7Rvs6VqcyRyf33oLwX8H
    9hocPgI2Llx+x/n/UqBwXMeTULkyPpcaVSWxORuJ7qYMpRS+i/uN1WYoKkzDrdPf5hlNQy
    gctTzyzkH/orZyvsgKDpTZqWTsMqHec6Od+2A+HxGMVTQ47cNSBpFKri9aiBAQfebN5zi7
    razEYSeNbM+BZ5Ps5r6J42n+FZ6Ziz5+beKFnw0oQ84w1wxeYH8DLLSBJPkN5Ed/heoFyo
    AT3epwuVTgosJ7joj4GHsvaav+emmcKM7//yyBAy7EA1ov9Q7Knu/h40CzNw
X-ME-Proxy: <xmx:pN54ah5oiqUkT7UtZigKm_972m7epVDMfYQMUV-4S8Bn4AFhcAzbOw>
    <xmx:pN54akHXX_1wwoBMDDCx8jfGi5lQapCOZXPYN-KyHwb7y5qYvFovlQ>
    <xmx:pN54apUK16tPMCp0phqvJTVzG7itY7fZCvL-K8IJ91X2DNzqYDQ9ig>
    <xmx:pN54agWwMNhWwXfh-3Ylt6T8u7SOHCUYk9r4OY_gfC35uF33Xc4w7A>
    <xmx:pN54aikvHbhGw82uYx7w40Nf2vI01-HfX4EgydjiWgp0P2OFRCpfjMc0>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 16:10:10 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	Brendan Jackman <bhenryj0117@gmail.com>,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 09/11] =?UTF-8?q?doc:=20interpret-trailers:=20commit=20?= =?UTF-8?q?to=20=E2=80=9Ctrailer=20block=E2=80=9D=20term?=
Date: Sun,  9 Aug 2026 22:06:33 +0200
Message-ID: <V5_trailer_block_term.b2f@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We chose to introduce the term “trailer block” into the documentation a
few commits ago.[1] It is used in the code though, so it is not a newly
invented term.

That term was useful to explain where the trailers are found (they
*trail* the message). But it is also useful here, where we explain
how trailers are added to existing messages, how trailer blocks are
found (beyond the simple case in the introduction), and how the end
of the message is found.

Also note that we simplify the “blank line” point. The text says:

    A blank line will be added before the new trailer if there isn't one
    already.

But this isn’t quite coherent. The previous sentence says “If there is
no existing trailer”, so we are in one of these modes:

1. discussing trailer blocks in general; or
2. discussing creating a new trailer block in particular.

If (1), then we shouldn’t add a blank line before the new trailer if
there exists a trailer block already. And if (2), then the “if there
isn’t one already” is redundant.[2] So just talking about the higher-
level “trailer block” simplifies the text, since we don’t have to worry
about the different contexts that *trailers* can find themselves in.

† 1: in commit “explain the format after the intro”
† 2: Note that non-trailer lines don’t matter here; if you have a
     trailer block consisting of `(cherry picked from commit <commit>)`,
     then you still shouldn’t insert a blank line before the new trailer
     since that would create a new trailer block

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Tweak “blank line” reminder (“Recall that”) by dropping
      “specifically” since it is redundant based on [1]. Well, I
      thought I understood the feedback here but reading it again
      today I was confused. @Junio, did I understand it correctly?
    
      My thought process: This “recall that” is similar to other
      “recall” phrases added in the series. They add some redundancy,
      similar in spirit to 74522b6b (Documentation/git-update-ref.txt:
      discuss symbolic refs, 2024-10-21) :
    
      | Add a paragraph which just emphasizes that the command without
      | any options does not support refs in the final arguments.  This
      | is clear already from the names `<new-oid>` and `<old-oid>` but
      | the right balance of redundancy makes documentation robust
      | against stray interpretation.
    • Msg: Editing the above I noticed that the previous (before this
      change “blank line” explanation isn’t (quite) coherent. I want to
      explain every meaningful point of change in the commit message, so
      I dedicate some “also” paragraphs to that change.
    • For [1] again: s/Concretely, that/A trailer block/ since it flows
      better
    • For [1] again: Fix mangled “The trailer block is by definition”
      sentence and make sure to use “commit message”. We use “commit
      message” throughout the doc, not just “message”. But just use
      “message” in the next sentence since it is clear that we are
      still talking about *commit* message.
    • Msg: Reflow existing paragraph
    
    🔗 1: https://lore.kernel.org/git/xmqqcxxyt4op.fsf@gitster.g/#t
    
    ---
    
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 26 ++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 616f479a367..a1adab20fef 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -74,19 +74,21 @@ key: value
 This means that the trimmed _<key>_ and _<value>_ will be separated by
 "`:`{nbsp}" (one colon followed by one space).
 
-By default the new trailer will appear at the end of all the existing
-trailers. If there is no existing trailer, the new trailer will appear
-at the end of the input. A blank line will be added before the new
-trailer if there isn't one already.
-
-Existing trailers are extracted from the input by looking for
-a group of one or more lines that (i) is all trailers, or (ii) contains at
-least one Git-generated or user-configured trailer and consists of at
+By default the new trailer will appear at the end of the trailer block.
+A trailer block will be created with only that trailer if a trailer
+block does not already exist. Recall that a trailer block needs to be
+preceded by a blank line, so a blank line will be inserted before the
+new trailer block in that case.
+
+Existing trailers are extracted from the input by looking for the
+trailer block. A trailer block is a group of one or more lines that (i)
+is all trailers, or (ii) contains at least one Git-generated or
+user-configured trailer and consists of at
 least 25% trailers.
-The group must be preceded by one or more empty (or whitespace-only) lines.
-The group must either be at the end of the input or be the last
-non-whitespace lines before a line that starts with `---` (followed by a
-space or the end of the line).
+The trailer block is by definition at the end of the commit message.
+The message in turn is either (i) at the end of the input, or (ii) the
+last non-whitespace lines before a line that starts with `---` (followed
+by a space or the end of the line).
 
 For convenience, a _<key-alias>_ can be configured to make using `--trailer`
 shorter to type on the command line. This can be configured using the
-- 
2.54.0.22.g9e26862b904


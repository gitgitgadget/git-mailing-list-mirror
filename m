Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750393F9A1E
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403298; cv=none; b=VVwBBovBrthgIsejIoyYgd0pd63m3XtrfeuV6P/JvSXSMiC+Dk9JjVF0vfhpkexvolB9DZzWMld+6IXXlEdiNPrHa1TkumV+w+YKYES3AfBIeQcR8VzxtdbCl2mcihDA8qi8Oe1UoPHuIg5E5dBfzj1CVXQE/TkA9kxVyUHapCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403298; c=relaxed/simple;
	bh=nAHWpw9SW5Pyj/jgCdOR0z1EaH3UeH1BBCshaNSbc9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rj0Jy4c1wuoEKIaMqOUeYTuJWkznjEMeEuoO3gogncnJ9W9OJqVfLOKt0weMwurkJoqwQop8xKwBt/BCiEgGgWw3OjFwuzzxm7/YDw4YvqplAiQrCgCAYIIuhTDQNtUmpYnA/QSzUuAmTOuv+gn46V4/o9TNsQ3PdJBjhObTxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WWV5bLos; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mfe9Vtzt; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WWV5bLos";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mfe9Vtzt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8AC521D000FF;
	Thu, 30 Jul 2026 05:21:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 30 Jul 2026 05:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785403295;
	 x=1785489695; bh=QnFi4vyuvXlBJnKLyrS71tWtt+mpZyg41vkn2EqhOxs=; b=
	WWV5bLosN8UjBykikefBBMT1SXFqtWzb+QvCStghPVXuIqyOA0642C97jHwsT9Bd
	1eXDCijsHRiLS8+jPg/kufLVbrhJNViEKbYbUq29wrf0rqHfDUv5LSFxpPyppRFo
	bAUjB1vJZnXQwjCCYW/JzxaeE8cWSBNEY/TqfJQFX40lbZalgpYF4be5o48jIu30
	e+H+m9JM3FB3URyWKRZmV5y5DxV9yYJJLaFTLXXeYs1iuxxoU2HZq8OLUinDuzZE
	7ZR9/zVoymVTLFJTDtxFiDHd1IKrNmGGoVbXP3Qfe2CreHNc3+LpSaAHBClZPlJE
	pFsZ12yCf6W8vodPi2ijLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785403295; x=
	1785489695; bh=QnFi4vyuvXlBJnKLyrS71tWtt+mpZyg41vkn2EqhOxs=; b=m
	fe9VtztMSsr9MMkI7xDVrUepOG+Uz2s2Brw6MlQHxP7w1AjlU2s2eSmaTBiFTIK0
	PlwzVVbAJAX53HhHBN7cyNpQIkOnKNiQqSTLao72GNUgKKiakVU5DF7LJblqdJpZ
	DzMSqiNX7spChsdLY4rPUaJCIbc5q4fEt110zPukO3/sWVXXy3CHyCWaBwf9xX4O
	oBnaHeYzpnYCPrq+vVajzF23uoHM6Qge3KIsunqP2QTNFyKy29FRw/kiYLLiRkHk
	Rm/QIRG+ie3kU3mBKjbIF2eUDn0OUWrNh3ZyxKcUWkbIuCEKmy5impOhFRYiw43Y
	83rW7wW8yQbcpLFJTQy5A==
X-ME-Sender: <xms:nxdralNCsXqZp4AHJ7XyfORJuzKpgWxvsaeT6L72WUqASwLQDVGUCgA>
    <xme:nxdranDK_CvVs2nwYMupwc6GXWiU0ExTLsyvaWU3oEgzr4tuegwwaWFPCctm62PMe
    NW-HDhX_EEoygrg6Z_b0RFEadBT62UfMvf30wHDRnLHOlTTf6mzTBM>
X-ME-Received: <xmr:nxdraqePTyswYCt9i6F8W_Uoerd6dVxcVQ_0791b3NrFOCf3JrUgKlDUEEq__UN7EfaCHxtVPWT_NoD9Gv17qQW0lULONSPl0AfqUTEZMhknkq8OvUqouEg>
X-ME-Proxy-Cause: dmFkZTGEif8V06QLJWp4Tr0XxWuthpDPXu8yXzE/6Wu3CJpYbMgM8lsm5jyJLeAnyrpZvE
    ycYhVYgpkiSon46eDu1/hD+XVIJYbH3Xeb45ZwNPUiCL5u1BeoKbRMXd2Dx36ClBh4cRfN
    3RDdslMGygM6+dnnjdS0m3p0cowhCsC+ewPbJAa763IQffx9meKZsfDOfBPvZRNlWFR95G
    1b/AcIyh8aIPq+fnefmHue4bAAgmxhPORPpGS4E1ADDTPqmGVvymu3hORTq1JjLamGV8UH
    NKlINhhPvBS5G13SWysle528nm5w3Xu9Dc9KfX3qSPABHdwZB6fD+D9CaGmb2OAuaqQ+n9
    bFnqK2moMfaSep1daPjFkRHBmSjm5+rYyEUOfdSFXDbSJOu1aEz4M5KzLdqBkkRpF9ecjc
    cU1RnS0eQt1AzQE9HwB/bYaP8qC+amlVogdn64vnBVak6kZhZUphLG7InEMvKmedpG5cWw
    rbHRJrHPf29mKnas6bC9ykvKTVCiH82MyW3dl7SYZPu4zD7ybBJA+/Ymgid9GkvRrrqjfO
    XB8Whc777K018CMMxAJxX7tTDOrBPq3mgJxeP2STToGApQ3Ys7/zGZY+/9xy9htiF1aCT9
    SGzcYC2DImS80mlwQnaQ4IpC3UT+MCjnqoZyLOzkCUEo4rUxKyf6FjPr60Xw
X-ME-Proxy: <xmx:nxdrauNRzaDKDEH21iVgjCoCejpYCQDqVKXUdtv3vBWHtewQCf3kJA>
    <xmx:nxdraiJegG7wPbI8q0hk0L0LCaWOPkRyAbca5Z51HeoJblosecdyzA>
    <xmx:nxdramKeSoUrHeoS1wNnZrKDqRkIBjuyTSlvReZ05N9tfbqiHONg0w>
    <xmx:nxdrak7MLEx7adBBbUCsvp2M5LXSHn7iGFhKkblx_VDIDc0P5gasLw>
    <xmx:nxdramK6J66PBB5WSq_ru4afJIMxdNpbq4im6nbReju47UqV0mr_FwV6>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:21:33 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 09/11] =?UTF-8?q?doc:=20interpret-trailers:=20commit=20?= =?UTF-8?q?to=20=E2=80=9Ctrailer=20block=E2=80=9D=20term?=
Date: Thu, 30 Jul 2026 11:18:22 +0200
Message-ID: <V4_trailer_block_term.aeb@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
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


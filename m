Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460133FF1C4
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405497; cv=none; b=PwGUQ4WaTYBzRrFeh5R4rkdlsbZhR0UG70Ef7nuWRHJpVZwIR/HSSwZ2qHsfMVLWSzQIktWC2M4QaCdMdi/SRPuPrI8KBavsCTP1N1HpPastTMnrxPzxFzoyCGei+MtXJrnD5Sl6717FRaapyLcx4FSS6WPoRn5dCeuPpxZlUNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405497; c=relaxed/simple;
	bh=xa4nSb9oDFnekSdMJuO7fGUQkT7FLWBZPqw1WgY9rzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gx/DsUvNXG20iqcF9Tgn+CpD4PIVO1qhhpzHiLE/D5L7++tY4jmhPbQAMMZs3iJddmXAxXmGf9GlbK1qng8cJFGwSg8tJQQFWXcXIxxojk3Frp2XQRub55oewJJk7CtBnyMzeXKmx6cMHLj/LUi2OlpAp+g0+Xzwze2hQJ1F8ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pUJa1wmW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bqOPZfLM; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pUJa1wmW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bqOPZfLM"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 732A47A0015;
	Thu, 30 Jul 2026 05:58:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 30 Jul 2026 05:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785405495;
	 x=1785491895; bh=MswN938MnQA6dgSAqPNjBT2yIfMt3cEwyYqYjDUP5VM=; b=
	pUJa1wmWxpbpt2ALRlJfFEwOxJMgeR758x7S6ocy6Nnrbf3ufIhvA1m1SeJMmC1f
	vJQgFEaSps9pRBiwf3/vW9I1j87BSkmaenxW5q37ai/paYa1Cel3ceMUYuARWieq
	z7+NoLIY+VRYqLu7lVq569h4jTzZQYLlM94h6KZoHdAEDQaBbo0JSedI8uMf9Psz
	Hn/Zp4yHjli3ohykbPRHJ9DdEemvoiVF2zdwIOU9JpFhqrS6ibwExYhuTmKCM5+V
	4PpmpekeG9hWtKpj1VINrURK0XE4JM01i7aFPZPipqt4nISlBQNS4ZUSuLGA2eGv
	uCO9NEu2srcBqpU8ctfmdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785405495; x=
	1785491895; bh=MswN938MnQA6dgSAqPNjBT2yIfMt3cEwyYqYjDUP5VM=; b=b
	qOPZfLMrasrh97nSNBBzgFe+r+o9SGKTzOyi8/Vt70o+rAscxJ98paN1E0AOJDZa
	CE2TyjTmmJOr0RR1vhrMhlkHgaRo27pYENtRJv9jiXfx15gbJpbCkeo7DnXZT2yZ
	ZV6pxE3jcRnTiUO4Zay9Jkn5DwsUOWwM6mDHH3LnuIb1flKG+vpabVJMJfAFvm12
	q2QITTDii6xIZ6b1tdGqMH2pgIdYiwfCX0JvrY8ETgth9LlvnEK6EmWVYIsHnh1O
	LYW6AwMXK8PkGC7kEg3HG9RtPco+OXOwWSk3wt9UcgmW/FecMkeMg2bGvphnKjz3
	2GVHSt8Cmmr57LPWKawhw==
X-ME-Sender: <xms:NyBraregwfimaJHeLsGlOlmhQO9dlSBd72dnblIDy4sM58IM2JGCkr0>
    <xme:NyBrapoyTQT0C489FLZgxs8Dv9gNXoLtvlEXQ_RugZXrhFGUxswV1SQX_OeQyK_gP
    Nvx0czasi_Wnky87rH_IiGEZ8xngsoDFRB_TDiVVUClT_caC-SiUQ>
X-ME-Received: <xmr:NyBrak9XOkblvTFFP8OkBsdQTKXk7ZuqUQd_-gyTR3dhc0qvpAGF_8VzK950WbtYa_RSa6zlQUlcXy9O52La7_n2DYL8s52AK32sormhg626Cvt7DJmurXs>
X-ME-Proxy-Cause: dmFkZTFZNRIWvPBprmPCA0sDPLcDU11C/BPtTsRb3gG43CflVo6Mmd/UxNbAKH3eEFzIUM
    Y/J/X0tKNfOBQifE7aQxzJpGbfrhJMFH69cHHqodvVnCNXeY37Lp3d0Bi+yd1tjkarvIl8
    ZuZvIyuijuoYZ/lYLurSKlyliQdkB6EJERcKD647FL11zzkUsfBSkHQap6XiKsWp4xpvb0
    6opD+4oanS8PcSd2wHm2jEYrbU638EcwD2tpYlc+qZgv9CQHnJDEo1+loZbbNaz9LFLSem
    J+JgM7qjaxQU5NXQ/lnubMiFLpxkE8h5TMu8ZmSqUKb9pf2znTN5SFS2h+oDySdI5aJvnu
    SY6Tbxuqs33xZn9Ob5vEzOjYc6BZsfggxT+dnAwXaG0nuQqipbo9QsIQGFHxhihfviAOxY
    ydwMjyJxtXSJYMnJUKBXA6l9LxTfZ3HPpDR6cjMQM0G4TYsX/q0x+s3Aou946pe40ctCB5
    MN3+4DF3h/H3qd8Cm8gAwUQCbUfWFuHki2TEGbo/S2x58uyJsL4eqTeEbrmSJhAXCpQ+e7
    /3I91Nf6UmhuSgO8Wanopnqcv7t6fllvrTDZze56rUwfBSCg23cPTI/3jy6YeFUf+Sji+t
    cMHJcYom33WkEuaqkCQnG168L2RFVu29KAERBJmxiVOLtiaD5dQvl8T8OY7A
X-ME-Proxy: <xmx:NyBratf1kbZ0ytMGk4_53BpD31l9WpQO-qs2hc4bk0W7FBnBE6F_WQ>
    <xmx:NyBramL1aIJus2GCr2RdIb8rbQJn0WPLnwF5UV5T1tKLlY4Nr-W26Q>
    <xmx:NyBralj9hhNewtPq1Iq9L_w0VeuoZFH5v7vL8uzzswuqsyZqTyszuw>
    <xmx:NyBrasTyBHSfcxChN9OiTGQDd01TZRn8agg315mx0EMgdaxwVpC6FQ>
    <xmx:NyBraj9cKrKHSOlolmag47V84sWme-YktHKJWkpBcYZEzYHQ2uZzfNQr>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:58:13 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v4 2/4] doc: replay: improve config description
Date: Thu, 30 Jul 2026 11:57:14 +0200
Message-ID: <V4_doc_replay_improve_config.af5@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V4_CV_doc_replay_config.af3@msgid.xyz>
References: <CV_doc_replay_config.709@msgid.xyz> <V4_CV_doc_replay_config.af3@msgid.xyz>
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
    v4:
    • Avoid two “for” in the same sentence; makes the sentence
      flow better
    
      Suggested by Toon: https://lore.kernel.org/git/87cxwxofgv.fsf@emacs.iotcl.com/#t
    
    ---
    
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
index 7d549d2f0e5..a7dd5288553 100644
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
+See `--ref-action` in linkgit:git-replay[1] for details.
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


Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60C304976
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502716; cv=none; b=A97abSN5olncNArl6SH7ax9oyB/uXQD6DPQhny29+0UxTsYgXqebO6X2QY+Mdwhv11WS2bPI/hzqDVCHMh9EoweHXm1LZFRrvFHp/LxwldVJ/+/Ki1CUX5WhDm1iKSLFSJAlJq2uuBkh6xDT21uz8TLlHnhRvWs18oQUvi5z0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502716; c=relaxed/simple;
	bh=1sZoFGURYkQoV1YKc4mkLkDfdabJgiKoDNRzn5PUSAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnfDtFsQC/UIOr2UctxKftZ+w6eJyzOnYfwduiubV4f/+GraenqMe0L3Dt4b3IjZ11ctrJVlJzwkOrfueY/X6pA5EyZBOWYRs2LK9XCMGVHtO702d1+wtO9xh3ibhzcga98B7c0d53s5oWwnhaSKaXL70PLDpSd2Z8Fo6FVvjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PGQa7W2T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MTtUgsTK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PGQa7W2T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MTtUgsTK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 92DB67A005F;
	Wed,  3 Jun 2026 12:05:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 03 Jun 2026 12:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780502714;
	 x=1780589114; bh=1+J7HI1Lp63CWn6EnvksM8kw5nRhNx6/tFivCQ6MtuM=; b=
	PGQa7W2TdSegYFnRtwAmODYNdoJldaP65bEWw6STmVXvQ8RZVbmwid/lFop/8w3f
	6vmI+XizqN9j9lNIyhX32JMVDD4wKkc9l0keSwepJfUKOfsWomyQKWZqKc3UT6/e
	/MHdIk3EtNjqS0+Nsbp/+fY5ZWOrxCrz6dUiElQj6PrR9PxCKgUh9VzkxKPv6VCw
	R+fAXbai3mBuqHdQbbs41YDM+8Re3KpyK7dDZo4khhEKa0dHjpmKg/H7ePuklope
	4bgNECQ8Wo/0D9u0+b7j3cKMBjI0QcYDcRqsX9hH1azCEJGmXsENdGsXNDqBk/v2
	t577HQN2cWG0s/7p+NKwog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780502714; x=
	1780589114; bh=1+J7HI1Lp63CWn6EnvksM8kw5nRhNx6/tFivCQ6MtuM=; b=M
	TtUgsTKb2/7NORs3MQERQ8CzU4FK9dGHEXETcgWtIyGWEQ5tmTE/VU1piuTMgRVt
	0ehQxbF/IwO8RHQSivKiXTt1Y/kEtBS+jrOcSNWFzLZ7CiLY0iRVtvFOBzicOBfN
	v19PUOs/NFM0yViPw46/A1T+xfH+5lY/w3Rm6JOvvBy8SqPP6CLqa+Bu11YcTLVG
	jdmPaka4Vv1qf1QtwaWR28hOsT8J2b7qaY2YQtEal3ibd2l1C3EqC6UBF+ZNFmcy
	jjIrhyHFCTB6DK1244vGpvju41/zxqWQZLLbXf9/TuGT7g1zvnHctMyLFXnDhpWA
	OLtIfvo8qD+SfWpsOEibg==
X-ME-Sender: <xms:ulAgarTetAgQwdMYGi11Vq-I1fswMv__ayRNmu9rSs9iddPlwSoUDqI>
    <xme:ulAgajxLN_46DhdxHaoCwTaT57JMX3KvJwZc9m3oDvnWypCCs38gvc-nfrf1K1Cs-
    jIN13V_JeY_v6c-bnDlGLQioLtTew-ITboBvTUiz1I646HTK2iRgg>
X-ME-Received: <xmr:ulAgal3-XLxKvVOBnBQU5jSQSMq5Z8OJj6xBAs3HwNOe5eLrJCuELmCIB30NnFjb0UpoJ3iS8r3-W9hXVWCd7Pf90fzM5jlm-smXI44>
X-ME-Proxy-Cause: dmFkZTFBnHuhQocGhNR3wnteGW0eB7gMQ6zFxf8jocqy5zqVQXLKCvfdvnfGeFTu82Wybz
    SAtT5q2hFB3NpAesYJAeqNw7REUrj6oUruvF+ifl29kHCZ5rytRbLXeiLOyTd/MksV1nKK
    gRMxQl0HmIPlwbD56e3wczxxaD7BYTajM7eKmgjodPCjFjmqe2qgC56BNexz/M6ErsCVDg
    Yylx54sNG+Jes832AX8jIWqd1r36wKJ9oAffZpI5kk7OcC4Rmigf6sEgSoWHGv8pEodIhh
    amvoOutxoXvU9VVCyDwcWHG7p0tTE86OjQ053zpbJUkOGT4ozLXFyT6WAbXVO/gWTZ0Rlc
    Mw9xNkQWrrF3mJCFiWuf97IZzjJdVHfud40KH/dBE4Zl3ZblJcYcADai60FX6VN/S4muFn
    A1QxB3xpdC/CoCl8eerAVnhbiIuzzb4rTHxd+Dp9xAtYzFbJ+OuRU06nHK/nlyhdPGDgB2
    fOknJSDjnvUedG9WxgO5dDk6HcrdamHCptBnO16fsviVBkD5kCTITAZNJfXMtOnxYaPbOL
    nW8KbeZEwNISovmWbEvdDQKiw/gWvdQbqcqZO2QZJWAXwkMkiTRCP9DWessElqX/IBKrdE
    3JLebjWiB1l3pR6HumZ1m845e2JiICrx65FAjkGTFi21mh3Hnsx7mv2kpSYw
X-ME-Proxy: <xmx:ulAgap7p-7wr2JGqMXbKLUfbZR9r_7EL15DOk6nXauswrMUC7uZCOw>
    <xmx:ulAgagWiD9oB0Vz7YYBd5VWNPgchv9ap_kAow0D7QtzpJT8WqkMoTA>
    <xmx:ulAgagDIauW7xdWneAHBlGqzVLkeoYRWQWGc3Sg6rhZIH_USs0Ki7Q>
    <xmx:ulAgan47EoaUJqsr4c1F9IiiZQmBLbkJ9rU8T4SLVzWAFxzB7dBZDQ>
    <xmx:ulAgatXaTbt8fr3NA17FdaR28Manm5ztlj6nnC_v0Y7m48639QD7Resi>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:05:13 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v2 2/4] doc: replay: improve config description
Date: Wed,  3 Jun 2026 18:04:23 +0200
Message-ID: <V2_doc_replay_improve_config.769@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V2_CV_doc_replay_config.767@msgid.xyz>
References: <CV_doc_replay_config.709@msgid.xyz> <V2_CV_doc_replay_config.767@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

First of all, this bullet list for `--ref-action` introduces a term with
a colon.  This is exactly what a description list is, structurally. Let’s
be sylistically consistent and use the description list markup
construct. Let’s also drop the harmless but unneeded indentation.

Second, let’s replace the inline-verbatim `git replay` with a link
to git-replay(1), since we are naming the command. But make that
conditional so that we avoid a self-link inside git-replay(1).[1]

† 1: See e.g. e7b3a768 (doc: git-init: rework config item
     init.templateDir, 2024-03-10) for another example of
     avoiding self-linking

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
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


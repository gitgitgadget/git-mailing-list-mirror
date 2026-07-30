Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D4C40801D
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405461; cv=none; b=t7GkI9TOMKrM2h0ITIhjiOsxiPqLX8+sYfru5rPRjIrkbFwCWTJigf8JYeM9AG6G0SIWk1RlOfT7voMHiqiOy9e5hjLN4fMiLS+KsOHTuiuO0jDAK1yhejTF7El5Kt6Tt5j7z+GCe2ioeKWYNSQni0JoGrMkY9GUuCJ8YB3NzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405461; c=relaxed/simple;
	bh=QgR3g0AgRWHuuA8c44b/ptw42wpFT0t8PV5xRt/503M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZXL2/OkKxMhsSrRpdLau9cEoNG1H5Au3DrDnmPvIygD2jg4amAdUogH0xnC2EPkZECUxZQqa/4oyBHL4kbJ+nxACWSUzue3i82UzygGCFsmhLw8eQglRcGjx5q4yOIA4fiOki0B9wMl5LeAdaeBVgDHEw7CgoQOoO+h8EmrGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WkEFltYd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TpDHeNdI; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WkEFltYd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TpDHeNdI"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 743391D00100;
	Thu, 30 Jul 2026 05:57:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 30 Jul 2026 05:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785405458;
	 x=1785491858; bh=cEar4k6SntiFXqeLTqQt8k9Kyfb1H4TEh36fvwYLqhY=; b=
	WkEFltYdrFT/ybEDjbMat4lpplQK6EguZIwOs7BXPEbjMbRzpYizUx5OQ7a6nJry
	EP4SWWVFYvxRNOaliNiYEyZWWSDhzlXdFntiF6Q8czAARTXtgB2U5Q13bH2FYHNa
	osRfSPZnDCr1NHxoD1iz8WzaBm1MZ9kFiSR6NGtB66yJbvhCIJU6bfuiO6MQNqib
	iyX/qezUueN4LwyuDfK7Z6XCNVkja0xkgFTFKR5JiQN2oQFfO7neOK8xRifl68O/
	F/ndj8jU73S3qvVdJ7SEEq5q8i4oOnDmPIAjLYX2dSjvVD7acIwWUimvQ61GpLzG
	wqhV6xZolnMgdBUzSXGjAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785405458; x=
	1785491858; bh=cEar4k6SntiFXqeLTqQt8k9Kyfb1H4TEh36fvwYLqhY=; b=T
	pDHeNdIFfeluII1wqBaJFLwaG9IggQP2WRfmAqbw5rlzsv3hmIu7ZI/i+PcDdxCL
	xKi4gde6JzX5lLj3sTw5/4qL5P5+lTv3BnLuz3SOvneDvJtGBjp6MLMw5/0d435x
	DmjJ8FqyO/BV6LfzA4GGE0V596UQ2cckp4ohmX99j5JZ8LGa72j97Y+4qNWlVcNK
	fidUBNPeXq8icL2JKNaF/gdc6ok0tS01INfXHiDVk1ApIF+HvjSu8YNAB7ZcQ/G1
	1nQLrzP+ryUSCU8Zy/cuOTLIIsoXehFwTVT6t995gb1KuismvTPAoZJPz2HDeucU
	YO/PE1OAf/M2f3cTmtg6g==
X-ME-Sender: <xms:EiBrag1ulKfS9JXVACnig4rqoxF7fGfOCvVSm10TzcgbQAFz_kmicGM>
    <xme:EiBrauzKf2az-VOYbrnsL74DlsfdVetfB0P7f4OUMzIrTV9gDd5HMDOPAMPE04Ez4
    e8hJRibVogOg_rxauzcK1pMLPHXU4fUJnLIx3SqHJVC0xWiwfWW>
X-ME-Received: <xmr:EiBraivJDHc-d5V_lrutzFEbqciI4mPQJ0kAc6ErZrJ7kpbU7xKnwhMkdhKimSSTmGJqBlK-k_f7qhyg2yrspdGgWvL2cPWEGqCJ9XZV_HX04hYdwFF3gRo>
X-ME-Proxy-Cause: dmFkZTGB8StpLFNLVqCn8xz9GjJMozaotnEpm8N1blLd9eTku0azoa0kpy2MAlCrGsAzBz
    DfX3nwhUEmk9pJ9y8TU0Z+cO9dmrlMrwzk8huPJiZ2GTo3Nb50Aroq7EeyvAIRhZWutI/i
    FgJNUGf6MDX5TRSZThEecEoUZCHQh1h7UUs78kv6AWDZtLtMXYCizt3qefPw3xRgmxJZfe
    RDU0kNTqTU4HjPGQ9V7fYdkFyjQD0RGT06Do8CoMYocg60Tlj3fbMwgNEVXgPNdXdPR82l
    yc9Ti+V7XbqT5TlUl9Y6YmYVWSdpmjewNMRzif2CAT/OT4wrtufVn+yAgQjKLZANztdskB
    mGb3AfV6rZnUa9VoKAS3zzBveKlB0NULM48epQXITwGtg+TTRAct/4+5c2e4+DXQNM6dcw
    S+eOr1UExwT2Rx7SKB1YZazSvH+OdqO9ddK1YFQOdT+HBO05mBWXMweDRmWChE+nQ4XE2r
    SOZWy2n0+geQHCOyrj1P3wZTcLunyTu5UeXoCCwc4aKAyf3DCUZGQi7h7QXBcqnoj6MIUH
    T5mx0mAlgVPlAIRjoKa2GojE/bfXs5xogj9iWjYKVjKpgiBe7uzlkSPVh2UXWHdkWxiyRl
    vvDzxxpprdHgki2ouUGRbvtL2q5rkPy6Zfo2FilXYQEHGAShkxynF4+NCOng
X-ME-Proxy: <xmx:EiBragy5v85V1UK1wbjJwmO1frr0Me0i7X7V2tu7zCN70HF68MP8vQ>
    <xmx:EiBralBhaK1hdXAGDS8RTtjRQP585uSEiwyi5MxrIPS-roWTrgLMPA>
    <xmx:EiBraudtz0EHyTwKMRUG6c5RS-WnlEfOWCftaX2ksoj2jRCW1s79CA>
    <xmx:EiBravnLCxO_7Nhsznu0wWOjeFnIExIjeZXqLKkBIRKs8jQvMXj-vQ>
    <xmx:EiBrah5hCvr43dRpkor6QaWfFKErx-dcrujRyX5Tox6xax6McvpAQo9V>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:57:36 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v4 0/4] doc: replay: fix config link
Date: Thu, 30 Jul 2026 11:57:12 +0200
Message-ID: <V4_CV_doc_replay_config.af3@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_doc_replay_config.709@msgid.xyz>
References: <CV_doc_replay_config.709@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): kh/doc-replay-config

Topic summary: link to the config for git-replay(1) (one variable) in
git-replay(1) and git-config(1). Also improve the doc for that config
variable and `--ref-action`.

§ Changes in v4

Patch “improve config description”: Take Toon’s suggestion about avoiding
two “for”.

§ Link to v3

https://lore.kernel.org/git/V3_CV_doc_replay_config.780@msgid.xyz/

[1/4] doc: link to config for git-replay(1)
[2/4] doc: replay: improve config description
[3/4] doc: replay: use a nested description list
[4/4] doc: replay: move “default” to the right-hand side

 Documentation/config.adoc        |  2 ++
 Documentation/config/replay.adoc | 19 +++++++++++++------
 Documentation/git-replay.adoc    | 16 ++++++++++++----
 3 files changed, 27 insertions(+), 10 deletions(-)

Interdiff against v3:
diff --git a/Documentation/config/replay.adoc b/Documentation/config/replay.adoc
index 40d1695782a..84e17e313a1 100644
--- a/Documentation/config/replay.adoc
+++ b/Documentation/config/replay.adoc
@@ -14,5 +14,5 @@ ifdef::git-replay[]
 See `--ref-action`.
 endif::git-replay[]
 ifndef::git-replay[]
-See `--ref-action` for linkgit:git-replay[1] for details.
+See `--ref-action` in linkgit:git-replay[1] for details.
 endif::git-replay[]
Range-diff against v3:
1:  ef8212a076a = 1:  ef8212a076a doc: link to config for git-replay(1)
2:  35b44b922e5 ! 2:  392c4f3ab9e doc: replay: improve config description
    @@ Documentation/config/replay.adoc
     +See `--ref-action`.
     +endif::git-replay[]
     +ifndef::git-replay[]
    -+See `--ref-action` for linkgit:git-replay[1] for details.
    ++See `--ref-action` in linkgit:git-replay[1] for details.
     +endif::git-replay[]
     
      ## Documentation/git-replay.adoc ##
3:  12c73641fb9 = 3:  a693ab0b6d3 doc: replay: use a nested description list
4:  e2191c723fc = 4:  53663bd54ed doc: replay: move “default” to the right-hand side

base-commit: a89346e34a937f001e5d397ee62224e3e9852040
-- 
2.54.0.22.g9e26862b904


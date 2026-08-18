Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F1026158B
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047090; cv=none; b=Rhm32NP/onFAtVW3qKpDoXgA3jQF2A++YBTxvfdi5nftrAJ4GMh7ruhbuWhQzuh7jHsRP1JD99mxRI1qjPdcOnNcwZajnWEVkpAbqGsQN4H9u0pUc3MNOu4hk/DcxJFGfDHfMgFtOSD7DYjzFk/kNeJFBjNdL6g2iW7v81IjNp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047090; c=relaxed/simple;
	bh=6+onU27jKTQPi7EMHv+NvYvZ2BRBkmcy3/HL1OgmxLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2mBM4HeLA919FsY8vI4C5JVipKWQBU3AIufMgtUXH09rt8yDKps2u63mRNa4xsQ0r/YlMYdfTmQwJUmhTWDp5axM4v2/F+hMjK7I+K8VYgrS1jkgurpEQjLk+jI9xlv/xsiCqd0yQmLgHCXslTpoXEkDxLTatA/sOCZqNiNSuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cqWOYb90; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GsbxeXCW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cqWOYb90";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GsbxeXCW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 79CDAEC0250;
	Tue, 18 Aug 2026 05:58:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 18 Aug 2026 05:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1787047088; x=
	1787133488; bh=QTVgrCI7qW+koIukKgT2VjDD1iriwAkEGZUcxUNh6Ew=; b=c
	qWOYb908DcyxUrgk0gwhM32AJ0n8nO41S4AIMFr8TSBWJDCoVxa67x2e95vjpues
	5eZAhSPoxk9S9box+f3XDscdl0rX0gKqm9G3IMp98FU4vkfd11oSCBZMHn8oSI08
	tZkpzDeYV/SXFvaFjmG/Lx62NK9dFC8ZTYmj6sr50p3GVxbcbJBeJK+FdPrxkmlB
	cPTOqDycV9hrC9tORRvK5MmuYMntB45pWCL5bVYQUp+zlfJlE9oNiHIQYZqnDu41
	NxWizxjFIoTFmlY+2OzPc2mCXjtw7e3Hms7T9U4t3Ah8zKIWm457FMejHr8eHgJo
	foX3jAWUdWF/YA3N2TVFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787047088; x=1787133488; bh=Q
	TVgrCI7qW+koIukKgT2VjDD1iriwAkEGZUcxUNh6Ew=; b=GsbxeXCWj4vdRDe1b
	aATo0fb9e5J57vkEsXn7NUwUqpyZrJkYd7/STX27K23TXcY2DQpQWGlzUwmpZqXk
	7Mu42Hov2vg5shrB+nOyva1GDMV+duJl+pxIGhfUqIWwpnjGbqYlL2jCDEfaoT9k
	Ij/5+zhxSOhZboeAL+5rZpLOvVZXesRF9CFD5RDmU1uTXHfb+m1ryogqXjQjL9Me
	S/0LYmcJPL75J8ofqxTt1ewgyIr1srYxMalfQDy1DHMeujjCTbfSJacPW83KDbJM
	QuRFtfLzC3wxhqbGnoR3KQUP8efpm/RZaTMa8EGlSY2sj06au6jclm4Pzm+fpzAz
	tp2Ag==
X-ME-Sender: <xms:sCyEal5wj2-b1Jli0m1g5B_ffoRnjo9Kw0HvMPowTW4jDSXiA9kzUJA>
    <xme:sCyEao7rQlI0k_4DFDugwoymMMXzJG2BoSYWg7uLHAvUkHGx3ZB1aKJgdw66k7RgW
    bJ1x_GxmGKXcalZus9_MHbgiv9KVlHwyLuhgTXWugpD1sHflmLwKA4>
X-ME-Received: <xmr:sCyEaqHVUKVd6yyqeoyUbY6RJpyVTkbmxPnC5lqdilpChIIRHxmSdLmzKV45Xhc5yO7A0CPRNjyH_2CFgEj-PHEfed4q-Nur6BZDo6c>
X-ME-Proxy-Cause: dmFkZTEvddRz+E4NUwK3NvoRmDO/5cfuc0bGITB/nfQULe4GxU/uPtNebcR/W7KQ1wIVrN
    mn6gsIGzIi48AIuGBRxM6U3ZBeu6ve9HbVmGKQ22SG2gG8Q3eVh1cXGkbP6MNUCtOBMItn
    27ZvU9KElbg4IsvC0bCKFTGZqYZM/oDSj8m/Aq4BVbrT5AvYft72KXjHfkFKyruBc1P1QV
    Hj6i9q/T7T7oddTQaWGPLQcIUm09bqaZKjYoWWlgAKMDFAkVzH4BpH7RPdH/by+p5Qh1Qn
    9DBe1yhFZLKvgoVoi1vdRVbtuIWo8bLDSTpe+6t7vSbnAqxvMR9nW4f9yKZdl0SXaxSdrq
    ajLqNahRUm4YonBT80sdP5hYFDuggXoUmZBI76/eeiD3/E6BSshYjZq9YiRXCa8gAsIGwo
    sdAed4dMINDJYAh6N/GkJMbJS8Qo2P+YkzTbI+Q+Wp67dw31VHyLiEDqcjdwXVlQz/xRXt
    7RDwnGBsS+YAk/2lNXeX1s0ZmGHzPZy8SfL8gW515qjms0EhL1azHcYfSMy4yTZHgM8qRm
    J//mqWClDaX7DJKRwCTeKtZHzDAe6dBSKsgsLuENeooLanTQSb14ugFtt7WdMbi9GF2Lx7
    OqnQ8L6XkGlWp570G+k0ZYJ13i+/3c+p8NbCgEzsxP28+qR+ORHloHJ+ODTw
X-ME-Proxy: <xmx:sCyEapTkn7lFmczjNh87UhBF0dmTzbWqWZ-gmQaB5gGVw3v8Bndweg>
    <xmx:sCyEarvIp6oxiMKh2SqELYJXEtNOxvERD8uCB1a2la1mJcBFBa9dMg>
    <xmx:sCyEagxlxDu8RAy0nknZbCAWWlqoqYUKQO6ngzpVN7VU_vbAmFbJcw>
    <xmx:sCyEat6ADFBHRY2VA56o5n1PW-10A4LUcN4vwKw1FxbS-imcrsYJQA>
    <xmx:sCyEapQFakWRcDmM3MkjE4EFKWB1eFHqajC_1Yj1hp7qP4iRGT20ig_u>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 05:58:07 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 1/5] format-rev: use lower case for opts description
Date: Tue, 18 Aug 2026 11:57:30 +0200
Message-ID: <V2_lower_case_opts_descrps.bd4@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <V2_CV_format-rev_three_more_opts.bd3@msgid.xyz>
References: <CV_format-rev_three_more_opts.b80@msgid.xyz> <V2_CV_format-rev_three_more_opts.bd3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The option descriptions use a mix of initial capital and lower case
letters. Lower case is the correct style.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/name-rev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 60cbbfb4b7d..254c88199fd 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -833,12 +833,12 @@ int cmd_format_rev(int argc,
 		OPT_STRING_LIST(0, "notes", &notes, N_("notes"),
 				N_("display notes for pretty format")),
 		OPT_CALLBACK_F('z', "null", &nul_data, N_("z"),
-			       N_("Use NUL for input and output termination"),
+			       N_("use NUL for input and output termination"),
 			       PARSE_OPT_NOARG | PARSE_OPT_NONEG, format_nul_cb),
 		OPT_BOOL(0, "null-input", &nul_data.nul_input,
-			 N_("Use NUL for input termination")),
+			 N_("use NUL for input termination")),
 		OPT_BOOL(0, "null-output", &nul_data.nul_output,
-			 N_("Use NUL for output termination")),
+			 N_("use NUL for output termination")),
 		OPT_END(),
 	};
 
-- 
2.55.0.13.g85d2d65e389


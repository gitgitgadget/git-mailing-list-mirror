Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD840D580
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126668; cv=none; b=drX7CqqAgIrhvPNv2VHKun+T0XLya+k8PHcfpu2laKfUXCqq+1WId6fa/W/lmrhvrM101CQMZ374bVTiSwt2RnZxyiCTFxKgWcA7ZzG6F6GChQf+iJ5uuem8yfjs51Y2XU4/aKCpPuU4BClV0+gO5UPImU9VNUQP+B3b3saD4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126668; c=relaxed/simple;
	bh=Ti3zJkgEht4zK9tD7VuuhXRyfDPl8hDP3NO/fHLoprE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyQZNgWhUvZaR0OcBoBsbsNuavaT10npGJM1KKEZlv2cILQMboGEafS5I4tHuKpDeHBN+Sv3wXy5mQGdIw7O0ZFf6UMAie1mjjGJyw00t2NuhgKJmr6BwzIZcQsovX8mT7XDk/IkNpRAglL5me93qlN0yl3b+aBiradsUZ8y7/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YwDQRV6g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gOxQEwyB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YwDQRV6g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gOxQEwyB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 429461D0010E;
	Wed, 10 Jun 2026 17:24:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 17:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781126666;
	 x=1781213066; bh=j80UmU+fsh+sDKj3AIHdYe+eMeTS0ORcxKyrRcg46WA=; b=
	YwDQRV6gr1dcjA0ZXxqH6vEYNcj4Ljjzl1XsVmB0Dr+Tq8/xDHzfCf6gBqisrBIh
	9SPGNZfmZXrls8kSP86uslWV0z5+e+yEd4/a01Q8EAcbdNxMRKQ3T3E9evT88zlW
	7PjXgxKczaO8XEvQ3jhpK9OjE1nsv8eAYrpHi7Cj2OfWR9MJyHYGyZFk9LtI5YNK
	QaOde3n0ZrV/b/toIscyL/SmH3QLzd+yRYMMqSEIz0vBhHesAhLFHTiG8kW/MBgr
	3ymcfOGA8pBVOzIr2ddjx+TsKiBIevfkRhmhyL/ZZCozEWH2LtL9B5l7OH9Es76p
	Tg+TtwgNeDBr5LOuGOEEhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781126666; x=
	1781213066; bh=j80UmU+fsh+sDKj3AIHdYe+eMeTS0ORcxKyrRcg46WA=; b=g
	OxQEwyBy/WEsx62zbZvNa/qSxhUNH1gfcoroqidtm5zIHhDMjBTxnD36lXrS4ntR
	1HDdbVBEQpPE35UYvOmM5zOFmbxYgfK9umviYO/7VmY5yUDMCCHPMgm3F/lxCDqV
	ZYsK0JAyZw/sWtWUU64ZQffMNQRwus7qWR3Ho25/XZY1Q7IpnKff66Onkkfm2fdU
	iR5mqbVTvMJpfH1gMApViSBHt9cnEtf5MCUS/Xiyl/zgvTQpWMcbfuO66SpkeROY
	TMQgthVo3ihFTWQ+/fP0zEcsiMm6aMwsMz8ds1JZkRkigVh+DAIs5ZoXkYCWXJCB
	dVYE4Gr5klD2Nm5CX3ckw==
X-ME-Sender: <xms:CdYpapBpRSPWnGLbebPo3y-jTn05e9nPaHT4j-HTZFK2kb4QtEjcJCI>
    <xme:CdYparOTlont-fFKdGDc24ZWH-j9VWty6NaDdBeObghwt23uvGFobyROBa6wQtFte
    6BdFF-21Bq0dqcCscQf1tClPzlF3NS4lJtJOuCEcXLPPV9cGcN4tg>
X-ME-Received: <xmr:CdYpauYPl4mGjpHNa54AwTuMbruO0nuZGza5PCgE9DgG1Kc3rCKqALVgdQI5s5kCkJqwFExTfcCnb38YCSnPt8gNsFgC8r_kT5mmiKJsGlt9-6waBSBfwpZe7Q>
X-ME-Proxy-Cause: dmFkZTEDRODY6dncr8bwhGw7lNbUcvIuw71usLJEASv0TjdvNKHZWp+zgcK79ciH8LAFkK
    RjGz85sZ4jlm9hztF50LVadJ7XfD+Akj4xQSajRCe4XOSfLcDlYpyRl+pHUE8YBho0LeVr
    8ZkkAuPQOV4M/Guz5wr+pCVS3PUyAcesj8ZI2ljgB7D4ViX1RlPY+MJgJYgDp0Z34iyso0
    7+KJAy495+nDsA9DgtUpI5obFv+GuNRc8dX0zRAHU8I9HbcYfMm3lefOfiSmf3Rdv0oCn2
    1FJOfyVqDrXCnv6yDq7SmQMBU67V+HOnk2WDN2OHXFLwqgp0GflLmxfl8F9XPyxzXUAXlS
    EbPPTxonc7crXTEpYdHJEUqigijfiGY4BgciM0MdEGCNiB6x6HmPtsAXHzjnUewcsPOPD2
    P+GyIarrrfkQ20u3axFu7XODW8sMH0+P4LSKWKrwlheSWY5+2pEd8F0j4S9a+aWFxXiLC9
    LbOyJpKsrj4zyrkVYxh/HS4ZW24PP/yexZpVFdnA1RZUT0sQ3u6ELakBwD3in0x+28+ORZ
    wrm017fgG240gtrqrUsGJLNwAfMJqpbr4Wz2upFTpo8ifqVTMMa/B1zfr51sWnD8Nx35m6
    QpghBHW6rwXHWKumVWXxY+xjmXWq620euA/KLa9C2yR8fgibrvLpF4Mmib9g
X-ME-Proxy: <xmx:CdYpaqvYj03FB9BVpMw2uoFQJ37WsaPpncG6HMjswFkSFCj9c2NHfg>
    <xmx:CdYpagOyArHyXWJuI1s9isZCq_xErCtZsPaujjDxyh8-Qq24D1odww>
    <xmx:CdYpah6cCA4LeOgfUOGWK2h8deIZUHiQFpLGiRsWmzekNSmpXqbKpg>
    <xmx:CdYpamTjnbOLJ6uVJxn4-IUP2qDWIGbRdKt4d8UzGV__tR4K_f4Qfg>
    <xmx:CtYpamOUZAiUVT4wXkRmL2wiSET915u2JBIPPfDCDh3W0H5ZxlzOxcaW>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:24:24 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 09/11] =?UTF-8?q?doc:=20interpret-trailers:=20commit=20?= =?UTF-8?q?to=20=E2=80=9Ctrailer=20block=E2=80=9D=20term?=
Date: Wed, 10 Jun 2026 23:21:27 +0200
Message-ID: <V3_trailer_block_term.8ac@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
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
*trail* the message). But it is also useful here, where we explain how
trailers are added to existing messages, how trailer blocks are
found (beyond the simple case in the introduction), and how the end of
the message is found.

† 1: in commit “explain the format after the intro”

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 26 ++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 759cdb6e18e..9f4c84abfd9 100644
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
+preceded by a blank line, so a blank line (specifically an empty line)
+will be inserted before the new trailer block in that case.
+
+Existing trailers are extracted from the input by looking for the
+trailer block. Concretely, that is a group of one or more lines that (i)
+is all trailers, or (ii) contains at least one Git-generated or
+user-configured trailer and consists of at
 least 25% trailers.
-The group must be preceded by one or more empty (or whitespace-only) lines.
-The group must either be at the end of the input or be the last
-non-whitespace lines before a line that starts with `---` (followed by a
-space or the end of the line).
+The trailer block is by definition at the end the the message. The end
+of the message in turn is either (i) at the end of the input, or (ii)
+the last non-whitespace lines before a line that starts with `---`
+(followed by a space or the end of the line).
 
 For convenience, a _<key-alias>_ can be configured to make using `--trailer`
 shorter to type on the command line. This can be configured using the
-- 
2.54.0.22.g9e26862b904


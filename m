Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3003C379C56
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788629418; cv=none; b=Yi5ge9qdn+f2e4cmvPrlrmghUVDahHAKJkG/5r9DWSgL8nFcutFklVFqgZcOyxPNuMzly0k7raMhJoKduEFJP0NbkF/FnWgwS2aS2pnQFP85E12UOmbpAy16smsTu4HIRlHYZT8jVKYGxmGFPd2adIDHyvONyvMmqxz1P/JFcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788629418; c=relaxed/simple;
	bh=cBUhHZXFUKOnYPO3Vf78R6+ca5ye0bnPbrO6cxDZa08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTW5faCZ3kdsfqqf1Ngrf3La07rmWPJB9rKPFWgAQCFj8o0TdQDdrWpW+eDSdnm/YF3dSD5MdLoQuDweFuT43e6rGYfroh/xfyCkErSiXJfRnIkNFWsLske5aB7uzBt8wXFTWyNkVQk+jukFDpLLAReVF85+0bwFq3Wi9tUo1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TyRmXzbd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WITWCl9t; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TyRmXzbd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WITWCl9t"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 181071D0008B;
	Sat,  5 Sep 2026 13:30:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 05 Sep 2026 13:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788629414;
	 x=1788715814; bh=2Zysfx+lzAiXyEm9I/dKpgOWYDCcr2P/1w7m59LQpJ4=; b=
	TyRmXzbdO4ZL1id010TObxbyYtUTiWBFNAiY5SLwFkLTttCx6c1GvmWDm5BT3pRR
	OCXe/EjJ0If+ZySVLD/LPZr2TP324KXxpWoe/DGK1gCxjVw5pIYMLAb06yXXTHsA
	8kqVBMZNNqXZ58B/YsmBoLfpOIQvJDwKN45q9Xbdc34ztVubWaTFISMc8Xfyg5Wf
	b3BNVTFlLyPi6Bn/8Kv0CCYTzEeedaliU0k/z2eTW7VFbsRzMG0HzrZhljBh92sa
	wiNJDbi+/ddZGLrGbB9AYjdTDfSPXwxLGSTLdaB364EK4I22FMA8btQNjWD1booj
	pvvd187d06BXssiU7sz6qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788629414; x=
	1788715814; bh=2Zysfx+lzAiXyEm9I/dKpgOWYDCcr2P/1w7m59LQpJ4=; b=W
	ITWCl9tyUuaF1rUdj4OYixtou7cQ3JUEjL+K9ThU8eGwN9mLfIGC1u/hOzFKG5yE
	jT4vX12nZp1SfPfTTMTIal/tSMFmj4t8lvVdkxI1FTQ1Fwuo3PNMx6u0gD25XlHA
	OShVa2EtUIiLPB6GAprRa9BgnPvnINZX1mcQLLyaNp7gcj7eoGgmUExo18H/v5no
	uh7s3ojRnshaX9B9YkU+Mbwpop+97QDmfU0XOJSL8F2/DmOsQ3+vGXuANQWAHsXq
	jZQphzmCJggzZ/iJd9vHZf5qfTNgDqcuNlmPgOBXMSI3WJc57qWjm5rPaZZRWMtv
	kOlNR8yWq+G97BVgEMA0A==
X-ME-Sender: <xms:plGcaoEzcYa1o9Wiz6vjpS_Gz7_7loHbBqnJrDaQQvuQrcQJsysSsII>
    <xme:plGcaoWUk67flPKcwkpxAqz5XSxik1Yoid7JWikJ-T1qFFo_GLMhP6icii43SB4lz
    AXuivIe3KGHpAnoSEjblBk9N22ycJ91klo1nqmqN2UJdxhdHZfRsA>
X-ME-Received: <xmr:plGcanLIy5pfH55CrLAxVJVSWo9tCp1P51nE8fAPOuMC0paB8helMwawIhwygN37Bq9YmL8jarddxtXcN9PozbiOeyzHAaOnIVxnuP15pvfdgUEvgFOxifE>
X-ME-Proxy-Cause: dmFkZTGxWbvk2P4qPNiFNfsjBBdOxH+e/v6VTm2pIPfhBHXExY9YtnPdsFEZ9EtpljFn/Z
    wiDkhu5btqivN0Pp1ORcC1aOPtxOHXJnEvKzR8lwDUPxhIpDfonTS+WD/e3ZgKzrkKqkg7
    aXTNc7q2Y7OgUY1RRYTm3CFDwUSvqtBibHWDOyeLQ7F71zy//o7KxNJ0CVSJFy10CsfyEN
    ZsDkK9lm+Zu5/cweP+Qq6tzrgulLefQl3aFTp9hkNK/R87gi+UD5/gz5vdqvbiihF1C/kF
    /Geu81eMH++bKG4IpAnhI3XGpkI0vW8V9pSIAA5nYxMuzO2jRwE+nTYZU0llPXFdpbW/TT
    ud65lUdQnRd2b4uhGW+jywqd74WpjNFdZ06m83wi8V3KdIL6rANg1YikYijVrmPkAWXSTl
    QNKkb4YRUFP9IQEV+10gbQ944Q198x5nTeLbIoaQARE3iwe19XdRphGYTv+sIrd7FnW8l9
    noYCvpyf1t0hHv+LhauALZqKo+4bpmR/rMJDYRbNCgfpR7WIWv/H8dkN7g2wpNXo5yyN03
    YEgorBSGLEDTCYldmqw+nYIFMlMivp8V51PUPDJBQ++2midJXK7u5Omso+QQtAstziqyw8
    bYv5TMp9CW3eSb99BJBANuvaIFl5J5IrM1TJ5heMvrStGKRikdXEuI0olHtQ
X-ME-Proxy: <xmx:plGcao_SEn0spoNLng5hHDZmKp5eYQy_R-PGKk8AFjL_Gdrr8GB9Lw>
    <xmx:plGcaqJWRfV6P79MvoiNSNfSwVsQcXFCBbUn6GD33yTzeJEGBQeZng>
    <xmx:plGcatm8SWLaOPniD-JmD747htIthO6gMXd8HKzNMPrLYLJGI004IQ>
    <xmx:plGcauNxB-eMXHjpXLjn6ZvMOM3FRRtpOj2wzEFnUfAuf_jJxL-Jng>
    <xmx:plGcatxdwA8JrZWl4tODwBoigFsX4qnkAqqi0IqMpuqHBo5Z6D6AUsXC>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 13:30:13 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v3 4/4] doc: datamodel: link to the glossary
Date: Sat,  5 Sep 2026 19:28:15 +0200
Message-ID: <V3_datam_to_glossary.c82@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <V3_CV_doc_datamodel_advertize.c7e@msgid.xyz>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz> <V3_CV_doc_datamodel_advertize.c7e@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We linked from the glossary to the data model page in the last commit.
It can also be useful to link the other way for readers who might want
to reference more terminology.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Drop the running text mention of gitglossary(7). Just use the link in See
      Also.[1]
      🔗 1: https://lore.kernel.org/git/5e12e3ad-a80c-4c7b-81f7-e028e461fdd1@app.fastmail.com/#t

 Documentation/gitdatamodel.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
index dcfdff0346f..56b7635c199 100644
--- a/Documentation/gitdatamodel.adoc
+++ b/Documentation/gitdatamodel.adoc
@@ -300,6 +300,10 @@ $ git reflog main --date=iso --no-decorate
 4ccb6d7 main@{2025-09-29 15:16:48 -0400}: commit (initial): Initial commit
 ----
 
+SEE ALSO
+--------
+linkgit:gitglossary[7]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.55.0.13.g335083658c8


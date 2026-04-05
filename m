Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7C72627
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775385213; cv=none; b=IS6HQK82ZX794uTzF8bOlKBU2/bwwqGvlmb9Jec1FP7ICA5ggVo+foBVMoAlmSNQq/27dPo/5t5l9WUtnZpy8RkByEQujwu2qH2sItpofvXIN584XotAhn8emevRyzlIqMWgYdmi7RpcYQ9w76kQjfQIun9UDYNsN8Kj4Jd1/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775385213; c=relaxed/simple;
	bh=L+7qsqdzzOu2izAK340WtE5HSznrFPv/Jr7TA95FKqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3pLrtQ73damh31l+2kuS0Z1sg5aj7oGOnluJP+azpBbrnzSNyvCKiBPE/Uq8ygVx/bUGodx0Iy2s5OzYtgk/Fjf8Ek6jg5ciyi046JTC5HHkLR8fYRfYyJHxY4FmliLR7w9cVEdf/96iTFpUaZaNcU60WbYk9EDQIkalpTeNJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eaE8OhjK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d5rsMGoL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eaE8OhjK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d5rsMGoL"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E327D1400109;
	Sun,  5 Apr 2026 06:33:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sun, 05 Apr 2026 06:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775385210;
	 x=1775471610; bh=r6mjpVcMz1Z9vgcNRw4qANQ1huJRorRHvFSMlgJmhk8=; b=
	eaE8OhjK8YElqiTXhTh6u0TsFf7CgNsdBtD/lh1W91Z7roYSFYz3XD8fXrr7s0K9
	VYL4dXEZAFwWuvUCo0+SFNB6BGyEOv4wYorJYSmb+oiaa1VO7pF3spYWUqcJ73O8
	ILED58Qeu2IdF734INsthOz1KnYtyoLScEQpb01UeaRRluljzxs2xsdcnca9/2D6
	v1dhDk6g0572bn2C61EbMdkJAG+QQzuUZPOzBa1JwzAWGKx8HZJWxHn+O1WzfwOg
	knNybUap5LptrYMve9BqoiFSH4pNij7m13OKTm9rpKQdZvQkaawIrjp7cWqOKxlh
	xQsKaleri9QlHtAfNzP3QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775385210; x=
	1775471610; bh=r6mjpVcMz1Z9vgcNRw4qANQ1huJRorRHvFSMlgJmhk8=; b=d
	5rsMGoLnQVkiKLN23l1q1iXUt9/XsIoncbUYu/cZh8VsioOwSvIKcbgh77p4v9Ml
	ObBQSyQ/MNJ7hI/mKFIxXu9cdpdTX3idC0gSptCXIreLB48KZaJjS1/YWXl5r1ed
	wOhE+QbUFmhaUirLn4VxJeIOW2SKhZ8e90NVbnl8NZT4IRJ1Ti2FBQqjzY/bAWPa
	2J8Cy5cdKLV5QHr+X4WS3BhyST4iSgmz2QOH9BMS3XQvg4oPpYxc4zLN/7zQVDiu
	3/byTH87LxuNXo43WBWZPpjF/FORqja+/1FVqZVWCzq5HQWLMIVU+5Ad82YMdAKO
	KuZH8WasP54bqzx806Iaw==
X-ME-Sender: <xms:ejrSaTN7lartRL3m_WqQ1QeiukcZ9gSZoED4jtTzAd-g8vuac1BfyOY>
    <xme:ejrSaT_m7JNHMrp4p00SYlAulCn5z1P8m1ETWoOudlPSc7bED10hyV1r_368_I_FQ
    vIoJYn2R7CuQHlgFWj4CR4XhtG_YVQHW97Du3N_E8QsjxJ4ykNv4g>
X-ME-Received: <xmr:ejrSaf6YF-tJ0FGWNxlfoa8-S_x0pF3mSqm4LOzTmxLfq8UzK3TTPUcArbUMGdYq_HzuWRh1voHmlNMHpFauAViKxdNrulnhDNr87r-f4o9TQ05NJdKZvqk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfegle
    fhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:ejrSaS2hgsICjM-6dGFsDTH0iPF_WrEerUz9AVk-x61pNiipCk36HA>
    <xmx:ejrSaeCLr7PH8alrYAk5VzMuKck1J5h9ekTtTnNN2vKFRgAB8e99Dg>
    <xmx:ejrSac25gQkgbpYMttXfUunO8GrshiiD_WG6oPaDUvDc3t9CtxX3fg>
    <xmx:ejrSaQv9uoP2MZsSRnSb1Z9DRAu3_K0LS7yDlQCyVpcejbOxdh2aRA>
    <xmx:ejrSaekef5UiVsrw-WTat8kilJQPXVO5p9oNkengD717I0MR16BOtzO->
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Apr 2026 06:33:29 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 2/2] =?UTF-8?q?doc:=20gitcvs-migration:=20rephrase=20?= =?UTF-8?q?=E2=80=9Cman=20page=E2=80=9D?=
Date: Sun,  5 Apr 2026 12:32:00 +0200
Message-ID: <V2_gitcvs_doc_link.56b@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <V2_CV_doc_deprecation_config_--list.569@msgid.xyz>
References: <CV_doc_deprecation_config_--list.54a@msgid.xyz> <V2_CV_doc_deprecation_config_--list.569@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Let’s change the phrasing around the `linkgit` while we’re visiting this
file (see previous commit[1]).

We use the section syntax to refer to man pages, so writing “man page”
next to it is a bit redundant. We can be more concise and just lean on
the preposition “in”.

And in order to avoid this double “git”:

    see `git config list` in git-config(1) ...

We can rephrase to the subcommand, which is a typical pattern (config or
option followed by “in git-command(1)”).

† 1: Which also discusses why we do not change a similar phrasing
     in gittutorial(7)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Just the “man page” change, which now comes after the --list/-l change
    • Restructure commit message paragraph so that it leads with “section
      syntax” and has a simpler structure.
    • Footnote to remind what was discussed on the previous commit
    v1: (combined --list/-l change and “man page” change)

 Documentation/gitcvs-migration.adoc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/gitcvs-migration.adoc b/Documentation/gitcvs-migration.adoc
index 2883834b714..905d08cd5f9 100644
--- a/Documentation/gitcvs-migration.adoc
+++ b/Documentation/gitcvs-migration.adoc
@@ -49,8 +49,7 @@ them first before running git pull.
 ================================
 The 'pull' command knows where to get updates from because of certain
 configuration variables that were set by the first 'git clone'
-command; see `git config list` and the linkgit:git-config[1] man
-page for details.
+command; see the subcommand `list` in linkgit:git-config[1] for details.
 ================================
 
 You can update the shared repository with your changes by first committing
-- 
2.53.0.32.gf6228eaf9cc


Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0783612F1
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075842; cv=none; b=H2Izhjv6+e6fJoPBVsd1YZU5YHc9cfrBwvkjMuTgmWLF3DbVcYcYFBV6lhUymGt+16URltRazssAKUwdHPANGOyYlU946XespNpAgo8dPFu3+jVrLXf9EoNVbuX/rXcCztzgCr4qSLRBhN/do+h2UMAiRn3I3lmxpDy1BY8kyIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075842; c=relaxed/simple;
	bh=ms/pVGpaFHuFzIFCEtFpnjsYVALc8MInTYSpzm79XNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYDDcR0XWenCdbHVknusBSk3R+UPduVo4+1K453ist6fMLXCSR0gsoPGbzeIlgIrz73sG/Ji33GIoXR3e8pCGeb34vS5WqH0S9qRWu/OfCYTjuK6dmIpKztMHDKN+6E34wPrlvp/WHfh1xCsKhP6D57RPcClfBnt44j5ea+QC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=P7cumUWv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tYWaos8D; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="P7cumUWv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tYWaos8D"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 11DBE14000EA;
	Mon, 13 Apr 2026 06:24:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 06:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776075840;
	 x=1776162240; bh=2O0P1MXU0NF93gtPynmjZtwgYHMtMw9BX/IJ+S2TH7s=; b=
	P7cumUWv/BQQ8f/1ldVRu3WooPg2fRbmQc7BDMVx6nyPO82aPG6EABn1Wqy3zPXI
	btvUWYIPf6v9GE9Fj3fctI+QkFi64ztnOU0VMO4xRB9SfqUOoOfOFFtQ/N59eC1k
	WoXx4J8UiVUaQ8rbbfI7QDCnH/DcsFxIsp7Zljxr4NG9/+Vdjrdx31jtNU3jw687
	6PG4VxaZYACDcH2ZFJmtH9oUaQEkXJF0gXMFjB1iFDPqCv6Ic4onBBPTm4r56K/O
	1Ed1tU9V+BIK9ucPlDA93IiNW5TARBDxTWM1bqPeqbNEwfM2mqCqZ2dDpSwJgvbo
	t0tle+kFmKclrNocoRLIcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776075840; x=
	1776162240; bh=2O0P1MXU0NF93gtPynmjZtwgYHMtMw9BX/IJ+S2TH7s=; b=t
	YWaos8DCXPcRhYPBXBrRpHWxFKkAwKYpc8QBNAIn4ficXw0Dx8IAFZlz/WuI1Yx2
	g6hD/OGJo45SxgHn5qGs7UnA/MT/f0QjWsCnf3V6lJb5RZnDCGcSVU64+rSvCBON
	IFH1dlCdn08iEGddzdv4+zQOdlaMhQLZeKI/sBdhTpcaZxnPsthccxbHLqh0zOob
	Q4N+Nuu6MhfSpWek++Hx670cWhJGJAWk7fPREWiEpSkLEFtXWjXulFZ9MG1WMn3u
	I9kNCd18YahkEoZFLLM+wgXy+5MkAR9VO52wrEAl6bmyZ4cWk0oSBEeo/+xxYl0G
	WLBv2tQau73Qz2lOUOC0w==
X-ME-Sender: <xms:P8TcaRTnyE8MJ5XJeXi9ie6yF5qEMT60YhLcDpG_YHvjDSgfxbSTc80>
    <xme:P8TcaRpCw_H3sSZ5EbPi5WjXTaK745TQ2Fz6BNV0pnzVCF6qBkd1bQEnlE6Y9gsKE
    KM0GUhR8tMQtW1MgRpa3-f0417DQd2UTZus7xg9nXi3oKtmCULBJg>
X-ME-Received: <xmr:P8TcafITkXwPs-AP6FlT8BfKgQKr0az7NwVYwMoGjOVAi3orTNpW36Xm_lxLot3wYg0XwFn9jpt-tdYXKg6TxEEsJzUz1K5wJZmZ60chmK9IVUk01DeosX0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedt
    udduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhhmrghnsgesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhushesuhgtlhgrrdgvughu
X-ME-Proxy: <xmx:P8TcaUoUaiYbT_YVeiTmSSD97aWsMVBXj0CF87kqzoRcrPRnfpfF7w>
    <xmx:P8TcaXzcsr7qqDdsSIbN_fpzCLW--7CYIEkyHCFVmuOlF77bH3YTzw>
    <xmx:P8TcaYOii7KFkcD8qR0sY1BJj3dhKV01L6QMVTT3UYOMVxPvaxH1Sg>
    <xmx:P8Tcac4rczqtiW3ilA3zUtMrSHqC2cDXy5MQkYgPW32DVW3_8GTvaQ>
    <xmx:QMTcaQ4mEf_Go8JPvCqqfwjL3Bb7VzZ69qR3-fimNsSeon3F-mggWnWb>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 06:23:58 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>
Subject: [PATCH v2 8/9] =?UTF-8?q?doc:=20interpret-trailers:=20commit=20to?= =?UTF-8?q?=20=E2=80=9Ctrailer=20block=E2=80=9D=20term?=
Date: Mon, 13 Apr 2026 12:21:07 +0200
Message-ID: <V2_trailer_block_term.61b@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
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
index f215cba4bf0..b693e89fd96 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -87,19 +87,21 @@ trailer.sign.key "Signed-off-by: "
 in your configuration, you only need to specify `--trailer="sign: foo"`
 on the command line instead of `--trailer="Signed-off-by: foo"`.
 
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
 
 When reading trailers, there can be no whitespace before or inside the
 _<key>_, but any number of regular space and tab characters are allowed
-- 
2.53.0.32.gf6228eaf9cc


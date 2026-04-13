Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C164A0C
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075747; cv=none; b=RZmG0nw8J+1pzK/O3LuXN0skx+W+gHjXOk8CIkCmfpR6Y9eOb6qrlUtiDKhHQ1l3HFQv1EynTI7LdMeQ+ofRQFBD310MG7L33UjTRQ6fmOwAqd3i/Uj6YnYNRBH3VUUkQVw7gEN62eqLRQXX2S06jhLRdekrApNJT5PIrR7du0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075747; c=relaxed/simple;
	bh=LMVheTPbepE4ezbWkjw87Wi8LJ3h9EHu2iqhAyx6daQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzm/3mccf+GOTl+41MZIEGI8jiz7+/C+oKd0qfwg0T6cQe5QVaYpIyb4Q0OUg2GthK+Iz9DkBH1aOLYa4bWVtriWo/eggnO1PfdPIzntAYvEPTJesKWLXba/SMgpf1IsX0vVmvcYr5T7xNRifdFKAng91IOpfZdvA+BIoi2z0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YZx4Nw7K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EJVOzdKS; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YZx4Nw7K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EJVOzdKS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id AE439EC03F7;
	Mon, 13 Apr 2026 06:22:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 13 Apr 2026 06:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776075745;
	 x=1776162145; bh=cUGGnrmqDdZ8thSEtkSWB15BgtDcgI9eGBVTKLpXhXU=; b=
	YZx4Nw7KdxGkkn6qAxCzw2bKwuylSoPoFx2NNrz8PLaa6ay8L83te2E/ZNY0dUQ0
	vN3QWX7qWqr4OKOQYH0gPdPaGChca8OrEtR8aShB3lw70G+kSs1+5gh6yu0To9ih
	UHCD3jPQeFCYLryE0ofFgMILxlkvKvp3mLmDD1YewGWdOCDcd6zbjSZ7IpeT74og
	5U31EPwtC0JO9V46Xrx7JWhG3J8SpykuEXGnKE3zx+I0PbZmP6NmxSVJ3jjHqZxx
	Rlz8+3FSoj2MpXygfsXlfF7P/1tuQ9pK7a00eEwNXs4m2bV6Cgrh1zref3YKR1Ps
	LItHlTxBzCailWvMaU43CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776075745; x=
	1776162145; bh=cUGGnrmqDdZ8thSEtkSWB15BgtDcgI9eGBVTKLpXhXU=; b=E
	JVOzdKSo37ynwnMUQ6CKxWeYJXbX3OKL+CdQULr67zJJBMemfvNIHUBrbT9FmDKH
	0XfvHq38Qpg02/+sujV0oGad98w0JYdMxqsdtzx23tDMSGMymd8ESMS7VvMUxoM3
	X1G1ZJ/dWTWsyvXcci/C18j7N6iv0Ai39ASHZdK9npl977uEEkj6pRzZUEHufd/+
	ryBymLtLDxhhXHYj/R6S1O6ijS7KHDkZxXlZj0EUAUof8Fuw91LaR4RuGi5FUWKC
	6+5vZ3eTnqY86Bns/MRRFhzZ/4ROMxogiDbALfnu4y+ca2WGWGjldd6nHzSJ62db
	MqjQ4qRTWsxZelwDFt4PA==
X-ME-Sender: <xms:4cPcaQahLybtNRBOlV4zvwhX99KLiBBs1tNhZdLqHuCHiJ3uvhPE-pU>
    <xme:4cPcaSTap80rbbdR2tUvo1GBQ3_4CfSS7pAriD5FPId1W8lmqG0KsiL-s5t3GEMlO
    eL4VlRz1HwgKdQiLB088lNIs9_eGvjrTtEGTvywd6SGjRjJyRudYw>
X-ME-Received: <xmr:4cPcaTTMtlIOM_ZR8ERvoNYskPBSeRHq0FH7F_kKkvKhVsaUOEgepIV5TgS9k9OkBHf3ANwcsxwSJCGTauuaVhsTnFL0q93gtv7IQ0jcwbDZ4SaBHgr2M2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedt
    udduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhhmrghnsgesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhushesuhgtlhgrrdgvughu
X-ME-Proxy: <xmx:4cPcaWTU3FCVfo455hNZXbNOLxHlmz5QsAEOCkq7X6Uqjtb7Hh31-Q>
    <xmx:4cPcaY4DHo6pvR_ZTGeW6ug98-oQeAf1vKFygSLc39qlrjBsX__U5w>
    <xmx:4cPcaS1x3ej0m2rUShPlykR9Y87wN0mr0QqYN2GbocFhvxMRGy83BA>
    <xmx:4cPcaTDmrMuNqAJGCFYWDDyBeftf3Ipzg0jU78UeU-dIKWpWQWPWKw>
    <xmx:4cPcadg1_z3p96Bon3a2lswRcFOVaHBc8f8RCnQ7k2cLuwVi4Fxxe5UF>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 06:22:24 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>
Subject: [PATCH v2 3/9] =?UTF-8?q?doc:=20interpret-trailers:=20use=20?= =?UTF-8?q?=E2=80=9Cmetadata=E2=80=9D=20in=20Name=20as=20well?=
Date: Mon, 13 Apr 2026 12:21:02 +0200
Message-ID: <V2_metadata_Name_section.616@msgid.xyz>
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

We now since the previous commit introduce the format as “trailers
metadata”. We can replace “structured information” with “metadata”
in the “Name” section to be consistent.

While “structured information” does emphasize that the data is not
loosely structured, we also say that this command adds to or parses
this format. I don’t think that we need to emphasize that it is
structured since clearly there is some structure there.

Both “metadata” and “structured information” can convey the same
information. But “metadata” is shorter and easier to deploy since
it’s just one word.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 3f60fd9b720..4e92c8299bb 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -3,7 +3,7 @@ git-interpret-trailers(1)
 
 NAME
 ----
-git-interpret-trailers - Add or parse structured information in commit messages
+git-interpret-trailers - Add or parse metadata in commit messages
 
 SYNOPSIS
 --------
-- 
2.53.0.32.gf6228eaf9cc


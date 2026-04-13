Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB87350A0F
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075804; cv=none; b=BLTyBa8AYHqpLqm9x6ptJDGcGWg1aTFbnfjYpKwipvLmhCDILdprTRPugNBmIEThnz73jNS/irTs8eI/3TgxugckiRkKPZIKFfpKCtjvhFIP0TjmkEg4ZdoHzOSawxMeyZQB9v57bBRB3O3cUIGKAhmEbUl0eAHv67xBt/FKRbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075804; c=relaxed/simple;
	bh=ThRK8jPPrYitqg8oFUP5GoBOvOKpHhiNSdHPkyXS7Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhDlFvactBkLFUbPHibhY5etAzxwl96/glxOFx7RVPHtnpZCSG5Dt5UBounrCr2s4V5IUAg8kxo7e8qNiDjJxr5nJ1HgJr34xWAKezuZfmtIp07RU0QT8feEZLvAP3KEehv/U8MZfsGFq99vT2eDNHnfGCFHusVlCVMPXWXqwSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SJ1Tijx9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GqQgKFth; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SJ1Tijx9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GqQgKFth"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 48339EC013B;
	Mon, 13 Apr 2026 06:23:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 13 Apr 2026 06:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776075802;
	 x=1776162202; bh=fwbvDrhhY6n2IpIx+qnNhCaDavXoxGx4jVjbXzKQqq8=; b=
	SJ1Tijx9LuXqSmrS1EcWGf00RjzZLvu+XyhnW4ABl/NuWslQrKmaVAHSE02xEcD1
	y9GyzD/6AGEYYVfCXjjy7d6ntvpNxQKoP03EGaEo1G1q7PGMjvybrVUMCXhvSB4e
	Vz8jJpFX6BczxejC/TEIZ1SaarzdBX31OZ4jDIVt2R1e2r2D4wkC1x5BOQP8tHBY
	p2+sX2HVujxH7XzZGGZaWejbWwe1HAtK7dbFp+qCvMQ39EbO7+ZXiGxWhZkERolq
	N5hMkVAUTrVm8zTzANNwLXECcokUt7rygmVK8b15fIgjp/24MNcdb6wzuocNxlZU
	AE8GgVYx4ZgjuBrf/TUe4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776075802; x=
	1776162202; bh=fwbvDrhhY6n2IpIx+qnNhCaDavXoxGx4jVjbXzKQqq8=; b=G
	qQgKFthvHDe+VysHUphoiM2R8LnaW+8dStkvTg4LXAAqki/6qmtChLcQSrbl7028
	hzepqrpT7sU/A0Q3+o2gp5+edZg15cWHlPEUL80Ah/KfnUWFNoNLyYJzPoXG+qaY
	R4HEnGaK/1PpWqPZnE8y+pphRegeT7sIZFoOt9ebLR9UUQoQSX05TwsPVx781wsq
	jUN/BCJMNQV6KOTj2AP9yQcsTidjXzKc2qoHucAVYzqptRjNl8KWMgWl0cw+3b9w
	1emH917HxDsj9iLL9xSytkLZ9BWT6YtltxEsJYorrhlaFLE6Y8QnLTA10bskkpYm
	Y5fWDIAvbnBs6+hEFWQJA==
X-ME-Sender: <xms:GsTcaTGaZE5X_uqYyFwpHI6dwv7VKJplQe1CmpJMUOR8OgvkntFxk80>
    <xme:GsTcaXOTtoGgTWHD5OOE6vK61TREA-w8W8mOTCORAdXKvOk13NrcOKCXVKjJO52Gq
    yi5N1xHR25tK9GE1WO5nZ15kTTktfNn73e2eSm0cjg01xMoM-Mydw>
X-ME-Received: <xmr:GsTcadesTI7SMjG_hAnIRula5WAcv68VKIfwGZu-JXY6CbZ_Re_LI5n5Q0wF2KexsWNZLS3IFnRJqLgmBCggIlN7Hk503eBag8gtsE3sAfR3nGSrYdhFLNE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedt
    udduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhhmrghnsgesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhushesuhgtlhgrrdgvughu
X-ME-Proxy: <xmx:GsTcacvrw8d069R_3rMwZQHtk4byfizv2JXfoI69o56rcXT__Q7yrw>
    <xmx:GsTcaWmEfbJKDDA4nCEBxisFO8cj_eJduLFsrZexLdbhKvC4egO4MA>
    <xmx:GsTcaWwQMOfTEz-sFd0uomyeq3op5ff_FHJcf6fQr7GpBw8oo63brQ>
    <xmx:GsTcaQNOAcDUtdau7i2eOLrD1SlIPZ9GUw0QxZb5fy8rH7pZtJbOpQ>
    <xmx:GsTcaceaAiQlTFjXzd4Cw4llYjxsvLSvYMPfwIzqGtg5U4aMwWj1wEs7>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 06:23:20 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>
Subject: [PATCH v2 6/9] doc: interpret-trailers: explain key format
Date: Mon, 13 Apr 2026 12:21:05 +0200
Message-ID: <V2_trailer_key_format.619@msgid.xyz>
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

A trailer key must consist of ASCII alphanumeric characters and
hyphens *only*. Let’s document it explicitly instead of relying on
readers being conservative and only basing their trailer keys on the
documentation examples.[1]

The previous commit provided us with an appropriate paragraph to
describe the key format.

† 1: Technically they would then miss out on using digits in them since
     all of the example keys just use letters and hyphens

Reported-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Remove the “paint by numbers” reference after review (unclear)
    • Add apropos footnote
    • Tweak the paragraph about how we now have a context to describe
      this format
    v1: [had a note about code spelunking (isalnum(3))]

 Documentation/git-interpret-trailers.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index bcd79b19bd7..c35fa9c688d 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -18,7 +18,8 @@ Add or parse trailers metadata at the end of the otherwise
 free-form part of a commit message, or any other kind of text.
 
 A _trailer_ in its simplest form is a key-value pair with a colon as a
-separator. A _trailer block_ consists of one or more trailers. The
+separator. The _key_ consists of ASCII alphanumeric characters and
+hyphens (`-`). A _trailer block_ consists of one or more trailers. The
 trailer block needs to be preceded by a blank line, where a _blank line_
 is either an empty or a whitespace-only line. For example, in the
 following commit message
-- 
2.53.0.32.gf6228eaf9cc


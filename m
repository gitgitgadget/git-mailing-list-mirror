Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4440B3A0B31
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905134; cv=none; b=YeWVyfGL/JZzKKQM3IoDGKMYj61wQnhqjNdZBk38gOyQD8Y467brauqf7AVFF2Y57JuyfT/PcuwinWDMPHONlX4ItO7TGPhfSUqkRXPjFcYPqxCyFs91h/MJwEkt/yF3ZJA+iCxJMTKgYfTSxhStnkF3eozPujIu7HrjWVa90sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905134; c=relaxed/simple;
	bh=AV1sB/538hXYJkx70mbzUyru5Q1BmIctImTQspkR4dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpthIkIvJH+7kQenMnEg+FqNuZ8mv/MkCrpNubpggAVbliDwhndyw02vBF6hqE1qRwSavVUU4i4eDEEUzuAIuFj8+y7ti/eCTWF1teK9r42f2+oTLbW8H/hdVsc0GqGYtFb+95YmMxo0Nqd1XUytAoWgTa8KiAnaEjB8+ZRO7XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Uz8xt3k3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gsut4hl+; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Uz8xt3k3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gsut4hl+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AC5D01D0000C;
	Mon, 30 Mar 2026 17:12:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 30 Mar 2026 17:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774905132;
	 x=1774991532; bh=pGvZD0dUd5Sn0biaCaYqnDvv2mSzvwe912nwy0TJ4Ko=; b=
	Uz8xt3k3gM0kGu3Cqok9ghSUiNaMvzMHNDuLBAJRuqg3vpQW8Qy6YC3wJbGR/Z1a
	f3Sx94tijAsjo2GkjIax5u+07NpmDIpIBy/Mk+s6d0+wYP5uZWhUFab299WOAHqN
	biX/EVm9bUTY7NwNyYovZTMs/URLsJG4VY7iQ+DhNEh9E3/YMN9IV3azn3pOlcsE
	gDg6oVoiwFyzdiIGaoqtD7DQhPGS//Eph4gpUd64jtqzeeBfcBHXrKkaN8rtAvEM
	FTZJFQ67ClAJjUAFGVSiaXLMVPbtayHa99rFzbmHtZFkxatkgFu6VxUmaXh6sQlO
	Kp4zoQ1XAoERrUnp0aIqlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774905132; x=
	1774991532; bh=pGvZD0dUd5Sn0biaCaYqnDvv2mSzvwe912nwy0TJ4Ko=; b=G
	sut4hl+xj7QKL1qhi3XitaloHSBEJvlAgwV3j4bc7VDq7t3p76yQ0hSKnC6v/9Qx
	gF3OtwrqJjT/l+Q1mESpXOwkniZX49wAQiCNMkrvnQ1NH5HyQOh7qhtXgaSdEYDl
	csK6tlbA15XlyXxhr1aYVJ8sJBoXDGMFPnQtmEcVgTRVXFlXiiczfgdgCEYudWVw
	pYJ+slW6zn+nl4WyfM9X5JTPhFsQpsI0zTjY3xXHtMN9CCFGCUdTeHH4BBvuDKEC
	Uo6dEnVSvvRsf2rT3/0eus2A2yvn+keDsKDOn5JknxNAE3rZMBkEGAsdg4QqZ/ER
	oeXNQtAUu2Ixt7xguahhQ==
X-ME-Sender: <xms:LOfKaY2_MPA0fkn0tDNYz8CyGumIwNel9DJtV6RP1-rvEKzQd8S_wlY>
    <xme:LOfKaZ8jAwjvlo_qgc1UKMpXNL54KWZV7MJl6Gcjd9jyIGwNLVNObXCeC833LpKux
    6Kx-PvuIMLqO0_86PObwULCfb9x8-PHeE8wgthjTMb73HebGI9npg>
X-ME-Received: <xmr:LOfKaZOX_ZYYjp7f371YQJbCNmNOTxfvUtHi8oSgypCmhTufQqZWrKbeFdHQz3yOxGfOUmLmF57rOcWPBpqVzqYTqFJajghPZ6vDrgR-sBIMH_yALoHbNmQTVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedttdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhepudelgfeuieeuteekleeifeegudefheetkefh
    jeffkedvueehtdevhfekieekhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpth
    htohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjrggtkhhmrghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhushesuhgtlhgrrdgvughu
X-ME-Proxy: <xmx:LOfKadfFTNseNivm3oWPmFzYleD4gb2NUTxGCGw1xDZTwomTbF4XSQ>
    <xmx:LOfKaYUjuWJNrehcZDZMKIhMCUaOK-StXCvM_Lz5bpfC8drXm_oNuw>
    <xmx:LOfKaVj3VXdkq26R-LWdKIy5E3MaxmjUPJ4ldqgtSc67sWhfFx2ymA>
    <xmx:LOfKaX-oLLdYGyYRXarGRPHoLErc0gT3OIscDjXyBzNIjrM-JtQCVg>
    <xmx:LOfKaXPTgJkkbL6CHQ_j9EzHZH3DqUeF52_DD1L5PeaNoZB78JltsB53>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 17:12:11 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>
Subject: [PATCH 1/2] doc: interpret-trailers: stop fixating on RFC 822
Date: Mon, 30 Mar 2026 23:11:32 +0200
Message-ID: <doc_int-tr_key_format.534@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <CV_doc_int-tr_key_format.533@msgid.xyz>
References: <CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com> <CV_doc_int-tr_key_format.533@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This command handles the *trailers* key–value pair format. But the
command isn’t introduced as such; it is instead introduced by stating
that these trailer lines look similar to RFC 822 email headers.

This is overwrought:

• most people do not deal directly with email headers or think about
  email RFCs; and
• simply calling them “key-value pairs” should be more than suggestive
  enough considering the context here.

Se let’s call the format just that, show the example, and then briefly
explain the format of the keys (coming up); this change facilitates
the next commit where we will explain what characters are permitted in
the key.

Concretely, let’s replace the introduction with “key-value pairs” and
remove the last mention of RFC 822, but keep the innocuous comparison
with email line folding in the middle. We do not need the final
disclaimer now that the *only* mention of email headers is that Git
trailers have something similar to email line folding; there is no
invitation to speculate that trailers would follow any other email
format rules since we do not compare them directly any more.

❦

Talking about trailers as an RFC 822/2822-like format seems to go back
to the `--fixes`/`Fixes:` trailer topic,[1] the thread that precipitated
this command and in turn the first trailer support in git(1) beyond
adding s-o-b lines.

† 1: https://lore.kernel.org/all/20131027071407.GA11683@leaf/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    The (❦) is meant as a thematic break. There is too much of a thematic jump
    between these two paragraphs without a section or something else breaking
    them up.
    
    (one was not tempted to use `---` here)

 Documentation/git-interpret-trailers.adoc | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 77b4f63b05c..e7c1f821619 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -14,9 +14,9 @@ git interpret-trailers [--in-place] [--trim-empty]
 
 DESCRIPTION
 -----------
-Add or parse _trailer_ lines that look similar to RFC 822 e-mail
-headers, at the end of the otherwise free-form part of a commit
-message. For example, in the following commit message
+Add or parse _trailer_ key-value pairs at the end of the otherwise
+free-form part of a commit message. For example, in the following commit
+message
 
 ------------------------------------------------
 subject
@@ -107,9 +107,6 @@ key: This is a very long value, with spaces and
   newlines in it.
 ------------------------------------------------
 
-Note that trailers do not follow (nor are they intended to follow) many of the
-rules for RFC 822 headers. For example they do not follow the encoding rule.
-
 OPTIONS
 -------
 `--in-place`::
-- 
2.53.0.32.gf6228eaf9cc


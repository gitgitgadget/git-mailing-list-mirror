Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629002E9EAD
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751310668; cv=none; b=tz471xQF3LIQ7N8V+yQfzPreDHuEixpEG6DZGROXhAx5nkdiF+ENN77zqMkeLL93xmbuGJJv0AWyJrvfRuyqpycgFk0djG5ZXVfvES9YJ73kJpmQfgHsnCoEP3S0cdXdKIHdTTrCixD+4dQ796hEsDWH/9XKUrHQihQ7IfT6Ync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751310668; c=relaxed/simple;
	bh=1wjliyBvYjHmIn7qoH1BdLkQHvPOlpoOOhO5f1qB/oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsimsOj8n5ARf+AL5Zu/wZPQcQKDZT//iQ+1T8Fu2cl6oYeVbAsWZjlMlwWMEe7mrOsHjfJLWXjXuvolz1AWbDf3ZRZ7ynn77EpgqSJxcyufQpo+C3aOLAPyV1m1AOGTHliS8zzggvlgJvO/rLWjtcd/+j9umZSvfSLC1HV0Azc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=yTbItN8l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f2ug/tsz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="yTbItN8l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f2ug/tsz"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ABF90140003D;
	Mon, 30 Jun 2025 15:11:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 30 Jun 2025 15:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751310665;
	 x=1751397065; bh=yJgCVQefO7/DHmGkGfXy8N5ygMYemKPcL+zOdFAKoII=; b=
	yTbItN8lJGgChVpZq1d8wzS5cpUTA21blPNKv3gwssLkllgMuPciz71YubNbrwbZ
	Epk4cFjVMyNQTW9ZjoNSrNTxLiFmc7/v9jmHejYq9X+1rO9BbREQGq3Smqf7jJv8
	XHlDtHqDjNYawKeI/HLwY4iR1qgHwCNs1L228bk1nv4kKj2JUKhUNdWJuiswfSOE
	udEOaF1hl5q62mBrIS+NYE9J3YNDmvRTaBgV5lgPAzskBc1pf4cDcERF6rJYgZZm
	noMjnA1DyXCU2OMr9y4uJxZQumf+fE6AbvPX/MannbeLeidb0fXdRFPppUeeCXG8
	OjTkLArdHS4DFghguo+iPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751310665; x=
	1751397065; bh=yJgCVQefO7/DHmGkGfXy8N5ygMYemKPcL+zOdFAKoII=; b=f
	2ug/tszaMZnFAdhEKwoPPOE4hji5pW9qZGgdhu84GwO4DAn6wWJaaO4YO4H4uQvv
	IoESZ+18IZxDurBkvpVcifbLV23e/J9tu3xNCmqFuyzdiGL/Uk/TmtZ2PISFlCaZ
	SR3k/tyySoPNLcYByHHxrcx57w1SQjHFxDFCd1flzyim8ItzmPHks2RA0ZVHZVBj
	Fj7y7skwrdHpQm57Ws8yKTZUrk/EDhQTHmmIRI74trNpgo+HOgedbEJ1FJ9BwEMK
	rLSa4r1xxpQVFxwGKJpYdBoZNhBeP+D3/hfSpFmPfCC9eEZhSNxeGrIAR8YfFoph
	prX0IVVOOh7JmGDJeAM7w==
X-ME-Sender: <xms:SeFiaHk0zOjngyVf90UrFKCa7Bs13ov5fBHhg9D9AccjnyLGbXyhh5o>
    <xme:SeFiaK0pmSs6OCHJ4P_MNdYRvfGKbrYFGjPotUokQFHIdujiOmNpN2YRmWL_LFCmX
    JElUnYLT-I1cN8eGA>
X-ME-Received: <xmr:SeFiaNqEhJRuwaMhEZPVX-UNu2RO-Nz8OIHaG7lmMcx_OiEcBXtYDtCY-VhRYH82oR7EaCbf_wHtuatFEMVqoMzWp5n081VcLtBeu9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhephffggeelhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:SeFiaPnYoxWNY1nLNStP5gajYjPPlgC3-5fR6iMnFcHJ2qtQlIUPrg>
    <xmx:SeFiaF3cgptVVKzvYor9CzGbFSHJU_KGwGK6erPazg3fuNKpRB4N4g>
    <xmx:SeFiaOv9VRXAmmC2_sUsJgG2ddPd0sbT7szbeDisqT4NulZdkzB6EQ>
    <xmx:SeFiaJXQ_6jrk0svs_rBmYc1s3yAnrczINJhAwpzsrTJMLosv2M0Qw>
    <xmx:SeFiaK3KqLdwfmPCwjfanfrhiHnth7oMotWVwfhsnNUcMLyDXMl6uOc9>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 15:11:04 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 5/5] doc: config: mention --url in the synopsis
Date: Mon, 30 Jun 2025 21:10:27 +0200
Message-ID: <ac3257a934d4c59de03757c2471c7067a8186108.1751310455.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0-KH
In-Reply-To: <cover.1751310455.git.code@khaugsbakk.name>
References: <cover.1751310455.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

4e513890008 (builtin/config: introduce "get" subcommand, 2024-05-06)
introduced `get` and `--url` but didn’t add `--url` to the synopsis.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-config.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 9d8f9bb04e5..511b2e26bfb 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git config list' [<file-option>] [<display-option>] [--includes]
-'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<pattern>] [--fixed-value] [--default=<default>] <name>
+'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<pattern>] [--fixed-value] [--default=<default>] [--url=<url>] <name>
 'git config set' [<file-option>] [--type=<type>] [--all] [--value=<pattern>] [--fixed-value] <name> <value>
 'git config unset' [<file-option>] [--all] [--value=<pattern>] [--fixed-value] <name>
 'git config rename-section' [<file-option>] <old-name> <new-name>
-- 
2.50.0.138.gf67de2ec4e7


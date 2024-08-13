Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1C17C235
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541470; cv=none; b=ggoVH1dPiO1eivflhdSzv5+Zo6o5war59mXStkBa7GS+wPvzGE/L8IfIgs1a6pQh0x9R531ABNlmskiwMnRh0mO5L6bb7V0zbSLvc8QOhF9Lc1No35z6B9XqKRI0zpqIBc5KB/5Ec3tZ7FmHvpFvMw3OVtYYKQ9rwBAu+9AaSMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541470; c=relaxed/simple;
	bh=libDPasjwERHGMXBJcJ0Dh5QJzvBfdxylv8HNoT6a+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fac0yB31ShXAfEk70GZoDaJLfhEYA8gJ2oNvoLycePH6+OU4qO2+S1HnOoQAa7ZFfvnY79vd7v8EtxdZhxld1zKgSSB9L+ErNnAYpgEBn+V8v60sYHzbp1DlA+/+4LpRANN7tK+C4XBdh7tbyWaHup47G++Sxk2T74KCx7D5kkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P016BOYw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XXRbYAzS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P016BOYw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XXRbYAzS"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1A164138FCFE;
	Tue, 13 Aug 2024 05:31:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Aug 2024 05:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541468; x=1723627868; bh=vWD7zvYfuB
	lMluFTJnwI+L7GOLzXt6QD1KyiY7vDzFY=; b=P016BOYwTqnYMfsHzitdDyP0y4
	384A0XGerDClovdKEU2AGU9FEaI8yYwaEYeS3216KoZLAjVSTZSq1eGDj4e875wG
	Zy/vOKpgKmAfZgztAMXUOZMagDJ8Fs2Q7UcLLkTTM0HH6VdBJlWiphJq7KHQrdk1
	tehIcDV1ipFCXSFmmAm4vc5RQYr7lFuwEP2bWR2Q/4UhdZTJucOcxZHBaRAh6QDr
	x6lsRtvwm+AxmCp6DGTJTuDJVh5s9sRYadWG5INTKuL1aG8B5Azi+zs2UTsjrC0w
	lXS8u5T/HvrOKM8WywT16jSb6MjS0DIPr4fLv/POqbmeUZGjmdFEFTJOj7zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541468; x=1723627868; bh=vWD7zvYfuBlMluFTJnwI+L7GOLzX
	t6QD1KyiY7vDzFY=; b=XXRbYAzS+/6c3CpsHVF2EbuJZrF7FicD+nP+chs8aIz3
	UGDpPUzF9tu4dMtlo/sN5zsW1lv6tVSkeGa0rzj8bDU6wD6wAQ9ystDSMC9W8tEu
	5BD2h/OCSZaV2jrG8JYIYK0PuSVWp7wYNYJbeC/OZbJ7fojMqvk0nSu0EYKSH6v/
	ecu6xSFAYRNeF3rae1VRULPcEvbxoZ8NntgsMOm2dcqg7vNRPybGEwlur9fqzWZN
	eShF10h2K0qKMq55QDCSXGImIKeBYtYCQaRurlfH81exuxFbCgCzNMXDsFxEO+5l
	81AweFnxfY2o1zsV1R9dlOxk72mrITQUB5s/F6/fJA==
X-ME-Sender: <xms:2ye7ZmrysAwAputL_xqDkIcots30_FmVb4ir2zHgohQAzR6jCu4cYA>
    <xme:2ye7ZkqP0A7m9SyTe_nNvATlX0U0m2qLajILnbhsw9NZd9wrK_YH7k8WfdAjHKi3j
    -onaqO-N7A7DeMaCw>
X-ME-Received: <xmr:2ye7ZrPWIetcefglVDslVbUb-tqQ9jBysIFL46rbivrJBE5kCgHuaxLvRpFCA_SuFqYw3toV01WNv7Jg3Gl1TVdvFXaLW_MDS9be4mhcSjEd1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3Ce7Zl6oNPAIhhuDKGiBUwLXS600IFvpW7pkeNFacZeAC7JEU-4g-A>
    <xmx:3Ce7Zl7om4zENRAz8YI6P9FWb0BtcekJW2XBNB8fCMF8Hmb9ee-vcQ>
    <xmx:3Ce7ZlgAtSzpmd01_kXS0W0YoZauAoaZ3uZekjZzjzBDgd2hMGfRYw>
    <xmx:3Ce7Zv7GHbs0xYfHuMAWRBKjQG3eg01w57ozafWUlsr87jdY_SC_6w>
    <xmx:3Ce7ZivGR96cPxqTwLuXESSn-bxUnSB-VgK1GFYqlDdcEbkVxl8Bh_Hv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3607a6b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:30:50 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 01/22] remote: plug memory leak when aliasing URLs
Message-ID: <02f6da020f083b3cedcdff192595438ecf82bf56.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

When we have a `url.*.insteadOf` configuration, then we end up aliasing
URLs when populating remotes. One place where this happens is in
`alias_all_urls()`, where we loop through all remotes and then alias
each of their URLs. The actual aliasing logic is then contained in
`alias_url()`, which returns an allocated string that contains the new
URL. This URL replaces the old URL that we have in the strvec that
contains all remote URLs.

We replace the remote URLs via `strvec_replace()`, which does not hand
over ownership of the new string to the vector. Still, we didn't free
the aliased URL and thus have a memory leak here. Fix it by freeing the
aliased string.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote.c                 | 2 ++
 t/t0210-trace2-normal.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index f43cf5e7a4..3b898edd23 100644
--- a/remote.c
+++ b/remote.c
@@ -499,6 +499,7 @@ static void alias_all_urls(struct remote_state *remote_state)
 			if (alias)
 				strvec_replace(&remote_state->remotes[i]->pushurl,
 					       j, alias);
+			free(alias);
 		}
 		add_pushurl_aliases = remote_state->remotes[i]->pushurl.nr == 0;
 		for (j = 0; j < remote_state->remotes[i]->url.nr; j++) {
@@ -512,6 +513,7 @@ static void alias_all_urls(struct remote_state *remote_state)
 			if (alias)
 				strvec_replace(&remote_state->remotes[i]->url,
 					       j, alias);
+			free(alias);
 		}
 	}
 }
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index c312657a12..b9adc94aab 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -2,7 +2,7 @@
 
 test_description='test trace2 facility (normal target)'
 
-TEST_PASSES_SANITIZE_LEAK=false
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
-- 
2.46.0.46.g406f326d27.dirty


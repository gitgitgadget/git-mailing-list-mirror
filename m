Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D2140E34
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996259; cv=none; b=LHkyWnNUOtFf3RQi6PFy27oTCo+oWdlcRSqMXOL9r95g/GVVqtvyVaZlNhvjAuy3owOsfnuPCDqySObkitoPMZNhxFKlQ/nOg4a48M2NdVJEd7Eg2fShQTsE51ao51QQqg1lE+7c1BhQ8fK3sMRpaEfkH8eG7YmzwG3cfQPTG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996259; c=relaxed/simple;
	bh=SzelzelH37sEk5y4Aw4DTz1I3Yz893enRljT3RCFEkY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dwnpg4jmkNvyKIrvxOkT0JEUi71tM+cHarAgCwenz0kSFkCccDcST0iDk1405F+6QXyatamt/y/FnM3XOVVsMBb/Hf7MyCYR71wW55MlsChiLzenORRlRtE/Vg+vMNZrA44huRRCJzkZu+/f1WYP1sKqVRi2T6bHYUdYpdQ08S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TN8PTnEo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VdO2Btbs; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TN8PTnEo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VdO2Btbs"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 82D821140157
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Fri, 26 Jul 2024 08:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996256; x=1722082656; bh=ddAW6VeUYv
	WS2iD8O/EHi6WrPlI6zifUsy/DBLoc5Fg=; b=TN8PTnEooFnJFsgcYxZDbSuHfQ
	C6eLY5fVdU7kAeiWaUTdF9nOeZzZYi0TNDMQHCwa8S0+6x/HxXHpMxZ3FJXtxnlO
	YDcU3qZl+fc7KG9WlTXH0qAIpf0CuZj3v6ZB9y/Ti5hnmS3Ae+VI6lqJR0jXD7Ln
	VdUmgC/54evj3NPG/OMD51B0mDzDItV0NnLP/XoUm0K9ziGZOwoYaxpEeOvv2u3J
	sQsCGMxEAja5P9BAx6uUqaSfEL+7oQvXw0dI7dcYcjRqGihCYZEgtJ907PHvteGv
	TNEF5tjwbrs35emaz8dm5z9+8K2uQYacuEU/1JzzqwSOxQ6JlhOjpL6e5Lqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996256; x=1722082656; bh=ddAW6VeUYvWS2iD8O/EHi6WrPlI6
	zifUsy/DBLoc5Fg=; b=VdO2BtbsCs5t0uXffVNDv9W8CAIdlf+q5xgr8hW6gRhs
	hAn9w+MRx6+WeZ7q4gUett1M4LUKwhCg6t0XxwYapRzX+DN5SSh5GlsYsvDVPQWY
	9ap7QkUD36YjGL9xGtyLDQAmyCDvp4ee2ZUFr80QhCJDkAaBY756FcgAdPR/fCgv
	bOSz2dJJgrC3sgoeoOQpU7agq1duIj6YFOgn/B8w85liaCuK9Nwegl9OQR6fWyig
	YNghw3tK6Om47RlxHjz3Pj4Du+/D8ijZYZrW8aqBysl1vINEAjrboZYiwSJ7m4G2
	Whq3emKbKnrBvnYI3w5C0KeLk9vMokZuI/INzj+oLg==
X-ME-Sender: <xms:4JOjZs2x2DNk8w5rbgCdzp6qxsxibvPr9pd0uxFDfDho4V2bnZkffg>
    <xme:4JOjZnH-87k_bO8rKC1oEAyAB9ayaIF4gy4B0CKhVr39ciJtT87-5VW07uhmftwGn
    4o7GGKjNICXakKEGg>
X-ME-Received: <xmr:4JOjZk40CenIPUHZh-S7CFKek4MeHyWGtTuT4MJL-Znt_CbLLkS-JBk2a-mrXdXLoQKJ0Ln8jlNa3NGDxi5o8nYlnk-s2aLcogk22TtpDtdZlK-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:4JOjZl3FtJ5uvc5108zkfc1m7IafGbWpyt50SkFWIRPD72DB9PRlZA>
    <xmx:4JOjZvFaSdD9zqOaAAAXkAAGZ5RjnpPKWgzrJucIUENIDhfERc4w_A>
    <xmx:4JOjZu_aAuw_k7_brlHfzo_bz98mtBWiiEnq029xVZofmrRtvO9cVw>
    <xmx:4JOjZkmD25YT6OKzNG_yxh8ZDlVlm5hEpX3V7HtmYwlSYUGm1K8nIQ>
    <xmx:4JOjZlM_qiCvUvwBMNb2Z28pfwjE_4EsGDwxMosrX5U9icgYgQIJx-rC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ce07156b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:16:15 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:17:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 16/23] builtin/shortlog: fix various trivial memory leaks
Message-ID: <778e87221ac1d8cc581a8c3f3572810c68686451.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LsdEeTM6MC9Zkyi0"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--LsdEeTM6MC9Zkyi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There is a trivial memory leak in git-shortlog(1). Fix it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/shortlog.c  | 1 +
 t/t4201-shortlog.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 5bde7c68c2..b529608c92 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -514,4 +514,5 @@ void shortlog_output(struct shortlog *log)
 	string_list_clear(&log->list, 1);
 	clear_mailmap(&log->mailmap);
 	string_list_clear(&log->format, 0);
+	string_list_clear(&log->trailers, 0);
 }
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index f698d0c9ad..c20c885724 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -9,6 +9,7 @@ test_description=3D'git shortlog
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.46.0.rc1.dirty


--LsdEeTM6MC9Zkyi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajk9gACgkQVbJhu7ck
PpS9gw/9HilKN/4dL+R4FUI2zMpnR9YTVVZlza4yUYr5VSR2QfdzlfAOd+5UlNoP
PMUegI4zP9fif+lq/LwKUdQMW8VcFWP3amBhZlNipixatJ8Cu3j5z/VcP0damHlQ
jSw3F3AxESwR9KRPK/XBI77pAWLtISSzJH5Ly7IOVU5FgfClLF8KHPh9VSmhaFj+
Fkj6pQ4twQUib9dEPQVllBQ+0jHTWTrxmGOLNFpEcIb+WmBWQzHfp0UAf/4dNTMI
1TFW6XICmS2sjr0ccQawSu/tob2NW4d4AixGyMbkcCf6S9l5f1A1M1NkN6XtXOOZ
xE9UIFKWnCLquIeEmEth42chHA+1jXMHbhdrRS/RQfnOxlQkxcpZRgo2NxAl1gP9
Hczi0OZmgin93X7X0uhuyztAiQ494T4QlshveEggeY634nnWeedhFbui9CQR6M1Q
kvQ/BxMidX2nrXDixjXQQPq8wCWAtITeIQEreB+0RQs6H0yiY9mtzXh+PLKnLXkk
lH7KN8LBdJdXghLeQM2Mf0ieAwp56WH8rR2ENF/7Be3w7/VD7JOL0eFBqIs9Q67j
gt1mZG03i6w2zYvSD0QT83SzmAVqekFUZ8gkCQQok2HTQGZb5cfzkdIpKXcn0St7
dfib+8hDsMVXREtr5+tVBzQ2+WaZZAHoBu+D1f7PMkrxhqLRa+E=
=+ZSF
-----END PGP SIGNATURE-----

--LsdEeTM6MC9Zkyi0--

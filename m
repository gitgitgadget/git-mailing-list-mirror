Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB7EEBB
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764659063; cv=none; b=O4WkO3SP+V2BlvTZsvRn7vZWx06scXrg570m1aw8tLQ5X6rChuXzLjPCNmJg4q7Hwi/nBwJrdnxMye4f9qqyNdUUM45JoWex1vSNJV7WbJ3jdpHdYmqAbz7c6qK//3LgZGAYaCTyG6dWslZc6JyWVdMab2OrIpv0hl2mxZqX6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764659063; c=relaxed/simple;
	bh=mGU6lKvaW0EQ2n5OFPQuM3ECe3oUf9J1yi6zAE1Hk34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H2ukeJWV/qV/WzGx9OSGTIRRuKi0fRQDKgBbCwHgTq68aHzGwrsl9W04tfsVR3YcGo8cNZ94nxtQfKOEbkU1VR0/CftvNYDeaGR8kSFVt0fMSAKG0xZzqPpPNLniijAqbflsU98o/ffu0Zt2fpSE6uQ1toKYgxJvNiN8pklg8GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X03pFtou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=crH/rNUa; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X03pFtou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="crH/rNUa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 311B2EC03CF;
	Tue,  2 Dec 2025 02:04:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 02 Dec 2025 02:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764659060; x=1764745460; bh=VwjI9QOLfd
	xybBMOgzfBPtiPb9KkKyMoPjW722XqZu4=; b=X03pFtoux4abUIc6a8TnAVV2qA
	GqyKLGVmMLZe+1ETzcdTmGMnWVqh9mBrR5FMPRJHRubAGZbjAN+NL+iEkwHVpVlE
	/UiXKd8mKf3Pw83oDefZTZJxoSatzoci2cfVGfPoUGCA0s+SnXPBLAt7bzgnydwl
	sWbJq3thO9d3CYOMc7c0lTgPojhiVphI0aBK4dcHNQRBDH11/2qi5ZTbuyk08y/b
	nTkTvRMqMcZP3PH0eYRQ0nnZ2ibA/kriIFCyB0JE3NaZKeWXXGS6VPV9jnhYN4oX
	jTv6CcsOH9sv1FhpUvV4CsjDahp761OWVJQs1o/5k7AqD13C9HSp/pqvIkZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764659060; x=1764745460; bh=VwjI9QOLfdxybBMOgzfBPtiPb9KkKyMoPjW
	722XqZu4=; b=crH/rNUaktjf+LhJS6MDvuo/9TfZq8u3VrL5YtH+2FMB9CXzd4U
	nGxPowlXifxSE+ZKpstlml2a+W84Wg5AmlHg5o6afvmuzxvob9/7aKOcL1YIad/V
	4F6sqTbgL8g0NCtaMpvA2xWGZ+BF13E8e9MwLX62GLDvosq1e7uqddiCmSxi0q8t
	UEbVYHt95B7Ij69l9gvIdIHd2aJSEJLWwfhcsLBM6Rv1AjWNLHsPQMQclb0Al6AN
	ay5iMx93vt2LC0Vt3QvjYfbUJlvC1Fv0umfQWSumYIWU0slpPv2lOGQNOSb7S+Dy
	CXiCoUDeooGvNi2WzjBoJAUM5yyc/23qfDw==
X-ME-Sender: <xms:c48uaalTQwEYscHYk9ZUtAN7lKIUT54SY07WrokfczuV9wvEidgqIA>
    <xme:c48uaY01zxcCSr9Q6fZsgdx1JjmN4SmNVwY6MJ7Q7XKhkDpM3aD8VpJb82AHt_79R
    O1OTcK_Xh5EI-N_Uy3otP42N4Ima4sVlXrJhIAWUE8HBqUGg2bf>
X-ME-Received: <xmr:c48uadqIPF9UO2SrTgK1HeOLTFPf-v96AddNCicAsliT-xK6Qi_-o3-6EBX0cD4CK3yhOWlGqYVsjLfBHM4mNSWG7CVODB8kOxT_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheelleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepiedugeffiefhheefudejhfelvdfggfeigedukeevhfegkeefvdfhgedugeeg
    hfetnecuffhomhgrihhnpegtohhnfhdrihhnnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:c48uadcu0v3Z_o8d05Tcteqy2B6dPFG7vJLH2KsyBuXxG3d7E1FnDQ>
    <xmx:c48uaUpRCDa0By3YzHi9A5wEviy0dBsw9tfSSr4Rj_KYJWQDY_Ap6Q>
    <xmx:c48uaWFmYeWFnLpqBuW0dlA8KoELY2K-YxZSrgpx0DO0pN15e9Myaw>
    <xmx:c48uacvQyjPoQFZS8wuBqxw5K_EhQD3gsX86Fm27Kb_DFGyelpq-ag>
    <xmx:dI8uaQtpdHI-U5maMpe9OXMBJS6xh3kv0687UAsXhGnfFpmmNEI-zdrf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 02:04:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/4] docs: update git hash algorithm for breaking
 changes mode
In-Reply-To: <20251202014605.52110-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 2 Dec 2025 01:46:02 +0000")
References: <20251202014605.52110-1-sandals@crustytoothpaste.net>
	<20251202014605.52110-2-sandals@crustytoothpaste.net>
Date: Mon, 01 Dec 2025 23:04:18 -0800
Message-ID: <xmqqjyz58ivh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +ifndef::with-breaking-changes[]
> +	The default is "sha1".
> +endif::with-breaking-changes[]
> +ifdef::with-breaking-changes[]
> +	The default is "sha256".
> +endif::with-breaking-changes[]
>  	See `--object-format` in linkgit:git-init[1].
>  
>  `GIT_DEFAULT_REF_FORMAT`::

I wonder if we can have a macro definition at a central location, so
that we can refer to the text without "ifdef" everywhere?

Caution: this illustration of the idea seems to work with AsciiDoc
but it was typed in an airline lounge with rum-and-coke in my left
hand and haven't been tested with Asciidoctor at all.  I do not even
understand why many other [attributes] entries like {asterisk} can
successfully be grokked by Asciidoctor, but we seem to do -alitdd=<>
in the Makefile for Asciidoctor, so I mimicked it without fully
understanding what is going on.

But the patch should be good enough to illustrate the idea.

 Documentation/Makefile         | 5 +++++
 Documentation/asciidoc.conf.in | 6 ++++++
 Documentation/git.adoc         | 2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git c/Documentation/Makefile w/Documentation/Makefile
index 04e9e10b27..88b8ed55a2 100644
--- c/Documentation/Makefile
+++ w/Documentation/Makefile
@@ -222,6 +222,11 @@ ASCIIDOC_DOCBOOK = docbook5
 ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
+ifdef WITH_BREAKING_CHANGES
+ASCIIDOC_EXTRA += -adefaulthash=sha256
+else
+ASCIIDOC_EXTRA += -adefaulthash=sha1
+endif
 ASCIIDOC_EXTRA += -adocinfo=shared
 ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
diff --git c/Documentation/asciidoc.conf.in w/Documentation/asciidoc.conf.in
index ff9ea0a294..2de6b80197 100644
--- c/Documentation/asciidoc.conf.in
+++ w/Documentation/asciidoc.conf.in
@@ -24,6 +24,12 @@ litdd=&#45;&#45;
 manmanual=Git Manual
 mansource=Git @GIT_VERSION@
 revdate=@GIT_DATE@
+ifdef::with-breaking-changes[]
+defaulthash=sha256
+endif::with-breaking-changes[]
+ifndef::with-breaking-changes[]
+defaulthash=sha1
+endif::with-breaking-changes[]
 
 ifdef::doctype-book[]
 [titles]
diff --git c/Documentation/git.adoc w/Documentation/git.adoc
index 8c6a3f6042..f21dbba5a1 100644
--- c/Documentation/git.adoc
+++ w/Documentation/git.adoc
@@ -576,7 +576,7 @@ double-quotes and respecting backslash escapes. E.g., the value
 	If this variable is set, the default hash algorithm for new
 	repositories will be set to this value. This value is
 	ignored when cloning and the setting of the remote repository
-	is always used. The default is "sha1".
+	is always used. The default is "{defaulthash}".
 	See `--object-format` in linkgit:git-init[1].
 
 `GIT_DEFAULT_REF_FORMAT`::

Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B744683CD4
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799175; cv=none; b=MDFXMvO4E+4v5erCBqwsO0ZDzlJ3ROpazQcrJdlHcNqhAhgu0AxyxDSRNxLYaGJhl5X4oNiYBWPzxbbvaLWXSpvuBTm7n5pkF25hclM+5oZ4MaUsDgNTz36awJFMCy29l5W/0Wo5YqIImS7h2UDZSvym4hvGwiGjP4ZdfFi5Dc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799175; c=relaxed/simple;
	bh=1TkYgoocOzG7uPsbmwvmdt5qDQcHK8Ga3mUpsOCDRp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNFFRgamQ/RCt7LgUT50Wm1wJpw4G1U9Xl8WU6gkJz+HmUj5Dr2EfYoLH7MwuFrTDlHQX+FpS9URSYxaI/dNyxsisXslSe5YiJqVvk8M0OxUkJAkfJPfeb/xhBoAhh4h41P1cgdJMx4zcPnd7nsIyM6zc7+6Uhf5HdsWxkkOSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H8J2ppj/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNI47gMh; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H8J2ppj/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNI47gMh"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2B1F3138FCAE;
	Fri, 16 Aug 2024 04:56:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 16 Aug 2024 04:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723798614; x=1723885014; bh=gHUS3gVL+s
	Kpca2Ilo6Xf2YKgHObXGmTG1sL0Us6Fgk=; b=H8J2ppj/zNw1TeR7AjctJpJrH2
	ZYxB9GK77u0xgIQ8aKTNiHmhk+3ydkkhWaqSBOofJpW2B4vCcbGxOt6num3Rn1Kl
	ClzZeQv/Gg6ci26RqPPf8XL1h9fSCMl5N12rU2p0TtpYNvrFEx8GE6qSq5z4LGbe
	Tk4Wwa9jZgUgNu0yOYXdlruZrtB2bTwQBbvc1weoOdOC1LF2WPrOveLga7wQRjSe
	yYo3vSKZoXMbWIw5qIUUIB0uwpF9qIWOtmEraV5z5AVdeNEsCdFckoEGzfFtjX2t
	P5dbPXviHcho22yC+3OYmyn1Tn9ryZfiRcAEcfj+k8jw64Ty/3jMzkIIMH4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723798614; x=1723885014; bh=gHUS3gVL+sKpca2Ilo6Xf2YKgHOb
	XGmTG1sL0Us6Fgk=; b=jNI47gMhjo2TtwNRBEFVMfuPrjq0xOfw2Qa+zC7/rDCB
	BCXVCbbWqspOHciYhCSmElNiYbgWX6WxGodDoBhxTAhv1PZ783MThGMuIC1mdXKP
	bNXuh3jo08vRKhxfwDx55Rf6Dx49OgW4OV3oJKXRlve8dZfD0TTHf0ayDknAXpUQ
	L9Bs7FnorvDdllntLdDJNGv80rCShRwECCjGfXc8xMa3Ur+cTq8CaiDBj3uQ+RPg
	KPqhuZgSnx+D9ZknEOjh5U+JzvGmcmiqBYvVM7qLoerL4jCN4tJvEkS75nCzrG+q
	2AC2A5Ltv8xDEd5F49lQGEVmxdaKvUdYBsdTyuysJg==
X-ME-Sender: <xms:VRS_ZsVPk4u5aCzLVHn2eMDP6OMQt2xMnSU1E4GRI5yiyUam9EmHvw>
    <xme:VRS_ZgkR9m7mtyFne8JN42VWOy_FaBJj2cfUsT-18_n0ot23YTAtwu3J1MUAdJWo-
    LzGTMPE4nEbaQpNzQ>
X-ME-Received: <xmr:VRS_Zgavv8uAz8ALZgiEQ1-ZDtpY1t0ItsKUV22e90kgmKMMEv-Pi6PWXQ9Ywf_g9GxgPMNvm7aSVeJskr8A90ii_t7nyiOkmOO2G2p5c0mX5y8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshhstghhuhgsvghrthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VRS_ZrVVSMpltVyK6Gy4VRUldzD1lSevV6ljR1YvLyd2-0PRcp9H1Q>
    <xmx:VRS_Zmng7FJKX-TFWxMI-9uT-7c6mxL-6zjfZ9knx9UP9ymBLFrKuA>
    <xmx:VRS_Zgd_LJDGzq2jWA5NJFpIC8XYYStHYC9pdQ5y1TYKf9NpY6Ti4A>
    <xmx:VRS_ZoHxI_yIJQlmvqe2njNCrIRwhTzc59dVbQ9aNYfaSniDiF_09A>
    <xmx:VhS_Ztvoqs5E8FuBTmTZL7RiaE5lit3XdbktyT7nzlvBgAhhnXbgDToQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:56:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 34d3dd12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:56:28 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:56:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/5] Introduce configs for default repo format
Message-ID: <cover.1723798388.git.ps@pks.im>
References: <cover.1723708417.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723708417.git.ps@pks.im>

Hi,

this is the second version of my patch series that introduces two new
config settings `init.defaultRefFormat` and `init.defaultObjectFormat`
to make the default formats configurable without environment variables.

Changes compared to v1:

  - Extend commit message to mention that we also move
    `repo_set_ref_storage_format()` and `repo_set_hash_algo()` into
    `repository_format_configure()`.

  - Extend commit message to explain precedence.

  - Fix a grammar issue.

  - Fix a copy/paste error in the documentation of
    `init.defaultRefFormat`.

Thanks!

Patrick

Patrick Steinhardt (5):
  t0001: exercise initialization with ref formats more thoroughly
  t0001: delete repositories when object format tests finish
  setup: merge configuration of repository formats
  setup: make object format configurable via config
  setup: make ref storage format configurable via config

 Documentation/config/init.txt |  10 +++
 setup.c                       | 101 ++++++++++++++++-------
 t/t0001-init.sh               | 145 +++++++++++++++++++++++++++++++---
 3 files changed, 216 insertions(+), 40 deletions(-)

Range-diff against v1:
1:  0d3844db32 = 1:  0d3844db32 t0001: exercise initialization with ref formats more thoroughly
2:  6b0cefef6a = 2:  6b0cefef6a t0001: delete repositories when object format tests finish
3:  16f52b75d8 ! 3:  ce0fad88bb setup: merge configuration of repository formats
    @@ Commit message
         or read the config multiple times. Both of these options feel a bit
         unwieldy.
     
    -    Merge the code into a new a new function `repository_format_configure()`
    -    that is responsible for configuring the whole repository's format. Like
    -    this, we can easily read the config in a single place, only.
    +    Merge the code into a new function `repository_format_configure()` that
    +    is responsible for configuring the whole repository's format. Like this,
    +    we can easily read the config in a single place, only.
    +
    +    Furthermore, move the calls to `repo_set_ref_storage_format()` and
    +    `repo_set_hash_algo()` into this new function as well, such that all the
    +    logic to configure the repository format is self-contained here.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
4:  e1cdaf0f0e ! 4:  8508662062 setup: make object format configurable via config
    @@ Commit message
         "init.defaultObjectFormat", similar to "init.defaultBranch", that allows
         the user to configure the default object format when creating new repos.
     
    +    The precedence order now is the following, where the first one wins:
    +
    +      1. The `--object-format=` switch.
    +
    +      2. The `GIT_DEFAULT_HASH` environment variable.
    +
    +      3. The `init.defaultObjectFormat` config variable.
    +
    +    This matches the typical precedence order we use in Git. We typically
    +    let the environment override the config such that the latter can easily
    +    be overridden on an ephemeral basis, for example by scripts.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Documentation/config/init.txt ##
5:  a0417b7d1a ! 5:  b68a841450 setup: make ref storage format configurable via config
    @@ Metadata
      ## Commit message ##
         setup: make ref storage format configurable via config
     
    -    Similar as the preceding commit, introduce a new "init.defaultRefFormat"
    +    Similar to the preceding commit, introduce a new "init.defaultRefFormat"
         config that allows the user to globally set the ref storage format used
         by newly created repositories.
     
    @@ Documentation/config/init.txt: endif::[]
      	and the `GIT_DEFAULT_HASH` environment variable take precedence over
      	this config.
     +`init.defaultRefFormat`::
    -+	Allows overriding the default object format for new repositories. See
    -+	`--ref-format=` in linkgit:git-init[1]. Both the command line option
    -+	and the `GIT_DEFAULT_REF_FORMAT` environment variable take precedence
    -+	over this config.
    ++	Allows overriding the default ref storage format for new repositories.
    ++	See `--ref-format=` in linkgit:git-init[1]. Both the command line
    ++	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
    ++	precedence over this config.
     
      ## setup.c ##
     @@ setup.c: static void separate_git_dir(const char *git_dir, const char *git_link)
-- 
2.46.0.46.g406f326d27.dirty


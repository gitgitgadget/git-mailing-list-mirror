Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376C15442C
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 05:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742968492; cv=none; b=hhrcuWRsDQbak5uyL0Lygc21t5xnuUYyTzeNd4rWgFlsVseYUxMxdpbbDCvutypcUq2RR4seEQoJnNbXHhteUTj4Il7lzWI8gxTLSdQF9llSSsasyzRLbVvIhA9wy9BNWTRtNVLMQnHLM/CGd2myjUieX+H5/0iS/rU/+Kgbuy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742968492; c=relaxed/simple;
	bh=kYiOFNsZ//uk3WrmJxTlcA3hDBDX5t3ruUbt1NAPaUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usfcJPplN/vPH48La4gOtrnTJEUHMZ4wKgtrjKHxgvV0b8J4K0wzVa/cu/Ho9VOOewNqeoDI2tEr8VKIlfZx+YMaK6xKvJBWYioCgljEwyRfBcQIahDsEihGUezfehG4v/60j/8Zs7J8zhZay/uD9R/DENA+pmVuOxK0Udd/ssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kuH3ewYQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OX2hIx0t; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kuH3ewYQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OX2hIx0t"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 33CDE138380F;
	Wed, 26 Mar 2025 01:54:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Wed, 26 Mar 2025 01:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742968490; x=1743054890; bh=3BTU1IEQbW
	9xdoErlzww1ZFNrBSex/7xo+VAtnCFdYw=; b=kuH3ewYQwPiGHcEsnhnEgw8/kY
	LQJz5hR1DO1zjUAsgzmZMETqyzmwFNuWBRArYfmRQjC0uRUXzZ5BsQ+d6iIj/NAr
	6/Y3Hq4H8YqqxHc7A7h9to3DxtvexGz57yF82OGxXUc0ZA1KPFpRB1Surg9pNQTJ
	LnjgRrdJZupx42YEYYf5bqcduVFOyH/3j01AJN/Jb+OxGT9hKED6+B8cI7nGQ39r
	Ma7chijIm55TmbgZ8IAn2Jqb8nV73KFGtahrqJHHLCPr7dfoXQ7kpoGTcNeIMPQo
	5cE3nT0CLIFnvxqaSdfYGzdRvDegVgySWMQ9jBIuEjhp5V4NqMZUu2Ve8GSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742968490; x=1743054890; bh=3BTU1IEQbW9xdoErlzww1ZFNrBSex/7xo+V
	AtnCFdYw=; b=OX2hIx0t8hakmxWycq0bvtsDmshAuDX4jKD+XygHAXh8xwx/mju
	zCkyj1U5wKsijlVS9T7lxomjzdEcis6lox580OwdH72pm5KIacOCoGLIvQxJAzzz
	UmGtG80VXAG/rQk/0notNheP4oRUXXESh+dhlHsNb2D5gxtiyU2LODJEZiGprd3p
	6fPQq9KaZ4TAqOTnLbtbB5XNPfcF5kL2j3raGeTXcA8hW6f31TYR8wHo3Vh08Fjc
	NT2zsEgUhfq49anrYDyXiIzUSyVgIqVriIYbe9Dm2W6f7gVWlwIU4Ib7Ayk4PsGc
	Zef0Dpvo0S63cBJTYz4Eh9RBCJN1Mux5VTw==
X-ME-Sender: <xms:qpbjZ0Z7somKyA4LtNYxoipWFfsZQVbj_6aKuxETam-uef981gzl2g>
    <xme:qpbjZ_Z8PZwmKhynIbA21_6HOcHPc4aPVP0rwh6oWrS6CAVESaO8dayFKEFkc9Lfk
    x0yNKYG4d8Ma6orlQ>
X-ME-Received: <xmr:qpbjZ--Qm0IhIpUr0el8hh32hWV1n7jB-jqYP357Wmd6UHKYWy6Upo_zkYNCVWVaiALyDyL0D-I5JG_R--rpzyFqCEiMKyISfIcEhLtiLhLJUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepleelteegkeeftdevheetheevteekhfejieffheek
    hfdvledufeevveevgeetfeefnecuffhomhgrihhnpehmrghkrdguvghvnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghn
    nhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhlihhpohgrkhhlvgih
    sehivggvrdgvmhgrihhlpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:qpbjZ-rbqkNaWCm-0DfpblUSg4gUWJRO6PUJJjahK2Mhiifek2EoWg>
    <xmx:qpbjZ_qiTzWBJgExgZNTP7k1YMnAqrXWwBcMkQ0fWYWvGYxnkzow0g>
    <xmx:qpbjZ8Scs8rxS7_xpB6SCIk5nP-R15tqDu9P5w75rBRRt9ofGbo4Cg>
    <xmx:qpbjZ_pon5xc3MtYgTWGJJEj6rmMol7g5gY2XQosEXkLQ-rAKvNw5g>
    <xmx:qpbjZ7IwePjIWNlvooEF9AzW7HVmVLbuEsuyQhyFwQ5lKDnxq8mbgqiB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 01:54:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a4d64cfa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Mar 2025 05:54:48 +0000 (UTC)
Date: Wed, 26 Mar 2025 06:54:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 09/10] clang: warn when the comma operator is used
Message-ID: <Z-OWp0NkjrMVQieH@pks.im>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
 <91f86c3aba9d19d5df11661675fd6c2cc049e191.1742945534.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91f86c3aba9d19d5df11661675fd6c2cc049e191.1742945534.git.gitgitgadget@gmail.com>

On Tue, Mar 25, 2025 at 11:32:13PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When compiling Git using `clang`, the `-Wcomma` option can be used to
> warn about code using the comma operator (because it is typically
> unintentional and wants to use the semicolon instead).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.mak.dev | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/config.mak.dev b/config.mak.dev
> index 0fd8cc4d355..31423638169 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -40,6 +40,10 @@ DEVELOPER_CFLAGS += -Wvla
>  DEVELOPER_CFLAGS += -Wwrite-strings
>  DEVELOPER_CFLAGS += -fno-common
>  
> +ifneq ($(filter clang9,$(COMPILER_FEATURES)),)
> +DEVELOPER_CFLAGS += -Wcomma
> +endif
> +
>  ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
>  DEVELOPER_CFLAGS += -Wtautological-constant-out-of-range-compare
>  endif

Let's squash the below diff into this commit. The loop already makes
sure that the compiler supports the flag, so there is no need to special
case Clang.

Patrick

diff --git a/meson.build b/meson.build
index dd231b669b6..a7658d62ea0 100644
--- a/meson.build
+++ b/meson.build
@@ -717,6 +717,7 @@ libgit_dependencies = [ ]
 # Makefile.
 if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argument_syntax() == 'gcc'
   foreach cflag : [
+    '-Wcomma',
     '-Wdeclaration-after-statement',
     '-Wformat-security',
     '-Wold-style-definition',

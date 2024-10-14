Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA91A76AC
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914808; cv=none; b=jCG3mwU5itS2ER1gWM8Lullm9nfFpKsgrB71wz0GA36P+rAGzELqG/GgB90OIRrk8qPJV4OZPEd473xXvyJ/t53wjwPEkkbF5fdK70rLlTbs5WW/TZlSHCftL1m8SUaGDQUriqJ6b9ToMKOuatOfiHkm2Otfw2PukQ7mQVFe+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914808; c=relaxed/simple;
	bh=g2h1SY4KKojm+dt2Ebq8N4SKOQdDDaEZzlEAlOr7vuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxSefAuGs+tuCK8KC6XKNXhEKKTh/NMYq82hPdWEqXctNvFjKDMkn6VOYD2j6FiYGQG3fRbK+65P9S6OUj6S54OP4n8b9/+w3YGxQLINPF1nVmMzNH3OORak7hLx6uVtI+FpDfTA5KlE4kShp8yRvCgjeeHVNQBqr69Q/rDe0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CDpX6s16; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y/PGKOPc; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CDpX6s16";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y/PGKOPc"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 767D6138021B;
	Mon, 14 Oct 2024 10:06:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 14 Oct 2024 10:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728914805; x=1729001205; bh=68m9ijrE/u
	Y6+mNvj6yoodeDgX8Bc/zBWxKCbXUArbI=; b=CDpX6s16pO6SBKogQ80p1fG6ib
	JMDvczyGZJEbHAHlvhdhkc9wSxxElrSXMCwHE+cW8xnyiDM184lj9mFm38c7KPzY
	lhnVqMQjQhnLHHYNvNwRqfE9bOq61OQvRzACu8ifHC8NNbG3jbFvMaVa2P8NQdMu
	uEgQMcOCbJCDYTRqG2+shCFpYTHm3sWA1ZCRboai6P+pSxquPYYZwo85YHWbku2H
	Tx2tCchtVfAiSUd5NyHFd1PaYXdjsGmcnTo2t50tp5+ZJwYp75DDXeGsChgDBiWq
	Q+TkruzZZ1vQX+se9qV582tChV7nGT14OrwV3ANIVDaFGPXS28ZnW7SsVZZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728914805; x=1729001205; bh=68m9ijrE/uY6+mNvj6yoodeDgX8B
	c/zBWxKCbXUArbI=; b=Y/PGKOPcHe9/f8T8S7a2EUR2XC4qvjJWv4mfIvHU1DwG
	FOK6OFu9I4C5z/iBb0vGmAy/ITYX3WQBZY4n6wH33fX/zSfsWcOUzz19Y/ZZyigC
	F2w/MtuF+9BGYrF0+ILqChPqKxTfMWXOaeygwTaTM0YLrY+a68M/P5RzD9rQ0r0d
	6XRTQP5MrOUcN1941wjAAqcRqtT9xT/JXNF2ZCYxovbR4H5KfGEIMTaEfssG5JsG
	LMKhcRHUdUBYeG5+ywgQyLOAJ9qA3B7k/6KEx5NYi1Mx0WZMjT3OtrCEf2D5+HPA
	nt4GPW3xQfcgMBp619Yq9KrqSOJDcki47+QiBcQbUA==
X-ME-Sender: <xms:dSUNZwBYehKMcYHyZO9hK0h8_XowmAGy_DWBTi6RvQzqxWOIacy5oQ>
    <xme:dSUNZyiUHTFOAU-qVgTCMVsPssvBocbXQDVVe5bcLcYUM0bWLpLRpBh61nnrUOvP6
    _lmiVj4csPmWhbJJQ>
X-ME-Received: <xmr:dSUNZzld9Lj129vzVDgP9JEsj8tYaoFiB1aINvpq5JI2s_lD72MvxImPBO-4G_9nXrEkBXAKXd3YPWgg5_IIzK5dn9CiPJ4XUL8m57fxixgbCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeffffevheetudekgeejtdeuhfejgeehtdfftefggeef
    leejfefhgfeuheejhfdvnecuffhomhgrihhnpehpkhhsrdhimhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvughrvggvlh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidrug
    gv
X-ME-Proxy: <xmx:dSUNZ2xTPO-hdyLgXimukzn1RV1nNwX9OYuCnXyB6SU8EQVdpy63Aw>
    <xmx:dSUNZ1RRdtt9zLWLoKfRx9NvBxegSSKkShZUSaRkPMTs0XMWI-LkUw>
    <xmx:dSUNZxa1yBC92HnHiQMW6ZlFGE6zOyhMRzr4C2OkGCdYyQ6SN-oXyw>
    <xmx:dSUNZ-RvDO_4mLKrDHbCjaxyU_qmi7i0jJlPKGWXSNn2umUmPzUHVg>
    <xmx:dSUNZ3dnLo5e8g0DJ20nF67ZBPoflTuciZxXgSaepQaECMoIy5iypeR0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 10:06:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6320b480 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 14:05:27 +0000 (UTC)
Date: Mon, 14 Oct 2024 16:06:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] cmake: fix autogenerated clar headers
Message-ID: <cover.1728914219.git.ps@pks.im>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>

Hi,

this small patch series fixes how we set up autogenerated clar headers
in CMake such that the clar builds again. The underlying issue is that
we accidentally added the source directory, not the build directory, to
our list of include directories. I guess this went unnoticed because if
you also happen to use Makefiles in the same repo, we'd have found the
Makefile-generated headers by accident.

The other two patches unify the infra to generate "clar-decls.h", which
has basically been pulled out of my build system modernization patch
series.

Taylor: note that this conflicts with the patch series at [1]. The
conflict can be solved by accepting the Makefile of this series here and
adding the following on top of "t/unit-tests/generate-clar-decls.sh":

diff --cc Makefile
index 87b86c5be1,0101d349f3..0000000000
--- a/Makefile
+++ b/Makefile
diff --git a/t/unit-tests/generate-clar-decls.sh b/t/unit-tests/generate-clar-decls.sh
index 6646a90f71..49c61d29b3 100755
--- a/t/unit-tests/generate-clar-decls.sh
+++ b/t/unit-tests/generate-clar-decls.sh
@@ -13,6 +13,6 @@ while test "$#" -ne 0
 do
 	suite="$1"
 	shift
-	sed -ne "s/^\(void test_$suite__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p" "$suite" ||
+	sed -ne "s/^\(void test_$suite__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$/extern \1;/p" "$suite" ||
 	exit 1
 done >"$OUTPUT"

Thanks!

Patrick

[1]: <cover.1728903464.git.ps@pks.im>

Patrick Steinhardt (3):
  Makefile: extract script to generate clar declarations
  cmake: fix compilation of clar-based unit tests
  cmake: set up proper dependencies for generated clar headers

 Makefile                            |  4 +--
 contrib/buildsystems/CMakeLists.txt | 52 ++++++++---------------------
 t/unit-tests/generate-clar-decls.sh | 18 ++++++++++
 3 files changed, 32 insertions(+), 42 deletions(-)
 create mode 100755 t/unit-tests/generate-clar-decls.sh

-- 
2.47.0.72.gef8ce8f3d4.dirty


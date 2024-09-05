Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404919DF75
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552340; cv=none; b=Uk5Cp4SO3KmIiiGaskho9bUtNsk5W1paAiIJyAOpaIG13dYp2Eko68lNb7lM2EpROtsmarixZmLY2ESzKhLG7SAFgChur7/UGfianu0WYuVyvog9xCgwQv/nVgapg7KeP8+6bYdVhd/xsrBwKOsgfsqCwUB52F4yU5s/hGyjc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552340; c=relaxed/simple;
	bh=WgeIbGpuZI0zG57USYmsJdg5vt5g6i+OjQ7i0GNeWhU=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=YzbyA6iD2eqQs3tH24hD1TR8HlOYoDPBKT0l5LjvC1CGzsKGQZBgnyaJWXTcpNv4P/fc06pqKL9hNO9ytHoJAhz/u617GgK2qXn8KvbvKxNHG1lxZFgi1kp2UxoZgbwqug4QaPzHW8BziIkZxrWEZoIEGMSRIR7aOL69IHlPciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io; spf=pass smtp.mailfrom=alchemists.io; dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b=xAt7jlpu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GVOHueFP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alchemists.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b="xAt7jlpu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GVOHueFP"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3039F114025D
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 12:05:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Sep 2024 12:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1725552336; x=1725638736; bh=mf
	rzJ+hD0CvT7FGbdC9G4xavSgOQMe0iPBoRYr+JXHQ=; b=xAt7jlpuWTDcn9/1Ic
	S/dhp6UqIM1yNXSIXNeFCyIOuJgWRUveUuPMzZSsbHTpgLwCAtNfsYpNJNKzysaK
	iY+KWMiccxKNYUKsj/fH/emnp2QjPLE8kjHvUx1Fooe1BjtGdOAlClFHuwjmelMM
	CHOLXxj08hTxUDvWqMn2GGJ9bQqQUlnGoD/Lijewb21PGIgUFYqtfJ1b/4SMcWM1
	Tadkhre8n6lgFGSD3ftGnX7LyjAyfYrIKQmeOCobSsLe8aI7hBT82caBcBY54HQ+
	t8edpT5S+/hUihNnQUWig5Ls5OVzCzooP/BBqXRWvRSiUm4X5m+uE91NWOygQIrT
	IMZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725552336; x=1725638736; bh=mfrzJ+hD0CvT7FGbdC9G4xavSgOQ
	Me0iPBoRYr+JXHQ=; b=GVOHueFP17UZP4L73ViKLr4vynYevq0W1z0jZg71KKEt
	yioNGdT8+d4+W5NSacA2T19X3z5ESZ4gPD8mRq2vlDly9GL3MlbHiFfWCIdP19Wy
	fdxoCvs0d7fk/G4sysp0+mIwl1yOYQPw0TnhhTWIdNA6eit8J4GPGC/8+raqprdo
	wZfPex2Rp8J4XYdpyBkkFeux/u35sSJFoabuFZAQzDIFgNd1uej/bmO0fNA79w9u
	Ut/z3vONS5VwcIjrOortjvRQl2CQNtT+T11xqaQx+hVMk0SJ55PDo6/9Qy8qx7ym
	suphpFmrly5ppCnvvi/+RWPxtdhKKPIuOVIZICVYQA==
X-ME-Sender: <xms:z9bZZrihH2YSq2WbPf1XFnjXJprEWwpCLI_bRxo6LkZOfJVPk53YNQ>
    <xme:z9bZZoBHWdTjx8OwuZnWF8k1zldN0TKSaC5SRBhYYnjrx5yW_onArnusiv3gEu9Cf
    D12R2ngvXthe0Ky>
X-ME-Received: <xmr:z9bZZrHJoIH6nAQoASl1i4BU-xq1bInjvK6djFEUETDrsX8C7JJBmC80gQ_fFtRfkSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhtgfggg
    fukfffvffosehtqhhmtdhhtdejnecuhfhrohhmpeeurhhoohhkvgcumfhuhhhlmhgrnhhn
    uceosghrohhokhgvsegrlhgthhgvmhhishhtshdrihhoqeenucggtffrrghtthgvrhhnpe
    eukeelfedtgfeludevgedvudfhhfffgeduhfduueekvddtfffhffehieefheefudenucff
    ohhmrghinhepghhithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsrhhoohhkvgesrghltghhvghmihhsthhsrdhiohdp
    nhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:z9bZZoRSuljJTCc0A4TnoYEYw56mwG73o9cR1BBlb96SCMAkVx7aTQ>
    <xmx:z9bZZox-a_On0usA516fglVw-PbskMt4uA96gQ09jsfCdlXRCC5stw>
    <xmx:z9bZZu5FbcqmCxntnIVH6E-TcVqq4hh6HNDt9Tiz82FiVvqZVu3Bzg>
    <xmx:z9bZZtwrYKuLydGOveumGTKhXTHJD5QnpRI6MouLbx2TvwdNopCEdw>
    <xmx:0NbZZlqqry1ukpQuRv1SIm-uKtrmItCyDP_HUlpf24_DtoYrd-gg1d7Z>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 5 Sep 2024 12:05:35 -0400 (EDT)
From: Brooke Kuhlmann <brooke@alchemists.io>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Should Git Tag trailer formatting work?
Message-Id: <E46F3EFF-66D1-4B29-BCF3-6FFAB2504411@alchemists.io>
Date: Thu, 5 Sep 2024 10:05:24 -0600
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51)

Hello. =F0=9F=91=8B

With the recent release of Git 2.46.0, the ability to add trailers to =
tags was added which is great! However, when attempting to list and =
format trailer information, I don't see the trailer information display =
using the following Bash code:

```=20
git tag --list \
        --color \
        =
--format=3D"%(color:yellow)%(refname:short)%(color:reset)|%(taggerdate:sho=
rt)|%(color:blue)%(color:bold)%(taggername)%(color:reset)|%(subject)|%(tra=
ilers:key=3DInsertions)" \
        | column -s"|" -t
```

Notice that I'm using the same syntax (`%(trailers:key=3DInsertions)`) =
as used in the git for-each-ref =
(https://git-scm.com/docs/git-for-each-ref#Documentation/git-for-each-ref.=
txt-rawsize) documentation. If it helps, I also create my Git tag using =
`git tag` and formatting my message as follows:

```=20
Version 0.0.0

An example.

Insertions: 10
```

Shouldn't the formatting of my git tags pick up the "Insertions" trailer =
key and print it? Is this a bug or am I doing something wrong?

Thanks!=

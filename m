Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129415477E
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709630; cv=none; b=Xuv3AVrs/7zWqDTs0QdjRkuQAtBUEXK05THoOjLaQJs719Jli8WMjhHAvqDnqO6HYFUHPhRU5E6Oiy6ZZIfuTVHqui+y1Bf4RnA3IkaUfPr+wN49cb2JKXO4UbeQVMw5bw3zU+SkgDUFkviF+fEBz9JrGIzRj6E/zaKiHAVN7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709630; c=relaxed/simple;
	bh=Fps7NKHAocHk9miTXmO4N2eFNurl6BpII0nofVfyNAs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H0Hzr74F7q64atYeKx23SC5t4QbWsLlbFhcmes1i7IettlHf3Y3SPTJ9Ez6kppNBkF2Vys/rxUGPM3nru/MEHli+nRKXzuFCDS5yz48BDfGjX9tlznn7djrymkFCrrdJ+edz3OkAbSKOrZP8IGTVowuDuZjb4D6NUTM/T0Uydi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oBclvuvL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XAHZrhS2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oBclvuvL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XAHZrhS2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 161427A02EE
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:20:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 05 Mar 2026 06:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1772709627; x=1772796027; bh=oPI23WW2QV
	V9DHc2m1yX4eScqZFuutskT1bfYfpfb4M=; b=oBclvuvL4oIIuGs59P+zBxGwgQ
	AU9bSGWmBZMSzBREytVA6mYG6SAAvfZGjjfi/9G+4uuMpOM95T3+LRy54ghQ//xO
	Zin/RaBbYyx43P5GsvtWmWUAFe983eJy0gS/DLQs09+zGiuiVHaglt1PW/MggCEq
	8qNp8Kf1j3s+pXkotqbnqINt9bDEaBsX5RVj2VTUmPLIQSO+USY9p3K05vgTNW3C
	WRkBDhD5BZ45XR95cFuG/+uaWxR4WK02Kinjw3MgDG8shvgYcQW6gNs8mOv6cjvE
	9OCAGgRupiGfEWR8QDRiKLjN8BccshC1b8AWVytF5aTI9oagBvUEPhGFHZvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1772709627; x=1772796027; bh=oPI23WW2QVV9DHc2m1yX4eScqZFu
	utskT1bfYfpfb4M=; b=XAHZrhS2XGYCjHJo8CdCnlA38WyqIVlBerSH3CF9Mzbq
	RJAukKv+mRRDWWYpzO8QwolWSCyYg8crjbVnwIisiYckbXvmSXOUwVugBX9kZyRa
	QIh7WBxdnVGBvvWzOZRb4M8OYoGFkGNofyseg+JDrlTzrlYBV0OFykJPqW2OJIru
	HaqvskmRoTd5lXT0Qn80MTquY1LdP5yyVb0CN69uOit2qiZoWG38kVAGGv8M5n6v
	bCbD2+SFjIRZ5cI0mZj/TB4jb2XccgzAvGSkFqESeOCrNirOLK8TarVp5YkywWVh
	tWTgR6n/QTlVsxjhpTwWNCIYsrBAPyL2MFu//Zdhog==
X-ME-Sender: <xms:-2apadjaHHBhyhHgmkXX6ZYZHuCtBc8oLzKaBLdEwYcTdVLbgz5bOA>
    <xme:-2apaY9Sp14vollbYF9Ji1c_81BDUdxn7zOhj2IaXHFoCx5ZV5NINNxenOC6pcZv1
    ZWTuiXGZA1vzW_KxHmSB-T8y4L7u64Jvrgjilr01JMdvhH5WSXk>
X-ME-Received: <xmr:-2apaSsMYTsedmPCRPfTCFXTTDzxinESGehtj-qjFGub1Or5ZWuymMdbN7J1us3499X4TUClfBwp8t5s-nmAzOBJ6XBtb7jr815PwLRxu9XC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeivdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:-2apaXZRWmNSMBAQZknXm4nNRq1EulYCauh36qb-eg7GusmumgEwKw>
    <xmx:-2apaaqokYCJghOIOwuK1rUXmiakn-jmdX6NgC8r3n0vR64wXCz1XA>
    <xmx:-2apaU958EVrxDxJFjUPYqTTNaxXtsrOIIOL58Am5yw9-gVN6UKIFw>
    <xmx:-2apaR-qMzrPfKop_-iUZMn3Xsc0gB7aXF3cdtuYT9Qi12XbiXFCnQ>
    <xmx:-2apaRlMgMe_SUn1Pw5OjhU9Dfm4oElJun826nB7YUki9z2Kq-c_nNon>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 5 Mar 2026 06:20:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97d04264 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 5 Mar 2026 11:20:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] gitlab-ci: update to macOS 15 images
Date: Thu, 05 Mar 2026 12:20:20 +0100
Message-Id: <20260305-pks-gitlab-ci-macos-16-v1-0-ce8da0ff29c2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPRmqWkC/x3MSwqAMAwA0atI1gZqlaJeRVzUmtbgl0ZEEO9uc
 fkWMw8IRSaBNnsg0sXC+5ZQ5Bm4yW6BkMdk0EobVaoKj1kw8LnYAR3jat0uWBikpjZ68ERaGUj
 xEcnz/Y+7/n0/D6smSGgAAAA=
X-Change-ID: 20260304-pks-gitlab-ci-macos-16-e9862bfee206
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

this isn't anything urgent, I'm simply trying to stay ahead of the
upcoming deprecation.

The update uncovers the issue with broken iconv that we have already
fixed in d0cec08d70 (utf8.c: prepare workaround for iconv under macOS
14/15, 2026-01-12). But for now we had only wired up this workaround for
our Makefile, not yet for Meson. So the first two patches wire up this
fix for Meson, too.

Thanks!

Patrick

---
Patrick Steinhardt (3):
      meson: simplify iconv-emits-BOM check
      meson: detect broken iconv that requires ICONV_RESTART_RESET
      gitlab-ci: update to macOS 15 images

 .gitlab-ci.yml |  6 ++---
 meson.build    | 80 +++++++++++++++++++++++++++++++++-------------------------
 2 files changed, 48 insertions(+), 38 deletions(-)


---
base-commit: c1485ce6c89b3d33d32bd5e940432d30885afdcc
change-id: 20260304-pks-gitlab-ci-macos-16-e9862bfee206


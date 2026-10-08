Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EAF4915BF
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453705; cv=none; b=XFKz1F/KjqDJlWM3WqsdO14QINmqC0sLB0nqDZT1DWXflJs94cy/3L2uhS4zMpHuFBXcMTK+k5LX72oDzPgWfRqYlhWUnqqStIFFYLqmA+6u+5Zqzkzte14yAPaCFv7Cp2LLAJPLxfeOlvUKZ2d7obwi4a76J177GSxCnVbUxwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453705; c=relaxed/simple;
	bh=WbSxTVGFpwWWq8nbkAG4wGNBvXcWFHoo7McWc3CkWzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H8agIAIsd+Dj05DyVHCuM3xboC5Wzyb8JmaFYC8SHw8BF4skvtVOW/LmQUbPmjZNu+OyPb51H3ZbaWXtpqfG3xHAvPPsdZAG+Ak2ylXyDgAjvAxlAlkmf+uaBGvLbVCtfRCB2acmOMczvclxNPzs4OIhXRkAw+lwqizn/9QKrnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A77Wt/x9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M9PXzw4B; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A77Wt/x9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M9PXzw4B"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 25B2D14000AF
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:01:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Oct 2026 06:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791453703;
	 x=1791540103; bh=D/KhpiH3aAVL6kCP53zLkX1o09nbKidK/X/8dVy+ugE=; b=
	A77Wt/x90L23LWk7Fnko9PN0cmMLNFdrluv/ExI65FSUl7Fuz2oofbXd1i2l1CA0
	ZkrlcuQL9HOSO4ZvelUMhavjXSXqFnEkHZHOmUd7sHjXO/2gvwNNCB8sYstXEWo+
	J4J8Ijm1hN19+IiAbD4cN15U236rqqHAwTQmW9mcls21dt9syCDZXj4+xxg9ofQW
	dghWWTssppbSoRL1qmWUV141sdowLEdKhD1AsEeIT/iGLVxWpN1nkWi1kw1VAY6C
	IrQzuaBR2uwDsNu77gc9AAoSFZ1r+xa/QEeFYENRPNtGS88Qg+nTz7Jo3OXQv7uA
	KoWR3cbqM+VC/H4fnBTHXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791453703; x=
	1791540103; bh=D/KhpiH3aAVL6kCP53zLkX1o09nbKidK/X/8dVy+ugE=; b=M
	9PXzw4B0JRezRKzg3jMGmvNJJzWK5Y648p/ReOIjTkvKKVdWDpRLBHh5NP7kq0Wv
	rXdAeJcz3o9Cc/VSVYIuF7rO2V6mIjA7J423kxQvPC1K00FVCCXmPPuapSf7Q5Ow
	FOfEXEUu/2Ttv4Dr4mb107rJBfQzOCc+Py2aT+DUaWYU362oqlLkhQIMEJGU5hV3
	PGjEtL/2kQyGg+LQwKRvBSyxyPs7gbpy370R7/J0jxYq7HSp03nfBvSPvkTeescV
	jhvEjDdGLfHCks3d/34ihAJ2l3t05IuCcd0RqTDRi3GYYtQwGaTW5KE5r96i6gRN
	qNxEuF4IFnTsJgfRUIYNA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791453703; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Jg/B0NHRuuVMVvmyFQm3G2rGmzARxThq3ohbMUnh1pnPePh
	cHFcY1ZCZUd4gfzVz05mFK9a02QIpsRW+ZjM0AG9B+4nzfRdtmWvxL1ft8GgFgxB
	CtJIPspxeJYmipbY4WPyX5XPt8zF+aV9lhgmQ5IUvvcSrjPZaCjK5zhbGQPB1z5b
	b8yJaYPIO6xGvlZAJ8dFZbZn93LTGnIjy1QhfVNxTgA2vSe4SMckxyDXns+wgX1B
	+Eor4tsJwXmxHzwDlYzDTI+CePF7EEFgh7CJhFmtZS+d5ocQB5z6bQdfvHkPA4ad
	C8dTUU3DUCXvuRwM/YxrS+tZI4ebulqQ0Q5HTew==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:R8LU8j+mUrJZJdquXwwsLFig9Zvy+j9iAyfF7Cl3egU=:WbSxTVGFpwWWq8nbkAG4wGNBvXcWFHoo7McWc3CkWzc=;
X-ME-Sender: <xms:B2rHanIGPw9zinIaRYrAd8239GfInJMAk0ElS9Yrv6yPShHE8OmPRw>
    <xme:B2rHaikiipxUAWAu8Wjdy84wkahmzuDSbCwCpy-WjDnZUR6d-0oQwLr9GtMdtDGXT
    hbxZVw6pVK62Uw_sTsk1kwotUey-EI-eWsUyin_cE97f3sEL2izIX4>
X-ME-Received: <xmr:B2rHatFpywEdQAkfUHG6ghpMnlzSzLhwxzWDQbPeCPjZZBeqgH3Raw>
X-ME-Proxy-Cause: dmFkZTGgGFqXmsMO2hd422zZXm7cA2HyiEnI682RnC4xCD8wYnaFxbeGucYCbG/HZvry9s
    4IM1xLFHcj3+Qqmh4tmLleKD2HLbB6S8Q/KxUQrkU6mw0hCigPrx3IfKN0iTVywzSAyo/O
    r1EtQqy5R3oKK4tIaqiNQtO/rVikN7zSyu4pn32eNPdOBK9X1laHdOZnWUNipcHqNpTdm7
    Mh6lJF+oQh5ngLELszt+gU31ax9KdglIrGLEuCkb+TzQDQ9jp/FNwNDmAAl6BpfBql0LwV
    jr4ByemsHCs+artvpgzQxl7BQhXPbLRVmNcdQj5eRYiGahJd/coVET9QRLmGs6T2qxxoPO
    ILp3IMtvTtChFQlxJov5yo3YHQ0hyIheUg61rUC2ODo+Mmdc7qYqO7lK4ZeYg6ENi3AGsH
    DDDLy7rCqpo28hI8+BXRRxh67Ss7QgzoKQJ12sQav/3WMa3CgNSxbCvxuAs57QQim+JP0p
    S+B1t5zFbuSTJn4IVq2amexQO++4IRu02raUAkwvefT5YSxTFa5XHt0nyRdIrQQgMCoO6/
    SSmwdpJxc0BDoI6KAp038hkMwjFv8AM2UnA04Vl7qZJtyyHbrEtSjC/dcwJu4Jyh/vVHru
    f0AVICi4uhY15PZw1IGO8GAzU+8w0y3NMhvRjkZPB774NgJGTCBcYtTIAviA
X-ME-Proxy: <xmx:B2rHaqFXJDhI-Gd8yvhshjk_3fCNXuJltK9NPpL-9I99expqRILgtw>
    <xmx:B2rHaiNxAV_c8KUbRxPZk3K3P5sNfvpkgudqnAayXpSGGc18tKVBGg>
    <xmx:B2rHahEfGHD6-lUUFc1C7h7JvnNGdZdqZiHtVVGiH8y_FkrDpE8zwA>
    <xmx:B2rHahOKrTVvJNg-bE0UMpz_Gjh2vIcn9h6u6ig98xw33Btwl7QJqw>
    <xmx:B2rHahV3SxafjtLk4UdTiP3dYDorNiaWIOUhUVornSgO2AUhGJKCObjd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 06:01:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0c3de53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 10:01:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 12:01:24 +0200
Subject: [PATCH 6/8] ci: switch away from EOL'd Ubuntu version in
 linux-exotic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-ci-housekeeping-v1-6-baf015c589c0@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
In-Reply-To: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The "linux-exotic" job still uses Ubuntu 20.04, which is end of life
nowadays and starting to show some cracks. Switch it over to use the
"latest" tag instead so that we don't have to constantly update it
anymore.

Now arguably, this reduces test coverage for old versions of Ubuntu.
But "latest" at least points to the most up-to-date LTS release of
Ubuntu, compared to the "rolling" tag that uses the latest release
regardless of the LTS status. So while "latest" and "rolling" are the
same right now, that's not always the case.

Furthermore, we have other jobs that test with ancient versions of
Linux, like for example the one that uses AlmaLinux 8 (2021, originally
tracking RHEL 8 from 2019) or Debian 12 (2023).

Note that this also requires us to switch away from GCC 8, which is not
supported by Ubuntu 26.04 anymore. Instead we simply use the default
version of GCC.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 4 +---
 .gitlab-ci.yml             | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index d7a301ec98..5b772dab55 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -409,9 +409,7 @@ jobs:
           image: ubuntu:rolling
           cc: clang
         - jobname: linux-exotic
-          image: ubuntu:20.04
-          cc: gcc
-          cc_package: gcc-8
+          image: ubuntu:latest
         - jobname: linux-breaking-changes
           cc: gcc
           image: ubuntu:rolling
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 27a16ed086..de40434ae3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -43,9 +43,7 @@ test:linux:
         image: ubuntu:rolling
         CC: clang
       - jobname: linux-exotic
-        image: ubuntu:20.04
-        CC: gcc
-        CC_PACKAGE: gcc-8
+        image: ubuntu:latest
       - jobname: linux-breaking-changes
         image: ubuntu:rolling
         CC: gcc

-- 
2.56.0.406.ga2d225a756.dirty


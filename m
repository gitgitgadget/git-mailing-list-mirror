Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADCB20C488
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508731; cv=none; b=jK6wyOxP6DypwCmVhfWJlhu3xwpklolMvUssA9f/3T7afLvNhwN9ub2IBwkkfvYbQgvduhWUI48mM2YhTNO9Nl3PL9dKIEW0mWVGsfjt8oMnhGIfY2I/sQspr4wVI5AEqyh9+4XqSwTjmXJpXdpjXXjGVy6sjHfIPyIulQerGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508731; c=relaxed/simple;
	bh=xy+HIa2KxluQx3jvqNX1uQVbE9H94R/Q7PYT+kGKTBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V436xfUtHFnD8dtbkd+cZptPr82Ugx8GvGmI9YAQuyh0FQnIoE9BXmYQguMT/ucocUoIr/2SHEgdu9oIJ8qBvMWPFEF/MLldEyqAe50JSgJwavmwQSmJ0cN6S71r3MFShzHaSs/U9R1qAL931YrhVGVYXxr8MZf8Tu+QBHlnX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ISZ482Zf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yoa4jJrL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ISZ482Zf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yoa4jJrL"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2362511401EC;
	Fri, 10 Jan 2025 06:32:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 10 Jan 2025 06:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736508729;
	 x=1736595129; bh=pXHspbm0cPcFnCW40CkUnbHewPPdbe9fSkR1CZi11wE=; b=
	ISZ482ZfjXR1x5nBIRvuaJG5XAwklIN0nS4QvMzfovs1ACaYih+ZqHzJsL4LsSos
	n0LLxF73/KUd6y6C6lpyrABePIvLU3AaD7Wdw5bKY6InuRTyfyiTt4eY/heeoieP
	FNF/3JwmWWkQHDDZFDUFWoYqesZlhApEDIhAbzzAO3OhDptCTHF0ei0Su2OrL6dD
	3Mx4QbpCuW3eaTOTYXtwR1T66d02e8EdaFiJq4vGg5G8rzEMZw8HIpBQmjN5MEC4
	iTn7Dej+wUzqCRHFDYzhqRRGPmf/haxz/3+RxA+VCP0WmZZNZzsFPVP0KmnDY0GW
	chr2GYfZcIGG5TGLoIGLXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736508729; x=
	1736595129; bh=pXHspbm0cPcFnCW40CkUnbHewPPdbe9fSkR1CZi11wE=; b=Y
	oa4jJrLLJ0qcBwROopqxhYSV9gGfSHIE6grBnMmmHQsbn1PKexZETAToWINodlkr
	dYRgvbBvSsEwtSBS4X4a6G3ONlTmdTzJTJUcK0lWdPEsUIPbEQEWbm4ENkDq1rwZ
	rGheGbufTu+Kjch1oyxR5aLHTnrKwVooOqE0KhRNMHcuF6/XYDd0Xq/9FXfJ94Yp
	TfNpyABctE0arsJ7yFH65izcUkIpwp8A+iVbjxYnrn0gJb3gCrdCoC2vBU70ToRV
	tNLgaBNOgOqqeEt/lIBC+T0Ge1lgUqTEtS56cB/P+u1Sgy1ejBsZYZpj0lApjZUs
	I0XkZlf5Gg2VRzSuFk9CA==
X-ME-Sender: <xms:OQWBZwtDm7m7ML9rE-W0CtmsSWBCeiZ5YHUnC0tzdCkuj0GL33jRPg>
    <xme:OQWBZ9eJcSW_PaapO480WwCUgu1gI9y97f-_lWBhQdGWZ7x9zVEcsrOW29czF6QSv
    mqpeZFVjSArOhxw7Q>
X-ME-Received: <xmr:OQWBZ7wyw2481Iozh0aoI6pSjlziw7cNrI4F_RCK1kf32hd5MdfDZUbA397K51s5t6461nhZDnDsSRovWiMgtcorJbxImjq-nBzhdWXRxSBcGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvght
X-ME-Proxy: <xmx:OQWBZzPu5JqrWB4LEGFN_uLZyvyk4XzSu54L-OeSqzSfHInpWsvViA>
    <xmx:OQWBZw8Cw656w_5Q6Rc5rMjpYk8Mxs6QdV4PeCj785x2tx6mzssFUQ>
    <xmx:OQWBZ7X2mwWlgo-DWKROSzNr2w_SaT30rjMXwj_bA3kKyIFh73cWiA>
    <xmx:OQWBZ5c6iFrILhVSchAYUgRGep3YOke9iP7Nw1QaUNLSE22-apKeOg>
    <xmx:OQWBZ0blt93hWSddx3UdA7iQqDZ0MbYtRQM9AvGLfhS6Xwgm7vDrWWAg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 06:32:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c720ede0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 11:32:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 12:32:04 +0100
Subject: [PATCH v4 08/10] ci: stop special-casing for Ubuntu 16.04
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-ci-fixes-v4-8-6e4613446080@pks.im>
References: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.2

With c85bcb5de1 (gitlab-ci: switch from Ubuntu 16.04 to 20.04,
2024-10-31) we have adapted the last CI job to stop using Ubuntu 16.04
in favor of Ubuntu 20.04. Remove the special-casing we still have in our
CI scripts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 2293849ada3b45873f80e4392ab93c65657d0f13..77a4aabdb8fb416c1733f02d02145b6bc0849998 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -347,14 +347,7 @@ ubuntu-*)
 	fi
 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
 
-	case "$distro" in
-	ubuntu-16.04)
-		# Apache is too old for HTTP/2.
-		;;
-	*)
-		export GIT_TEST_HTTPD=true
-		;;
-	esac
+	export GIT_TEST_HTTPD=true
 
 	# The Linux build installs the defined dependency versions below.
 	# The OS X build installs much more recent versions, whichever

-- 
2.48.0.rc2.279.g1de40edade.dirty


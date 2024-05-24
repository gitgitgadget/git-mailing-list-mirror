Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99842ABE
	for <git@vger.kernel.org>; Fri, 24 May 2024 19:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580046; cv=none; b=aYnlNPDqkXr/Jl5yl68OdLYb0xlk2sj0OUX2m4xajpI+7J3PDOdrjds+3XqtrMBVIDTS+Awm8oES4XE/qNVtOrnw5Uxd9xCAKykyMy3SV5WlSwb5hNqTudDp9RrC5269giPgjJKHbfehk8kb+omUzHPTHhU952Bs48ERdk2I3VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580046; c=relaxed/simple;
	bh=E10iRXqMP1riVCX2sfkApdGUFa2fuDx1jLw/w8r9MsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEhk+EqwXHUkuAsa94prjoXcyxEBqQy6i/GpDYtA3C3XP41AN01ZrCUJsf06/f78doRcYwuJANSy77RZ68Cuxm95qDVdiF3nhK7e0UQYjccri7b/pIMAoCNqhS42E2YNBchKG4t4R79QP8RnLExIHWPSfQ0cAggfHaVHeol/MlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cuV83WPv; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cuV83WPv"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 711F22B2AB;
	Fri, 24 May 2024 15:47:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=E10iRXqMP1riVCX2sfkApdGUF
	a2fuDx1jLw/w8r9MsI=; b=cuV83WPv3K4oHcgZv/nPfJ1xezIMgznCUzyYUeaBb
	vkPSqsQNZwaFG70qmk/swbv8dkuKs8RaGgCOwdv6pBLQLeXBReyhBmrGU+uaiwNz
	6EkFd5fjjHcfyEwFlNErRhl7AJGxFtD1jTr8vEVeeBCxtJzcqzfcnEstIs00FDxt
	jY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 68ABE2B2AA;
	Fri, 24 May 2024 15:47:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8AB22B2A9;
	Fri, 24 May 2024 15:47:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v2 03/12] ci: drop mention of BREW_INSTALL_PACKAGES variable
Date: Fri, 24 May 2024 12:47:06 -0700
Message-ID: <20240524194715.695916-4-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-246-gb9cfe4845c
In-Reply-To: <20240524194715.695916-1-gitster@pobox.com>
References: <20240524194715.695916-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 705D25A6-1A06-11EF-9E47-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Jeff King <peff@peff.net>

The last user of this variable went away in 4a6e4b9602 (CI: remove
Travis CI support, 2021-11-23), so it's doing nothing except making it
more confusing to find out which packages _are_ installed.

[jc: cherry-picked from v2.45.0-1-g9d4453e8d6]

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4f407530d3..33039d516b 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -34,8 +34,6 @@ macos-*)
 	export HOMEBREW_NO_AUTO_UPDATE=3D1 HOMEBREW_NO_INSTALL_CLEANUP=3D1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
-	test -z "$BREW_INSTALL_PACKAGES" ||
-	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
 	mkdir -p $HOME/bin
 	(
--=20
2.45.1-246-gb9cfe4845c


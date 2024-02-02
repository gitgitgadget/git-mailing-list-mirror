Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214927473
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906382; cv=none; b=u0+CyIprRGRDoPuNdKUCpHIUIRX4Z6nGwqnlL9ix3BQLEkHFLw3CqEejrBViGB2Y4J2vaQx8jM4Cuw3H3m9aZm0r7I08h3RY1jPHEy/OmcKduC58zenMLnIO8iacvgKuUWY5bS4C8RBDtO+ikFmKIJvmUGDzTecNPLlqvUyqhe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906382; c=relaxed/simple;
	bh=GddtFCA25o0qnXlGBhOsRIwz/bUd/9hkOT9+CMOwZoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUvjgbUwlwDqarvXYkmdQ/i++DC9d5KPufq+wxpEWXsdFJZcC90VUBlRMLP4zF/8UY+b0+dLszSXA2LiCZS6N+1QvSXSf5+uLe249UpzY0+mWMQVdMiWF/nnUEcqGUUZ3qelHXL25ScPgPMRUu90q81GjrNH8tEc45MA7BtlclA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oO75fxgS; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oO75fxgS"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A7CB826BB7;
	Fri,  2 Feb 2024 15:39:40 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=GddtFCA25o0qnXlGBhOsRIwz/bUd/9hkOT9+CMOwZoo=; b=oO75
	fxgSFlcfU3BVtY5Ov4ixau36ypBORXmx9EdkqQb8PXUh8U6dhkylJl0La9PETXGL
	QuqnCPydxUAu8yAWuuYe4fulNGNsvbhRhp+PzGWlt080wsciDXMRL+j3icWSuIl5
	nUv79oN0lTG64kpndjqRcpKXmxvbSdEEmUaYH64=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A048826BB6;
	Fri,  2 Feb 2024 15:39:40 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D579E26BB3;
	Fri,  2 Feb 2024 15:39:36 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] GitHub Actions update
Date: Fri,  2 Feb 2024 12:39:33 -0800
Message-ID: <20240202203935.1240458-1-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-522-g2a540e432f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 2E1947B8-C20B-11EE-9702-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

The CI jobs are getting "Node.js 16 actions are deprecated."
warnings for jobs that use checkout@v3, github-script@v6, and
download-artifact@v3.

These two patches update these jobs to use checkout@v4 and
github-script@v7, both of which are said to use Node.js 20.

download-artifact@v4 exists but it is labeled as "major changes"
with breaking changes, so I refrained from touching its use to defer
it to folks who are more experienced with its use.

Junio C Hamano (2):
  GitHub Actions: update to checkout@v4
  GitHub Actions: update to github-script@v7

 .github/workflows/check-whitespace.yml |  2 +-
 .github/workflows/coverity.yml         |  2 +-
 .github/workflows/main.yml             | 20 ++++++++++----------
 3 files changed, 12 insertions(+), 12 deletions(-)

--=20
2.43.0-522-g2a540e432f


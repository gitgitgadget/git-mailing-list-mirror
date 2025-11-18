Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF892D8375
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458344; cv=none; b=M6n+EQ8Xf3pzXrepqOrmU7tX537/cOGjvEw4r9r+hG2bHJQ5PnY/03BCIk9DvSlrzGxEyabOy1n/7beZbrwDP2hFIzMnNXYsW3hdrC+8vDjVAOO9wl2ec2S0tt3kvqEh2hnlkx5dmFZZe1/H7emRuQk4VR0v3kfVB7vz5u+5dCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458344; c=relaxed/simple;
	bh=ZUUcPjMGVVYLh22s0qbyVHkhkzrvrDVArEp/PHpPVZo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fr4gqjFSIpo+r3MoBzghfYzcZ/k96ldEvXRzPxfnJyswaa/sW+eIcWUKfImmrj4nrCO0zUnoN2+o/ikZ6e3g6TMg5+b1NkkYjJyYrQLQrugTeSkLP9t3Tm/3CEt1Q+cNayXneRGBfaOYypwFtHHeUg9DfdtNI1kS8tdMgJSGl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CbdZSWMf; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CbdZSWMf"
Received: (qmail 20030 invoked by uid 109); 18 Nov 2025 09:32:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=ZUUcPjMGVVYLh22s0qbyVHkhkzrvrDVArEp/PHpPVZo=; b=CbdZSWMfay+7JEDXQJH5NLClpKrZ6hUK9Pb0ELEUK52Pyr9AJtjMinIhbanCZRVY3LAntsQ2neFYglaFpmIoV0IgbQxaT7iJP9yMaH5U7y084brL6irW+VaYrOtL4WErJ7rECCzdkWNWrXiMxSe87P+SJvBf7QNpsL1q4d95Ut0euLOqgrKQu4hj3ta54C9zFBMTJaTOPpr+LhmrWTnOi9FEkVW1GS2d2gV43Djsl6q2GaKbE7SDBpDMLsS2pv2OKrXRp9tNR/TNS57lBrZ8t9q4E033jVWKvIZyUrHENcq1f3iZXAVU9C2UQzAD37mBcZBuKfDT/HIuEbwhX/qcxw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:32:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27650 invoked by uid 111); 18 Nov 2025 09:32:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:32:26 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:32:21 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/2] meson-windows-test ci output fixes
Message-ID: <20251118093221.GA530337@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I ran into a failed test a month or two ago that triggered only on the
windows-meson-test jobs. But those jobs don't actually show you any
output from the test scripts!

This is what I hacked up to improve things.

  [1/2]: unit-test: ignore --no-chain-lint
  [2/2]: ci(windows-meson-test): handle options and output like other test jobs

 .github/workflows/main.yml | 12 +++++++++++-
 ci/run-test-slice-meson.sh | 13 +++++++++++++
 t/unit-tests/unit-test.c   |  1 +
 3 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100755 ci/run-test-slice-meson.sh

-Peff

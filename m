Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6C283FD9
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764672512; cv=none; b=Qg6yAUP7YJM5Q5p9oZskVohXRxJJZOB7uGOjWNWzyEepwFqyURfJam4dXVGgqL3KXVB9q/0anp/vuAxYtkghGxiEUDiS/JqfqExCUsyHFHeSuiFRGQbeLpGGhbUMxy0lO8kfUL6BAy/jtK2gkjvH9UN58dK6PvKTRIkmK86MTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764672512; c=relaxed/simple;
	bh=B5MRB0q7Lbbt4aGGZOXxiwB9BuWWmCAVvdvPEeBBxxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BsB3nAGnCivOkgxXGQB3ITBRDMIjegB2WOt/BDhBUgFO1ZqAOK9bVnFhu3hesKx7xA60CkdtHL4h0idbct/RO73snEZKvz1CPaTy7pVZHN5MaSWzb4oY9V3KEy31MwDvPHAMY7EMvJv3JOTjxyYjF9+kIi3ewCUkPdX2T8x6eOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=1HrgFaaW; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="1HrgFaaW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764672506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti+tZVjKHCdTL5xKszpxkiTv5aeCm22XjLcoiIJw2pc=;
	b=1HrgFaaW1I4y17rwSFdOmK2WmpbFjHMUpcWjeEMDsCZkP3Cvojo5RUmglxeNXsMg+HpyjW
	0LpGXEzAmHsulPogFNYLfYb5tt3ro05D4CxaWnZwvcFidkwgzRJvmiR21W/5wKkpBO5kpE
	keC9AWr3iLI+Y3VJblDc05P01c1M/2Q=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 02 Dec 2025 11:48:08 +0100
Subject: [PATCH 1/2] meson: ignore subprojects/.wraplock
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-toon-cross-compile-v1-1-cabc8bce529f@iotcl.com>
References: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>
In-Reply-To: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

When asking Meson to wrap subprojects, it generates a .wraplock file in
the subprojects/ directory. Ignore this file.

See also https://github.com/mesonbuild/meson/issues/14948.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 subprojects/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 63ea916ef5..2bb68c8794 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -1 +1,2 @@
 /*/
+.wraplock

-- 
2.52.0


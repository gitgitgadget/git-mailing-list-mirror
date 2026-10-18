Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21A3A5443
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792346392; cv=none; b=r+5cz6qLiPD3uC8wJuNj0mIjktiHKzQOPfpv9+CApx+pNRg5Cgeo0Y5wuHjWPyvkAt/YOiCmjPGVcWZKwIGnABgW/JxEQYH7Q0+CNCwGlyh/lpvs6xtQ9kI/or2HgmWZA/4YjZwNmdWS+V6SzTJ7Wy3TaQtAZQ6HCO0OYDyYTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792346392; c=relaxed/simple;
	bh=eFsDXhtbrE+JQqz98dyUO4T2TjIopWGFb9YZ3XcsnIQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bii0bKGvBYby05lW0gg01YJXKa+gvs8H2+e/WS6pP5Q/z5X8i7GJDbPJZ7Scrwic3NsKCFdjsjCSMKp+vEPmIQTiEDyEnaEvX9k/fhueGsqKBHUXdoL2wOapM4egmj9zIadTOoBzK69y/tCBkQJMEXwFTJCA9uDb6ZR7Fv4jIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L75Ih32b; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L75Ih32b"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535a54bed9so1894237eec.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792346390; x=1792951190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eFsDXhtbrE+JQqz98dyUO4T2TjIopWGFb9YZ3XcsnIQ=;
        b=L75Ih32bm5FFcsCYlRdgO3zd3sVlMYu4WtknosotFyPBtAfDIN/mnU8pcZDp9stIWN
         ZoiEn5ZAqT4xroy03jsOW9vm+SgLSFFrgvqdWuAEHO7N4zuZ6ZCUNYFC6ScsvzhneuxS
         EGu+Ib3xBkq0dWFcw7as7itRsjZy5ge5dIe7bHy9ghWra4j4IBm9HFBHXVhdZvWIUhlD
         HNptfuD+nJBaOko1ro+e3/+M8r8nyNmIRl3e4rakBVjXSXxJa8ll1oDghkdnlwpXJ0E1
         +oO6ty3S6SDD0AG3fYWwVxezs9rn+04vfsvmCJZ1PzP2vEUj3YhJxEG5AICzOdHkk9YV
         vITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792346390; x=1792951190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eFsDXhtbrE+JQqz98dyUO4T2TjIopWGFb9YZ3XcsnIQ=;
        b=ueIJdyAinWOYrhFq8ADE6DauAAvmFLZXdD+7AVsDYirnbcEWOgK8+rqLhoK2hwCAqv
         NmrXBoRuPtS1VuT7PjAZ/HZj3Lt7saTLg6+6ly7ky3p+53Vj+T3hqfock+7MxSPs7Y3A
         MykCJCVfez3gbtiL4mK2O4uMv8IDey+D41zLulAb7sERIIof2PV5kSHzjlcdS8UnIFga
         +6pG2LIWYkrfDd5M55xySQWEHKa4i2RaSVcwjiCkLnmcnfRRoc2Oa4ym4eL1eFVPK0er
         XqRpWbWvSTlXmFT3X5fgGPMpmHG5g7kUH9NtXBpCmQfcv3u3yZdTBrDidKf8BoOnOTTc
         4q3A==
X-Gm-Message-State: AFq9FYJYl7qe1yAVjeIkWJqtY6RNQJW3Wm+9QOXmvjMS6AOkKT6nuk7I
	ByERhqdGaKmxbKWLvLrzErjaEGocZvVqNiVedVQrnRXgJBTpM4pN0yKVdRjOHpoQ
X-Gm-Gg: AYBFou3LAdGGxrqQM4HVN5PJtN2ifdbZo+Lr+leGg3t/aMOCW/Nub16ESuesfeJ2Her
	HDcbiJyUYOVdq8SdxF82W15QzKRdzv7VLoXAGLQ4UNVv8pgGbYSVNzClzfMeINUWkAuGyoBMWns
	m0VfJdDUp9kicFz95LfNgYhUGtEA5ImaACG4oBQskGBJOAbmiGw66fMEDoRg24XAH98pHtc6eKQ
	xjKwFxIeZNjj4AnoEIUPzCeWurOUA29jrD4hh4xJEaMRXamt09lLqV+EQJwBrugNTXOue+jDRlq
	HCVxUsXTLPdXZ7Maa/KmmS6ecHtAZFBZPt2pny/ru7hLzsxZ90SByDuCc7hf6QHcYCWhH3GHusk
	vKnhmIXMHwj6O4cf0kYBEWa9BAzon/edA3gwTD5R4+cnCq84/s9X0bbc4wW/ooeV0CdARDjzPn0
	hR9CG3mojdES2IIbzDqnGlYr7MSvY4mpGoihJau6m7Ve7af4l70QsQY+qyGcKOc9CErvdhb3O1k
	sj3SNhnVA7JdLbHvJ+rWmBJr7Qus8ArUbGaTmJ8sQ==
X-Received: by 2002:a05:693c:20cc:20b0:35e:f1a5:9ba6 with SMTP id 5a478bee46e88-3619ed0f886mr8026467eec.5.1792346389675;
        Sun, 18 Oct 2026 10:59:49 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK ([223.190.87.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm26365362eec.4.2026.10.18.10.59.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:59:49 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Subject: Re: [GSoC] Introduction - Aniket Gupta, microproject idea in fsck
Date: Sun, 18 Oct 2026 17:59:44 +0000
Message-ID: <20261018175945.697-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f609.dirty
In-Reply-To: <20261011131325.23285-1-aniketgupta3001@gmail.com>
References: <20261011131325.23285-1-aniketgupta3001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentle ping, is the fsck microproject idea still free? happy to send the patch if so

Thanks,
Aniket

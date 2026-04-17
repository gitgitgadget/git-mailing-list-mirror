Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9341BA21
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776392510; cv=none; b=dINYim1W8ptMyz6edeX2AdxLF2yfd7qLZIdTb0fklYr3lfEULT4UIj9uivar2k6V3otFV5bLjASE4+KhRVWzm4l3HzjHnNQ/rgrWorOwsjEE6tcer7hanXT5RtogmI+qMBuYUnGGFlMZvlIId+rBhxG2FO5uhT3tVwjWMusP4Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776392510; c=relaxed/simple;
	bh=kD+BJ+za1VOU5MBMsiLPSjFEPRRBOyLOzUdcHL8g82I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoDH/IhhdS2jlyJW0MCqLjZoYhq/lpgE6hWH+3khCMlOOtObTry7zuXql+ZyVl9uX0M8PTwWzj5yL+Y1FzBh2NSePpo3WGXZC+w1qoyYX4hGWaHASnNLvwbM3+eYTSMx/CK0EtAL45l4ZTYoecm26C1uiPsHnjDn6qjkVJtsUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJNkOjkf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJNkOjkf"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b0afa0210bso651385ad.2
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 19:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776392508; x=1776997308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kD+BJ+za1VOU5MBMsiLPSjFEPRRBOyLOzUdcHL8g82I=;
        b=RJNkOjkf/WGJMvGGYhtXzuwybA3DOUKtAoPhljonarB/0CqF+UgN+qZiGGqsAkbOwY
         vMrMA7utWTCoVjDIZvWyRUwpCkI60nxOTZGH7SKKmEI0NUdgi0kM7QoFaJQX/CALlOR6
         Yd4TeZ4jyJgSVziz749hWVvtnNOnqVRWgKul1KnRPeOUY+E5sqGCOjwkhrE90gzJTDga
         wchY6DBt95M4TRAHpzzwwRf2Ndj7T3TT3FnIDdXqDpc93qW6FQaV4zXVi8U6jC668tq/
         vEbm6Z3l4cenHUPXGYhc7cE/hK7TII+8yVaDlhhx0jMuTFTdfSwBSPYaUuR8ganbCByh
         r/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776392508; x=1776997308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kD+BJ+za1VOU5MBMsiLPSjFEPRRBOyLOzUdcHL8g82I=;
        b=TRUpMT2qxI0CqgvdI9YO25zBOWAjmcDfLel3JdwjApNt2Nmfr1nUguN9mcwgt7m+Be
         KvGCkI/L+GIgqCATawgsFEbC5lUtOp0h31mGOL6lcw66jLqCf0KUTqG5DzwT6JPb9Rh4
         o+2wCQO9/BpTx/P3BE8fiodH8xi1dDI9EKrGbxDxtxvc4bdVJsKbJqqJFEFG5IGHdGmv
         xVvKZIz9G3kduLw2pL8Td1dTszqYPsAS8NKCnHJ8IlTsIbxTcYd5nvrpuv+ieZxbkRjt
         UDZGJjowpMFYmuctq6oQJ7ZBlQ5SiCgAuO0ZK9O9xqtjWGyrYhne2xpLZy5jAhBrRBde
         cg3A==
X-Gm-Message-State: AOJu0YzW81Dn92qh/tHu8+6bm6WJrFb+biAsJF939aiPGLiBUL4nRhRa
	3J3TRu5W7pAU+0JCCa3Jjv6xRZwmjGtr9Ys77JL8jtFi6FRdacnG7mqRYMne7wjkJ3s=
X-Gm-Gg: AeBDiesaeUd+d/OErzIFIAkzF5/5+03P0rvbjQgxHF7u0AE+IrUDxSqOzh7bf1IZHWc
	cTNuaPgcgK+WUHhmK+wnpYL+3JlPdKS08htkl9Ypyoonzvkni9EqA89n3KAF5tOL/PRFmXsLQa+
	cOoakzcepnCEX6ZZNM2JFXwJ1CmaWMMDl46RbCjAa/p3SgGJl4ylCNqHyW8iTcZfWRuXhTe4gUw
	jky+4tPZUZfIBjZ/h7Jpqh+bPT4N7RYLVAPC4ZeR/ue8OzpFCrb0tr/PCMWKfzlcDuNY2hfIZ7z
	lhAIq9oFgHwhj5/0Hza3MiLiNKuJSP7Bj0ak8EzqJm6Veg+zZ4XRwFWTGVvYLrq2lXfLxZ/ZCaT
	UqtfLz7frresoGnSWS8wj2jX/KNAWJL/Z4BagqsNSSut6IdpF0DebAI6j5/pgaChkjz28voCc7z
	uzGxMTKdDXSCvS2Vg6NhG7g1TUGtJkv+7H49yP2Vqqzx6+pHkNJVGbxjXj1UwZ6fPNudGXZjWH+
	ku+RpshZxoKGEYEdmqiUF5KSA==
X-Received: by 2002:a17:903:1103:b0:2b0:6b98:59ec with SMTP id d9443c01a7336-2b5f9f7abacmr9035685ad.34.1776392508518;
        Thu, 16 Apr 2026 19:21:48 -0700 (PDT)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20c6asm2377395ad.58.2026.04.16.19.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 19:21:47 -0700 (PDT)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	peff@peff.net,
	gitgitgadget@gmail.com,
	christian.couder@gmail.com,
	hanxin.hx@bytedance.com
Subject: Re: [PATCH v3] promisor-remote: prevent lazy-fetch recursion in child fetch
Date: Thu, 16 Apr 2026 20:21:46 -0600
Message-ID: <20260417022146.57388-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqse6p0cvm.fsf@gitster.g>
References: <xmqqse6p0cvm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> So, is this topic still viable?

Yes, still viable from my end. The patch fixed the production
problem I ran into.

I thought v3 had addressed the outstanding feedback (HTTP
behavioral test, dropped the commit-graph comparison, packet
trace and pack-reuse analysis sent on Mar 13 in response to
Peff's questions), but I may have missed something. Is there a
specific concern I should address?

Paul

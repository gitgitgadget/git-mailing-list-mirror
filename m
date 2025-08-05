Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E04921A424
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375084; cv=none; b=DjtZwTkH8ctrEHUKp9iUlLnO8vstKUyX8aTVJcCyIgZEyS+ViCQMdwpHEd3UuMlzb6cWGMJkravmXWYhIWCajszd51h/JCzvvvzNzmkgKuaynGq8uSYHDZzo909arQJp/vREJgeaeE+ECO4/tT2gLwYNQFhC4YyJzPWNhACRodg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375084; c=relaxed/simple;
	bh=bfQBjJDUmoXrOT84OunZOT0f7iMCPpEpF9nQJ8bn+yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5IKbDQyFXz07r8o5oNe/p2HxZ57rISa2dRdjXHiH1PB5m0Nagk3J2dzEp2hLIxLTm2qHkrxUaVbsVD+G4rLugu7qluhOCjdYPKFKF9gaoU1G1wF4Y3Tdbv4Stq/oc+NUKcirCOSrH9B5m1bavVVPu0NPZVxUnHdGMO7tJLk3L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKPryBAC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKPryBAC"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bf9b25cbbso77866b3a.3
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 23:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754375080; x=1754979880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ls5u45XUNiqzDGKug0BjktY4HYGL4SOJEc5jSayrZU=;
        b=nKPryBAC8Yxu5yeSStkLihVWer7ya8yZ8M3uzkvaQsNPSvtIOy5ujbXmoyzySHucJI
         c7duZPccivHAhdgfhUH6+jiBgMl7BuUuDYBNsf7gp3V9g8Jdvua1qArKeON/E40lKqy7
         1+QJ4T/bb3A+D7wFm8IhWYnj9YTtLVd99gFKka5g9ZP+tBjy1OebPBmtY30dW1xRg56R
         AxFd1LQgbIh7lQzObEkp4XdxPo9r6maYUOsIoVO88M9D9/dpIkvLwRI5oi8oqjWYsnXf
         f1u/dfsq3uUU6XNKbdcKCffXlAWPNmKOCmN6ASkGT4LMJAfZTCaUnE0AzZTir/N7knZy
         X+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754375080; x=1754979880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ls5u45XUNiqzDGKug0BjktY4HYGL4SOJEc5jSayrZU=;
        b=u4FDjRdgm5vvZRudDgJVXtUZvtBteUNZnwKprnz4jTy2ZipAcMp3k8dhqznPusYDD7
         BbOUXZb/wDgNofp+UJDGN2rfnucYk7bbbVfCmUktpQLAL9Xp20dyZms88vI7msEqEOPn
         /vmUAPxN431K8D0qwduoUt+4RfwlgQQ1qc4BLq5jIBOuWB6e8J0a8D7NJ6TTpZLhy6zv
         bs/wBZelvbgFImWYUeOui5sIf/wa202kOY1SaYDyKM5qZFN94Fg8EEuJtxCg5jWyPPa4
         klRfwmMn/xOvrpBpLd9ziFeQYYMWSolflZhMGFa3dRGdAahpQuasVsHaibgHI8Uj5IUt
         nYJw==
X-Gm-Message-State: AOJu0YzBU4/YcVuqbPAwRnE9cRHSEPeKw8ghKsMLo14heh3cDLk7BWS9
	rIIcO9MrSRR7oJuKDnklqAoPtU+SGiFbKHtORToTySj20YwL5Y0x/td8oUBadQ==
X-Gm-Gg: ASbGncvmB+Zb1k14hDecDyY7QfR+xmln7w/Cvn22ucA3HXUqjMGiClzs7Py7QjwRyBA
	7giegkeXROCQZu7ZtZpQ0Bqerl+1nDCxoya335Z4hYxEqnMaFv6JNCeyO9/HCU8oecrDVsB21vy
	+N7sXZS6ZkKDCQkWPTrk3SqdIUkevaWF5Pnw99mdXQYeIMfzeGIbB2cOv4AS8xyTPnpPhuAWB97
	uhmM7jT2eDQ2KgyhVw49alVgX/i4ZGllgiYIxhVhnT7nPPkha7ykU91Mq9fXp9Kall4OuvB3Cm5
	38TQ61g6unzO7HWlyFJVwuLWhWiLddDgMxfc2Fs2IZHCkJbRsddjvPMoMHiIUXFKAS2H18cg5ZT
	V5Ko9zjSYaWb/k+O2vzEmhXJMTFWhGQ==
X-Google-Smtp-Source: AGHT+IGANvap1wL1ZMMwXUv+6WGdraEkSfhsVFlJ6O3yqoMEJwQz0FuzttZ78xkSQJYbbiCwmIUV1w==
X-Received: by 2002:a05:6a00:2351:b0:72a:a7a4:99ca with SMTP id d2e1a72fcca58-76bec2f4b95mr7494824b3a.2.1754375080367;
        Mon, 04 Aug 2025 23:24:40 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbcfa0sm11996744b3a.75.2025.08.04.23.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 23:24:39 -0700 (PDT)
Date: Mon, 4 Aug 2025 23:24:37 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] t5516: introduce 'push ref expression with
 non-existent oid src'
Message-ID: <d26f355c19c59eae30143900e218533bfeabec2a.1754375026.git.liu.denton@gmail.com>
References: <cover.1754300389.git.liu.denton@gmail.com>
 <cover.1754375026.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754375026.git.liu.denton@gmail.com>

It is possible to trigger a Git bug by pushing a refspec where the
source is an oid that's non-existent. An example of the error message
produced is as follows:

	error: The destination you provided is not a full refname (i.e.,
	starting with "refs/"). We tried to guess what you meant by:

	- Looking for a ref that matches 'branch' on the remote side.
	- Checking if the <src> being pushed ('0000000000000000000000000000000000000001')
	  is a ref in "refs/{heads,tags}/". If so we add a corresponding
	  refs/{heads,tags}/ prefix on the remote side.

	Neither worked, so we gave up. You must fully qualify the ref.
	BUG: remote.c:1221: '0000000000000000000000000000000000000001' should be commit/tag/tree/blob, is '-1'
	fatal: the remote end hung up unexpectedly
	Aborted (core dumped)

Document this failure in a test case so that it can be confirmed fixed
later.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5516-fetch-push.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4e9c27b0f2..c2fcfeca92 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -509,6 +509,13 @@ test_expect_success 'push ref expression with non-existent, incomplete dest' '
 
 '
 
+test_expect_failure 'push ref expression with non-existent oid src' '
+
+	mk_test testrepo &&
+	test_must_fail git push testrepo $(test_oid 001):branch
+
+'
+
 for head in HEAD @
 do
 
-- 
2.50.1


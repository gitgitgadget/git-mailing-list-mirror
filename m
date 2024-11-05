Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658621DD0D0
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834664; cv=none; b=DReB3H3QILPX3vh11CF2vhBWfRjumWtvIe/hD9QM+bLkCxDeCZWWTOVPcwKNZmxsX7XFdYFpmmX4AUgnkBTaE32mu/WUFA2NvSvaXwb5P2yNjaN59mIW0FaRizN8xhw4xa4Kzpz5+aBIeWz0ysCJ/CpOchkYmU9OxYlhiEDfXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834664; c=relaxed/simple;
	bh=d5xmNgZ7p5kPNLNw34/oxXaXamj5h1TGlnv7Q5X1wTU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ReJbh5sbPZ9WBtIcrZYMTPcQ5kKE8sdSJtHf3JAMuxMXyN1XCnThURajZy6MGxaYZrhtMCTLzmFBqkPWjYd4leVzG5x3e1Ah+L0XvmIaJzIiPJhj6WeyN4MqoUm0jrAQn2TtrD+CCn5ntUFnUCAXt3AI1GfP0Er8+2lBBmjZ6RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2sHtVOJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2sHtVOJ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e330f65bcd9so216960276.1
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 11:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730834662; x=1731439462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa+vRa3LzTJzBAknQf5E1877WbMkye3C4WINNq0+uT0=;
        b=J2sHtVOJBlM37Ir8ayKoZKXNFpECRnWd+EUacbBt8F3oHXS0z80AeQZjg3oFl+eeTg
         wY8G53WdX3x/yF2unNPxsqv3pxHLDKC0UPh5wfwnjtcyuSlmpjHdCPDsqtz9zuI8cCdz
         YLTiugjVfcAldIG8zuFeUbmIly5Kbr7KorUF7LXw/TzkiGvhsm0dmDxp6zPDrbCdG4pH
         +TODG06yYjjCKZcyZ+hCnNDVsP/BVfeo+DY2ZtfLdSNv4cOie4eP4sMZvScQW6eA+5/x
         ST9jn04dEBF8ieUHBs5Klj9xhT3AEXmhLVzPVYr0hPo+mEeZ7usFi+ig8N6Pe5FxXP/P
         /jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730834662; x=1731439462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa+vRa3LzTJzBAknQf5E1877WbMkye3C4WINNq0+uT0=;
        b=Lt7VualvuSl4tiksPawVXIrgrW2Bolsliq+r5smflF40Ru7a8f6uMshmz/8GGhB3kN
         bf+semji0cPvwxd/+/gWHMMfeON4cOjMWWrxmRywpyFrfuziCfEaMsxdLT3xHDW+YXD5
         novPdZwro7taWIbGwJmtgFQNCw8wRVNcEb1dQ1sHj/8Hc857l29wMuWDQaH1B9ZpNvHd
         oE+TevqZcL712TiI5iwXj5RAjSsEydufcoj2JQDx0yMXFs43FxIee9MnUK6sl5CMVJEh
         sOgTgCaRtXKS8D1sryFmn+7wMicJjx97vfu10s5dqdYtyZwqwufqX+S37p7eAi8aZP8F
         Rptw==
X-Gm-Message-State: AOJu0Yzx7+8xYjur02hTLCu4TU/5GTydn9a0mT9Oxv8duQXEY2YWo4Ov
	oBAe4XzYC11uRI41PJdwJuwhSfDDYvEpuW+RaZO7XI/+S6DHap5b7E6WVvNFEWfqJM0aueXkMM8
	CPg1FXQCGI6vGw1Qab22SkzkES+oJBdK6NnqbVkle9mvvKWtUwPEXR9ldwPLGkpqKWVOOncnXVX
	QplbQ9//qgKZtFuvMDSI0lnyy4hgZW7WxbpzjAIRBYRdCHxAfWPH9JFd81XyetftZz2w==
X-Google-Smtp-Source: AGHT+IFfuBam8aWgsB73sH/4W+0eOAoHbnxh2QNcQHxDPEnxSJhgTQRxDF9P6R7I64Uj3J8VErUGR7VMYDlqTpQVzlC0
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:af5d:b903:295d:2c17])
 (user=jonathantanmy job=sendgmr) by 2002:a25:26c1:0:b0:e2e:2c2e:277b with
 SMTP id 3f1490d57ef6-e3301838ad9mr45975276.3.1730834662365; Tue, 05 Nov 2024
 11:24:22 -0800 (PST)
Date: Tue,  5 Nov 2024 11:24:17 -0800
In-Reply-To: <cover.1730235646.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1730235646.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <cover.1730833754.git.jonathantanmy@google.com>
Subject: [PATCH v3 0/2] When fetching, die if in commit graph but not obj db
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Changes: the commit message title of the second patch, and a change from
grep to test_grep.

Jonathan Tan (2):
  Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"
  fetch-pack: die if in commit graph but not obj db

 fetch-pack.c                               | 42 +++++++++++-----------
 t/t5330-no-lazy-fetch-with-commit-graph.sh |  4 +--
 2 files changed, 24 insertions(+), 22 deletions(-)

Range-diff against v2:
1:  34e87b8388 = 1:  34e87b8388 Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"
2:  a35e386a0e ! 2:  c92b2c9e50 fetch-pack: warn if in commit graph but not obj db
    @@ Metadata
     Author: Jonathan Tan <jonathantanmy@google.com>
     
      ## Commit message ##
    -    fetch-pack: warn if in commit graph but not obj db
    +    fetch-pack: die if in commit graph but not obj db
     
         When fetching, there is a step in which sought objects are first checked
         against the local repository; only objects that are not in the local
    @@ t/t5330-no-lazy-fetch-with-commit-graph.sh: test_expect_success 'fetch any commi
     -	GIT_TRACE="$(pwd)/trace.txt" \
     +	test_must_fail env GIT_TRACE="$(pwd)/trace.txt" \
      		git -C with-commit-graph fetch origin $anycommit 2>err &&
    - 	! grep "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
    +-	! grep "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
    ++	test_grep ! "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
      	grep "git fetch origin" trace.txt >actual &&
    + 	test_line_count = 1 actual
    + '
-- 
2.47.0.277.g8800431eea-goog


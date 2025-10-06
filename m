Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550AC199237
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755582; cv=none; b=YpbK+5r8PzmCtiV052nwdZb1LKO4+FqIZcx3JEBz3kxUhnpuhzNtN4mnlIsoYyfr8CgBR3p+9UaNkJo6M8wf/JS3uz97nQEHdkZoGy0jvdKbQwYM+hFwXPuANcA6bH/K9YsT2K0CWF8qqxmaCM/GMzxiZ7WCwUEwylB/LUXRHs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755582; c=relaxed/simple;
	bh=a6EBKwGFha9bOUbhU1odfOfK5oFplBxLFoh2RKVuX0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snrG+khFaFcIEvSlZJbRufiNqrBngJ6vWrZOeRrHGoLXZJ1uxIa9mBtnWTyZi9e3smAnPC1PAHlRxMu2c9XdjwxhEId5g1U+17IcDU9NOQs0bj32JR2CODDC0HztUybTFiZyyj133tXyIYy/89/zMPpb3I3akS0Aqbw6aoITPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaGwkz1N; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaGwkz1N"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d60528734so54011067b3.2
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759755580; x=1760360380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re5AB3nMqX4EbMJf+92FIockioHBiiqDaNvFEmPmCJ8=;
        b=CaGwkz1NSmhXvydqVAjoDxDb4S3n8hUK+IBxuUxc6oEQW4x4azIQvTlYhbfHMREOIw
         M2B+litGfozVUQWUbDMMUVD9U4y5jNf8l3xcrazf6aYMnSCeq0YOtFWPavBVTq1WFlYa
         6kfrLjRLwXtdgl+ILTYIDgipE00oAlhDPOAVIIgh1Zv953JCQIbTEoMoUZqEE+OVu2Ib
         UufC3GwBztyosEwJMRDWAA6g9CqWur5Z3iXldPRoL90tql8EUt+B9MgzY4xRZ0NyNQK0
         I5CMn02j0LA2bdMBUELG/KmTC7cu58o3YDbbnfvU1lRDvX+GuNxlIII+ZYJRiz/6fYDy
         YtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759755580; x=1760360380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=re5AB3nMqX4EbMJf+92FIockioHBiiqDaNvFEmPmCJ8=;
        b=HrNDWZMoZfJgye+l4WxQpJ6R9pY9sPE/50shC5aTagOaIvHADtM90dqyx8yWImOM9x
         NNkgR6uWYoW57csZz1WZVUBXTu+Q7wi5nDoewgKrsVq2aBdfZateKLxPrPP0HiVTrfSu
         2ZPB/fZhIusZLIkSOPjLM7vjOGaijtzSvlpxhtWgc6+YuxC8JqQRT+9ZlQaVIhn8OK8C
         aWil8E5znA1HFjHQWDXhvgDieUJtG+kC7pSyoMjJb7Re/JG23ywgW1EWCoQUFxynfOfa
         yQoc7OLfv9XJXhX5YJJXLMPj8RMEojMcqPY49uKTLKnlloI3ZJvQ+lTx9P8tI/k5XSYS
         YUvg==
X-Gm-Message-State: AOJu0Yzs4cXhK77QdkxWb2NdF0T+qITvzhPMx1roV8qc7tkbtBFvaK+H
	7Z2BAXxK0SEOGDhGO99Wwt0byRlqS1/vlX32c4naELRHPhkRxsriIIvKPc/v44F7
X-Gm-Gg: ASbGncvT8iaU8X9mhED/CbW/aW72mDs2PSHOj5+zE2fOfuCydIDeb2xVauk6D/mq5T4
	uB71q2/o4NK6gLtFBvIOQJ8jPb0rgTn4us+FdIUzPbu+u0UQsjvynX8sFYM/eefA3KvbONO0xee
	6NUntGUrLQBBxw5e7KAKs8vxDGplzBT+aPbnddleHztFeHuwgZG1VvP79BIV143JOsR/CZY7hTC
	axlgJsvki/1jda2dtSBxGdVX5GqtsglTLZ4dcU5oRgPC3PZG6eOGlJt9Gl6uqkBt10DVY1E7HyI
	qxatlz2OQxswzFf4WXpecL8LoeKm3QU8q8uY3lfNEBZ2RD3tiQ5Va0ICSkbpiUBtEta81NWOgmj
	P67TRQlPZRAQr9cwTP7/p4CrCvxSQvkJHv4szfeBgxL5gbcki9FEkXKbUbTd2aSUDUQuCb8QfQZ
	lGD+O0ZN9nrebVyc0=
X-Google-Smtp-Source: AGHT+IFf+V2xXGXqWSmP9R5SHlJy1HK0hKbJSYIsLWYYccC7Om70y5UvRaPJsTIqGnRlztQ5O1YWMQ==
X-Received: by 2002:a05:690c:25ca:b0:771:9673:135 with SMTP id 00721157ae682-77f9467cab4mr168423217b3.33.1759755579870;
        Mon, 06 Oct 2025 05:59:39 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:8444:5e58:11a1:53a7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77f95845328sm32673917b3.20.2025.10.06.05.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 05:59:39 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org,
	phillip.wood123@gmail.com
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	avarab@gmail.com,
	gitster@pobox.com,
	glencbz@gmail.com,
	karthik.188@gmail.com,
	liu.denton@gmail.com,
	motisd8@gmail.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im
Subject: [PATCH] doc: explain the impact of stash.index on --autostash options
Date: Mon,  6 Oct 2025 08:59:29 -0400
Message-ID: <d4a277b6b0695d86636562f4c07efae17f9249f9.1759755379.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <b36d2dbf-7cf4-46cd-81bb-b502e0eed380@gmail.com>
References: <b36d2dbf-7cf4-46cd-81bb-b502e0eed380@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 9842c0c749 (stash: honor stash.index in apply, pop modes,
2025-09-21) merged in a5d4779e6e (Merge branch 'dk/stash-apply-index',
2025-09-29), we did not advertise the connection between the new config
option stash.index and the implicit use of git-stash via --autostash
(which may also be configured). Do so.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

This builds on dk/stash-apply-index from gitster/git and is published at
https://github.com/benknoble/git/tree/stash-apply-index-doc

 Documentation/config/stash.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config/stash.adoc b/Documentation/config/stash.adoc
index e556105a15..fcb9a4a7a0 100644
--- a/Documentation/config/stash.adoc
+++ b/Documentation/config/stash.adoc
@@ -2,6 +2,10 @@ stash.index::
 	If this is set to true, `git stash apply` and `git stash pop` will
 	behave as if `--index` was supplied. Defaults to false. See the
 	descriptions in linkgit:git-stash[1].
++
+This also affects invocations of linkgit:git-stash[1] via `--autostash` from
+commands like linkgit:git-merge[1], linkgit:git-rebase[1], and
+linkgit:git-pull[1].
 
 stash.showIncludeUntracked::
 	If this is set to true, the `git stash show` command will show

base-commit: 9842c0c7492d2858d64ef81128f7b1f0b38e326b
-- 
2.48.1


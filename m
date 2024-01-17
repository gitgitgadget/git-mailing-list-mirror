Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA124A11
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521162; cv=none; b=AUYKXl9orsEvLLsvEBnn8cdjfEHO9HRZyt7QQavkQ2m1hlMMD6y4TqYWw17sLmVNFK9VBwSChr42fyxbtle6vRsvB4T1fbyWcO1TcPMdkh1e79bxMdvNVzf/13kIcldJfd65vVatrLSORX/HltIUHoWtVROb7OX/zk6sHeZMHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521162; c=relaxed/simple;
	bh=ZzbY28CwqaZwaMZqIUhgA9LhakYqhQq628R6/hmEOnQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=Sk8YjliCOSrw69zs+ufgamAjZ5a6znA4soBkUUUGyZAkUmiJL7vVLYSHBzvFNVMubFNuYRuhAgSGN5/s484E/xO1vgMf/A8WnGgy4h0r6QG6pUCDWChkLavAwzSawCq1koSY7cEdOTUJUdiFUmtXhM8ADIADbdWRrwyrcV2M4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcMQgY5H; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcMQgY5H"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3376d424a79so9219481f8f.1
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 11:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705521159; x=1706125959; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLJOK4Mu4tFYInlshWjwiKh3Bm4HtBZmFXowJuGacKY=;
        b=XcMQgY5HflOrMbbxlPoifjbivuifKkhbz7MMLb0iRM1knU6jD4jYgpPR9X9/nT/WE2
         9/WK1z1ITUkZSSkHNQxYS8Kgq4cHlB6VvhAnhL4wSna6ajxaIfhPwyIwi3WjcGrLXQcr
         6bng4+TPvkDqEjvnhmJtb4i1iw1rkGYJEJd05jeqE7Z9kTjNmIcDT4LE8rg2rkwt8lAi
         T7AijMtvPcJydgus2IyI/LBX712jTqFi+z2IgrBetfw30ycRS5hRZU6s97EZWzPY3lCX
         hROWyVLl8WLWyYN2Pb4txKtjgC7XMMPrhmE2Q/SL2lZBEGwcqJkazjx3iK1LNx90AtiW
         HJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521159; x=1706125959;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLJOK4Mu4tFYInlshWjwiKh3Bm4HtBZmFXowJuGacKY=;
        b=Q2DM8zuLqRoMBWe7n8ZlsQOR5ocPeekBoOtU0+Ll355tolOrAMGWe6dSdDog8f6hpJ
         /mnKDGPkDdl7+WRuIFCmebGFGgIMwj0AF30F8/6GO9sUVUvkvYlkdc03P3PLVBRKAkW0
         rT9bVne6EoWwHcTcvocCnT8EIfblvLlq40e0/SsnC+SNwH/XSJjAayWGuHHJeMT6LxCC
         Q4J31H5JZ1pLhSn5wfHjpVeOQG2xZXcCdkeN1yTop3S7uxmsL5i713q31kvXYWwNdl/a
         9UN+gv+51hiB2nRfmFHVWK7Ukbqk8FGXrhBgQj9u5Q5/s7+l0qEQzlMLq+MYq1JgaGbi
         B34Q==
X-Gm-Message-State: AOJu0Yzprx2vqaZlmWXEM3CbmAR23Ef/0fKs7647xFmQxTBKWX8MZZaR
	1DhtucdncqDDhhyIvZqwOAbM9b4Dd9g=
X-Google-Smtp-Source: AGHT+IFKynMBoAAgrYewiH9UiAan63ib93mTMX4xZsORtdnq+IUdaSj7BISMjQu/fnkjSEtAPPikMA==
X-Received: by 2002:a5d:530c:0:b0:337:bcdf:2dd5 with SMTP id e12-20020a5d530c000000b00337bcdf2dd5mr1697690wrv.16.1705521158716;
        Wed, 17 Jan 2024 11:52:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q8-20020adff788000000b003367a51217csm2336334wrp.34.2024.01.17.11.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:52:38 -0800 (PST)
Message-ID: <19233aa0d4496b66d67fbee82fb8d9b6b35a03cb.1705521155.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 19:52:26 +0000
Subject: [PATCH 03/12] t1414: convert test to use Git commands instead of
 writing refs manually
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

This test can be re-written to use Git commands rather than writing a
manual ref in the reflog. This way this test no longer needs the
REFFILES prerequisite.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t1414-reflog-walk.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index ea64cecf47b..c7b3817d3bd 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -121,13 +121,14 @@ test_expect_success 'min/max age uses entry date to limit' '
 
 # Create a situation where the reflog and ref database disagree about the latest
 # state of HEAD.
-test_expect_success REFFILES 'walk prefers reflog to ref tip' '
+test_expect_success 'walk prefers reflog to ref tip' '
+	test_commit A &&
+	test_commit B &&
+	git reflog delete HEAD@{0} &&
 	head=$(git rev-parse HEAD) &&
-	one=$(git rev-parse one) &&
-	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
-	echo "$head $one $ident	broken reflog entry" >>.git/logs/HEAD &&
+	A=$(git rev-parse A) &&
 
-	echo $one >expect &&
+	echo $A >expect &&
 	git log -g --format=%H -1 >actual &&
 	test_cmp expect actual
 '
-- 
gitgitgadget


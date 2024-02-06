Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9EC1BF5C
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256256; cv=none; b=rjwgaFV1g8auADTPWzG4Fbc+XzD9Vx3Kf6RL3fFRlncdAZ7VGWKlcHDCcNlivRpAa8rJzGi3h/mWeZeyGhpMCQuEwyqJmYZhfGPbuts7hI4wI/IISmvducGEtMIJT8Kmhs9/brj/gERdeZvDYhsz+UkIYa7AH14e/UAr1u4H2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256256; c=relaxed/simple;
	bh=vvvymXlMyLZh3AZje1/JOyyR8tT9JEP+bZTlrK4xD/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZXWTOE1DM2KwwjnmfjZmBCU7CUl6MOr71CFx9jI8rQTbjDfizsuOUWO/5LsB7Q5Eo+zaR09VxJyLVcHyH5xsurEVLoGnraydJc/t2QyXIgr4jZ7PbDbqWVjwCMzPLaNzaq/C2t6HIgJeLyrnnkDbvZcMFBI3qA43ipy5pFnNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBTGUiCf; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBTGUiCf"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-296dcd75b96so255378a91.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 13:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707256254; x=1707861054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvYcIwbn+LVvi8WzVFLxeIqCUzCVRgBu5b5kyO79Qa8=;
        b=PBTGUiCfLUhuyCRejJMtDpMg0uX5z+lD2OxZlrRZ84GDnkeXXYeEO9mEyJOORpDkpJ
         vwS0dOjuzXGOa060oIbucSoUpZpKgPKexYKnoFVqxikrmYBasMiouNFJZH9/JkA5Fiy0
         0nvGzaPP78Ua76q84o7VLYV0WUtuLyd0jhh7XlZ+QPXcseIzRp4tFLom2a+D25nOwZcO
         T51OnINQBj5zxNe4uytONtu/PKEyYMlJIZBkA5jJvQR85A5MgGeDRjsM/36GL/eQnTZ9
         Z5yn/+am89b5m6vsb1SHaM2yj2YLNeWvAFXNJJHIViARpA0FJLiF9CsxXQ7j3zi9gMnS
         z4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256254; x=1707861054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvYcIwbn+LVvi8WzVFLxeIqCUzCVRgBu5b5kyO79Qa8=;
        b=qPxMfTcOgddU+f9BEyDQUloyByw6acgSYNHqAlVYz1WFNlARfDOiJ0pzkrvuB4eaQj
         RsfWXWhBU+8rofSmZSRw/8u8qCVo+kgup0uwbeysvS7Ap0YU6yLIcXvRI3/fGEDTD5FU
         hRa2EmYioKqkbDtdPnk3CTDfxVde2waSb1m1t5p5doWRfNLCc4/T32b/PIn82bNTObmK
         jtWxBKq8sf1dlRt4/oAin7CC6UOfWOPh6fQY2lkx83G8hE/nbTxXUcaWTF7PNl3RxDgw
         BrXDTODFX2Bxbu7jT3jE4dD7aHvs2P+akRVdYH9t0JUREvHZABvDHznXh0n2sDmDx9sX
         VUhQ==
X-Gm-Message-State: AOJu0Yz1I1AhNPx2UnRrA0W6Poref1gYs1qSiKGzv0POJgjzymczRh6N
	6eSb4QdtV0ihtBUKLvnJVe4n+ShOjjWd3REI1dOtvFaHyUDfkly5
X-Google-Smtp-Source: AGHT+IFVk87Q2H3ac9bEld4B/IQVuN2I9GFcA3oEkJN0O3UKDElPR+jWby3n6C9r7+znpaX6zOwSjA==
X-Received: by 2002:a17:90b:3149:b0:296:ce4:8aaa with SMTP id ip9-20020a17090b314900b002960ce48aaamr871744pjb.45.1707256254472;
        Tue, 06 Feb 2024 13:50:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVbT6f5mRpCSA1WJMKagpVAb36Nhwj+t6vs5muaUmUVG9JgzJC1gn3chMfgtmzX8yosN4XX5uDnocmOXIFEaLdjGs9JEXDJgSN+xGznqslNuMv/
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id rr7-20020a17090b2b4700b00296b62d9793sm2271803pjb.3.2024.02.06.13.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:50:51 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 4CE6B5202A3; Tue,  6 Feb 2024 12:50:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v6 4/7] completion: bisect: complete missing --first-parent and --no-checkout options
Date: Tue,  6 Feb 2024 12:50:45 -0900
Message-ID: <20240206215048.488344-5-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206215048.488344-1-britton.kerin@gmail.com>
References: <20240206020930.312164-1-britton.kerin@gmail.com>
 <20240206215048.488344-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --first-parent and --no-checkout options to the start subcommand of
git-bisect(1) are not completed.

Enable completion of the --first-parent and --no-checkout options to the
start subcommand.  Add test.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 t/t9902-completion.sh                  | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6a3d9c7760..57c6e09968 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1478,7 +1478,7 @@ _git_bisect ()
 	start)
 		case "$cur" in
 		--*)
-			__gitcomp "--term-new --term-bad --term-old --term-good"
+			__gitcomp "--first-parent --no-checkout --term-new --term-bad --term-old --term-good"
 			return
 			;;
 		*)
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 304903b1a7..8fcd1cfa7e 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1271,6 +1271,17 @@ test_expect_success 'git bisect - when not bisecting, complete only replay and s
 	EOF
 '
 
+test_expect_success 'git bisect - complete options to start subcommand' '
+	test_completion "git bisect start --" <<-\EOF
+	--term-new Z
+	--term-bad Z
+	--term-old Z
+	--term-good Z
+	--no-checkout Z
+	--first-parent Z
+	EOF
+'
+
 test_expect_success 'setup for git-bisect tests requiring a repo' '
 	git init git-bisect &&
 	(
-- 
2.43.0


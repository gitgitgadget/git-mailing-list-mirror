Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529811946C7
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431831; cv=none; b=EmygLZ/RO7WxXAbfO7YJOLhEPH4ZOV7alp6UVGIvC4fBaF0Wa/3cCwgbSJyUmoOw5twXICFOycVlJWxMPcHebgngzaZfMpTLy/D5vTln9/MBt2xvrYVGt1VeTBLfJc60sSQQv8mHp+BLNT/DAZVWtqJobPnNB0ahM43Z/tZMZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431831; c=relaxed/simple;
	bh=nwkY5OI0HH7Cs9FA1wEWNBXEa68F2cUg0znCVfElnyI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GEoJ9KbM0sK459C3hSOqy/AadiGw8KG1Z8DCWvqM+Tr1twxFkoQkIJrZSJXmy4JNbpXFF34Aa6xZc1IEKDYtXWTqimW52OcKEfIDGOPIhsPAZQ87GnqIfABoTxGyghRPheQnBG4uXj3scx6MaHE0VOVVMLlpxPos8io4ukLWmYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k562ckoV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k562ckoV"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso4508393a12.3
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431827; x=1730036627; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPioBOD00J+cmRqzjQDezJ/4LSeWLk7OvKmHjCC+7Ao=;
        b=k562ckoVxas2JIyMelv7k5+KO24gVndFTExfEhh9WCv+W62h4lftIIZ3TgavpVh0io
         /zqRu55nHZl0inw7yxECD0mqhW0coeUr6bL6x8DZhu1GRTYo+P3uHtH8wraxQ3JHgwjG
         EFUf5HzrXLYV57RZ1jlhrabLehmKGaSfs7V3C5mxJfh1mv2Fqx8QdLIAbFN3Pz9+HyZu
         Tw3HenQTs8D6f8vhHoYeKeKn4EhlPVAaWuyvCS2xMIKmqtg/xf2i/Te/rXN3jZt0ZV2o
         sHdXDoRByiWTxXbC3zPfeA729IS2s6AQnf38BCFCzA5yrpPsmMzGRKmaPgGEDmodSDB/
         GEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431827; x=1730036627;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPioBOD00J+cmRqzjQDezJ/4LSeWLk7OvKmHjCC+7Ao=;
        b=NM2OqaMTmva2FLghWgzQpqKYVYxlk9ANywVtb8tSvc5z5PyPT5DHcctEonTVdFBuY+
         QXQuTy0EBCJqX9ufwTiPHaQ0PI08TrZ2VJe4CP8eRsbeq+mPyqnbmq3tKqUX00F2Y5k2
         lNBL2jjV8g6SbA3f1WiN22+lvisIjyYmkSC/HZg2Alna00+xh8mmIzdSDY4jVsoxPevF
         S9d86G8pUFnUxklPv+D18zmsrxCgFFr6jzSjsc7Xv7ysmrWZBcGis3F5OtVx78qeZdIJ
         WtGsinUZt//WKc4L4EVL4sc+cz+MOVJV+EFfJr4vIZkhCvcWjgDw5Nt85gJHBfNE9Tg0
         +yAQ==
X-Gm-Message-State: AOJu0YyGdsRgu3fjo4KWZ/a7f+yT0kzJ1vw9laem1oXrcSa6gllSRWKO
	9LeyVAvYzywp7+wWVpI3/PWDZ/lEsQ00K31dsVo4IxMqQ+DjxhQ1rGkUyA==
X-Google-Smtp-Source: AGHT+IFWw94TRwvrm+vaFewF3KAt67lXtEkRYJjwKD9eod60G1Mc2o/ykRcUhaxDkUcBOtSOQdZaHg==
X-Received: by 2002:a17:906:dc8f:b0:a9a:1f8:6c9b with SMTP id a640c23a62f3a-a9a69baab11mr640171166b.37.1729431827010;
        Sun, 20 Oct 2024 06:43:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a913704d2sm92227466b.119.2024.10.20.06.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:46 -0700 (PDT)
Message-Id: <6ef8d67af4b55f91b681c980301d3d190dd5a4e2.1729431811.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:26 +0000
Subject: [PATCH v2 13/17] repack: update usage to match docs
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The t0450 test script verifies that the builtin usage matches the
synopsis in the documentation. Update 'git repack' to match and remove
it from the exception list.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/repack.c            | 2 +-
 t/t0450/txt-help-mismatches | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index af3f218ced7..50f208b48b4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -41,7 +41,7 @@ static char *packdir, *packtmp_name, *packtmp;
 static const char *const git_repack_usage[] = {
 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
 	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
-	   "[--write-midx] [--full-path-walk]"),
+	   "[--write-midx] [--path-walk]"),
 	NULL
 };
 
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
index 285ae81a6b5..06b469bdee2 100644
--- a/t/t0450/txt-help-mismatches
+++ b/t/t0450/txt-help-mismatches
@@ -44,7 +44,6 @@ rebase
 remote
 remote-ext
 remote-fd
-repack
 reset
 restore
 rev-parse
-- 
gitgitgadget


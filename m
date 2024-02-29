Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF05D462
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201507; cv=none; b=DONH0Xi30QeRBL7jkn6eZCHKL4UUbsF2i8IhGLbCHzbBHiO2XIKIF9jQbgNabq2A/0ONXp/sDBWR8YC2fu6FhQAocptBd1bITg8gWzn929sWflkFA0p9D9bq+9wI4zjzVu+H2vbZKKJTFJWZiQpU+G7vXgNPe9ru0D6uaTgqKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201507; c=relaxed/simple;
	bh=GpMQ1SMft51NDlrsoECa/kVwCMr7vJY741hZQm9yAkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzRmqQyLDwdRA5PbOUqAnujnPBCXkZQWX+LH+ftBO/30LDwkGEPJiatCokBRfloqK6rLjyRfKcm9RjOOlicw/UBmL1u2AuwOtSKLK1khqJBIrNPj7rgtOoLf73d545DNVso884k6+xfHm6FUjK16hZHkXbBncfeBH2PuotZKlEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1HVIany; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1HVIany"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso564988e87.1
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 02:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709201503; x=1709806303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdeWJlgeZNlv/W/UcwiQ71zspJyKjYBGFoawvvx4OlU=;
        b=T1HVIanycdNv8G0eZl3tRZcuJ0DVG0lwdk1B75UEJQA+VCO1GbwvxRQPZ++PgCIJNl
         igWueSCHYNvMUO9OG4Qf/Vl6MhKJMbjQwokfJYtxERknkK9Eck9HQSVWQkCanrc57qc2
         Vj2wi5bMelURdJ9bV6DjyzPP/GqhD1f+F5MUl2S4FoXngGtONI26DtGRKMW6v9EmGMdc
         gzN3WchyfSBiY3WACCVH8dYbGRlgYBDwvPoVv2E36vOKqweTDLLSPG2uEpxZCsDfqtsy
         A9f+kGv1LGXOAl7uTJ4LwSNtonjTf365PKlAaljYnhx+PmZdGW86lsd5+squDjXemept
         HNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709201503; x=1709806303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdeWJlgeZNlv/W/UcwiQ71zspJyKjYBGFoawvvx4OlU=;
        b=sO0jtJFw0pCnqNKZVOqix8tPR+zg43uRwoo14lGG0As6AjBv6NQqPFdmKiBHLCXXpH
         5Wdqqm5b14vaMNnnIzFp35no9Pk0krrjxhE0u5Xl9YteoiaruuAyRZhcElUVMRKqZg08
         C5LSuZxM6wH8j5AJfp/fNAvkBRCqLkhlGhWwxvBHO/7XyktxIT/wkzQMA5Epf0ob+JmW
         AcfXkYZudHZ2SFxlTGh0BFT7a3vo2LlUogfIWxuPC50ZfwiYiAOg9emeB6dQWmolwLgY
         lWrF2RrIKmcpru9NBkW6hnQDf3ph9FerePPG7sF2/t/W6cK+BR4ROf9AnYWlufODz2oy
         ++xg==
X-Gm-Message-State: AOJu0YxkSEx5Vxoo6NrHtAyqK9Te5VIO7BeAyAVjQrynHqCw8cDQvoZB
	PsC93bgp6AxluJg2yAx9gTzdCuTHXbsLOcQnkeMumV4+xiTdRB5rZ+qc9KmdOlawSQ==
X-Google-Smtp-Source: AGHT+IH2Rt3J2QgZrSXpVcZwUAxb5cyLQ6vEK87ZMLY68TiL1rkv11j9lH4jNXZo1xI5PgJsfKqQFA==
X-Received: by 2002:a05:6512:3125:b0:512:e535:d692 with SMTP id p5-20020a056512312500b00512e535d692mr1113332lfd.0.1709201502826;
        Thu, 29 Feb 2024 02:11:42 -0800 (PST)
Received: from host-sergy.. ([129.0.102.60])
        by smtp.gmail.com with ESMTPSA id n33-20020a05600c3ba100b00412bca4cdf9sm1498296wms.36.2024.02.29.02.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:11:42 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com,
	gitster@pobox.com
Cc: pk@pks.im,
	shyamthakkar001@gmail.com,
	Sergius Nyah <sergiusnyah@gmail.com>
Subject: [GSOC][PATCH] userdiff: add builtin patterns for JavaScript.
Date: Thu, 29 Feb 2024 11:11:31 +0100
Message-ID: <20240229101131.445405-1-sergiusnyah@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <xmqqttlsjvsi.fsf@gitster.g>
References: <xmqqttlsjvsi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces builtin patterns for JavaScript in userdiff.

It adds a new test case in t4018-diff-funcname.sh to verify the enhanced
JavaScript function detection in Git diffs.

Signed-off-by: Sergius Justus Chesami Nyah <sergiusnyah@gmail.com>
---
userdiff.c | 17 +++++++++++++++--
t/t4018-diff-funcname.sh | 25 ++++++++-
2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index e399543823..12e31ff14d 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -18,40 +16,19 @@
#include "git-compat-util.h"
#include "config.h"
#include "userdiff.h"
#include "strbuf.h"

PATTERNS("javascript",
      /* Looks for lines that start with optional whitespace, followed
      * by 'function'* and any characters (for function declarations),
      * or valid JavaScript identifiers, equals sign '=', 'function' keyword
      * and any characters (for function expressions).
      * Also considers functions defined inside blocks with '{...}'.
      */
      "^[ \t]*(function[ \t]*.*|[a-zA-Z_$][0-9a-zA-Z_$]*[ \t]*=[ \t]*function[ \t]*.*|(\\{[ \t]*)?)\n",
      /* This pattern matches JavaScript identifiers */
      "[a-zA-Z_$][0-9a-zA-Z_$]*"
      "|[-+0-9.eE]+|0[xX][0-9a-fA-F]+"
      "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\|"),

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 43593866bc..9c3b80665e 100644
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -18,40 +16,19 @@
test_expect_success 'identify builtin patterns in Javascript' '
    # setup
    echo "function myFunction() { return true; }" > test.js &&
    echo "var myVar = function() { return false; }" >> test.js &&
    git add test.js &&
    git commit -m "add test.js" &&

    # modify the file
    echo "function myFunction() { return false; }" > test.js &&
    echo "var myVar = function() { return true; }" >> test.js &&

    # command under test
    git diff >output &&

    # check results
    test_i18ngrep "function myFunction() { return true; }" output &&
    test_i18ngrep "function myFunction() { return false; }" output &&
    test_i18ngrep "var myVar = function() { return false; }" output &&
    test_i18ngrep "var myVar = function() { return true; }" output
'

test_done
--
2.43.2

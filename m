Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E7D14D293
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722883; cv=none; b=gqSiotzdIpSsYKc0hMYXUjccNrSe/WnkAEOV5Sq+VPAaVlu+DOxRLzgr9vPVjyuoFF04/4wyywpTtHuJ9gWAPTpKRhrsZ43QhzVwhXhPMBtH5QFzdtzcevJ3RG4RXxTctcROuCjX9Nz8kZi9t3veZ/N1WfPHnkPHYNYVh4NQSeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722883; c=relaxed/simple;
	bh=GihmzoGpXQcJWWVBnIdVZUVKWLXaKUcn40FtEz0KU9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4lPL250DG/G7mjUCOocE5oJRDfXSBsch9DLXK0+VNtvJUq9yeDmjbpKI05UUGTkInXRX+iBkHz+8flLc8HJcIdzCKc3lHynnQtmJC5uQa92MJH1qNc6GmyUMjAg3v7E17MKhbwtsXcOMmPZtgWX78RwDM4Z3yqSzUYK/uHL5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrhpTFzH; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrhpTFzH"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77b550128dso532750766b.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 01:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721722880; x=1722327680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdJVQPxnX2ejLWnSEXYE14wHZC6ZGRrq/+9puE7yOEs=;
        b=HrhpTFzH2j7ddcGK7Ag2//UUltBe98hnEv3d6Dca/MQ7Fv6e/JvxQRMmhL86HnUsvk
         dotuINjIzuL4ebMc8J5K3gm1kqvVGPtcJ54hsCh+bEuf+cbz4EjAdZJTYE40YxKntsln
         JMcXo+hUX7B61l2eqb7yDtD7zusXpDNU1kKqE+w0TbvsreOqVQqwN/+TBisPw+5pXihX
         2iqdkMYcW9IQiYvhfIdEZZfxuXbCQe+FdkfCTxYuKZrLwaMk0ljt6NZgYp18XL+e1MfE
         BkB7VbbzkeEfWk6tcKv0Yk9nyx+a/PndQZMPU3bC/tLowIOA+atvNeznJMUYNCe5+Hqa
         6JKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722880; x=1722327680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdJVQPxnX2ejLWnSEXYE14wHZC6ZGRrq/+9puE7yOEs=;
        b=vpbUOFYgNmiXGi4iZCpxzg1a+mDrIqqdxc8D0VD2o38vcnFnJsTS8ZBUrEvdevw0zJ
         bO+PgTDu5+wxYkiUrQnjgEQM7ia/0EQRkVDnhdaPBQdx96JKDG5kI4b0KFFPmA40r8VJ
         zL2q1uRX/6dhzU3637ZvdHrHGcagSSUtepCyPpfXGvkXEsqGNa7jS447lbpAKoP81AdF
         zYdbunvlGvrdw/vtHh7L2TEC/rz6oybZhFVdeixyDjyknZP71J02rjT+GHrWi82g3CSq
         dTiJ+JIFMofvBQAdm9lzZ6/YWO6cKDlPJW1+nk+Z18A8NLUuZrfaFL7fX9UAzjQPWdZI
         NF8g==
X-Forwarded-Encrypted: i=1; AJvYcCXptyI11YfUv1Uda3RCMrwGVgVoLZq7XFdzcG1oyhFcKgC6xsyBgfvxJ2V764KiBZmP0VgDstONY+VFvtYL6kxVXWpi
X-Gm-Message-State: AOJu0Yz9geF7Z8rKk78A4KHt6MC4Ztr6L3NG8OxcIQiq4zPACK+GVWoO
	faQnluwB8/sxtv3cvrXHxoO4PAOozlA0Me0xy91BxEx7O+sQMxJQ
X-Google-Smtp-Source: AGHT+IHeh5EGTlJ6Qo/cA8des6h6VT1+GoDzUrVo2HcrkLsUGT9tFtrYHVzzbxRibsLEPQMFoyie5A==
X-Received: by 2002:a17:907:2d8e:b0:a72:af8e:15af with SMTP id a640c23a62f3a-a7a4c3e3f3emr692897266b.49.1721722880011;
        Tue, 23 Jul 2024 01:21:20 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:45ae:72d0:1982:e034])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a9f463194sm24026266b.112.2024.07.23.01.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:21:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v6 6/6] ci/style-check: add `RemoveBracesLLVM` in CI job
Date: Tue, 23 Jul 2024 10:21:11 +0200
Message-ID: <20240723082111.874382-7-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723082111.874382-1-karthik.188@gmail.com>
References: <20240718081605.452366-1-karthik.188@gmail.com>
 <20240723082111.874382-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For 'clang-format', setting 'RemoveBracesLLVM' to 'true', adds a check
to ensure we avoid curly braces for single-statement bodies in
conditional blocks.

However, the option does come with two warnings [1]:

    This option will be renamed and expanded to support other styles.

and

    Setting this option to true could lead to incorrect code formatting
    due to clang-format’s lack of complete semantic information. As
    such, extra care should be taken to review code changes made by
    this option.

The latter seems to be of concern. While we want to experiment with the
rule, adding it to the in-tree '.clang-format' could affect end-users.
Let's only add it to the CI jobs for now. With time, we can evaluate
its efficacy and decide if we want to add it to '.clang-format' or
retract it entirely. We do so, by adding the existing rules in
'.clang-format' and this rule to a temp file outside the working tree,
which is then used by 'git clang-format'. This ensures we don't murk
with files in-tree.

[1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ci/run-style-check.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/ci/run-style-check.sh b/ci/run-style-check.sh
index 76dd37d22b..6cd4b1d934 100755
--- a/ci/run-style-check.sh
+++ b/ci/run-style-check.sh
@@ -5,4 +5,21 @@
 
 baseCommit=$1
 
-git clang-format --style file --diff --extensions c,h "$baseCommit"
+# Remove optional braces of control statements (if, else, for, and while)
+# according to the LLVM coding style. This avoids braces on simple
+# single-statement bodies of statements but keeps braces if one side of
+# if/else if/.../else cascade has multi-statement body.
+#
+# As this rule comes with a warning [1], we want to experiment with it
+# before adding it in-tree. since the CI job for the style check is allowed
+# to fail, appending the rule here allows us to validate its efficacy.
+# While also ensuring that end-users are not affected directly.
+#
+# [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm
+{
+	cat .clang-format
+	echo "RemoveBracesLLVM: true"
+} >/tmp/clang-format-rules
+
+git clang-format --style=file:/tmp/clang-format-rules \
+	--diff --extensions c,h "$baseCommit"
-- 
2.45.2


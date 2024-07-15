Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36F186E51
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035854; cv=none; b=cgT5Xq7NSd7pohQJwhdU6dPdYIdMYyAcq0f/H/m6o9uDwnceKpVkwpqOT/uOzsRQt9ykxU+16GID6JHM6YDss+JnY/qK0yuMEUXrtBFHVCci3T5OsrklrXlrPKgk4dMXV9DyoEyp3oe0rWZiTyRYSGkm+UD6Mh23VzGP7wQxtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035854; c=relaxed/simple;
	bh=fXYkwyyNJCLwx/1+LXMILAXgVK2bnFuuMMrPjySB8G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgUYJAZxmZXxyoU2uJtthfC0BEvKR89CSMYetfprED94i0vIIpyDUVNgma8yIo48xdIbfTaWMW+LwbKsMglxyw5faFDtF2t3Cafo/1NdHFwLTRlRuz8Hf4dPhCHxvPgShWiUoSimeWnVC7YKX6Q4uXg4zQ3Rgj9PMoWriE+4A9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPAp3wec; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPAp3wec"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42797289c8bso29556065e9.0
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 02:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721035851; x=1721640651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXE3MYu8CxgvrX1p6ggHUE0kt8dF7SAUpXUFx2O4fgw=;
        b=bPAp3weccLAmlWnKsTghkQban92EeWnMAnoq2k+f28WglUcXIRhpO+F+9R6A2bOqIl
         pA+aIq90PairdihJ4ylxTHM87FqbVTne+KlpdDNQ/YV9W/hJqdXVpYcQP0amBiWdLJBF
         JLtTk+BG9bEHPJhjGZx9VIc9NuPcCbJ1WMqtEm2okTM7Q/Ny2sP7hJyBotkzm23w6Ty3
         iS0HIZZ3owC9yyMkExitoRND/g4J0uuXu5nXWteSRXZ/mciL7mtTW8PZP17/+mfQXMbp
         UarcsuATMN/0UM36aE2EBaLeHZfgWchDmFebsVwYc6j6nvnwdLck3o5CmWCMLr2LbtJj
         lLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721035851; x=1721640651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXE3MYu8CxgvrX1p6ggHUE0kt8dF7SAUpXUFx2O4fgw=;
        b=Q6E342MYYsvj9ZxSSmgMlLXwcLtHp+EtQtOlC2RWXr6qIfiAO+vc+dZm8AjHC+QMc7
         g1SzFdo6t+rOebl6SWIfuq6UDN/iXc8ylXXdVWkZ/gzxhCoXFnGmJeIPurD97aKvP6ie
         +HbCljAfItiN1dbon+n1A3x3wkekT8SeBaihNgunv3QCXHKz7RWSx7mnt3lrrGVUAwS4
         I+15PMPrYDzmPLw+ScAGcq3vkYgmjXeFh3Mg3WZuevWJTNwd24duYJ8yqZBybq1RLgff
         rcOYhxSnzzjS6pwvIYgRj6Xnz7IVTTWMHSBSxz5mDKOGoGBPMxI7d1kSBY+PoFyFxcVM
         rlFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmB5QheXg13DMBTo5p8O2ISHfn7kqLXWilQXH20vfHtpf1mp0dV8c/+zs7JHjwMXvXW6CfAvOmLEv+NC96Ei41L8uJ
X-Gm-Message-State: AOJu0Yxct9oWua62soqXerIjQipHug/OiKbckSVdYQ2kEXKOY1AijCEc
	I9eH5fLjMaItR+MLwGMQ2u+itUC1GVBtrlLzjtwNX6QgEOTO7C7v
X-Google-Smtp-Source: AGHT+IHAwopgnsQJjlg513Kad4P9S4YsIV+6Fa3iTCOWY0/5YrYxFJUZircO5aNZVaRaza0l3rpjvA==
X-Received: by 2002:adf:f98c:0:b0:365:e76b:e908 with SMTP id ffacd0b85a97d-367cea68090mr11519822f8f.24.1721035850808;
        Mon, 15 Jul 2024 02:30:50 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1a3c:da7e:77ea:d1ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbf19sm5745208f8f.68.2024.07.15.02.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 02:30:50 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 1/8] clang-format: indent preprocessor directives after hash
Date: Mon, 15 Jul 2024 11:30:40 +0200
Message-ID: <20240715093047.49321-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715093047.49321-1-karthik.188@gmail.com>
References: <20240713134518.773053-1-karthik.188@gmail.com>
 <20240715093047.49321-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not have a rule around the indentation of preprocessor directives.
This was also discussed on the list [1], noting how there is often
inconsistency in the styling. While there was discussion, there was no
conclusion around what is the preferred style here. One style being
indenting after the hash:

    #if FOO
    #  if BAR
    #    include <foo>
    #  endif
    #endif

The other being before the hash:

    #if FOO
      #if BAR
        #include <foo>
      #endif
    #endif

Let's pick the former and add 'IndentPPDirectives: AfterHash' value to
our '.clang-format'. There is no clear reason to pick one over the
other, but it would definitely be nicer to be consistent.

[1]: https://lore.kernel.org/r/xmqqwmmm1bw6.fsf@gitster.g

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.clang-format b/.clang-format
index 3ed4fac753..5e128519bf 100644
--- a/.clang-format
+++ b/.clang-format
@@ -96,6 +96,12 @@ BreakStringLiterals: false
 # Switch statement body is always indented one level more than case labels.
 IndentCaseLabels: false
 
+# Indents directives before the hash.
+# #if FOO
+# #  include <foo>
+# #endif
+IndentPPDirectives: AfterHash
+
 # Don't indent a function definition or declaration if it is wrapped after the
 # type
 IndentWrappedFunctionNames: false
-- 
2.45.2


Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B169199EB5
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477131; cv=none; b=AMVllV0k+Up1nLJnMY5DFWhzNIij9zYejxv/C+c/1Ke+yKrKlee1WLmor67rLcBpEOVURVr3RHGJG9GppzKg7sD+Zu7XfTRHYDMb0b2ehTYQgk+0POEUYAugmd9HMbs7GKMK9/YHd2OdIRQWaDnwSeckBhEUziYID9qLDv6TFz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477131; c=relaxed/simple;
	bh=a33aUx6uDd7fCJDKDyyVt9kCWO0ewSQOAwf+wVOH64Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u9tZqEzwvPeCIX9J8Bk1t8MopsxLtJ2Qb1VGzpEzPacbdt+KEkJ7i7Ph8fECwv7Chp2ROJpBXgYpf9q430mavjnXPY1x8KwHPH+C5z6Zgmjf5+VawuXXjrxlzTPkGMN27cECDmLqZ8ULBhRQrEhKSb2sHhYL3iOkMuzzpE7dTnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaZ5wWOw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaZ5wWOw"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-417e327773cso14360255e9.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713477128; x=1714081928; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWDYRnXiT5ALn/eZBaAfW9pu9IafcMSa7MSKor8obBY=;
        b=LaZ5wWOw90ZrN6wCm1IzaBOhcKXJbOejFYliDjyD+ku041kcjlYOB9iYDdi6U9WYuL
         5xvKQcZ/ZrnKKEoHujsce+FNzGTkSJRhHCXShEkgDiF0fxwqfEYxpTlkuh2uMux37nrS
         YIgBb9Sp/Duj7ihdGFXgaAEzwQtN4XSYkWviiEGSbBjExRpCtYZVSI4zIfG9o4/TgaRx
         Nd4WJC4RJ8lJ2KkWU1sAyDVr4aNpoVjn0W1sixveB7hsvnORhlMAFbXrpnX0ch6J6F7M
         Z5YJatg/8FnvBqQFnDZjKZRhby1S7OcsR36m/se2iHyiqBLzfO6eaEu/uYNIo4LSyAHK
         mkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477128; x=1714081928;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWDYRnXiT5ALn/eZBaAfW9pu9IafcMSa7MSKor8obBY=;
        b=KOkaQmoay2lgL1qzdKXnVXTbG34obgqyy2VKaz7BPJTrFS9ncgJMcOcevqEmRd7fwv
         zs/QJAVWK64AF6uzRpXIoPIvzAeTRRjf0VMMTRUMNlGXCTJyZbpNPyyLxPhQG02qdOcB
         56Ax1s3/EsD0FOZ7g2u/wkMHw/pMggxcwVZYk3gAfTsGhnuLnnmqNw2gsZ0CxpVTpk3m
         yHGk3LegYY4M9YNKkM6Pb11hk+wDVadyav5PfjVIckAscSVOQYKUgADWWLZ0FcaOJVvA
         hRbNNia6ZkX5/sA5R7cFELn7rh578bvfbc75MinYs/gM1kEy+mB34a8rnQpZbsKlC7MA
         4TiA==
X-Gm-Message-State: AOJu0YyXhpWcnlAi7C97VIBJmK5DPHF5yqJ26M7LDktCDVzUYrDiyeRW
	JQJdr+OIKoevkvs0oZ6RQSfAt9LlKRcIn+9xYaud6t9+wyC1p/BKqG72Ag==
X-Google-Smtp-Source: AGHT+IGOS3+KVI0wKitPGBAxCM00ZMY0rT8vdQRUBzo9hNkY8vj1B6ADwVZEAzNQcALrp7YDsraHPA==
X-Received: by 2002:a5d:6184:0:b0:349:e211:e4a5 with SMTP id j4-20020a5d6184000000b00349e211e4a5mr2462837wru.8.1713477128191;
        Thu, 18 Apr 2024 14:52:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b0041884b79b81sm4079944wmq.1.2024.04.18.14.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:52:07 -0700 (PDT)
Message-Id: <4ced981b82e9978116592ad6533b683192d33bba.1713477125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
References: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
	<pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Apr 2024 21:51:58 +0000
Subject: [PATCH v6 1/8] MyFirstContribution: mention
 contrib/contacts/git-contacts
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Although we've had this script since 4d06402b1b (contrib: add
git-contacts helper, 2013-07-21), we don't mention it in our
introductory docs. Do so now.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/MyFirstContribution.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index f06563e9817..e41654c00a6 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1116,6 +1116,15 @@ $ git send-email --to=target@example.com psuh/*.patch
 NOTE: Check `git help send-email` for some other options which you may find
 valuable, such as changing the Reply-to address or adding more CC and BCC lines.
 
+:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
+not part of the core `git` binary and must be called directly. Clone the Git +
+codebase and run `perl contrib/contacts/git-contacts`.]
+
+NOTE: If you're not sure whom to CC, running `contrib/contacts/git-contacts` can
+list potential reviewers. In addition, you can do `git send-email
+--cc-cmd='perl contrib/contacts/git-contacts' feature/*.patch`{contrib-scripts} to
+automatically pass this list of emails to `send-email`.
+
 NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
 please don't send your patchset from the tutorial to the real mailing list! For
 now, you can send it to yourself, to make sure you understand how it will look.
-- 
gitgitgadget


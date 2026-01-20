Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2056D3D300A
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906934; cv=none; b=gSoj6x1Kz9TP+rZA/iZJxTR4+5RF3jQHOwCMxcIri/jrUAUvj9MV7olv+QQ0e4Ou2tmaefJhB9Swvwp7KZNnaF0W3mkCAxK1q30M1vHwAbSrYMyQA/jHjNj+fjSqwMAex+k3L0MkE5bpauKSL5zmxmQntaRot2h7L47h0slBm1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906934; c=relaxed/simple;
	bh=nMrPxq5YHp12E9NLgiE1hgtp2AeRN1uiM+VshuhQie0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fcuzG8zPkj0N7L4Yg1by7NgkubrFr9QqWz0CVnLdY5nHVCNhAzVzf+92sNb7LWWuv+fLkSoaUOtVPTieyZ+DoHAv7gh2HKj540HUA8wBM7tva0YkvwEj+PM7G1nUUvpDxnQXHgp/AB6dMEa8cjZYM6zyR//OO8Cj94SmqHSEpSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZICs6zP; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZICs6zP"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so34306475e9.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 03:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768906931; x=1769511731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CNqFNkSobqwn1Zg7nspVyQ0T6y/3wydXwJrYj/fvgtA=;
        b=mZICs6zPWJ2R8i1UqoRKYwPTpoHuV+I5kkx1jYQy8rrmhpi+X042zL4HxkuRejW5mB
         +pOuiHIgjAxpQ9RGxV6U/B9i8un/d46ntfeUmeJXW8VOYw0DLo1Jnhbm2wwixeOqw1yF
         nn8De8H63o8vAzsj1VVl4lrDhPSepw1abQXvfecCG7gpJdoTvBq16cMzA2jxAkNsnV7l
         Tgjoqxxj6ojCx4KZ4gBNPYaM1I3y/I/cP4wZUTycnVQl7zlSy53k51OSsW2tx3vjKmE0
         OIxtSCPT8gNd23gyI0VWCp1kP3pKqZHHWHw/FKYTICmW6U8+XJEQnReQbmak5ElqLts8
         1ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768906931; x=1769511731;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CNqFNkSobqwn1Zg7nspVyQ0T6y/3wydXwJrYj/fvgtA=;
        b=ToaPz121lTrHtslkrKkFD9wk+56o9JZNnWey6w70sodRNVbKgZe3KL4v1PUcJwI3Sj
         SuyI5T37YVJ0XLW2Hw7MBufNwNjVImgkcy4ziUrCh8o+V22LOdgXX5GnqM0ptUBHp2WI
         QOoOCzfP0BSMTs8kiBu86aiaWCFHhu9QGEz9dSiGB06Qc9EmIBO1xp6keFnzWCCaxX22
         PxBN9a5fCMQoYvq2YsSjR5Knq2ePJTSkfBR3cdJBYPkBe6bnBixv7nJYB1AkbGwtALmZ
         f2Ktv4jqX4rd2c5yTXgdCQ4d0BgB1rqDcHwQdbXKiwpM957W21iyT0e5R0QUlEuEILXh
         hDkg==
X-Gm-Message-State: AOJu0Yxgumco7my1IdVlUSPoZIJM0Y+f+kb0SKva/lmIpJFDkLTJhTJG
	1iNr7WoGXffdUGTlquLvnArvAWGmqxHfas/QPKlJXsrqKQ4LLjViPHHGSAsMdSvC
X-Gm-Gg: AY/fxX6K5khZP1rHuetIuSZ6PWuTQz5wDvMQ1tL0lO+ZbQ3jIJXC6O6KUdXSxgt7Dqp
	ZlaYB2thTv6dP1GhYibkQ5PR8vjWS42gp9R+l0HwkTmMeFA4mY3LCcB2bOD0WB23/i+X8HzzAjT
	svHPKhC8tgEnI0pMKTnMB94yWD1e5MMy1jSc1W7ooBdnVLoBYk6ch7SJYmCkq/LWxgZN7HVPN+A
	GGgAay5CNpIgwvyWlS8joeYPrJzwHh0fWgXXCKJRX90L+HK43gRWiBWV7q3v00nUzYdW6NDikMT
	6PqfQGKR9tEA3SXCWDfPzvGFKGq1geN3IBOAFpZC9XV6sM3liq5H1FHT6kc2glXTZNb6BDqRIe8
	k+d1K0dQOWAynx9K0Bzl9HWNl73VjNEebAxALSrt+gER5C+HG46njMy5QoW7GdQ1m8rIJ6PPzvt
	5pwVZRG2OktbTHbJg=
X-Received: by 2002:a05:600c:3f0f:b0:47e:e076:c7a2 with SMTP id 5b1f17b1804b1-4803e7a2d74mr21444845e9.15.1768906930807;
        Tue, 20 Jan 2026 03:02:10 -0800 (PST)
Received: from berwick ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428b954esm297093905e9.7.2026.01.20.03.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:02:10 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] mailmap: add an entry for Phillip Wood
Date: Tue, 20 Jan 2026 11:01:55 +0000
Message-ID: <f10c3f680d58ca0abbf795ae8b0f2ad14ab85419.1768906910.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

While all my commits appear under the same address, other addresses
appear in some commit trailers. Map those addresses to the canonical
one.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
I'm not sure if we actually remap the address in trailers but
we've certainly talked about doing it in the past.

Base-Commit: b5c409c40f1595e3e590760c6f14a16b6683e22c
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fpwood-mailmap%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/b5c409c40...f10c3f680
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/pwood-mailmap/v1

 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 3cf26b1add0..c9b50830140 100644
--- a/.mailmap
+++ b/.mailmap
@@ -226,6 +226,8 @@ Philip Jägenstedt <philip@foolip.org> <philip.jagenstedt@gmail.com>
 Philip Oakley <philipoakley@iee.email> <philipoakley@iee.org> # secondary <philipoakley@dunelm.org.uk>
 Philipp A. Hartmann <pah@qo.cx> <ph@sorgh.de>
 Philippe Bruhat <book@cpan.org>
+Phillip Wood <phillip.wood@dunelm.org.uk> <phillip.wood123@gmail.com>
+Phillip Wood <phillip.wood@dunelm.org.uk> <phillip.wood@talktalk.net>
 Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
 Ramsay Jones <ramsay@ramsayjones.plus.com> <ramsay@ramsay1.demon.co.uk>
 Ramkumar Ramachandra <r@artagnon.com> <artagnon@gmail.com>
-- 
2.52.0.362.g884e03848a9


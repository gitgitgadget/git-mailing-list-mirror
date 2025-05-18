Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6254F202F6D
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747554215; cv=none; b=nzQLRuVcUnIbY/DDSE5DZMPiZdcDiftjfln9utrm3X7JfDyEKPXu28q9D6YdV3WHn9cwvjSpE0H6/kCwGxhBjy0RM6SOekqNziIJnGvxEq7VUXGLm8g7FxKsGtnRqhDO9+qPh/mDZAKjgWNemF4nOTGAJaud3r7TGAX0YNqenLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747554215; c=relaxed/simple;
	bh=uc8jvo71wJ6T/di2Zhi1KXD4nBzo0nr0FaTxPIVlieo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQIvQ/XUycJT0SeOqlkDjy9qmbLY7Jb/2rns5bMIbaZAkUWvtfxTpl6LUADl+0BMPn7mG73Sinz2A/+ft88mE+zhpYgNYfUdJVd5you7DUN6xCMvSX8GX7UZgo8vf/8N7Li0uowj98oFcEHIF2T6wA21TehchlUBeMrbdkX7/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A95HTVHA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A95HTVHA"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-231c86bffc1so32862955ad.0
        for <git@vger.kernel.org>; Sun, 18 May 2025 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747554213; x=1748159013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VvU/u9woi4obNyQvvteoZrePFEOoO1fNnsT9mP8MPI=;
        b=A95HTVHAqXE4iQceC5Cw9gKnXKoaaKVWwhdt4KdIW0jyCeJj7rGY4vlUkv5akDQ9NK
         CSl3FNH/PQfJWxniVjRr39FaRqh4xAv1nYqZYECMvfZXdpnVCj3NFS1/mY4qN/DPRZNY
         VFsaAzeLTzEuBGPsNBev68H7RP2Yc1TtCowfpcnDP9Jciizu2AAOj3EnuoCJ3I5vD6Bm
         DIlFdEzkUNoOAbJ7x/kXdOgWu53xn2Fds7wajvmZ8ELxJBOAUujOZ77zdYt/Tps7s2Ko
         9r48ZhxnrGYOgAo5qIjtC3AC50wI9BLDUdZu1TiDcaRNxwlHr0MYwT6BPzEm6GUc0sJ4
         uLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747554213; x=1748159013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VvU/u9woi4obNyQvvteoZrePFEOoO1fNnsT9mP8MPI=;
        b=Qus/Cf1MJVHrC6gC7CalYKHs+sIt5oUWK0Q7jbVtmWckL6I47hy0ZgFB29pAnGxpfS
         bUQSt6AVO57yTUX6mDpnxo00g6oi4H0AvyjRORVE+nvTc3EjluDZCnCZAyMynCijgN8a
         ryVKfSYk0UR8PqvDH9W0AI1G77K4ch1zFbd/iteyRni/oXqAO3nn2HGEHBWiPhdgImeV
         WDlqIurIgdu7vd3RhjqOdBC6UwCEjzz2thFuEOYFl0NawqMUbVxNJ9XEsqwxReZuHCa/
         ifN28QjpxEmqQabMAGPY889/7uysFRRABviVg+Wot2pGY1/WBvb7QYQR9ZJ0yQqcYkM8
         e48g==
X-Gm-Message-State: AOJu0YyXiysGW2HUQpG+sSxCsROGSk7ogC+CyNprAEMXNXYCWyJC3lix
	0pUEwE0hy21bVtNx+5RcXWfHcVAmD7oQySkdoVRgkiEtcPYF5sm8cJkgKtsdcvc9
X-Gm-Gg: ASbGncuOh3FTx0C0+MCDxp+194qgeOcRMiej1lt+hQ8jlXW5827OP/Vod4QZ0ASoZeb
	Qn+xXA3PHThBdurB7rXHCETp+Q79WbU4G94QS3s41aFI/YUkKy96ouwP5P+y+oUYVnnt4wY3gAH
	EaqRxuRZpE/OZx/HPhSYgEC/RRuVq74EjxBsHtBuEj5oZCexjD3NabNPtvMN9IWG8hCjP4a8o8T
	Ur9IXGh/6ih5Toy6ez2WUKSuR18y4UVGLiS11oAqC2y5RPjxNzRmpPXTv8URQn4/7o6nC/n10pS
	HbUnxGn+tk5ztoaFOMQ27u5wz5/xgNVPjszo7wxCPw8oVM0KMVD2SuMJ1vshkUlEuj8=
X-Google-Smtp-Source: AGHT+IGODAuTdtrf8IL/HaGfYq/dJ8wvZQFWOkj1UcaAYl6TxuX2OOkioZl/ZE3YOddFsUSUPIvrvA==
X-Received: by 2002:a17:902:cf09:b0:231:bee7:8609 with SMTP id d9443c01a7336-231de361d05mr96081135ad.18.1747554213325;
        Sun, 18 May 2025 00:43:33 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac9fbdsm40131625ad.50.2025.05.18.00.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 00:43:33 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	jayatheerthkulkarni2005@gmail.com,
	nasamuffin@google.com
Subject: [PATCH v4 1/3] docs: remove unused mentoring mailing list reference
Date: Sun, 18 May 2025 13:13:15 +0530
Message-ID: <20250518074317.73367-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250518074317.73367-1-jayatheerthkulkarni2005@gmail.com>
References: <20250518074317.73367-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git-mentoring group was initially created to help newcomers
with their development itches. However, in practice,
most of their questions were already being addressed
directly on the mailing list, and contributors consistently
received helpful responses there.

Remove the mentoring group details from the Documentation.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index ca1d688c9b..ef190d8748 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -40,14 +40,6 @@ the list by sending an email to <git+subscribe@vger.kernel.org>
 The https://lore.kernel.org/git[archive] of this mailing list is
 available to view in a browser.
 
-==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
-
-This mailing list is targeted to new contributors and was created as a place to
-post questions and receive answers outside of the public eye of the main list.
-Veteran contributors who are especially interested in helping mentor newcomers
-are present on the list. In order to avoid search indexers, group membership is
-required to view messages; anyone can join and no approval is required.
-
 ==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
 
 This IRC channel is for conversations between Git contributors. If someone is
-- 
2.49.GIT


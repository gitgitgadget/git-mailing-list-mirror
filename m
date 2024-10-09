Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847D1194C6B
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478562; cv=none; b=N7bp/2rgL+Sc8V98w6wdW9kRsx/iOCN2bhrAAxzv9aL6RUzyPuz/3wKHOCR55Lg6bYhM7ZWg6e7PF0Cwl/a/vTvxxlD+4gsAfd0xwpKCTa5hEM7P2joFrbdflkXoASBPG/v6nReHKx105JftMABvLs9TL35hsQ5389HIuHwpT7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478562; c=relaxed/simple;
	bh=LJH0cXYbFTonO9Zu+PA1/nKmbt4HEXQbpqw2DhqCR6M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOu4b0owElH9ha0sgjpXTSQa+Zc3OiTU/EcWpJSEhfDSyVLyvqZBVUqWPlJOTJneUqWwbqLSTpFTHsW4qH3nk+tb/r+fqsxrhGngDYk2IaLb0sCwSaGhjNOtO6Gxwkp5rqdWfrngHlLkS6il8fYhC9rmPmH9m5EJOlOdZqydgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAvRqiwH; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAvRqiwH"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-50ca3428289so1221901e0c.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 05:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728478559; x=1729083359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqup1YDOyJ4x3b28qxI/cCxkTLBX+87HPrp73Yp1XCE=;
        b=MAvRqiwHAPmp0IdMgiKQX43/jZ42yeo51vLPOwVoJrVoSR5ckXXa2t/NEQwuPcHjcZ
         c1RPuYnMh89UaD5XauXbb8XxsULruX2y/mU5e9kiDtgn9A0nTbtOJLy8h4By2qIjWUt3
         Hku6rf1zDaCO1GnMVFXv+FS1b5xRh/w+VpXPP/BTID47LEpxJBuN34ZoP3y1IVgXAugv
         7lSBoJXfuE8Wcuxv7eKKhphPjddmk38bXfAoJjJQQukdSTS6pf5fY3GmP+u61L8L71Oc
         dPdPV8AwnSsJNdyZPEun1HRU1YgNWaQLmp4n18RRweD+4gtdQNftP6yea7g6a0QKCd91
         v0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728478559; x=1729083359;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqup1YDOyJ4x3b28qxI/cCxkTLBX+87HPrp73Yp1XCE=;
        b=avgpZyiDqJ5g8blAIa7l807HGbjyBIH+aUvFu9hsk5m6GVK97t1Ye0r0VQO1YuxoZh
         kNnDhkNYcGvOo93sjE9oza+gSVEETIj0kY80a+J/B43QKcNF92SbOtYg/+P0EAqq6WjB
         VRqk+yKOAEDJX7WD9+rnI0lfPG5uJg/PivD0/iSDzRxHzNZM87T3UdGF7xbuQGU4K2vu
         SZzrj1//LjHke0Cv7YAzsJXcK8dK2tEpdqDIICc7bE/T6dc08U9V1JwHoyfjtopKLxWM
         es/E1NOrpUdwkBc9kf5uzin1GiumZ5iK3qTbOpcg9ILPU9SXEpJtl82QRLGTyuwru6cI
         amVw==
X-Gm-Message-State: AOJu0Yw/jYRUXVEaVLNkJFzSY8vmMo+DlKaTlSWIQW+6z3vudGwT+k05
	1VHPyqNeyLUoECS0oMzUKbyRU6NXyF1BG0woymlxEaxXgDC+dvjm5huQ8DB5sPdoRUrsOkDrcDt
	TffE6ckfYd6S6e/3bbNPRw/Duvt4=
X-Google-Smtp-Source: AGHT+IHtQjKCfDgWP0lDGpP3BOgu2jFHQIP9hqtKCoNzt/sx/hZyg8HzsgjJWocTOcT+a+Lna3/iPrlQxIvj1hHWNo8=
X-Received: by 2002:a05:6122:d11:b0:50a:ca33:b033 with SMTP id
 71dfb90a1353d-50cf09b7c21mr1251750e0c.4.1728478559434; Wed, 09 Oct 2024
 05:55:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Oct 2024 05:55:59 -0700
From: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
References: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Oct 2024 05:55:59 -0700
Message-ID: <CAOLa=ZS+naxOzJUkLLOZk++WVZ2dt3eQq9VmW+G-5O1ZLgggUA@mail.gmail.com>
Subject: [PATCH 1/3] clang-format: don't enforce the column limit
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The current value for the column limit is set to 80. While this is as
expected, we often prefer readability over this strict limit. This means
it is common to find code which extends over 80 characters. So let's
change the column limit to be 0 instead. This ensures that the formatter
doesn't complain about code strictly not following the column limit.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 41969eca4b..38910a3a53 100644
--- a/.clang-format
+++ b/.clang-format
@@ -12,7 +12,11 @@ UseTab: Always
 TabWidth: 8
 IndentWidth: 8
 ContinuationIndentWidth: 8
-ColumnLimit: 80
+
+# While we recommend keeping column limit to 80, we don't want to
+# enforce it as we generally are more lenient with this rule and
+# prefer to prioritize readability.
+ColumnLimit: 0

 # C Language specifics
 Language: Cpp
-- 
2.46.2

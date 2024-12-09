Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7B1F5F6
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767742; cv=none; b=T2qTZOvYS+bfdXt44jC9NDcZYWfHQmd0XUZUBZ+kbyPYr9+Cgiq4OjvsnpXf1xZxzOUJ9mpC2ZFtUQOgRjKjtMQ9KkZB9zlrphLDZqC0uaFsdTPYaZvqn2tnlTStUJ31+8hanGmvSQtOWrq/F8lrwfJ8A5zYpZpDz0d+jV+R4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767742; c=relaxed/simple;
	bh=rH7ww8HY6BoGXuMHbcRltHTtkMJMvWb5MoORcag1Ocw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=eip3sQvbPwWYJY5XnQ00sK4I01KzmqKtN/NL6xmJvYHgL2+LM+Ylm4Tx8mYXwddGmDw8MoKoRbyHVe5Z/seKOqBszHax3SzXRKMd7C8casuLO+mvBoGoN4YrMqbOvhTD43QemhOgYOtPFXCKUIz5fb5rttABNo8rZzJ5BZCH+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHeFcjmk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHeFcjmk"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-435005192d1so3872755e9.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 10:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733767739; x=1734372539; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ2oQW5YAw1gdgvjUVd6I+81jO6QpQRO2IjuUo/IRhA=;
        b=mHeFcjmkNNaEVKFoTnliOKqXW/AIGzP/KnTXH+17cBgbbx2fPwrTLDeuu4gyuILHXD
         AFtseqiNCzjDKfY8+Io4ojCBfBxS6RDGsFLznn82ZZ2/pL6WTC39RPRd+0n94iggjkIY
         nzhDZVqW4W4GVwDVbwRPHR72UWdGS2c74E32h6DD3JIf7u4DQEaPebXY/O8P/LYLcJyH
         2rXSpkk/Cps9QLEQwuEQC8JqhysmxnGeN0JE+uWY6BtbkZC73AHyWUnchPLT4OUqxD3s
         NWoLJUntUPMIJnusS7v4qVmrt/WBbI65ClIHrr68+wdrUPyR0BjY6dk0b/x0wrCnCvlQ
         peXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733767739; x=1734372539;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJ2oQW5YAw1gdgvjUVd6I+81jO6QpQRO2IjuUo/IRhA=;
        b=SrEJNF8dSx3qKmx8KW7rDKezLWJ8KswOCLrTpSxzrKHuaRdKEgQdyV314uZFhfojO+
         zY0dMUBy0B0ZleJ8dXr62/GztPhjEEWYWaUVu1RILct9r75zKJ0aXcTr+O47RsrW5Coz
         iM59EwZoBRmTESGH+84/hhDDarP+OAoyQBVxovLnflzh77LZlqs1JPD9bUWOqjLjuGgL
         50xNnzwprMNjh8M+pPgSxmIbK2TWov0311JVmv84gO48iGMcOM8YEx7WBbkUjEdJUXyH
         hxSxFZfhYY8INBLN7WIOWr2f+ITqq8lJ3ZehzUhTTbb5eRtDDQSvbMjmwZr2DooEbKSL
         EAag==
X-Gm-Message-State: AOJu0YxSgZJUbDR1pQNs+F0BQJBHFrLqJjTGRiYKqgWQuDXQyMNeFM35
	kAuSzrmHUJH06qfORGE+o04Im0MiuUEUge/moe0XyHbT2yhDF1hfT8GxzQ==
X-Gm-Gg: ASbGnct+RCsEPMfTdGtwk0b8Dra7r/Ag2o6jnTROQyFE3w1dEGI2qT1Mx6oixwGGMlT
	CUGrGcZs1w5W/AccL7+hrvDGuYhFQCjinujMwxDOWA40DkzqomyNt0/w9gwR+xiRikgQzEEnhiX
	8tLdJOAs9i23jXAtvaia+W/PZkw6kTUwOr0QKGGhjAhTb+kKzDlWiVLcIR1AK29e8oDxjok2Uj8
	8D+x3mszos4QrEcQfXW9SPe0mweEkF6xIr4d6elzkT4yILMy2s=
X-Google-Smtp-Source: AGHT+IGmDw9MDQ7oEDkEO1mkW+xdJyDYbDg1R7+EoxIci0zT5i1MO5YK1GFen1653596ZMdPwa3Amg==
X-Received: by 2002:a5d:6d0f:0:b0:385:e394:37ea with SMTP id ffacd0b85a97d-3862b36ce4fmr10588131f8f.22.1733767738843;
        Mon, 09 Dec 2024 10:08:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386220b07e1sm13601503f8f.102.2024.12.09.10.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 10:08:58 -0800 (PST)
Message-Id: <pull.1835.git.1733767737.gitgitgadget@gmail.com>
From: "Christoph Sommer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Dec 2024 18:08:55 +0000
Subject: [PATCH 0/2] gitk: text wrapping in ctext (commit headers, subject, and body)
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
Cc: Christoph Sommer <sommer@cms-labs.org>

Using gitk to view diffs of source code without hard linebreaks is a bit
painful without dynamic word wrapping, for which I could not find a
preference. The only related one I found was for wrapping the commit subject
(called a comment in the source code, I guess), and that did not seem to be
reconfigurable in a running gitk.

On the off chance that such features might also be useful to somebody else I
am sharing them publicly, as two semi-related changes:


gitk: add text wrapping preferences
===================================

Add a new preference "wrapdefault" which allows enabling char/word wrap.
Impacts all text in the ctext widget for which no other preference exists.

Also make the (existing) preference "wrapcomment" configurable graphically.
Its setting impacts only the "comment" part of the ctext widget.


gitk: make headings of preferences bold
=======================================

Make preference groups like "Diff display options" stand out more.

Christoph Sommer (2):
  gitk: make headings of preferences bold
  gitk: add text wrapping preferences

 gitk-git/gitk | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)


base-commit: e66fd72e972df760a53c3d6da023c17adfc426d6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1835%2Fsommer%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1835/sommer/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1835
-- 
gitgitgadget

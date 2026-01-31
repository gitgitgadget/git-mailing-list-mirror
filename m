Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED7E37A497
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769895801; cv=none; b=CCxDbdwiQxTIenMwU5hy6UTMUmVDgQW2///Tbdp89eC81++AXUn+dpoq5FLy5bmGS7sfMBMX5TYgaf+mzgkxpwQP+C941ecshXbY5MjQKr4CqhmsLzJ51vB6oUwi5rUj11JChF9ufrdzA5Hg5QzAS9GndZpGrSW4hUa/ar7TcFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769895801; c=relaxed/simple;
	bh=xK1uqDmV8Y7gjjdHAURaWEm89W3y8Nm5v9t2u3Sx0qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wd55C6jjVtIo3EISChM7k4hsCqqfBgObPVm9NCsRIgQpEnkrhyolIZrkx3NyP0L9hGMu3W4nJxgVT20tzqKziidEh5TePnR9aLgbM0JwGk6goaqUB3GU1J2IkUhYQhR24hqa3dn/3oiL/wiW5bml8CBC/lCMGHqjLUNfJMNSuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asP1mteX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asP1mteX"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6d8751c88so343947985a.2
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 13:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769895795; x=1770500595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yp53PwXjz1lx+68KJeO6wtVGxcaWaaUPl+tT9fc6cJ0=;
        b=asP1mteXjlS0DXL+LZRmkMxGOPFoJV6ox5BjoJSw/yBGwGKERt4L3ICxo8HYbUDeqZ
         fYLMPikWqDFyy/qWlWnI2f8/aYLjbIPw15F7i49Rh/PZbJHl5YcxI0QxmVuXwNT6vLUJ
         r5k0jUg/7a+5kQuo9wRCXflOCYaj3uG7GAlUFNK0cV1gRxU5c3X73TJxpy791FDpmG9+
         zQHWEhaxh+oJ3BwzCZW6tyPKKhefB5/huPxW+yzH4ceBRcBmfC/uLNZDIO/Dq1xB1yyC
         qPFUPi072WAwMhuexFDROFx+s9QwVbFFWcVlEQqovqkJ8MDRnlqKIk2ZCnJZaLTQFLKB
         Jkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769895795; x=1770500595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yp53PwXjz1lx+68KJeO6wtVGxcaWaaUPl+tT9fc6cJ0=;
        b=Gk5h+ukCZK4xwYnuH6dl2BnXDU0AIunwBfR2KslDHYpi55fInBA2xaonnKEByh3eQh
         GFMiPA1j2zy2JCGSSIAj7+hjFCbQUacY3rsYweDBsaDMJFZveosG9osyXqg7cu+IguE9
         yPhU4F+K+WtxSX7EylMU7g8KYW1UF7rFEmvR0hmhLvElyl1H8qLp8HavOivOuUFIcsG/
         fiMQ6wNv0MhcUhhIGyCAhZ+OqS8RcNTKCsS9f88/7YFDl1BYTk+dMZbUe8ZrTqaflPeb
         wvRLlLEdhLZl8pvZfcgRSjLHmrHOgL9WSy7H0ZtI2Ah4ZCdC/FKgzZecr+2KieA4CfD9
         EJSw==
X-Gm-Message-State: AOJu0YyDCOvJhAXMsHoixFPGYIV8v+qlT5uWrg6WnCLtR0oYtDmoYH6k
	jZviHhRNB6b0oJByZUa5TWamtUFQhozeP0zwvv/bYE/i3CVR/ro8X/9z6Q613nNb
X-Gm-Gg: AZuq6aI2P/jdaUF8r9+2PsT3GK9e+2URfrdWnVJH6MT5XZDM6BYG7ZPl93RfOxW8uqr
	msWOFXPmFUXN/w/ZqqJLD3ZY8Gj7OOrwsLFCuZgs/Vtqr0pOQ8M4GUnTFdF4CGLVM9b8MRxjMEb
	J3yWERHmY8RXJNYxkgWWkyCPXKjsp5NIyS/A2XmGigKDsHR33atEVuujQ+Qaptbs6Af0Djo2cim
	bYuuj7qt8sjg3VO9N0DzLzoGT0QZAd0PxZ7GpKMC+RjxyBhJeM+yenUkI8EYTn0wB8mGoeSwSsC
	jr6B+iyntyNI4HbtLlvPoVwwqSngD+dUGms9wvnBAYFLUKp6ZFhtnGer8ZG35dtS+BuXTVyvqI+
	d7EH1MdsdTddgb4/L9ylF65A0pMoBJWBtxHx3ZnCFG6wriIUvmLPQgqodgY1gsXDjaH0gegF9Nu
	Q2JfwYVWdGaSY=
X-Received: by 2002:a05:620a:25d4:b0:8c5:310d:3b2d with SMTP id af79cd13be357-8c9eb2708b7mr943010485a.33.1769895795318;
        Sat, 31 Jan 2026 13:43:15 -0800 (PST)
Received: from development.internal ([107.11.98.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b99fcbsm965368785a.18.2026.01.31.13.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 13:43:13 -0800 (PST)
From: William Hatfield <whatfield.git@gmail.com>
To: git@vger.kernel.org
Cc: glencbz@gmail.com,
	avarab@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	William Hatfield <whatfield.git@gmail.com>
Subject: [PATCH 0/5] submodule: add 'reversive' traversal options to foreach
Date: Sat, 31 Jan 2026 16:43:04 -0500
Message-ID: <20260131214309.1899376-1-whatfield.git@gmail.com>
X-Mailer: git-send-email 2.53.0-rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces robust post-order (dependency-ordered) traversal to
`git submodule foreach` through three new flags: `--reverse-traversal`,
`--append-superproject`, and the shorthand `--reversive`. These options allow
users to process nested submodules before their parents and include the
superproject in the operation, enabling reliable automation for
dependency-ordered cleanup, builds, and deployment workflows.

Highlights:
- Implements all new traversal flags in both the C helper and shell script.
- Provides a comprehensive test suite (t7425) that validates the new behaviors.
- Updates documentation to describe the new options and their intended use.

These changes make submodule automation more powerful and flexible for advanced
and dependency-sensitive use cases.

William Hatfield (5):
  t7425: add tests for reversive submodule traversal
  submodule: teach and plumb reverse-traversal behavior
  submodule: teach and plumb append-superproject behavior
  submodule: introduce reversive shorthand mode
  doc: document reversive traversal and related modes

 Documentation/git-submodule.adoc |  20 ++
 builtin/submodule--helper.c      |  98 ++++++++--
 git-submodule.sh                 |  13 ++
 t/meson.build                    |   1 +
 t/t7425-submodule-reversion.sh   | 314 +++++++++++++++++++++++++++++++
 5 files changed, 435 insertions(+), 11 deletions(-)
 create mode 100755 t/t7425-submodule-reversion.sh

-- 
2.53.0-rc0


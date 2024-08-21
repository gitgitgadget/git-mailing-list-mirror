Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF441C8713
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238158; cv=none; b=G0NeeCX9aFEkndFP0wqEWcDzSNQUKP4iaCXX+D7BckA0hw46ylLvjk1Ypgb3dxkjC1x7KPsC2LjfxQ0SXQGLF4vgwECEBe/PBVJCPml7iXNfi/ykthjxV/W727MpQJhIfTCsX5nompi2hQiLxCi2WGnDVs4ahUPrskKA9xeZ26M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238158; c=relaxed/simple;
	bh=xIGwqruw+lIIURY4Jr/nKyhaS6JpXUD7Jpg0mF+O7i4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=CFZNTWv6PC/ozVHU8dF7sk1JWJNi9GQo4yBKu8zxQVmtCjwtYK4sLGT9qitMIfWcNJ9npx6SIv8bQHnTHfEPrmLsdTgrn6+UXVQfFxJhN9Ke7OtKI0HyL5JkXCLaFLHlVlftYrZ1TijjrFe15XOVdi1i2UdTvd+Gq8rGvbSV0xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIVVGnKd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIVVGnKd"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2b1e1so2651409a12.3
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 04:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724238155; x=1724842955; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qkZu+ZOVWi9h4i69+T7CU0lkG0e/tbmmdsZ9h4QUFro=;
        b=JIVVGnKdNRPm/YQZv0Yqme0ClwWZDh/L0Z9gtdEu9rRohgdAnFJSK0MOKttibjg3uM
         gOr01N9ZEvI2gRvpfB84ByhoWudB9ir69kTwgQ1BG5SyR0n5yjV0qB4ZsLSswcxs5kM7
         p5JCi+cII9MoSpAbwFsgzIIHGEEW6yCdaZoBHkXJM+nTYRpfgCAtlKMagv0DKk4YnP5E
         M6wVJYaW/YGEmNaLbJCV5O4wIcNpMdrU86SmPWhF+Iv37P2xIXR3eLwz08tjm9zoNoVp
         HLB7ywJacEgy0K2PFqcUGKkP/b/eB0AmDt/4luuowMsG/dbd2u9BC3QYPytKNgTpYJl/
         fHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724238155; x=1724842955;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkZu+ZOVWi9h4i69+T7CU0lkG0e/tbmmdsZ9h4QUFro=;
        b=rLaQRJlVd7EUcjYC6ga6EQ7lARvgY95IGOfOxXWY0w+lSdty5vA4efnPuWLwQe/YqH
         04tF8j0/XNuKnfx6X1k/HK1vRIr9tt4WwA2qEwRYckD4aYg9u7AZnyOUr3efjCGZt36r
         zfXgo6H11cJ2gY7U70KkJHkvNcKfcJ9xWcSxGQ+Hfe9tt0TpkGwpElSKAvJKCRfjeKYl
         C5l2sBNsEkvRESgLgVkg4uhXGLSNYTsmDXKvyfMDyTcMKHH2fmvfHvrl2OYizoCmFnDO
         8T+H5Rh/N1YLt5YLyqC6fWa9u8NmCdQ4yOPtPww/wvsgteEOxO3x4RAFuClumm2+tu/f
         ThRQ==
X-Gm-Message-State: AOJu0YyaO0TW3C67DXXQ5KgQpxAnOfNztkqivtQyXN7Pes68HEv8cSbe
	3DY65ecNWM97xMxnu5KcTdKp9cqXhDZeOGZOEwIgbZ0OmmZiPP62GCit/g==
X-Google-Smtp-Source: AGHT+IFKgrNlJ3UMrN6ItH11BdL6YteVRg00roP035z/zB16ZfSkhWDJj8qNqprGVMYsOLuw87L35A==
X-Received: by 2002:a05:6402:2710:b0:58b:1a5e:c0e7 with SMTP id 4fb4d7f45d1cf-5bf1f294373mr1558628a12.35.1724238154456;
        Wed, 21 Aug 2024 04:02:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5beef16a9bbsm4288733a12.57.2024.08.21.04.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:02:34 -0700 (PDT)
Message-Id: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Aug 2024 11:02:25 +0000
Subject: [PATCH 0/7] [RFC] advice: refuse to output if stderr not TTY
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
    Johannes.Schindelin@gmx.de,
    ps@pks.im,
    james@jamesliu.io,
    Derrick Stolee <stolee@gmail.com>

Advice is supposed to be for humans, not machines. Why do we output it when
stderr is not a terminal? Let's stop doing that.

I'm labeling this as an RFC because I believe there is some risk with this
change. In particular, this does change behavior to reduce the output that
some scripts may depend upon. But this output is not intended to be locked
in and we add or edit advice messages without considering this impact, so
there is risk in the existing system already.

This series is motivated by an internal tool breaking due to the advice
message added to Git 2.46.0 by 9479a31d603 (advice: warn when sparse index
expands, 2024-07-08). This tool is assuming that any output to stderr is an
error, and in this case is attempting to parse it to determine what kind of
error (warning, error, or failure).

I've recommended that the tool author remove the advice message for now, but
I'd like to help other tool authors avoid this surprise.

I read the thread for the --no-advice option [1] looking to see if this was
presented as an option, but did not see it as part of that review. I hope
that this is not considered a breaking change for users, but I could see the
argument for that.

[1]
https://lore.kernel.org/git/20240424035857.84583-1-james@jamesliu.io/t/#u

 * Patches 1-5 are preparation patches to make the test library work to test
   the advice system after the final patch. These are split by test file
   name to reduce the size of the patches, but could be squashed into a
   megapatch if necessary. This is usually a simple addition of the
   GIT_ADVICE=1 environment variable, but there were some changes made to
   those lines to be more correct as necessary.
 * Patch 6 highlights the fact that 'git status' uses advice_enabled() to
   determine if it should print certain parenthetical results. See
   format_tracking_info() in remote.c for an example. This output doesn't
   use the advise() method, but instead appends to a string buffer that is
   later sent to stdout. (If we think this part of the change is too risky,
   then we could move the isatty() out of advice_enabled() and into
   advise(), but that would not match the existing behavior of what is
   blocked by --no-advice.)
 * Patch 7 modifies advice_enabled() to disable when isatty(2) is false and
   GIT_ADVICE is unset.

Thanks, - Stolee

Derrick Stolee (7):
  t1000-2000: add GIT_ADVICE=1 for advice tests
  t3000-4000: add GIT_ADVICE=1 to advice tests
  t5000: add GIT_ADVICE=1 to advice tests
  t6000: add GIT_ADVICE=1 to advice tests
  t7000: add GIT_ADVICE=1 to advice tests
  t7508/12: set GIT_ADVICE=1 across all tests
  advice: refuse to output if stderr not TTY

 Documentation/config/advice.txt           |  9 ++-
 advice.c                                  |  4 +-
 t/lib-httpd.sh                            |  2 +-
 t/t0018-advice.sh                         | 18 +++--
 t/t1092-sparse-checkout-compatibility.sh  | 18 ++---
 t/t2020-checkout-detach.sh                | 25 ++++---
 t/t2024-checkout-dwim.sh                  |  5 +-
 t/t2060-switch.sh                         |  4 +-
 t/t2204-add-ignored.sh                    |  8 +--
 t/t2400-worktree-add.sh                   | 12 ++--
 t/t3200-branch.sh                         |  4 +-
 t/t3404-rebase-interactive.sh             |  2 +-
 t/t3501-revert-cherry-pick.sh             |  2 +-
 t/t3507-cherry-pick-conflict.sh           |  4 +-
 t/t3510-cherry-pick-sequence.sh           |  6 +-
 t/t3600-rm.sh                             | 12 ++--
 t/t3602-rm-sparse-checkout.sh             | 18 ++---
 t/t3700-add.sh                            |  6 +-
 t/t3705-add-sparse-checkout.sh            | 32 ++++-----
 t/t4150-am.sh                             | 14 ++--
 t/t5505-remote.sh                         |  5 +-
 t/t5520-pull.sh                           |  4 +-
 t/t5541-http-push-smart.sh                |  6 +-
 t/t6001-rev-list-graft.sh                 |  4 +-
 t/t6050-replace.sh                        |  6 +-
 t/t6436-merge-overwrite.sh                |  6 +-
 t/t6437-submodule-merge.sh                | 16 ++---
 t/t6439-merge-co-error-msgs.sh            | 12 ++--
 t/t7002-mv-sparse-checkout.sh             | 85 ++++++++++++-----------
 t/t7004-tag.sh                            |  2 +-
 t/t7060-wtstatus.sh                       | 11 +--
 t/t7201-co.sh                             |  2 +-
 t/t7400-submodule-basic.sh                |  2 +-
 t/t7402-submodule-rebase.sh               |  3 +-
 t/t7406-submodule-update.sh               |  2 +-
 t/t7500-commit-template-squash-signoff.sh |  3 +-
 t/t7508-status.sh                         |  4 ++
 t/t7512-status-help.sh                    |  8 ++-
 t/t7520-ignored-hook-warning.sh           |  8 +--
 39 files changed, 214 insertions(+), 180 deletions(-)


base-commit: bb9c16bd4f1a9a00799e10c81ee6506cf468c0c7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1776%2Fderrickstolee%2Fadvice-tty-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1776/derrickstolee/advice-tty-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1776
-- 
gitgitgadget

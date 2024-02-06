Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C864130AC7
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225617; cv=none; b=s7riVt7ntXV3Ale+2HW0iRvMLaIdFstUtHt3ONv+RxBVRcaF3x6Sl2J7AVI+L5j06jOmLC78Nys5Z8tXYJMxGMabtRxqFfQz0nVN2ISqFoLOrEjNQex88OJ6iJFsyBZ1dQc3JLGAUa/MX0rQNWKpo0UAygUOEoQfpOibaRzmXkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225617; c=relaxed/simple;
	bh=CjEFt0pyCdW4uOgDSnT+sFetVg7X+Jqx6GcLfHFGSF8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BjnU85R7CB6EfGPT1y9AQ3gsRXtzGGTqcOgl6YUGaPB86/DVFqf9ShLmVjG8pLXw2814FsdVgVbIvn2CYXn7khYaffm97SDQjiGNPfs1VWW5ZBLnONtGl3scMvIhwfmHDODzxOEOwfL9uNZ/BvF2muDEI8Auto/gvB5CLlaU6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RS5HYtl7; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS5HYtl7"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so7300108a12.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707225613; x=1707830413; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkHPYBTlTDflC6Yd73ueIov5cjIU2Iy0FtNls23aywo=;
        b=RS5HYtl77AS8wbvRtniuJZUrTOFRqp/D4lgcI4qs+GkIfDZ/4uFHm7j7a5evVx11Ln
         zPdj2mNLbVfRuP3uGfB6nwPkp1yAKNQiIO3QcIQryEQW6PnqW58/4Dbe3wvxD+4lnCEN
         V8BwUU0+LtWnbBoyTX/wtXb7l3PadV9e2eiSBO5QyoJTYqzF/h3mr8xzqt9ivU2zTKfn
         F2H7sVhOgDgzVA2cyp0adJR7cuyuHf2ZOEKvjtgh44oykLksCHp14MGvUobN0ulgvLAk
         Ddtf906p0EcwzVAARHXux7o7FtmleRkan1fGlGlYJkahnT5u83I80A5BKruRaHeOI/bG
         k9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707225613; x=1707830413;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkHPYBTlTDflC6Yd73ueIov5cjIU2Iy0FtNls23aywo=;
        b=t6hr7ajHlNnalE7kBvWtdlZQBeW4n52xue9yqEuvIREsk6kEC4MWLxcqzRpUVu1Orb
         gN1SupQ9VrtCOkGkcrrNnTlWR9EKFKLh4tJpeEcvHN7JUsn16QcxbzeK569cyjwg9qNb
         MgPGQGHHA7qHhnraoJ6sBIdVCZRxd6UhhGqdSgVGKH92t8DHWExBgX4gD3LhRldUGNSA
         OE+gMCVeOxOK1uCuSnuTgzgAqKWzyodaiLnj7z7V7d8GOvo7ajYFW7S8HYCFapz6lqEj
         gdzx3zaOd2EpGVBtu6APvzlKBXYbtY7ReX7ZMGk+1Z2TylIWjO36TOD7EUbOI2Q5K+wp
         kvBA==
X-Gm-Message-State: AOJu0YymV/Tt/luiWQnp5/JagX3b3hEnWzMWaolF8OZ3AzcbEKlQVJnq
	VZ6mvjARszBBuJ7ya0xkZTbT56Sszv2jgaiiI9OyySsphc7hCq1gMEE+jBcl
X-Google-Smtp-Source: AGHT+IEJhws+BH0YsI9ECPuxmeuupAwGQjpOCaZoV6oQGzUpjFr/NdMlLSTa2XZZavYEzJRX4uSPDg==
X-Received: by 2002:a17:907:2cf5:b0:a37:9bf7:bff3 with SMTP id hz21-20020a1709072cf500b00a379bf7bff3mr1327045ejc.58.1707225613491;
        Tue, 06 Feb 2024 05:20:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWD2ZU+xfRTHC3VjXDMwXJwgu0MpIEjn4wuYmquqHwPVKKI6uluJ+gcV4kaRv5uuGuJuDPM3n+wzRzF6nbBan5n3ALvrKzwHCtJW++n2w==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906111500b00a372330e834sm1143055eja.102.2024.02.06.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:20:13 -0800 (PST)
Message-ID: <pull.1665.v2.git.git.1707225612576.gitgitgadget@gmail.com>
In-Reply-To: <pull.1665.git.git.1707069808205.gitgitgadget@gmail.com>
References: <pull.1665.git.git.1707069808205.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 13:20:12 +0000
Subject: [PATCH v2] .github/PULL_REQUEST_TEMPLATE.md: add a note about
 single-commit PRs
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Contributors using Gitgitgadget continue to send single-commit PRs with
their commit message text duplicated below the three-dash line,
increasing the signal-to-noise ratio for reviewers.

This is because Gitgitgadget copies the pull request description as an
in-patch commentary, for single-commit PRs, and _GitHub_ defaults to
prefilling the pull request description with the commit message, for
single-commit PRs (followed by the content of the pull request
template).

Add a note in the pull request template mentioning that for
single-commit PRs, the PR description should thus be kept empty, in the
hope that contributors read it and act on it.

This partly addresses:
https://github.com/gitgitgadget/gitgitgadget/issues/340

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    .github/PULL_REQUEST_TEMPLATE.md: add a note about single-commit PRs
    
    Changes since v1:
    
     * simplified the wording as suggested by Junio

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1665%2Fphil-blain%2Fempty-description-single-commit-prs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1665/phil-blain/empty-description-single-commit-prs-v2
Pull-Request: https://github.com/git/git/pull/1665

Range-diff vs v1:

 1:  4786f84884a ! 1:  f719e11b1df .github/PULL_REQUEST_TEMPLATE.md: add a note about single-commit PRs
     @@ .github/PULL_REQUEST_TEMPLATE.md: a mailing list (git@vger.kernel.org) for code
       bug reports. Nevertheless, you can use GitGitGadget (https://gitgitgadget.github.io/)
       to conveniently send your Pull Requests commits to our mailing list.
       
     -+If you use Gitgitgadget for a single-commit pull request, please *leave the pull
     -+request description empty*: your commit message itself should describe your
     -+changes.
     ++For a single-commit pull request, please *leave the pull request description
     ++empty*: your commit message itself should describe your changes.
      +
       Please read the "guidelines for contributing" linked above!


 .github/PULL_REQUEST_TEMPLATE.md | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMPLATE.md
index 952c7c3a2aa..37654cdfd7a 100644
--- a/.github/PULL_REQUEST_TEMPLATE.md
+++ b/.github/PULL_REQUEST_TEMPLATE.md
@@ -4,4 +4,7 @@ a mailing list (git@vger.kernel.org) for code submissions, code reviews, and
 bug reports. Nevertheless, you can use GitGitGadget (https://gitgitgadget.github.io/)
 to conveniently send your Pull Requests commits to our mailing list.
 
+For a single-commit pull request, please *leave the pull request description
+empty*: your commit message itself should describe your changes.
+
 Please read the "guidelines for contributing" linked above!

base-commit: bc7ee2e5e16f0d1e710ef8fab3db59ab11f2bbe7
-- 
gitgitgadget

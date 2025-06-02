Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D32C3258
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748882447; cv=none; b=HxTKPEOiPTDv3A5XFhO60AlcVkj4hTdRe52zZ9DvRFExAvQWGRAM6kzwPaJjUzxliKAnO2Civwaf+xGK895TqFdbFFnnnGAFrdPP9pxPAwd0Sx7S6Ba26/+FUgbjK7f92j8XF449mVg71vqOvJvPd06K3EAW8yi/4b8gqEJaZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748882447; c=relaxed/simple;
	bh=Ai+WSedLxQ9HSxqnQ0qGZCeSS0XfybI2r8TenwT6Ux8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=G8BjMOxmCRhL9FpAnyIIXAinNk32/M/cIF2uf7i/Qgfjwv0DoSo8Qv75A9XAh0Y8uIizOMbraeTjzD37XjNdvGh4BG6YTkGVYhpX+BQHnlQUOHFH2wob4VhWZRe1Rb8QiBPYV6Ys7SMcYTm+69bK/8WkbZN5sbfxTWWsmHWH3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMk61WLy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMk61WLy"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450dd065828so20231825e9.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748882443; x=1749487243; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xjdBIdjzGvEiXX5cTK0jeCtz37ZAYW6SYcqWTlsYPZw=;
        b=mMk61WLySJXhfCktREiYt9VdRXNs4kDcY4/zNQB2F66jTXZ0Ms89GW4T9gtOAUdu4a
         nSafjhStwMgBwwKODHq1+q8M6hbYNjr1HBZf9+Pf5qxRIJlH5bA1asIk4QoEO9PMwg3c
         6ZI2qSGeht8PqsmjlWADtW9w1+9J+u8etXhQtk3lSUk5OJ83x/QC4qSO/BFpzblIpW1+
         wpWYb+LhpSE14l1Ueh4zxd+riWeE77WQ0gZiWNeB8yQtKKayx7Q0NF1koewgDPDFD9ry
         3h3Z6mmXBxCPBLcF9ao+dZEIvdKen7ZRPrl3WcTMansOIAFM19N9jaNcdgDPBVIzhy0e
         dlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748882443; x=1749487243;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjdBIdjzGvEiXX5cTK0jeCtz37ZAYW6SYcqWTlsYPZw=;
        b=EsLc+tXyFJqWX9d6ZXuZUuUbpeFre4+3Qvm9gF7EgyzGQVxWnRXgf40n0MU+h7ul3F
         FO4TSlLRrap9vsjMJ8WqEmdp/JkHuDASJVXi1EanVCfU99mOFOvubuBxY8lGmsLE+eeZ
         wiKTCAOyFi+7SfBtdgWicMsPhN1O96mBjXYO2+q2qP6RH1ACzd5FS/3uAOzBReKmMFAi
         qw1kPIFJaQR1eTyO9NfCQTNYh3dTMCgaXEKmqeskK2khBtW+OpmAQVFvQayuFgfjjbxb
         NVp5q+6QTDGvZ6hYpLUui7x0jsd9EcEYIloFspKQMrmarQ2bD8z4WCysZ9/v1rsgK3Uv
         zMcQ==
X-Gm-Message-State: AOJu0YyLoMF/HW95GJb6RXn0qgtZgxJBVNa74E1W85jLq0EP48l9yRbT
	c1LWPHGXBAyuo6RLRVZskfDiHsvFqbzP2mU0LX+WpnrFMIhw9Az+31Lz+HUB0Q==
X-Gm-Gg: ASbGncvKPzeDmMUQpfwwi/80vtMr3BvSVrDAQq9IYGqCCt16zEzWgAcn6eSZ0mZQNps
	OK013A0/BneGQyjRtoLzKUOKLMHWYGUYOyFdQyG6HporUWcQH36EyWZaQxBoAYtPs5kDDvxG4lf
	tEA+zh26rSCfbWTk27GJarGg/5alAkNkuQxXVkcQOBQl9Buhttukkgu9Z4jQdAdKUjrTBys3wJN
	+6y6YUbew0MtjsaS4rmvQQXz7VONFGodGBLRIV39HLWnu6Oo7R5MVJRdPqLyFU7hZdjUDR1nzVo
	K3NGMMWBKptmArSyy217QQdpbbq4yvZK1hfWcAqbYKqaFksT/xKR
X-Google-Smtp-Source: AGHT+IFAr7EVQXSpw9+UKR3or1RE8wS2UccIBsbpqV6Frf2rpJ78XUI0+hr4uSgu6AcGv0832KiFfw==
X-Received: by 2002:a05:600c:4f50:b0:43c:efed:732c with SMTP id 5b1f17b1804b1-450d8876ce6mr85248615e9.28.1748882443185;
        Mon, 02 Jun 2025 09:40:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa249esm133399595e9.13.2025.06.02.09.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 09:40:42 -0700 (PDT)
Message-Id: <pull.1928.git.1748882439.gitgitgadget@gmail.com>
From: "Patrik Weiskircher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Jun 2025 16:40:37 +0000
Subject: [PATCH 0/2] contrib/subtree: Add -S/-gpg-sign
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
Cc: apenwarr@gmail.com,
    Junio C Hamano <gitster@pobox.com>,
    Patrik Weiskircher <patrik@pspdfkit.com>

This patch adds support for the -S/--gpg-sign option to the git subtree
command.

Currently, git subtree creates squash and merge commits without applying GPG
signatures, even when commit signing is configured via commit.gpgSign. This
causes issues in repositories that require signed commits for policy
reasons.

The implementation ensures that -S/--gpg-sign behaves consistently with
other Git commands, passing the flag through to git commit-tree and git
merge where appropriate.

This change improves compatibility with workflows and repositories that
enforce signed commits.

Changes have been made to this patch according to a discussion with Junio C
Hamano gitster@pobox.com on my previous patch attempt.

Patrik Weiskircher (2):
  contrib/subtree: parse using --stuck-long
  contrib/subtree: add -S/--gpg-sign

 contrib/subtree/git-subtree.adoc   |  19 +++--
 contrib/subtree/git-subtree.sh     |  66 ++++++++---------
 contrib/subtree/t/t7900-subtree.sh | 113 +++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 40 deletions(-)


base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1928%2Fpweiskircher%2Fsubtree-sign-the-second-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1928/pweiskircher/subtree-sign-the-second-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1928
-- 
gitgitgadget

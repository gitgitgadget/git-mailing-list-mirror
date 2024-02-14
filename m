Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D5F125A2
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900412; cv=none; b=jkXMHjkfb3cWfhKuZidfk4bwjB6UeQU0g4YscnI++TlvMKHd2ROMOWJLg2EJSpb/nOXVGdwuzrQgglECx6CbX2+XJWEBEJvSpflWbcjFINuOWjKXUp4fLRtwH1hcO9AY7alzJj9goIcacjAn3GpKHbh84W2Dq9SUL419x9ef6Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900412; c=relaxed/simple;
	bh=hNB63pececRVmu1wzcWQDA4ficOYT031mzSsfpTVoU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8QMd1ddjFO7/NBBu8ZjfIDyaCWMM4SW9COveYNDKkCOyo97D28uUgOyR7kuxKFGg8ecZQ7YEBdZKYXoLWvIlxBaMkqmk40liWiU775xyKxkrJrDnGG5qBKjF+V2zBerbMKOPRUjqpVvJF4ElKNcKUc8Xd7DjZSIjuLQ2LosBGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4L4MRoO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4L4MRoO"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e09a890341so2425172b3a.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 00:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707900410; x=1708505210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YX7bWSgidCPmv/xngRtPxi+TfFp/0RBGqdmP63GnicM=;
        b=S4L4MRoOdlmqqsNjxzAH3EMyR6XR34Gb+m3H2Nvac/yvfokTe+e7GE87HBipfKBHSE
         E+nZ53dzxZ0T98zp0c6jcGInusBmLULestZlLWlIlv/kjWa9deeyBDBHmAgqnQZlLA2z
         iNnfvOxE9sGUPYN+GVmpWPdRfF+V/o1v7xFf6MrfBwcqdYfIWNjsa7F3tO1ZiMgG5QK6
         zNjygjt83xMVQiRJzoJXGz3SBHPT85boD9qJLYiPWY628tD6kvJV++oI5gO9S/6BBaBC
         XPuBMGFn5Ue+h3ny2VoWJca4DW9SiDL4mFpzkSPLi/G1IaTp2ztDbpNept/hwsfiLo8M
         KR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900410; x=1708505210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YX7bWSgidCPmv/xngRtPxi+TfFp/0RBGqdmP63GnicM=;
        b=h+U48ik5B9JjlQkjzPi1CiT6KGY5WbmHbXTXeT2Eq6r7NIpuuIkMCNFYEY4kaGF1fd
         UhfG4QC064UBcCjyxXbfBLNwRI6kFzU5znJREn/6RJj7ia09JUBNsHsXRJp+DHsA8ySZ
         ei80Igu+6FCXd85e38ud1XYiwF6OOJACiUhRIfLpnFoCIm8p7IolUDmmDrUtffG8Utlu
         sFkbpVQIWwEvRev18DMP5ZGS02uCSaPWMyKXHQUqk+FKgLYt5DOS9RSSf1QsEC2CBtiU
         E/OshiL6j2WHQ+7wR5of9BMNKWECe4udkrNgSTQuRMQuHMByZjTAtqzpREpBlk7MRrAS
         S2Bg==
X-Gm-Message-State: AOJu0YzoFm4N8gTzFCzPFlFsWjSfyXaEuY/Ky5NGovXLsBuFiE10pI6r
	ZHnONIBH/UaMy2oucEvdY4nTHSM+Xyim61mOd5xs2zGLr6Y/r5J7QKpQzfHa
X-Google-Smtp-Source: AGHT+IGSdsCdq5UAQEbSXKBYTShdePrKEyTGCHypK4CFmK92oue6H5Pgy+oIa08t3dokwgG9F+DzEQ==
X-Received: by 2002:a05:6a20:d39b:b0:19e:3659:c23a with SMTP id iq27-20020a056a20d39b00b0019e3659c23amr2149018pzb.43.1707900410164;
        Wed, 14 Feb 2024 00:46:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjyxW4uUfOWBTZTaGOAOzW6xI1caXluUKVZvRl4AVmpLZx5J0Q4iwIGMuptntNO4Lev0E7aCbn5Hrhu5/+mjyw/CmwMuK01XO/uNKSVJz4OqKfoQ==
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id mp13-20020a170902fd0d00b001db3bffd1a8sm2267733plb.42.2024.02.14.00.46.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2024 00:46:49 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 0/1] diff: mark param1 and param2 as placeholders
Date: Wed, 14 Feb 2024 16:46:40 +0800
Message-Id: <cover.1707900029.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <6e33b2b2-f0b1-46ba-bbd8-3ae4c87d35ba@free.fr>
References: <6e33b2b2-f0b1-46ba-bbd8-3ae4c87d35ba@free.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some l10n translators translated the parameters "files", "param1" and
"param2" in the following message:

    "synonym for --dirstat=files,param1,param2..."

Translating "param1" and "param2" is OK, but changing the parameter
"files" is wrong. The parameters that are not meant to be used verbatim
should be marked as placeholders, but the verbatim parameter not marked
as a placeholder should be left as is.

This change is a complement for commit 51e846e673 (doc: enforce
placeholders in documentation, 2023-12-25).

With the help of Jean-Noël,some parameter combinations in one
placeholder (e.g. "<param1,param2>...") are splited into seperate
placeholders.

# range-diff v1...v2

1:  c65bca7f6f ! 1:  3a82f72f33 diff: mark param1 and param2 as placeholders
    @@ Commit message
         This change is a complement for commit 51e846e673 (doc: enforce
         placeholders in documentation, 2023-12-25).
     
    +    With the help of Jean-Noël,some parameter combinations in one
    +    placeholder (e.g. "<param1,param2>...") are splited into seperate
    +    placeholders.
    +
    +    Helped-by: Jean-Noël Avila <jn.avila@free.fr>
         Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
     
      ## diff.c ##
     @@ diff.c: struct option *add_diff_options(const struct option *opts,
    + 		OPT_BITOP(0, "shortstat", &options->output_format,
    + 			  N_("output only the last line of --stat"),
    + 			  DIFF_FORMAT_SHORTSTAT, DIFF_FORMAT_NO_OUTPUT),
    +-		OPT_CALLBACK_F('X', "dirstat", options, N_("<param1,param2>..."),
    ++		OPT_CALLBACK_F('X', "dirstat", options, N_("<param1>,<param2>..."),
    + 			       N_("output the distribution of relative amount of changes for each sub-directory"),
    + 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
    + 			       diff_opt_dirstat),
    +@@ diff.c: struct option *add_diff_options(const struct option *opts,
    + 			       N_("synonym for --dirstat=cumulative"),
      			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
      			       diff_opt_dirstat),
    - 		OPT_CALLBACK_F(0, "dirstat-by-file", options, N_("<param1,param2>..."),
    +-		OPT_CALLBACK_F(0, "dirstat-by-file", options, N_("<param1,param2>..."),
     -			       N_("synonym for --dirstat=files,param1,param2..."),
    ++		OPT_CALLBACK_F(0, "dirstat-by-file", options, N_("<param1>,<param2>..."),
     +			       N_("synonym for --dirstat=files,<param1>,<param2>..."),
      			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
      			       diff_opt_dirstat),
---
Jiang Xin (1):
  diff: mark param1 and param2 as placeholders

 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.44.0.rc0


Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316A1DE4FB
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768051837; cv=none; b=aMYatodZFl5WlTEn+qnkqPFc352cv1g7lo32jXA4zb18d2NawVg5k9kM7l6v9+qHUaoI6jhHOApaQpL4r1EoXpNfv99qdGUBtssncnohQ+Opqf5ycU/q0zmYJihDM7PlKn6uVO6lKKFJbrpNq87Me608MTIygS7mvCl7OKWrRe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768051837; c=relaxed/simple;
	bh=Um74Pm0WMOyr9zGSOh+NDtZy3vR8thTJDpKR7KeqcMM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HKAHfnhWRKQ8BN+F9A36q8vgI3hlXAazMavAFWhgc8lfNAdYtEQFi9i/8VbwUM4lWOIrc9y43+OTm7gyTZdeZU9YgYe6d4xJtds/WM2tKoRk/66bloWVfKK4ZgkMRdaaRnwNqugaxM/YWV/27dJDVkv4BJP0HRHZQbPPK9R1j/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGCWVCaO; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGCWVCaO"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-459ac2f1dc2so3004208b6e.3
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 05:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768051834; x=1768656634; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyN5HxqC8/aOtdjFkNDmk+DH6gOXE+i6STyx1reNLqI=;
        b=FGCWVCaOwIYNwWewXGsz03fnhtNUC9BnbgjYhN3ieXyeUOrFDN2Gt4vNnh308JCrs9
         gcw2MogoA/N6iPpcoF32ZHvfsoyD56ntGiB1GnRTrm4AJ5g9jxQjAW3/cwd1qEISYMBR
         GVbM0+6WP/03CTdzMP+UBfA/f4XtJ7Ma2h0Tmhg+Gwlcca9GU+Djix000ShWMuyGhG55
         Izjq5+Ay8ObSjd/GsjDVYLlCC/yBaTLKAgQUKq4TJFmfr3BakTd3oeKUTHVIiFVGqLop
         j+g6KLNJXu55n8fWOGJtuDq/TArasuW/Z5jJJG4287ZqnoF2hkXI0YV96OU8QlWmyYSq
         CULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768051834; x=1768656634;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PyN5HxqC8/aOtdjFkNDmk+DH6gOXE+i6STyx1reNLqI=;
        b=Od/PZLU9jZWXzzEPaSexfG3B5/pGozh5lw7UH5MT0b5yJJRKtxyHbYWvuakHL3Wx7Q
         yMrGPmr3mpNgBSUJ5XiF3wfnbEKgHnVblXFmGU+Rd9jTOkcz83/3PpoMzmAITrtvsrB3
         bi3Mbzt4AU5Ad5q5QiANgx1aQnf27JTTt9j0QjMayWV+fL/RZyDsw64Po53b5z2JYC7w
         epuegsNkUbCpNLQMtC77f75kqO98Wjka6HCPPOIqb4KLzPJ7phfv90co+662AhO58M4Q
         xpx4V6WGXTssZaZeHgBvioDXxX66PNenyUGGVMMeVyhLkVSLceQegtTY6fhIiB3rVWzY
         s8Uw==
X-Gm-Message-State: AOJu0YwiivAxddCrl92AFMb84IS/uEkTkGdtZeglQU7lBx/P0wJkvYu6
	DL4JRpntDQONewF3mvlHaZjoQMSxjTpb9Nh2SDoVgOXYVFjojb9YRq2oyw50YKzJ
X-Gm-Gg: AY/fxX4UPmjKls1pq5Xn+4IBOtIYJstUj4Lq9rOqy7QTP+g6oTFOIOcLSgJq/kSDt0B
	S3rKFoaZ8yVwbYYxZfevI1GwzcmnrZ7DJgk76PBpT6v1f64CrCYPbEvF8aMZqVvUhW3Pt9AhmaV
	QhChcyV3ttWBtO/LCnwJjGbViuyin2VfN/xhIC7UsnmTvvVJaJSVnmDU+4CeeMkPc5a5tAMLO0G
	AlN+cggQLyRqIFA4iQVgRD5QtC2ph66JJauSFxPsqV/u6Kyol9x8QClhyFhmN+DQjfGIVid53tz
	S1vdtlJM3OzU4DL13BEji3cKM7wmY1CN0R19se69JYmTrSWTUIDJkmFg5xPy2lhrqs2/UjSr0Go
	dFmga27avGgjVynYPL/f/Q/vo5h+28iw7ZtH9u/EUT0miVKrwkHlnA+v4+FXgC2E1uk6lLnUwC6
	11Kw2dBIb9ctT+KQ==
X-Google-Smtp-Source: AGHT+IHsiw5s7QhGSSQu4RIvbl5MJUqutqSlkonm8XjpBZ1WQmmJ3RHiQ9FhO3ehqBw54+bxkAwhEw==
X-Received: by 2002:a05:6808:c1f9:b0:45a:8d04:5744 with SMTP id 5614622812f47-45a8d047d4cmr3157345b6e.58.1768051834461;
        Sat, 10 Jan 2026 05:30:34 -0800 (PST)
Received: from [127.0.0.1] ([132.196.82.130])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2b2b20sm6145368b6e.18.2026.01.10.05.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 05:30:33 -0800 (PST)
Message-Id: <pull.2138.v20.git.git.1768051831.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v19.git.git.1767984037.gitgitgadget@gmail.com>
References: <pull.2138.v19.git.git.1767984037.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 13:30:29 +0000
Subject: [PATCH v20 0/2] status: show comparison with push remote tracking branch
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
cc: Nico Williams nico@cryptonector.com cc: Patrick Steinhardt ps@pks.im

Harald Nordgren (2):
  refactor format_branch_comparison in preparation
  status: show comparison with push remote tracking branch

 remote.c                 | 183 ++++++++++++++++++++-------
 t/t6040-tracking-info.sh | 262 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 403 insertions(+), 42 deletions(-)


base-commit: d529f3a197364881746f558e5652f0236131eb86
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v20
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v20
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v19:

 1:  451d7a4986 ! 1:  bb3e00863b refactor format_branch_comparison in preparation
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       		if (advice_enabled(ADVICE_STATUS_HINTS))
       			strbuf_addstr(sb,
       				_("  (use \"git pull\" to update your local branch)\n"));
     -@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     - 			       "and have %d and %d different commits each, "
     - 			       "respectively.\n",
     - 			   ours + theirs),
     + 	} else {
     + 		strbuf_addf(sb,
     +-			Q_("Your branch and '%s' have diverged,\n"
     +-			       "and have %d and %d different commit each, "
     +-			       "respectively.\n",
     +-			   "Your branch and '%s' have diverged,\n"
     +-			       "and have %d and %d different commits each, "
     +-			       "respectively.\n",
     +-			   ours + theirs),
      -			base, ours, theirs);
     ++			"Your branch and '%s' have diverged,\n"
     ++			       "and have %d and %d different commits each, respectively.\n",
      +			branch_name, ours, theirs);
       		if (show_divergence_advice &&
       		    advice_enabled(ADVICE_STATUS_HINTS))
 2:  dc8ab23158 ! 2:  050197eac3 status: show comparison with push remote tracking branch
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       				_("  (use \"git pull\" to update your local branch)\n"));
       	} else {
      @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
     - 			       "respectively.\n",
     - 			   ours + theirs),
     + 			"Your branch and '%s' have diverged,\n"
     + 			       "and have %d and %d different commits each, respectively.\n",
       			branch_name, ours, theirs);
      -		if (show_divergence_advice &&
      -		    advice_enabled(ADVICE_STATUS_HINTS))

-- 
gitgitgadget

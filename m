Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAF254AEC
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605854; cv=none; b=pgMORzWmoR5aA7ul8po3jSHm0SNYr6/QTVLXgwYnUw4bjbJMU3Kyv8lMXHXDaIU3UqAdVmlwf+imsFMSQofx8uC0/D09OJQYF4EuYIAQzyQebJnr4Khn4r7i1MrPe3+aE+wR8aSxkgrDMkF0/qnuavFXT7T6pKAaHXgDlc4220w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605854; c=relaxed/simple;
	bh=tQDW72V5Lk9vQiMxekNox5DarvPf9XlwYx8oXgTctkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbsLk5PaRfEAaGdulWkDwpcKEpi04V6//OgcXwDnWq4SJQ7o0RRyNXnUMH3Hji59N3IhLfUVHK44FIDEZEEuXl1aGtP3PNVKdl29Q3ikONIUXnwzI5g9w5mJ4YwyHNT3hiYDwlyZwMJthV98dBDnQCW/JaxBMW4/g9iE43dHY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7aobaL3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7aobaL3"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74b56b1d301so3471554b3a.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752605853; x=1753210653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzK/DdMASZVBG0IkZa8Bn4jLx/mWuLkqK+IPZmsqisk=;
        b=c7aobaL39AOzqXyjHbTgwXQJzu1U/liMJnWoR5b/lhhIJRbolD37UMvWgDKAu26cjz
         XnPGH/k/7iEs+gET7uF7j9uSgCThEAxk3xY50sy5JA1/AkxXOIQZ0v9mLv4G9LbmX5SD
         69qgltsxfnAgoe+9h1ClfdZuHXPZHyPBDkDUlZWi/2QA6dlU+zxxpS7yjfnhtXvqEwWl
         KzLz7fssIURtq3gEyGpEx8ql4ws+pkRE9z4Lc7pVnz1/XiN6ldiY/gr0ZeRb7MqA7pq9
         /KtlAyn4KrWDlV8KsEtVSFfXa0cq1NFr+xarCoYTRFPj02sX5OtJAbLEc+2BDtzaxBcA
         XH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752605853; x=1753210653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzK/DdMASZVBG0IkZa8Bn4jLx/mWuLkqK+IPZmsqisk=;
        b=MkZwEbtvhWzmBi0+ADEMKa9oWersMke/hgj96M4x5nDpMUJfJpGMSuKojdWg5vEyhv
         eCvt8/OO6Lvb906WdCwHoVr9w3IZW6ieUHWIPyzpwY+QMkTE2/9DEj0I871QD3aAyDPX
         +ID9pgP+Vj98PEddx+SuigzJqwoYjWYpnocU+W9osoKZkkrBcQiKAD4mg9raHS/bA2db
         lCD09k2y8ZmNoli5fz9Ir5wUBZITh06uklBzg4X5pDtGV/WARg+RfAR+22KlHfmE07Ha
         b16pJQcSKumDrpxcljRPzHN2hBd1x053mmD9Kfr7+BnlYmAIswkQXS3EiRMpc5FqOu8t
         Ab2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgA/oMSXA2ChXqOxf/H0yWsBOSa3f9lBBI/cU9Ar6z2E9xfZTZdFOAtuAu+BoMrR/GyBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIjeTuhBeD+ZLyOqPoV7XR8qxlGKfg7dGpJYqH3etbAxIyNsGp
	WVgAfp+4E4DdIiALZlizGm6dRCFc2iynekdPolfU4N9kw28HHN5+F7KJpkiTRAu2
X-Gm-Gg: ASbGnctT0lve7WMsdoqGzTrk0r9enBqdbyPIKORMRtcHszMgDbphL3ogjrD/uBsPsIq
	6z8AHudY26XQBjyeheYlBcd/xUMdcl37ZqdxzWyis2d06V+FRxBVrIDI9xfz6wnNBViwDFnZsxU
	mv/wvcWPBct+NjZmrjOENyZUfsOuPlOtoehnhiBBv6FEsp3vdbstqBlW4BiT/CDoqIer3meyvAe
	WiyTpnJN2xltkY3fPFzO46itMsYASmfmAHdUnWElXqbnTOQr2qED2LYBQ8Y1Vneyo0fidWX2548
	rsHGu7Yb91spbNYO7e1yxjl8B5pGPw8Q5ZTDSIDmHzQEvV+c+jJh2h+VH8gp/qV5rIX/sn9kmuz
	6gtZTnk5MBagBLTN99f0hL+09Zb9SVdz8hH0=
X-Google-Smtp-Source: AGHT+IEmcywcw/Xko0eR1SDxnFvkTtneXr6KhhLWLhV2jK7fjc6a48FpN1Um62dd8fnQCastx1t+pg==
X-Received: by 2002:a05:6a21:648d:b0:21f:ee3f:8ad5 with SMTP id adf61e73a8af0-237d7235caemr623534637.20.1752605852537;
        Tue, 15 Jul 2025 11:57:32 -0700 (PDT)
Received: from thinku.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4aabdsm12317126b3a.124.2025.07.15.11.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:57:32 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	phillip.wood123@gmail.com,
	shyamthakkar001@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH v4 0/2] commit: improve behaviour of core.commentChar=auto for comments in commit messages
Date: Wed, 16 Jul 2025 00:26:59 +0530
Message-ID: <cover.1752602474.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626132233.414789-1-ayu.chandekar@gmail.com>
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20250715185659.xEMLxp_sN02paBR_i5nJpUUFnywjwPpfnws11giyxO0@z>

**Please ignore the patch series sent before this, accidentally missed out on mentioning the verison 'v4' in the subject.**

Hey everyone,

The aim of this patch series is to improve the behaviour of core.commentChar=auto by the following patches:
1/2 - Fix a bug which reads comment character of the comments in commit message leading to change in the value of `comment_line_str` and thus resulting the comments in the final commit message.
2/2 - Standardizes the behaviour of code by resetting the 'comment_line_str' to "#" when 'core.commentChar' is set to "auto". 

Thanks to Junio, Phillip and Kristoffer for reviewing the patches and also Christian for the reviews and mentoring me.

Ayush Chandekar (2):
  commit: avoid scanning trailing comments when 'core.commentChar' is
    "auto"
  config: set comment_line_str to "#" when core.commentChar=auto

 builtin/commit.c           |  6 +++++-
 config.c                   |  6 ++++--
 t/t3418-rebase-continue.sh | 13 +++++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.49.0


Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164B635963
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909790; cv=none; b=cco8PGgo/PUTDuubH+qENXUZJ0ibrNUPaGkqKyk8w8v/i8uJXvzv8xuz36moRhCuBVDiT0RVNwDopJa+sEM72gxyoNFA7hCWWXAj0b3enn8pd6XEurfBYBEmYKlQPP2cZRs+F4+1ZCVOR7C9jsJ4y7a2WhGg19ULQFOT3X2Cx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909790; c=relaxed/simple;
	bh=bLmeyXSHKM8Az49Ee1PjpFuNowdoVfPlCgQV1L1F/6U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eEQqIbo/QLYHJL8EK479Ki0OPdUtAD87fWwOd4RHrUPjUX0Le3qcdhgUDktNLXpgLNcsSx7wQ6bJznthm5QL7p7vEyiPFhW2VQn9S/iOyEzDKjY3Pkz3f9QHaGlWwBOAyWc5TYW/rPw61LVSV9t+2S4aL0ZwU0WNgBCj21ngku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFBFY3p4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFBFY3p4"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e415a68fso2248771f8f.2
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 17:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755909787; x=1756514587; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRG1tCa/IrI9Mc4Lghqvcla/Of5GXD5DMJ1yUWYoUvw=;
        b=lFBFY3p4J/0DQovvNVS2KdmmrL9oS8BDwg8d0w0re35jUby3ixZyPrGA4GCDmrXJ7K
         SOIgux5jNEKlp3+ktwmWGMm/zaNihfpo+2tebnxppi39+ynGkGgb/cO5z7Kgm9AMHv7r
         HWFZSACLkc85PQp5KBEPYEMVgVsVrEr/7WzNXoOc6ZDj1YJOIhLREQUZwGILbeKyU1Mi
         /L5Wjeldhpzwxquaq7AEm3gL73oUqmlSAxo+HrAKyZzluOZDhsYIk//feCVHF1/aS38y
         58m+xpKEUkgqMnlp2tIKempS1tCIvv8FA2YVs4ngoTr9yyAWfXooMp4sacr1KU5k+KcW
         Eg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909787; x=1756514587;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRG1tCa/IrI9Mc4Lghqvcla/Of5GXD5DMJ1yUWYoUvw=;
        b=uVkcOKJxfFuQySicE+hfaE9Y6TQyZI1BpmxlYH7nAZW0X67BMF7DQUGzeUAQ1J0zm1
         SNT5JgbV4fckUOZQLKr4kMSzKZguOwofmG+a4gR4hr4yUNmrNDUJ9XE/TswNS0LFJ6Yj
         1z5BTmX3HMM72EHIfWebFRzvvyV2AJRLt+oGIkUnRJWQM++5UGg+BA78nspBVf6ze0ZT
         ufn6a/6UQk9iM8CgNXPd2vzyA28A4tspHErgzOBP5ON32ZpIiEukpaKJvP86DuYsUbNv
         bRMDP3pIc7uyqeU7aaNhOk4RX4VwkWOXRmYGWueqQWCvgVxYYdm4LIHamoQq4l3vJVke
         ehig==
X-Gm-Message-State: AOJu0YwX3zmdzMzO3EKmOcvA504sgCVzETQje0vz0Ix/AIhXpMcXW2hc
	Z+AP4MOcto0paZFWw97tc/IswWuMY28W9356ER8GHqaLo21ktoPyYlxD9IkTnw==
X-Gm-Gg: ASbGncsGMsVwHHBUGsIQh/zJ/QqKz/UGhRe8ZgymAtQEDlsEUUsHBFDpNZ6wNzhObzV
	HJJuIesOlCthV+EytrWJ0a/TCS63TMQXaeOK+Xym4qD2W5xAL2Q6ZFddteEIWwu1u7CB0EnP+Oy
	QzVto1b9yvWXha9EJjKTwGhr9AlC+WIxJxNPbvhKg7FULY5IC6JEg/h5hskbORTDBf1L/rWstg1
	71ZWOvlQcUsNq7+ErkLCQ/LicW22g7TflrkKy3nZm8gQ13Hoa2QRPfTdbkR5jtgGxtDFaNNdN9o
	Ib4K86aZ/1jMVQjCOSjxuaMqZwrL32DnqGJuM3WXiG1tkhGblZ6H2XBkb+AIhqiuRuLKoUBjtLQ
	Mi+nJzBa0xYVfgHURjNOTR89pDd4=
X-Google-Smtp-Source: AGHT+IE7wZKRXHz8W62H1R3Trk56HP/yChsVXCET/+sh7c3njc++IFbmHA1VqhGfEKbAxUEmnVfW2Q==
X-Received: by 2002:a05:6000:2c12:b0:3b7:9929:871c with SMTP id ffacd0b85a97d-3c5dc5408c9mr3517278f8f.37.1755909786999;
        Fri, 22 Aug 2025 17:43:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5753adf7sm15559335e9.7.2025.08.22.17.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 17:43:06 -0700 (PDT)
Message-Id: <f42c2c794a96c9a2dcb34bd7fe7b202466b3ffe0.1755909782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v9.git.1755909782.gitgitgadget@gmail.com>
References: <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
	<pull.1949.v9.git.1755909782.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 00:43:00 +0000
Subject: [PATCH v9 3/5] doc: git rebase: clarify arguments syntax
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove duplicate explanation of `git rebase <upstream> <branch>` which
is already explained above.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index e82ceb9cbfce..6d02648a9b3c 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -62,11 +62,7 @@ one of these things:
 
    git rebase --skip
 
-If `<branch>` is specified, `git rebase` will perform an automatic
-`git switch <branch>` before doing anything else.  Otherwise
-it remains on the current branch.
-
-If `<upstream>` is not specified, the upstream configured in
+If you don't specify an `<upstream>` to rebase onto, the upstream configured in
 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
-- 
gitgitgadget


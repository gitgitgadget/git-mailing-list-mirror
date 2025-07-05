Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3DB19CC27
	for <git@vger.kernel.org>; Sat,  5 Jul 2025 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751699773; cv=none; b=RAp+cQvPfi1TScRkc7mwzIpKjf2wrWRBJVVmQFBM7j2OClhoWulz7HmIQSQ0nKgaDrv96qEVbV6RgaUCmLIg7n+jfcW99p2aFeOlc9KMFc/4y+0vS7x6+x2DskyAL0Payq7NBPvPwLZP7zkdjyE3I/2w1xGy5DtQI+Mu1vUQih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751699773; c=relaxed/simple;
	bh=yzECm/EP1GGphFF0rpOyyddk//EdcXPhmdkGsn35Tk4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MdnihdIj7aSuDH9uHZ1SWMzBCqe8GnouH/c7A6NIRDszKNo/8Xtcs7grl+OdkwK74Qm2VpkswCnZjmRywEF5Iwv+BDFQn7tLT0FuC2g9tzAwKPhRpdQcRl0jfRPxuSL9qcBeXUvlfobYV1jcF+vl05hS51fNIkgZspR+7x2in0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4C1QbZR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4C1QbZR"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso1168075a91.1
        for <git@vger.kernel.org>; Sat, 05 Jul 2025 00:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751699770; x=1752304570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yzECm/EP1GGphFF0rpOyyddk//EdcXPhmdkGsn35Tk4=;
        b=e4C1QbZR+90NqBcL3RtwT6CGm2NkDwOq1Hf/7tYye6MhddNUrgE5lviWQ9GRNHs1sh
         ODoQSIi7EXoslFp1TXEpWjAyuTwdwVWF7vTDMYsmDPZkavcAOUAchdj5V0AcKAP/Lj3f
         ymBJyjnPfpjkvxBaSHfOFulmBUzFzcemWUiFa/ZEj8brUCHeXSwFPDRK5zOS/33H5WVv
         u62J/5ubqjrKb+SADHzB5ShdBCVNGG61Enex8RbseapjiXZhpOSnPYhBhFNZOQRr/PBZ
         0xTokLEyc9HV3vtYR24xG4afEqX0SQ2CWKQFn8ByRjxxkmJi/m6HWGbdF3xmsxBxkFsW
         3bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751699770; x=1752304570;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzECm/EP1GGphFF0rpOyyddk//EdcXPhmdkGsn35Tk4=;
        b=GXa6UVNSh57Me9We1+Xtbu/mZW6ulaUlUo5hmqe0oWI0MvDD7/amTaalE1GyGXHwJ0
         ER2bEBryoI1JIIBa27A+mvG91ekHY6/dutQUCNoTNZr/y0RsHuwgwS9Q5nyZnX228woG
         K/imthxoybTRtiVZbrsrQMSK6vJsERAyb3CCbBgozx28K1SsQjV9LIW8OErmX00wiGMh
         KNKNGedJpRPytMbbZOwcPyW9/kqfhcHzsSAP9PdZaValwF2dE6X/I1roMYA2z2wWn87G
         HX/TQfwrzjf1eH9m5slCVeSIOTE/f2axnrh4JD1rad/vWf2C6Th5NbwMZ/mW3jVwiSpm
         n7WQ==
X-Gm-Message-State: AOJu0Yw/d8sayp3nVGNbNQHTWry2Yi0g8wosX8HXHfN+qglFXwLiasbN
	b3jNRSb+jziInzw5eJEmgPjSKT7al8hJjR06qLFHrcRlc59MEphMRuK5kMz/j4a6kjVJV+Dwi09
	wSQBbfToJTt44wAQXrV6XZwYcp69pWM9pT1Fzkv4=
X-Gm-Gg: ASbGncsKiU5y9Fo/HsWZKax2F+TpRsd7xQAyTa7uhhUAxOg5jT2Yj7udE06tMd1pA0I
	mzrWZVvxm4S/E4y0XU5VbJgxqL8xh8/QlJJ2xJjU5QGAIZ6ba2YbX0WGRjITOo0zNcIy1MvptKq
	bhiRP5Mw0FQQXJUz4B5UOsIn2gAxenGZ+wTQeEHm/wnzEBBdyhVcJDqVwcQJsWWfLbqcFKkg9Yv
	SCdPw==
X-Google-Smtp-Source: AGHT+IFbcH/qEQdDRK256If9/Rwj/sfKOz44CGO1iyrAKETTNgFUzBWq1814To/46PybZ94JkGeP5wfvw4vuA9V8aLY=
X-Received: by 2002:a17:90b:584e:b0:312:db8:dbdd with SMTP id
 98e67ed59e1d1-31aadd9ffccmr7048405a91.28.1751699770312; Sat, 05 Jul 2025
 00:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sat, 5 Jul 2025 12:45:59 +0530
X-Gm-Features: Ac12FXxv2ttsazJ-ckKnuae3zEXhpCvWt1EHFo_e0Xja3f_Ha9uj35bNR2qPCN0
Message-ID: <CAE7as+YXwesgk2tna4kEC34EbQ=-eA+thQBqU3qnveDh9rbt8g@mail.gmail.com>
Subject: [GSOC RFC] commit: commentChar=auto bug-fix suggestion
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	karthik nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hey everyone,

This rfc is related to the patch for bug-fix [1] I sent recently.
In few words: When core.commentChar is set to "auto", Git scans the
commit message to pick a comment character that isn't present. If old
conflict comments remain, Git mistakenly reads the comment character
in conflict comments as a part of the commit message and chooses
another, causing the conflict lines to be included in the commit
message. Skipping the trailing comment block during the scan allows
Git to reuse the original character, keeping the final commit message
clean.

So after doing this, Phillip and Junio informed me about another bug
which comes across [2]: If conflict comments already use a character
that isn't "#" (e.g., "% Conflicts:") and core.commentChar=auto is
set, Git will ignore these lines during the scan using
ignored_log_message_bytes()(which uses the comment character used in
the conflict message) and then pick a new comment character based on
the rest of the message. The newly chosen character is different from
the one used in the conflict comments, those lines get no longer
treated as comments and end up in the final commit message.

To make this behavior consistent, as Phillip suggested, we can set
comment_line_str to "#" when core.commentChar=auto. So that even if it
breaks, it breaks consistently.

An alternative approach I thought of is to return early from the
'adjust_comment_line_char()' when ignored_log_message_bytes() finds
conflict markers. This would skip the comment charater detection which
ends up keeping the same comment character as the one in conflict
comments. This fixes the issue, but we end up ignoring the
core.commentchar=auto when we detect conflict comments.

You can check the attempts on my branches [3] & [4].
I'd appreciate thoughts on which approach makes more sense.
Thanks!


[1]: https://lore.kernel.org/git/20250626132233.414789-1-ayu.chandekar@gmail.com/
[2]: https://lore.kernel.org/git/f39a3285-574a-45c6-9646-04eb175f4770@gmail.com/
[3]: https://github.com/ayu-ch/git/commits/fix-rebase-commit-9
[4]: https://github.com/ayu-ch/git/commits/fix-rebase-commit-8

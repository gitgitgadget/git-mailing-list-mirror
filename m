Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415113DBA0
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762628763; cv=none; b=i9OcoclRgoPTDQuw+zqCur6Y8RiizTDAtiaz06SldOolevEowAT13tpHvbmPY7fAgLzdFCXk+YyErv+rNRMxUlyCIZpvQm+vQnI+TURFfuNXvno6DaIv5BZY7SxuTdXS+HhpDsf1XfCU6AUNhQHOb/QlI+qGznFV/zCdj3cQNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762628763; c=relaxed/simple;
	bh=4D8J3HdfTQ+8Tr5DHdLLHPnwAsETCgY5ZBIg1v4DkAo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dA8Zs2QnMESNJ0uYgkgu36bBQiuO5VF0CQ1y+ya3O0O5jX9I9l4nf4tKgWArfepH3AfNQIOHWDklrCRBE6VL9oyG+JdTZP5+5uh+O05RF3flrCyWBb8Bn76qWJRocI1bQq30FPRSxtSASwRghmZJGDStm3ML9qbSkMoMdR1PBTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuR+hma7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuR+hma7"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aad4823079so1586322b3a.0
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 11:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762628759; x=1763233559; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P0FDcwKPeV948TuQeSpvyDsi5TEoTjZf3E8qa5r6ozY=;
        b=KuR+hma7T2eyJyganJ3B8EmuqueuHXdIFvTB5h2wropz27K2cq9djJw4aCW821dOvS
         bm6K0WdRZdQo2FAiE4wxP6811rtjP2HbbXTx24HDocYEyorg3deO48mPh95jCClpz1Oj
         0igsrd9tQ58Bxc0JspB96WlJJYkV5Xpufw94WH82ffG5O0Ry3j+KpGaQdk8yISfKyNdv
         9xn0kZaxAEBHaRcW/D3GB+i/jPxOfXskoAph4ZkRWCMxDlUhESj+yYaTnmvi5YS+Uy1I
         SmNR7fisQbEL9s4+7J7M9DET0d6NVScMhcT4uiwjxMpGQh0WjtlPuTHp1+Ju0KgIg1Im
         kzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762628759; x=1763233559;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0FDcwKPeV948TuQeSpvyDsi5TEoTjZf3E8qa5r6ozY=;
        b=X2O0x++vJ3rwOWtfu+DnyLegC1A5TNIJxXnK7X5HwXoRYzcSSZoOZ/JWbwQNuV+oSF
         c4B6z/S/I3rKEvZQSjLTu0RWLwWALooUX/DWZO1V6eOnLWJdD7PWVq7kivZxJqzs6NLq
         IlVIfS9/P/YGjfVnzSmRit+avOyj8TgU4GSLOFNsqIRgwXRgoPZy/ehsZ2b9sCop8oQN
         +4WFw0x6Sx74rkTnRUwkN3PF3qRSNOtdMmyiYv3vo4yhAXxU6hsHCqWTsA1ydIbe475C
         UOHjzM1M/kDt0yJN/n//Hble9TQGpCjc9O29gTuQm2WdltK485On4CE0c+yv36epvZl+
         Tjzg==
X-Gm-Message-State: AOJu0YzxXVZFZHms5kUXHlz1rwXSYO/QQJ/5vLzZ60K/0Ty3AlRFZtQt
	VwDAt/n4J6voR6TQm6uI7RWSa4ulUtm27U4izRg9rS5g37ShwdnVorOlzGHbawX22yg7QVxgZTz
	U0RTvkwyM7U/7EAfKBHYdis+DCQQaiM1rNmmr
X-Gm-Gg: ASbGncv0Pw6Sv7nzQh09702cuBwCAEcBhyrGHGLQkRkxqvzWiHvle1N7KoZF7m7EL01
	VDyiHOZoK2fEBcChyeCqBWJn9VoECc3DzvDlO7P1usssYNyE+pQtZcjAt7SK2kyuTtIlsoxBJyG
	yqQjR38NeBsPjxs8dEyfd3DyKMV1ZX+lxpDapJjL0ExadDXeeDYkaORTnoKAlpQHM36JCA29RJd
	RIXLqq5QYHYPh2/GL6HsH+pHL16OtcXtfkibjeRDdpVHk7E1tdIEP58y1YdcR+RTPxOHdeL
X-Google-Smtp-Source: AGHT+IFufj+vkNWUO2haTweszV2EFzi8VK3gMXbmZdy+BqjrOCsHCrb96fbUzxwwz8p+5SVvRiAgwU0i+4vN81/In/4=
X-Received: by 2002:a17:90b:2fcd:b0:32e:64ca:e84e with SMTP id
 98e67ed59e1d1-3436cb227c9mr3812704a91.15.1762628758617; Sat, 08 Nov 2025
 11:05:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 8 Nov 2025 14:05:47 -0500
X-Gm-Features: AWmQ_bmoLD1lyt_6FyxLPhIWHwcmfW2M38-p7gHxyQDrH7630GSFti00SjgbtXk
Message-ID: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
Subject: diff --cached --no-ext-diff --find-copies-harder --quiet exits with
 wrong status code
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

AFAICT, you need all of the mentioned options to trigger the bug.
Allowing ext-diff works fine, I don't think it's triggered in
non-cached diffs, and I've never seen it without --find-copies-harder.
Notably, s/quiet/exit-code works just fine.

Here's a repro from git.git:

    cp git{,1}.c
    git add git1.c
    git diff --cached --no-ext-diff --quiet --find-copies-harder &&
echo 'this should exit 1!'

(And of course, ^quiet^exit-code if your shell supports it yields a
different outcome)

Context: my distro applies a patch that allows
diff.renames=copies-harder. In a repo with that turned on,
git-prompt.sh stopped showing some staged changes.  Turns out it runs
git diff with all these flags (less --find-copies-harder, which is
enabled by the config option). I _have_ confirmed this bug exists in
unpatched Git, however.

Some rough debugging notes: when entering diffcore_std (or
diffcore_rename_extended's cleanup loop):
- for exit-code, diff_queued_diff.nr matches "git ls-files :/ | wc -l"
- for quiet, it's just 1 (the first file listed by git ls-files :/, AFAICT)
The only other obvious difference I spotted is that the "quick" flag
is turned on for quiet, which makes sense.

I tried to figure out who builds the queue, and it looks like it's
diff_cache -> unpack_trees -> ..., where at some point for exit-code
we _keep_ queuing files, but for quiet we don't.

I also saw diff_cache tweaks opts.diff_index_cached based on
--find-copies-harder, but I haven't looked further to see how that
affects things or what the interaction with ext-diff is.

Help welcome, thanks.

-- 
D. Ben Knoble

Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F65849C
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736079151; cv=none; b=Ou3yFk6ZpMNttQ4g92+EO0ziLbX70Z4jLC/9pHgr5KajyT7f2tqkepJmr0EEz+iwD1skX9VEaK6tXpEPHoGcnmUqUL8+fs0m788G9dKjp5qorHuO7SPUUgbPEV2i+gz9OOgnHql27SQ1iamaSGpZ07HJxIkVBHtL0Pf5H1YBjfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736079151; c=relaxed/simple;
	bh=m852lghkSkAUjpctC1wt29znzuGu/kgD2/hU/rHUxrM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=i4Q7O7eKVaO9uSSNJx1TkGg5HsOzu4hfAdQTPmeijRgpxK3u04RLVpi2xZW3uKkGLZSs9oIb/rhtAP0XckQVCPxgcBvloXuQWWpoUd+nNhmTrLFyCorb4byWQyMm3nMliqb3cHi9HUU2ZkEWLh82n8BMv1BJU8OzjfeNRx7hHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3lT4cC7; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3lT4cC7"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30227ccf803so155770781fa.2
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 04:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736079147; x=1736683947; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m852lghkSkAUjpctC1wt29znzuGu/kgD2/hU/rHUxrM=;
        b=J3lT4cC7X109ep9eJ6Yrg2aUjx8CD6ZIgxDiEx8iPMa/sZxEKBoyE6b5Rsm5kLqtAp
         QjnJc4/ORKmHnhkHX3jpJ4zdec2CWsbCHymgRMDUL0MS9TmJqIKBAXPKHZFKsNQhMT/0
         B6lFIIpC3/01SKlkciU8VR54HeoEXr/MhaWwOgKE9AhI5ALGBiE0rVX8H0Js6b2s/g//
         Dvxms6fcMyhDgKwIWKwLIkTP3KSpguFttdghnYs0Pjkg5Aa86savS+UrQN1hlY/A4mBJ
         cxk4BByoEnI5WqW1ejtxElevWGy9V0KmK3MoSeiXqQiQKxgrtBpuWhzRU8V9kojJf60N
         EBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736079147; x=1736683947;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m852lghkSkAUjpctC1wt29znzuGu/kgD2/hU/rHUxrM=;
        b=Z7/siyP6YKv9zPzI97YMQIlN5dfnIEgD6zi0y9pLEUneSTsfBuGCBpS1RVzfMXZtt5
         g3+hjuMy1MNnZ7rOYx4ZnRLtGmSSecG1sMTi/Cr/Vt0DEq43iofq5ZPx8CAugi1KaeHo
         1XcjGb4GLHPw6I3F6nJEtKo8kC4W8Tbb039QDCf5Nf5IlLZa1TwSAUeDLP+fNhyetDcb
         hipL2ip6sWssCMlEQgPmQaqTMhBKM0OMa5GH9sQSX+x99gFl6p0UvJIkr4eDE9tPO5gV
         2gYni0SIK3XlNO8SUJoiRbzquV37J7xHzmc6qQvqqqMvjRQRTNHJ+1iRofx6sU1F+yiE
         YK7A==
X-Gm-Message-State: AOJu0YzZl93N8i9KbuA8VZKJQfp6jreNc+2ShQU3YWMa/ZMStZmxrDug
	gv3ydlFaTPJHpYqkDoix2AQRKiHpnxfkPqr64SfEKjV41CLgfliFawhsFiLtW5PidjLKFNeL7KV
	XA/BDfzF0JN7dcrg+Hb4ARJwcHnOCiky/
X-Gm-Gg: ASbGncusSXh+hBelEBqMcrwLPwmaJUbILhupCgBw+JMob37q3yv2XDV2oXwjaE4EKTw
	1lBDMQtFI58enr4v0Wvfk5Fxkwtv9xiPHGT3T
X-Google-Smtp-Source: AGHT+IH6hqFu7xcAx3Vpg/r4eXWeOKyVSGug38vkddAbBEGZghcca+7b268NMvzq7DmMNpTzL3uCX/zauV/Xk0hyNfo=
X-Received: by 2002:a05:651c:508:b0:303:4589:d700 with SMTP id
 38308e7fff4ca-30468517a24mr158015901fa.5.1736079146252; Sun, 05 Jan 2025
 04:12:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ross Goldberg <ross.goldberg@gmail.com>
Date: Sun, 5 Jan 2025 07:12:14 -0500
X-Gm-Features: AbW1kvZpB0-lBSTxp1S_2VIJo_tPX5Iv4zh-TGJ8rkzgo6YMxTi_4aXuZM3NOy0
Message-ID: <CAAEcvMp8obN4b-zpG4wUtt7-O17j4mEMSHLbu0wZ0XWUKKn6Tw@mail.gmail.com>
Subject: Add --untracked-is-dirty option to git describe
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Could you possibly add an option like --untracked-is-dirty to git
describe? (the name can obviously be changed to whatever you think is
best)

From what I gather, git describe --dirty[=<mark>] applies to deleted &
modified tracked files, regardless if the change is staged or not, but
only to new files if they are staged. If an untracked file that is not
ignored by git exists in the repo, it doesn't seem to trigger
--dirty[=<mark>]. Please let me know if my understanding is incorrect.

My proposed --untracked-is-dirty option would make untracked files
that aren't ignored by git trigger --dirty[=<mark>]. It would only be
valid if --dirty[=<mark>] has been specified. If you don't want to add
in a whole new option, you could have an alternate syntax for dirty
that activates this proposed behavior, maybe --dirty:[<mark>] (the =
has been replaced by a : to activate considering untracked non-ignored
files as dirty)

Are there any other categories of file statuses that someone might
want to be considered dirty? If so, then any solution should take them
into account, too.

Thanks.

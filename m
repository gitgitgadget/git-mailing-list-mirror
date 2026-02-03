Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB32264AD
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142735; cv=none; b=hD4rWxSwbzB0euMiwX6/rlqZ/Xf+D2r0MBFVJmT4jSu99DCDnptoYBC5ijHZfwfkbQtILyEGMfnc2fEwFwCBqTOjtU1M3RiGjOE02eRvfXO7ydD+dFxNprZ8n3x9jjM9yQ3JUfPxassMTeH1Y8d0OW3q4uunmN689MBB1qXC07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142735; c=relaxed/simple;
	bh=H2OJyckKVm20X+OA6cS6CCbUI2Jv19fRPHo0REqDGYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MB2bAtl/uWZcs3FIEozeQfbpgKcqJgg5EHQDrlrRWAQZ6h7mZYgM0YTUaKkC9n3q/ahuCwcfH5wZh383+OVnfOaR6vBVb5NQTJ34CBw0xK0B7ajGquA87kXHxTOE/XWZtbGt9nZoz2zRafAVWDPHqD5JLDokQaW6ZBtbJZkZY0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3ilKVZg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3ilKVZg"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f47610542so3376734b3a.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 10:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770142733; x=1770747533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2OJyckKVm20X+OA6cS6CCbUI2Jv19fRPHo0REqDGYo=;
        b=g3ilKVZgmROOUfZQpSvQ+XziLR2OVEJYrBFNptooIbKLPdlG/AeiAoQ1SfHCCt4sEN
         9Ghkt7ucRHlrL6eV6nU/YCM9fFFhh9UoHWLsDJz3B6/o9CnKB/fjEaF07QXowqqCznUv
         zGgB+3Ue4C36IojxA9vnVvB3GZ90f5oRwo2i8BiQpDnUT/qiMn1if7qmwP85jZmd382n
         JE5b4fSinjVtjw3A/INIArOHLEJW77qwRp06EuRThLwEqylW7VM4VKC9wfwsJiJVUBFV
         wq+JXOaOSqi15TxjkTcXUF+DDKJhrNAGD2VRliNQlU391F/1+viJS0cytjQTwUOpsBX3
         RpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142733; x=1770747533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H2OJyckKVm20X+OA6cS6CCbUI2Jv19fRPHo0REqDGYo=;
        b=mPnDtJzE75nFPyL5P3UGCtV/uC/6MzUjdleaeWDpXjj99RZLAW9VBlji9w4K3iYhYk
         uURb8f56ZyrGHrE0OI6qB0BC9/lK0eY8F5sL5WhGhqgf/nVMCvxp6PjogeHUW2vsvQeP
         +VvKQFu0xCZytwQkBzUsqhJCZkBmDEOxKlJQ2w0SbwWB5t877yaSf0QyuQ0RaGvyTsaC
         FJzYKD8r4TZYgBdfupHmL5f/snAOpLoupfuTcWdl1i+WK5qVtTd00J+UU/1aYVUXeCCz
         1JYIvXjETxSYPDw94zrFbLwDcyE0UOUGrbqh4fho1WAtLmul8P9O5TRpV48ScwxM5xqY
         +r7g==
X-Gm-Message-State: AOJu0YxQTOof/0w2Rctt9CMvA+fpCEwUztUoaty8bvlJCSaO/hoXYJrq
	FASGb8wlGAYSh7J3xiOVWCTZ3d98nZHONbLxeQbeB5rSs4symO/QwMq/
X-Gm-Gg: AZuq6aI3TD3Soy90QHIahSWOmhQa6YitrYAogEXWcO8ugRPCAJL5oO9PuhlGh3n1yJZ
	OY3TSzZKxgivY8K2gCF8d8HNO7jE9ERsoBnyIpu6Bo0N/cXSAd9UORowU/oW5DKtbR30uzmLJF2
	oz0kFeOLbE1eZS1ZS2+P6TBC4D2xVui175MqSn/4LfTZeHUmizujX08Of57ZfbJqfhKgbgqRBOz
	hpDzMAJiRKpuqXxSZLKJk5x7GpR5lc3SYG32Y/JPbTr4vGb+00nLSaR7uCsKsMDApuAahHB978G
	OcYHVOfhdoovPnorfr2O/udPtQTEgWz1LCdp/1sC03cgVwePDumx8t0GZuNvyKjrnXi3Gh4FjZY
	0zqe1cE2lepmMCowaqnV2ZDqZ3WooSH4Z4xXnFh8n4kdHijMZ43xcDac3VRhvJ9vdVx8qTnovPv
	pUzjnermKxqh0kHR+/0Oucb6KbnVxnlMvv
X-Received: by 2002:a05:6a00:88c:b0:81f:394a:489e with SMTP id d2e1a72fcca58-8241c1630f1mr287078b3a.10.1770142733507;
        Tue, 03 Feb 2026 10:18:53 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d163fb2sm58273b3a.14.2026.02.03.10.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:18:53 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: newren@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	karthiknayak@gmail.com,
	kh@pks.im,
	peff@peff.net,
	ps@pks.im,
	pushkarkumarsingh1970@gmail.com
Subject: Re: [PATCH v2] stash: honor --no-overwrite-ignore with --all
Date: Tue,  3 Feb 2026 18:18:45 +0000
Message-ID: <20260203181845.602979-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABPp-BEZkhYW+fWgtGn8yHuLfak+UYo9A_HwdiCkAf5A0H6hBA@mail.gmail.com>
References: <CABPp-BEZkhYW+fWgtGn8yHuLfak+UYo9A_HwdiCkAf5A0H6hBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Elijah,

Thanks for the detailed feedback. Much appreciated.

> What's the basis for this patch? I don't see any "overwrite-ignore"
> anywhere in builtin/stash.c .

The basis was the existing behavior where git stash push -a would remove
ignored files even when --no-overwrite-ignore is provided. The intent was
to make stash honor --no-overwrite-ignore consistently with other callers
of unpack_trees, limited specifically to the stash -a cleanup path.

In v3 I rebased onto current master and also removed the commit message
claim about removing the stash FIXME, since this series only addresses
the concrete stash behavior and does not attempt to solve the broader
unpack_trees issues.

> This suggests that --all and --no-overwrite-ignore are incompatible,
> yes? Shouldn't they be reported as such rather than having one silently
> override the other?

I agree they are philosophically contradictory. I chose to downgrade
INCLUDE_ALL_FILES to include-untracked when --no-overwrite-ignore is given
so that users explicitly requesting preservation of ignored files are not
surprised by their removal.

I am open to changing this to an explicit error instead if that is
preferred. I went with downgrading to preserve backwards compatibility
and to honor the more conservative option.

> Also, the commit message claims you are removing a FIXME comment, but
> no such removal is found in this patch.

Yes, that was an error in v2. In v3 the commit message no longer claims
to remove the FIXME and is scoped only to fixing stash -a behavior plus
adding regression tests.

Regarding tests, v3 now explicitly covers both:

- stash push -a --no-overwrite-ignore preserving ignored files
- stash push -a --overwrite-ignore removing them

using test_grep and test_path_is_missing as suggested.

Thanks also for the references to the broader unpack_trees and stash
history. I understand this patch only addresses a small part of a much
larger and messier area.

Please let me know if you would prefer the -a plus --no-overwrite-ignore
combination to error out instead of downgrading.

Thanks,
Pushkar

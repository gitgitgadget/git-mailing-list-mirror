Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265BE22B8D9
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169487; cv=none; b=oC6W5czZ0QKfs+RQVMhccqRTCBa2cXE4H6mbXxL8sTWVnOYhcpLZWlucAYxamGwW4PW00G3QpRKCyL8+rJpZV/l1Vo/VK6MnyC4EA8BqWcR8Cja9wxULkCzoYj4wgXTmJ29pEK5rVC92FYsafH+tuhET5uoLh914ZUDPDPQ4rHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169487; c=relaxed/simple;
	bh=72IN1b8k7pu4hOPhGHB/+ZOFWsTjRocLtavAxv2mOf4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XwNxpCgyt59oCBZkQ3bpefUa600MJW8IsT4RmFlyqRTCS0OmMBsJJdTIkC/SQeqhx75wVEcPIMajckMY+BX89t5UWsgeNPtW91UVlJsCe8sx91QLX12IAKa0cJ6RPZLG0NSNBqJuuphR/2YKv+OvuC7chR4O38UEv+0mzuQGUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jade.fyi; spf=pass smtp.mailfrom=jade.fyi; dkim=pass (2048-bit key) header.d=jade-fyi.20230601.gappssmtp.com header.i=@jade-fyi.20230601.gappssmtp.com header.b=ne23aMy8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jade.fyi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jade.fyi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jade-fyi.20230601.gappssmtp.com header.i=@jade-fyi.20230601.gappssmtp.com header.b="ne23aMy8"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so7895292a12.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jade-fyi.20230601.gappssmtp.com; s=20230601; t=1753169483; x=1753774283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=72IN1b8k7pu4hOPhGHB/+ZOFWsTjRocLtavAxv2mOf4=;
        b=ne23aMy8jNIQz4PYyw7vMitzr55lg4VlY07bfLFjcFXmeMPHHEMu0g1Qas4AfqjLIj
         VnC6Nj/zbOiiglBWkqlT8XRzIQiw5Q6bNaHftHsMcVbYgLUBbgKMxuOC1kIVw38J47Uy
         jCFlS7vxgQgHXC0d57ccV+CN7uzZo+UBWG4jGX+tLveQ/P5+Z73VM9dygWiEBLBzD9sq
         WJd+yfjiEIYW4MsOubimC1Ivn5mUMspjatpH2X04AM434OyO5zAF3HcABlxddhi0cayE
         JL3zHdGTJkHs7CrOZMLDPuxb2yO4jme+wUY0Rg39OuocwIg7XaTT1AdFdEWe4gXeVyOo
         4y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169483; x=1753774283;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72IN1b8k7pu4hOPhGHB/+ZOFWsTjRocLtavAxv2mOf4=;
        b=POF53NeePkr/y9xp7BcvpYd689zNjoF3IrTDpiBQzIb103h0mDzjT+a09XypeF2xE9
         jW2bGDAE42vdgzkZKxCMc9UNzkEWkvJRE3U0ecLrVxhjgWJluFmGhBeEf+dfa2pyXWJP
         gp4sRoiZ+R7QzjThTepdtGhJc1bxV+srMUYeC9hEsCNIp7Vp6Z0w8oa21LvB9SgqEt/O
         4W4fypGmGgwnJLjx270G5aAviykTP2ISPal1qgo6wAR2sdqLFuSmSarBvovRH+8F6N4P
         dXQIedOiTGYFAy7qg3GgTXCwjz2puzYu2hMHUTF5pJ6221o78Rl1NT2TcHt6puAa0hdE
         TIRQ==
X-Gm-Message-State: AOJu0YzYhCkxCXlkiFsyjXdgKDTKcpwhR+/0P36rTiyfMLL+h3d7IeMd
	lllpX3qLFuUD4rjsLoOWmr4+YXpVZc4NuQO4vlSJCPTUyispdWJ6fUVT+1Grh7Ryt4MRfjBcyGx
	PfOmbyNsAaWCjFfaO/U8Vm98I+lR1yTFpycrEIEAZnijsUwIoIHxG
X-Gm-Gg: ASbGncuI1r/RtQjJibU0ch0TQT6kk+pq3orNCHQc+x8v99fCG8QGhmBnNfuYw/umTD8
	uUYJU2t4vnpOzKXk3oI1HIztvfVPyhlYAerK2LdwanDxXrw+dvhiqj+V8iLGYkAln/48fh/idfd
	QerXkILUFGcKPpfHVaBavHXRAQhYsztx6R6FeRBzvtohDRWby5U12ZryIfQ5qCkIx2dcBw7oZkp
	FiJTEo=
X-Google-Smtp-Source: AGHT+IFHNYQ1VqF78+FzCnkjhV3g0e+Bj5WCWEb1cYg8fGLTOM9fl1Yj0nfYt+6yJqPgc3lVLbwjF1lRxAZLEyLMYJU=
X-Received: by 2002:a05:6402:1d4e:b0:612:c4a1:1381 with SMTP id
 4fb4d7f45d1cf-612c4a11783mr14515872a12.26.1753169482544; Tue, 22 Jul 2025
 00:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jade Lovelace <lists@jade.fyi>
Date: Tue, 22 Jul 2025 00:31:11 -0700
X-Gm-Features: Ac12FXzhlOUPIWscKDal5Xp37X5E9xwMJHFfdGJU57qTW0-5yA1oi9C47NfhIx0
Message-ID: <CAFA9we_yDs9SPL2pJU_WiUz8CqvQ8ZPHwXBfTzHHbt-QGV34qA@mail.gmail.com>
Subject: Precious files and the .jj directory
To: git@vger.kernel.org
Cc: sebastian.thiel@icloud.com, newren@gmail.com, josh@joshtriplett.org
Content-Type: text/plain; charset="UTF-8"

I'm aware of the many discussions about precious files [1] [2] [3],
but I wanted to highlight a particularly pernicious category of
precious files that are really hard to do the right thing about with
Git: namely, other version control systems. In particular, as I
learned in [4], `git clean -ixd` will of course list `.jj` to delete
and delete it if you have it in gitignore. But yet having it untracked
results in it possibly accidentally getting added and also clutters up
`git status`.

It's my understanding that git has more file deletion edge cases of
gitignored files than of untracked ones so the latter is theoretically
safer. Is that correct?

[1]: https://lore.kernel.org/git/pull.1627.git.1703643931314.gitgitgadget@gmail.com/
[2]: https://lore.kernel.org/git/871s7r4wuv.fsf@evledraar.gmail.com/
[3]: https://lore.kernel.org/git/7v4oepaup7.fsf@alter.siamese.dyndns.org/
[4]: https://maddie.wtf/posts/2025-07-21-jujutsu-for-busy-devs

The part about these that is especially pernicious is that git does
the right thing to `.git`, there are not that many of *these*
particular file patterns, and they generally merit the same treatment
as .git as deleting them results in somewhere between frustrating and
catastrophic loss of work. The one other example of one I've seen
other than .jj is .sl, though that's only colocated with git if you
are up to serious shimming shenanigans with broken tools (nix flakes
etc) as AFAIK it is not supposed to be used colocated normally.

Should these be special cased somehow? Should they be simply caught by
the precious-files work when it eventually gets done?

Regards,
Jade

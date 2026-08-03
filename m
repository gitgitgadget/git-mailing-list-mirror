Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA036A008
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750642; cv=none; b=PUKs4Ehu5H97cUfVr9DHXqyrqM9TC8jL84JdLGONG1QKKGd9ejmgFsScl8ja6I7R3BfIpfb/qg26W4ZV9Dv3o+B53OLG8Kd+uzctJTeKCN8pBy68WlSVhJK10fO+hz2pLbMt9H3bpxSnZ8gGFT4ughhiO/WWdSrNdijota95//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750642; c=relaxed/simple;
	bh=LSlsmxsxNW2jg31HJf+weLrsfX0mKwHB1mVuvnFadEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEQz2wuQx/Hu/r14QOs0GTAfFMYDTDGuQP3u2jHhGXa5yUsiwb5y/7b4k9MBs3vuY9STsfErkJbP5mS1LChtx3XIdA6kzLK3vgMsEHbgOtG+NAzSJZtK7QVBV/mzAbuXnoa/AqSHTvFY+1H8MqUKLsduXfcxsiytttWEK/V8xNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqz4G5Ki; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqz4G5Ki"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-495590dde14so18531115e9.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 02:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785750638; x=1786355438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Jsk/66sybxeJECTcCn1WfJJn/dEo56CZEvz1diKPIc=;
        b=Kqz4G5KiG0uRydA3/9YZPyZNyOiGAifnbAfXqx1qIZeNOtXoE5VEeGuUrU5eexDl9n
         KxrpdyQIBz2UQwtc2qo8qRht/omVFtZwTtJ5Gr1p7qBXUUavAaoeMBwe4OLHfnmqrwJ2
         kv3R6FKlv3qBEcfYailhsTEw9V3H4zJPvvaXnOavyHmnq4pWDzouis8JNG8V9l1zzcNO
         btzb3xyuRFtJMyOrUcBlgTS0A0KLAY2Ri3CabzsFagZN48KoeJEGCEvws4BoaC8WVNle
         R+O/YeW5lxEfxfuZ/fEECIgDjfQfDMQWleFLuGehdsx7Vk0yBBuoj3+Td+i4Xl0bsoY2
         B6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750638; x=1786355438;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Jsk/66sybxeJECTcCn1WfJJn/dEo56CZEvz1diKPIc=;
        b=qXkE8JBWHCWXFo6K/yObcTIs5St4f663mb0cb8bQijKZScV5j2Wm5bLvtsQzJ/VkBT
         UJXb53EAuvssyLf2ebU4765OPCYR139uSbCklOkdTM5jyPZ5sx2sQxeojq6tV30Nro0y
         sqRnavNanXZxmt3teId3ENp2IW2+pnxA6W7/WICWcWAalXwo4rizdGB9+fprz6QFblTL
         OUBEJyNeH7ycmSO8hRgTW4UCOhxrM+nZUfJVt/aA9cOx6WvDY6aRkl70aRGp57YIz6cI
         OaClcpjqFI3WARZBizvDIqE7FYv5F7L5JKWaLKFDGfkEeJFGnLzOrDAoZ6RxCiSp3/H3
         RwRQ==
X-Gm-Message-State: AOJu0Yx46vbMWPc/LQWX58EAdOBxVzAiNKc/GSy1CL5P9q1dRLeb2+w/
	kc6/ipXx1YiX5rEAX8LdLi6/FBvrU8Fh/T1Qd23e/xmmp4ewtErkLmx32IMmhg==
X-Gm-Gg: AR+sD10rEYPUGoghQGVbwRrg1VgnpERj8y+1TLbyZGoI+bNlbyIH5mmPAjYtRLWMws3
	kSoTTE5eHXrcWJEdkJkc5EElBx5TDnCSc+yzTjPmWsI57BGblfhJkfR0KWp/Mti1jmeMpUiacah
	P5zQ2DttqyazXYar+SATMPKQxK/wBdvmLPScB4Xcalsv5vUpCsg5CU2BSQfGwYjbNI+/P6CQJP9
	MDEX0xDhRhB1qgOFLkbqVFgrE3AumJgQJz/psgC89J3kEu236ETqZoXSadClZRXJqOUqoTKTeVA
	ABsVj+K/DpNDDJGHbHsLeigFvVmPqNhB7VWO0L+xPltNT0xGraGbw1BZXzv27Kqm0pDR24ELBip
	0KUbE4HqRZJU5+xu1+i9iRDMXMJRIohi+GHDU2U68mzvO5ZB8pt/ipeTJUQWr7Quqt8Dny5/G7W
	3xCx0l40wc677JF/MHZmPyNYX8GzDdvR3neUpaCd/IdZZyxbW9rmZaRvTB6NxZf0gw
X-Received: by 2002:a05:600c:8b54:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-4980c674f25mr236797295e9.9.1785750638387;
        Mon, 03 Aug 2026 02:50:38 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b67529sm225414585e9.8.2026.08.03.02.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:50:37 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Harald Nordgren <haraldnordgren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Matt Hunter <m@lfurio.us>,
	Patrick Steinhardt <ps@pks.im>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v10 3/5] history: add squash subcommand to fold a range
Date: Mon,  3 Aug 2026 10:49:20 +0100
Message-ID: <cover.1785750108.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com>
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunlem.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

On 20/07/2026 09:27, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Folding a series of commits into one required either an interactive
> rebase where each commit after the first was hand-edited to "fixup", or
> a "git reset --soft" to the merge base followed by "git commit --amend".
> 
> Add "git history squash <revision-range>" to do this directly. 

As promised, here are a few suggestions in the form of fixup
commits. I've reworked the message generation when it's not being
edited, but have not had time to improve the template message when
it is being editing.  As v11 has come out (despite a suggestion to
hold off for a few days[1]) I don't think it worth my while spending
more time working off a stale base.

Patch 1: clean up the option parsing.
Patch 2: checks for BOTTOM rather than UNINTERESTING commits.
Patch 3: reject root commits.
Patch 4: reject ranges with more than one tip.
Patch 5: refuse to squash if there are any branches descended from
    commits in the squashed range other than the tip of the range.
Patch 6: never discard the message from an "amend!" or "squash!" 
    commits.
Patch 7: fix squashing a merge. 

Some of these issues are addressed in v11. The last four patches
are the most interesting in terms of improving the behavior and
implementation. Besides the difference in the way fixups are handled,
the main change is in the way the code is structured to perform a
single pass over the commits being squashed, rather than multiple
passes for checking the connectivity and generating the commit message.

These patches can be fetched with

  git fetch https://github.com/phillipwood/git wip/hn/history-squash/v10-early-part

note that they do not support editing the commit message of the
squashed commit.

Thanks

Phillip

[1] https://lore.kernel.org/git/414ebe62-c7f6-4d44-bde2-b689e35accfc@gmail.com

Phillip Wood (7):
  fixup! history: add squash subcommand to fold a range
  fixup! history: add squash subcommand to fold a range
  fixup! history: add squash subcommand to fold a range
  fixup! history: add squash subcommand to fold a range
  fixup! history: add squash subcommand to fold a range
  fixup! history: add squash subcommand to fold a range
  fixup! history: add squash subcommand to fold a range

 builtin/history.c         | 617 +++++++++++++++++++++++---------------
 object.h                  |   1 +
 t/t3455-history-squash.sh | 385 +++++++++++++++---------
 3 files changed, 623 insertions(+), 380 deletions(-)

-- 
2.54.0.200.gfd8d68259e3


Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205F393DC7
	for <git@vger.kernel.org>; Sun, 24 May 2026 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779644545; cv=none; b=C/jrH1RZL4bpc66s1wnxFFN77KnkcM0dp761KelvBOSQODTA8dlVI6lox3h5UZdALzOdHMk5jD0oVGCANWzPd7+qIbyBRv03yE4fRl11ViA9dGb9PCja++/IZQciZ1jiLjMCLtbaNLf/BoNS4VKlP4T8KgxDSxf3hvmtwuaGafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779644545; c=relaxed/simple;
	bh=c6BhRptdGswUTE8UG6wLKTt986oyaXl/QiFlTO70f5Y=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZpGUg3GND+aNG7MJYjUaSN6fHK/bPR6hzlkJTxso6U0Sugdvkvcm/z6+/4oyzwOTsV3XOIxbyRmWJxuySWZX+cTw/c9yax6x8EbJWeddVfm6FYeXjT5tCaAq3N5p3BqbxWkTbHuV+ouQ/FYL1nnoz1l3lXsyZU2MCe8N8GNeyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Obw+GlQM; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Obw+GlQM"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b7105dfb35so120045466d6.3
        for <git@vger.kernel.org>; Sun, 24 May 2026 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779644543; x=1780249343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tXn6g/gvKCFnnOmtKyIo5L7S7TZaouzE4jVYyosbWIE=;
        b=Obw+GlQMXDwTQGXCt3QDGRmaZQQSz/oed6iWo1f3nX4N8RVOa0msOcAoXWkqw1iNxS
         rlzt6l58vBZquZkT7uJHLk/UL612+6RxdArG6tE2TtUCd1UeLJuZW7cyEWKW54swMRNO
         yNtY7hCWRNNxkvB4Br2YgpxRb0y0A3eWJgS7nvD5VeV9a/tOgvNCvogLI0EdFyVME2hs
         3AxAP/ZXl6l2AZBcGv3XD0F8/HYuLYvryJnJUyPVqVjzgQIDzDmD+93Zjuwj+vQF5Qrw
         DDqQsAGo5jdTg5AfQRD4uXLtIB2yyriXPNNBZ61R83UGlCkn4e0pNIFjs8AT+AF7gPjO
         psNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779644543; x=1780249343;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXn6g/gvKCFnnOmtKyIo5L7S7TZaouzE4jVYyosbWIE=;
        b=fOTvDSJG3/8figDUbYVo5Azf8PRb3s5vlqOSGYr8KmP/GtnoOGK5PuSVPKoDSBIJc9
         c1onMvAEH97SkX8/WZ4uwP37P9Xq5kyC1X6jUBqOAtldoOU/HbiwmX/qXF+TYazF35A/
         lDbiTjTiMeO+Nfhc43gk98zo7NGaI2KAJm9LZLL8TMiofWHKI7ThN4JL83DRa+BkYXJP
         s+4WpngsBpsUztRw43mdSBEvjNadNSRnOvnY+NIYyaon6WKQObNrj6PCXbSZU9waLD8H
         1o1Db/w7ZvYSyzTfbxNZuSq0qIblk09S+XpHSXy06pXa0jMYer9DsrEfU1CIlqGbSnkn
         FC8w==
X-Gm-Message-State: AOJu0Yz0Rxf2y220JOBs2utE1WOcSiSkQzhFWl+BICB/Mvvx1sqIRY8l
	wimgIWB9pVO27o4XWP7jLCH2H7JF4dBJoOK8QDUejNjG866xnAULs7GDQDaAPsAk
X-Gm-Gg: Acq92OH2Q4pxvQjLlv6iS/E/DJ1kwkEj+CR9vy8ET5ebbbrv0qAFP/mBxIcTUU5Hqys
	QTru/LoaYLPyM9wR1PFiKIe78tZrBd6CnEdIaF1nf+jyTuByrk4dY6sr+coDj+oajyNKDJucfCA
	VXkbsgrGAI2vyc0Z5FHrPXEfO0qkoKI3bjoroZy3/kSppxM5CTflBG+eGtyqnUctlPujuAUD/+1
	xypS6KBlLaxoofjXHEc89Xq+jASd3SK6EXBvN8D3+Cb2qxQ/+RbGQClsvEoXRz2DV2KJ7oQXz8m
	8RfSaIV5i8pT5q6usddkYrELvW5NY4h775D2XW1Z/biUQkJYKzcisCIH6TeLSaN/FAnY9FhyVdV
	Jwlf2spKZHgWEfe0hrVq/D6upsvNx6LoWmw7J6N8/Y8bMHs1qWVAy/M1rr76cvAgek7RZRh2lQd
	RGZnRQ0E7jiVWNDJh33uxdE5psYA==
X-Received: by 2002:a05:6214:498f:b0:8ca:1e60:9312 with SMTP id 6a1803df08f44-8cc7b56a0camr194089226d6.17.1779644543014;
        Sun, 24 May 2026 10:42:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.235.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81306c57sm88535816d6.34.2026.05.24.10.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 10:42:21 -0700 (PDT)
Message-Id: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 May 2026 17:42:17 +0000
Subject: [PATCH 0/3] commit-reach: replace queue_has_nonstale with a counter
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
Cc: Kristofer Karlsson <krka@spotify.com>

paint_down_to_common() and ahead_behind() terminate when every commit in
their priority queue is STALE. The current check, queue_has_nonstale(), does
an O(n) linear scan of the queue on every iteration, costing O(n*m) total
where n is the queue size and m is the number of commits processed. This
series replaces that scan with an O(1) counter.

Performance measurements with git merge-base --all and git for-each-ref
--format='%(ahead-behind:...)':

git.git (merge-base)
                                          Baseline  Dedup  Dedup+Ctr
seen..next, 33 merge bases:               157ms    165ms    143ms
seen..master, 1 base:                      47ms     40ms     44ms
master..next, 1 base:                      62ms     60ms     63ms

(seen=fe056fe1, next=c82f1880, master=6a4418c3)

Large monorepo, 2.4M commits (merge-base)
                                          Baseline        Dedup+Ctr
component import, wide frontier (1):      8083ms           3778ms
component import, wide frontier (2):      5664ms           4207ms
component import, wide frontier (3):      4558ms           1796ms

Large monorepo, 2.4M commits (ahead-behind)
                                          Baseline        Dedup+Ctr
component import, wide frontier (1):      8216ms           4145ms
component import, wide frontier (2):      6107ms           4528ms
component import, wide frontier (3):      4725ms           1999ms

Linear history (merge-base), no regression:
master vs HEAD~10000:                     4410ms           4180ms
master vs HEAD~50000:                     4412ms           4494ms


The improvement depends on how wide the frontier gets during the walk.
Component imports in the monorepo create wide frontiers where the queue
grows large, making the O(n) scan expensive -- up to 2.5x speedup for
merge-base and 2.4x for ahead-behind. Linear history and simple merges show
no regression.

With a very narrow frontier the counter approach adds a small constant
overhead per iteration (maintaining the counter and the ENQUEUED flag)
compared to the old scan which would return almost immediately. Both are
O(1) and cheap in that scenario, so it should not matter in practice -- the
benchmark numbers above confirm this.

Kristofer Karlsson (3):
  commit-reach: deduplicate queue entries in paint_down_to_common
  commit-reach: optimize queue scan in paint_down_to_common
  commit-reach: optimize queue scan in ahead_behind

 commit-reach.c | 58 ++++++++++++++++++++++++++++++++++++--------------
 object.h       |  2 +-
 2 files changed, 43 insertions(+), 17 deletions(-)


base-commit: 6a4418c36d6bad69a599044b3cf49dcbd049cb45
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2124%2Fspkrka%2Fqueue-has-nonstale-v3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2124/spkrka/queue-has-nonstale-v3-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2124
-- 
gitgitgadget

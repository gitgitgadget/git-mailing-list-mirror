Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7272E45C10
	for <git@vger.kernel.org>; Wed,  1 May 2024 05:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714541232; cv=none; b=TjpqNjrkyqYYzEZn1r7cAgFAEk64xHbHLemwTqiFC3UarIBIxJ3AheSPqC+LR5PYnIJkFt1Bng2+WWRAnnpq5rApH1qP144jeAnGdxkULNdIGNEJgExjvJVPE3XzEV7SCRGrdQUdHzSJZXC9JRSRmos4NEy8MMIvejExB8l/yDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714541232; c=relaxed/simple;
	bh=P4InBexjz3KnBAXDDFH3OxL1cVPRtqzjHO1ygb5Pe2c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uByk7AMcTa88uDZo/xzTkR0IeJiryv+vaGsVj8go74rwA4KOG2Z51rB0LZPNG6H7C5zAvvRJZJbx5v8QuNukmIT145QSdiW/P6o0dlFFTqn0Lv0nsAgdjClqgrzu7WmPPtBtzjUo/K9sQ3rkHhsWCXHT+mGwGZoE2fKmiV/0Ctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cdl/ugwD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cdl/ugwD"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so6493109a12.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 22:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714541228; x=1715146028; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxNeoE8WwAk4OccM4Zw9Jw25hQs9DeAbNF+O20wwTPg=;
        b=Cdl/ugwD65gM4dmaEDJAJQYLQ8n6zG/lV9jTxbDTjx4oOUkPgzRkn0VCtjM/MaJsok
         lpYGNyFLHC2zBwczU+kL9BMweGhv8ZqZTT/l+zk1W5pJb90KvvsdstpT8mNHPV8bEwXo
         lq2MkTMIqJjs1PsydPjIEYL7I2n6ItgzW2pJMxuTDvh9RcKtUolQihE1160RPsp+tqkY
         /tMq2Byl9a6TCY2IjDhkRIVBxkjnfU2Qfsvhm7taJPAsXedYIXynXrTtWYvZ9egEpDUG
         JjAPmwoROhl6veqpy0pBEagWqz0DSGF9CJCp6cz/wwC5a8oqYiwSdG2fd0Cb3IIO0gBl
         RV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714541228; x=1715146028;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxNeoE8WwAk4OccM4Zw9Jw25hQs9DeAbNF+O20wwTPg=;
        b=jGQFCDpY7YPcrgmOpbZuLGTKrHAf+6uMwpFHVDGPDEb3ZUJisgk6a7BdXzcYypS07J
         WMb6D94BZ/zG2Yn3ccVZy7+gkAO9m/76ffMeG6OFAUX8y5Ml61s/Wqsoc0FkR5PX2e9A
         X57hWy0HemtRDKS22dpnPdwn4qo/23DhrNNdAx5CSi3tkmrbeC+/ZhuaqkQvlPcCwMXa
         1y7cTjfcYlOoBrSUD9Biqv69kLSVnkY6ZC+SQGgeNKT2hhcfj73Gi2Lt95+zK8x5IsdU
         1kwUR6SwQZVHpnCx7Q235hBfTve4Z+uC9rGoERRyaaLnLvnFfamMcoln9AeiR2kBfdMY
         QRXA==
X-Gm-Message-State: AOJu0YyXxMIUyUlSFfcwRTvyto8tiYOz8DX7DkLoYz1fR6uaAg9rv7xq
	AlRe0A7a/Ak6XjKLIo3TgWpep8p9v75+oh40MQnClunYRcoaSU27rs7zAOMrfMif9qPlaajDCp4
	cprHR6XGtNMSHOoDjdbM98lKPTUBUwHaJ
X-Google-Smtp-Source: AGHT+IEHnMBzK/Q347a36Mscl5fQ2RRF4NqSOt0scx+ZvJjiwEZSH0ml3afyIdmpVu05XNwnxalnDeka5vVYPZc/t2A=
X-Received: by 2002:a50:d55a:0:b0:56a:ae8a:acc0 with SMTP id
 f26-20020a50d55a000000b0056aae8aacc0mr1140779edj.21.1714541228148; Tue, 30
 Apr 2024 22:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dhruva Krishnamurthy <dhruvakm@gmail.com>
Date: Tue, 30 Apr 2024 22:26:32 -0700
Message-ID: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
Subject: Help troubleshoot performance regression cloning with depth: git 2.44
 vs git 2.42
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
Cloning by specifying depth exhibits performance regression in
pack-objects (~20x). The repository I am cloning is on NFS (mounted
with NFSv3 & positive lookup cache enabled).

Ran under 'perf' command to capture profiling information to see if
something really stands out. There is a significant overhead in calls
to file open/open64, fstat64 & mmap/munmap in git 2.44 compared to git
2.42. Not sure if there is an increase in the number of calls or
something more is done.

Could someone please guide me on how to troubleshoot this better?

--- Details of the test environment and the clone commands with output ---
# There are 10 loose objects under objects/08
$ git count-objects -vH
count: 3627
size: 25.84 MiB
in-pack: 1108374
packs: 2
size-pack: 303.38 MiB
prune-packable: 0
garbage: 0
size-garbage: 0 bytes

# Simple driver script to enable performance tracking for upload-pack only
$ cat trace-git-upload-pack
#!/usr/bin/env bash
export GIT_TRACE_PERFORMANCE=true
exec git-upload-pack "$@"

# git clone with 2.42: pack objects take 17s
$ /opt/git/bin/git clone --no-checkout --no-local --depth=500
--upload-pack=$(pwd)/trace-git-upload-pack .. prod
Cloning into 'prod'...
remote: Enumerating objects: 669941, done.
remote: Counting objects: 100% (669941/669941), done.
remote: Compressing objects: 100% (154988/154988), done.
Receiving objects: 100% (669941/669941), 144.54 MiB | 25.78 MiB/s, done.
remote: Total 669941 (delta 533745), reused 645666 (delta 512193), pack-reused 0
remote: 05:35:40.654828 trace.c:414             performance:
17.098198597 s: git command: git --shallow-file '' pack-objects --revs
--thin --stdout --shallow --progress --delta-base-offset --include-tag
        05:35:40.708162 trace.c:414             performance:
24.764812264 s: git command: git-upload-pack /large_repo/perf/..
Resolving deltas: 100% (533745/533745), done.
Checking connectivity: 669940, done.

# git clone with 2.44: pack objects take 325s
$ /opt/gitn/bin/git clone --no-checkout --no-local --depth=500
--upload-pack=$(pwd)/trace-git-upload-pack .. dev
Cloning into 'dev'...
remote: Enumerating objects: 669941, done.
remote: Counting objects: 100% (669941/669941), done.
remote: Compressing objects: 100% (154988/154988), done.
Receiving objects: 100% (669941/669941), 144.66 MiB | 29.08 MiB/s, done.
remote: Total 669941 (delta 533742), reused 645666 (delta 512193),
pack-reused 0 (from 0)
remote: 05:42:01.017156 trace.c:414             performance:
325.552424902 s: git command: git --shallow-file '' pack-objects
--revs --thin --stdout --shallow --progress --delta-base-offset
--include-tag
        05:42:01.063013 trace.c:414             performance:
330.965731114 s: git command: git-upload-pack /large_repo/perf/..
Resolving deltas: 100% (533742/533742), done.
Checking connectivity: 669940, done.

Best regards,
Dhruva

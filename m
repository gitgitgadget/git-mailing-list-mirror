Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954251D5AD4
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869871; cv=none; b=ZjIoNZ1r2U6C2t74uFkfj8YlhiXw5CqrVqDlkEP1ULabEfyGQRwcnH6upDwTpT/xw6AFl5P+0oIfDX3ieAVvp/OtHHY8/MOAUzAbgrnCiiv0Jyth/ORrWmRc7+syvKU30SDBFlyiUxNKEsbR7Lk8Ft7lC/xj3qGd3bPl4bSLQoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869871; c=relaxed/simple;
	bh=5WwwyG/Du0gykNGUmyhdo8JfwTyGBK00ywfcldnwNuk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=K+8t8cPLNLwJ3n8glbUHjE6Bm5QxOIzRfLHAACwyOlSi3NBZKSDg3UPfcOWPXWkgv9dHdY76GGUiJMHxAebmBvv0UnG7N6Nok8r6tl0n4TcfkJ9itnXKS8LxAYv987rJSe3pNuChWVltc9j3LMZuN2IbV1MPFLd8r5aAKepIm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTXH0kuo; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTXH0kuo"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a5ac8fae12so8631cf.0
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750869868; x=1751474668; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LrjCKIxb5GCprtvaFTViX0bcwRh4eGh7ckjxA9BLCQ8=;
        b=kTXH0kuolRgkUheW1E/SCjansHj0/UJDPduLuCvkbPbm1pkCvH7F06urNlKDJe4qAF
         V1FQhYvzDKViGEnZnm0hyAaueFugmn3b/smUX+p+8L1uRTTpjVu0M0gJBtf/K9D9ro+p
         +2yXLo4Gktjp9i+XgyZVJSUpVhF4g3buhMt+G6oeDguExAdXrru4hrD9XPR7oivQHyry
         zZzmwA2/3BFXOBdWnRTxbhrVz1EpxOWNdmroYISdQ13ttFoedGkvMnjyrBYGtjxXidf9
         n3zKuUey6Amo6Tbtqrt5q/l7nuDtwvONPjZLKgbzH34/Bn4kEKaSbK9/O/3Syilgu3Ew
         YAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750869868; x=1751474668;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrjCKIxb5GCprtvaFTViX0bcwRh4eGh7ckjxA9BLCQ8=;
        b=t6sdvxPN2a4nCyPiLTV7CnTdLPxTyogHiXb4FgAljrUHs8pYyHSpqoBBsnHCe1eYyy
         kAkHLhmAFLjgQi94Srlsphf9brAvG+KJE6Iv04ez5xvfuNvcJIYGDY7KD+OvHABBLnDz
         r7wW+RrER/PIr3sgRK+HjueKGgjYH4TJOsg5kJ3/wzmeh6dmFFm6ssSnFu6K+L2Td4E1
         HACbT2V0i28WE7RhaWbx5s9wj+a3wm9nLWD8PyoLI5peCNSXlaM6b8j5t5Vh3tk0yoZK
         MQR3rSDfZW294HXqX3uETGy3+fqsvQFC1YIjkHMte9/woSojxQ7vfmQ2od/DpTSsdnEL
         M7IA==
X-Gm-Message-State: AOJu0Yz2knWvuUwwEPbtabId35udEQfq4InQiU2WcpVaGqwUmH6QqkfI
	Xi/roE1HDq29ND39JrHP8zlqryBM4Xj4S2A0O/Ajb5bBE49Ev0fmcNZB2W4VEQpR/FS5PpHrPlX
	Ksx27V/x4THRif3xFfJfRmPC7TgNey86pYtRKADpaBXSeWuzvUYo5w+ZMLuM=
X-Gm-Gg: ASbGnctXpUfqp4BOhUnsWRLLzJuXYVMbYauHTviXgvV7H1hKUGlXCualG98aKmPOK6M
	tHgCB82zMor+uG1XYhz37pt3YgG6CpKZ/VKTHYlDIQjiNxCSwZ+BKGofrK4APnqs6+rWPDdPKuk
	s0h3cD5rkCslcY3kW29mnC4nNEQkowUAXNtclMtlRTyA+cPGTkfrDkcv1HPyvl5Q0Wc9/1objYW
	A==
X-Google-Smtp-Source: AGHT+IE2d+ngdyjdteUWiUBgfN+ggIbgJwCiJemTcR6FbNSkppBXtcLnPqZ9ZqoYHnxRvJjeNdYBpF3poPc2H14tHTk=
X-Received: by 2002:ac8:7d82:0:b0:4a7:bed9:5251 with SMTP id
 d75a77b69052e-4a7c68088bdmr3129311cf.9.1750869867905; Wed, 25 Jun 2025
 09:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Koponen <kaikoponen@google.com>
Date: Wed, 25 Jun 2025 12:44:16 -0400
X-Gm-Features: Ac12FXxkDuskjfygFNgTXoo7ZXkOn6oodEi7EOMqx3Tz86s-8yiduj-i_ON5duI
Message-ID: <CADYQcGoAN8bW3SVEdqPLJAMQbicbo6wQW_nNa_uYkXMouxO=Ng@mail.gmail.com>
Subject: [perf] git log --follow seems slow
To: git@vger.kernel.org, Kai Koponen <kaikoponen@google.com>
Content-Type: text/plain; charset="UTF-8"

Sample case:
```
git clone https://github.com/golang/go.git
cd go
git config core.commitGraph true
git commit-graph write --split --reachable --changed-paths
git checkout 3730814f2f2bf24550920c39a16841583de2dac1  # Reproduce HEAD

# Observe that there are no commits to this file until 53fd522
time git rev-list -1 HEAD -- test/index0.go # 0.07s

# Check size of test/index0.go and of 53fd522's diff
wc -l test/index0.go # 12
git show --stat 53fd522c0db58f3bd75d85295f46bb06e8ab1a9b --
test/index0.go # 1 line modified

# Find commit 53fd522 with --follow enabled
time git log --pretty=format:%H --follow --max-count=1 HEAD --
test/index0.go # 2.3s (!)
```

As far as I can tell, even with all of git's expensive rename and copy
heuristics, the above call shouldn't take this long (nor should higher
max-counts, but count 1 is easier to ballpark the work required):
- There are no other commits touching this file after the target commit.
- Even if some commit after the target commit copied index0.go to
another file, such a commit
  would not need to be included in index0.go's log, so there should be no need
  to do any sort of copy-checking work until index0.go is touched.
- The target commit is not the creation of the file nor is it a > 50%
rewrite of the file, so it should
  not be possible for it to count as a rename or copy, and therefore
no other file blobs should
  need to be checked to confirm this (also, we only requested one
commit, so even if the target
  commit were a rename, in theory there would be no need to check this).

I assume one or more of the following are going on:
- I'm missing some nuance / reason why rename/copy detection is
necessarily more expensive than I think, even for commits that don't
touch the file
- --follow is not taking advantage of the commit graph (seems likely
as --follow seems equally slow with core.commitGraph off)
- --follow is performing expensive rename/copy checks even on small
diffs that are not file creations
- --follow is not using the --max-count target to limit its work
- --follow is not using the --format output to limit its work? (Are
there format options that require more work?)

Git version: 2.50.0.714.g196bf9f422-goog

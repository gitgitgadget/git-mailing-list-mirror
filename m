Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D507206F31
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102859; cv=none; b=G8v4jmUJvvVS6wgYAIkar+scwbhjb4CrR7Agk4afpRpXJ+YA2N1t9VavLE/2NQBmSxmEyvWoqwCisf2HnWP+ott+eQM5oXR9KIOBryi5et7/ZZTIK0hV97GTaxiT2oG3/ovnbgmKGZmNRyhnK5ru6M64E1VxaktWsEwrEyCuVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102859; c=relaxed/simple;
	bh=pgopEV+KWa8aZz1f5+wSptzMPhL/YDS+jCbY520BaRY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ok32jVnKb5DN9d+DVNl+BusA6g6mGHU/5KYV5K0FLUwcyOOHJGe46zDGj9D3KNIpvCw+sthv6ao0mjoRaJI7beuG8wtkNV4YsHVR9koOMp/YtMEVwrd4fpf0gvh/yXoU6BsCUCkJKHvyEuOEQYcf4yWkL5ddEMqxVeGobpJfAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJpnmI6V; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJpnmI6V"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so10634058a12.1
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102856; x=1744707656; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtYcQEr5aL6CSvttoO3nYYMfaWzS6BloCe4otTDbLCQ=;
        b=JJpnmI6V0RPkyUdtKbCCS0VuEtlG54KjNIjKjmEdBvCLA0/6xp28o9Q3/q2wVabXY3
         +O575wTWn2o5eZYa4/OFS0fRm1ZsIeqiFetWeAmdrkEZl31edIiivplrGlt+suhBzpmW
         v/hruofvOgqR8X8Y0gnejVBHBc8UL6BdpzXan2sMovh2Kh5p8vPtJVKRZL6rRN9Kl5KV
         aBg/CMxUzrBYCqUylzH4i01MvYMVbl5mxKWo8en6RAwmeyQ9BKw50tdUP40NZMu7UPIV
         QpxXNq8T0HvvwjXUeJYlNlyNDoyFKOxqi/RVto5w7AjigPs+z1/A/OCo8MXtewAZU9GU
         ztZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102856; x=1744707656;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OtYcQEr5aL6CSvttoO3nYYMfaWzS6BloCe4otTDbLCQ=;
        b=cmsMD09r4skxAqghqn5nXBnYGlD60er/vowaHD2tQMvBeul9hiHNCLjjsL23/RK5Fz
         VuHzELb2pRqfVNqMkyE5kR5ShiSI9I+J7FtuaiEEh7EOLZb5ILQpvkZEhrywf10Qh8LU
         Q0DVo1U9FsvcNo4La/HAenZokGh83bWjvir0/oqI31PX0eDpFigp+03YOLA/qHW66uBZ
         Ke2ySZ3daLGM4HKNtIEYDTY6Wc4Jjh9WQ6Ph09v/KTmyMA6RzTtBpvJ/FPzENmHtc1V5
         mVnRe6sm+q1v9WZenur42VXE4icIR/M+oWVmX3VIBj0pgTrt0XSrUv2V3m7jVa4dHcRn
         ugEg==
X-Gm-Message-State: AOJu0Yyp8tKiVnSxiBqC4jgBfPTUPr/i89RsGGvyYT3v6hQgr2Ag6usF
	d9yAT1K3rww6Ceq93VglzJO3pPpYlGTRcOQ4owlJPotf/6g+Pktx
X-Gm-Gg: ASbGncsyMtu99T69gyiPVsXZCtkpn9/W9Vx6Qko/2w7liQKaHaN5h/ls6JeUWMCFYnM
	rCtRHVpug8ybY0iDmQZwpL2Z6jp4V+Vn0kpMFa/2RUUCkEBuDBN6MKXjqs+bye6jp/lQtvEgPkz
	mR6r+1ZOLq65NZaP7TXKlvLRFbt6RhmRZhM3DU3Zge/5VF+yb+iQwNgXN4OFra4YkM88Kezm6HD
	LRV5QKzNjPTAnCPiACB1/vF3JRlwMvPEh/qI2gi1BzcokiCEe6RXzXp4rvplVl17NikuJPZAVUg
	AmpxLjfQFhDbFnESCzLnxJ5VuOY6+cSweEfrdIpTXxnC0GsZHKx84oM=
X-Google-Smtp-Source: AGHT+IEPExGkchrqIDdxXy170BifktaoW5umUKgXmrbD5cC0gJ+OiB7U/OUjF/Ib1ubCqn1gexEyhA==
X-Received: by 2002:a17:907:7fa2:b0:ac3:8aa5:53f8 with SMTP id a640c23a62f3a-ac7e712047bmr869043066b.8.1744102856213;
        Tue, 08 Apr 2025 02:00:56 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5d442sm875538666b.26.2025.04.08.02.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:00:55 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/2] bundle: fix non-linear performance scaling with
 refs
Date: Tue, 08 Apr 2025 11:00:51 +0200
Message-Id: <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-0-0802fc36a23d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMPl9GcC/62OQQ6CMBBFr2K6dkypgOjKexgWpR1gEpiSKaKGc
 HerXsHl+/k//60qohBGddmtSnChSIETmP1Oud5yh0A+sTLaFPpoDORVBR0yip2JO2ju7AeM8KC
 5h9HyCwRbFGSXwt5G4MAwEKMVmFDaIKnkEMrcoqtQuzbzKp1NaUbPr8itTtxTnIO8vl5L9kl/C
 rnO/qWwZKCh9ObYGH8ui+J07UZLw8GFUdXbtr0BlsYuMxwBAAA=
X-Change-ID: 20250322-488-generating-bundles-with-many-references-has-non-linear-performance-64aec8e0cf1d
In-Reply-To: <20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-0-6d23b2d96557@gmail.com>
References: <20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-0-6d23b2d96557@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3305; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=pgopEV+KWa8aZz1f5+wSptzMPhL/YDS+jCbY520BaRY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf05cc5oPhGjhn3gAmjQ9V/3FZp7ER0Dz2Wy
 7X6VFKJL+j90IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn9OXHAAoJED7VnySO
 Rox/DZQL/jy6j3cApi7OIFeas2CLpBwxWtI6Vu8Mg8xXRYJfJACCEEXIcdSRir7QhPR7JmTs3Eb
 Tg9W5rf/8lPhUibexM/Ro8DJBGuvldaSWs4p+x2gJSCplTzmHQD7RlEpCH6slSvjb+7ue+xsoG/
 65c60zR6ALzyQ0MKxoTu7Gek4eDv2sYuQawIblI9N3uMftC7kMAUZ07BWxtO1U4rBmbWEVr2IMX
 TzXUrweNLEEF7xGjLyACTnaR4rmMGwlFFOD0lBUi6eVnYBj0vmqQC21scXrWW6I69l41ymGQmSM
 bef5cRXKBu6bQl1W7RVpjwj6RQseY9nWZIdqPfKH8lUjbPjSFxp3zuhTfXo7E6tNYXFmrcpSnu5
 qtEi/V/sBkhTYfx/7cq7PjdU3i9mzBRT3WhRMXGrbJJzXfvonTffy7gp5Z8jt7hejC2JcLb+Zsb
 HCopsI3ButJDk/bOi3ZfUfMgNNRNZ6mnFQELOAtzjiX9Y9W6nn5MkmwFtQOKLf/26gbZ94+iiH7
 kE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Hello, 

At GitLab, we noticed that bundle creation doesn't seem to scale linearly 
the number of references in a repository. The following benchmark demostrates
the issue:

Benchmark 1: bundle (refcount = 100)
  Time (mean ± σ):       4.4 ms ±   0.5 ms    [User: 1.8 ms, System: 2.4 ms]
  Range (min … max):     3.4 ms …   7.7 ms    434 runs

Benchmark 2: bundle (refcount = 1000)
  Time (mean ± σ):      16.5 ms ±   1.7 ms    [User: 9.6 ms, System: 7.2 ms]
  Range (min … max):    14.1 ms …  21.7 ms    176 runs

Benchmark 3: bundle (refcount = 10000)
  Time (mean ± σ):     220.6 ms ±   3.2 ms    [User: 171.6 ms, System: 55.7 ms]
  Range (min … max):   215.8 ms … 224.9 ms    13 runs

Benchmark 4: bundle (refcount = 100000)
  Time (mean ± σ):      9.622 s ±  0.063 s    [User: 9.143 s, System: 0.546 s]
  Range (min … max):    9.563 s …  9.738 s    10 runs

Summary
  bundle (refcount = 100) ran
    3.79 ± 0.61 times faster than bundle (refcount = 1000)
   50.63 ± 6.39 times faster than bundle (refcount = 10000)
 2207.95 ± 277.35 times faster than bundle (refcount = 100000)

Digging into this, the reason for this is because we check for duplicate refnames
added by the user. But this check uses an O(N^2) algorithm, which would not 
scale linearly with the number of refs.

The first commit in this small series adds a bunch of tests for this behavior,
while also discovering a missed edge case. The second commit introduces an 
alternative approach which uses an 'strset' to check for duplicates. The new
approach fixes the performance problems noticed while also fixing the earlier
missed edge case. Overall we see a 6x performance improvement with this series.

I found that there is a conflict with 'ps/object-wo-the-repository' in seen,
the resolution seems simple enough. Happy to support as needed.

---
Changes in v2:
- Use STRSET_INIT macro instead of strset_init(). 
- Link to v1: https://lore.kernel.org/r/20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-0-6d23b2d96557@gmail.com

---
 bundle.c               |  8 +++++++-
 object.c               | 33 -------------------------------
 object.h               |  6 ------
 t/t6020-bundle-misc.sh | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 40 deletions(-)

Karthik Nayak (2):
      t6020: test for duplicate refnames in bundle creation
      bundle: fix non-linear performance scaling with refs
---

Range-diff versus v1:

1:  1fd141cd34 = 1:  2b608cb908 t6020: test for duplicate refnames in bundle creation
2:  25b86d1a6c ! 2:  054389419f bundle: fix non-linear performance scaling with refs
    @@ bundle.c: static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
      {
      	int i;
      	int ref_count = 0;
    -+	struct strset objects;
    -+
    -+	strset_init(&objects);
    ++	struct strset objects = STRSET_INIT;
      
      	for (i = 0; i < revs->pending.nr; i++) {
      		struct object_array_entry *e = revs->pending.objects + i;


---

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250322-488-generating-bundles-with-many-references-has-non-linear-performance-64aec8e0cf1d

Thanks
- Karthik


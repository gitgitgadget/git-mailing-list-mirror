Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F31F931
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130026; cv=none; b=h98om35Pl4Ho6UMz2MFKOTaYzeACTBvF+CcoQMQ1PmsEaSdr4CWfebInIJ30PqXU3brBMGnIHFc2amW1gFMFPxuUL4rKG69BQOf7ZkQOnr41OpZzQjh8xLB0v82cW2bPEzc+2YKF1aZvGCDrzNCeBOx3hHYCJSvKy2fpozi2YSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130026; c=relaxed/simple;
	bh=6knHy2hGq/7N+2eEBDnfLHLqMstMAxjHW/G4WCIf6/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FRldg73Qxscqnb57bdYBAlLFyflIyPn/jUWond1uZZ8I4HCuqzcWl7/80jLvlneQm+96FGh3EBewoH9EPmxELvrfoUaCS9PqFIKPGYcjWd6M44aHCJHdmZ6C5iogJx3pw8SxV+JGqEDElxvbOTD0r6f9ttAQFhE+411iUHLCRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=WEtxswwJ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WEtxswwJ"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e38c1ac8e3cso1062037276.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732130023; x=1732734823; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X98TBDeujG5HtYb4qtY4Mg2aQj5gkELzAk41SCk2kv4=;
        b=WEtxswwJVRuyOowR4sN+RrbtEuiFiUr2ifwghRBm9GMNUzTq7MRyc76GTqaZWho5y1
         jEh7z6IhSnToybZTOus7sGHwBpmC7T9AoxVzZxpD+ePGwagBnrZ55jAFhAGlHtuiGmhq
         H451rEQe2O/rfNk6kqU+sltdDQabRVRn8vz9DmxO8vMMgbf44BCM51NGNF9vHQJ3GEaS
         okYESJdUqfV/Yfrnzh1rEBwsr7uoHLBx+KupsxUp3jaEKezcTqTinKYu+AWz0K/X63Nj
         PM/5ZxOUkwjmxjrwNlUWWRu+OOEwL/aIbk/6BJtkckTQvWI6tlH2BDZK2v9RgG3mQAWT
         xBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732130023; x=1732734823;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X98TBDeujG5HtYb4qtY4Mg2aQj5gkELzAk41SCk2kv4=;
        b=ZgtOVOceEyT8qG5XFSAkv9rFIrIxYooQpLeOcN0YVj927TgCsLzmI2jHX58qz7SQE0
         DpORxJcJZEpsaE+Q0tREIIJwNvUmCINc/TSkO+Wss66ST14ztn0gKq+gz8zaaExYP/Ch
         SrDV9e/AGNr0VJQS7WAcRAglP6JtCdpAZJtcNLsgFf2HQV55Ae/7lUaD/eUGlzJLALUh
         0HaWFZIiXrr4SiL5oOJFEmHPmI2zgeAS62MJqek09qUwykQyiLUNEawxsnTWDm7bo8j5
         +8gummldffMr3hD98uDKsIZ388Y1WE/oORz8cfBT/K+nVpQr+R6fGZX1eY6Pz+cp467i
         kktA==
X-Gm-Message-State: AOJu0YwE4vlanZpZ95PK3Z1C/vVMaLVr1+TXOn9mB6pgQIEfjD7MNUxj
	DWVROBC7o859SuT/4cHEUBAMr6der2Tj8TnzsGULzNSdaeU6UOurTvvFvRn4Q9U6UUSov7tVWYU
	J
X-Google-Smtp-Source: AGHT+IEZ0Bifx6rWcRx2FKolCNsi0MNovPf+bteVX9W4lXFA1b8rllcJFD8BE7z1OdREQWa33v7uYw==
X-Received: by 2002:a25:b794:0:b0:e38:8220:352 with SMTP id 3f1490d57ef6-e38e1519b75mr563653276.8.1732130023154;
        Wed, 20 Nov 2024 11:13:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e7e77aasm3305771276.39.2024.11.20.11.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:13:42 -0800 (PST)
Date: Wed, 20 Nov 2024 14:13:41 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/6] hash: introduce unsafe_hash_algo(), drop unsafe_ variants
Message-ID: <cover.1732130001.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

(This series is based on my 'tb/sha1-unsafe-helper', which I sent to the
list here[1].)

This series implements an idea discussed in [2] which suggests that we
introduce a way to access a wrapped version of a 'struct git_hash_algo'
which represents the unsafe variant of that algorithm, rather than
having individual unsafe_ functions (like unsafe_init_fn() versus
init_fn(), etc.).

This approach is relatively straightforward to implement, and removes a
significant deficiency in the original implementation of
unsafe/non-cryptographic hash functions by making it impossible to
switch between safe- and unsafe variants of hash functions. It also
cleans up the sha1-unsafe test helper's implementation by removing a
large number of "if (unsafe)"-style conditionals.

The series is laid out as follows:

  * The first two patches prepare the hashfile API for the upcoming
    change:

      csum-file: store the hash algorithm as a struct field
      csum-file.c: extract algop from hashfile_checksum_valid()

  * The next patch implements the new 'unsafe_hash_algo()' function at
    the heart of this series' approach:

      hash.h: introduce `unsafe_hash_algo()`

  * The next two patches convert existing callers to use the new
    'unsafe_hash_algo()' function, instead of switching between safe and
    unsafe_ variants of individual functions:

      csum-file.c: use unsafe_hash_algo()
      t/helper/test-hash.c: use unsafe_hash_algo()

  * The final patch drops the unsafe_ function variants following all
    callers being converted to use the new pattern:

      hash.h: drop unsafe_ function variants

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/cover.1730833506.git.me@ttaylorr.com/
[2]: https://lore.kernel.org/git/20241107013915.GA961214@coredump.intra.peff.net/

Taylor Blau (6):
  csum-file: store the hash algorithm as a struct field
  csum-file.c: extract algop from hashfile_checksum_valid()
  hash.h: introduce `unsafe_hash_algo()`
  csum-file.c: use unsafe_hash_algo()
  t/helper/test-hash.c: use unsafe_hash_algo()
  hash.h: drop unsafe_ function variants

 csum-file.c          | 33 ++++++++++++++++++---------------
 csum-file.h          |  1 +
 hash.h               | 20 +++++---------------
 object-file.c        | 41 ++++++++++++++++++++++++++---------------
 t/helper/test-hash.c | 17 +++++------------
 5 files changed, 55 insertions(+), 57 deletions(-)


base-commit: d8c1fc78b57e02a140b5c363caaa14c2dc2bb274
-- 
2.47.0.237.gc601277f4c4

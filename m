Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679A9501F59
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778063; cv=none; b=WknasTI0fqk9cLhx8Gdft7m1AnqJVkFCDhtR1r5UBugwN14W15gID9+V0+Kk/HuENz3Vk55JVR5696I2C/vi7szqRQ8LS4tJoa5ktLbz1Pvc9ikc7pVHdRsXKxGT+3VnN2YOEHlWZ7lWfWiZgnvsPZSIWsVD2SdVLWO27DKHOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778063; c=relaxed/simple;
	bh=kla2iBGhQ3PYzZ5wP7yIsgF3inLPn98bBeWX8ljS32g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=OxTR59lSX6kZ68h/wQtWSqZbNTqnSUvz4Yj2bGZF33JJkAX0ApDplaP7M2BQ643U6dmJmTwsAz7GXvCxGfyKmg/AvyxPD/twztNWH95G4Zbf9FO8evqePejDvBiOD9B8E/ep59DOJgZctKZeq9dMK/tOHiImYMeQpWrRgppt3ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS6Wqqof; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS6Wqqof"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-5337ac9e465so5861551cf.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790778046; x=1791382846; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p6Va17a2N7dxNxuQa9BtdrdrN9+BBKanF3gGvBtIjks=;
        b=eS6Wqqofk6Jw/+6Z2GooGZ+as9oHxztNHQuQYZf8Js30n9x+fQ80ejylXRw0yhjDpa
         CdByz/vXuz3KNZQG7S+4Il7bIM4+dctcdxi1NCEdY5F3jXOcB8UrpyX9mhgRd6lmTVwp
         1dH4VuvkVHhUvfc8k7wRQMIiXa242bIXH/mhRuIeqLKsSsuEzeLNAANw1acd2SRZZrN9
         DRaYlU6525EJ63BoElD41TeAiLntm5JBN4/oB2Sx5ziL8H7gYJPRKBRJwFF0a/YQV3nY
         1YMg5Yc2vNEhaKiVWC/6q1pRuwwNUwfd2tTxWIcxSYHDvorg1SyWisO0MfE25TLK5qgu
         lyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790778046; x=1791382846;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p6Va17a2N7dxNxuQa9BtdrdrN9+BBKanF3gGvBtIjks=;
        b=LawN4gQD4/fit+PMELfE8Rx34sdDjs07TSeCQh1T3tDpPTEmL3hVKLUNwSDinKR+CF
         SMwrS7PmmDsWHMV/N9VeLX8+VARE6c+dNoFXikzp04iXV+DcxH5U0IKkvo0zC5YSZLIY
         LF6EW1XzBsA4n8gcth42GHpNDexSijrf2aNcfG7Unyy88NrFxMf8usirk3BMdH67k44x
         y+Uy6DGKJ3LyhTXcPEPrMjuP5hyV2mDyXqsHC+ETzRa5xDHmadIQvOd1bgZg0fuvcQTR
         1E+nUJijfEg2HAB7kE895ObksBkPRDZ2tjAfqt2pfTZq98PLLVCm03rm4hgPL0/6BC5A
         48Qg==
X-Gm-Message-State: AFuF++nOX2JuIAH0fPeJvsFKlZTEn06lnNV8b+dYMPTsnytSSJ0nMGSS
	l+tCJIPAV7qUwchMJa4YJZWRieh34TYvuwrdwKhjBBgVzdmG5D35JUNnPBIIgDCv
X-Gm-Gg: AYBFou0ZHFH0aulw27MDUcWDqlgEg4Xd7Ka7gEn9Quaeatp12g6+bulplijY7UKaPuY
	aPEGUbU8Mazqw27kfw4G7IMBvmwhT/uw+Y100iNbFhZtN4SHCNUxW3kEFelLmKQyTyod7NRb6Eh
	FMX9I5CQYKCl+ntRe7tGn37fCWZne4C2fin4zmqK8wQOq0YS1YgtJBntOVQcUdiFlS3sufx4H3X
	IELz3/EPOsJnsZmGWI9rrQfbl/gfbDNBC66Mx5e54LW4SXRQjpa4iq9eYZ48mkHUfo1q8qRUTFV
	DdCRgTfZBFFBRxckJ7DPS0y6ndvlSjHptt0wzKXPUiHPUxtjXbw/uraqQJvs66nPiKbHheC2gHw
	d0CtMsj8GzMy3BcCPrtCdvmi6Ld4qnkVUbeBagRYuFHIMkpB+YqKSfpXimyBO5YY0G6OURcIDkr
	6eAzSM9P6B/xJLZqinQaJZToiae64KRoBI/k3+nrZaAjZJnEQBE2mYBJdkZHrKK+suvzARiyOfI
	D3vyrPgZltFuKp9Hlmj75Mxi657GJEMw/hB6/ZUPa7wb4Qj07lR+FyD4fBFN2Eldg9Y8DdyhpGK
	g9tUDaIyEb1kGHcntY5IEayxolBFOWnHIUXF5rnkaU6gXuVtgVtF7FNH5Ce/K+voenwMqUJkatj
	BqivuWhqkaSjh1EMuMigVD83UipXF+uozQmLXNLmRCeG6Fp8GMlxgKu8=
X-Received: by 2002:a05:620a:6501:b0:92e:5b92:98bb with SMTP id af79cd13be357-93ca96be791mr246327285a.14.1790778045408;
        Wed, 30 Sep 2026 07:20:45 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-eastus-03.tradc-corp.com. [40.76.104.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ca808106csm124645685a.9.2026.09.30.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:20:44 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v3 0/2] ci: use cmp and align job-count selection
Date: Wed, 30 Sep 2026 10:20:33 -0400
Message-Id: <20260930-ci-large-test-resources-v3-0-d65ac7c21b5f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNzQ6CMBAGX8X0bA20FKgn38N4wGULNfyYbmk0h
 He34IWL8Tibb2dmRugsEjsfZuYwWLLjEEEeDwzaamiQ2zoyE4nIEy0kB8u7ysW7R/LcIY2TAyQ
 uMw01aGUKU7L4/XRo7GszX29fpun+QPCrbl20lvzo3ls6pOvufyWkPOEgyizNa6WzQl2avrLdC
 caerZUg9h712yOix+RSgJGpLlS+9yzL8gF5Wmq4GAEAAA==
X-Change-ID: 20260923-ci-large-test-resources-349cdc95f7f8
In-Reply-To: <20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com>
References: <20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1790778037; l=5429;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=kla2iBGhQ3PYzZ5wP7yIsgF3inLPn98bBeWX8ljS32g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHtQ0yNxbN+i43EQ4u5bO95Lx7OdIyZsM+C/D0+K/6m5muTuMAoTR8t4lmP8WmCsWeCMnR98S8U
 5qaswhgvdVgY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The first patch uses cmp for the huge commit-message output comparison.
On this input, GNU diffutils 3.8 on Linux arm64 takes 5.276 seconds with
4,199,924 KiB peak RSS for diff, versus 0.506 seconds and 1,264 KiB for
cmp. Patch 1 includes the fixture and measurement details.

The second patch uses twice the detected CPU count for Make and prove
on both GitHub Actions and GitLab CI. This replaces GitHub's fixed ten
jobs and doubles GitLab's job count. The GitHub measurements in patch 2
favor 2*N over N, with mixed results against ten jobs. GitLab runtime and
resource use have not been measured.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
The table in patch 2 uses attempts 1-5 of each linked run. Its rows
aggregate ten Linux jobs, three macOS jobs, and a Windows build plus ten
test shards. Failed steps are excluded. Each job has five samples,
except one CPU-count Windows shard and one 2x-CPU Linux job with four.

Five further attempts per policy for osx-clang on three-CPU macOS
runners gave these successful build/test-step medians (minutes:seconds):

  Jobs                3       6       10
  Median          48:10   36:44    38:05.5
  Passed              5       5        4
  Cancelled           0       0        1

Six jobs had lower times than three in each block. The ten-job
cancellation followed six hours in the build/test step; its cause is
unknown. It is excluded from the successful-duration median above.
These are attempts 6-10 of the runs linked in patch 2, separate from its
earlier full CI matrix measurements. Neither experiment measured peak
memory or disk use.

Changes in v3:
- Use twice the CPU count on both providers, instead of adopting
  GitLab's existing one-job-per-CPU policy.
- Include CI timings and their tradeoffs in patch 2's commit message,
  and explain the use of sysctl directly.
- Patch 1 is unchanged.
- Link to v2: https://patch.msgid.link/20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com

Changes in v2:
- Replace the unavailable CI failure reference with comparison runtime
  and peak RSS measurements.
- Drop the file removal; following tests overwrite expect and actual.
- Share job-count selection between GitHub Actions and GitLab CI.
- Use native CPU-count queries on macOS and Windows.
- Link to v1: https://patch.msgid.link/20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com

---
Tamir Duberstein (2):
      t4205: compare huge output without diff
      ci: use twice the CPU count on both providers

 ci/lib.sh                     | 17 +++++++++++++----
 t/t4205-log-pretty-formats.sh |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

---
Range-diff versus v2:

1:  5cf348a75c = 1:  4a15b8f17d t4205: compare huge output without diff
2:  3b9bd2c495 ! 2:  d444411070 ci: align job counts across CI providers
    @@ Metadata
     Author: Tamir Duberstein <tamird@gmail.com>
     
      ## Commit message ##
    -    ci: align job counts across CI providers
    +    ci: use twice the CPU count on both providers
     
         GitHub Actions sets JOBS to ten regardless of runner size, while
    -    GitLab CI uses the detected CPU count. Use the CPU count for Make and
    -    prove on both providers, selecting JOBS after the operating system
    -    is identified.
    +    GitLab CI uses the detected CPU count. Use twice the CPU count for
    +    Make and prove on both providers, doubling GitLab's job count.
     
    -    Use nproc on Linux and NUMBER_OF_PROCESSORS on Windows. On macOS, use
    -    sysctl to avoid requiring nproc before the dependency installer has run;
    -    GitHub macOS images need not provide GNU coreutils.
    +    Five GitHub Actions attempts per policy, with the long tests enabled,
    +    gave these sums of per-job median successful build/test-step times
    +    (minutes; four or five samples per job) [1-3]:
    +
    +                          Fixed 10   CPU count   2x CPU count
    +      Linux Make             278.9       273.9          259.9
    +      macOS Make              94.5       119.1           99.8
    +      Windows Make           102.2       103.8          100.8
    +
    +    Workflow overhead is excluded; Windows runner images varied.
    +
    +    Use twice the CPU count to scale concurrency with runner size while
    +    avoiding the larger macOS slowdown observed with one job per CPU.
    +    Compared with ten jobs, this trades a lower Linux total for a higher
    +    macOS total.
    +
    +    Keep GitLab's Linux and Windows CPU queries. On macOS, use the native
    +    sysctl command on both providers so CPU detection does not depend on
    +    GNU coreutils.
    +
    +    Link: https://github.com/tamird/git/actions/runs/36070869894/attempts/1 [1]
    +    Link: https://github.com/tamird/git/actions/runs/36070867524/attempts/1 [2]
    +    Link: https://github.com/tamird/git/actions/runs/36070867647/attempts/1 [3]
     
         Assisted-by: LLM
         Signed-off-by: Tamir Duberstein <tamird@gmail.com>
    @@ ci/lib.sh: else
     +	JOBS=$(nproc)
     +	;;
     +esac
    ++JOBS=$((2 * JOBS))
     +
      MAKEFLAGS="$MAKEFLAGS --jobs=$JOBS"
      GIT_PROVE_OPTS="--timer --jobs $JOBS"

---
base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
change-id: 20260923-ci-large-test-resources-349cdc95f7f8


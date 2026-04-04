Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368C4371D1D
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775294673; cv=none; b=cE7QPel6sBAzrfUptDq+X2lUI2E4jcgwcaaY2Izm+cb3tbcYI8jCP7SZrUowKwA4TzocXcHd9XyLrJQZcUJD0TzyYqyPy0bIvOpXfUz3L/LlxffSWjA3o9MbZO2/lYnQsDZukBBt14MN0ayAvvWo/Fz7MBW55jbJtilWJ0Zr/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775294673; c=relaxed/simple;
	bh=46Ck20jV/IYXyGZ1mEb3TofGWhTbrtB9/rRMlv8wk4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTZKRbveybL41drqzF+B6gbXT6H6bYjSCA1ujgzmcy0Q3VIWIc1ekEfmDWFBglRclhbdi1WAnEsV1kpb8GyhiWZm1DSa49BK/mCu7TaE1/1asicARaKouEGyuJ5frHl2WIFvihKRGmciLeAA9w1pfg4uc3Yo1TQ2+EL2bSLi+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du/pGk6M; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du/pGk6M"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfa33a983so1570762f8f.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775294669; x=1775899469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnhvIWwKONaiOZjB2t3ue4VHUinkxLQJADcrd1bg3n8=;
        b=Du/pGk6MwMDLFYGWfyhI1STgG1hxb7V2KsPGUoZe2dqStyOc4BoKFM8B2WM++iwBiE
         Cp+edT9Mg+nzB5ZPA3zjLPkWDuH9MI+A3Fwmggh3Dl3/mfXbBuovAj1hTcFvf5yoUuIH
         rAMgPs06T1Uuw+TQg3lf6BY2mxXKpq6Hv3vDk30X9cn8pKGAhReQXJivaG9D5irXyNPi
         XYvQwxGBC9XBJxkzRHRiMwlgMJOkbORX3+mDfJJdIqDsr9TbUUELpG8g2fSrX3//6JtQ
         3msNkmjr1mVs5K2Ul1qjqdTn4VN0ZpSQI+FVmWcSvUTdL2phHU+MJdc5DZVORBquQN8l
         JOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775294669; x=1775899469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xnhvIWwKONaiOZjB2t3ue4VHUinkxLQJADcrd1bg3n8=;
        b=EEjvmTd+17OWpgEpoREEcCluhgKzzirHPOIzcJjm/rueEsHmJVWMFkWWcsjYmDw1IZ
         oY3TQRrYkR7lhZ8402O5A002BRYeUGYfG+zOhBTpPYamCcpc0w3eOWZ0ViBISSz67ctj
         2Pfg+8cSbB59KBS1IUBkBQoZEYtw1VzvAPEn8V3Xziiy7cnpNbe0mTkBt8PL/uKeou/I
         +wr+rPpu4/h3KqawOYITXFzJZq5Kg9zQF4jROmhReyfMWHMpk1IgiM9Lqott6lX8kzNY
         04Npw02rhtrNBncGRA/jXYGPhh4eBzpGf5oqPiFuIVHXlG9w0WvGCDFruT40W85lcFvq
         +hqQ==
X-Gm-Message-State: AOJu0Yy//vPMDa2yVerP4pDgTbj+q6A6dKjWwe/bZGbV8+q7CU/CLk57
	MKIeQl12wO+YjtR5ZTdEy+KVYPWxekIJDwS9J9YlKSVVDRtb3ajZV5CaiwIGEd36AHM=
X-Gm-Gg: AeBDiesAVaLKVf0TOSVqkn+taB/8Zb4qyGf7Ff20fJkPYKc3Bjsa8ZpFR4kUX69h24o
	QHctVgNw6bzyjqAn0eaL7VGa4g5x2whL+4ZTnuye+t1wgIOwZMGm0lHwW0YyFOCaFCPUHfQPVk9
	jIBXR3/dWHJr7JE0IBwFs4F6V2XL7TSF+zCKHz9tBeMOY4Kvd82AfJUxJkEo2MX8WKRwH+5GNef
	xWKxxc2LewP8xlrvgdo2uBuJx53ReRkMUkwR+5Sc4nIp/d3cYkoDPMYSbIYz0YTNbZ+nZGNHdP6
	G8CTy75JPrrGNYinYIYuGr4wmI+p+5sCZrCoLdZ05xMIQpFNGjsGDG0RJEelGyXfQQqNu9JdBwA
	ChQT3vGefILEXrUilTBurslvjunf2kGTKEsykqI3yKj+1Hg0Qa9gVxFxhuVpXZ78Yd8ynoBkL5S
	wRIW8wIQFr5WyONJpUeDhp9XjwQmsDbd1pvyETXpbsP3/0z7Vi54W7I/hpf9T/NvmR938MAfpKQ
	aevqqWdIohth1RSmhbLWE7ynTU/FXsDxf4J1JGXxx4pgzBSZLhr198htg==
X-Received: by 2002:a05:6000:4023:b0:439:c661:3245 with SMTP id ffacd0b85a97d-43d292f12a8mr8795136f8f.34.1775294668922;
        Sat, 04 Apr 2026 02:24:28 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f1a99sm25488813f8f.32.2026.04.04.02.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 02:24:28 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC RFC PATCH v2 0/1] graph: add indentation for commits preceded by a parentless commit
Date: Sat,  4 Apr 2026 11:24:24 +0200
Message-ID: <20260404092425.550346-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When having a history with multiple root commits or commits
that act like roots (they have excluded parents), let's call
them parentless, and drawing the history near them, the
graphing engine renders the commits one below the other, seeming
that they are related.

e.g.:

  * parentless-B
  * child-A2
  * child-A1
  * parentless-A

This issue has been attempted multiple times:
  https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

This happens because the engine prints left to right from the first free
column and these parentless commits for the next row, their column
becomes empty and the engine fills that gap with the next commit (child-A2)
seeming that parentless-B and child-A2 are related when they are not.

The actual implementation is very minimal.
This patch makes the parentless commits to be kept alive at least one more row to avoid
that, indenting the next commit to the next column and then clean the mapping
letting the indented commit to naturally collapse to the column where the
parentless commit was.

e.g.:

  * parentless-B
    * child-A2
   /
  * child-A1
  * parentless-A

This is done by adding a is_placeholder flag to the columns, the parentless
commit is actually there but marked as a placeholder

e.g.:

   * parentless-B
  (B) * child-A2
    /
   * child-A1
   * parentless-A

(B) would be parentless-B column with the placeholder flag active.

By teaching the rendering function to print a padding ' ' when meeting a
placeholder column hides them, printing the second example.

There could also be the case where there are multiple parentless commits

without the patch:

  * A parentless
  * B parentless
  * C parentless
  * D1 child
  * D parentless

with the patch, the indentation cascades:

  * A parentless
    * B parentless
      * C parentless
        * D1 child
     _ /
    /
   /
  * D parentless

the _ / might look weird but that's how the collapsing rendering does it
for big gaps, this case being from the 4th column to the 0th column.

Another patch could change the collapsing rendering for placeholders?
I haven't done it to keep it minimal, but a follow up could make it
to be straight '/'. This would make it bigger but easier for the eye to follow.
IMO is not worth it, but opinions are welcome.

The patch also adds tests for different cases like a parentless commit
preceding multiple parents merges and the examples above.

There could be some edge cases still so any testing is very welcome.

PSA: the tests are on t4215-log-skewed-merges.sh, which is not very related,
     but other graph related tests have +140 tests, and this one has less than
     20 and some of them are also not very related and differ in style.
     A cleanup patch before this renaming the file and style of the tests is fine?

Changes from v1:

- Changed to parentless commits instead of root commits to make it more generic
- Fixed the branch names to pass CI and fixed tests style.

Pablo Sabater (1):
  graph: add indentation for commits preceded by a parentless commit

 graph.c                      |  70 ++++++++++++++++++--
 t/t4215-log-skewed-merges.sh | 124 +++++++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+), 6 deletions(-)


base-commit: 8de2f1b07a8053d7f1aad70dc1131d6afcf5a28a
-- 
2.43.0


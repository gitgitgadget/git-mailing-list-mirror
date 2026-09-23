Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043184E379B
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201008; cv=none; b=GQHXoEvwiNsWFJNcs/GpzBU/bXnJ7pS7XqCmfhvitNPHgqyRiu/rz+w0fn9Dy96a6RmoT2SgyFSfF+WYmITfnj3DUmx+HQLgUMRzmNyPFViYtLB9SgCzCZBwh0FPcInES8cwV1AjeZJRDP2XsA1hy7iF1WnbIgLbMhok//k5w4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201008; c=relaxed/simple;
	bh=+bVcwQ5o7vnMgH6PSPB74bimL65RWzsrGoMJlfLfRCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+vqsB237zXVlQ2gU/LC85Uk0Ig322BQ/SfWLnG+SUyQkk7fVws+/lK1zO14sKdo+jXVeyJsMhUYkR2Evoc+HdFQ0HKJNpF4SRFkPf+w8D+TFLYDf66Oj6KOxZfmGno0p9hQQL1gRgmErbRSe6mH9Iip3EhZPAAqD/lLYdXlZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no6OtMSP; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no6OtMSP"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-4881ca701a4so891355fac.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790201006; x=1790805806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2g2Sc7hckGujkKfT4zme16kQGNCF76RQm24PNpjTh4=;
        b=no6OtMSPwag4vMKgqe4CeC6P9UE7iDooxZZ717KQKkiAG64+/zp7NSYeHJ46z/T01C
         ugNPL94WMR0qYtXxmlV/9h0w6C1TgRLNmvxYFvbdnV/z9VVyQy8tuSq5EtjQwgsCQxNn
         iyFth0x2Sw6aTeWIzuoMAEYrPGivvomJviCRbn9rwnRZ1wgAq/9i8paYL8FJ1PpYxX10
         ZqpA2fAo2xygQzsekZ59gB3owgqFsZs0mjvlbWC00Frf1Yk695KnfQBGxfjVBsQQZlcR
         9De/PvGHWYnD/MJ3dPXy+b6CMJ9CkoY+7fw9KdSp3u0kL6IJjZaeNGbNufMcAm3MfJv1
         WXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201006; x=1790805806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h2g2Sc7hckGujkKfT4zme16kQGNCF76RQm24PNpjTh4=;
        b=Y/knnKy5GA4iDl3sPPIgSt+4AnI8vuAQJcayAYHilw4oeNFGGy3m/exjt+jHYBxInh
         oL0FU2ZvabCTfZ13crLrCTTISQQhkuAwD9aUVqUhUGiVTCR3Z+kPCp4bpkENzuSUN4k6
         ljJmMWrx+gNGRjT8jU1Z4KC3ky5AHUBfmEoFp4xL78hghnWfJG55XC1JyUeV3oI6vtDV
         1hokvq/Y1QzhMkduwgiNGELQWn1UIRm2wQ4VgCMcePBxUSQwFt0cxLWUUihWKIcXAu2m
         W3z34tdQZfNfbUJssqaNjUEC3FVycUQVXjVMJWHETQrY9T8I81UBlfNb/sxD0fqyN9Q8
         PJHw==
X-Gm-Message-State: AFuF++klKiqQW5ottjAVFTU/UTK6Wnoy8COCprcFj0U+LeD4Ox8tCwsY
	18QgAZ5MBT7/1TIBEvoW+Jbb7sfcYuezSEZwBBMRC67W4VSawX95LmRs599qSg==
X-Gm-Gg: AYBFou1Y8+rDD+pSRmyRKtyqji3OhOSFoDNfBEOx/T58GTXzTQ/Smn9ArG8//Djse6I
	D5A82kZXfK0CYqs4Fr/y8GGI0OW+Chi3eGQ47xchVVOjC3JXpflXQqTNsxq1N9ZS0lo7QLtJQ09
	xRj23iIm/REPX4eXI1GMh4qrADId+sBvG1Bq18dWczuiAP9VSRGZ5qvz0Ghc6wjfWg4FnDPcI0u
	0iQ9vmBYGczVvyvREDwIyvyZ+1cH8ppz7C/k8b9H1VL5oNpHdbW5L4/7lTRuIPbhfsttqLfd+fz
	EK7azSKz0YPydufNHXFSQWTo/xZnwjbukg2xtu2xoL3SnP1iUfUb7DwTuLjbfiksVJxofe4klfH
	9MJ3Jah1y2tLj2/Ox6eLoraW/8TbwjHeNIZFcrppNAPg1TrbGcaQphSrylbpSjLjbOoUlEI53Ms
	vzJDTSNVTuiRJPLzMXaopZfScjKcH+P17vokw2ZKE8lZcM115Jn5POVrWJTs4otFjjCcht3uj7s
	jo1p675DmU1MhTAQv/gWqr3FLCMkZc7vnxEgHoG50bnWsPT
X-Received: by 2002:a05:6808:c210:b0:4d6:9232:b3be with SMTP id 5614622812f47-4d72cd37bcemr532961b6e.53.1790201005871;
        Wed, 23 Sep 2026 15:03:25 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c43b74c9sm3364802b6e.9.2026.09.23.15.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:03:25 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/2] object-file: fix packfile flush during transaction commit
Date: Wed, 23 Sep 2026 17:03:13 -0500
Message-ID: <20260923220315.569424-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <cover.1789328612.git.jltobler@gmail.com>
References: <cover.1789328612.git.jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This short series fixes a bug I found related to committing an ODB
transaction that contains both a loose object and "large" blob when also
configured to batch fsync loose objects. The issue can be reproduced
with the following:

        git init
        git config core.fsync loose-object
        git config core.fsyncMethod batch
        git config core.bigFileThreshold 5
        echo foo >1-foo && echo foobar >2-foobar
        git add 1-foo 2-foobar

and produces the following error:

        error: unable to write file .git/objects/pack/pack-2b7c2470289822070687e8d64186093a710eaed3.pack: No such file or directory
        fatal: unable to rename temporary file to '.git/objects/pack/pack-2b7c2470289822070687e8d64186093a710eaed3.pack'

If a "large" blob packfile is written to the transaction temporary
directory, it is unable to be flushed during transaction commit because
the underlying transaction is migrated to the main ODB before the
packfile is finalized. To avoid this, this series ensures any pending
packfile in the transaction is flushed first.

Changes since V1:
- Updated a commit message of first patch.
- Improved test readability in second patch.

Thanks,
-Justin

Justin Tobler (2):
  object-file: lift ODB reprepare out of packfile flush
  object-file: flush transaction packfile before migrating objects

 object-file.c    | 12 ++++++++----
 t/t1050-large.sh | 17 +++++++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

Range-diff against v1:
1:  cf14416f22 ! 1:  6f74391ae8 object-file: lift ODB reprepare out of packfile flush
    @@ Commit message
     
         When flushing a packfile via `flush_packfile_transaction()`,
         `odb_reprepare()` is invoked so the written packfile becomes visible in
    -    the current process. In a subsequent commit, repreparing the ODB is
    -    slightly deferred when committing a "files" ODB transaction.
    +    the current process. In a subsequent commit, flushing the packfile is
    +    performed earlier when committing a "files" ODB transaction, but the ODB
    +    reprepare needs to remain the last step.
     
         Lift ODB reprepare out of `flush_packfile_transaction()` and instead
         require callers to explicitly invoke `odb_reprepare()` if required.
2:  18a1798d95 ! 2:  ad2fa8ee3f object-file: flush transaction packfile before migrating objects
    @@ t/t1050-large.sh: test_expect_success 'add a large file or two' '
     +test_expect_success 'add large file with loose object in batch fsync' '
     +	test_when_finished "rm -rf batch" &&
     +	git init batch &&
    ++	(
    ++		cd batch &&
    ++		git config core.bigFileThreshold 5 &&
    ++		echo foo >1-small &&
    ++		echo foobar >2-large &&
     +
    -+	git -C batch config core.bigFileThreshold 5 &&
    -+	echo foo >batch/1-small &&
    -+	echo foobar >batch/2-large &&
    ++		git -c core.fsync=loose-object -c core.fsyncMethod=batch \
    ++			add 1-small 2-large &&
     +
    -+	git -C batch -c core.fsync=loose-object -c core.fsyncMethod=batch \
    -+		add 1-small 2-large &&
    -+
    -+	# Neither object may be left behind in a temporary location.
    -+	git -C batch cat-file -e :1-small &&
    -+	git -C batch cat-file -e :2-large
    ++		git cat-file -e :1-small &&
    ++		git cat-file -e :2-large
    ++	)
     +'
     +
      test_expect_success 'checkout a large file' '

base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
-- 
2.55.0.424.g13c7afec21


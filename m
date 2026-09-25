Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6277345729
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354161; cv=none; b=FfmhUn8IHbN2On7abJRTIcNxkg4rtXuh3yJADsa2GMnEQNxWye/9X3FD2ZnPCRCBA00/7Nx3petXAzixiIId5BlAmXVX1h9sqEu/XzJ3167ASz9ElqxLEE7qJPvyDGLFX3W8t35Wea+6W82YLjpCEsF//mz00S8hHzlo/dpjf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354161; c=relaxed/simple;
	bh=5/8gGmFUH0OyEU4x+ZluhNc9RJY4fkBxNR4sNEUOKfs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=mkyfJ5CE3c6EzGSosWgqL9tR3UPOT1eX3uaboVtXP8YTfvy/TjZygWu/3oQBJvYvuTL357X8adv+UlV/4VNO80YeBwaqRuRAOQ+efQ4C5mz1++9V+A6qVhwrqdbhpsjOaTNDNEA7foKlN4uDdQckv7CGvK0c6PPJx4SN89Lvpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiQ9jYRt; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiQ9jYRt"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a3688a2so793715b6e.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790354158; x=1790958958; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nJqj+xLYdxxkVMSwGT1xAq2nwy/mDU8SECNC35DYUjU=;
        b=LiQ9jYRtxifRwtcTnT/yze8V3HWy/AUdfXSYMsgTvWnGTIkSkS0JIcQxypUmbEx7c8
         yZER6//GNJkVOuuqUES21w87/dS8mW8qoaMYNUtI0cHMv+K1gzo3ptTNmCGquARhumEd
         2n6D3R0MNTDyNFdnYW19gx3oy7XjEG3W1MNY+n5OoJjRT2v5mr8ZgCaerkIQMWPdQ5SD
         EnUrDGtGnRlWYDvDwIG/GlLJQsAQ0siq9Q76HWQW1rymXaBeZ7SYBED+Bu/XU4/M/G7B
         wsiKUWuTQ6iCPH561WeLbvbClG6LtVC5HDLwJ1w5XfYLofuP4O1FYBplP9Q0euelf7M/
         SlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790354158; x=1790958958;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nJqj+xLYdxxkVMSwGT1xAq2nwy/mDU8SECNC35DYUjU=;
        b=DC6nM0vj1ZpAbJPyfBLyKVqddy7qNe8SpxPL8qXbxAowTo517zOuKHDIT1V4bnXHOo
         cm5Jcnl/ViL32IWA2nTE8A8XdW2RC9BUiq3GGcHnt6o7cqUln5BAhUwAuY3zNaBU+ukA
         mBdr7dQqnNdbejo2QrlKqJsdtV7/j0rjizbo9FaiorMgJbxIo6Wx4ur+DsN3R+XDhlC1
         gFuRaCSrSoeQ0ju1zw+Q4Y11xUtblS75QZn0+6QwxjoOX11X11uSe8AzuDk5gXe7O1D8
         2mKPDn2gb8ndZKhRbDe66cg1ufDP7xFJN6QBhLwVsHpJ6l2EOcbq1pFeR3xMKmPrI/CK
         lTPg==
X-Gm-Message-State: AFuF++m1FzsuOPazgw/Bdd0iVCf3yeBB2XkifoicwNAESEmKtB+r3tGo
	pAK/heAMwTGP6AHKqiDWFWAi8tP9Wg6+YbnXwHrjDjm+yRV4xn2qlIc8mXUKkEN6
X-Gm-Gg: AYBFou3Iu0jh46PYgCh4SU+LTwJpegfXrjgTzLJQdtZujfF52+8AjXtgJ/mEB7GvGas
	gAv10fn+/tvYBu561QfrTXcF06uETGIcNpdJXMYruHacaoGjp4NmgNDizpzIWGmP1aPMmAjPT3a
	UmHerpraPS2GN4MAoJFQZyGr+33UbQg97Ag7IPqiO2ifvV4uqcT6q8YrKWV2yna9uEYU4Wdh6Xk
	Zcs9wdvlO3n99c9UsKT0cmWJjjbOH/096kdG3JXbXcIHPJp5MAs9ArpyAXEO/avhJer4YG90oF/
	qv9DEOsjNsTXgmM/Cg64wS9AJGG2a5GuwgDjpKbaWDaqN1iAsZxd3fU+kVNW+DXRSt2CjWDowFI
	gopkeaekB0/+Tix7BSa/+Iblnn4vwMvW7FUAM/NzjgpXydcSabn5wJuM8rDDyZ2kwB9+FWB6ePl
	bdPIvoyJ5JnUnrTjXbajRUjv+xs8zkgUqm+sn0cfo6L+NvdBPFHhHJYZ54etXspWcKysbPveWhe
	3AyQ3CZ4aA+84COTX9f4h78qNByiDczNyoR4spBV1olnjls72KQo9QEjH7TEiuZrVU9m31Bo6+6
	l0OxCvUuEOgCWgzLKa7uoyyVdUlO7pRksXT7PXRUI/NVqvH+8hOv0/dupAIR8uk4NeTOYAHajTr
	ZvFh39GI5grh8lmZ9+hiJOD45jhnlqw+4JrMJbnLCf1Ds56bDryy7CJ6B7tqSYZ6iEqtellw=
X-Received: by 2002:a05:6808:309c:b0:4b9:a8ac:487 with SMTP id 5614622812f47-4d72df6cf05mr7162390b6e.37.1790354158421;
        Fri, 25 Sep 2026 09:35:58 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-centralus-01.tradc-corp.com. [172.169.249.3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4dbe7e76bcdsm2113204b6e.1.2026.09.25.09.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:35:57 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/2] ci: use cmp and align job-count selection
Date: Fri, 25 Sep 2026 12:35:37 -0400
Message-Id: <20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNSw6CQBBEr2J67RgYvuPKexgW2DTQBhgzPRAN4
 e4OeACXr1JVbwUhxyRwPa3gaGFhOwXQ5xNgX08dKW4Cg450HhmdKGQ11C7knsQrR2JnhyQqSQ0
 2aLK2aEsI65ejlt/H8736scyPJ6Hf7/ZGz+Kt+xzqJd57/y1LrCKFukzjvMlMWmS3bqx5uKAdo
 dq27QtfAJp+0AAAAA==
X-Change-ID: 20260923-ci-large-test-resources-349cdc95f7f8
In-Reply-To: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
References: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1790354149; l=3321;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=5/8gGmFUH0OyEU4x+ZluhNc9RJY4fkBxNR4sNEUOKfs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAzpKMWfJQt8YgSGgs1Dc60epWpVmbBFmcrJCt5m0p2FO7gSYZqsNX6+MDctoZcxRN6EdTo4qpw
 X479UaIAiMgs=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The first patch uses cmp for the huge commit-message output comparison.
On this input, GNU diffutils 3.8 on Linux arm64 takes 5.276 seconds with
4,199,924 KiB peak RSS for diff, versus 0.506 seconds and 1,264 KiB for
cmp. Patch 1 includes the fixture and measurement details.

The second patch aligns GitHub Actions' Make and prove job counts with
GitLab CI's CPU-count policy, replacing GitHub's fixed ten jobs.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
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
      ci: align job counts across CI providers

 ci/lib.sh                     | 16 ++++++++++++----
 t/t4205-log-pretty-formats.sh |  2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

Range-diff versus v1:

1:  5babc36eb5 ! 1:  b48c86e164 t4205: compare huge output without diff
    @@ Metadata
      ## Commit message ##
         t4205: compare huge output without diff
     
    -    The huge-commit test compares two files with a line larger than 2 GiB.
    -    In Linux GitHub Actions jobs, git log produces its huge output but
    -    its subsequent diff process is killed with SIGKILL.
    +    The huge-commit test compares output containing a line larger than 2 GiB.
    +    For two identical files containing 2,147,483,649 "1" bytes followed by
    +    "0\n", GNU diffutils 3.8 on Linux arm64 gives these measurements:
     
    -    Use test_cmp_bin to compare the output byte for byte without constructing
    -    a line-oriented diff. Remove the two large files after a successful
    -    comparison, releasing more than 4 GiB before subsequent tests.
    +      Command               Mean +/- stddev       Maximum RSS (KiB)
    +      diff -u expect actual  5.276 +/- 0.572 s              4199924
    +      cmp expect actual      0.506 +/- 0.099 s                 1264
     
    +    The test needs only an equality check. Use test_cmp_bin, which runs cmp,
    +    to compare the output byte for byte with less time and memory.
    +
    +    Assisted-by: LLM
         Signed-off-by: Tamir Duberstein <tamird@gmail.com>
     
      ## t/t4205-log-pretty-formats.sh ##
    @@ t/t4205-log-pretty-formats.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'se
      	git log -1 --format="%B%<(1)%x30" $huge_commit >actual &&
      	echo 0 >>expect &&
     -	test_cmp expect actual
    -+	test_cmp_bin expect actual &&
    -+	rm expect actual
    ++	test_cmp_bin expect actual
      '
      
      test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge commit message does not cause allocation failure' '
2:  0836f6b372 < -:  ---------- ci: match Linux jobs to available CPUs
-:  ---------- > 2:  8ec0308f6a ci: align job counts across CI providers

---
base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
change-id: 20260923-ci-large-test-resources-349cdc95f7f8


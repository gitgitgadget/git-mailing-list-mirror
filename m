Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACEE264617
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775311191; cv=none; b=OUmc+Z7E23wu2VgI2iySypxVs1U/fgVOsEQD9Jp/S44X1Yr5F/uWvpnmTfdZU1ZdMZ7N9VmsoUUo1ijCEmvgwAVFIATcpMQc7Gr/LLxJNjttvZcxJ4nTaiA8uW7572du1F8ApTBn07mYQhInDt6TAWhEadDg31KxVaMLrt6KEi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775311191; c=relaxed/simple;
	bh=sUPAF4YUdz20HzGRgqTpVfNNnWXPpEsGF0rnOjOa7qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6JsQpc375dhV2HS01UeoxZoI96ALOJ69/j5GVdp4NmkRIITzZ3VEczCOwS9YqTpYraJzmk1TA0XQKFkbOo3Ew/dMUVLj7rVoqef0r1YisuOgkQou2q/rLyMcF6/f/CqyQt+FQTg3nyBWzXmcWXHkf8LuDlTNNYVVAf1fNAgr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8QLOTsV; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8QLOTsV"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso2374491a91.3
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775311190; x=1775915990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ut2zalUO6Kdno+MwARwx6JEXNUonZuuxQTcj7/jOAvw=;
        b=m8QLOTsV/fPO7Z+7AWO+dLbAh9MJo2iK42D++2ZMe92fgfedD89efAFsvsYcRalpKl
         2DHQYJw7pVMffZxEM5ZugO4WNsNdUczkJTp1h30G1uzM86cgMRZHJ9eQ0r7FZRH6yYDZ
         IQWObAfDD76gNKDP1V5A14DTtYAlWK1H6wi2VoUR/I8e6sGOY+4EVdk/Hy4RMEMGIIBC
         cdVfvws9co4wnNdQQclSuM8S5Z9vdyHUVnNvqCcNJurO5rQ2SD/kMHi58VdHwwllgQ/k
         PJsxu8OqGd/95jA6W5CPGrdQvpaRi9JKHQEccdckIxo6VqE10SIMIuikhqSijoZSZCW8
         12Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775311190; x=1775915990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ut2zalUO6Kdno+MwARwx6JEXNUonZuuxQTcj7/jOAvw=;
        b=AcscEBML4DRE0g+rkVEkWMQo6lVpTP4RfN4bH6PcMcufyys0/URU6hKwbkSCHoyWs6
         Fo3ePEwSNg08WbgdEriqNz1XCCr86Fq2cpX05c4Qt0BE38Hffo+dMkNs/yw3I+5UIZej
         eSAAIFZ4oMQOjV2nNlAL4DGeBPDI0TObJz65XtuyeSFz6BW4osZrSMNFU2CvUhUlR6aW
         /4O3RIxdFOu818+fXE7Ylo2rUIMos/SV+bGOnj+l9cBgNblFo5zomLxLIvTEzBVd3YBk
         iu4To65gIwo0J2M8WsY6+lkaZm2LIkulUHC7IgjAehauuqNJx9DHCTCGaXVBtzRsU4F/
         dGlg==
X-Gm-Message-State: AOJu0YxN3Kvy08cLjJhlMXXZkvSSnu4EuXYv55b9HjvriXwIb+CdQ41G
	VTM/YGyGpXQu7NfgK8/EeNYpdcqSBVryBF2aQnCwIR+dsvMV/vhWf2WPICUQJg==
X-Gm-Gg: AeBDieviezTu6cpId8/KzWSajrH49YcZCSPigJx6p/e8N87tih84DQ50QF4NpjWOUwL
	iNpSm4XW3fj+35iLivxpxv6UPidBORdSjOPNc9FolP+m/gfwCm+VvGgP05NNmFx/oZXyqgwxQRB
	z6/dZT/Cjqs3ZPWjG5P4f80mP4XYZBGqF3silXDqh+eOBWpr+UEZIrdfwiFZN+EcBjwNEP26Kjm
	cxUuKc4xlN+cuI9f709bICvCHciInHHhNZ8/so5ANE2mPYTni3XsJeZBdsCIVupdoLLyWhsVkb8
	pQidImqo6J10yiwTz2AmGQA/Ty3CETsE5/gCIwbJ6C6/DIZgDH6wd+2I8wNz9lJLzuaq/QD56bO
	wGJGj0C6Ts76IOaCn0V0Gd5oAzhtFWIPxpqT4epnJuO0XMHgM9mgEfSNfUFT6EZg9n5TdNRS/ET
	ZuDLATOkY1pZ5OFpEhrBaN5aCJA0HtL5jEZ4GhmnjWmA8=
X-Received: by 2002:a17:90b:3bd0:b0:35d:8fd8:d893 with SMTP id 98e67ed59e1d1-35de67eb212mr6325862a91.7.1775311189852;
        Sat, 04 Apr 2026 06:59:49 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:8811:aff7:7421:f350:c0a6:bb03])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6491fe0sm7071805a12.11.2026.04.04.06.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 06:59:49 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	a3205153416@gmail.com,
	bkkaracay@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v5 0/3] refs: reduce reliance on global state
Date: Sat,  4 Apr 2026 19:28:37 +0530
Message-ID: <20260404135914.61195-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series continues the effort to reduce reliance on the_repository
global state by making repository context explicit across the refs
subsystem. The patches focus on passing struct repository through various
ref helpers and backends, and replacing uses of global state such as
the_repository and the_hash_algo with the appropriate repository instance.

Patch 1/3: Updating get_files_ref_lock_timeout_ms() to take a repository
and propagating it through files-backend, including callback paths.

Patch 2/3:Replacing uses of the_hash_algo in refs.c with the hash
algorithm from the appropriate repository.

Patch 3/3:Removing remaining uses of the_repository in reftable-backend.c
where a repository instance is already available.

Shreyansh Paliwal (3):
  refs: add struct repository parameter in
    get_files_ref_lock_timeout_ms()
  refs: remove the_hash_algo global state
  refs/reftable-backend: drop uses of the_repository

 refs.c                  | 17 +++++++++--------
 refs/files-backend.c    | 19 +++++++++++++------
 refs/refs-internal.h    |  2 +-
 refs/reftable-backend.c |  6 +++---
 4 files changed, 26 insertions(+), 18 deletions(-)

---
Changes in v5:
 - made the commit message of patch 1/3 more explicit.

Changes in v4:
 - Dropped patches 1/5 and 5/5, as they require further refactoring and
   discussion. I will send them separately as a follow-up.

Changes in v3:
 - Fixed an import
 - better readability in patch 3/5

Changes in v2:
 - Made struct repository the first argument in function parameters.

Range-diff against v4:
1:  11c134b3f5 ! 1:  59c4662031 refs: add struct repository parameter in get_files_ref_lock_timeout_ms()
    @@ Commit message
         is used as a callback, introduce a small wrapper struct to pass both struct
         lock_file and struct repository through the callback data.

    -    This reduces reliance on the_repository global.
    +    This reduces reliance on the_repository global, though the function
    +    still uses static variables and is not yet fully repository-scoped.
    +    This can be addressed in a follow-up change.

         Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>

2:  d144e879ad = 2:  9dd20df759 refs: remove the_hash_algo global state
3:  76c14eb320 = 3:  04c88f7ed4 refs/reftable-backend: drop uses of the_repository
--
2.53.0


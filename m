Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A9B13DBBE
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967559; cv=none; b=hxV21Cb1DY4gzL1YIjMiMctXfAEiv67BI5VmG1ds2EbMh3lCsOqYcuuPwDRBG5phnXzXnQ0ki2Sq+3t0YA/2KZQ6oLNZYd49f9E44SkGD8UnmdijYdDuPvqQAgseUKegGJXso+VqtW/ICmJ8uHb8YjXnecC6zFu1O+bB/NCzWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967559; c=relaxed/simple;
	bh=AzCXALt9L6pqm58LFNmEk3eS28cTy38AXrB5SUhF1xc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=IRaZjv8gpiU0n6ktVx0JR8UZq+FAv+kHeYUW6QxoRPUzHCszPbyjJOF47PBWoMgAItSKua0eCk0+KUDjBKn6ZPBlOJXKdViRxDspRRPnMZfxiISgMhuY1nsd7izoViLqDXWGVRl1L9jKetSLnIBuchjt7wCiBMLAjeMeqjpAgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhwaKoGG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhwaKoGG"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38245e072e8so1237387f8f.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 14:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731967555; x=1732572355; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOLSNQvCTtgUVEDNZUL558KD6BP78B+bsS5YX8l6vwQ=;
        b=fhwaKoGGk9LBOIRDXVDivy0oOjq54ef+dfmjF1KLamV+h+pAqtb31izEC86yzeJTg7
         07CD3/7siG7sgx9O9Aq/NMe0cqvSunuOQySETAFSL5xJDXOnqbYVtghv+EjmDqTAMu6d
         L0j4WKgXhDgjSO/Vy5H1J09+daD/YQCzac/GE+f67My+ejVgQUOi8qpEkY4CM1aDsDe/
         kdIo3uHii4XALljjlnbxCplX/Ej8nLWM7tMrON5NuKYtLhmMGgjgS9pJ4ejrHcWwcdxJ
         s63kae27a3tmlhx4I99Q0h/IHKuMzalKkicCxn0L7zLZfX+HIQ09Fa7K1EmASwPnAs8p
         iRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731967555; x=1732572355;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOLSNQvCTtgUVEDNZUL558KD6BP78B+bsS5YX8l6vwQ=;
        b=tZUAI5HUBDQxSm4zI/CpsVGyEw9AUH7iXUxQ4nQ9fSDm47pG16IePSw/x998kdWMoc
         SZZZMfT/3wHMTvZXhmH9x4x+hzeLSXGEcR4Pru4amj6GHClaJaxGcMVfn9X77xOs4WCe
         hUOQRXnNSp4Y/lUBKEd5+5Vrb6u0lVym87XH6GM8sxhyAx/fq/+xBXgnwoqoVj4DzRy4
         8PcrSQn/NsVqVnUppdGNq291ws6iSW2HPF2KKu1u/P8pz8vB8CqnVvBd9pDoUjXCHuGt
         cg54DJMQmvb2uY/XbHimnGCRDZiBkGzFyfRZmTlyU6HsvOybWb6e977Q3SZn/a9jr8I9
         T8Wg==
X-Gm-Message-State: AOJu0YxNkha6pSM4hvEPVg4OOLxkyP6wPQl9aWtbPyqNgqYKH/TiUzsM
	3vIL6jBlu01tWXxG/mjt3ib3VdQiTG4AeOtgioM1B0Is27PKmrlHPEAWVA==
X-Google-Smtp-Source: AGHT+IFoCOcJF4Aosa9R+TIlT967pMJu+LLboHNd6vONA1kyrn6ZIASaw7PoRcSgOIKLwkDGkBxUiA==
X-Received: by 2002:a05:6000:1868:b0:37d:43d4:88b7 with SMTP id ffacd0b85a97d-38225a21c50mr16833351f8f.3.1731967555045;
        Mon, 18 Nov 2024 14:05:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823514e2bfsm8542529f8f.64.2024.11.18.14.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 14:05:54 -0800 (PST)
Message-Id: <pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
References: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 Nov 2024 22:05:48 +0000
Subject: [PATCH v4 0/5] doc: git diff reformatting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This is the continuation of the editing of the manpages to reflect the new
formatting rules.

Changes since V3:

 * rework the description about -1, --base,...

Jean-Noël Avila (5):
  doc: git-diff: apply new documentation guidelines
  doc: git-diff: apply format changes to diff-options
  doc: git-diff: apply format changes to diff-format
  doc: git-diff: apply format changes to diff-generate-patch
  doc: git-diff: apply format changes to config part

 Documentation/config/diff.txt         | 204 +++++++------
 Documentation/diff-format.txt         |  42 +--
 Documentation/diff-generate-patch.txt |  44 +--
 Documentation/diff-options.txt        | 423 +++++++++++++-------------
 Documentation/git-diff.txt            | 122 ++++----
 5 files changed, 433 insertions(+), 402 deletions(-)


base-commit: facbe4f633e4ad31e641f64617bc88074c659959
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1769%2Fjnavila%2Fgit_diff_new-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1769/jnavila/git_diff_new-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1769

Range-diff vs v3:

 1:  6841bd5825b ! 1:  fd3ee137fe4 doc: git-diff: apply new documentation guidelines
     @@ Documentation/git-diff.txt: OPTIONS
      --1 --base::
      --2 --ours::
      --3 --theirs::
     +-	Compare the working tree with the "base" version (stage #1),
     +-	"our branch" (stage #2) or "their branch" (stage #3).  The
     +-	index contains these stages only for unmerged entries i.e.
     +-	while resolving conflicts.  See linkgit:git-read-tree[1]
     +-	section "3-Way Merge" for detailed information.
      +`-1`::
      +`--base`::
     -+
     -+or `-2`::
     ++`-2`::
      +`--ours`::
     -+
     -+or `-3`::
     ++`-3`::
      +`--theirs`::
     - 	Compare the working tree with the "base" version (stage #1),
     - 	"our branch" (stage #2) or "their branch" (stage #3).  The
     - 	index contains these stages only for unmerged entries i.e.
     - 	while resolving conflicts.  See linkgit:git-read-tree[1]
     - 	section "3-Way Merge" for detailed information.
     ++	Compare the working tree with
     +++
     ++--
     ++ * the "base" version (stage #1) when using `-1` or `--base`,
     ++ * "our branch" (stage #2) when using `-2` or `--ours`, or
     ++ * "their branch" (stage #3) when using `-3` or `--theirs`.
     ++--
     +++
     ++The index contains these stages only for unmerged entries i.e.
     ++while resolving conflicts.  See linkgit:git-read-tree[1]
     ++section "3-Way Merge" for detailed information.
       
      --0::
      +`-0`::
 2:  07df397741b = 2:  a0a3986ea86 doc: git-diff: apply format changes to diff-options
 3:  698628e076b = 3:  aca3573cd95 doc: git-diff: apply format changes to diff-format
 4:  1154462f8be = 4:  0e6162d02d1 doc: git-diff: apply format changes to diff-generate-patch
 5:  4ec2fd9c3c6 = 5:  d350237eddb doc: git-diff: apply format changes to config part

-- 
gitgitgadget

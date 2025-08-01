Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739A21FF3C
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040696; cv=none; b=pknRDqR+qNWmcqS+OPjqSefTa5urZ+9YYYbP4OpAmQmglPDcKt6RuaWHQAPmC7ps2A/WY8iaQfQa364efhrJI965ck56bzKepvNk/lHZ1/C/Xsxbd8K9y9+8Y11AD4uaI7eOKEp1l+Q7ZqvCYjymBxcmBWG8obRlFN0q+8dHsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040696; c=relaxed/simple;
	bh=Uvm7OoaMfnbWkoFy39za+AVKblYfylEpkBkoBtPtxUc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HjdnP8rQlO6ZNTYiWEyGtEOPMelLTldh4hNaeYxTihKKLlhaBIOPUv3582E6KeU7fGvGvdJPlm8rs6RrV+yhx+bGv3XZg/B5jt3G/qlDNECabsM2HHaHADXrLZc/i8DuZsh7P7C3KN4AE3FGZ/W5V+2URGB4iKNaNDafoEQQN34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQuS9kpD; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQuS9kpD"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31f4e49dca0so1476613a91.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 02:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754040693; x=1754645493; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uvm7OoaMfnbWkoFy39za+AVKblYfylEpkBkoBtPtxUc=;
        b=OQuS9kpDdWXktAvKtQVzTK2SvdCqfMtcW77mtq30ReRLNtd2oTc9NhSRH+Jx56lYpm
         kGF4+pEmCUcxcW52DKx339SgxxXZoX1TpsfOTWt+JHLohmgWXeT4Fj+0fjFZNKTK0DG6
         y3XRgkkkTAcHAt2Yz9Hhg1/ffl2f50D4+TrTFSFnCRAk8sDP8xG7n9V9Ktk8/eInveyI
         mooKCc+Rp0W4zQmBn/TtighN9h2OpgDhTzCK4gokVRpEtKX32vbq9uedujeERPNflciS
         /wodoRsJYVTR2P139PfKgf319/RBW+ht1JHiEd9BNx3zYOdto7Z5mGxgq5x+/WOHEPo4
         Bo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754040693; x=1754645493;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uvm7OoaMfnbWkoFy39za+AVKblYfylEpkBkoBtPtxUc=;
        b=ESZPEOq2/oZD+WeXbDf6Z81GtsAG6QlVeqI68ijX8sC8OG7jn3vNXVz3eaIgV+V6lr
         DggakyBgri40B4ME/CfzD4XU2tYk4IGplZaA7nyf+5GD3AR2gCAgmb+JYqbnlh5Wh46S
         yYWfrO+52vjD9FuKRFOv/NPjuBLTP2V8zWypbtCrHn0eoIH9FQuaD5AeATNeu2Z43kp4
         9U7+8h6QSAF7QdnxysootNR9NiVOputBAoF9MnTmDopklKHF/fw0s0V9TenRbKU6FGeB
         34m1tQirYF2VMJ8mTkAVzX0Gho5Ld/1vws50SrkqjUMQrvvIh7yx9JEVnFI9l3+issB1
         ekFQ==
X-Gm-Message-State: AOJu0YwUU6xWF6m9rZl41N1qmCMUSd/cbLFagswlXhkjZdLG9b4c/NTY
	e/BpTYtskbiPB1952h5DRTGkmjKG+GZxebA7/T+gUF9Dz9ZmErcHZKw48thaPl8Y4pWUlJHNp3g
	P03DmTktXMsBnEj3kLWPR12kj86oMuVLg4lVboA==
X-Gm-Gg: ASbGncuDtzSJYtCsC1AIYT10c0OXMYy7q/6NgtoQvnLVV5og0Rn+Ni2K0q7L4u/xB9T
	wSf+WdGelHW5QkZknQx6LordbDYNjLjnKDWmvVglPqN+9iIMVsZrpZUNS0fUG5JuKdj5PWlzoVT
	G3CYlLPHiDo8uWTu0tLbaXSjvP6QmR8CMZvPNWkFQPo0QkVecral0hwIkA6aYpUUE2f4wmG+j75
	RXk1GrWs9NchlwmqRLMuz69IO/VsltXrs/OYswy
X-Google-Smtp-Source: AGHT+IGmewfs7Z7hMZU8PX6yJD1A1tLUciTHfaok2uzXkd3Z5KcSyDLh7W6J7DdDKAmxLwZQwM+mYFOVao+8qdNwzBE=
X-Received: by 2002:a17:90a:e70f:b0:312:ea46:3e66 with SMTP id
 98e67ed59e1d1-320fbc0c07emr3096682a91.21.1754040693354; Fri, 01 Aug 2025
 02:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Su <injustsu@gmail.com>
Date: Fri, 1 Aug 2025 05:30:56 -0400
X-Gm-Features: Ac12FXzNI-qXWAC2xK8udaFzsHKNLscJPR1weWcPv3E7jP4c0zBSpjFMV8amnKI
Message-ID: <CAB=S_8+LMsSpnRWQZwK2Dj63WdcPy1vp+aJ=erDbf_aaPoU3cA@mail.gmail.com>
Subject: Fetching upstream remote fails if repo was a blobless clone
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

```
git clone --filter=blob:none git@github.com:injust/delta
cd delta/
git remote add upstream git@github.com:dandavison/delta
git fetch upstream
```

What did you expect to happen? (Expected behavior) Fetch the upstream repo

What happened instead? (Actual behavior)

```
remote: Enumerating objects: 1578, done.
remote: Counting objects: 100% (776/776), done.
remote: Compressing objects: 100% (15/15), done.
remote: Total 1578 (delta 772), reused 761 (delta 761), pack-reused 802 (from 2)
Receiving objects: 100% (1578/1578), 2.67 MiB | 5.34 MiB/s, done.
Resolving deltas: 100% (1156/1156), completed with 356 local objects.
fatal: did not receive expected object 0020d54b979cc8cf59a13406f98bfe515b190559
fatal: fetch-pack: invalid index-pack output
```

Anything else you want to add: This only happens if a blobless clone
is performed


[System Info]
git version:
git version 2.50.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.6.0
zlib: 1.2.12
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
uname: Darwin 24.5.0 Darwin Kernel Version 24.5.0: Tue Apr 22 19:53:26
PDT 2025; root:xnu-11417.121.6~2/RELEASE_X86_64 x86_64
compiler info: clang: 16.0.0 (clang-1600.0.26.6)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/fish

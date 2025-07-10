Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED528C2B8
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138457; cv=none; b=ivtYYHADsrUvX88o65m6iPzkf4/ZslaGoju9hMDQ9+UoSGVYa4QKp9Xl4da5NqKL1TutVIQ3Zh/c0H3Wwb0Vh5bpstq8vuMHbIZBS2/Ho0lUIBdyRgT5G4CUntR4izCwoJadUO2TE560XcBX8EdoSu6G1VP+Qewhkok5WqcXA+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138457; c=relaxed/simple;
	bh=giBxPU3xLe9ETI9VHZWlOHIoPsPGYhyaKulKkn+bha4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iCUf3Vnc33jSe5Ns8WeY7JGBMZRfuJJQr8sLrRVHQDh2JxRt0u0ueY8/yzCA7P/2cvlXzqv1bBCJQWaYE4wqwJ8INMdRyjWceaCMoh/R5PDQLgpqbCWaznqrvYuMiWqZN+se/Wjav9ctUvWSfesMH19eLS9BcjwL6yTqYTHLGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exon-media.com; spf=pass smtp.mailfrom=exon-media.com; dkim=pass (2048-bit key) header.d=exon-media.com header.i=@exon-media.com header.b=crKCiCHW; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exon-media.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exon-media.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exon-media.com header.i=@exon-media.com header.b="crKCiCHW"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b50f357ecso6105651fa.2
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 02:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exon-media.com; s=google; t=1752138453; x=1752743253; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8HiIpFMsT294LEFxF7gNluiHLsqdoqfUPyKTHQu5IHA=;
        b=crKCiCHW1mMnSLy2JESWRY2vXHRoTXw7iH2lhzFLlC5ErPwjVFTfB94sP8BhTEqJVh
         /kKnfAHq2VM6QDdR2eHCAf2wIqZTgMRV4XekgaKxFOfDM3oRrnlpMKmZEs8WHitXJwMe
         EkWDjkbd7pBCEel6GW92eiY0qs/M/Nd2mNyhtnT0rs0+uHgnOytvcDHg3tJMxFCPIstj
         Zi7dRaN3ZiFQcT+GXGrh1BqkRHU025Yn3x7YrIyM/HwMSiaLnpeOr4xeH4Mx33WsNnVZ
         Qa6HBu7Nml1jLtZkQ0Bj/U5xSmaqRG5j28a7NF9h03LdOe0alDf5gYDPxTevrLg1E65s
         5msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752138453; x=1752743253;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HiIpFMsT294LEFxF7gNluiHLsqdoqfUPyKTHQu5IHA=;
        b=FNH2/A8qfHRXnOSy9gCxYUGIR2/B47b/SoShgRqa6kqCd999bsRAo+vOgXRlX99A/d
         vbx1LWENAhiPcAp4bizcUPU5AE55J3Mzi76xUl3Siif11WqHYKFwmuY68faseUtE3e0Z
         NLSohTFhzkgUz4dmVP7tdSPGvkyA18ZJpwoHdL5djZXS4o9jCN+Pq3AgUSlcIg7ru1wa
         W3O0PcQSo2VwUzv6ZgTyxKKR/G1wsc1OB26qgDNpaHFl+pyiYt3709RLuE3rgwYpeXCG
         6AzEGwvHlLy/1l2bC3O/nPCiUIW9h7Al/E5Pw+MejzaKUyzW1hcJBECMcYPjMRq4vCHw
         TZHA==
X-Gm-Message-State: AOJu0Yw055mLIt1Ej+lfb9aYskxZIneiW477LhbP3fFJcmwyyrBl+5ki
	DB0yezqoDhkVtpTBdRr2kDcPV7Dj79/5wG2ZcwHpK/mmqSaszjhNzL7e9bBmN9jQc7aUc5uCCII
	d1pEtX0Fa7UOM1DFDEcfoVZ4Cpk5vwGB4aCEqehLr27gUbFJT61ikP4g6lQ==
X-Gm-Gg: ASbGncsz5BdEMoOcVF4L9/PAqUQ9/rxaROQP8FUXfAVoE6fjqNwuAM1yEcmT+OBFe9v
	UXqHMR85lqTPXD8ZW+ZkSbZrrUhxeJGw0M+6E1hp/gPfo0fjKPXw0EAP2mZIwbYpEPNP0LTv3UT
	2uq5HlE/a+N74lYA8xyJw8ivd+YxrzLgdXXn7c2GqUzw==
X-Google-Smtp-Source: AGHT+IE5ctfHWIQO5wLeaXP7/Y/xiqoaqd7YtIxQPRw69eTS5/VatMx8VUmtDDsWsOZoGXeb2mb64kLYQHhfzHwPf/o=
X-Received: by 2002:a2e:a984:0:b0:32b:8989:eb72 with SMTP id
 38308e7fff4ca-32fb2e64e03mr5586931fa.40.1752138452774; Thu, 10 Jul 2025
 02:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Oren Levi <orenl@exon-media.com>
Date: Thu, 10 Jul 2025 12:07:21 +0300
X-Gm-Features: Ac12FXykmMz77MWLdXY2-bYqcbO_Gnd2zDBZftwsBHs4aBBVpa0xrcdYdyWreIE
Message-ID: <CACpw4KCYrgjCPO6z-czSa=rW+5z5m4Xpy_RSgxEkUGdeMEvULA@mail.gmail.com>
Subject: bug: `git commit --verbose` not removing text below scissor-line
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
1. Run `git ci -a`
2. Edit COMMIT_EDITMSG (using vscode)
3. Save&Close

What did you expect to happen? (Expected behavior)
generated git commit message does not include text below the scissor-line.

What happened instead? (Actual behavior)
generated git commit message has the entire text below the
scissor-line included.

What's different between what you expected and what actually happened?
text below the scissor-line included in the generated commit message.

Anything else you want to add:
related config:
core.editor = code --wait
commit.verbose = true
alias.ci = commit

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.50.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.7.1
zlib: 1.2.12
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
uname: Darwin 24.5.0 Darwin Kernel Version 24.5.0: Tue Apr 22 19:54:25
PDT 2025; root:xnu-11417.121.6~2/RELEASE_ARM64_T6020 arm64
compiler info: clang: 17.0.0 (clang-1700.0.13.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]


-- 

________________________________

Oren Levi

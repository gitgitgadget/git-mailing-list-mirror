Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBAA3C8C73
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390480; cv=none; b=cIA6/qSMfQhIsUlXHbT14STaHulHK16PSAuypOoapsZ2I+ws2lpmzX4hRLm9pbyMbAHtalkCRTvAGk64zDCPrlKHSBXQirCcTJudMNBPuIERMdmfz2HrmTb421xEtORjIdgE6VjcSdpboPV+d9tQo2X7irbh0FNvfiBGkmzoXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390480; c=relaxed/simple;
	bh=BtYszPaUJGGMr0g2M8UFaqvfKf7V0siHw867qEt3+T8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G6MYqL15MaAduWDmmXSFUEdaEsGY4LqvPIfrqZP5/3RsStikQQ3/67gBCfRDWR6gidMe6vd/WQDndQ1vJ1aBPu1r4gkuzt9Elg06Ch/f/1On2+tFsJzqlcW2u/oQmIryT8mTUzI6TeZz5gVuO1tDyGXwEGpVQp7L/VUwjaMPDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HQeO3bgK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GS6pJ2FO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HQeO3bgK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GS6pJ2FO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 60FF57A009D
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 04:54:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 04:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1780390473; x=1780476873; bh=tnqCGMGzmM
	k0LedOwomSDdc1rKWmSNez2IgvC5EAtUA=; b=HQeO3bgKTx6xozHMsnDrz8NyZZ
	MNOZPF4wgzIwpvk21wZz3ZdeDW+eG77UfObEnG7sOtxgmhL8YrWE1wUULRjJwk0B
	JGeeVdEsSEeyKqxrkqUz9ljeR5iQ9Zo5G52SvhFfftrfOg8KJK/bzDXJELzHTjsX
	Ppg0kZUV1uJFeMqNJ/r+t5lyuVETrUgAUJhHc8+0kZDohaQiWZBGphLHlZhaQg8U
	Qt1qtc6hmsyPFQFKCzDg9vG98F/0xLxRRPYoIjY0jgg893ngSUCZbkF+DVmx4hJQ
	wH+dMXMIg2ke6BE63KvSnAktd5vENNo/lDTXyi5drYDrzF9daRhmm5qhfZrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1780390473; x=1780476873; bh=tnqCGMGzmMk0LedOwomSDdc1rKWm
	SNez2IgvC5EAtUA=; b=GS6pJ2FOEr3z8Q7Z+V/FI/n/RrJDrI3IwKI2KkQ6cptb
	ck1i7qItgIkdYIvMSX41BR7s/w0zy96vLPKVTuySERMh8QLRE+JFTqyUS/cjQ8JG
	BThu6KthXP+s3TzjBEgrJ94RUluZzUqveTfA4jhEwo9k3r1dPN8IUDRcfwshzQ+5
	xb4OrsBNHXnC1fjqm/RNc55X0vohU281OkORNSvQrcRccKP7BUd/DP5T8dYkW+r5
	ob5GzCEXNBtkyp6ALovgoMLkgLPZ8DDuM5Jpsa2DWN5wh+/c7MhfCmEyaYrlSN7S
	M7KrxEwgKN1aT5mqrZwXivpYAZ08PVOOfVBEhg++3A==
X-ME-Sender: <xms:SZoeauvt6isRBb7ANh-NCDwo7882nCh4EtX2D2TTI3ytl_cLSrs3Xg>
    <xme:SZoeaqaDDIoZpSE0u6x7VgVVr5P6Euy3ZH2vSEy-N8uNIv4ahaQwfR_g9sKTwoaDl
    DkuZsKYYPT01JkpSO1IoxkAFI-qNBX6qvhG8z4rcCvzNheOJQAcxg>
X-ME-Received: <xmr:SZoeavacxdL9vOPHFlP5KoK8Q4ekT4vC6FymLUFR3-d2HHQAHSL1gJNm3B7IjS0J8NX7Nu5dQ7PY6DifihFCAtWDUGmIepymSACZy98Niw>
X-ME-Proxy-Cause: dmFkZTF8WfOfEmNjmhaz+xdbYFJ8KJtxALnPmtJ2ar2Y981nkrjsCdClEovm4Vw96pBs2n
    hZlR1Jv9/fLmR8H18Jzi2Nt406Eer9MIcz8DHaqm+yBlq57PLg0nmglbVYcT7mnGepySkR
    8VPtmbPGy7ASKYmpcJgcxL7zDEkdlivLzxKjmd7tqP6O5oJVdOt0O2pBOrWHCYfSxxmvYZ
    ncsvT4aZft9s1wkNXypYE/w6NvN6l3I1d/oAGh1v5wzj0aij/evAmVgxGS0zOFeH3PuKx0
    KXE61imSVEhLeDASOyoyBXsnK018Mr0Pu8+II97uzntXeYKf+weDqutLDjh2sQRw+D9un3
    WR1QnKB+vKP/M9/z0uNYf8PTUW8GU/W5mYJs+RS1hU4IvZ6Tuep5jpR8gu/gE9rdJTER3i
    lV03OO+AOilJllBijGqFAUu46NedcERXXLe0mxs+pwKni0An/la9XRAlkioN11rCCBgI2U
    F/5Faaz7crELYaex7KH9TxjRYOxH128Kwr6nyVVeZYKMXSM2DGVzLvC2JOSI2RfD2BSOJY
    6zFQlOj+IVcU5X1s07mRA8cor4T0wTOZYYRiepc5zE5B35hnNaJoTPhjtGLCkoZ8IPDNJh
    ffH/3w+gCFmzFjxcWOH1uQ5b/cthj5PBMbW+mA+Qk14anFN8ZdVfWgEoia3Q
X-ME-Proxy: <xmx:SZoeauVZZrhDmzWMP9F30E4fh9fnJyvqCxFSt2Kk6vn_YsyHHc14yw>
    <xmx:SZoeau35mI4Y8FdWdq96g4OAXSz7eTqXBpttwailkegYV_MZwj4WoA>
    <xmx:SZoeatZE1NVn3Nglf52lc6GOLzH1G2vXXVQcB1L7JUIAT7OeyVmVMg>
    <xmx:SZoeapqcgNllOUxh5wLoiQVwCVXyowO7Eic_2brwqMwO8xioW9cPXA>
    <xmx:SZoeapfsaJysxack7ePUclxsj9-Bah56QaIWwYEfknle9pO0QeAIVMjT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Jun 2026 04:54:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61247a90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Jun 2026 08:54:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] t: fix broken TAP output
Date: Tue, 02 Jun 2026 10:54:26 +0200
Message-Id: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEKaHmoC/yXM0QrCMAyF4VcZuTaQVraCryJe1DXTKGylSUUYe
 /d1evnBOf8KykVY4dKtUPgjKsvc4E4djM84PxglNYMnP9BADvNb0ULvA07yRYsZl2q5GjrqU3Q
 pnNNE0O65cFv80tfb31rvLx7t6MG27dfMvZp8AAAA
X-Change-ID: 20260601-pks-t7527-fix-tap-output-105da1d73df0
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this small patch series fixes another instance of broken TAP output that
has landed via 4d11b9c218 (Merge branch 'pt/fsmonitor-linux', 2026-05-31).

As this has happened multiple times by now I decided to have a look at
whether we can fix this class of issues a bit more holistically. So this
series also contains a change that makes prove bail out when it sees
invalid TAP output, which uncovers a small set of preexisting issues in
our test suite.

Thanks!

Patrick

---
Patrick Steinhardt (4):
      t7527: fix broken TAP output
      t/test-lib: silence EBUSY errors on Windows during test cleanup
      t/lib-git-p4: silence output when killing p4d and its watchdog
      t: let prove fail when parsing invalid TAP output

 t/lib-git-p4.sh              |  3 ++-
 t/t7527-builtin-fsmonitor.sh |  7 ++++---
 t/test-lib.sh                | 10 ++++++++--
 3 files changed, 14 insertions(+), 6 deletions(-)


---
base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
change-id: 20260601-pks-t7527-fix-tap-output-105da1d73df0


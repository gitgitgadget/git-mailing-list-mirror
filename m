Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496FB1388
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763210030; cv=none; b=lIH1n8eH2R6dYENUigRJ3hnt17fs7MDUVNhJocI994Cd8zp/nmJTJK5NYllmk7u113kWCeFP4t1Ih37SkNpH8wSaCX2mFWXCb843SZ4PWw1fHk5+4QZZ4/mNOhA9haPe0eJg4i8miqyZCeayljrdls1VTVj5cZQSyUIPcTrbO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763210030; c=relaxed/simple;
	bh=yN/YQbkhKku2QQVgSPwhs85pOtQlsfQc6wWjzzbuPnA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iIDWq3FuCi7mQxru4MVCAAHQ7E5pC8p6AO3M95sy9HdPxPOvmvBhK9LNLftom2V29MCQ/Vav3iuUhU37EWvP9+40MMXt4YvmkggWsYK+LRAqKYzd1b42XvldORlBi2MkOyxw0HVxoQ8vT/0h4bRO9P/hNk9DK/1YROFiwBDR5O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMpkVf7e; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMpkVf7e"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-937268fe284so1511746241.0
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 04:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763210028; x=1763814828; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hy0vJVzjeKSP69jbKNFClFyXAeTpzpwZZRl/5ywQMgo=;
        b=lMpkVf7ecn4I7kDmUDGmERY0sG2ju9TUpXGRcgppc9osJWWje/q686jvDjHwh7jpMI
         mD5nz8vG509RayirDIzSoYJfRivdf7zLGV/NhUqvydqtvJwkatISRGXL5ed0iNn/uDFn
         mBg6Cz9xd1GgVM3VTGBp3AYx116ZGMOLKcE7oFK4kO5DG28Ua9IgZXQBI/h7ZT2aE5w+
         pxWfhZ+w95pR0Lyxwe3oceFjD5ZybDQb98URBk//MFblYENptgmYN/0zv/mmihy3uGbu
         Pw0F2dSXfCOnE1GpTJX1pc4vZGJg471gZM7Fc56o9MN/peSb+93H5ixx4S607gNMCWVd
         N2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763210028; x=1763814828;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy0vJVzjeKSP69jbKNFClFyXAeTpzpwZZRl/5ywQMgo=;
        b=dQJl+wkSe/Kz+DQmdXuSx4jIQhiN3rCa9EaptD1RMxxFUIK3jOwQ9vf4xspQz52cE3
         mfYaYd7uPcYaZge+QtRFElBT/duZHz/HDKPMUhdKzy3y7x/3060R52QHiLK31a/AYVX0
         pYUkzJopmr/5G8t+v7p0KX3d3NTRTIJ+kxGE3paZLNnnrTY9H5VG8vTGUIAyzcz3hUhS
         BmjtaT/OOeIb2denz5LKDAVTKDosvSZNzyXrw+x4sRO5nT3MSYvgftMPmG+lPjz3PTlV
         UNV9pJJ+DQADsdN4HvVQK6d603caDny1mk6s8Tzk8fMUZGznGbhgGKELamkb5C2g98jB
         DkYg==
X-Gm-Message-State: AOJu0Yy+oS6kegXfXBV/puXgVBtZxexRUixPMMDrnBjBE6oadHXprNaU
	+FutZf0ZNBgZA3/Tl+ltb8PMGqK5FrVHHRtwW8H+H72kytrm8/UNCfCw7kVpYfjq5Qqf3xQYl9r
	jeUyIQ6FXxL6wqlUVJKC1HzjYNocEiOxqu6l+
X-Gm-Gg: ASbGncuBh7zoEjywAN5TdOSRrSswq7ALuzqQIrX4HfISgxD1Tawz41Wk+9Iw4jjtDAx
	Bm4TtmErK6sfiawnggRRpvbRccvkKFebHaWmKCWZTF498a82CnAv+gsazqniOkEN7Iela8bBsDo
	sGGtN24rNyAgHaND7wpYdcuIuG493y3/6czf9E7QlVnGtMd3M15d7UMbcCr51sMKXwyGD6j0MBV
	cqTql3KhBFuJ4Og+gBzg3fJviO6pZy0bSrl0MCxTeYpYgSAz6mXj+OO/16meCUddbMUOEY=
X-Google-Smtp-Source: AGHT+IFc1co8+nbqmEOXbRu3P/GM2HiS1GDsS4HOF37BK3mdyGtGQ9meioGB+eTEtxCA9QbVCGFi7R0stM780WGbqdw=
X-Received: by 2002:a05:6102:cd1:b0:520:dbc0:6ac4 with SMTP id
 ada2fe7eead31-5dfc5503207mr2587301137.2.1763210028078; Sat, 15 Nov 2025
 04:33:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: BhaaL <bhaalsen@gmail.com>
Date: Sat, 15 Nov 2025 13:33:36 +0100
X-Gm-Features: AWmQ_bn-q19ZtiDHsn3o6OV9siRgW_F0moEKz8o5XqAfDtmQIs8Bpcb0zT1QOTY
Message-ID: <CAJESqkrv9RmimXn+6SUhRhih3qEsp_MQk0+BH2FZsFX-_uD1oA@mail.gmail.com>
Subject: Ref list fails to load in gitk when stale tracking reference exists
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Open gitk and use F2 to list refs while remote-merged branch is in view
that still exists locally (and has a tracking reference in .git/config).

What did you expect to happen? (Expected behavior)
The list of refs opens, so I can see reachable tags.

What happened instead? (Actual behavior)
An error pops up, dismissing it leaves the list of refs empty.

What's different between what you expected and what actually happened?
This error message:
---------
can't read "headids(remotes/origin/testing)": no such element in array
can't read "headids(remotes/origin/testing)": no such element in array
    while executing
"commitinview $headids($upstreamofref($n)) $curview"
    (procedure "refill_reflist" line 16)
    invoked from within
"refill_reflist"
    (procedure "showrefs" line 44)
    invoked from within
"showrefs"
    (command bound to event)
---------

remotes/origin/testing is a branch that existed upstream, but was
since merged and deleted.
The local one still exists (pending deletion/cleanup), but has a
tracking reference
in .git/config:
---------
[branch "testing"]
    remote = origin
    rebase = true
    merge = refs/heads/testing
---------

Anything else you want to add:
This wasn't the case with an earlier version of Git on a decommissioned machine.
git version 2.42.0.windows.2 is known good (but 2 years old).

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.51.0.windows.1
cpu: x86_64
built from commit: 4d21a77b98af5cf479d8b6f863c2aa94257cd4e1
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.15.0
OpenSSL: OpenSSL 3.2.4 11 Feb 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 26100
compiler info: gnuc: 15.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]

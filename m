Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1099283680
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759489534; cv=none; b=oMi7tZws4YMZ9QSGJW/h2iSf1I3jyCQOd/nQfG9rO44hqHNZPVaX7EtYtySg1E0QeE38qCCO63ZcYuCqMrJLIEhqIExsl/9AFOsRLbOF3SSM1V4X7YngbTkr/cEoaYqiQi804azzgj38JTQ/w/BR83HDAMqR8Mj7Usmim5gjKes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759489534; c=relaxed/simple;
	bh=Y4gorFfgMR/2mEaW357+PfSO4MrjeERVTaZqLIIKysQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XpkYIBkKgdXW3UCl/XQR72xh5Owg7TG2fivrmj0M3EBrJM0cnP3OG/kpFg+va84nEwiCF8iKrb5epncy2J9M7DdEk0OrXOmdxYf9chQtcYjTGPuap7LOFP1QIpx28mwagX7kOF9SZFFSlFSSTNhkz+k19ueS2qZ1qrsPU3axxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH7oShry; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH7oShry"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3717780ea70so22432731fa.1
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759489529; x=1760094329; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E61p/M3e5HQw/peyKJaXD1uBmBBjBy5zB3Go05kCKsI=;
        b=SH7oShryBi6Z30aIb7BZXde6XmzJdE5BxEuPF4skF9q401EF4nFz6JUfVTygYKIECU
         OOyFp+kygTeXb54ElRpapCUWo64mSB/nD2bUMfR+GesZSY2j6wti6YROi7kMg2GUMBKf
         kgV1v71Vt4aTaOpmcolJzMMKCE/hPyYszMki63J5IfbpH/52+SIQy4J1N4W6Vmua7l6a
         mmd8xEgjMcPqKUa0s/UoHefgXvzd+x8/XCKKzG/2/2U9npf2E8VfLTTlE84MpV48hsYv
         Fy5mTLmO40ivmavzMOAKGKoRYOGX8V+9yOrmfkWe49lEithBOfBje8zs1PVMHaUJOroO
         1M6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759489529; x=1760094329;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E61p/M3e5HQw/peyKJaXD1uBmBBjBy5zB3Go05kCKsI=;
        b=c+r/q+gkz7NE04/M009PZq28WQ6dKS8J8+frC4TfAKZMFRF1AXtU0QPhbM6nTXo8Ok
         RUhOXXuNa8Bg0kY2XFX71MBLfzbtkYBItXFrq+ZH7liGolry4EYa2bd5XL0acRPMiGYm
         ur5eA8EnMhVokOGanGHDrBHqgR+wqCcaZUvL7jSFTgJ9m76hOb7Oud3oUtNfiGsTNCa3
         RhDRf1wAJnunJuc+Kc6xSobOfRGQJz5YOJsFD40R07GCJuILSSstu86hDXudCvEzy5rk
         6dyr1F2nEpfU638J0g1jUOfgNt9C8JglFtX+oRkTOSPnTvmz52HglYoaj6Xf9KeRjb7h
         HLdw==
X-Gm-Message-State: AOJu0YyswTlDUVeRJCJYgH+Dti4iR+HpZc2SkJuugprIhcdh1BFNempq
	P+ViFhri/pXcrx/JWze1flE2JSZdD5M7FWThIuSTWcOmXiv+DXjrpXQilvRjX2A2bsHXDHtHjW6
	F3hnelX5g+HMrldIv8itxEudyzLX6atEjFfEUQUybfg==
X-Gm-Gg: ASbGncsmc35dw3kYukKd0KZiWbV7TxOP0x5M5QmXYPpwpnprBKmKUUpxctBpwioioK+
	jM4KwHvFKwm1XXcaEceiZDOu1je4dfOHhIAXkWbC7nvkjzt2le2Kyn3tYNA3o6N/LLO3TauKoTS
	3AhlwkpnbCb6RF7zlZwGv8TgY6DCpDzL1Vg4jhLz5aOVhZYuV/VtO+82aTd30MZzhkdGdqRVs6e
	0S84woenULKNK3kHH3bd64nbQUD
X-Google-Smtp-Source: AGHT+IFUKf7LLni/R929f6ymnRZ6sjSbQRgglN9UCwKWYaJ3ozCwTUXzyH7h2OMLrX6rz+1oLThe+jbaDGDKSbCaQEg=
X-Received: by 2002:a05:651c:220a:b0:372:932f:4656 with SMTP id
 38308e7fff4ca-374c37d620emr8066871fa.29.1759489529044; Fri, 03 Oct 2025
 04:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Devste Devste <devstemail@gmail.com>
Date: Fri, 3 Oct 2025 13:05:17 +0200
X-Gm-Features: AS18NWB8tFmWjdrsOv8XFeGZXN3Nmid6GKg0bKQiwDKLebVmTrXlP2zEEXvGIwY
Message-ID: <CANM0SV3+4k5tsgRw0g8-HoVSFGb1AwZr+2hCUXLriFGSd33WQQ@mail.gmail.com>
Subject: Untracked files cache not used when --untracked-files is used
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am using:
git version 2.51.0.windows.1

Run:
time git status --untracked-files

I get:
It took 2.75 seconds to enumerate untracked files,
but the results were cached, and subsequent runs may be faster.
See 'git help status' for information on how to improve this.

real    0m2.959s
user    0m0.000s
sys     0m0.000s

---

when I run it again, I get the same thing again

However, when I run it again WITHOUT --untracked-files its much faster now:
real    0m0.753s
user    0m0.000s
sys     0m0.015s

which means that the untracked cache does work (bc deleting the
untracked cache, it will be slow and also show the message)
per the docs:
>When -u option is not used, untracked files and directories are shown (i.e. the same as specifying normal)

Which I can confirm also with:
git update-index --test-untracked-cache
>Testing mtime in 'C:/Foo/bar' ...... OK

It seems that using --untracked-files(=all) causes it to either not
use the untracked files cache (or untracked files are not stored in
the untracked files cache if they are in an untracked directory?)
Since various tools and IDEs use that hardcoded, fixing this would be
a massive performance boost for many users

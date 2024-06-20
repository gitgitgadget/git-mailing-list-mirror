Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCEA1A8C08
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889398; cv=none; b=t9n+5e9X2VURa2zEP7sIZfwD6BLEi1TWRhA5Z23BI1B3VBzN/N5XXD1bKsAPWX4mQZ3vP5X03Ym6hXoebj9suSubdeJCfK+oqApLPc34uAR0QuJdS+1oIaWf8H5u246KrQasDXcvsw6V7cpr5daWb0jQALm6q0b1BwHG/oBmiSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889398; c=relaxed/simple;
	bh=eSoQX+ArfGODFG0AJu2h8dJE0cnG5VG0OZZ9BkwjJ+s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Id8HzTUGbPC6Qja4fJ3ESX1uF/XyS07BpqUM0EgufoVKewvuLWIzimG7v/FYffyhrCdRwWCjWLB46E9U6ddtK8zSXkUcTZUYLS2IS0HFWNutkHMc5NRFDlSWWG6D6H37iCQZYgyDAr0xBxEpKpq5o5Frktfz4Y8jFXG30V/K4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic+mcEUp; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic+mcEUp"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso614372a12.3
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718889396; x=1719494196; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TnNXHArYCqGPD4YU70AJZeqmRKdqgeEPY9kXl//mbQw=;
        b=Ic+mcEUpRfNU14rJpFyfh/Yvrugaa5vplhQY6MUFG28HMcszzodzjrq1oZMljSS1/G
         i11e2AsHhyw+XZa/Yl6WxcmYHvW7sNVqM6OvN+Uo+N9/NPRiGwpDIsPRE1TOa/pxpjST
         OIzLloI4KB6t4AhKGmhcaqwJe7ioppAc6PUll6w07dGz7lqzTUVDIMCWiQcT/9BuMwxN
         3hjv2vuafD0s/qheQeUJhmTK9bdFQqzEv4pzgWODPyyIiyH1iqCWAFc3jDiE4L9QKcG8
         0AYk0qPvIXf6sKZ/d9c09fEFIELZbPXjsXlwsSvFum6VFfyEzIKaYsjSNGR2GVp3cW98
         ciDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718889396; x=1719494196;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TnNXHArYCqGPD4YU70AJZeqmRKdqgeEPY9kXl//mbQw=;
        b=Ncr+jxfZod2jHVPAC1oeKlQOpeW7uWf/0NiHUGDf7eCtT0erKxYMz7afx4XkvNSaj+
         6Pbeo+Obkth+HbWJya8rva/f7nI0HW3XGXONP/RWDQOuD8VzcFrhlIhA2o1UkMvh2mjg
         tt768j0GPqq9X2o8ctqlXoKEOeP69fWW1TNzjwlPfXooGjh2Jzg5oCTQg9kRvYX0dX6K
         Ih6GQPqi18k90cYNbNxsyUNim3CBCNfv7GwcDwfSWRxjjrJ9aLyfuphAQTJ6jpvwraLx
         c9A1w+3EYqm3adB550uoS9F46vBONYDB+gK/kzMVjcQl8jNoAtd/Oxj4yKBdekor9HBL
         CskA==
X-Gm-Message-State: AOJu0YzjT3gIdrbPlKHdzpI+IA8vjuuT6BMwEGt2j/Edts4suT+x44yw
	lzcTkNIo+W5iY3trQHmgsxcOhT0KvCGWqdK8xkURV+nn7ZiIRFokNyuV+jIFzcdEtoB2htQnc9+
	59ldbjp4xMGqm64yirz141jsWBDjcx5SlhXU=
X-Google-Smtp-Source: AGHT+IEh4meVkfrXwPQUUtfP7B4lKWmN156odtSPOyoD9uOZq0UyUXuVBR6dZJcbWudoU5jdkx17BkJw8kZCz4VgQ2Y=
X-Received: by 2002:a17:90a:c287:b0:2c7:e:6f1f with SMTP id
 98e67ed59e1d1-2c7b59f8f02mr5075719a91.10.1718889395659; Thu, 20 Jun 2024
 06:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Thu, 20 Jun 2024 18:45:57 +0530
Message-ID: <CAG=Um+0LXVRHmvKdTB9WHJujjh9agK_ZHdv45ffzMsqX65NLVw@mail.gmail.com>
Subject: Bug: Git Maintenance does not register multiple repos
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When I run =E2=80=94 `git maintenance register` to register a particular
repository for maintenance,
it appends a new entry to `~/.gitconfig` with the repo name.

```
[maintenance]
       repo =3D /path/to/repo-1
       repo =3D /path/to/repo-2
```

Now, since git uses the INI format for these files, this would imply that
repo-2 actually overrides repo 1 for maintenance.

This implies that a user can only register a single repository on
their system for
maintenance.

What did you expect to happen? (Expected behavior)
I expected that multiple repositories on the system could be setup for
maintenance using this command.
Which would mean, the `repo` filed would be an array.

```
[maintenance]
       repo[] =3D /path/to/repo-1
       repo[] =3D /path/to/repo-2
```
What happened instead? (Actual behavior)
It appended an entry with the same key, which would mean only the last
key wins, and a user cannot have
multiple repos as a part of maintenance.

What's different between what you expected and what actually happened?
Mentioned earlier.

Anything else you want to add:
No.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.3 (Apple Git-146)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.5.0 Darwin Kernel Version 23.5.0: Wed May  1 20:12:58
PDT 2024; root:xnu-10063.121.3~5/RELEASE_ARM64_T6000 arm64
compiler info: clang: 15.0.0 (clang-1500.3.9.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /opt/homebrew/bin/fish


[Enabled Hooks]
post-checkout
post-commit
post-merge
pre-push

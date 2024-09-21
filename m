Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD93518EBF
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726892802; cv=none; b=XC5wh+DCtzkQq+a2x90bZMta5Iiuzu0sSW6QWsBVWb4L3ucy+zcJHs++1SpPUv3rec9LcqsoZDjNSDxXg/2C0ET/scHxbz3yslHnUxaK8KDLzleoOAaQzrkA8RNewIZTe/7lcb3bO0/n02dAf6LzYRFsN1oNNvEayYWv8AkzssQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726892802; c=relaxed/simple;
	bh=320CtvGb49yawoBa35TJrmc+nlqRcED0CnBVD7pymDY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PcUB0ZwEO2vLxfxB4LbRABL4UCx/LqkFE/BblW1t94GFRUKG9qb6DV9FaUFCe+KHA3WVJ3TPFpUp6rR0PLnVFUG69z2/5tySCtC6ln4WLW6MBbxXOYn13VLoL6pnbUfpKGucLa3ObXcZmb1DDp7uz6hZMhU0k8Xm3rtV1+G66Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7333+Hu; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7333+Hu"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53661ac5ba1so2865938e87.2
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 21:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726892799; x=1727497599; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e0K5Zac9n50a/+MtWeUqnk2goMw9jJMWH20GQfcqOwo=;
        b=A7333+Hu+WkVCmnN1K7q1Ozlz8YiWXV5l6kOvv2Hoc8MAofoDfOuHF4JeEF4FJBi8L
         Y5kOAAxKC/OV39nLrbL7yLWrLyejJ5+3sMISmfGfwE5/nbrbxw5q8M1rqTiTmYevfME4
         QxnCNXh0lyzxC73g/BNiC+c/5PuRsy0syQvJDEsR4Ccyz+rWt8C86Sv8W0gSJpTYQIdw
         WgMS5ByrOZbrCDjRapZlDYkzT4EzIINuGw8QZE7/NVXtxnkcNkZw0xaUmPhPb2rUBwdu
         9Zj4dHeGh63z4iQkWbj/DwDV9JHeiN1jVw5YaXAKlJtNECAW4wsyARcAkfWd22odH4ij
         8+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726892799; x=1727497599;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0K5Zac9n50a/+MtWeUqnk2goMw9jJMWH20GQfcqOwo=;
        b=FA4FrAey4kFFzReuswyo70f18RlQl9U4932EQeqzPO5ENksfNh0pUC5Wz4Qc5PgkY3
         kLfk19rgm0PYCYD++P5tbnpCp1bMtMhQ086z+tr/yL9svJCsyvA0flsVnyVtHDkajyT/
         zaWTnZtOwUGI4zdSQ0J6XjsJEclMpKBPS39CE8z0sX1AK8/m7/3SUBu/WbraXpBZD8JI
         chCXb4Cg7kxTvNkBbGlxVvMaU725ifwL6DKWYQcnHGxP9GhDUELnEFu725r0aDS2tAyK
         K3Iv3PWlI2eLMBbv9/sYPnFzZgAlM8UhOmRo0XZJiEQnZuyc/iAf43xGUWenzD4Mt1E4
         TORw==
X-Gm-Message-State: AOJu0YzLhIf6PT8lMROj58u1IS5EH5ucJB1L5ZD2ImBj7Ovw8baVzcbf
	erWlcfb3LYbeD4RQ29ZGmtCgZwtXrQlew4YbwlqT0HkbtCMQ523okqd8xA6D6bl02n6QcfSj/MF
	Xi2RshaLJylYQQVes02sekJcapGtj5VjY
X-Google-Smtp-Source: AGHT+IH6PCax+KjmxUry0a40Gr72IXXHH0Pc/KYn/nh4468LhAioLXTunBa8zNaexkA7uulec7UNvDmrm5qqjWX3H6E=
X-Received: by 2002:a05:6512:1386:b0:530:ea2b:1a92 with SMTP id
 2adb3069b0e04-536ac31efdcmr2652746e87.43.1726892798453; Fri, 20 Sep 2024
 21:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kohei Shibata <shiba200712@gmail.com>
Date: Sat, 21 Sep 2024 13:26:27 +0900
Message-ID: <CACpkL8WsNqhQ7SP27-XQwp1bzKjyUT6m2idFarZ2Z5rLVYg4pQ@mail.gmail.com>
Subject: git diff --exit-code returns 0 when binary files differ
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I've encountered an issue with `git diff --exit-code` where it returns
0 for binary files that have actual changes.

> What did you do before the bug happened? (Steps to reproduce your issue)

1. Initialize a new git repository:
```
git init
```

2. Create a binary file and commit it:
```
echo '*.bin binary' > .gitattributes
dd if=/dev/urandom of=a.bin bs=32 count=1
git add .
git commit -m 'commit'
```

3. Modify the binary file:
```
echo a > a.bin
git diff --exit-code  # says "Binary files a/a.bin and b/a.bin differ"
echo $?               # returns 0
```

> What did you expect to happen? (Expected behavior)

`git diff --exit-code` should exit with 1

> What happened instead? (Actual behavior)

`git diff --exit-code` returns 0 even when the binary file is modified.

> Anything else you want to add:

I could not find the exact condition to change exit code. In some
cases, depending on the content of the file, `git diff --exit-code`
does return 1 as expected.
I don't use an external diff tool.


[System Info]
git version:
git version 2.46.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 7.68.0
zlib: 1.2.11
uname: Linux 5.15.153.1-microsoft-standard-WSL2 #1 SMP Fri Mar 29
23:14:13 UTC 2024 x86_64
compiler info: gnuc: 9.4
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]


Best regards,
Kohei

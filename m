Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C781B12E1
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366649; cv=none; b=roo/yThTqFmrjfaSAK4DQL7kdckQB1LUkJo16RcrZ5/eBUe0lCT904GASmu9QDRY6qmufU9rDG4otgPKrJVcFtReLDt4yNUwPC6rPIg2eAbjbDxfJeC0jW8gp6fZfpVDZiDD6D7NE1rWWUjgWgjA009/qptpE+qsYCj38Va4RBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366649; c=relaxed/simple;
	bh=oajxbpTRd9V/m/nMpeoE3y2DzH/zivynxDehoMmG5TE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LNicRPVWBmnXFgdWftWccE5MwpJbuh+7N19G/awgzi5EEiM50wzsyYwKvNB2qT36iWr1N8YRJHflVcvDjRXYhkCqUsaqRMzZv5uX9zqLxwwU5UJSVzPP+qSWQn8SA+0e9YpXRf0Wvh/aW6UyBkC5jxBV7CPsV6wg2F8VVCzrxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QirOqTdP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QirOqTdP"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-714187df604so3624717b3a.1
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725366647; x=1725971447; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oajxbpTRd9V/m/nMpeoE3y2DzH/zivynxDehoMmG5TE=;
        b=QirOqTdPy7DGM608F/g34Js18IpT8i6NmRWPLTtbTNL97xpkFStINkip61GBfVWxRO
         dy7OzYZfDemckw1eMATtWN02dE0ii0VYeronBrjojDpGAs8qZ/U0z4/k38bWClebs5KD
         a3XARBtiH4BH2S8r+qaj3v4+UM7LsMGbjz1sk52uJKlKDrQjycdYS77yes9OnwwwsYyL
         PhsapVJzh0CycKoHVSpqgqjXMoqjaEL5sExKpvsOW6Il3629gtTCNfnZbrjuAQSNgSzp
         UpnujgHeFPhD/uRiDDeUtExhpQEvm0c0+uuwc59ljQKI4XAPWwI6j09qMuHvTDryf59r
         mznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725366647; x=1725971447;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oajxbpTRd9V/m/nMpeoE3y2DzH/zivynxDehoMmG5TE=;
        b=Eb3VIMM/tFw+VOKM6c/gj8XqbHJDinbLQzfwBobEJX5I6lNRC6pqQUkoUcj3BjL02G
         0VtqSaOdXLeo1sU6nwpjFZbjLiLYUwuWiEcl0IITA3OIAXBdIkc0SPYrL4hMkWv/gDXz
         ZQVT8YOEU4vDz8OE0tEv+zBv639YpBTASs/QAusEBbq75Kk0J3GyWP4Js++t7MNd06Wf
         CRkXI24p4B1T0kJhQOkC8gbVrkM1C7HiQzPY/Wr22j5gfTNIdiYi045zgGFE7mRZ3WiX
         9E6SMK9X1yd0sfYkW8CheStqsaG1PeDGsj2lKL8UZW5Ow2+bxO5/SUPhquz40jsqaI2f
         ZPbA==
X-Gm-Message-State: AOJu0Yz5z2yl/6h9RCtetSISZb4nmgMp4e9L5GryCTzPxKJd/Igukomy
	oMprs3PHGKm53ZrVus8lJAYpTLS1cOAL0JX6M/nwigarOQXjUzokg8cga+7CC8rzg2dztjFc49q
	CplX+ndb6pYW4V2w93Xoy1+IJ47+OtMeM
X-Google-Smtp-Source: AGHT+IEjCwQGzHAxUGRlntQDfXQi1OKQ1L1TQsP6vB24/2ypZMb6A1HlKGh6IPM1eGKRQmhYr+vbvUYo0k3m+l87urM=
X-Received: by 2002:a17:902:c405:b0:1fb:7654:4a40 with SMTP id
 d9443c01a7336-20527a5e64cmr234923595ad.14.1725366647030; Tue, 03 Sep 2024
 05:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6auY5qmL5YWoIChUYW1vKQ==?= <ttakah@gmail.com>
Date: Tue, 3 Sep 2024 21:30:35 +0900
Message-ID: <CABiJAjbEpYkcrxj82uQ=O27tR9fKoUFH0=MOCobDfa9cWsbdAA@mail.gmail.com>
Subject: word-diff-regex=. sometimes ignores newlines
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

mkdir test
cd test
git init

cat >a.txt <<EOF
NRZ /NZRQ/NBRQ/
NRZ(C) /NZRCQ/
NRZ(M) /NZRMQ/
EOF

git add a.txt
git commit -m 1

cat >a.txt <<EOF
NRZ /NZRMQ/NZRCQ/NZRQ/NBRQ/
EOF

git diff --word-diff-regex=.


What did you expect to happen? (Expected behavior)

diff --git a/a.txt b/a.txt
index 278ea76..7e6f42f 100644
--- a/a.txt
+++ b/a.txt
@@ -1,3 +1 @@
NRZ /NZR{+M+}Q/N[-BRQ/-]{+ZRCQ/NZRQ/NBRQ/+}
[-NRZ(C) /NZRCQ/-]
[-NRZ(M) /NZRMQ/-]

or anything whose hunk has three lines


What happened instead? (Actual behavior)

diff --git a/a.txt b/a.txt
index 278ea76..7e6f42f 100644
--- a/a.txt
+++ b/a.txt
@@ -1,3 +1 @@
NRZ /NZR{+M+}Q/N[-BRQ/-]
[-NRZ(C) /N-]ZRCQ/N[-R-]Z[-(M) -]{+RQ+}/N[-Z-]{+B+}R[-M-]Q/



What's different between what you expected and what actually happened?

some newlines are ignored
and the length of the hunk is wrong;
git says "@@ -1,3 +1 @@" but the hunk has only 2 lines



Anything else you want to add:

this may be clearer with --word-diff=porcelain
because it doesn't emit enough number of "~"s


```
$ git diff --word-diff-regex=. --word-diff=porcelain
diff --git a/a.txt b/a.txt
index 278ea76..7e6f42f 100644
--- a/a.txt
+++ b/a.txt
@@ -1,3 +1 @@
 NRZ /NZR
+M
 Q/N
-BRQ/
~
-NRZ(C) /N
 ZRCQ/N
-R
 Z
-(M)
+RQ
 /N
-Z
+B
 R
-M
 Q/
~
```

this should emit 3 tildes




Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.0
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

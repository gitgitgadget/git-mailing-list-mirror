Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D9D233714
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578341; cv=none; b=CY6fG+oqb14hTuqRhBFIHFxj86mJMHaNcR+64Yn8AUZ/cXGLL/cLhj/52IJzbFcGKNGS+JmpSvcsDBbFKlQWg7mCsTIOSpJ8Ct95xeQD0yWSNwG9nXEA5OjhrLA/lr03yjR+aWUkFgX559FEy24AUkHDwfZiFDStOfXI4R/O0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578341; c=relaxed/simple;
	bh=8YbPu/FKwdM7IgizCTpr812wLR1t6b0UbMz9fP5cHVw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=M2ZcyXbIOw30Ce0JzJJzYiSyigYonIiZnFqMWzbFDHKkDqoC+XEqmkQ4WkwYRQPZkL0e0Ybg/WFIx2ngng1XsLVRUBTbPzbYQPzCY4eyzBZOak0eufPmRhDp5FDK8hVmSe3pJcKfqdcbgEhyJ4hu22FTH1iX/Tgws2ytelPjVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtRxVLgv; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtRxVLgv"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-399737f4fa4so3187489f8f.0
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 00:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743578336; x=1744183136; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4OxW7O7UumUkrTS+EgCI+kRh3PN6fGvmKpDb9hY9m10=;
        b=ZtRxVLgvsHZR4l/axDiBnIZ6oJlb+fCb5YB1BneNY0HwvlNLdIkcSUASG3XVaqMn7a
         oRO/p6cnHpuRecF60g42AIlxeDHvj7kha/W8Llrr11HBywZpxzc6e8ekq0NxmhKxpS0P
         +vRSphovcU7LCcBrWmGU8ymp824/1Ie5ALk3rQEZwdFYOtQOM9uw3C1omD/iG6cS0Hob
         1QClLq9VJcOsbRqaBcugCSrV8KwuTjUvrO2LBKKdmSGaaCqxh8dor0pC6m9zk7uyv8/r
         WX8ODTunE4M1AJkVdZVuA55J+r2n1M3fARj7MDNLurYTrzxPDESzIjwfYi9eDHwleRV0
         9dlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743578336; x=1744183136;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4OxW7O7UumUkrTS+EgCI+kRh3PN6fGvmKpDb9hY9m10=;
        b=d7XD4vv5oPCKg2T1y5GZRAhZnCVlqb3sB843nPs2SRXTkNGeCo2ylRlFFeonEZduzx
         vZTCYYYEprdwir7xfLvcepPSFf1m5qx6TABrDxqUYUPvKOI25/+eE0ECM/ina5XflhJf
         tF3dKkxg5V+4WtddstITd/YH8JO9Xt2SwabxQuwBQHvB0Vs2+nbXzc7eBG/1VoItDctu
         ad7rpF15BuoDU0BxwIJ5sOZLyCWK/l7vWJ0rkyzpb7cMummj5XoEWMp/y3VwvVwDBjKp
         YI5zS5ziRmtBj9eKJpJ2MO9nHJruOXEfcmakCwqEUYR4qlCxva2f680+I0Or1hQaIDx0
         DdPA==
X-Gm-Message-State: AOJu0YxhSaqXgeHxnyfBzp6+yn/pjBo2RKsEj3NSAeQ46ijZhdztCN0b
	5UQ0rxwmfQuydQ1LoyZ6sNXta37LRq2evqbi7l8SBMPfkuOaocm4Df/Xw1aDQ4PxJoxxLQx4qYU
	/wTcBb9sf0gR8Q0Kg8cjhrcdpUeWCfuFHAZ7OL8LH
X-Gm-Gg: ASbGncuXBhp7dAdHz2dqbhpAF6785eL37Y8MZEqrnCbC44OxOrYBcugsV03SHomuCOT
	i4ksWIYB8EL03/kCENOYrdz6sDo/BaYcqWxZVVbX/uH7GdShoTxgdI3/Y5HGRdKOdvjqZX4564T
	//pBNWN1m1xfNfka4AJTM4ZHEPaw==
X-Google-Smtp-Source: AGHT+IFECTjZNq8Z/D40y95wbKFjbVKHKO5dP3y/Mvu+wy+jrfQRITkg/aeezOUATnKdXe/salr9KDJPrxXStcN+Lg4=
X-Received: by 2002:a05:6000:400c:b0:39a:c8a8:4fdc with SMTP id
 ffacd0b85a97d-39c120de150mr13173978f8f.16.1743578336501; Wed, 02 Apr 2025
 00:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrej Zhilenkov <azhilenkov@gmail.com>
Date: Wed, 2 Apr 2025 12:18:45 +0500
X-Gm-Features: AQ5f1JrGTRGxZtzVXu02l5fIB2sXzesjrB714VBNRat6yzgcJytQAGfyC7WbCnU
Message-ID: <CAArAzAoU9qDj+yLi3pA6wFYdTAk0UvQk4omSWM1RL4D9w5fw_w@mail.gmail.com>
Subject: Update symlinks after changing core.symlinks
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello! Is there a direct way to update symlinks in repo after changing
core.symlinks?
E.g. update plain files, if it was false, with symlinks or vice versa.

I've tried `checkout` and `reset` but they have no effect in this case
(see the snippet below). The only two things that are working:
- checking out a commit before the symlink was introduced and then
checking out any commit after (need to know that special commit to
make it work for those specific symlinks, not practical)
- removing symlinked files and checking them out specifically (need to
either have a list or somehow search for those files to reset)

Is this the way to do it or is there an alternative?

Snippet output:
```
Using temporary directory: /tmp/tmp.gynGH2VcB1
Checking symlink status after creation:
lrwxrwxrwx 1 root root 12 Apr  2 07:12 symlink.txt -> original.txt
Checking symlink status after checkout:
lrwxrwxrwx 1 root root 12 Apr  2 07:12 symlink.txt -> original.txt
Checking symlink status after reset:
lrwxrwxrwx 1 root root 12 Apr  2 07:12 symlink.txt -> original.txt
Checking symlink status after removal and checkout:
-rw-r--r-- 1 root root 12 Apr  2 07:12 symlink.txt
```

Snippet:
```
%%shell
set -e

# Create a temporary directory
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"
echo "Using temporary directory: $TMP_DIR"

# Initialize a new Git repository
git init -q
git config user.name "Test User"
git config user.email "test@example.com"

# Create and commit a regular file
echo "Hello World" > original.txt
git add original.txt
git commit -qm "Add original file"

# Add a symlink to the original file and commit
ln -s original.txt symlink.txt
git add symlink.txt
git commit -qm "Add symlink to original file"

echo "Checking symlink status after creation:"
ls -l symlink.txt

# Ensure core.symlinks is set to false
git config core.symlinks false

# Checkout just the symlink file from the master branch
git checkout -- symlink.txt
echo "Checking symlink status after checkout:"
ls -l symlink.txt

# Try resetting just the symlink file
git reset -- symlink.txt
echo "Checking symlink status after reset:"
ls -l symlink.txt

# Remove the symlink and re-checkout it
rm symlink.txt
echo "Checking symlink status after removal and checkout:"
git checkout -- symlink.txt
ls -l symlink.txt

# Cleanup
cd ..
rm -rf "$TMP_DIR"
```

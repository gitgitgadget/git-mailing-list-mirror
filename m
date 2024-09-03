Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E11EC00C
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405146; cv=none; b=E0T9RcDBmx55Cck3P75J2KTiRYWZbzOSaWU/5UfOKMQLDzj+0M1kbgt5Fot9tSoDEHHAribOppIhnwOd+pEnHgC4kiHaN9w1WJ3DlyW79lqdFc2aYqaWPmRZgpTgZTwfnlNJslnvSpfkAO0h5xYbpW5hwfq+OCtNA1f8gUuDk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405146; c=relaxed/simple;
	bh=cP/hWc6KTeI2fd9tXG9bZNMAApZEaCZAQ0AqvZv6wbI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=T31BnrKhKSVA5qZlabwBEZwReEXcqhRoO4aHrfjFM54GHzpYP7VGUWxAF+TqCCX9p7HMtA6xfHsKdcTODD/1kX8zJeUKrXQ3HEpzSm/cMMUa27Cw7d1a5Q7SW7m/RWhCqSxh6N3vrD5zP2yuYrRo50h8EY5JmmobIlXOtFwCH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg3ORJp3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg3ORJp3"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c27067b860so1239881a12.1
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 16:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725405143; x=1726009943; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b0mB05rgb1ZeMEivju5Qc0dKjss1hPCKFR2XmQbIAoI=;
        b=Mg3ORJp3RUnwCvob283V1ldlk8jtDVub8le2pD4DBZ1+P3W/NArNlWIf07SZHqXmMm
         JaNYuKI2fOUsmnU97CT0ZwbCFTXl4D1C2XdFWcfHfnE2Iyh3TGv7i8m+GP2X8RUf4mL8
         acD24tF1Gu1NxZGufVmY+ePf+epZZKA4nALWA7/huQLBGMqmp70Ov2T/4dcs7XGVn8ij
         LSSRk36pdhqXS2Nthdb1JN1qyTXXS8nPLTnjZ/32eSAOCcAse2C7EaQHPvl/somRMQfl
         hwgAbDSkjmYS2+5cB0AJNhk2ZWBrfw33NApx9ogdmXLNX4jER3ISp/3x42iUqlCwTUpD
         om5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725405143; x=1726009943;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0mB05rgb1ZeMEivju5Qc0dKjss1hPCKFR2XmQbIAoI=;
        b=mGRRBNnBmq2BZt17UdQ16g4/mJXLfgYZx8IvDQtPuFktvmXR/u/6wo9JJzbhYG16l2
         GlBX0gaS7Kuc9t81eZw9zYArwYRdtZgXT0E5n9R+/4dmRIpgW9Jd/XSlCQKJKlI6JK4e
         1Qoeuufs5savPPdJsFzSLtj00uljTdGb/DSDqZ7LqpIH3i7QfK2WdzLyt60TkFyjf9kx
         RfsjrtVeLpyKlaMGv8c17l1t/E6chbntSC6069rPpp3tq5s6/v1nDlYlEST6EIkmrISV
         H4J8YkIcZ3sLVaz7voSwlLNNTP1OLLOB9/2sqA4UAmWbRVvv+aoeq4hPziUUu4TXFtv/
         JRMQ==
X-Gm-Message-State: AOJu0YyoO/J9szxTNPpx4SkGoitTHoAug6Q4LZrhpIHNV4R2UcpqSfoM
	b/+43Jy10kWXieKVXPEJZl6qqVFHvGKRnJXFjgh9F33VRTgTzzu/xDB+IUnZNslRZnEm9P17DBF
	VGENvdh4YaI6L7sLyWLajgGAvhPVP1bhO
X-Google-Smtp-Source: AGHT+IEhZrE7rIKUHQz6uq4n40zC3Ud7HSRS0EVzcTsUw2e/1WFUWNGE2tEQAVndahObGoax9hRZwe7psN+DYMiTYG8=
X-Received: by 2002:a17:907:2d9e:b0:a7a:a960:99ee with SMTP id
 a640c23a62f3a-a8a1d3268b8mr342629666b.32.1725405142945; Tue, 03 Sep 2024
 16:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Wed, 4 Sep 2024 11:12:12 +1200
Message-ID: <CANrWfmQjDMvtXwbmWe4HcjhG0kjnv0J4HhZo6Pv7pyCFHBWLAw@mail.gmail.com>
Subject: =?UTF-8?Q?=60git_remote_show_=3Cname=3E=E2=80=A6=E2=80=8B=60_does_not_show_all_bra?=
	=?UTF-8?Q?nches_capable_of_=60git_push=60_when_=60push=2Edefault=3Dupstream=60_and?=
	=?UTF-8?Q?_behaves_as_if_=60push=2Edefault=3Dsimple=60?=
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_";
mkdir --parents -- './server' './client';
git -C './server' init --bare './repo.git'
branch_default_path="$(git -C './server/repo.git' symbolic-ref HEAD)"
branch_default_name="${branch_default_path#'refs/heads/'}"
git --git-dir='./server/repo.git' --work-tree='.' commit --allow-empty
-m "$((++number))"

git -C './client' init './repo'
git -C './client/repo' remote add server 'file://'"$(realpath
'./server/repo.git')"
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' branch --list --all --verbose --verbose
git -C './client/repo' remote --verbose show server

git -C './client/repo' fetch --all
git -C './client/repo' branch --list --all --verbose --verbose
git -C './client/repo' remote --verbose show server

git -C './client/repo' checkout "$branch_default_name"
git -C './client/repo' checkout -b "$branch_default_name"1
server/"$branch_default_name"
git -C './client/repo' checkout -b "$branch_default_name"2
server/"$branch_default_name"
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' branch --list --all --verbose --verbose

git -C './client/repo' checkout "$branch_default_name"; git -C
'./client/repo' push
git -C './client/repo' checkout "$branch_default_name"1; git -C
'./client/repo' push
git -C './client/repo' checkout "$branch_default_name"2; git -C
'./client/repo' push
git -C './client/repo' remote --verbose show server

git -C './client/repo' config set --local 'push.default' 'upstream'
git -C './client/repo' checkout "$branch_default_name"; git -C
'./client/repo' push
git -C './client/repo' checkout "$branch_default_name"1; git -C
'./client/repo' push
git -C './client/repo' checkout "$branch_default_name"2; git -C
'./client/repo' push
git -C './client/repo' remote --verbose show server

What did you expect to happen? (Expected behavior)

The last `git -C './client/repo' remote --verbose show server` outputs:
  Local ref configured for 'git push':
    main pushes to main (up to date)
    main1 pushes to main (up to date)
    main2 pushes to main (up to date)

What happened instead? (Actual behavior)

The last `git -C './client/repo' remote --verbose show server` outputs:
  Local ref configured for 'git push':
    main pushes to main (up to date)

What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.0.windows.1
cpu: x86_64
built from commit: 2e6a859ffc0471f60f79c1256f766042b0d5d17d
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.9.0
OpenSSL: OpenSSL 3.2.2 4 Jun 2024
zlib: 1.3.1
uname: Windows 10.0 22631
compiler info: gnuc: 14.1
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show

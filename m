Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB11A0BEC
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359888; cv=none; b=T5eDwbq7eCk0CpOtOeRl2Ldij1gb2hIEVcwpLtU8MZWuIA5lIQZsGxwKp597bxZoOnjHvI4W7XarRIxgHy4DNR07r2m06wPZSDj8HF5783z9afzEIl2Dgr2B7w3mtza+CxY2SipY+2Ka41bHD7QuZ72fET5vZ4nWAo1UfDs/1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359888; c=relaxed/simple;
	bh=dqaB+VB3omC2pByRlnTkQbsYdwhFrs2YBJuw15BG4RI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=G6BVlk/9pWDDcQEUGnxbIBbwYKZksOr9ZvB+iVtG5HXJGy4uy943/ZnQgo7vOGBEsZQNOhiR6C47ueBMBQP/zRADfNXlot98PqEIWd3oiGSm1Q4SjCoDul17spxMKpMV0ttAMOXLkwSz663WTc5l//4GdeludRBSzjXgGLNHkG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLDyxPHA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLDyxPHA"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42c7b5b2d01so30645415e9.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 03:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725359885; x=1725964685; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dqaB+VB3omC2pByRlnTkQbsYdwhFrs2YBJuw15BG4RI=;
        b=PLDyxPHAAcDEbNESHjozdtVBPV0YH01j6Dd9rlkknO/f40zeMdgz3mswEcdCBv9AtR
         MFjDVwt3anvyufzLfRlAVJ3g6/LkHjyAK9QjblFuS5xtqiy3U9YfZb+7rsr2TkksOwPB
         XEkwV7LnNVGe/K7kIzvTfZUhMVjDPP8ZJ1kJa0fX/7y5r9uOU9LgrS3jD4BM+aVUJbGp
         h+8Vwf0tmEzlSTxqiVl8pFDPnjYwiCTyT0qMed5eeTyubzRtiNIwFKO+7zyWKHVQGXTa
         3f++CTtJ0wLtuw6BUsRFATru2DdffD02bvVpG+Acnxia5rjYYWHjJcWI7BpE2VDTwbJU
         JKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725359885; x=1725964685;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dqaB+VB3omC2pByRlnTkQbsYdwhFrs2YBJuw15BG4RI=;
        b=vGwDl9hzL3n0R1JKqSkDrhEuOFTLrGM6YjvE693hAFm7ZoyoTLAPGGuk/xF+fL0R95
         MRtcL4ihTpM0qMJCumR7wtAoJY0RWtk8lLbDdierbePTWY2xYEyPlZ5pj4gCDa1LkK7O
         pKqJpf4s1h8TbJYkb2BFW2Qb454R1hG9ZzLuwmDuTiEZ0k+NcrziN/ifavtFS1kyXFeQ
         2rK6WpmCRRJ1qJSSjSDfDRmjUhelm90u6MBPYbnnyev96abjd5C873OWbbdjmNTThZdQ
         XAWKiVG/oxfF3nSoNrFZPcCzFY1XOI58ncG+wdXIPfuOFqjz71/QxytRvP6P1B+8I9NE
         eY4w==
X-Gm-Message-State: AOJu0YxNL4ZWFJ9eETsV2nUhkn7+g6zn91CDepnJg+RjiTHXNS4mv/oO
	DouU3kslYOxNQzIq/W9ZPtor1GUdsXk9maBCx9ww+N/Grovx2iD5bAamQQ0EzMtgyOp0FUkjyRn
	B6rRXsyO6AMiThawxLrwdyE6rb0VtERsn
X-Google-Smtp-Source: AGHT+IHpqSXm89w06wpEnNV4l/2m/vadztBuhub+h16cmKX8P8HqgEikiS6By48vyIKwYs+lvy5YjggSw+xa/ils44w=
X-Received: by 2002:a05:6000:d8e:b0:374:ca1d:85ad with SMTP id
 ffacd0b85a97d-374ca1d8830mr5495567f8f.56.1725359884817; Tue, 03 Sep 2024
 03:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Tue, 3 Sep 2024 22:37:54 +1200
Message-ID: <CANrWfmR1y64OP+506JUO3Beic9kn5_TrhMQ1ZucVcDEn03noLg@mail.gmail.com>
Subject: =?UTF-8?B?YGdpdCByZW1vdGUgc2V0LWJyYW5jaGVzICh3aXRob3V0IC0tYWRkKSA8bmFtZT4gPGJyYQ==?=
	=?UTF-8?B?bmNoPuKApuKAi2AgZG9lcyBub3QgYWRkIHJlZnNwZWNzIHRvIGByZW1vdGUuPHJlbW90ZT4uZmV0Y2hg?=
	=?UTF-8?B?IHdoZW4gYHJlbW90ZS48cmVtb3RlPi5mZXRjaGAgZG9lcyBub3QgZXhpc3Q=?=
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_";
mkdir --parents -- './server' './client';
git -C './client' init './repo'
git -C './client/repo' remote --verbose
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' remote add server 'file://'"$(realpath
'./server/repo.git')"
git -C './client/repo' remote --verbose
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' remote set-branches server branch1 branch2
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' remote set-branches --add server branch3 branch4
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' remote set-branches --add server branch3 branch4
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' remote set-branches server
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' remote set-branches server branch1 branch2
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' remote set-branches --add server branch3 branch4
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' remote set-branches --add server branch3 branch4
git -C './client/repo' config list --local --show-scope --show-origin

What did you expect to happen? (Expected behavior)

(local config has branch1 and branch2:)
remote.server.fetch=+refs/heads/branch1:refs/remotes/server/branch1
remote.server.fetch=+refs/heads/branch2:refs/remotes/server/branch2
remote.server.fetch=+refs/heads/branch3:refs/remotes/server/branch3
remote.server.fetch=+refs/heads/branch4:refs/remotes/server/branch4
remote.server.fetch=+refs/heads/branch3:refs/remotes/server/branch3
remote.server.fetch=+refs/heads/branch4:refs/remotes/server/branch4

What happened instead? (Actual behavior)

(local config does not have branch1 and branch2:)
remote.server.fetch=+refs/heads/branch3:refs/remotes/server/branch3
remote.server.fetch=+refs/heads/branch4:refs/remotes/server/branch4
remote.server.fetch=+refs/heads/branch3:refs/remotes/server/branch3
remote.server.fetch=+refs/heads/branch4:refs/remotes/server/branch4

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

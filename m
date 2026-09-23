Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CEA46D0A0
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194842; cv=pass; b=mnX6pvUtDu4HErXsksbfy0VsVBVWwRbrxtp3eBGcA/rTKU+Cc2X4aMx8HQ/JfwERecAvnh76oA3XfyTW2GYAuJ1bKxTtjDyqCAiU3ufMQdUWHNcvjR98SuMcUZwzdLLmYj5wdkm6zpC2ZGzyEkYlwoUgh9qSd3CNrKe55nzwvaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194842; c=relaxed/simple;
	bh=os+3nP5EAtjiiMyXczVuf5Q1pwLFHK94Qghhc1Dn+RI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bwpkmDA8hCql3eyRDU389SFRGtSRhpdfSxJ17qIubZ8o2rxTFjvP/nk8KQLlMuS7ZHQdnao2t5lqu86caO7LAvLh79lVp168bnudY++YrnP2RyH1tzj3g8ePZWZZf/qDb9N+118tSTWHJTHdQF8fAQH3pUqcEJ8B3NbGKXYfo8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFbvIPpI; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFbvIPpI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso9680895e9.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 13:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790194834; cv=none;
        d=google.com; s=arc-20260327;
        b=Z9ahU3v99YJz/exypOnjTzsWhO6JEM8RAw1tDI9v3K/HwYYf1HPt0XxpxbUGrJJP7W
         93WjVfkDRNzr3QD6G6xjmBD8MBEBsr7PGasQwcgx6Lpe5Y2yTuoZoJZuFSH94QyHyj7m
         WKvDvalXhW6C4yq3soohWzPI2BJMCGAQmLeLdhboFWYuNe8StTf+FgzjpW2zDueFSIkJ
         M4VzMpNdx3RIy8RwjjBP0tCg4ACu+aArjnXhM3OBv/eJLGPWRr4fZFsHQZ6MAqgEemWY
         Afetzi219nXrHETANwi3wbHT/tCddgVCZz54ZW6GwnQUuDlUPbBsczAVod19PNNdNRxH
         Up8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=B0Hb/k3Pp2vC97O4lJ5drnb7gwwiPcdqihZIX770IhM=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=HX/Hws5CHiSICeDI5h2Ji9D+Cpx78TopgCSAJcT3G4NUR413KBT6ekidl0mtAMQ4g9
         Mm5cCUyWZ5MxFMVS8ro8cOVy4LpNRGGXeGJot+7opEISIMhAyCe7xfGApPBlImOtqc7Z
         yM10/+ulqkkP9zcS0nFH2R7JV1XyME2hhNjJOsjYI+ifAZV8fr7x12GzeKyGPdocMvPg
         um6/XIfvfciy8k4zhG/Wp3F6NpKlNdyAE7SCvnPsrQhJWKTd/vR8BetHlgKWyUTCYkyQ
         5he6ETeoHzcoQU6RZdaW5RGAuzRqixGT8YyvqVJwZOMIhOC7HuSbEBkPNrkzL/Y4g5za
         U/WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194834; x=1790799634; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B0Hb/k3Pp2vC97O4lJ5drnb7gwwiPcdqihZIX770IhM=;
        b=BFbvIPpIYsHwRBqkNQoYqe90DybB7xwzGzCs/UMRDP4gG13jX4pDMl8jgZFmk2vHPm
         8Wey3SsWVTMl5pXs2Y+khkIO1S934CAv8UwlO5Z0kCZBuLmimCcwLxiNIh017/cOORVr
         1FIJ94KWNuBc+ow8r8Wp7PRdFeKpLfKm2Ax5OM3CH/Rt2Ho97HHd5+vogWonmnFTAUKA
         YCMrVK9qDssz7+BwH2SCd9TEPpUbJND2WVMOz6pyhd5t2iTrQApPxfKe8uJfNrGgnm5i
         SofDxbRUl3HCrj7Xv+Gi8rRvn9kjxXQpglzWQV8fZCe8PYhEKjFbGV/iZhS26sgPzSMY
         uyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194834; x=1790799634;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0Hb/k3Pp2vC97O4lJ5drnb7gwwiPcdqihZIX770IhM=;
        b=2y0QJ87HmKK7KDED/jCu/Ye/r1Pe/V5eFMgu1hEwkS7nOw17Apt7y99ajqZGNbhkeK
         iVOvFsrk8czVewSpD6chn2EK8lucK6KK3KFQtHOaxb557lqoAzEBqc7pu5xXbhJ3Arwp
         cwASjJPoBt9OtFjB5ocTOSlriZT5fQ7mbtj/agOCQnITycAdeqTi1eD+/Rlg0F0BA0NB
         5izBWnMaSUuMW2pCcmp0jrByAc6plbdCGfYZ9pGtdY+fL+qF3Nv5B4jePWiVNW8jpc/i
         nTw6dcWKmNSQxt7UJKhjd/8K2jzxAUpZ6oUSfMxf+yJldAskBGCJRCUC/zZgMIZRgKgy
         X0ww==
X-Gm-Message-State: AFuF++lGnBWVrGZ2HGEdfwjYwgqEBbk4yQJSmr3AsgaCSmYaOweqYTlZ
	9o4ft1dWJ0kytQ+hq2cOqiN/s1flaHSgoSV6EL60m05eCR6VIx9TLtMGLJlPNv8jg7AzM6BKSVk
	fK1BeO2mHvI1eGxnfwmK4mgPO5pWglZ7G/k6p0VP9aw==
X-Gm-Gg: AYBFou24Q7HLEoQj8NcSNNY+NYw7ER7Em9+2wXYa5w2jl0uS9xVU++HH/4PokupepEt
	hVY5ArDi7CJ85aoI/QLV/cNU2ks1EsZhgBQV7JXy/5ON8gA7f+bxrc2Z6fKUD6PJT+JFVbrRlU3
	EW59h8FDzIMW94hk1OiF1Ed8y7R/dynICV3ED0N2VrANFNO2dGeadhp97YTTOUIACxt3p6QpW/1
	6Yzajpl1IyrAXBftmGTaasMPiKIC0m32Z5v6WwTDXAvrRdChtJgQRTA+ou40vQQLhmd0XO5yCxk
	OzXj7Ea2d7RiFNkXAelW74phImuRi5343ZlBKr2AZhcDu8Xyo9igLnMTDAe+BxPkLRJ9efQ3FCB
	R8vHyZizbChtCG8yXvXxqUkcIN+2xaggn6A==
X-Received: by 2002:a05:600c:1553:b0:49e:74b6:740f with SMTP id
 5b1f17b1804b1-49fe66f3ca9mr4448545e9.17.1790194834363; Wed, 23 Sep 2026
 13:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Guillaume CHAUVEL <guillaume.chauvel@gmail.com>
Date: Wed, 23 Sep 2026 22:20:20 +0200
X-Gm-Features: AclHuK-PGISliHvAJVbXzT7lcQPraOfx9I3jSpStnBM9elXANbPEHd6F7Nx5o0M
Message-ID: <CAP4DsUexEmm1qo6jH+Qzy+n3dQs_OCJ8yg=ReF+aVrcTrC7NeQ@mail.gmail.com>
Subject: [BUG] submodule merge tries to read B's commit from A
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I ran into two problems while merging a superproject with submodules.

One problem, involving the repository used for commit-graph lookups, was
reported in this thread:
https://lore.kernel.org/git/d3241733-d015-4646-88e0-06e56a04e77b@nutanix.com/T/#m174067937aaf76e9fa844386961b3e9e66c1e4d9

The other problem is that during a merge, Git sometimes tries to read
from submodule A a commit that exists only in submodule B. I reproduced
this with Git v2.56.0-rc2, built from source in an Ubuntu 26.04
container and an Alpine container. The reproducer below triggered the
issue in all 50 Ubuntu runs and in 43 out of 50 Alpine runs.

The merge should report a submodule conflict, not look for B's commit
in A or report A as corrupt. The script checks the OID's presence in
both submodules and prints the "BUG" line when it finds this case.

---------
#!/usr/bin/env bash

set -euo pipefail

unset $(git rev-parse --local-env-vars)
export LC_ALL=C
export GIT_CONFIG_NOSYSTEM=1
export GIT_CONFIG_GLOBAL=/dev/null
export GIT_DEFAULT_HASH=sha1
export GIT_TEMPLATE_DIR=
export GIT_AUTHOR_NAME=Reproducer
export GIT_AUTHOR_EMAIL=reproducer@example.invalid
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
export GIT_AUTHOR_DATE='2000-01-01T00:00:00 +0000'
export GIT_COMMITTER_DATE='2000-01-01T00:00:00 +0000'

tmpdir=$(mktemp -d)

for name in A B; do
mkdir "$tmpdir/source-$name"
cd "$tmpdir/source-$name"
git init -q -b main
printf '%s base\n' "$name" >file
git add file
git commit -qm "$name base"
git switch -qc branch-a
git commit --allow-empty -qm "$name branch-a"
git switch -qc branch-b main
git commit --allow-empty -qm "$name branch-b"
git switch -q main
done

mkdir "$tmpdir/super"
cd "$tmpdir/super"
git init -q -b base
git config --local protocol.file.allow always
for name in A B; do
# reproduces the bug
git -c protocol.file.allow=always submodule add -q
"file://$tmpdir/source-$name" "$name"

# does not reproduce the bug
# git  -c protocol.file.allow=always submodule add -q
"$tmpdir/source-$name" "$name"
done
git add .
git commit -qm base

git switch -qc branch-a
for name in A B; do
(cd "$name" && git switch -q -c branch-a --track origin/branch-a)
done
git add A B
git commit -qm branch-a

git switch -qc branch-b base
for name in A B; do
(cd "$name" && git switch -q -c branch-b --track origin/branch-b)
done
git add A B
git commit -qm branch-b

cd "$tmpdir"
git -c protocol.file.allow=always clone -q --no-local
"file://$tmpdir/super" clone
cd clone
git -c protocol.file.allow=always submodule update --init -q
git switch -q -c branch-a --track origin/branch-a
if merge_output=$(git merge branch-b 2>&1); then
merge_status=0
else
merge_status=$?
fi
printf 'git merge exit status: %s\n%s\n' "$merge_status" "$merge_output"

if [[ $merge_output =~ Could\ not\ read\ ([0-9a-f]{40}|[0-9a-f]{64}) ]]; then
foreign_oid=${BASH_REMATCH[1]}
if ! (cd A && git cat-file -e "$foreign_oid" 2>/dev/null) &&
(cd B && git cat-file -e "$foreign_oid" 2>/dev/null); then
printf 'BUG: OID %s belongs to B instead of A\n' "$foreign_oid"
fi
fi
---------

One run produced:

git merge exit status: 2
error: Could not read 7d549ba7e9152029e66ddca8dd23ee7da32b036f
error: could not parse commit 7d549ba7e9152029e66ddca8dd23ee7da32b036f
error: failed to merge submodule A (repository corrupt)
Merge with strategy ort failed.
BUG: OID 7d549ba7e9152029e66ddca8dd23ee7da32b036f belongs to B instead of A

An AI analysis identified a likely cause: a delta-base cache entry may
remain after its pack is closed. If a pack from another submodule reuses
the same packed_git address and base offset, Git may return stale cached
data.

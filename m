Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5518222617F
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740649895; cv=none; b=FUQv0FgIVGrI4/WTlSybZVAbNnmALdg11j7h8Lub6qYh8j+QUypVo4PYS0BOkiCT1fZsmXsn/t+PqN0Ol4iH077Z5kwvgKgTWtMxDToIA6JceB7mJXnKzcJDwHQ0NyEfZASReVEKHjWyBEBO7bKYphlbGZns1G090rNmqnsIUu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740649895; c=relaxed/simple;
	bh=4n0oLODj9hTx7uiYjhIU3FuczleVT/ZJeTYOuTkoYdA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RpVq7FdY8bNx8k6AvfGDn9Up5RYUzmiXMsd6rChfOYi4EH3piPMygmyvWbmViqjoUm8DYF+AdDxwupxb9cUJLIFkZe6ysAP6DYr3zIwvtjgPezqIeqnS00zaDmAtKAnrs8RO10zXF1BieH/l6/Yano5tIULvJNfFEEvM0ZAfMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=island.io; spf=pass smtp.mailfrom=island.io; dkim=pass (2048-bit key) header.d=island.io header.i=@island.io header.b=XZY8fHlr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=island.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=island.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=island.io header.i=@island.io header.b="XZY8fHlr"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so1033868a12.3
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 01:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=island.io; s=google; t=1740649889; x=1741254689; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4n0oLODj9hTx7uiYjhIU3FuczleVT/ZJeTYOuTkoYdA=;
        b=XZY8fHlr6cWFtPRbqzUq54lQZqhx/9PqUUiSz7kDw1vINRl6F7GW4u8sCXwuFTn5f9
         x6PcIw+tBaXWh2D7MFzx3PvIu0elNqVjZMa7v+t6agKxcZ96Rfu2JxdEeqLAjmnIdjIM
         Q66ml6xhwRp9UHz+OAMCRVexJ+SfV4UungK2xPcMdanh3dn69k0zw6e1Js7oGcYDC+2k
         UDAdqzYkcGTBi7Lo45TrfkTDgDzbekle/oDpI/jcwDez1WMs6D4QtxhtpN0tvHOLnA90
         /rOSCxUd8cfUxCwTRrtg5xGHRUmMUsWb8bF3RI3aUREH9SnUDbqW5Xzbozpd0G6+jDy1
         0zEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740649889; x=1741254689;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4n0oLODj9hTx7uiYjhIU3FuczleVT/ZJeTYOuTkoYdA=;
        b=ZidQkLhUEldLm9fjkTDkuBL5brzqadRFqrbHi607J5mbYBmhnQJeswggvV3TXHXFkP
         R/cNnjKpnsMWWpKvLoccvxFzaCJ3yAlaOCp2nngQ5gtaQupkpm5fhVz3Wtpy6qzkA2ya
         BxjS10aAiY8V26BKZwG4uQh4Ov+l+cytG8+MSEbP6/CUOhDZAu5Zf/ZJOzXxxwjuPQuf
         W1Tb8A40wcJdvuhGxZjb6vYpcU3TbmtQfO0K7QLXVP9yyy0qfQBX38jNcDoP3ciDE0dD
         6kiGMk19Uc6j0TLJigqETooGvRUG8EaiCZrZFMrfDn7ZvPPDOuK9NGixxEn9z2CG8jA+
         UL0A==
X-Gm-Message-State: AOJu0YwO51FiLldZ9QruKenDJC7OBQfJ36gxZ4Y89rqQA1setxllWPUW
	DKUCrOFs4by4j0sBc7THHReWopbrcEaM3PmBcwDNonLRrrdkqEdUerNypEcKwSeMw9Gy5OskP1s
	fkiIKV09INFvKOXpZyhEXdvS2n4QX7z49xFmTfVkRVHKxb6zYmCpAuA==
X-Gm-Gg: ASbGncuczDaBMV5wquleP6+uriySZb3S4DH0C+RVibOxHQhqHR8t/0ZCvl2WJ5NHd2e
	ZJ+5YXPrYxyYBDWsZu0V78Zf71i6Lp+45DDjKo7ma00C3CWHzE4bH1BSrzHkbptVPFXMHazCBZx
	HMUIoM0C14
X-Google-Smtp-Source: AGHT+IFGzdV3bO6lmtbM/BmgCjjCHHnf8U0nll+yfasXEoJgEPzT1dKTU3G5TueXFD/mLaICfbvkRlGUpGDZe40hyOs=
X-Received: by 2002:a17:906:3190:b0:ab7:be81:8944 with SMTP id
 a640c23a62f3a-abeeed58126mr718470266b.6.1740649889226; Thu, 27 Feb 2025
 01:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nikita Leshenko <nikita@island.io>
Date: Thu, 27 Feb 2025 11:51:17 +0200
X-Gm-Features: AQ5f1JoNtqDrTgCKFKjpAyt3xEQqELtDT3KPhzCmBF443wjU3QwpIOgn6iDqF7I
Message-ID: <CAEXts1sWBK0HY9PdvsGqq-nxbi0qdkodBV3CNEZ567ji02ZojA@mail.gmail.com>
Subject: git-am doesn't compute intermediate hashes when patch applies cleanly
To: git@vger.kernel.org, Nikita Leshenko <nikita@leshenko.net>
Content-Type: text/plain; charset="UTF-8"

Hi,
(Git 2.48.1)
Imagine this scenario:
* I have a patch file with two commit, A and B that both touch the same file F.
* The patch file has hashes on the files (for --3way)
* I apply the patches with --3way
* A applies cleanly (even though the file is different)
* B requires a 3way merge

Now, because A applies cleanly, no fake ancestor was created for F.
Then, when B fails to apply cleanly, the patch file for F contains
unknown sha1 hash and the 3way merge fails.
In other words, because Git didn't build fake ancestors for A it lost
the opportunity to learn about hashes that are relevant for B.

Is there a way to "force" using a 3-way merge for all commits, even
when a patch applies cleanly?

Here's a bash script to reproduce the issue:

---- START OF SCRIPT ----
#!/bin/bash

set -e

echo
echo ====================================
echo "GENERATE PATCH"
echo ====================================
echo

rm -rf src_repo
git -c init.defaultBranch=bug init src_repo
cd src_repo

printf "1\n2\n3\n4\n5\n6\n7\n8\n9" > file
git add file
git commit -m base

printf "11\n2\n3\n4\n5\n6\n7\n8\n9" > file
git commit -am first
printf "11\n2\n3\n4\n5\n66\n7\n8\n9" > file
git commit -am second

git format-patch -2 --stdout > test.patch
cd ..

echo
echo ====================================
echo "SANITY TEST"
echo " - apply to indentical file in another repository"
echo ====================================
echo

rm -rf sanity_repo
git -c init.defaultBranch=bug init sanity_repo
cd sanity_repo

printf "1\n2\n3\n4\n5\n6\n7\n8\n9" > file
git add file
git commit -m "identical content"

git am --3way --keep-cr ../src_repo/test.patch
cd ..

echo
echo ====================================
echo "GOOD 3-WAY TEST"
echo " - apply to modified file in another repository"
echo " - have the original file in the repository as well, so that
sha1 is present"
echo " - change the file so that the first commit fails to apply cleanly"
echo " - this will force a 3-way merge and the intermediate sha1 will
be created"
echo " - the second commit will fail to apply cleanly"
echo " - this will force a 3-way merge and the intermediate sha1 will
be used to create an ancestor"
echo ====================================
echo

rm -rf good_repo
git -c init.defaultBranch=bug init good_repo
cd good_repo

printf "1\n2\n3\n4\n5\n6\n7\n8\n9" > file
git add file
git commit -m "identical content"

printf "1\n2\n3\n4XXX\n5\n6\n7\n8\n9" > file
git commit -am "change in hunk"

git am --3way --keep-cr ../src_repo/test.patch
cd ..

echo
echo ====================================
echo "BAD 3-WAY TEST"
echo " - apply to modified file in another repository"
echo " - have the original file in the repository as well, so that
sha1 is present"
echo " - change the file so that the first commit does apply cleanly
but the hashes are different now"
echo " - no 3-way merge was performed so the intermediate sha1 is missing"
echo " - the second commit will fail to apply cleanly"
echo " - this will force a 3-way merge and the git will complain about
intermediate sha1 error"
echo ====================================
echo

rm -rf bad_repo
git -c init.defaultBranch=bug init bad_repo
cd bad_repo

printf "1\n2\n3\n4\n5\n6\n7\n8\n9" > file
git add file
git commit -m "identical content"

printf "1\n2\n3\n4\n5\n6\n7\n8\n9XXX" > file
git commit -am "change outside of hunk"

git am --3way --keep-cr ../src_repo/test.patch || echo FAILED!!!

cd ..

echo
echo ====================================
echo "WORKAROUND 3-WAY ISSUE"
echo " - demonstrate the patch can in theory be applied"
echo " - start with the same report as bad_repo"
echo " - first apply the patch to the original commit to reconstruct
intermediate hashes"
echo " - then apply to the latest commit, now it succeeds"
echo ====================================
echo

rm -rf workaround_repo
git -c init.defaultBranch=bug init workaround_repo
cd workaround_repo

printf "1\n2\n3\n4\n5\n6\n7\n8\n9" > file
git add file
git commit -m "identical content"

printf "1\n2\n3\n4\n5\n6\n7\n8\n9XXX" > file
git commit -am "change outside of hunk"

git checkout @~
git am --3way --keep-cr ../src_repo/test.patch
git checkout bug

git am --3way --keep-cr ../src_repo/test.patch

cd ..

---- END OF SCRIPT ----

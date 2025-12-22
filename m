Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693330DEBC
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766395008; cv=none; b=FpmS6E/eoHe2e34WJdaMhX6YV/IdPNsSdBcsP1pWw0iCvvQcj30ldokYuTbyoH+XA49IR2EqY/YiaAy+kmlMx8lSW3nD0wisgvCyOwszxWZhtJbP91hlk1uvwilie5BZS6HYsijbqdEHMY71kST6O7/5knh2GPGn2AiiTjQcLDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766395008; c=relaxed/simple;
	bh=eEF9wB/SA11IMLHCtszLogl5JJGFvXIdiiygnDAWbCs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Yxf22CrFlfNVdRENccpQFUfTQnVkCzZ/H0tYO0o7gRz0xKaCVO8nv2NFoMY6ffcMczKNQXPEzNKY8cuSdmCb7osYCgUuBNRq9uuMsQKZpqqUdUXOCg3g5UHDdH71CklMBOb/lE6tUOlNlEp8sDlqH7uLsmegNOXVfLdCSrT/0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHQgDPSQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHQgDPSQ"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-598f59996aaso4850350e87.1
        for <git@vger.kernel.org>; Mon, 22 Dec 2025 01:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766395004; x=1766999804; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eEF9wB/SA11IMLHCtszLogl5JJGFvXIdiiygnDAWbCs=;
        b=QHQgDPSQG5etzYzsg1jaJrjuMhrShqBdIF6EOBVRGwPXXdadmHwa3JZHeMUUzh9LKL
         erdZyIijmuUxAu0SrXA1prhBHvhgOhMYz4r89Dere/w3bE+TdqppwHazVPJo7rIHJXFy
         xBkFclSwyZaDgv1GtjKYayrw/28sErjxLAWsZZr8DFF1nObcgWZEHrmhoVWxdyzLB4Ok
         3CwEMrHeb5AeSVc8JMrVsEQlcx1s5q80YPkzBhQAXHKM1qpFKtkvY2cSy/xQXCd2C+a0
         gMTHRarzSe3UjiXoW9peJQwRSjQprx3h8gLk5vBlAgLPvljSPWpwfpF2y7CHMrxt0A8Y
         b/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766395004; x=1766999804;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEF9wB/SA11IMLHCtszLogl5JJGFvXIdiiygnDAWbCs=;
        b=kylEW9Cmvqd1utF8v93gIiPjmwPZBBvL8v7bVSOFh7FIhdwRzoK2w6r2f+wTU3Dh0P
         K3anHJs4g3rKN+d+J7xsl+prbAt0r5KEwPPPYGuSbXqS17GelCJ5vBxCDBXcsdD8wydi
         jyG4p9e8eR8VMxCLd6zrss6m8bsZd5W1dC038zdmg98aBg8m5DfYS//X2fdD8W3oEzSd
         P1kKKZv/nObOf0dXqBadooRB7ZTMdhEdTu6tk0dHC7E+7poHmsyBvh70JhFBe1Pzt5y+
         3DOMDEOolhJMuD3Jp6aTBIKTutC0YKkM/G6LqyZ/ymXSQJMr/noUZG8eAzG2BbqzGz4i
         5SGQ==
X-Gm-Message-State: AOJu0Yyasnf2asU1mrCaX7eJLd/Mpa0Zz/wUqb1YlGJfMUBr/Y+mt/nG
	e6KyN7P5uuybYod4Kcfh9feSjjMdba3MiLNAID8/YmP6cL1lc2voQH3tpjBVrP6lGRB6LegRXRd
	wpqwxAUI638yTmQ/mJacJadB4NjuJdxa+1PPH
X-Gm-Gg: AY/fxX6dbCyN4kufy8TH+aW2TX7rT/OxhkzcLAebYn9d6UyzPznfycTDQVXQv3B0YKl
	FoRT7rag2Zvi6DS79Itc2xbdmUOnnmQ/zpnRJmD4zTdo4GDTf6U6sTCAWajglZEaSw+8+xVizoH
	HOSjvvmARvg4KgLltijg1Ch8YJzY0fpa8ADgTok1QxhQpOXb6IX9Em5lJJToRRFKm+ZGIjKWG8O
	3SJr1klRz5lKk6LU4YIXKE9qWfWwMfWX1aRlCrX3Opf5Vpw1PR+YIMOKuuvq99EsCvosb4=
X-Google-Smtp-Source: AGHT+IEQ3Bg0lS0KmKlTHqhgvU+A4HOrIIcTkVZOxxC6cEn/fbokwVreqVGiiBDdCxpH+gqAtmQAipuRdCvvk4EvZ/0=
X-Received: by 2002:a05:6512:3a8b:b0:598:ee5e:d8bf with SMTP id
 2adb3069b0e04-59a17d0930emr3603660e87.15.1766395003929; Mon, 22 Dec 2025
 01:16:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhelyo Zhelev <zhelyo@gmail.com>
Date: Mon, 22 Dec 2025 11:16:07 +0200
X-Gm-Features: AQt7F2rifqqVpdsLcsc7V3DO09pQ8-AXzT-svF3Jr5cNzlBlwU-OovQ7722wYAM
Message-ID: <CAMxgZ8KqU9BUJ6T7DLct3CaEh9EYdcMO=dBAMPyQsb=knekSuQ@mail.gmail.com>
Subject: [BUG] git restore: typo in error message "could not resolve ource"
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I executed the following command in repository: git restore -source
my_base_branch
I have reproduced this on both Windows (git version 2.52.0.windows.1)
and Ubuntu (git version 2.52.0).

What did you expect to happen? (Expected behavior)
The error message should be:
fatal: could not resolve source

What happened instead? (Actual behavior)
The error message is:
fatal: could not resolve ource

What's different between what you expected and what actually happened?
There is a typo in the displayed error message - the first letter 's'
is missing from the word "source" in the output.

Anything else you want to add:
The bug is present in the latest stable version 2.52.0 on both Linux
and Windows.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.52.0.windows.1
cpu: x86_64
built from commit: 2912d8e9b8253723974b7baf1c890273b1a1c5bd
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
rust: disabled
feature: fsmonitor--daemon
libcurl: 8.17.0
OpenSSL: OpenSSL 3.5.4 30 Sep 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 26100
compiler info: gnuc: 15.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]

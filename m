Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494503570AD
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463547; cv=none; b=omPAPQfhS86Wlo+Ap12vN+OAYckDiClapTGw2f0qovp1UD1Q/QRcurgveKdKTnh4TKD4LKGOKhVuNnkE6qdANcstwXGycX61jpfLA+p7LTkrErVzk6n2dkGOtH6DBQiWkXGRANMAjW7n1zc6rcpo3XtJinxtlLL7gbRIxuTyTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463547; c=relaxed/simple;
	bh=JIIX2JJbCmNtZxjG2LsbpOWmwWKPOP9eTBK17tfTyBM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B4t+kq5baBJgLA3qYjMmREbVyk4+dGaLG7JiLkxMaQVD6BWRn+1PdeNGf4l74FRwO2jCQI7YlAgSjR+6SQ15q5rYyc4f2tg5IMw4xyDYwrWO3bE+R1occWQEDMGHlsN6ahq7btwUhHfD2B7IK8XuHKO98E/mqyH6H/3N/Puc+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBGTLWrH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBGTLWrH"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47defaa012dso29488f8f.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783463544; x=1784068344; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M4ro2lRmXUrn/8ul+BT/RePPCBwIKtI3i2+4JgF0ECk=;
        b=YBGTLWrH0cXF8f/w79cewU5p+9nSyeOVRGKXfT2ZUPMeL4J61tksY0SmaXvbIRc8ct
         ltgQ9Hi+L6u4wYMU3RUy+9fN3r8lFenCeKu8+NG6dn7Idg6Z+pT77hej+SCGF1XkgZQW
         aIyn7r9NJrQ/AEqNbq2ozl9WAlKfhL7fGI3UVpPMiPxgq4fgmqkp1xiyYaa9Vl8csEX2
         C/svhWrf/oshjP4Qu71nxxnqeGdvlpap3xCzHRh/2okfUR0fHQR6T2y9nlkZ8Smgvauz
         gN/NHfQn8TedkFo3BIwF+ioUzoUyoVeeOiyE6jhZTi2VE1caDkc/W6f3ngNzszPXA6SB
         Wanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783463544; x=1784068344;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4ro2lRmXUrn/8ul+BT/RePPCBwIKtI3i2+4JgF0ECk=;
        b=qi1VqwNA9V1Ah9l410lXvuZpa4b7i2zV9UYVaH+Azula+j57slko13dZgHk/VIcbmD
         LLixRCpOzOHzCbfxer/Tnf9Kyvn2Tpiy2hU01qGn5Kfmdp9VWAQ0VRlkWiBjpifO0b1C
         gttJHVJqQ4T0lEjMlL6EsshEo2qIYeq5K1AXMqENh64V8Tp1IVLNLTP5LxWz45LIx4q2
         U9nehf5uYXsUGpQOSKPstPD6sPZlwE+9hnnk/KJe3nHlXXPPVZtaw3tfHOqu+HF3pSSz
         0jxfrFrsZh49g6rd+umC19RtdQoL4Bf026zUaJ1fqZwyMeslh99//TGqK1NOwFbnAHYM
         mWJQ==
X-Gm-Message-State: AOJu0Yz7ko7uakJqNKau1GTrJU/emp/ixB2Gi4uqoKETlcev01tM9UAg
	Jff62BfJh1YH4OpCwS0i6JoV2/M8HDH/qaVRAuBfL71JY3+yGOx5cLrMYCmzUA==
X-Gm-Gg: AfdE7ck08BFxct8fGQ0BjUQbhcWz/DIO9kSOFw7LyRel9vtBxD9gS2Vv9BSZLt2Ylyw
	pCESyy/3dGYoF5/o3DK3W2B+BBLDFDIbTsIwTPEmGQ1O+qC2nRFN0bk1sgKW+KIfonVR62uhr6g
	6f2zAebvraq7Yf46GGnehFumbeD2Rg0HCGRejLouhuo+deZGHYQb5apWYE9X2Kbyj2DvRJgPtIE
	59uloxHOT8ygg0gYktzdluMDrlg01919icqK1GMWIaAKfbXy1Sc+Ws9kLDNllv3C1NE8hclQ3Yd
	jbM1REyUwkjTC6ScIgela41CUVHiQyc84OT240xULIve1VJI8Vv29JymPer5Kxjm1zB0cL1er9x
	/MThn5FisOrxdzNdOlWNe1g7ueMi32ZXzJhxALz/PfBG3TE2Qd6mfGqnRrpJp8P90HltOqqkEzb
	qGzuIE+tB7zx7Mrx7sPMt1m1XEIEvBFtnNyGV5B0stpw==
X-Received: by 2002:a05:6000:c8a:b0:477:80fa:f480 with SMTP id ffacd0b85a97d-47de66a2f76mr5669245f8f.39.1783463544495;
        Tue, 07 Jul 2026 15:32:24 -0700 (PDT)
Received: from localhost (84-236-78-136.pool.digikabel.hu. [84.236.78.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm40192523f8f.7.2026.07.07.15.32.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:32:23 -0700 (PDT)
Date: Wed, 8 Jul 2026 00:32:22 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Subject: Incremental 'git fetch' downloaded everything again
Message-ID: <ak1+dsNQIV8EeSIc@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I usually try to fetch from https://github.com/git/git daily, and
today morning something unusual happened:

  $ git fetch
  remote: Enumerating objects: 406099, done.
  remote: Counting objects: 100% (1229/1229), done.
  remote: Compressing objects: 100% (1044/1044), done.
  remote: Total 406093 (delta 207), reused 1189 (delta 185), pack-reused 404864 (from 2)
  Receiving objects: 100% (406093/406093), 292.22 MiB | 4.62 MiB/s, done.
  Resolving deltas: 100% (308943/308943), done.
  From https://github.com/git/git
   + ffe2b816f5...106a830b98 jch        -> origin/jch  (forced update)
     e9019fcafe..f85a7e6620  master     -> origin/master
   + c42f45431d...00534a21ce next       -> origin/next  (forced update)
   + f6884212b2...73452939f9 seen       -> origin/seen  (forced update)

Note that it downloaded over 400k objects in an almost 300MB packfile.

Looking at the objects that I already had and the objects in the newly
downloaded packfile:

  $ git rev-list --objects origin/master@{1} origin/next@{1} origin/jch@{1} origin/seen@{1} | cut -d' ' -f1 | sort >existing-objects
  $ git verify-pack -v .git/objects/pack/pack-080fedc9c19f711dd1b22103b382ede8925b90a6.idx | sed -n -E -e 's/^([0-9a-f]{40}) .*/\1/p' | sort >received-objects
  $ wc -l existing-objects received-objects 
    406954 existing-objects
    406093 received-objects
    813047 total
  $ git diff --no-index --stat existing-objects received-objects
   existing-objects => received-objects | 3615 +++++++++++++---------------------
   1 file changed, 1377 insertions(+), 2238 deletions(-)

The vast majority of objects were already available locally.

What's going on?!

This might be a recurring issue: I remember a similar large download
from 2 or 3 weeks ago, but back then I didn't have time to investigate
or to report.
I tried to reproduce this issue by attempting to recreate the state of
my git repository from yesterday in a new repo, but no luck, 'git
fetch' only downloads what's necessary.

I use a Git version based on next, with a bunch of my own patches on
top, but none of them has anything to do with object transfer and I've
been using most of them for years.  I don't have any config set under
'fetch.*' or 'transfer.*'.


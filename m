Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0238F6E
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723082853; cv=none; b=g/mG3wyg8AKLwN36FR5BEdQKPC1p7IBfJakTjIgo0TkxA5yM5Q7Ftq5dyDrgbrBN+WaYVO5Zn5PN9vVIaklLQA3vj3GKSdCD2w2yqNDyo3sPACdf3dNr3ZL54Utzd8Iveusb2U4gna+znkm1JmRzurX+iBlAcDdc4tKHji04wLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723082853; c=relaxed/simple;
	bh=3mUgvHfR/gpeg2bE4iOVV3FUt7xNVKSOafD1oyqGAJA=;
	h=MIME-Version:From:To:Cc:Subject:Message-ID:Date:Content-Type; b=ADdEKXAwD6sf6xKMGFa6qT5WNjurjwrj221F2KI548TznqtkigjuVyRmbwEvBSK2XRZb3xdsiZFF0HEqnLXY18n/AWPnIgydHKwHaT/w275cl32rggVFbg6Hh3KC49f5ci5KxmBzZycaG/hvpGJCvPlUxbgu7KfmHOHp1fVc4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cD9NQ5pr; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD9NQ5pr"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39b3f65b387so2181515ab.1
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 19:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723082851; x=1723687651; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:to:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0EGLQgqfgnm1QeiwA1IRrbaq2tI4Qqy6aSN+SM+USyc=;
        b=cD9NQ5prmHfLoYQirklDzeaEWgucNOu0uVQ8viatupUZLftBApbWsA/JO9voFSIQnX
         1Bdo7HBq04Y3AOpHPfAGnyta5xLJ3vgggwxsdSd+tQqql22i9uYNGfL/MGVKMxrXBA/m
         NBrhAgbkvpOlh/ibbqHCOFElZTYJRASjX5FrjrVepJbk2zj35qiHRpipd4uLm/o48rs5
         nHzFzZV5TaY100LS9i9piJ1CYlHlvIBiU+lT4WdS/lE6Q7pZqntT2namXDnGqyH9fF/H
         k1FSMWZYgUqZtBiY2j+hSCFrV89OkRLNLJXBu76Fj6TSK+msRvQGv8Bxt/5ygOJDRKH7
         o+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723082851; x=1723687651;
        h=content-transfer-encoding:date:message-id:subject:cc:to:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EGLQgqfgnm1QeiwA1IRrbaq2tI4Qqy6aSN+SM+USyc=;
        b=vMrxFeeZMKBHJXRzI9bB/QifoxOBricR1vsA0Yp2WCI3X1odSNt+zk2cCP6m+pZOSv
         u0y14jV6cxFRRwQblY9G7NiuCgrhEh+jxVJ2tPNgzzC0RDFwUFIR/Q4Z2OZOcjQHypiL
         H9dPDvpvUX9HiJbryRS/2jqdNm14xRYLUAZXHskI5iUOmrCdZjlTpY8JmCzzQMmgzbq8
         IQD81ypr/MgFwDz52O4uTxkCRo+f+WPTHOm1hTC218lSeGq87qfW3H2Yv9BMeh3qxtQR
         06heHXj+LI6Oki1SAweXsdLDOpTTQ37+Gs9mnkktc8CpPAhVbweUXScyqInMFA6Zdeu4
         EX0g==
X-Gm-Message-State: AOJu0YzIY35h746FbyNdi36of4cJ6KWhKV+ixi6YqbCdJfkN5KUOZB70
	Irb4NpmTCe7jmlhbZRJFWmdqIelobCfZT4MS5BEYTkhdL24y1sf3tlZ3ng==
X-Google-Smtp-Source: AGHT+IGtnDrZ/2hUMn5ox6FkMhr8b5Qv+xYqhmP+1pA20A4UxpZ4o03X1DmHB4+fhtYKB7kObag19A==
X-Received: by 2002:a05:6e02:2144:b0:39a:e9ec:9470 with SMTP id e9e14a558f8ab-39b5ed2193bmr5456355ab.17.1723082850907;
        Wed, 07 Aug 2024 19:07:30 -0700 (PDT)
Received: from zivdesk (syn-024-241-228-214.res.spectrum.com. [24.241.228.214])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20ab4f7esm50416015ab.38.2024.08.07.19.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 19:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: <git@vger.kernel.org>
Cc: "Derrick Stolee" <stolee@gmail.com>
Subject: [BUG REPORT] sparseIndexExpanded hint always shows on sparse worktree
	 move
Message-ID: <17e99eb90d57089d.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Thu, 8 Aug 2024 02:07:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

After updating to v2.46.0, the "sparse index is expanding to a full
index" hint added in 9479a31d60 (advice: warn when sparse index expands,
2024-07-08) seems to show any time a worktree using a sparse index is
moved. This is easily reproduced with the following script:

    git init --initial-branch=3Dmain main-worktree
    mkdir main-worktree/A main-worktree/B
    touch main-worktree/A/a.txt main-worktree/B/b.txt
    git -C main-worktree add .
    git -C main-worktree commit -m "initial commit"
    git -C main-worktree worktree add --no-checkout ../other-worktree -b oth=
er main
    git -C other-worktree sparse-checkout set A --sparse-index
    git -C other-worktree checkout
    git -C main-worktree worktree move ../other-worktree ../other-worktree-m=
oved

It does not appear that the index is ever actually touched. Testing in a
real repository shows that the index size does not change, nor does its
last modified timestamp.

I've reproduced this on Windows, MacOS, and Gentoo Linux.

--=20
Thank you,
Brian Lyles

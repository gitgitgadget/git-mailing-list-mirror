Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7A3D66
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 04:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728535657; cv=none; b=gXTMP/fl/OkIB3vocaY66jER3QJLRa8tU4I05m0nXbBbEXGdLA27flek6Rg1N76Q1dnIQgqT3eyzEufSXeHk5a5izH4A6PmVj5YLKNqOgsmIBJMDF3Uu2ZdMV8JI0w446AqpuY5fSMuqC+kflswZgbLzWEK79CNsh4oUP84jkgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728535657; c=relaxed/simple;
	bh=4ccQdw3fdr6g2jRrA9zY0VQPoKRDOgIZiZAGMOrDqeg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BeW5c9CknO3ku9fY9Kwmb7Y33EGrCXXUK48CEQxKMdqo74GBeNaWSzPnv+c7vtdDb+ytgsQQ+VdmMggNu9O+m1uguD6bQVyrX9OylalrVoildkyRZu/KZIwBSMjCXvVZ6iF2sbHfffzkIVAdl9LcHagj9yKXLIcqSoCWXp/e/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8GmQBy6; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8GmQBy6"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fad5024b8dso5010821fa.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 21:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728535654; x=1729140454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ccQdw3fdr6g2jRrA9zY0VQPoKRDOgIZiZAGMOrDqeg=;
        b=J8GmQBy6k3b/MWVPoLxAuVdElBz3wEg7med+V/GbaNwctYpT5603RkwkkUgSv+GR+L
         FC6jWfthpXfft2tNUhbg6pFSMt64vBEUo2bQBVtvHi5aPbTfh7Sl1J8IuF1iotC3tX1M
         0p2kck9OPSoSZwz/ohGvPY6mLJP6HZ/GFjTJCKibOCdNWHFk7OvlfWdRi9Z1Cx8bETw8
         t8dqt1SQlb0/0vq4CnBP0ImCPrgJvggjxtoEwp3ni5ZFBXIcuTPrD0yzpwePbn/o8Za8
         SI/Hwd0XJ0ZvsMTgb1A3EXpYcMcSQPRLtGDF/0RdTtCH8Gj2dKwkFc2uXCnvQrI9Eqsl
         P0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728535654; x=1729140454;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ccQdw3fdr6g2jRrA9zY0VQPoKRDOgIZiZAGMOrDqeg=;
        b=o3Ju5IPjKiXxI+5y/GMZESB73Abz0bM3Z52klHQsMfBDsr4vicVP4CiEt+wgJ8Xdut
         m6yr56aYd+lD6GoaSOYkJv0CsvwFh7S1yhx5LdDf5Fz8PUWoQI/pg4FfzSY5nTC8s+Rb
         BjehBbE1yNtmIG6aAEzBAtf7/pVQ2wGO9/BuQDbolwZYgt+2eCNi4XfYkeuFsaY6zhtQ
         Sp+Ql/DmQTAS8xIZ3jVzib34fKz0ypkON0dIt8ym6YCubOI1sf7Ud93vV0nhDAOCUV5S
         2pfTT21Hq92Waj+MNKXzrrmrYlPt4K7jB4iSMHGMuSTwHVRfOlzGz3YFUoAfoUPDKCNW
         vRfw==
X-Gm-Message-State: AOJu0YyYo13m4nV7Hbl1OEsTHl6ydXH9mY1DWdogLpUCbdRBHqTvwHwP
	U0PEVYG1oUK6I+3McIHqWykh1vjkIDSxVSKIVx9lDqaGTDCKuxAB/SgsPfBwF6boRTsgrJmMhon
	e2i6aoDnI/KEZWSD2HSRZzDIAKOvPjWFo
X-Google-Smtp-Source: AGHT+IFX5mEPYvId057Z64gPKNaZ/pLND/5YNQJBrC3vEDsjoM2XRMawiyPiV4fZffFtHeWuuni0eojRZJPZXw53mmI=
X-Received: by 2002:a2e:bc26:0:b0:2fa:bfc0:6ad8 with SMTP id
 38308e7fff4ca-2fb187cbbc8mr29342121fa.36.1728535653372; Wed, 09 Oct 2024
 21:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Neema Joju <neemajoju96@gmail.com>
Date: Thu, 10 Oct 2024 10:16:57 +0530
Message-ID: <CAEqABkKmkqJCqpG5nOgGnK_BKhN_rTgmioptTvCLYGWd4WV0ig@mail.gmail.com>
Subject: [OutReachy] Introduction and Contribution Phase
To: git@vger.kernel.org
Cc: ps@pks.im, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi,
My name is Neema. Pronouns (she/her/hers).
I am an Outreachy applicant. Completed my initial application and am
currently in the contribution phase. Looking forward to working with
you.

I have read through
https://git.github.io/General-Microproject-Information/,
https://git.github.io/General-Application-Information/ and
https://git.github.io/SoC-2024-Microprojects/.

I am in the process of selecting a microproject. However, there are
some things I would like to clarify. As a part of outreachy
contribution phase, making one contribution is mandatory. In the
Project Contribution Information
[https://www.outreachy.org/outreachy-dec-2024-internship-cohort/communities/git/]
section, an applicant has to complete a tutorial, microproject and
then make a contribution.
While I see detailed instructions regarding the microproject, there
aren't any regarding contributions. Is the microproject considered the
contribution? or are they separate entities?

(I apologize for the double emailing)

Thank you

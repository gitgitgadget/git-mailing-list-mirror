Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8488010EE
	for <git@vger.kernel.org>; Mon, 25 Dec 2023 03:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5b8nohi"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so6767e87.0
        for <git@vger.kernel.org>; Sun, 24 Dec 2023 19:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703476021; x=1704080821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p12UJ8qzovSwkQYAv44CZ1HX8vBBMbVHij+U9pKMzqM=;
        b=i5b8nohiF+WoWr/39KO2BFsfef8dAPkCNz7AVC8Idly7bRdTtYpQ4t6nDAsPZXKffw
         towkI6fJVBI7EU/v88pq1m/kFEdMc0O1P5vntBjIXhZ7B0l55YsizABVVR0baUJAGGhG
         8TtfqGLa4Rg9rujqPKOYKEX5KxMdEBYR3eiCPGDgX8OFoUrmJqlKlN+7OBeNYq7/r8JM
         Rv6XzRgy8P8A3mjogb6YGwTHrfJzHH2jiIMk0vCvyHlnDsrQP7JxdE+UgE3g7FIKoLHv
         Byyrx2RrymagL1m1EaKdcT9kdWkSQoabMG5fomeAZH+/5Zo5DlOSkGgdzoMO5CFA4sw9
         PaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703476021; x=1704080821;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p12UJ8qzovSwkQYAv44CZ1HX8vBBMbVHij+U9pKMzqM=;
        b=AHKzzBimi7V0WfxRnhGfoJ6ZStuQ9njkHc9oT1g3dJ4NqdRJb0yMlP+Iwm7RbUDZRs
         JDzBgEqFAXshNKfHP/y7Ia6tY7S4m/ghqay2kfvJHjIGUUsYv1f/NAqAyJQbBZCXTgrw
         V0Iqxket5tzMHVHQbXOzosHKC69Rml7DatgI/vfJLy4s+iqZwUOiLps9KhhFtD/FeOG/
         M9zDCtbKd/GF6QPTsRWSLNxCl0CmPYCLa0F4Ng1ZMmkJie0pkr4iqQz92CZTDPaBTy9X
         be3PAFW6EgRX6tSZ4qK0270DjZiht5iW3QpG0xBaOWXYg1WbfmeyJrK4gRvIZkBBE/gj
         PLtw==
X-Gm-Message-State: AOJu0YxRPZnwADViHCY6YOtGFM3YGYuhI7nfV723CqT5Q54FveFxOh3e
	kMxKYiXXRN08qtkyBjqO78VEZe6/2Umv5s6Z2p2g6ep311iTx5Sj
X-Google-Smtp-Source: AGHT+IFg12vC50/HQjJekPqWcSq/mNhsXIfrTZhDX11S/mNMOhc8vrDrQG3TamszDuGGEI3LfEVd3hd3POjeztE6HJE=
X-Received: by 2002:ac2:51a2:0:b0:50e:7be2:83cf with SMTP id
 f2-20020ac251a2000000b0050e7be283cfmr94247lfk.156.1703476020976; Sun, 24 Dec
 2023 19:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ZheNing Hu <adlternative@gmail.com>
Date: Mon, 25 Dec 2023 11:46:49 +0800
Message-ID: <CAOLTT8R-wo+20Xt94mBsC8gaP3aaAg=aa96K8fTjYQMyaC0fJA@mail.gmail.com>
Subject: [Question] Can Git Diff with block context
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

In our code review process on our coding platform, when displaying the
diff of a file, we add a parameter called include_extra_info_lines,
which is used to expand the display of code lines related to code
comments (I'm not sure if this feature was ported from GitLab).
However, in terms of implementation, this feature is achieved on the
server side by a very cumbersome method, which stitches together the
normal diff and the diff of the code comment block before rendering
it. I would like to know if git diff natively supports a similar
capability, where I can specify the first and last lines of the blocks
of the file that I need, and then diff will load these blocks
together.

--
ZheNing Hu

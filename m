Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEE33F9
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742973439; cv=none; b=O4mPVu2vP+lcs+oHIvkdz7pIsUde/ghOd+ZTil4hGYOxsdCCKMEhvUtI9TBSnZBCHMsIgP87Ry8dEv2jynkqQOgQXa0/oWtv4v6A2dEwFNxgDsGrFU7erAZJGTKUbk52coS9WkpF81VnQQJKm7FAuxthqaw5LX8wb2u0moKgD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742973439; c=relaxed/simple;
	bh=fHl+uOuxQE5nL2uTqNI4F0tMI1SquMGUo5szcHl6GJo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ggtXhFl60Qx5P+bsvGfEtdrJGvH9jPOpSW5PjEZZeAuBsSPsSgL8dEhuYo2oWauJ9huV6ADwp0yBBxnviQ718vCiRA7LKPL/7oYyGFXWr86DitnUJ0QUPBN5Lc1zHwBtkdiPy4+MvpB2UMRXHlyTCAr9PtpNdnUo2vxNkzpBBRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ES/uONr2; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ES/uONr2"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3f9a7cbc8f1so1908476b6e.0
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 00:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742973437; x=1743578237; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GL8Hkp6ZurN4ipGfpLE+Uw8xW2fTqHflTFrKfZtQQfo=;
        b=ES/uONr21nN901ZZZtpPoazIQe6X4ksHCuNwzVoCeyUEHZZMbvUGJ9L+z6wlnUo0bq
         CR+brZvoThTqFAI4HaGFLinFktMcmExg0A8wJEahIxklcclOfV61WuzbcqmXCRQOdc5K
         Zkh+gvjGL85/7mObEKVnn0lLEr+D4+3juXw/3tNwg1RuiweHe2I3Kpf9ILQNerAH0Ah/
         JZ6rQdv8H0FrgmTH2qJ8SGWZa78dPxlIPJg+73TIZdTTPJFZZksdSYJs0rrypPx8p+n+
         Xh8zSzobvaCteAr6mCeGWORaElu8N1cJcGIPeWqMANnAKqMrVH3KUioD8CQ8WC8/fiHA
         dMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742973437; x=1743578237;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GL8Hkp6ZurN4ipGfpLE+Uw8xW2fTqHflTFrKfZtQQfo=;
        b=cNVlypZBpxbv6fi/C/0x6eBjqS+5jgHoOqDT7gCX0hewvlvIS05PDdAlYFUps81Veg
         3nRfrUZseyjNflvl3HDBZSn3bgqbKR0So+bUtgavAP7SWYGOd4jN9ENHID+ws6NPIRae
         Ym2JstdFrQBCtEUYhKDFICTpZvQhRzYXumvpCjphZEMLR3+uAmj7blwZC9ltVfJSHbYh
         5Yxwpu8FD8HL00+zSedggt+B1SIZRnqJ3T9yy8fAX2AqoTnDL01MDXwNzuD+ppKLMLrJ
         GDIdgNLF78/+vWnmqQtCzgi1XOmMpqiDbtpsCYg/cRU7KhvXLDPoSdxXBCHuApV8ynBS
         ZKNg==
X-Gm-Message-State: AOJu0Yx9bC8Wjexd+rTUR8nZx6RNEgjSqJXQScWe8enzuymZEv5iKhUp
	DDUUODOstYSOYzJmvKLNyAFKAxY7ulZjXjFjsInYjJ4Q/7QNOGFsibgKlsWXQbSQVp3QGuATYD1
	vzOk/RjcKZ9F7fRafAn+sXbFIfLtdmrTd
X-Gm-Gg: ASbGncsoFYF8XV6gWZb+nkBf98RQUBBW0lzltkzzch6F3xhJ3wjtlPZTR1VP0mlS3A0
	sU14i9N8k1Fbv3T+B8jwfST8KgXQ/lBLx2HMJaeKno95kfhgtt3ZId3Qa0m0v5Mh6gOOBPheioL
	Boku354mA/Zs14Y0EfW+wKRwGRbC4=
X-Google-Smtp-Source: AGHT+IHHy3kP2p0oGWtYPoBfP0o9wMfkxw5np0g09Q4dap9L98BDHWpXRV1yTkXMqcTjFnWcLeT6RcKRG1Ba0rXnwdk=
X-Received: by 2002:a05:6808:e8b:b0:3f7:4b65:582e with SMTP id
 5614622812f47-3febf7b2984mr13749243b6e.26.1742973436790; Wed, 26 Mar 2025
 00:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jarno Suni <jarno.ilari.suni@gmail.com>
Date: Wed, 26 Mar 2025 09:17:06 +0200
X-Gm-Features: AQ5f1JosfY8XNrAJDO1-YIc2L4X96vNQplqcHhnJAB0z9nqLpzyn3cj213fqnrM
Message-ID: <CAOqj8L0hknJ2aYGSmXdUvRgzHZRWBTMgSvywGpc=TUZL-Dqnmw@mail.gmail.com>
Subject: error: could not parse 'Drop' when rebasing
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

git version 2.43.0

$ git rebase --edit-todo
error: could not parse 'Drop'
error: invalid line 1: r Drop option --figure-soname-bumps
error: could not parse 'Drop'
error: invalid line 1: p Drop option --figure-soname-bumps
You can fix this with 'git rebase --edit-todo' and then run 'git
rebase --continue'.
Or you can abort the rebase with 'git rebase --abort'.

"Drop option --figure-soname-bumps" is the commit message.
Git doesn't seem to accept any command for the commit. First I tried command d.

Workaround:
I did `git rebase --abort`. Started new rebase, used r command for the
commit to rename it to not have "Drop" as first word. After that I can
rebase again and use d command for the commit.

-- 
Jarno Suni

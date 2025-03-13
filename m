Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9E4645
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846989; cv=none; b=cMe221hWM3pUNwrBvGA0zG9LEfcJg6ZY4aFGqb2YGRMSpxqSPPrN4l6aRVg8zSl2pTOCsYoO82/J3PJL7NJJ51r4jg31URDeFzcf7878o1fqNI82AB/Vdr+1JBbVF8RtobKG6r+SMBoPGq181x3VxHrd0DmZGnkoRuJGH2//KqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846989; c=relaxed/simple;
	bh=HLitd1UjwS5bL39lpUXy+pB5J39hobsT7j5T+cdxYkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8VIOYBeEboKCwNXuZdK3jpouUAQ7wM5U9bXAq+6R2oR2qilpXeN3JVkt291J065nPOR6jE5Nqs2YZDrJT6JEHIg3M2D+jJrgKJXG09kZUx5ovgBCPuNkAHsYETYRAzK26X6YnMUSRJbmwCI/IYCaXQyONXQg+7OeFDa5SYCC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGGB2Wew; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGGB2Wew"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d46aaf36a2so4544795ab.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 23:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741846987; x=1742451787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve7ipnukD5+sILPZywaecngHzzyXAKDOvg98fhwsIAY=;
        b=WGGB2WewydgCRqTwTcXKEHxyHeNco5tlabxTOCVKg5f4SLhtdch/uYizzVMpdTuLX+
         5CHH329BXADOfq9yugos6P6OgAahdSDvXNQ1V1hsehbAR5QfKuxvrilgT+tzsn1vDcsR
         u8h6QeZNN+6RmAKQ6/fWRr1zQqDtJwMmexSf9NLDZvFSI3kzDjRrgUwa/19BH+XoCSX+
         7g1cUIH8Xfw8S5VfbOl3af8imrILXkZAcEcfXjyCHXD/3xilpxnNfwqjK9pisEpZWJMu
         7IbDyGwVsNq0PlFHO3Bvkf3OtAtpdr3etDmfo+mj/aGAXq5ydvHn6KJfAECj7010Cy5y
         Bv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741846987; x=1742451787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ve7ipnukD5+sILPZywaecngHzzyXAKDOvg98fhwsIAY=;
        b=rJ8nmAv2FFOA6b2TCdwOml9u9f72MsH9lqaXK/NMfjD8W8pIq9TaNPAPYbBvWP/igQ
         Jwv8bExMQ0aYj8n75cibXwCDRnNniXCsAOEWlrPtvSRReE8IM5Tef2MyjLTS5J0I6gSM
         LLvNW2rzLTTHuggLeWSNHIsp+5afyM1YIObNUa24e1JZtwneU7/pKb6tZiC0MVcS7k2b
         CgO5NfgvJqjizGrnClqgVPfkE1jx3HSLhUIQMF4C52mdKRBXaL9degGOyv3hA2Tc44Db
         gynslBcvR+rJ7mtHob2Y5zParHxMwtL/zDu5C57oW4ZNJqj/hRNC4kPUuVyEuePe2BcQ
         yYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuLzYnMqrUan+ISpf3wimNFMDph+GKpvQkG8RkzE9KGYFaVPBKSw57LW+jisWfRNg3ZQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGxPqbHi2sX8wtrFMgIpVQ8nyLl9Bc4EQYQy8PW7X0yweL5T9K
	Ngfik8sfIlcx7QCB061JTUIiMWyRlmizME3H9OCMHODCWNSUyjc6fxc6mN7lgIqeKD7HuiWaJ6s
	4MkVDK0rz21NBoIRF+6p5m2Z2baw=
X-Gm-Gg: ASbGnctQHd03d78RqJiTQFErlxYQkuifkzkvvFRD6fZcrxg6LG4CahDJVgpdJ2NCHUC
	yXAyPJCm9fQCcjQgNtfT53UDk7YGBcGvlplorljQsFGdnmSs/hnIIyVw4yHyDZDQoLF13jQhcXm
	PYR52FgMBE3Mclv1sWd05UhC8OeInOx9P2CBjYGBA0trjONx6lWufyJWLgxC0=
X-Google-Smtp-Source: AGHT+IGVZzv4CTNjYRyPtpM2rGYbR3kBn/9bSLP/mFKSAU/P1No2E1r67qCNzvSsAwAIPsp2NVNrs8hZvrkFZcbBWuY=
X-Received: by 2002:a05:6e02:184e:b0:3d1:92fc:fb45 with SMTP id
 e9e14a558f8ab-3d44187c0demr301220315ab.5.1741846987539; Wed, 12 Mar 2025
 23:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1873.git.1741275027.gitgitgadget@gmail.com>
 <f48b3310d4ae8d05780fd25e467083c4dc9852cc.1741275027.git.gitgitgadget@gmail.com>
 <Z9ID/2zx25qesuJs@nand.local> <CABPp-BH+9JcP6FDP6RFQzZbwW=XOWnWAR8PmrCS6hG4iyd2pPQ@mail.gmail.com>
 <xmqqr031x2gg.fsf@gitster.g>
In-Reply-To: <xmqqr031x2gg.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 12 Mar 2025 23:22:56 -0700
X-Gm-Features: AQ5f1JqIF5JBnzxhzIwLPNr6bQeX-_wmduFGSRMbzbDIXKinL1JajQlRTunaasA
Message-ID: <CABPp-BF7iTvqKFvuOZ5wZ3vZADjCvB63iKR-4D5+WeTxnZGThg@mail.gmail.com>
Subject: Re: [PATCH 2/2] merge-ort: fix slightly overzealous assertion for rename-to-self
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, 
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Dmitry Goncharov <dgoncharov@users.sf.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > But it might be worth mentioning that having side-effects in
> > assertions is a huge no-no, and I understand that when folks have to
> > debug one of those (I had to in a separate project years ago which was
> > kind of nasty), that they sometimes jump to the conclusion that
> > assertions are bad.
>
> Yes, assert() invites such mistakes.  Why not avoid them when there
> are better alternatives like "if (condition) BUG()"?

I mean, I just gave my reasons above which you snipped out.  But if
you feel it is important for folks to move away from assert(), would
you like to see someone create a better alternative to assert, such as
BUG_ON(condition), so that they have reason to want to switch?

Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81252E62CE
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743718273; cv=none; b=e5zietQfPvfB+EBoYukzQUZMVcr1MQCcUz8nvsxOrsWmEXqSh/HzF4PpMU96Ezjopvfd7htz989UpLp2+8AVMpxBGO/Z4ld3/qmEZ0aSGR+4BDYsBatvx7gyXCVeErtDkXSWq1mX1IUyGxZZhOITm/1T+f/EyEfrj6QVI7nETwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743718273; c=relaxed/simple;
	bh=cq28vkISH6jNMUQIFw9SyvcOomQhbM45/UBdrXX7bP0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRHP966XzWYHYZJKHK2jx+q9MVSvxKGSLvYKzm/yAggqy+vPnq66o/F8dqTnSiovpdS39FaI1y/kAeXbOhxL+jn2pcuMUhu3f2hGDWY1lZU2NXH7Z2u1P4yF0/4/te3eOJhEiR3E0+djjtotqQws5l7IgoHlVEXIB/g7/T13FQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Au0HGZgC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au0HGZgC"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f2f391864so776533f8f.3
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 15:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743718269; x=1744323069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R48i0NGAyHZwl7HaMJpL9EDtQTkFBWFeTIKU8upCKmk=;
        b=Au0HGZgCi2ie/P27ghZrqCaGFZi77f6HrRWvFgWZoKXQwJwfmqWOxyPwhRDMPPZI2M
         UF8g5j30O6/kMU0bIjk/Tqw8luNMa42US4pVT1efyx35H6p0IdTYDoOqg/geIwnIZZTd
         ITpAY0FQsV38VMGXqsEZJNUyzUtHN5X+jEMlJE34S57vuIHfmwyG1pgXhCtOMa3qHSKo
         ywMyqxAb3oWci7CnvIKlLh6yem0XgD8JPOtkHFCx9DbO9B2IjDAIorxwgHwOKfsQKDva
         CGJkOKsRB3kGLzF5d6Yrd1NS9exBl4sujdeW0xk6k7IzWgcvHeN6S2zx6QSKAaYGl/IS
         aomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743718269; x=1744323069;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R48i0NGAyHZwl7HaMJpL9EDtQTkFBWFeTIKU8upCKmk=;
        b=chMPfOu/u+AStaMsLWSwGtwW8y2Mj4er4aecNhhSFiV029tzlfPlTjHBbNokmJpbN3
         FcIGE88TqsRDPJ55IfOZomI+TxBn02L8XEMEdSZ4PwiuqCSxCVqRUnZxLZhlfsGN8rMK
         ojVVoznU0TlHJcTjyAAuW8z1RtilcDH/+r8jRbcdIoFGmhNDR61hL6Hx3kti5JaPxv81
         B7dQoSJO4ke8XepZT4gJn/955e/234tWGxRCccsVz6tBHrVIF2CoTm+MP/SWCKCMRxRi
         ppY1SG4XiK9qUCsb/349r96OzubLf6j/gVFXMLhyj+Kz7NkcRDhRVIQ9mLaysuX5EgYn
         LoHA==
X-Forwarded-Encrypted: i=1; AJvYcCVD4Pv9baebPVw+B5H+ojMoEWYG2hK4jakTDlAbSurwN3NLoHmsr/VmdYOta/Ue8xUcF6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwI2yyp7e91jeLkn9XpU3XdRmc38FwaWxaXzI+WTVhFrJEEkQe
	HPMDi0CIKODhmC9UqSra/0isQxjTGxtp3n6jLvaVkub4EnO5QH+MSTNm9LUUUgQfjVSHMDc3Mai
	8CIGBQ70rdfTpGn7AmWNnG/3eUMdyOwe6
X-Gm-Gg: ASbGncu4MVLZ2GHzh++A3XfdCuM+hEuJabUGkkWYOGt205MGAaXKlPOOdSV2Rahjb9o
	+8uTkv7gxGvLNGB/8pqRUBdf9VyUtxzpwe+EZdfsXcIjnTwLtlMofzdbTbZbVsgi6mXRkR4sgCc
	Zq3MBc9HAGZwi7roKWYxudxdv9hBU=
X-Google-Smtp-Source: AGHT+IGJd2YPZYRuNp4rarzKD5mnDz5c9viBERQXAUrW7Sie4FEw6kd99IXQ7xu3ZqiBS34b10Nff0Ao6zPLIVQD2Cg=
X-Received: by 2002:a05:6000:2484:b0:39c:2264:43ea with SMTP id
 ffacd0b85a97d-39d07ad8a7amr358255f8f.3.1743718268829; Thu, 03 Apr 2025
 15:11:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Apr 2025 17:11:08 -0500
From: Kane York <kanepyork@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <D8X5I3W7K1DI.2JYHGNY9L7ZD3@buenzli.dev>
References: <D8X5I3W7K1DI.2JYHGNY9L7ZD3@buenzli.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Apr 2025 17:11:08 -0500
X-Gm-Features: ATxdqUGPUhe_gJ_dJdgR943aq7_wQRD05VniL6P0FU7hynTIBFKeMT88nUdFsgs
Message-ID: <CABeNrKX3fY8qmASgyKaSv99LkGsrcExKFwNtgaKqjfJdQn8vrQ@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: remo@buenzli.dev
Cc: ekempin@google.com, git@vger.kernel.org, martinvonz@google.com, 
	newren@gmail.com, philipmetzger@bluewin.ch, scott@gitbutler.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 03 Apr 2025 18:40:20 +0200, Remo Senekowitsch wrote:
> On Thu Apr 3, 2025 at 5:39 PM CEST, Elijah Newren wrote:
>> cherry-pick & rebase preserve author name, email & time, while creating a
>> new committer name, email, & time.  To me, the change-id is about the
>> authorship, and since these commands already preserve authorship, it'd seem
>> weird to me to have cherry-pick not preserve the change-id by default.

> I'd say Jujutsu, Gerrit and GitButler think of a change-id as associated with
> a unit of review.
>
> [...]
>
> Cherry-picking on the other hand often represents a separate unit of review.
> That review may revolve around whether it makes sense to backport a bugfix at
> all or any additional changes that may have been necessary to make the bugfix
> work in the different, older codebase.
>
> As mentioned above, there's also the issue that preserving the change-id on
> cherry-pick likely results in duplicates. For Jujutsu, it would be nice it
> this was avoided. But it's not infeasible to deal with that either.
>
> For Gerrit, it would be important to be able to track a change across
> cherry-picks somehow, since that is a feature they already have. If Git
> decides to preserve the change-id on cherry-pick, there's no problem for
> Gerrit. Alternatives include storing a separate cherry-picked-from header or
> enabling the -x flag on cherry-pick by default.

I agree, and propose this concrete behavior:

- git cherry-pick generates a fresh `change-id`, and places the old change-id
  in a `cherry-picked-change` header
- git cherry-pick preserves the old `change-id` if passed the new
  `--preserve-change-id` flag
- git rebase passes the `--preserve-change-id` flag on 'pick' actions, unless
  passed the new `--no-preserve-change-id` flag
- git rebase uses the earlier commit's change-id on 'fixup' actions
- git rebase prints the change-ids into the COMMIT_MSG on 'squash' actions, and
  tries to read the user's choice of which to use, defaulting to the earlier
  commit if both or none are present
- git rebase creates a new change-id on 'merge' actions
- git rebase needs no special behavior specified for 'edit', 'exec', 'break',
  'drop', 'label', 'reset', 'update-ref'

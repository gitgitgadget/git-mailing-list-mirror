Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D5B79CD
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756426527; cv=none; b=hd93KeSnBUgfQGaZCds3HWlpvzDyLOFhMp1w72G+dvrd3xjX4lQ34lnjgq5tRmetr5LJX4m1+X8baZTUUN9cu6xfhW+eWL0hm/p+5n6zIh8Dmjww46gw1PI1OgPntDC3Gk85RmkQIdHVKC8wUocQvh9yH1QEExerklUC9Lf58Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756426527; c=relaxed/simple;
	bh=PrqF0CteG81x8clf4Wq2DzPityX52MJMIDBhfbOON0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5edLPIHd2QHXJ/1zj3+NyUqSSYZKL9va7yLeSdTG4brzAK04J8isP4yZ11g+FGuiAMaxosqSjJVTcdSL3pfKj8U0iCobWgnrGmWSG6jwO292bp79yFVG6OkTbileZI8aZIbV44H8FPV6RFlrZJXsMzmuTR87YsV9ZijZiz2cH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVk8SWC0; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVk8SWC0"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3f29ebce11fso1485895ab.3
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756426525; x=1757031325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gi6Hw1DBJ7u78axnQeRzGa9IRaSnFTKR7FrmYYXyIjg=;
        b=jVk8SWC0w+prdiOo9JlCLx9wYU6aJubE9vf2tDpegW74mhrOq81KqzwtHABWrVspBy
         /nz/bnuLkYPKI8+8qodNw9EByx49Dcse7pVeNIpnyNL25Tn+e91YVrhDKHT6nGfJOCiq
         Hdd2q2fOSk+E+FF1evmqswsfmc6kJOsZ07FAL38IK7LlhWCUrrNEayrMlercWvL6n1Vj
         FkDgjzjtUI7dsdp9/TT2hnsTKCH5ZizBsWj3fuN9/vsT5fes1zjQtU82gtGjMXskP0Nv
         5QtRCPGvbJiPxniKR/nDQUNm96WJ4ZsEHsFOa79FLF/6WvqvFm71mt5T1vZnu7SrrrdZ
         FIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756426525; x=1757031325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi6Hw1DBJ7u78axnQeRzGa9IRaSnFTKR7FrmYYXyIjg=;
        b=Dhg/TOMvZ8sSUAeDymC/NRkkrOnDGgDTh0UL/fXBQdKl6CyFLiU2dlG+zMeB4kWZ9P
         N9heQBIg5qQLl2OzLbjbsdg/g82+pLgN7IXbHY7QfLNIQZmeS+Hl5SMCrgN4NQCXoSai
         OkInwby+mShNpsaXBEaCzuBOTjGPkFBtCLFGJ0pFO9z2RmNFotTmb0xpXnfcaik3gtK1
         ZW0gTKlqyvcy3cCHplea1KzhvmJrAlTn+3WKR3do9C5cgbxq8nl4w1Ng5RpYWEy+dlZJ
         4ASS9picyt0DRg9+1VhJ4lZOpEUo10qbxEip/o2nduLG1qGRsiQ6COCPJqviqUUgV8iv
         xMJA==
X-Forwarded-Encrypted: i=1; AJvYcCWkZQFWcAeBp12wpZmw358nTxR6lqrXRnEX9WacKn7FD4zHlZQffIC2Ge3v3zglhC6bbpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL+Cq3D/Ss8KAhDyDXMtUSe2JZDeE7HkQfEQwM0U9h+s+sSte+
	ZWdcuOzsSX4FosUgi2YL90a4L2im8zuvuklCy8g9s2eI0ZE8ENVkH/FYUp3/FtpqwiuMSYJGuLT
	ly9eOjimX/6GhIq4Xg1sc4YOt6YESjz0=
X-Gm-Gg: ASbGncts06IHst9JRWDaK9XKlRfwC8c/vdmSA2NUl38uOsQcrJ/hvVLGTWWTPFLIKCE
	t9zY8KlOFggGDGtFHE0FWRG5ITkrez6GDZUyE+Gsj17sWmN1fdOMgEarq/GPCZfFI8beMm4WpPV
	irVg5YrWBtKHNKGqpX7tYao2E2jIC3F7wqaTFULJwJlDZohr0RLcyn0ML/28quXWSUGd2j5QVI+
	W8Cjqv1oV08cZ6fKiDqXhGrAZ/AAvbFgHg/D9lUbdq7IKV/JXs=
X-Google-Smtp-Source: AGHT+IG5I+57ARMoTM7ejspHoUiB7S/PqEI7bmiggKBWmg4KZESlPsZ5fscmfWU5OxAt1FtRF4UFAb8aC7kUXBxNfGM=
X-Received: by 2002:a05:6e02:214c:b0:3e5:42ec:1352 with SMTP id
 e9e14a558f8ab-3e91fc24c59mr319905805ab.4.1756426525374; Thu, 28 Aug 2025
 17:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com> <xmqqzfbjqbfo.fsf@gitster.g>
In-Reply-To: <xmqqzfbjqbfo.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 28 Aug 2025 17:15:14 -0700
X-Gm-Features: Ac12FXxevemtdqT1tRuzpRVEFtF2BmYWY2nOEg0AJKGqLA3Vrk4ls535NuGQJM0
Message-ID: <CABPp-BH=tk3eenHJkbRcD8uLGuakNMT5GkjVt6WfmOO8P+xq7A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] sparse-checkout: add 'clean' command
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:22=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> This seems to have a few comments that haven't been responded to
> (plus a "This step looks good to me" or two).  Can we get it unstuck
> soonish?  The topic is from mid July and I do not like to hold topics
> in 'seen' for longer than a month without any activity.

Stolee built this series on top of Ayush's topic to avoid conflicts
for you, and he said
(https://lore.kernel.org/git/c3c0fbef-f395-4972-8352-dd89af6799d5@gmail.com=
/)
that since you marked this as blocking on Ayush's topic, he didn't
want to update until that topic moved.

Do you want to instead kick Ayush's topic out and have Stolee rebase
to no longer be on top of Ayush's, and have Ayush rebase anything he
might do on top of Stolee's work?  (See also Ayush's recent update at
https://lore.kernel.org/git/CAE7as+ZpEwiNsDAozoZXqHRLOF3+hT++uo=3DmzZqEvTPo=
vQN9uw@mail.gmail.com/)

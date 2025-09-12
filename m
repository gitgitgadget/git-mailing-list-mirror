Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7866326D65
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699095; cv=none; b=fRDQj59LcYxg2ZSEF0NGTOURWkVJmCSUFmgrQXU/5T91w5k55/q88xpolZATdjNaOl592vC6JGQEkeTZy6OJW/lB5Hb1VrTdu+GYuwJpl7hpLYT0eo9JWss0lyY5j0mht4fp5N1ca90MfnUYZonmT7ujEx/ZA/OH3u5Bu71poSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699095; c=relaxed/simple;
	bh=56+u9R75gAp0OpC3dkDgNLC2rpxG31KnJo2OTrJ3cao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5zAF3cxNZurxRghYkTIMXoooIPSJrN8/9CciySPzawVj2jE+lK7ixOFwDmCH1t4cHpRUMiigjPePDwJhRoSvD6+ODUPHbijeaCqwfmHsaqeIN2MUvtp/EOA9DuXG1PFzfDoDhpz4fKQMiFWiMXFw6SyYz5lwyC663/xGxWyIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0pbfD6w; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0pbfD6w"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e970e624b7cso3072294276.0
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757699092; x=1758303892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56+u9R75gAp0OpC3dkDgNLC2rpxG31KnJo2OTrJ3cao=;
        b=j0pbfD6w6f6UE/PGOpikZmKWKDVHljay9Q4f4OzujW4WbDkyMmfUq3/nq51T/ElJFD
         2qloFrDku8WBMhIZj46gx8AW92C9bxOCX3hmsf9jkrYmyBUmCwCv6RIbIitO57KCgSy3
         8K8sTqfmFkm2Vv0ftk41zwPW3mvpwK63aD4AkkhsSiEKEGP9N/ZIpWR9MsG44RaUtZnq
         q9jJf/bzE+nq2NkVp6cNHKoAsJK65mr4LJJYTV03HQZcOEuX2VyPhbsV7e8gj/nk5YsS
         XEHa9WWjWy0vIjwbvWapYc95hWWuUEw7GLklFRAQL/3YShE4LRHkfOfKO4bcNxgbSBba
         bhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757699092; x=1758303892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56+u9R75gAp0OpC3dkDgNLC2rpxG31KnJo2OTrJ3cao=;
        b=eTxkwBsnz9KTOmhQOfHgDO/jZH5abNgLkpBE6tlIKiTfon63xi01GnYXd7v1whnIaP
         dkDcEyCL9Lq4nPJ29360HQbN3DUafhJZR5ol0hXpoTNm6r3ODfcCPfJhVYAzXJzDAwZj
         eXzcDiIkso6Xm8hNdRgKmtnYd+rNzoP1R+fq3PtXF/JExGBvLmKGA6cEvljRI8if0MbG
         lCExQEiOEQUersp4vXFRFU5+CG9+5JWE6kOLJtG9+R+GgMLFM4BgYdVqtjMSsAxN7Tv7
         /v0wyX5y2arYU4GKfg5vNVVnpjc+rCtnP+xSDT9w/mJEkCm+xDHwMDrfyKQUIYHrwmeF
         HqeQ==
X-Gm-Message-State: AOJu0YzOAGhcaPHTzu0cuXmvOEXsk/GHpnsAI4N9cJPHasXyEajf3OgA
	SfFOqY8WbV6JiT+vAZF6oQWXSQlsTSgJPdCYhtofB0WBX5xJpgQui1Nf06AWq120JHUDrMvX/fg
	YhgK9yctmcf22T8DjR+wZXrwS1GPJ6Gpvt3V+
X-Gm-Gg: ASbGncsiUBBfsn28Z57IsbE+m4YSq3o9/ye9KPhjBJvz+LQSpaeJ2QoDn4RUuBjkxzf
	vi4I5glHhybjlAaXotkKZzqt9bHGDpM0T66hG/HSBaOLmf3j98JB/4NMsZklHxvNwJtw0XeJ/iE
	QKXW/VhDJFMLkBBabwu/w/JApslzKXiVtOOlE1SWKTXZEcMbHNhAgiBYYO5b0YYjcwGZasIHLPI
	fbJ9vRo
X-Google-Smtp-Source: AGHT+IFEi1OZUeJpyIaZiH+8SJyCtla3fnx2rIHZmBTj1TKD6PYjp/smUFhZ0OZzxCyA++UgeRqbziQibA0bOd5+WDw=
X-Received: by 2002:a53:ab51:0:b0:604:3849:9c10 with SMTP id
 956f58d0204a3-627410bf4b3mr2785725d50.0.1757699092505; Fri, 12 Sep 2025
 10:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
 <071101dc23f5$fbf06e30$f3d14a90$@nexbridge.com> <CAJKmQvcqLzJDnpYg5K7_eUNCUdLCkkFse-wB+4R8KGxKo_e+0w@mail.gmail.com>
 <071e01dc2409$f9785230$ec68f690$@nexbridge.com>
In-Reply-To: <071e01dc2409$f9785230$ec68f690$@nexbridge.com>
From: usharerose <ushareroses@gmail.com>
Date: Sat, 13 Sep 2025 01:44:41 +0800
X-Gm-Features: Ac12FXxNNN6mFKU27UJ8R_0Z07GqBNWREFMupP-BrWMdJ377fAJiBTNuFtVNFgw
Message-ID: <CAJKmQvcEzs+rhM2+WeFphXqOUD3QGaRGM+yFUkVfKWYpyM3qLQ@mail.gmail.com>
Subject: Re: [DISCUSS] validation on git config user.email
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 1:23=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
> I cannot answer decisively. The functionality was first used in this cust=
omer about
> four years ago. I do not think any changes were required in git to accomp=
lish this.
> It is possible GitHub had to have an enhancement but only they can answer=
 that.

Appreciate you sharing what you know, Randall. My intention behind the
original question was not to suggest adding validation for email
legitimacy, but rather to inquire about and understand the rationale
behind the initial design decision to forgo strict validation when the
user identity feature (user.email) was implemented.

I will try to find answers from other sources of information.

Thank you again for your help.

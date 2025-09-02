Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26AFA95E
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838394; cv=none; b=tmntWrKeaK12TeLMlZHCsOYL2LDeXy+ZNsbDtsIWbAnkBAsgdv4oOXTZR/R2JUB3eFU7ywCTC9+mlZ43WJJqYjwlBzrSm18gi15gkjH0HJZwPW1pgAQtvSr1jFKkXV5/NQBUUqtoWvXaArs+N4Uu/3E2Jva98iAfdb+2NBFETSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838394; c=relaxed/simple;
	bh=+Sm9GOIpiN0k5/tWB2+0b9v8iCFEckisIQC4WG+ScmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Jh9majLrQs3RKBlXuP9FFctFKa3x7BNj50QYylrvwcS1v9mM5MuF4ncEqZ4PLiMgBjlFx+4YmrL7xc99P1uw8Zs79+pGSLho8QowR5gmk/5l+hgrpb000rDuSy06xt7QB2K1XOJIGBcAe13V6Z8C62OQ6/GfmK4dMdl+c/pU57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNuwc2BM; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNuwc2BM"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-333f92a69d4so44095781fa.2
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 11:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756838391; x=1757443191; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1l/V2w0TS5HYy0ZoU2SOf23jfOre+OSxIn91rdyeXg=;
        b=NNuwc2BMRF5H7c4mYKe0i7mWoOxSHq+7YdnxSL4iXWMSBMTENqqpI8L/WI0VtuWWHS
         nuZlfqBtdjFA4X1y+WG7cwXCC/9d05LaMrLwdHu62Flp0ba248LkDG5PYn5lkAzxJtdx
         zXZ89q2N12aAWtKMwFaW8+rzTsQI1l6gzbk6jNQScDprr6N+WSwsZv5cpX8OGeGAofPI
         aCvo0kUEvmlKncsUMh8PfxKmrrAz9h8mtoCtsdA0ukLErvC10t7YQaROEfhDY6KGw3H2
         1CEGHFzAlV+SLSR+T9pUmJoLm71t6r/mVV9GRCyM/hjks8hSNUkdr4J8Vfg63rbo6g9G
         1dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756838391; x=1757443191;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1l/V2w0TS5HYy0ZoU2SOf23jfOre+OSxIn91rdyeXg=;
        b=lvFQXwO/9DwiuHQq+FWIYglFRRkZ0S0xl5SqCN8K7Xw/sglu8ywwafwkc1Qui8q/lF
         C0toDXfYDptjwvVTRfP0q/CCYc6GsISkYwjLHpmIuGac0odgz3dZOzAGC1C6+Pu3xdS5
         5PmTFp+YZReIAbWY3eQxXWL4L7eI1bSLIt/zeze3zgbiB9WOgOIKW5U1GXJLOHSnLzWR
         QvdTZiKBXROGHWL2KKBwkZP9ddtrhoXcr4odkZDEdQJlsW9P2CC410AxuflN6YVJiGIC
         snr0miR+LOhvwJby6aFmddgOTgDB4jBQ599QAGUgd9/ZjWlQdGxMEajsQjaoAwi3Cej5
         MB+g==
X-Forwarded-Encrypted: i=1; AJvYcCWL0Ix6CR+Kr1aPsbnA7aLEHnAx+gQj/TNRQegtphsuPiKoW4W61Gf53Y2lXcjTc8fY3xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMrwORcA5HjTx2BM/uOckZYSDO+IaJuleladeRHDnToZmXh4N
	drGEZtV6fz0g3GPf1bPr8IoPMlgh8WpK2vGPOYNciMbK3gtvAt7zWaR6lkgMpC/n4yiu7MYwnQU
	HktjC/uso6cyPi3TXZU9Th+2DLC2H7lM=
X-Gm-Gg: ASbGnctjfxhklJuy0PYt7CxHxFtMihtCzi8MKhHD0nncUDSiWsjfW5aNh16231YscgC
	edNn8ohpj/WNrFJDcr41VKXXnx5keqZnzLrrVbfZ0gPg2o06QxGjWKKaQA45KEY4Fwt1MvW5XP4
	l5+yqZto0bzjQ3h6fi3s1SNVRbQ0idyDwb1ntkfCjrD2JqWAsM59W9fY4nzgrra2j9RQ7z12vz+
	AtDKU6zpKZpatypcsI=
X-Google-Smtp-Source: AGHT+IGi37hsflkiMOt4+g9bLGM6f3JFUsVB/tiIcsVMRQV7MrEYBWNdRnKEQRIJg/K39PQWM8K7dgLKBBi3huvqc74=
X-Received: by 2002:a2e:be1d:0:b0:336:dd88:6a02 with SMTP id
 38308e7fff4ca-336dd886e73mr25062621fa.43.1756838390592; Tue, 02 Sep 2025
 11:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <6d065f550fe871cf010409f7bd2a63438cf52723.1756496539.git.gitgitgadget@gmail.com>
 <aLIG5bLOisbxfn1y@fruit.crustytoothpaste.net> <CAH=ZcbBJV0oT1Ht6qVKmq7xG8ki9Enutq+VNes4n9+2r+0nrvA@mail.gmail.com>
 <aLcdwiRpD1Yo7SKy@fruit.crustytoothpaste.net>
In-Reply-To: <aLcdwiRpD1Yo7SKy@fruit.crustytoothpaste.net>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 2 Sep 2025 12:39:39 -0600
X-Gm-Features: Ac12FXzyVui41AeZYzxqJYQWRQ-jIvE1NlQNjh1rNWDPwv1cNd5Ng_JnLu5lHfI
Message-ID: <CAH=ZcbCgYEVrhejh66H4xqpuXyZj9jh+JqfH3mYik206-fVTSg@mail.gmail.com>
Subject: Re: [PATCH 01/15] doc: add a policy for using Rust
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	"brian m. carlson via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 10:39=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> I think it's fine to introduce it in a different series.  I'll plan to
> do that myself if it doesn't get done sooner.

Actually now that I'm knee deep in adding cbindgen to Rust it'll make
less sense to add it later. I'm currently working on refactoring my
entire patch series to include cbindgen from the beginning. I haven't
looked into cbindgen until now because I wanted to understand at a
deep level how C <-> Rust ffi worked rather than using an automagical
tool like cbindgen. I now think cbindgen should be part of the
introduction of Rust.

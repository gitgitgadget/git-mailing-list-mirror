Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28704501A
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753531263; cv=none; b=JZ7VQ/XPv/3t8gHPEJ5bt+EXtI5OmlpyOWajvzzvbnpbBaqIVaMBQ26WUDGKBvae2DkO9BXfXxckQtjBlGochGNiavpndsV11ow1iZD+lKyS7Oq+fxZgx0HGINfYrcDdGVtF0lyOLrIzsHkSuskDY3dpaQvdghbDfMZaKmbQ4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753531263; c=relaxed/simple;
	bh=h+haV2W/GrQNkUwmJpBMl3n/j5FXIZeSe7LP2/7XmU8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IzCNuh2yHjr9xjmj7/YxCd/SxZ+LBnXw/v6JOxEVFMz9ZGGnXPGjQB+hRQ1t795KA/rgrmIki1Ub9A+rGfwjIZOddJPjgW0FsN8nrXAVijUm/lSfmSMpfAQLpm+FRDnqSR+38VbFV6LUEaeyTP38PkY0/y3sRgExryjkUnLbox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjY77JPP; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjY77JPP"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32f2947ab0cso24981611fa.2
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753531260; x=1754136060; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6klJXBxBkvYAkXb2HpzG3s5eyiB36T8r4VSJcpBm8uE=;
        b=KjY77JPPVF25ozRPmSfxsNpkFbHKYHTw/QyHvuheGNVmQnTsZuTLhfYIxWTQHyZeRF
         J0Llx3aT2C0xm4OdqOAD2/19YXViF6Ca856Jzwkp4ZLhH2Y2KSmekF0amSEvRvEhBGQr
         edm7hBzn7XZ6IYgi26SOagSTEDg8bJ7JuHi+/pCNKwN/jY1zdWt/kYwX5MEWbJgC+ySa
         BKKyK/MFlUR+20DKBEQbFCjo+rLkdnoJSTRL/QSCla3LX4vb8J0/4eSYE33jqaxrRUEO
         eFR4mTJQH0VgZEDwStPAi8yyyblK/17b1vrLf2963Q2vXeHYmgu7ReQ53CrTnwJ6r8OF
         5Kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753531260; x=1754136060;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6klJXBxBkvYAkXb2HpzG3s5eyiB36T8r4VSJcpBm8uE=;
        b=DG3o4EWnKScAwzrnhKRuiYkWk9nLkx4m5dXthH2sFHRNYRj2BYZ0VzVqG9NvASE1iK
         C0Lzt2ruBe1MCJpk1oqxZ179gsGzpLJ3F2Ab8oxRx5EY/oFTpzWlNXps0S1RjxoLCtnN
         kBC4XmVFC/RyzgrP2enWUYt4P0QYYAkSPgNBnpv/CFqVvabX6dzxBvyXh+Q3dsRLwrB+
         uDqxX+eGTK+GNZKH+YaqNVIqA5rdK8jfdL5FgcIjK5JV33dJ0gFTZFlMFNH7PxrPMbEu
         se2o7k84GbPz/m4QbLsf1TtI2gxjHfxJbeBnHBeGoDeTnDSQfY9oNN9lQ0H4J2bwB6vt
         A59Q==
X-Gm-Message-State: AOJu0YxhflbL3wYXL9dgwYAQH3ngoor5Bzykcxt0tGvG4fXLCh5zESlv
	gBfekGJydAx3xn5+K4je+o4b7h8AGEhBPg3Jr234G6Cw+FQMUWVj1TWcSS277IbYdECBVhZpk9T
	5o2OhMdln4ckNdKQPmgnW70ULMPiUMRNu5fKV
X-Gm-Gg: ASbGncvSVg/OXW4eYYpA5tjACYhNLpcbpsYbQFyc7MdRbbvC0JSlsivFiGtAMbsP7wU
	CqkIYVEW55W3KJOoasfi/7GeBNDs5r/RXDEIhMK1Ja+MPZCHfYzIPEmJp4WMN34xYGNm1lZQrcN
	PWBCgn3SjsseTIFBAIdhYvY7q2QSHTp1AR6bZNal3MABQEIyhmy1Iu0TIkoj5IOlftSDs6U8+9Y
	pMnNjJU5s4l7LW+qjrr7Uu9R3QCwI3J3pjn8+ee9q81vNVjkw==
X-Google-Smtp-Source: AGHT+IHuNaXd36MOv54xwpvlXsSHusfaOw0DLmUe5it2HRTN9hMoKWEwQ+y4WGGt0wCUxJveQJy0+AUvYX3MfXknaHQ=
X-Received: by 2002:a2e:a009:0:20b0:32b:7faa:1327 with SMTP id
 38308e7fff4ca-331ee683566mr8872371fa.15.1753531259444; Sat, 26 Jul 2025
 05:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alon Bar-Lev <alon.barlev@gmail.com>
Date: Sat, 26 Jul 2025 15:00:42 +0300
X-Gm-Features: Ac12FXzJMn1dqf3mMDAbeMXIaXY7woytaQqIKpzpix6Jc-ApYpXIHOo_7vWaASM
Message-ID: <CAOazyz08vf65ezNMuUyOCYYHBGmDSeCtzXn=WdZAWGO9ZjCkAQ@mail.gmail.com>
Subject: [feature] git clean ignored files in nested repositories support
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am sure this was discussed in the past, I could not find any
explicit discussion.

The `git clean` is a handy command, it can clean directories,
including ignore files and also handle nested git repositories if a
second -f is given.

    git clean -dxff

However, as far as I understand, it is not possible to clean ignored
files in nested repositories, the `x` is applied only to the local
repository.

As workaround following command may be used:

    git clean -dxff && git submodule foreach git clean -dxff

However, I expect the double `f` to take into account the `x` and also
clean ignored files from the nested repository.

I am unsure if this is a bug or intentional.

If this is intentional, maybe a patch to have a second -x would be
acceptable? so that we could have something like:

   git clean -dxxff

Any other suggestions? It would be nice to be able to clean the entire
tree with a simple git clean command consistently in all scenarios.

Regards,
Alon

Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB632253E
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311677; cv=none; b=RE6LDKN6OvVY+H/VwunKZssAQYulvYt/AQ6k5yzQ5KXn5TxIBGiqUORGadnEX1fpMwQn0y/+bCcfByKjZKmXfXtgKBwVkgLbG+ZHE5Ae4k+EWSQB0HHzUbLGhsLIhMekWDq3X2bIo1W5vz5f029evpNOy/9GK5r5y2ISipZnrYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311677; c=relaxed/simple;
	bh=rDrgU+QbMd/prOW49Ryvxv+er0dC2EhpEPVElx9utao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boaKpTbxH5h/WJqQvoKdHznA2FNGXTxwazCBwGQuAn1tl6+HXu13f7UMnSu2bpDk2jobq5fH8TmZUeRHkd2S+uuH0KRgWF5/k9LP18gFDqLIFNFZfuv3VvpwnCY/OWUlrR+rc3MyPFv02eBe9M7mWVA1KMBlYLXNJAuKNAJn3pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaA7CPUi; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaA7CPUi"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-570d0c280e4so2878762e87.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 12:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311673; x=1758916473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDrgU+QbMd/prOW49Ryvxv+er0dC2EhpEPVElx9utao=;
        b=jaA7CPUimsG58D95ZAZrtjnFbe7TiShUXpmrnjtNsblsokTvYvS094wTYY20LudvpU
         hQvBCOzKu+44RnKne/VevqOcjiwQ1LjxbTN3df9sdQPkqugdZ77TCgjGtlvj78kbw9wo
         8oKh8hOahCEawAYFfZuRze+KaI5ohD/yiAZWKF315jRUSeJbx56Mxda7MaXIvX3a2caJ
         7H19qQ7MtAnwM8ixozDmGniwuBaFDt0pVmxuLZYMqEwjUrVEbIC0BGjnsNaRHffDU9QS
         YfjuzTFqUPQet2LwePgha3CcN16qnjRecDTcc1apc4oCiIfQGwN2lgQqOBiIGh+voqwZ
         b0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311673; x=1758916473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDrgU+QbMd/prOW49Ryvxv+er0dC2EhpEPVElx9utao=;
        b=hMyECc1jzown9iE7Jfc/z1XVoSTSBHmJdqWmWMCDkNonY7slhBqIV+nZKeQvqZ6/A8
         cLYkgtJ3ar21MZhjY47bnJE4fbSi4vZOBtR240BgguVLX5jS4MKLmbAi00h3jPuLjcby
         JnxST1qDx7XSSE5HDNaEx//1fjaPY/xMnu+7TNDHV+B76ZwG4XEyyktlZtZFn2B19hTI
         wTW+TuKczGeo67SHDo1ofp31UUmNWjFp4yifE82qyhogs8pQyAKOdBQZ1aOzBHHgjtjr
         U5Jxw1I4rDfLT1gkBeJUt0If/qrCpCz8KiNFW2Xg2Q/ixnJE6rnBeeGAntgbnrIIu989
         TfnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqZKa3Pkf5KRZRGlplYxd2D06/eBljFtvChhBr7XyxR1rNDy6bJUBv/dI04aPzVkGkCtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpQSZ0EqRhKz8pF1cmggbX0FgCYIIaqaHe0TaGHjNzPDydAmA
	K5WujXF042eP5gtuoNqr7J9gDqXPkFE4lsn9P1bz+ZHmCiFEq21qkIt0bBh19L59DJsTa/NBUce
	vhs+WF2mB9qelWJCHdQ3NzcozVE3nhus=
X-Gm-Gg: ASbGncuS4oRz5hLM5bfY2zRzBcy/spywasTftJHTJH2Fs2hr7iF33t2mwdO0zu6NH40
	GL3qPWRORXgLiL+j8wpFJJlSQxQ/CnZ5UTfg5mYeBTp6/aBmLy7xbqP7us1hzmhuWoYOtECBKpL
	H7/ymtNQIOBT+if+ncqhXRO+ZkMnhwKXMJIQP8Bqx6o5oR1DXi8g20ET1JccqNdmUNuER/kzF0y
	o6KwI+a
X-Google-Smtp-Source: AGHT+IGIVjpaS6G6cfaVARb+pZK4VwFTZz7s8kS9lq9iKsuSyz+8PBMV0pWTyoMmMjnINTXvAnoReXWx1RAQlVLKQ4Q=
X-Received: by 2002:a05:6512:33d0:b0:55f:5cad:28c8 with SMTP id
 2adb3069b0e04-579e2eaffe1mr1612865e87.39.1758311673123; Fri, 19 Sep 2025
 12:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <7fe85f0eaca88fd3084bccff6754c57a919e7d4f.1758071798.git.gitgitgadget@gmail.com>
 <CAPig+cTDUM5nVbBF5L3k+Gr5xYxXdH2ungVvkQ9QVbZCqMsLHg@mail.gmail.com>
In-Reply-To: <CAPig+cTDUM5nVbBF5L3k+Gr5xYxXdH2ungVvkQ9QVbZCqMsLHg@mail.gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 13:54:22 -0600
X-Gm-Features: AS18NWDuhoMGFaYjnQAKaH15rZfMSvvuf4nyNVJuJrniYEMT8tpK75Bp9MwaPOo
Message-ID: <CAH=ZcbBsE3AwoE2t=recg9kwtq8y0tXECRtU9YnbH0WVWZdCCA@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] make: merge xdiff lib into libgit.a
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 1:46=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> Please extend the commit message to explain why this change is desirable.

This commit continues the effort of making the Rust compiler link
against libgit.a. Meson already includes xdiff when it builds
libgit.a, but Makefile does not. Rather than telling the Rust compiler
to also link against xdiff/lib.a, if Makefile was used as opposed to
Meson, seemed like a clunkier solution.

I should have asked for a better way to accomplish this as part of my
commit message or as a question on the mailing list.

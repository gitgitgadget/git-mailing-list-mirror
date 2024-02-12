Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B826E4F895
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781185; cv=none; b=B6oke2XSIeLwSlquIZLU6fkPpuFlg+cC9nmAbtyEvjwWRjSL2iAQKJljGLmxyDgxsNNMo/+t/tNhUOSurxcrbfKx2OmeIRvWeFcn02ckiPUoQi3rb7RuWI1I6d0ofwkvxM87cZOY5n3LLwCDOnAYIOIN9dIIAY7Nk55MmmTvpTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781185; c=relaxed/simple;
	bh=a0juU3q6ddGDpKBq8Isni1Ka90kBIJM0LwbyHSXZLqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZdMQH3R9Ouc8nZH34mSU99BFWMXdZs6XeMST2hTHxBHzJK3DZxog4Li/xMiQwFuqA2yLaF/tvVIn8Od/8Vx6WtgiBsMJ0CRZJvwuo1l9OyLGLhki+Ns9hbv1bo5CDFlIYLzVIUQFvfg1yqP6Qp5WV3XcXBgdAYXL56yUTuNMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKiHRTlz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKiHRTlz"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a271a28aeb4so470474766b.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 15:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781182; x=1708385982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0juU3q6ddGDpKBq8Isni1Ka90kBIJM0LwbyHSXZLqs=;
        b=JKiHRTlzrqYOrRQs3kUamFwg+MtgkBm+8aKs5i216vG9c92j61i3a05Oz+JdFQPUEC
         YXrtge2HL7ak7suGrLFZTA9vqpeH/BO8ctlYXXBGhauKMqhI9curZl45xnJuNF+qffQq
         lB+tB4iY7fLLhkMxDcSZ3qGZz400shHcD70FHiOvW8yPFLxYCUZiWYOmrdUAx4UXsRUp
         g4ifcJiGhjHiE0P99KKd1ma5cO6PbzxKzTPY89hsDP/+cGI08pcC68OtoRatrnw7vJxq
         sWzjtMmZEntcQayl80su6m7xSHBKkL22sHTMK0mZ+FmORyFWFHIsukSpjlr+iWeyq3D6
         dGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781182; x=1708385982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0juU3q6ddGDpKBq8Isni1Ka90kBIJM0LwbyHSXZLqs=;
        b=aCTjdSfQIQPdBUW2G6MU/qCWpu4RL4rguLbAVhLaXTh+J5tqvcpK7gQ8sN6CzWO6wf
         Mo/N+HzM02s5GR8D2rSlPGVA2ADijjlP5x8RZfIW6+1vjSUQw133fgiaVtGiWM7tuamN
         rZJfkulD1H81YCN0Y02oxKeEJ2F6ydVRi8q3W3ZOjrO6PmIM3D2yFKhokh9gq9whhjJW
         SQFZEwNtFnPmyrIIutrEM10nyb+aYpZKDfodfLII56R97GvPgfNF3GzJq3Z7hY/yo+7M
         Rytgbk+Wtl7hGhii2qDV8/BRmCreX8+TIYaPnksRGjmZJSaYVKk9Zlze0VD0yEq/lKV/
         yN8Q==
X-Gm-Message-State: AOJu0YxMJnzB6mLwYiO9TqVUNjM9fYaQG6w0Rxpj3NSr5pwZ2aa6c7SC
	/pHFFCWhIss66ZUyPwfneVMfViOMxUnYaA+F5QjxSIBF2sKuU2dq3DhU9oHPIKSoPhnNooiV+tg
	eh+YkMZj4F0A0xnw4NzKZ2tuG9dS+WEt/
X-Google-Smtp-Source: AGHT+IG8t7kjPyh52Jo7gEyMjputjLIcyIqkbTZQfCdggMuweh6mIIAC4raoOeSiQUVt1bKaLKLXNlN1OsodaCkVonU=
X-Received: by 2002:a17:906:395:b0:a3b:b334:2f26 with SMTP id
 b21-20020a170906039500b00a3bb3342f26mr5646510eja.61.1707781181892; Mon, 12
 Feb 2024 15:39:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <9720526dd8a63b916c75fe9d6322ee13c8b36621.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <9720526dd8a63b916c75fe9d6322ee13c8b36621.1707196348.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 00:39:29 +0100
Message-ID: <CAP8UFD3u8qNpxObdOJDfBq+zVfxNwAG56bBcPeSC4i2=ZuhWjw@mail.gmail.com>
Subject: Re: [PATCH v4 26/28] trailer: unify "--trailer ..." arg handling
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Linus Arver <linusa@google.com>
>
> Move the logic of parse_trailer_from_command_line_arg() into
> option_parse_trailer(), because that is the only caller and there's no
> benefit in keeping these two separate.

Well one benefit could be that 2 small functions might be easier to
understand than a big one. So perhaps
parse_trailer_from_command_line_arg() could just have been made
static?

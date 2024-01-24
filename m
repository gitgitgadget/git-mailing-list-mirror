Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7C17985
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084618; cv=none; b=ZAMfwNkwHqghowzy1P7Ojnv1hXAZt6N7cbHwfjqNkM4z1bZhxM+4gD3Z0PEJ0mp0rSZEtt4zT7PWsPo9j0hAZqrhV7bloM/bOf98jxrzNh8qhXKeTPYmGQ0MLCTZyFIKnpynb4bb7kzYnZuMDaSe9fpNu3+Vx+xh5TuDIuaGaw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084618; c=relaxed/simple;
	bh=/73wtjawPg9pZQTgjFY50Kyr7lXHYCt64sbkDIEFplw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JTZfSLDmiKGLO8S07YqJ0bo6kslp+B2RQ19cd741o6tKVWMvRKvgwtN94dSqzjpzpySFD7/slcUvTskq+gYSbQp3Qr1XM3a1FbzsU8j3YQEXzkojiRVj8ao+2EyY/FrV8NuXcvhrMoU9rM1hSgsbFBWtYq19dwH603403OGBcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSDyABJD; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSDyABJD"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e72e3d435so4773989e87.2
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 00:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706084614; x=1706689414; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xuy7OX3axI0iiMzuuur6ujhVfR8b/UQiDsRCpQYN2vk=;
        b=LSDyABJD7gMHUYTPZVxyfKGFWHKURfLiL8ME5xXDmH3bMh8p3phbNxcyhRkDP704m1
         Vy/KxsVGpmGYEq3wiBaYts5xZIuyv8IBdU/wSJpgKd4MbKU1PRwxQsxn2PojQn6tgBF+
         l+Ar9JGuw92n2+7lfa+Kvy0m/PJ/XmNHRSOwiUooUfL2jUla+40z+erKqB7KbbLkF1GQ
         mCz9m2AQ9tEbTeSm0ry9/x7mW90qsxMgXI6s2ytVLiPzO1JwhoYaqbJ2feZlcX/x+6ly
         4JbKsWYKdfFwTul2Qpt1RF6DgLpVB0yxmaWPjpFkqwp+JvdF7fDey6KFLmS5JbNUKOA9
         u2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706084614; x=1706689414;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuy7OX3axI0iiMzuuur6ujhVfR8b/UQiDsRCpQYN2vk=;
        b=LI3uvvN7+ynm9stqYtyPHQB6CTLQ4I7bl0aJdyx0EMbAOsSZITSBZMInJzRLl7PTMF
         LuikylxaCprgDAfvWwedYvly/xgyYFAmRliXEnCSzthYnTYOV/oI000XCeVjEtbI9R8O
         37e0+zhlItDvDxQP37HcFUm/3ZbdVglCXNOEtWkmNPNaiuZJxGGP1cbHiNcu1asuNkzQ
         Uvl5FBgKIrTkA+/OAR64PgaBwQJN94rOlzyv4/fsX+ky4kPDXl/Yy6F/9VIVXcL/veby
         i5r9swfWg+LhYZEyG8y3lWW1vkF/4mRVTnxBrMoiK1PHMpyI2+KIPkKBaL+oIYI0fe4S
         Jdbw==
X-Gm-Message-State: AOJu0YzK6jRTNWqiO6MFwXYvsGUuTKz39DrKFf0PCF4M9Et86M9Cef0l
	kSXjN9NCK66abUJwXIS7QFjHEEDCgH7xTpntl1K4Taqvaj5WcG3qV8y2wvLS
X-Google-Smtp-Source: AGHT+IFp7zKdOYuxjBtepyuf2BC87V+98RC33CUmPH2eqQP5NHpkM+6g2CYsAm1pZa7F9skIrW2T2Q==
X-Received: by 2002:a05:6512:214a:b0:510:4b2:2036 with SMTP id s10-20020a056512214a00b0051004b22036mr779401lfr.12.1706084614112;
        Wed, 24 Jan 2024 00:23:34 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d34-20020a0565123d2200b00510125c8d7dsm66102lfv.140.2024.01.24.00.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:23:33 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
References: <xmqq34v6gswv.fsf@gitster.g>
	<CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
	<87a5ow9jb4.fsf@osv.gnss.ru> <xmqqsf2nnbkj.fsf@gitster.g>
Date: Wed, 24 Jan 2024 11:23:32 +0300
In-Reply-To: <xmqqsf2nnbkj.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	23 Jan 2024 10:34:20 -0800")
Message-ID: <87plxr3zsr.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Then how does one figure what "git clean -f -f" will do without actually
>> doing it?
>
> I think whoever came up with the bright idea of forcing twice
> somehow does a totally different thing from forcing once should be
> shot, twice ;-)  It does not mesh well with the idea behind the
> clean.requireForce setting to make you explicitly choose either '-f'
> or '-n' to express your intent.

I agree, yet I see it as another deficiency, in addition to that of -n,
and I used it as an example to emphasize the deficiency of -n.

> I wonder how feasible is it to deprecate that misfeature introduced
> with a0f4afbe (clean: require double -f options to nuke nested git
> repository and work tree, 2009-06-30) and migrate its users (which
> is marked as "This is rarely what the user wants") to a new option,
> say, --nested-repo-too so that the "dry-run" version of the
> invocations become
>
>     git clean -n
>     git clean -n --nested-repo-too
>
> and you can substitute "-n" with "-f" to actually perform it?

Whereas obsoleting second -f in favor of new --nested-repo might be a
good idea indeed, I believe it's still a mistake for "dry run" to
somehow interfere with -f, sorry.

Thanks,
-- Sergey Organov

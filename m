Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362D4317D
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760796396; cv=none; b=G95BRn6TDRP4hTB/63WnvhkAZff3BF3EDXP+ig61bFAidGXQ5OWBDNZ4ll46nzYWjZwfytTb6v+HrWIAZKJbx7PYpvEu++fuYSRo1CYTOK1Kx5n/6roDTUruyeOrC/7rAm5KBKkW7cpzMPvDgVT7ig/PGFtcZFR7fiABl5H4jEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760796396; c=relaxed/simple;
	bh=d33uEcm+SAUXvi8/n/fKL/UHu0cVQpNulNowv+u9Ui8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=AzsuusH66nCSvANcdgOlYb6t/jTN2mp4khrvDb3bJ9Tq6+F5hdxMOZRvEpp7YBJOOaVNsfEMsCHokOU6MsTbUMKGNQLjq/B87HLfn0Bmt9jg/yUgw0Y4XsnuhvKgJt73APXvVlKtj6uVm+8FHgF3PGMstA2UW+dishRYsWHNFOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2W7Tw7x; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2W7Tw7x"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-635355713d9so3104753d50.3
        for <git@vger.kernel.org>; Sat, 18 Oct 2025 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760796393; x=1761401193; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hz1LpLKmk8234tKQuMogZYR03LeUWxPv197RLVJ2pIA=;
        b=T2W7Tw7xKKj+Fs5bxo9NItHQsyc43m6Ks+4zmxHqwihp3rvBhh24OfWWvKhNDc1lM2
         vrumUGdBOnvPev1UqbXlxLMcR2ISsH5CN+rdpTb8+AfHCgu2BcG/lD06nofzbRDJwfDS
         MuH/Uiojh7bF08zogx39uX4DX/sxf9Dfk9f91FoSmziC84pg8CG06++ZDzSoHllOtTXG
         w8O50L5mwDa7ovC+mBPUgd8OUzP1AL43Uz2j/WUBeIWgvEbm5S6oxwm6ref/sCFUtcMZ
         DKtINQqfXkpcfxtmHWcm4qUB9i4Mul3O3IhHas3zV4eGNqmVziG4V6AK8pj3BF53d2TB
         yP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760796393; x=1761401193;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hz1LpLKmk8234tKQuMogZYR03LeUWxPv197RLVJ2pIA=;
        b=LQhXB38pukCLtdz2n17V37KNFQGb8xXIYFZy0/ej2ScO0zmGrqxTo4g2h5S/MqcwAP
         lSccoVxyDoOBPdr/zHY/zAR57eBpDVcb8QRQfMjEkZHom1A7rpsz8jTMxoKOBjB3feYA
         3HwdgaxSIINvmJKEdE/H7bjUPyXj8zJHpE4dc8Kb0J/vzRbdR30LONp3qNQPOUlZNGdI
         /k0wYV0NDhVFQ/ElodyMJGfnL/Y6kHgWRIsdC6GWZBRtuEzMEKpUAJ7tPQRBjwYsJff/
         0umQOaufHtRqRDX6yqz8wO7oU9e4SesxMVBGxEhWGvEycYtf9MYetDwu8y7RHSURngu+
         sC1g==
X-Forwarded-Encrypted: i=1; AJvYcCUlP33moBADX1F9srFhlGUpRIVflJdVANY1UaIQ8/S20Qw/qhpRyERFPW11yIUaYMpYMt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaxQmAmkRSAjCY+cYoE19dyr4iJM2UND5kI1yLYkPmf+wZBzGB
	JJ8KbFPR10C3sdpuy1YvuqYriHe/bJy2Ww3TSFZX0NKKhBqVKVeK2C25T8he8NMF
X-Gm-Gg: ASbGncvEoB0bf454xFl43+7Omm1pZ322p+Py7fV5+sDIC63UKVsJVEz8el/vG2Nh2Bh
	uffumcHe8VFxmLO8mTM6q0DbjVttiFwLA6cFg07DVQ5dajo0nV1T4xgx0jbQzX+dSmGC1D2bmLU
	ZZbZAdqzmkRchqjhITu+GjjWe78vkiNhGKE9PuwmU77dhZeMZ2jFHsd/hY733Y3RZL5qbvl7Gi5
	53ejA5mfYb3/F2ctcW+ieaYznP52yodz2N04Uc9T7O/A1Ct5AG8TCJd2IZF8kj4/bz8c17coAHQ
	XSYqlAI6zXBYRCyvxS9k3fQBxMR3DzTqkULLAxaQX/cwU6q4Y5WsH6/2tTNopg/05tbh3JvwZit
	iqCzwEfTvKQYrjFU8ETVGrrO9ufuWuvJvBhasZYuuSEAHq2cpameg+VcP7ajQYL35zhOIPulOw4
	FZEmQfmqTAFzg0j68nT5gWVjiemAM=
X-Google-Smtp-Source: AGHT+IHETS+wlhZSI1N5609W5Y+pEdSfAb6jXQcnlfeF4eeiJ0waSQBIGFwNdweL+pTl7t562ELLpg==
X-Received: by 2002:a05:690e:14c8:b0:63e:21cb:10ea with SMTP id 956f58d0204a3-63e21cb12efmr4041068d50.55.1760796393468;
        Sat, 18 Oct 2025 07:06:33 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:34d8:dae9:227:f577])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7846a6d5883sm6892637b3.64.2025.10.18.07.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 07:06:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/4] doc: git-reset: clarify `git reset <pathspec>`
Date: Sat, 18 Oct 2025 10:06:21 -0400
Message-Id: <9EB375A8-CDD0-4717-B1DF-32DC3078A50A@gmail.com>
References: <xmqqa51pxg9p.fsf@gitster.g>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Julia Evans <julia@jvns.ca>
In-Reply-To: <xmqqa51pxg9p.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 17 oct. 2025 =C3=A0 19:25, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BF"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> `git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
>> -    Interactively select hunks in the difference between the index
>> -    and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied=

>> -    in reverse to the index.
>> +    Interactively select changes from the difference between the index
>> +    and the specified commit or tree (which defaults to `HEAD`).
>> +    The chosen changes are unstaged.
>> +
>> This means that `git reset -p` is the opposite of `git add -p`, i.e.
>> -you can use it to selectively reset hunks. See the "Interactive Mode"
>> -section of linkgit:git-add[1] to learn how to operate the `--patch` mode=
.
>> +you can use it to selectively unstage changes. See the "Interactive Mode=
"
>> +section of linkgit:git-add[1] to learn how to use the `--patch` option.
>=20
> I do not see a good reason why we avoid saying the noun "patch",
> especially when we see it in the option.  If we were allowed to say
> "patch" here, "changes from the difference between ..." can be
> rephrased to "parts of the patch that makes the index match the
> specified commit", which may be simpler.

I think the issue was the word =C2=AB hunk =C2=BB, not =C2=AB patch =C2=BB.=

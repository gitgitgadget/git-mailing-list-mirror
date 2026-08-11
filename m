Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18993803C3
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466047; cv=none; b=d/ZnMKtfUPeVYebrq5gRXu2MmYkGHmF0Xo9cXHLTFqqVUpPsYuD7XlSzAAtjMKwEhQ39sHQKhcLuO1EN/24995wqi+7GXmNjJKFYlxif3PGEW+U3iVVU4nMVQjBlGQu2mgGaDY5sw4VO6rthcBa90CNU08vMEK9qfrpuAQwtSR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466047; c=relaxed/simple;
	bh=5gzZJD9lJp7gZ9RgzTVoDSH1TkqzaEfszjYQ6aE7Wvg=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=nKbz0njmTLWEax3keYflONwpGe0WtOKFM8k1x0fV4qwDa6PV3uaXsv2zGZ2Tetp4a5o0H07/NNrgNkeUy5XfLX1e7RkeIAkdOrLMh7FENqGNPAp6XiMIpLiKWtYwQ8EqGrs38i6chLMTLT3lCPz7mdL2APE9SsYFgv5gmPklaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWbf4zrf; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWbf4zrf"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81dfdbd86d1so30764377b3.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786466045; x=1787070845; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJEhXxDWJ+WilEr4G8xkQ3PkVwOjB+gn5f8Q3Jl+PH0=;
        b=BWbf4zrf2CPJy8MKNIU1x0I/FUIYXI5IxWl8+C+CsPqxNAOua8Bj516BfxkzqkWw0R
         GbUGsEFnZF4ic5zFCNmsFqnGXF/pHvV2+fpfVLIoGJFLGZBHqQ5MxS+zxKb8O3n9XByP
         kaofWNUaue+CNPThUOWR+UDnOg5dtxMHmD0k5LJq26iBbCaxkzlTH7FoMnI1t28M9szI
         k6l+D+2V0PD3ahLkrsuWKppa+Zc5W+heInaclAF9iXQUshMr2yGvHG+/ksWj5RK0IWml
         1Llz/UFH6Bojmn2ii57coFKrs8yJBsZlDgsJ0/9/YAb1QQqCxianOQx7JgE/X5tVs+jm
         s3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786466045; x=1787070845;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJEhXxDWJ+WilEr4G8xkQ3PkVwOjB+gn5f8Q3Jl+PH0=;
        b=U3iJwz/Kz5cBaNAvcYjnzkEbvUOhpJNdmNOMXMGKyPTItLWLorX/XPEuJ1mPvzZDIz
         rpDza33Yb1qFnpXkPduPmZltuBp4WIWyC3NhPa+bGoeSyFvYN/NMll2emNVgFDP9wwDq
         hx5ZROcISTqy5bcziMPzzdmvslkogfwVhK89Wy0qgjBGRt/DrTqmE4S7Y2FkZ8cjhHEn
         PHXuJnWohckGH4MJYBxsaAZaq6djSPHO7kLkfzYfIQv3F7QEE/nwHc7f4qRtPnRDZQn8
         X5NkqmaCbAm8TyT5/3uxTAJZZCjp8iaWsOMHWfYbVqxLZNXuWd+LwN2Sj0iY7C1BQoow
         NQoA==
X-Gm-Message-State: AOJu0YwGOP7Flj4gpT8+v/bItThLbEmzvSFmFsFcf6lGP+MuFtD76kpH
	FRtRy3uauHfHhwqLqTFny1P+3Uklr7AiKAXW6x9vgGLLdkv42TwBPa5Y
X-Gm-Gg: AR+sD12mLRsCRuWbMMqNQlbw0J/rtZmCzk3cAazY7TZEXpx68uHGdHek9cjcod3pj8z
	IhFmr2rSi2F1NHTbUN1EIPP2yko9qmjMx6ACC+qHNP9DpoNOxyPs0db4EoU0cxq+FZwPErhA2dH
	uiyg4zTFdzV8DZYDY9eOk37Wa2NLZc6/+w+j0JLVC1T67w3hOSYXtb6uLfjL2b7w898wdFDCyiS
	0FBzVcRZPDdP9BsCslGgsPsPm5uZNwZyek83f7zOdUk3fXZ+lySimzRlaVnxHUj8+z+Rg6eHdpw
	7rweyeOVck7WO/oNWGdI1BsZusr0jzox2CQJRaelD9wCn4OzvY9qlB+BvQ+T/F63cKMLTwgvhwA
	7rHJ6+zZrlsxIrTAIVEquvDqWK86Le6pTrUEy4uPfU30Z1A35SEidBkXdB3RQiFbM3BtvKVD5Z+
	5pnSW5caWWolcp4as8LvqcUPtYY/WpK5wfHd0kmHBmUAoE6MXnUSI24kPjxYiVQjEPNZ+bnOuVT
	yY2f8lHt0p0NzWfFzR5/l6PdRU//j8eB5Adp4X5DCeY2rJIPFwJ7flhgRIEHZziHkHMauDJBzv1
	p9IMfvbGIP3X6uYC4ObocP3A6opegG6I2hOwZg==
X-Received: by 2002:a05:690c:3387:b0:82d:aa2e:2a66 with SMTP id 00721157ae682-82f2c351124mr34685187b3.23.1786466044710;
        Tue, 11 Aug 2026 09:34:04 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:556d:681f:9688:f449])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66b1ef5f935sm1374409d50.1.2026.08.11.09.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:34:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/2] completion of 'git [-C <dir>] checkout'
Date: Tue, 11 Aug 2026 12:33:53 -0400
Message-Id: <B79E6047-CC44-42D0-A9CA-BF7B8D2C8B93@gmail.com>
References: <xmqqcxvp481b.fsf@gitster.g>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>,
 Leo Kerin Britton <britton.kerin@gmail.com>,
 Elijah Newren <newren@gmail.com>,
 =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Patrick Steinhardt <ps@pks.im>,
 =?utf-8?Q?G=C3=A1bor_SZEDER?= <szeder.dev@gmail.com>
In-Reply-To: <xmqqcxvp481b.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 11 ao=C3=BBt 2026 =C3=A0 00:04, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFJunio C Hamano <gitster@pobox.com> writes:
>=20
>> Continuing from the previous 'git [-C <dir>] diff' series, these two
>> patches correct completion for 'git checkout [-C <dir>] path<TAB>',
>> but without falling back to untracked paths, as "checkout paths out
>> of the index" is by definition about paths that appear in the index.
>=20
> I suppose I will add the 'untracked, too' final fallback, just like
> 'diff', because 'git checkout other-branch foo<TAB>' could resurrect
> a path like 'foolish' that appears on 'other-branch' but not in the
> currently checked-out branch (and thus not in the index).  The
> 'foolish' file might also appear in the working tree as an untracked
> path.
>=20
> This is not particularly useful, however, as it is unlikely that a
> file like 'foolish' tracked on another branch would be lying
> around untracked in the working tree to begin with.
>=20
> I did not, however, find any readily usable machinery in the
> 'git-completion.bash' script that allows completing a path within an
> arbitrary tree.  If such machinery were available, 'git checkout
> other-branch foo<TAB>' could capture the output of 'git ls-tree -r
> other-branch' and offer paths that begin with the given prefix.
>=20
> Regardless, implementing this is beyond my 'git-completion-fu' right
> now.  As I mentioned, I barely managed the 'diff' completion as a
> monkey-see-monkey-do patch series, and I would welcome others
> building on top of this once the dust settles.

I do not know where it lives (and it may be Zsh-specific) [partly because I h=
aven=E2=80=99t looked while on mobile], but I think there is support for com=
pleting =C2=AB path =C2=BB in =C2=AB git show <tree>:=C2=BB, so there might b=
e something to build on there.=20=

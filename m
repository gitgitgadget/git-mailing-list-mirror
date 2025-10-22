Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77732F0678
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166525; cv=none; b=qR0DSJsw14AjiAbJPIwYhyXoD1IqNS4GMqfWs8lS0ALjbOeGDs3nwIGMWy//E7UaASKBDutrd1y01LXEs2Ni7z862cq+Bmeglg8PfCUa+za0gzJlNCzAX3KWAuvwVVWrs9uVPCH/8oxictd9Xpcy83gScKWXDw8W/IJcW0YSYsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166525; c=relaxed/simple;
	bh=K5JT2kMq3Q3TD9m1E5eiwnHJOeoeutyLD44anKYjOh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmtaDurXjY1v+UYQSTmNZvN7a8trp8Xc56ds4e98GBnPTgd1q8WNcYVCKth8gtQSLdS9HRtfvBufxNiJXGrEtzwXYMFw7g764MPcBPQa3TyiMwgiaWynfk0t2TQfqbcMCGcUfY728xVfWImQd7ZLh+OA8v98fG251/YDZaR7SPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bx1B0Tqe; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx1B0Tqe"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37777912136so1195061fa.0
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761166522; x=1761771322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fTYRzTsSe/7VTf8u/By2uL1uVlCrhuIKuWFuLEpCQY=;
        b=Bx1B0TqeJq0JEGiBqpXH6zeFc8SUAFISTNWYVhIjIk/U2pYZWdkgtIHnGq+VsbvFdx
         /rKLS5DiQJ8sjONo4X47S4Xur497VPjULa6s/98kATMZHFCYHpLtRpE9OzdBmmKuW5CT
         qnoJFdiIT1OZiY8Usf0SFIGbmabOBq4HuW9qJEORLIi714pIU7kuu2hHDqX79XVb7CsL
         d0Bl2+S0uVIWxwqldMMkyuCG0hjt2+2YcnqXBjeeBySH5f9GV2AHfTOx5s3M2ePmgerj
         p+sUaR8iL/RZBNtyng2+a1ZYlD7BW5TZPQqeqG7zwC1jSCT7N/JjW7iiCfBPP0QPey2k
         J3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761166522; x=1761771322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fTYRzTsSe/7VTf8u/By2uL1uVlCrhuIKuWFuLEpCQY=;
        b=s9W7VwI42W3yu+R+oGOyv6UA1+v47eANdESA2IINMP6pH8Yy48Y8ELgu27L3Dkbt/t
         DunMkMShoHqOkB0sqizq6idKGFCWqrHpTzko0WB5ol2gkEYpU4g/woJAt6cDTk092o1t
         4C94LQKMrzrDV6CVfnG3Llc/WxyBbicMwZgo26DrSaA2BMlrH50Y+0H+UtRdTCbDde+t
         pTdXYC/vzck7vpByZVAcsL0G64XqyFnV/hPnZKXdyqyITcm/qSGFQcJ5oZ8R2bgSnWa1
         I2bmVLIiqee6WTJVu84rJY4kvl2naSHs4zDPdzGLBGMnTz0+tU+2RvJ+WpMSsGRcYEjS
         rPzA==
X-Forwarded-Encrypted: i=1; AJvYcCULrzVN/mQvVgQHZsNJTxpNA8QlpoTSRSAxzE9i5/hf5WVyWoz7Mv74LcH3f5zkSnHuu2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTneF1WySp6TeRkIilwXCywnTniPm0xNspfZ80aH34XeOatI9A
	3SttX20BKubkK7+gyNFj0ekfe1/h8Y6Q8ppGqzXiFhk3anP4wOhYsrFuV03Y5OuahnbIVkEtCwj
	MiBjnUs3nhB/epnJ8NujIz742qoOCAUI7kgkc
X-Gm-Gg: ASbGnctG76mAcJTxeQWUZsioC10xjrzid9FjWQfc/aoVDtrXvGX5VUrKLeyxTQcQbEd
	0XVm87dr1FQZV+korZvMZ7DzLltf4f24Bq/ccJ8RGT1PZXu7yt5v03oX3wt1KdOdKvWQCr2TmwE
	JDen1MuEWD/fIqe5H2O4FokfxcUnhDdMkrzwGP1WI3zd9k7HhAyDsyIFeqtfBY5uDfLkhnthgFu
	XoW143xQiPIqSCKFrL/eSXtj4m3RXJTNgZU2Q4LPTnUjH4xrbEj6TPpIXBUYxrhdMPe/Gup
X-Google-Smtp-Source: AGHT+IFoFSFwDCfQBLVkrEqsTSXs/+gJHuQl/qno+WUFuXeiqgsVcF/884Jb+uQ1j0+S5uACAOv3VYanXASDNxJ1adM=
X-Received: by 2002:a05:651c:b11:b0:333:7e5b:15c0 with SMTP id
 38308e7fff4ca-377978c0b4cmr75283391fa.13.1761166521763; Wed, 22 Oct 2025
 13:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <7b9e8961d42e0f367ba0782e7d932607aa7e0b0a.1760563101.git.gitgitgadget@gmail.com>
 <786d6c19-0a13-4e55-8f4b-39b57dd6ea28@gmail.com> <xmqqplagunnm.fsf@gitster.g> <d863c518-3246-4752-83f3-469592b1de69@gmail.com>
In-Reply-To: <d863c518-3246-4752-83f3-469592b1de69@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 22 Oct 2025 14:55:10 -0600
X-Gm-Features: AS18NWATsgIi6ai83edpWrL5b6KduM8alkKevyBb1SeU7M_H23hpQaxVLyOJO0s
Message-ID: <CAH=ZcbALmH1LRKpLXygUOPiNJeoG2Uqvkb0fuy_i412W=z2oeQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] xdiff: make xrecord_t.ptr a uint8_t instead of char
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 7:27=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> > I 100% agree that being honest about the motivation to sell this
> > change would be a good thing to do here.  I do not think "in this
> > series, I want to match the types used at the interface to be of
> > Rust's" is a position to be ashamed of ;-)
> >
> >> I agree with Patrick's comments on this patch - it would be nice to kn=
ow
> >> how you decided where to add casts. Given that rust is going to be
> >> optional for at least a year we should take care to leave the C code i=
n
> >> good shape with a minimum number of casts.
> >
> > Thanks.

I'm not arguing that uint8_t should be used everywhere in Git, only
that it is used everywhere in xdiff. xrecord_t and xdfile_t are
fundamental to how xdiff passes data around and they need to be
transparent to both sides. I'm trying to leave the rest of the data
structures alone in order to avoid refactor churn. Refactoring C to
use unambiguous types, outside of xdiff, is outside the scope of this
patch series.

Another problem with using char instead of uint8_t is that tools like
cbindgen and bindgen don't translate char to u8. Bindgen will see char
and will produce std::ffi::c_char on the Rust side, see [1] for why
that's a problem. The other way around is a problem too. When cbindgen
sees u8 it will generate uint8_t on the C side and then `make
DEVELOPER=3D1` won't compile because uint8_t and char differer in
signedness.

[1] Problems with C types
https://lore.kernel.org/git/CAH=3DZcbA_8JM1hdUAfFe3ho0ShuniguEpV1308S0nCkCH=
OCsmmg@mail.gmail.com/

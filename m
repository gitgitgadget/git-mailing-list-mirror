Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3969BD529
	for <git@vger.kernel.org>; Tue, 13 May 2025 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747107460; cv=none; b=ShU3zsQ5puf4ZGF+Agd9ercRwDctT7LCkTVMmoVr5/bQ5/quZc/96yigck5qsf3p8HSZMFqu2N6xEQlPc73I6kGncS7WNDS4K7xY95N27RNNIlscvqVB25w2UdmW01iJG8gmy0sI4Rki8JMkF5e/V6ukkxv4spA03QINNoSAZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747107460; c=relaxed/simple;
	bh=RY0FXJLupI/xp355c5IWodJVMR636CjSqj+d2EIC2I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzcSM2dqKHOdPWAFdG3Zda3l+M60ZVFVYBlehsw56C2w6F6bRJolaYn1yZ1d+JAqw6vK2JqLNjnoaWkFch0vfaH+u5KYQY8wm7o5O6jY58flXFK+hGaP24NU/5LHTzL/J9lIf2mQRKPDK3mrKEtgENa78qdT7+ISaMUwAn/K1/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpvJeXfT; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpvJeXfT"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d8e9f26b96so49151545ab.1
        for <git@vger.kernel.org>; Mon, 12 May 2025 20:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747107458; x=1747712258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awsv7EqkiZrxxpRR+QS+PAadUQorEiMhOwoXpaKRny4=;
        b=MpvJeXfTLuPYx38J0m3QqzDZlG35LCjp6LLgfJXJKuuzy6cZvCbz2lgBdSkUxNezSN
         72I4oIHsnI2lCZ9x0uah2ggn0af2GN0VqILGF/2WZQ/tCQ+0VosrtnpiOaQaJByRihlo
         EceD9ON+iCr2LlFceitQIf+WxWzTFjCat3CdJ2XNt+Och7Y1eCTBO4itnFMnQ0SNUD9X
         T5wY+YGOrQMN3lxc0qyp6Vo2sr5kRL4K8wxX1cFcFGBeUKlcV5L26XDr8QiW3WAoLBmM
         WL3AH4NmxOD6KJ1l0xKFUX582JUyxDSSkrzOIBBYfQdVSiDuPnRJzL1fh4bvxDQuWmMo
         GvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747107458; x=1747712258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Awsv7EqkiZrxxpRR+QS+PAadUQorEiMhOwoXpaKRny4=;
        b=gteY5RmHAUSoC4uuN4Od0mfUBWD2hi07s6lrKb4pWJl1J+i/XWs7LCT8HTC+LzylkQ
         smnEwIN4kkx22iGR/k1LubqOR+2WyEgWyyKRgIh/QtYefJm7t0oPv5fFN1iWP92Pln7S
         Zgms0VJVxHJtqK8iZzUEG15AxY60Oy2UAfTRlRgrzTA1aZmsbmlJm6STMjjk8b4ECsji
         dGP2Z6HNW8r+ocgxEKiYGXGXgC117w5jrZeaCtrfiQkexHQSxT4DlmFaGwUWxM1wCENU
         /r7Oo5uuE0VeNa0bTpidWyFNrtnBRRz4b7yiicFORaTt6O+mbBvNPhFaSqS7WtfsZNLS
         KBiw==
X-Gm-Message-State: AOJu0YwK/+yjIEzsOwnWD1vDAHnml+9QHYeUDxYkwyReowx1LRnV9t4c
	TuSaoavFJg+CQiLf1iAZxmf9FvAA1/kcUWl/RKPyJTZdtl05Hjru5U+0CO7jxwI8OwEFSq/fzoT
	YkicNKfDXCYKBvsroRgHt24+6wws=
X-Gm-Gg: ASbGncvcSVQLoQhe+cuzWcBMljNPXCOgPTOhp/h2KnkuH6IRIP0gjnOFAqh/hwgRVEe
	6nyPPllLiVPoWnWjjqNBNbyrxLq3hSlsgf6sLLpgrmkoyg5zlV4JinRp0EOMPYwGMVCXayBomsZ
	UrU3U/hRt0OSOmPzGIeqIxQlTGtvpIl5FQLfRvpDKbpgwRpQ3n0zQKQjHlLT3iuqLw8g==
X-Google-Smtp-Source: AGHT+IHH0AWkLksLb2zbfsstpeEsHXIrCU1WPoUQ/hnrvBOA8Tl5So0j+7Sts8DdZz2Wu1ol6t+Qtm2MOZgaBjVeYi0=
X-Received: by 2002:a05:6e02:1689:b0:3d5:8103:1a77 with SMTP id
 e9e14a558f8ab-3da7e1e1a71mr188326715ab.1.1747107458112; Mon, 12 May 2025
 20:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqy0v1ia3m.fsf@gitster.g>
In-Reply-To: <xmqqy0v1ia3m.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 May 2025 20:37:26 -0700
X-Gm-Features: AX0GCFtj4sQl6v7B_VFREW1hV7PUSN5e4tvRbaB6jla2sXuQK0kCRxrfhSyc9zI
Message-ID: <CABPp-BEukTWwsuC7MMR8D5_UAhyw-LgT=DsPKAWeR_ZmVVhjzQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2025, #04; Mon, 12)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 6:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> * ds/sparse-apply-add-p (2025-05-08) 3 commits
>   (merged to 'next' on 2025-05-09 at 11ce4306b9)

That's unfortunate.  While we can't fix the second commit message
anymore, can we at least hold off on merging to master until we get a
new patch to fix the test cases?

cf.
https://lore.kernel.org/git/CABPp-BHkgvc0UQbhXfP4POtY8GPVpz9J8ZbX3_jyzL_V7G=
yBbA@mail.gmail.com/
https://lore.kernel.org/git/CABPp-BEmMaFQxE9NQgM8M=3DcgfBHY1p56vnBt7R4CfuiX=
nq++4Q@mail.gmail.com/

> * jc/you-still-use-whatchanged (2025-05-12) 6 commits
>  - whatschanged: list it in BreakingChanges document
>  - whatchanged: remove when built with WITH_BREAKING_CHANGES
>  - whatchanged: require --i-still-use-this
>  - tests: prepare for a world without whatchanged
>  - doc: prepare for a world without whatchanged
>  - you-still-use-that??: help deprecating commands for removal
>
>  "git whatchanged" that is longer to type than "git log --raw"
>  which is its modern rough equivalent has outlived its usefulness
>  more than 10 years ago.  Plan to deprecate and remove it.
>
>  Will merge to 'next'?
>  source: <20250512190311.1451556-1-gitster@pobox.com>

Can we fix the missing word in 4/6 before merging down?  You said
you'd fix it up locally, but my view of seen shows the word as still
missing.

Other than that, it looks good to me.

> * tb/midx-avoid-cruft-packs (2025-04-15) 9 commits
>  - repack: exclude cruft pack(s) from the MIDX where possible
>  - pack-objects: introduce '--stdin-packs=3Dfollow'
>  - pack-objects: swap 'show_{object,commit}_pack_hint'
>  - pack-objects: fix typo in 'show_object_pack_hint()'
>  - pack-objects: perform name-hash traversal for unpacked objects
>  - pack-objects: declare 'rev_info' for '--stdin-packs' earlier
>  - pack-objects: factor out handling '--stdin-packs'
>  - pack-objects: limit scope in 'add_object_entry_from_pack()'
>  - pack-objects: use standard option incompatibility functions
>
>  "pack-objects" has been taught to avoid pointing into objects in
>  cruft packs from midx.
>
>  Comments?
>  source: <cover.1744757204.git.me@ttaylorr.com>

This round almost looked good.  I just replied to 9/9 mentioning I
think he should send in a final re-roll including his fixup 2/9 and
some wording improvements to the second paragraph of his commit
message in 9/9, and should be good once we get that final re-roll.

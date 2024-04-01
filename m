Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04780481B8
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991245; cv=pass; b=OrVmu4PGVJ8tb6SAzmUfJsjTumP8cO4JVDkYyACVC9r2KiwKEyeS4zDx09hrEFinibzyCD24WcsLPP+q/cW2g2b2VD/NdNP99piybX1AMLHQk0sIm0vtAEgBHYs0fUorQBEd+RCD2jPnMY7Ol1EJW/cpfke/105a7ANVrKLn9Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991245; c=relaxed/simple;
	bh=0tOxD22KQJB0DM32jGUSV3An/VIs9r215P5ii51dn1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPvE/wtDF+hhxgFZ/mvxSoqRzuaqOTyl2CNjr6IUNjlcENV/CUulPxgzeQ/mjV9vH//UI81GI5ih2kykOeCebsmB7OQ35fDMWOaXFOyqFuSLuFtIb2/hgfvAFjctn7Rdq54YeXjzplxqQon+HKamVVYK7u8aUbw2/lmsZF8C7Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=VlHjjTdz; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="VlHjjTdz"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ville.skytta)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V7crL2qfWzyVF
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 20:07:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1711991234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVRsjYgln8z2jxqwe3d6MAeIiQEPusuuX8ksO4MtmkY=;
	b=VlHjjTdzJ26UCx4AP6AzGfj5zYYGPWn9r6/JB6ZRaODqh4hWmR9L8yEEqyLCzpWhSyW28s
	FEgo24M678Z1qoRY7UF6uOvKOlSwRbM9EajIdNYxSOiK6TsKjkPgjGbnJwRMobQnlsPXnz
	azY6CzxOqE9AniJewDVDwzR0T2Dqhgk=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1711991234; a=rsa-sha256; cv=none;
	b=TDcG0+XI4a94hPEmFF/n4vmtg75fVWQSW/T6oHGDTcNXZobtu/NAYoYxURpZKKI7NnTnDR
	b6vMokXc7MZzHAXoZ1x9c4imbvBM7f2KH7fG3njaO3Zk58KK3l4z0czpm2sjhqwkFhBX56
	yMrvDc+EBT9qBe5kVorljolN0opvMPA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=ville.skytta smtp.mailfrom=ville.skytta@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1711991234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVRsjYgln8z2jxqwe3d6MAeIiQEPusuuX8ksO4MtmkY=;
	b=Cp2lKz39B+fJRI7oDqAKRPAMQxwgzMH85D4W3ZR6VMbX5DBIyC/46ZLu2dfrWGSZu1MXYV
	wmDCgjsiKVVbvbz5UV4qe2Sd1rBmSR62RZUu8ak0n8/V6O+PvaNNjsYEP6ONhdHLBr3RWI
	MDTHErmAZIS/YXwGvu+UZvntYzmTFYs=
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516a97b3139so1096210e87.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 10:07:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YyKfUwJqUsodJ3R4Fz0lfWL/MYHLMUv1yeAUyBrySxLPBloUwFd
	TBzbQw8galTgIL1VCib1YkMoWPDDR/97K4DL6RjTCQRgNU33awiDMlxVXqZ/LEugWiNU9la+/kC
	r4UcfMZPLISOno+W8tpIwUG+q2KA=
X-Google-Smtp-Source: AGHT+IF9uml2+yRvOtTY9ge858FTrVueyNJWBIvuRTYm2bOJXf7+DG3B4sG7uyv43684Rtb8vMkFlstd1GmWHaNF4gA=
X-Received: by 2002:a05:6512:21ca:b0:516:a04f:d528 with SMTP id
 d10-20020a05651221ca00b00516a04fd528mr3841167lft.1.1711991233937; Mon, 01 Apr
 2024 10:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401113033.28709-1-ville.skytta@iki.fi> <xmqqttklcd6d.fsf@gitster.g>
In-Reply-To: <xmqqttklcd6d.fsf@gitster.g>
From: =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Date: Mon, 1 Apr 2024 17:07:01 +0000
X-Gmail-Original-Message-ID: <CABr9L5A_zz6ZvBWUoX_Px6Upyiur3+SPp8U91uw3OXO0mXZgeg@mail.gmail.com>
Message-ID: <CABr9L5A_zz6ZvBWUoX_Px6Upyiur3+SPp8U91uw3OXO0mXZgeg@mail.gmail.com>
Subject: Re: [PATCH] completion: fix prompt with unset SHOWCONFLICTSTATE in
 nounset mode
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2024 at 15:31, Junio C Hamano <gitster@pobox.com> wrote:
>
> Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:
>
> > `GIT_PS1_SHOWCONFLICTSTATE` is a user variable that might not be set,
> > causing errors when the shell is in `nounset` mode.
> >
> > Take into account on access by falling back to an empty string.
> >
> > Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> > ---
>
> Obviously a good thing to do.
>
> A related tangent is that
>
>     $ git grep -e '$GIT_PS1' -e '${GIT_PS1_[A-Z0-9_]*}' contrib/completio=
n/
>
> shows a hit for the line with SHOWCONFLICTSTATE, plus two lines with
> GIT_PS1_SHOWUPSTREAM that lack the "if unset then use this value".
> Do you want to do another patch to fix them, or are they good as-is
> for some reason?

I initially actually changed those very lines too when working on the
fix for the issue I faced with GIT_PS1_SHOWCONFLICTSTATE. However,
both occurrences are within __git_ps1_show_upstream, and the only call
site for that function is protected by a check on the variable that
does take possible unset state into account; the function will in the
file's current form never be called with it unset. Additionally, the
first occurrence is immediately following a line that sets the
variable, so that one is "doubly protected".

Therefore, I decided to undo those changes and not include them here.
I guess it's a matter of taste whether one finds it desirable to
protect those accesses nevertheless, but it's not strictly necessary.

Ville

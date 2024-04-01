Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF251C44
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998647; cv=pass; b=jOEpb8+ME/jYnhT3eVbc5SHxpsWSBYbLqoWE49zrINhXYPTUFuJtxenu0Za6NsXqFODc7esFnmNKAkWui4Aa/KVN0kdbSMYcDg0xQmkFxNC91bDdHxfcQ95Zsb9FxOukHLi0cxqrhgKh+DGaZWVFBoNKlip+Msh2U53VLLyD8Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998647; c=relaxed/simple;
	bh=fC9WU+2THryK2n00FNPpWZCdzmmgB9Uf9ykLuOGRr8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SS39H8PM/GSONJq9EjwHTwipW9G3ySasv0PPTR/2bAQefvXD0ZJaEDhb/s5bL+bJ/uV4KApELKXqPOX+iJXrZmu/29bKEnsE6TZjqqaB6uHJRSvrH+0YcbJueyQpW56eBemwO1qOWMY4p7cctmo6dYmVz3bfNTsrN7bzrJQIVk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GF5j7QJH; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GF5j7QJH"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ville.skytta)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V7gZp5hlHzyRx
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 22:10:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1711998642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzJY3IPyBqD7WTsu1gGdhT0VTFxwhdLVkmI+LEAtYzM=;
	b=GF5j7QJHJx9a6Bjr1pru3dn3zIPNArbKvv82sPgUImTS6/U3aqtgPzcZWBZOa+XEww/Ic+
	itT2bZY05FMw1bipSfLGgRhwEAFPFef2ivZKxqhyIe0YdJ3ufiIMevO6xYjC194jhX1NUE
	hiGtclQCntypUHC5l4UhhsFjVzxZM4Y=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1711998642; a=rsa-sha256; cv=none;
	b=JN6iNKOEDROmjT7df9KKycHwnvyG8CeCY36IGsZaFA7J9gpkEgCrMP/GgoU6aXKWZMRgW1
	V3or3mDpOPg9KXxafbN9rH1o/2pgy2eZWaECObIZzP3aFcPRy2KKk4Vtlhv29XHuK2uTcg
	W1KyYBq1RwdCMofX82sRgoic52314Ao=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=ville.skytta smtp.mailfrom=ville.skytta@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1711998642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzJY3IPyBqD7WTsu1gGdhT0VTFxwhdLVkmI+LEAtYzM=;
	b=aOfpj3OBFxU14j0BkbWcI2MiDSgKn7uxuLM4eUFROCvNkBFgHEe3r9CrHH9pwWFE6DY1pr
	oSqKZYHR0eoZt0OjkR4p8tNppX6Wc3InkKrZMWEfhmJ5PHTfwHi6yaauy8Trg7A53mn8SF
	KGQOv+HJNLwu4mbmKFCkUCUc95P0sg0=
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5157af37806so4706552e87.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 12:10:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YzWv7fb9l2k7AVu0SveLU/kemaNm4qYGd35BjO+M2Xn+pwrWI+V
	U49+XhbUiioMi9jFysepxtcTfqIhMHwFR7tBt7pk0fUxcjG8ROAfRB9kf3K1pFqH9bV+ZUFPVuf
	kj2K9NxX127xCemZEwxUTrkyAm5M=
X-Google-Smtp-Source: AGHT+IG79TmbevT8HLSSaiZGIYnseoYpD23Yz8OW7eylBNKHD9Wog9gGGwRxS5DXci3cbNDHqoHEXUwAlIabK4uHBOk=
X-Received: by 2002:a19:ca43:0:b0:513:e369:cc41 with SMTP id
 h3-20020a19ca43000000b00513e369cc41mr6389866lfj.49.1711998642462; Mon, 01 Apr
 2024 12:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401113033.28709-1-ville.skytta@iki.fi> <xmqqttklcd6d.fsf@gitster.g>
 <CABr9L5A_zz6ZvBWUoX_Px6Upyiur3+SPp8U91uw3OXO0mXZgeg@mail.gmail.com> <xmqqh6gl9eq5.fsf@gitster.g>
In-Reply-To: <xmqqh6gl9eq5.fsf@gitster.g>
From: =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Date: Mon, 1 Apr 2024 19:10:30 +0000
X-Gmail-Original-Message-ID: <CABr9L5CLNCYFcta0aMApkyxr_jW9wycY8GmJsUPr9kg1smv+Kg@mail.gmail.com>
Message-ID: <CABr9L5CLNCYFcta0aMApkyxr_jW9wycY8GmJsUPr9kg1smv+Kg@mail.gmail.com>
Subject: Re: [PATCH] completion: fix prompt with unset SHOWCONFLICTSTATE in
 nounset mode
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2024 at 17:26, Junio C Hamano <gitster@pobox.com> wrote:
>
> Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:
>
> > I initially actually changed those very lines too when working on the
> > fix for the issue I faced with GIT_PS1_SHOWCONFLICTSTATE. However,
> > both occurrences are within __git_ps1_show_upstream, and the only call
> > site for that function is protected by a check on the variable that
> > does take possible unset state into account; the function will in the
> > file's current form never be called with it unset. Additionally, the
> > first occurrence is immediately following a line that sets the
> > variable, so that one is "doubly protected".
> >
> > Therefore, I decided to undo those changes and not include them here.
> > I guess it's a matter of taste whether one finds it desirable to
> > protect those accesses nevertheless, but it's not strictly necessary.
>
> I am glad you took a look into it already.  I wonder if we can
> somehow keep this "institutional knowledge" to help the next person
> by saving them from wasting time wondering about the reason why it
> is safe (iow, what you have found out and described above).  Perhaps
> a patch like this?  I dunno.

TBH, I'd personally just rather patch the "vulnerable" reference to
guard against this. Sent that approach in another mail with subject
"[PATCH] completion: protect prompt against unset SHOWUPSTREAM in
nounset mode".

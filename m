Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C135C181
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837499; cv=none; b=EW8ENyHzgHIRRbITR8yXmxh0m6uZte7OGayjH+/noqOQjsjucCLDhBzIOBrV9Wwmtmrwc8hBkb3kkDM2wYNs5iSKVm90ugLKzYODswO7pYHmt/nkwpq+5VfkKLaO8KtM1lyUPMkbwU3HgRUIHBgWAA3ODl9Qftx7hKYCodF+NUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837499; c=relaxed/simple;
	bh=/Lkp1EIoAwl6RdFf54vLdMdcxsG9LgMSjbtC6FpDRGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGaUEaAyGZhdD3mGPXjIbpXjmzrBOJAr9a2r1xv7vaYHzx+uvsHZWt8DDUKXzHHZAARIWEgwr3sPelBM7ZfefVDBjBIM5A+/8oZCOvQDtutXaUYQrV6A0yT2DbJo72ClzA5VZGJmKrG4Z1UMAQnk5kpfLM+Z4tK8Gi9U+jiAPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nf7ynITz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf7ynITz"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso2681771a12.2
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 07:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768837498; x=1769442298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Lkp1EIoAwl6RdFf54vLdMdcxsG9LgMSjbtC6FpDRGI=;
        b=nf7ynITz9sSYB3kqtXIoYPJhC2pufhYJQKW4oM1XP7gVwJyi70/Od7Qm7jrZ81Npzo
         QnIE3QSS+WaTXETgzim8r2rFidsL6N2AJp/aG3fbyaEMfv10BjZgKWJ+oWP9JflDJGtM
         0wdEHNAcnW6PQkpaHP+9B9ZpUVNapCuC/0FmUL7kP/el3WxMF/slxUdnFbHWutCBR4MW
         9jln8UaugmJP5nbg6v8SKyC897gU4PTe62NTsu8RxiOjfnUTnB0O4Vup/qosHpN2RXBG
         gUfmV9t2aRO0xOCsd1X8ZDMby6O855CN1Mk0x28b6lexcZY6Z+rCrMvkE23HjAjS0JK4
         loog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768837498; x=1769442298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Lkp1EIoAwl6RdFf54vLdMdcxsG9LgMSjbtC6FpDRGI=;
        b=HAIqsWf4FDPVCU7maFzFuef4c+70wgrCMau2NnNu3lPI9PzlZyvi260bcxM2aNnM+H
         DF14old/icp8iiZhDDQsbw4zvgtmA5raj0tlvVE8SzTbzcIM2hdVA1J1QSqwHda+v0eM
         gkh8fwV/GdCgMlIR0Op/ig+sIJFwpoWRhDkg6gtQwSBwOzgX2ql/+T/8yymfZDGHljgf
         kae6jTZw0u3zyEvKS4nk+9zvpz6+UWTdGx+EOuaPfYf9QzhjSWl1ZYICzuWFTr6D77Vw
         E3oNCCFiWNbC6FMByO6IEbkuJMoWjHKYOr6zwDjHMvtvFB4ifTI6pA5HAfIfIk1H6wGu
         TCoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIKyzJ/4LTf8uDPeP3Ep2RprZPpShTO7+tzlmi1T1/k4Td2daIE0S/OLZ2bbG9vNfHga8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0m08/sijcQJdPiaXQjIP6AOWmZ8+7PJ2AtlHUTaLmrSKV5US
	PpMHBpLZ/hp64Y8YtSg64jdKTTbife7pr0g4ayOUTHa1sgtXOebtptZ3VXpJBhjTd73Z4XE6Rfk
	OKzrIrdPP2qBC6ze0l+q0fILOFt67Pn81CA==
X-Gm-Gg: AZuq6aIo8vKzvQZJXGu/MKI/b1/NyTNWj43RkNkQ25KrYJb35f9YNI2UeLgw+vmzqS2
	2DuLl+IoBiPqveLEWn/yEEx8hH7NbEcCF2X7FdVixns2BkurZdEgt1vq+2GREEpKyYH7LHxDq3Q
	8ns2jPzrKM2GmvcptLW/U489zo8uedhlj0e42asPsiETzLel24pZLw8SpvE0s+TU89k9KqwPz+N
	bitk82dkU2qa5ShIkVAXdZVni0V0TYd0zb6RTX5LXXlgLSB29vDPcET5o8rcGdRdATjdQLDBR8F
	Na0OyCSgORouAqju66IBNbfEwOHs22GSZPmbUs1Hbcrumh1DQFjz+El5NNxi3vHMUv+/
X-Received: by 2002:a17:90b:4985:b0:34c:fbf0:fa55 with SMTP id
 98e67ed59e1d1-35272f92312mr9962188a91.21.1768837497636; Mon, 19 Jan 2026
 07:44:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqldhybtqs.fsf@gitster.g> <CAHTeOx8z4bG2OmPCc+8pCHBVeUWPmxgaSqz=jHL+H=VRHx=KAA@mail.gmail.com>
In-Reply-To: <CAHTeOx8z4bG2OmPCc+8pCHBVeUWPmxgaSqz=jHL+H=VRHx=KAA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 19 Jan 2026 10:44:46 -0500
X-Gm-Features: AZwV_QgTG8VRN8h3MzAa9l4S2e8guVYKh6UMJ94ebMatcdtYiA-67OGEPTxBROg
Message-ID: <CALnO6CC3WTBjaLR7yAr-w5eaqzyd2qF5MAyfV2wQY3+TDEbEsw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2026, #05)
To: Yee Cheng Chin <ychin.macvim@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 8:43=E2=80=AFAM Yee Cheng Chin <ychin.macvim@gmail.=
com> wrote:
>
> > * yc/histogram-hunk-shift-fix (2025-12-06) 1 commit
> > - xdiff: re-diff shifted change groups when using histogram algorithm
> >
> > The final clean-up phase of the diff output could turn the result of
> > histogram diff algorithm suboptimal, which has been corrected.
> >
> > Will discard. Has been waiting for further comments for too long.
> > source:<pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
>
> Hi, I'm the author for this patch. I'm still pretty new to Git
> contribution, but what kind of comments are you looking for when
> deciding on a patch? I noticed that my patch didn't receive any
> comments, but it was essentially a bug fix for an occasional
> suboptimal histogram diff result. I would imagine most people would
> not have much to say given that it was not a new feature or introduced
> any breaking changes.

I just gave it another read and, while I can't comment on the xdiff
source changes, I find the proposed log message and test cases clear
(and demonstrate clear benefit).

I also appreciated the analysis of occurrence, which to me suggests
the performance cost is negligible.

Thanks.

--=20
D. Ben Knoble

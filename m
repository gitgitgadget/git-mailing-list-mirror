Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979281BDCF
	for <git@vger.kernel.org>; Sun, 16 Nov 2025 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763335524; cv=none; b=tHM/YfXHCARQIdA+9XtzV5vQwcSrzMRR63WWKxCR3EV+NWyVjS09OQlgfIx6sAPdTbRcPal3wQvWcrf3zJtntKIMmMr42ihlg23KrjpxJoQbRbiQxeqJez4fKtYO1HzmHfdJ9QeefJdekV24nrxtPstZAXGlq0YoUwgYTo9x/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763335524; c=relaxed/simple;
	bh=VCS6hiWqNZoaXAF9FjlGkviGPId277i7B7vHjVR6H+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M88CEAnLxqq90K+GkiJFCanMiJHw/iN2j1Qz/d8Z+uK3XikeNfbx2gj24LknY6/plcDyKL+05JlLeP7iBQ4VqcfpWdoFbVUfEfy+afOLPb74lI8ZrFKPSC1kU63OcCQkH8pzqzv1u3PZ69z4lJWnxCYnIWjh8dzm28+Ey/pRL9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=K8kT5nLI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="K8kT5nLI"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso2979504b3a.3
        for <git@vger.kernel.org>; Sun, 16 Nov 2025 15:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1763335522; x=1763940322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dik6zAMGZKR7QRkh9IfOcVkPY1LHlIZUZj/NbUkmG/k=;
        b=K8kT5nLIaVwLwi0H4mOmL3zkp0z8N67Aeas26OWjFjZ0UjjL6fiuwC+kOX42lqV7S6
         25Pg1xU+6sVOfcMvF4X2kOeZxU2GX+UOgv8/6ysrb51GrtuOovXtLFKYD2fR3YuWB3K0
         MXMZju0UamUPgVxStHaLGT81oVYUHC1uPIq5fi7ykm8V16onXJVKuiXKCSx4J+0PPkEn
         /RfI711sBk8oRrl2Ce2CFwFLQ56qwdy5t0ThaAgUiWqC39MQzlha9f4JoV5RYpOe0NpT
         h+2zNoS7HIVH8s5LCbR8dPx9Dke2gaEcixPoET3k1BBXN6r62xGLhFOMJRpmAxd2gn7N
         raVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763335522; x=1763940322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dik6zAMGZKR7QRkh9IfOcVkPY1LHlIZUZj/NbUkmG/k=;
        b=aLXvNhX67lDd7gVnuYkCjFBMsuMl4my+R5ZexwCycVMSFzFQNwphOgZY+y8XbYdnwM
         1CWOkrULE0EVwrlsm7cz5ALpMmn5jjsd7BRNXtq5KFJtJ+uAiZ9WVJkHvWBW/knpU/JV
         nvNjZVC664Ud29GIDp6+S8VCOCaHQvFfD/UwaaEpwp580NyMQgfusOlzz6wqtq/1xsqB
         9WvuNW5r86g7AvgycfNjo1RDEVyik7iOMha6x+BEja6/F5h2zTstVwk2CSO3+gGu+xgy
         jRd1CUc6v2hgtMR3oZ3sDXEibG7KLcbB4yvWrVFawqd6Xct3RRnd09C/or9Mlh2WEAx3
         ZYWQ==
X-Gm-Message-State: AOJu0YytxMlPDlaJjIXiMALpnQrD3yPucio6vkKviKSIBqUaPsFNT7sw
	VPYgoIr24xt8Y6EvWCb/PnN5g8ZobQlCwuz+Ge7zd63Y5whbbforrYtIiy2APKCzxRoLeuYQYEB
	5f3JIglFp/DMOg4zxi9vV9R2qrvSh9gI1adrsG0nFF1HjtmRmJEnjAqk9M2QAkR5vnw00IAIkTh
	kkej9KbO6QbdHvirNjBJwM3UD85R7tld7MHmH1zGs/CDiIPuIK+5R0Y6Qb2UDfeRhgDi9IIC6dX
	peWSQSYR4wtUB30pqqYigO6PHzC2Gwph8XdUx3r9pLh0tWVxO6siVFZzNMnjMntAQuNfxLHpjiH
	4oelutg6Yee9ciw=
X-Gm-Gg: ASbGncsYWL2Tda5sjHhQ4Cv7pRKR/b1xMbNowZpz2Bp9EVbFS4UIu7tYeMQnH+RO49z
	c+v9MFYSbr0neuTL34eQ7utkgq/vdqnC0+1rL15vhAhyT8S1hboLVWd+bjUTb6js8iyHeaesnn1
	GS4NaOebiOHGyvKCtkmzrQAqRO3h11kNnK26D0HH1d/IVUO9znRTQHJVoBPlddkAHWEzizkh2Yr
	F2FxUwmhAI3AEu+H5f4NmUTlySTneQnxjCS1uybuFg81Q6Y8hLb7KnMCqRpxmMmHPC4o8SIB/Qj
	ns20ZOU=
X-Google-Smtp-Source: AGHT+IFDenLDeXsgYvZI8ozVpUskYpWjY52ltbhxA2gbi8fP5SViqUe6qoRuGNx/uyMw0BCHyStQJB5cjXdLrV3uuHc=
X-Received: by 2002:a05:7022:43aa:b0:119:e55a:9be4 with SMTP id
 a92af1059eb24-11b40b30ecamr6226769c88.0.1763335521604; Sun, 16 Nov 2025
 15:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ddefb36d-f023-45c1-b518-a9f70dba0696@gmail.com>
 <b1775e1a-4f6c-4116-9587-69526d379b42@gmail.com> <xmqqv7jcgy8y.fsf@gitster.g>
 <xmqqqzu0gxq2.fsf_-_@gitster.g> <CAOTNsDwS2er+31iFt4EnhW_ZupPG+Uree_qobBVj9v1q1+0vPA@mail.gmail.com>
 <xmqqh5utdhfv.fsf@gitster.g>
In-Reply-To: <xmqqh5utdhfv.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Mon, 17 Nov 2025 08:25:10 +0900
X-Gm-Features: AWmQ_bkNy72Ij79OlumU4IjUeWjG4D5FF6OfMKPmRJVlU-LcJWrai_6ngYjsg4k
Message-ID: <CAOTNsDzqXZVMhW+kuWG_ZnxSc0U-g01AXkG7EbP8HXzR16LO7Q@mail.gmail.com>
Subject: Re: CI Failures (osx with p4)
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 2:18=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> > --
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index 50628ee2dd..16ee593d30 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -7,7 +7,7 @@
> >
> >  begin_group "Install dependencies"
> >
> > -P4WHENCE=3Dhttps://cdist2.perforce.com/perforce/r23.2
> > +P4WHENCE=3Dhttps://cdist2.perforce.com/perforce/r24.2
>
> Just being curious, other than "because it is newer than r23.2", was
> there a particular reason why r24.2 was picked?  It is not the
> latest that has arm64 macos (r25.1 also has bin.macosx12arm64
> subdirectory at the above distribution site), and r23.2 also has
> bin.macosx12arm64 subdirectory, too, which makes the above update
> curious if it comes without explanation, given that this would also
> affect Ubuntu that slurps bin.linux26x86_64 from there.

When I first looked in r23.2 in the browser, somehow I could not find
bin.macosx12arm64, so I looked for another version that included
it. It now exists in r23.2 as you mentioned, and I totally agree that
it is better to keep using r23.2. I confirmed r23.2 runs without any
error [1].

[1]: https://github.com/KojiNakamaru/git/actions/runs/19413263298

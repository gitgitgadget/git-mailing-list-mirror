Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54EC2BB01
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714018398; cv=none; b=Rg4VkcfcbW7zDWzSRXZw4wGjC5I8TVUPxgXMvIZacnxPgWFLfY2ll+shc9g2yNyzlaRxTUm+MEp5Y+JXJuqdoEBPfi69HYkkO4dH4jS9isHPBbq2GyweudWts/x1g6lvmxzslZcu1pi/3d1tHqtUx4JkYdAOYwgikQ3HzV1cZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714018398; c=relaxed/simple;
	bh=5csnHxotV9LT7x6TGnr8y2ks88K+e17iV0UraCPI1X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aq31S+y1bWVRSVCElGxBUsMWG1i7SJmsEyJLKpr7bJTBC6PC/WUNENfXyDUvc5Y/ZIVpU0h3xPyBNSUejh8wv+GaAtxfUvwhMLyZJOfjmzq3zIeF6ojXyL+fWj9fhbcDd14BLFe8sj2SdAxPYRmin9yb8ssVOWvk7G5p9fI6VwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ib3CDzUy; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib3CDzUy"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a4b457769eso497627a91.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 21:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714018396; x=1714623196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpqeUGEdCmmVH9E1iAxQvEqAhPmA3SdS84IYeWKfhJA=;
        b=ib3CDzUyzJFD2znWiL9/4KPGx2wsSGFuGLgYSYmAPq3qPnJNONHeu9zXhorvL4HKbL
         jmLNCrWxvtXyT4BpdsRH0ggPFtfjTZKT40fGdip3tHJm6HVMEL0GLwhzOHunDYvTG0Lz
         rpGboqD7BnBP9FzI2OyfCivRqFGgyqxHSmjTr4sxaKvG6h+SV9fjiRr16Ou+cX6Y7Qgd
         LcyiO/F6mi25D7Bsce0Ti3pE1u+z/RmyHADOh6y8urt7ZGeiYTF78j0NTqSzKisWSEPM
         0X2Hjdhh+5YNMtPVIlBTNibBMbSrk9s78fLWb4e5PAVb4+bt/R0zmiGRQrhq/yxDE67U
         H5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714018396; x=1714623196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpqeUGEdCmmVH9E1iAxQvEqAhPmA3SdS84IYeWKfhJA=;
        b=odEfVg+dHAdVqDk7x1kO0bfEGtB3MLQoEWuNNleFI67LW3yGZG71h6ciwsDeBb0aZF
         CYi6zMqZQhL/i+0dK2CzhM527G97gKysd2bu+aMbin38ERcTBRHf6pYGa2QBjbidxz3O
         aFkcIJVcdneVKXeFQTrv/GLiKHttwXbyy812c40dyqcR5A053oT+DMKiKdFsH+DrJlQO
         QhdgRcNkdCAEF0eCGlQ1F7hTd2mnYPXNjtVoHGJfsYtNs6Vw1ChlQnOc4zgARIrg9HS2
         7c7mVWJvFYZRfuGSDwRLptK8aQZYN8Q9AnkWmajXcr8pR4is7z1ahG3IOLUSb1GBrt+R
         3+nw==
X-Forwarded-Encrypted: i=1; AJvYcCVAVBz5t0xWVjC4VpcaBn7U8clp8kRt+bhz2giVG+3w1sfsGRBMbBpqMmwemro0gI3d5ysOAXkrkUizV7+F3XwKoTvL
X-Gm-Message-State: AOJu0YxW9T37JQ8Hw63MdmI/lSPKoTj4otvxgNRi9MYh/zjxkg87E7ms
	Eclo0V7wBL+skBYR6o6vmeLkl4lpMymuiVDFOb8UhefePZrH9cL+RcZ1ZJ+9KKTqLhTCvCE9rOq
	4ShPJVdBajeoRGQ3m2GJDcjSKhxjNH7TG
X-Google-Smtp-Source: AGHT+IF+ZVLaa/jX+2n48ZsijDtQkhNZK332y1nUIow1l+s84CQcr3Fjn7Cn2eMDflJLHJ2gmQHbI8z2fFypx4b1AK4=
X-Received: by 2002:a17:90a:e502:b0:2af:ff3:e14a with SMTP id
 t2-20020a17090ae50200b002af0ff3e14amr4461322pjy.16.1714018396033; Wed, 24 Apr
 2024 21:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADs5QabwDtUpehNY3hr6BzKyfpp-Ts54TANGkygWPcN3T=OSOg@mail.gmail.com>
 <Zil_m_1B0wcLejNH@tapette.crustytoothpaste.net> <xmqqedauwgbk.fsf@gitster.g>
In-Reply-To: <xmqqedauwgbk.fsf@gitster.g>
From: Dan Demp <drdemp@gmail.com>
Date: Wed, 24 Apr 2024 23:13:03 -0500
Message-ID: <CADs5QaY=dJ=MXNYgqyEQA9xmcBkeocZh5z9Tq_iNfnFgCHR_=w@mail.gmail.com>
Subject: Re: Git Bug Report: git add --patch > "e" makes keyboard unresponsive
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To be clear, I did close the editor, at which point Git Bash shows me
the next diff and asks me to choose an option (y, n, a, d, ...). It's
at that point the keyboard is unresponsive. Not while the editor is
still open.

If it matters, I'm using Notepad++ as the editor.

On Wed, Apr 24, 2024 at 5:23=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > Using the "e" option should invoke your editor and wait until it exits.
> > The only way Git has to know that you're done editing is that the edito=
r
> > process it invokes has exited.
>
> Whichever editor was launched, unless the user explicitly said the hint
> is not necessary by setting advice.waitingForEditor to false, the code
> should have given something like this:
>
>     hint: Waiting for your editor to close the file...
>
> so ...
>
> > What does "git var GIT_EDITOR" at a Git Bash prompt print?  If you have
> > your editor configured to open in an existing editor window, does
> > closing the new editor tab or window that Git causes to be opened fix
> > the problem?
>
> ... I would expect that there may be something more than a silly
> "the editor is running elsewhere and the user is stuck, expecting
> something to happen but the editor is waiting for the user" problem
> here.  For example, could there be funny interaction with "single
> key" mode with editor on Windows (which I do not use myself but I
> think I saw the word in the original report)?  Is the configuration
> "interactive.singlekey" enabled?

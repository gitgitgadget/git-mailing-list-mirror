Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01B7D098
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418833; cv=none; b=A6bOOKQwX7aV/o6bY6fTlbWh+kFD6AoYiQqPO+tgTCKvSn1B6b6xrpIZScfsOA2M+X6Ua/s34V6RjEiILgB5EZ5H3vOnPriYSKmOjQrHLfZKUI4y1ybIFnBmkE3rP7kaRwHDrj0WRPxjMSU2baBNLq/r9bZZnvubgdE7crjkcvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418833; c=relaxed/simple;
	bh=f9/+14RRVieOMPWbMU3SP1++LmeOEJ/TnUK5MQ1b5M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYzN8vQgPjQsW1f9nN3tpsb78p7WzKcgYSW5DOfXjQn6Nj4xoBbuvwFzkahGzVaUrP5OlUIPk+YXcUV9ntEazAHXVM7cLRyAZdGpb0QbDFzTxUjp7dUGrvt/6erRThyn5r3demC73S2H1h9CGbxRcQLzXVBFqnd3gOECMM4tPiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa68kuvl; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa68kuvl"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-87c0166df31so259806339f.3
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754418831; x=1755023631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9/+14RRVieOMPWbMU3SP1++LmeOEJ/TnUK5MQ1b5M8=;
        b=Oa68kuvlTscMSI3J9ITDecIPfIN9FowCkv29E0TjNgv4QmvBqIkV0zivcdFYns33Jg
         MzqqzZucaZw/V8KlLd37AW4R5XIfI6P+qSpIeC5awaVnnqw4EyeqACP2n7uqGBIFxTvi
         WzxW1c9KELyTuV1iByS4FPMjCO5ExBa+PHWwBreKwJVTuJWQqCz367xfn43laogmX337
         3oLob6TUlI3It3Ew7o6AZFUOMCf00zOmkm751dtG/5qJ05Jj8vsQ7R/WXNIyPg155CJh
         Ibwa7f403FAxuIkXVG+frfnBjVje2yzpxiVYQXEwPQ/GibX9g6qn4jRn98kh7Qx7BzLV
         np0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418831; x=1755023631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9/+14RRVieOMPWbMU3SP1++LmeOEJ/TnUK5MQ1b5M8=;
        b=CRrlS/nBhyBzPiVBcfmDDxYnjSr3CX7mWx2GxA3UsutoWXDyg05HOOC8PGFxltV02a
         HlotSGknqK/lhLz9DiIpzO2qG0u0UtBD6IY4rY/HOSFYKxQTknZeHyB66xp6uP0e0Wfy
         jpyuCdGX4VMj50a7+wK8NsEj/Rq6A7nSS855mlYbpY3avQUuWkeJweBWgAGuDgdrGUBl
         5Mv7PTyJaILxq56gJ9UNTRmoYZvGpikXag+KngaVUi+9PGD32b6JllqcPsUD+sRkDvrE
         2wW0s4NEeGLyGA9zYUIrpsW8dimxBLqe+8/J7SEsUtTv0r1bGERrl5j0tu+U9Ss4Tlux
         VooA==
X-Forwarded-Encrypted: i=1; AJvYcCUhOc2yPvtjR+ZNyQgmXQTWML6o+5QeuqhnGru7IGQ9MB/HmyNRKynAiShs6shvggrQSlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhpJV07x2JnlnCJ25usUPcMnMrSIBxlAJUwdAvn3Ksy6ptEAiF
	CWjdH6neosxwFmvx2HYSRQIQqwNr/lvF8UX2/kR3u9boCnUstJa1B5FBgJ358oyXTFhWrR6rmHM
	P+eetlTEG9V8YvAtCOPdWduP8/PFTdLw=
X-Gm-Gg: ASbGnctwmIejVW479Yu9Cr1yE+HU/qag+c0kghd6LwAy0bYMPKF+Ai5YBjnCt9Mkog/
	XAzqpQ4xMXXUy4C7MOz/clGLV3eBjaPC5K5fDmQMYLPhkkMhS69dFjsLLiCzQE/i5rPggPs2R7z
	xUPJJq/VLGkyQ6ARraJp1matcFXcTe9JZCSYXxxSPN/G9QmxgnL4cJAvdpW3o3+MfSo2NbfnmS+
	WiWEJbdY64eiHnJFExKknHCTgPT/3kt4onw/LAV
X-Google-Smtp-Source: AGHT+IGzU5BnToXCBh1WxelSNuOI30DUdFU5KBi8lbriGfMbtliD3Ul/kGb0ifIKF/jIa9nU3sSDeGFYzIwcRwNJlwQ=
X-Received: by 2002:a05:6e02:16c7:b0:3e3:a49a:917b with SMTP id
 e9e14a558f8ab-3e416109a73mr275915695ab.2.1754418830790; Tue, 05 Aug 2025
 11:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <bda42aa85cf4f332ef60aca1a8937ed4b868fa87.1753197791.git.gitgitgadget@gmail.com>
 <aIx7OEX6AEqNsIHb@pks.im> <CABPp-BEUFaePoJx-dn9hOE6r7mQV_W_6QF2K1sJJ2uXeL81rdg@mail.gmail.com>
 <aJGK1afGLkNAQID6@pks.im>
In-Reply-To: <aJGK1afGLkNAQID6@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 5 Aug 2025 11:33:38 -0700
X-Gm-Features: Ac12FXyNaxOqT2gDLx-Mk7yOkpfBk9RdTX4Xt7qzk_8rbj5Df5kylPyKELLxs5U
Message-ID: <CABPp-BGmipbdicHeFfLQOq2EG5QUk5GxHxhDuwSKgM4x6YO34w@mail.gmail.com>
Subject: Re: [PATCH 3/6] t6423: document two bugs with rename-to-self testcases
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 9:38=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Mon, Aug 04, 2025 at 12:15:15PM -0700, Elijah Newren wrote:
> > On Fri, Aug 1, 2025 at 1:31=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> > >
> > > On Tue, Jul 22, 2025 at 03:23:08PM +0000, Elijah Newren via GitGitGad=
get wrote:
> > > > diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-re=
name-directories.sh
> > > > index f48ed6d03534..69de7a3b84af 100755
> > > > --- a/t/t6423-merge-rename-directories.sh
> > > > +++ b/t/t6423-merge-rename-directories.sh
> > > I found it to be a bit weird that we have this conditional here.
> > > Shouldn't we expect one particular outcome? Even if multiple outcomes
> > > would be techincally correct I think we should expect one particular
> > > result, but we may add a comment to explain that different output wou=
ld
> > > be fine, too.
> >
> > Isn't that exactly what I did, with the note I'll copy below?
>
> Not quite -- you do have a comment explaining why you relax the test.
> But I think it would be preferable to _not_ relax the test but still
> have a comment that says that the outcome isn't quite clear cut. This
> would alert us if the outcome ever changed and thus make it way more of
> a concious change if we had to adapt the test, but it would still leave
> a future reader in the know that a changed test outcome might actually
> be okay.

Ah, gotcha.

Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0101930FC3D
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694847; cv=none; b=RX0ElgtVEOvvWy2tcG7U9OI4CL25H+CIlBifxClHh4VhLHTzudZr5i2c40uNeQflsb6DSusy480RPMZGG1ZO6QZj7x6hLU7qq/40E+e0YMX3P1hxrFDNZxhpawaZtjnhGr93G6KkkFU3rE4+TKLxm03nMqnp049P1MH9wRl6huk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694847; c=relaxed/simple;
	bh=2DljmKdizw+y31itoCKd8EHtpc631m65tX2gwTmjBcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WElAfr9R/9rboyGPn3MS2jk5OH9oa9WQ00DYlvf3SPHA3mty89dlH1wy2FW3L1eFm4y77noLavLFe+SPFFEA/em3RaEdWIPlt5wdJDsRFRvDlcb5QAf9tHMZNuFYvGDXhIomLB2dTirD78t5ae6AqKMqekfwFnB7HktfC5HecuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBnAfAnf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBnAfAnf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290ac2ef203so16420695ad.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 02:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760694845; x=1761299645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIXzQyF6uGfJo2MPgAuqQmSYVkKM4aYQ+CLouUWWVQU=;
        b=mBnAfAnfmAYyUugJw3MFVgmlWt6EB3Sit7vXqkJhkQR17y3QEizoH9bUutC7t4WKvS
         OYRkJi3burbbVEsn3y6AbgPw3As/kpVCfv6zjgBgXBrKe8U2ysbw0g32VuEDEq0FDkUI
         gw+mtA8Gk15QGCgcSAW4uVGUWCgY6QP6dvlDBQ+WyLxqUGohxfup08S3xISm+ztdhux2
         xbG7R0I9JkkPDjroCDh2Fu5bYMvOCknCySpseGUE7vq5FQnE1wPveYF56NWi+4zF8pGx
         +jMegW08RTTSYrqMHzvNqLvvPmiIc5NTR7VBGAWXTUVdnPU01xkdBWwJ82GZ2JbH3MVL
         7KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694845; x=1761299645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIXzQyF6uGfJo2MPgAuqQmSYVkKM4aYQ+CLouUWWVQU=;
        b=twHrqgO8V2+6xG3QA95U1HQQnVGf8gdUAHVBsajWrLR/Y5hS5uCZToDVW9i5x7Wglo
         lTGeC2IJUZHTKyQkgq1Lx0wFUm+SuK/pIsu+t7F9r2IziJR3HxVHl3vgu+uxTS++bPE9
         GxfBG/MGWZ2LSzwUoGxdcry6fG//IZ+8KohN4Wlu47Fp16X+vEdOvzeCzP4bzbzTADeF
         YksZD4PffLymDLSoXnTRH+NgksuJqcz0KSO8xxqwkCGns1jPb5ZAhyxWHVNX/TCyRBfr
         pCIRzfcC7hBOwNUEZWOJfYm487M7jdngEf6wMJQvc/zB0AWTm7pADKsE/Ho3ZZSoLLrK
         gtBA==
X-Gm-Message-State: AOJu0Ywo2HZsvwf++7BNXp98Sub9LnA0E16gDMxWTxqCbGCRT3KrwVJe
	3jskNEmPups7TYrb1kKW8zj/aFCZk5p4qJpKxlSsWhRc9vzh1+SJrCDj4CM9E1k6lFX2UBLgVHw
	4pUo+8bFqpziIhVYmACpe5G9A569fFBeNGzATNH9IRg==
X-Gm-Gg: ASbGnctmmFUFqbVx7TKRMqcz/6xT8knZE98dyJtddp7Ngg7Ky1/r2jAv8OAsl7Hi5mZ
	fJ1hvPZg4kL3+0dXMOxkCbfALch5ly+w+tumyJpdDFHTawInV/2m3yX62jttcksrlg1zW6wjAD9
	hsnPwu2H96Uf/+MvV7rVLXiT1Fjfg14IXoUa7oMe1GcY/lGKGa8GwU/Y8L+nihcFC2p6UL/JB4A
	/RyUtb1XIbjRSJwthHaxsXkECBPgIT1yQELKz9ab0FnmFTIl72fT0GxNC8p1/QXb977LYx7dvr6
X-Google-Smtp-Source: AGHT+IE12ToQSbhsmWHm3SfCTsNFisRkXjQ/iOfZw7CtLVCVXNSY/DvE+cMnhS8s5wO1kf6hgHnbhnkqa7PwYzRSj2M=
X-Received: by 2002:a17:902:e746:b0:28d:195a:7d79 with SMTP id
 d9443c01a7336-290c9c897cemr38006085ad.5.1760694845153; Fri, 17 Oct 2025
 02:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760571220.git.belkid98@gmail.com> <CAP8UFD0Lzmt5ayQ3iSXtmJohDawmCEiu1r8Gq2mKTMy-1gX_fw@mail.gmail.com>
In-Reply-To: <CAP8UFD0Lzmt5ayQ3iSXtmJohDawmCEiu1r8Gq2mKTMy-1gX_fw@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Fri, 17 Oct 2025 10:54:05 +0100
X-Gm-Features: AS18NWAUFAZMbqMJhOMSYSpVcsN3eq9RexJovSsQ1wkI2ADrzlKmleEsQpGx4C4
Message-ID: <CAD=f0L9OFO5N=_3iiqMh33WK+AV-zQPhpdTLn2JusNf4AwnYrg@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2 0/2] gpg-interface.c: use string_list_split()
 instead of strbuf_split_max()
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Oct 2025 at 08:58, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Thu, Oct 16, 2025 at 3:04=E2=80=AFAM Olamide Caleb Bello <belkid98@gma=
il.com> wrote:
> >
> > Commit 2efe707054 (wt-status: avoid strbuf_split*(), 2025-07-31) notice=
d
> > that the array of strbufs that calls to strbuf_split*() provides are me=
rely
> > used to store the strings gotten from the split and no edit are
> > done on these resulting strings making the strbuf_split*() unideal
> > for this usecase, with the string_list_split*() being a more suitable o=
ption.
> >
> > The patch series by Junio Hamano can be seen in the link below.
> >
> > https://public-inbox.org/git/20250731225433.4028872-1-gitster@pobox.com=
/
>
> This description is probably good enough as-is, but here are some
> comments that might help improve it if you want if you send a v3.
>
> The way you explain things up to here, it might seem only one commit
> in that series is about avoiding strbuf_split*(). But in fact the
> commit you mention is the first one in that series which is named "do
> not overuse strbuf_split*()" and contains 11 patches.
>
> So I think it would be a bit better if, instead of speaking about that
> commit first, this cover letter started with a link to that patch
> series and explained the purpose of the whole series. You may then
> mention one or more commits in the series as examples of commits where
> strbuf_split*() is replaced with string_list_split*() though if you
> want.

Yes, this approach would be better.
Thank you
>
> > This series continues on this path by replacing instances of
> > strbuf_split_max() with string_list_split() where the string from the
> > split is merely returned as char * and no edits are done on them.
>
> Yeah, some commits in the series do that, but not all.

Yes I will reword this too.

>
> > Changes since v1
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  - Added commit reference and link to patch series for previous work
> >  done on the subject
>
> In a cover letter we are interested in the changes in the patch series
> since the previous version, not the changes in the cover letter. This
> is because the cover letter itself is not merged (except perhaps its
> first few sentences that might be reused in the merge commit, but this
> is more advanced, so don't take this into account for now) when a
> patch series is merged. So a cover letter is more about giving context
> to reviewers and inviting them to review the patch series.
>
> So here it would be nice if there were things like:
>
>   - a summary of the changes in the patch series since v1,
>   - a range diff between v1 and v2,
>   - a link to a CI platform where the v2 has been pushed and the CI
> tests have been performed.
>
> This would help make reviewer confident that the series is in a much
> better shape compared to v1 and reviewers' comments on v1 have been
> taken into account.
>

Thank you very much for the review and suggestions.
I will reorganise and send a corrected v3.

Bello.

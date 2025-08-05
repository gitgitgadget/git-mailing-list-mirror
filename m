Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D621A5B96
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411420; cv=none; b=e8+Lu5Kf4OkNtkaWPb0LHh8yXrtaolkndLI/H3NAcSk8Y0Z6qZUS2HAq3YRBvUOcRohKdSRLXYdIbf60bxw+0QaSX5h9M0j0z6zCMDm0zFlgexTIC0bxC+RSmP2r/H+8YihPPngY51XMPUfTUUEF3vdXzZZmuczgeHsdwTd2b3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411420; c=relaxed/simple;
	bh=VL6WtpQ2EwxHLVWGXNWD9JFdBijOdrQChQJukSIxma8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDvt973+bmLywpHQicgHSpGRT4r7Dh55vP/LnvnaIgkPzGUeGEdVf+DBzeNlyfoOkQ2LmWMQyKFzdSI8Q1i0AcrRlZimsDDuKe1yC1UhLiMDIJzWklbgjAzIDRb5GFEPL10c4gYplbWETRyxCG9ZbVrBzxQCJa4olI+1vkGg7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FY7O6MEe; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY7O6MEe"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso8931765a12.3
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754411416; x=1755016216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCJlvte+TLkZYk6rLIwiSkDs1LzmEDJzcn0DSxOrUIo=;
        b=FY7O6MEeOpH6/v3uOMwUzoMia+zJ+nslteiQbVlGMyoa1krcJLwiK7ETYCfbm9FM19
         KLkiBuimniClxRFVv8mpEV1pztULa86+6bKy/z4EnhH94tgWB1lsSxwgdC6Pp/mOr+Q9
         9qt15mpfIIwThSNfyzpiXtm5/Wt9ydalZfLgUHOzDx4oZ/WiAaWWiOY0A3qAdcwxO7Gt
         AU3IU8FoTRULHFNohInPCZUKWGqjPn1F/5USWEDPT60Dvge6l73cahfgm6vW2XsMP21I
         PpoxZfEESvKYKMqtM4Wlrg9l69pSlQWxPB3x9D8/3Z2BZFyTmzychKpdz02WOwJf4stH
         vS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754411416; x=1755016216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCJlvte+TLkZYk6rLIwiSkDs1LzmEDJzcn0DSxOrUIo=;
        b=b/nCvIozQmrXbvCxHghit7fhk3IcK8FeIxJsbhiyOtWQH5hspzmn/TjgfjaS1Oq6NI
         mMD9lvlEBspNnsJcD2NAfq7IDKTa0Qqi1FnOaBHt6oQJ3Xn/2PGXxYxamtclwBrtIo6l
         vJBgcs9SlX0oIgPCUNYah+k5dHxiJXbRYJJBaXqUQQGam/pCRCojUpERGgy+xLQ13JRT
         a1ISCiE5GoOtVz+zGkRHTG37w+M5/MwW8qRGD6q1EIQZGW6HjJTuPDyuJoH2wfdev59O
         YPf3EgEtgUq6OcWzEiG0ss6v1+6fppkM82KJVfWVNTtZTMuXNgaEvevQ0qiYIkRT3S1e
         u4IQ==
X-Gm-Message-State: AOJu0YwIjp2SJIrbkuYrALf2m+HJxAaRe6CmGgiKVopWNTV7AmeBadCb
	ALRA4h1TVF/FDl+TEsYB6V3fIDyaCB4gks11xyRoCKey1ua2I9261Gula/1q9VMuM8BKawSpLAh
	iKzpJCUc7aGga53mpTJuPH3TnlvNGiJs=
X-Gm-Gg: ASbGncukvETmt42x9cacsY6qm4kxFl3u1wbScsVNEgoV0H7yOe8LmQr3MZxOn13Ri+O
	toBQ8W5H2TnOlYlu+vOb+L/ypfP2dX91h12BHtQGWfNgBNBkDqTVEI6aPzfU3RmutIqhdVqxB4y
	FQAFZsVGmbGvAfxF3N2DOOC2qx70zmaKvBJoZrurWQkb3V6ftDKEdeKjP75hEKsdIEMr7YPjIEj
	WOCQttbPLc4VGi4AYJu+knVZlAvaLbdTY1iyR0Dgg==
X-Google-Smtp-Source: AGHT+IHlJ276T+s+FfPoSZVMKB6LeUHkRw9yF1VWQUsqCm/caqk7TA4Vfnd7Qh8SIz272t1LeS/ueg8xtSHS30FY3rc=
X-Received: by 2002:a17:907:9721:b0:adb:229f:6b71 with SMTP id
 a640c23a62f3a-af93ffc5ae1mr1595877266b.5.1754411416274; Tue, 05 Aug 2025
 09:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqms8fbilv.fsf@gitster.g> <CALnO6CDm5n0oZsXzvKz89jVg7E_h=1gqPFs2x7-UojdcY_Di_w@mail.gmail.com>
 <xmqq4ium3w2x.fsf@gitster.g> <CALnO6CBLF2Zxhy=mvz61U7M3X3UNA-V8R4tkzOvVjKWpEwi8Mg@mail.gmail.com>
In-Reply-To: <CALnO6CBLF2Zxhy=mvz61U7M3X3UNA-V8R4tkzOvVjKWpEwi8Mg@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 5 Aug 2025 12:30:04 -0400
X-Gm-Features: Ac12FXyctgbHEGBPFVUNspNvmy16jEbiPMGX7yd0mYWlKyjXhavd1d78zzTrZf8
Message-ID: <CALnO6CASXHv_wwmAfn9tZ4D1qdJBgVKfLEQ9+LTEF9FJPiS0qQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 12:23=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Tue, Aug 5, 2025 at 6:24=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> >
> > "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> >
> > > .... This is true whether I use
> > > my copy of the topic or the one you publish (4c8db1e55c (builtin: als=
o
> > > setup gently for --help-all, 2025-08-03)).
> >
> > I think the breakage I saw was while testing the 'seen' branch as a
> > whole, so there may be some interactions with other topics.  IIRC,
> > it was running "git repo --help-all" when I saw the complaints.
>
> Hm. Will try again with the whole seen branch, but after merging
> lo/repo-info locally then
>
>     make -j $(nproc) SANITIZE=3Dleak CC=3Dgcc-14
>     (cd t && prove t1517*)
>
> still didn't fail.

With apologies for the mail noise, but I can't seem to reproduce any
failures here on 371c45b569 (Merge branch 'dk/help-all' into seen,
2025-08-04), which is the latest seen I can find.

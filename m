Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97C25A2DE
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766441220; cv=none; b=JkECZp75onwT7gNaG9LFqNs6LH0HpdM4Vo0T9/yjA6VGR3InfPPQ3kfil2/pLe+GqoB/v6FVy1ktpQN0E66zQZZicHqmx2DDZj+9gR/zjofq8vVJtatafmmDMANLa3o+v3nbl+L9KgEP5jqARoViHOeHs1RySQ+s0gtaKyotIi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766441220; c=relaxed/simple;
	bh=YDIeNJnP3mkZROWVcA9GFsgSpRCq9QrTzCnsX/k5SiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXNmfdAgeQhGtiZAx1v+Tp/Ur34XXD5b0oO3vk+CwDa1kmNlGrrqQ1z4kk8olbDs7HrZTbow3eiTd5o1kc9l6/wLyQhOyRol50bPiHn+1Ecs149tU/Sja5U9V3b/pIPBeKOrGvRAKH96xOfdoSdijOZ+5KtnuP9cm04a8EekNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRmvP87N; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRmvP87N"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso3377986b3a.3
        for <git@vger.kernel.org>; Mon, 22 Dec 2025 14:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766441219; x=1767046019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHgf8k5GUi9ZPpMhTKYADChOsyNPOIWwGhqGfgqCK38=;
        b=mRmvP87N1N/WIgrMKDZj5d9rO6TcKUOVj8oFLEsddc8jdacWCGmkl0PFyWzF+QBC9A
         fi68q7+2nNp6i/+818077FvzSvDm8TTskMHi7AGGU29H7se+3Rpjwh/LdQF5otRxMv/B
         uk9dmV0r3hW/+nOXimLGkh4My8/aTnfX/0DrO9CdSXHNx7NirWfpE09tDIyRTDGTj3lJ
         a1B4BIv0Bu4CEGk/xJ0cVu7kNtWasMBbUP5fMOvYn6HWKAuwBPsuPlLPYnMedFsd4iir
         +drUvyYdJItYxpfYoJmS0KJgAwTcdFddURdIXAeYufs9QpHyUCEKMBOVB44tHhmsaq0c
         x/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766441219; x=1767046019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CHgf8k5GUi9ZPpMhTKYADChOsyNPOIWwGhqGfgqCK38=;
        b=NjioiwHvpYphcsv3cRLsyXo0WfLrTaBApeXguQgHPMtTR6WzXbcrpHTkH+4RmB5Vjb
         1pi8xzWfN1PRuH/eXkmmeWo1iNs0VK+3J3NuHUKEqfjFyl2gBIcAbSoS3sDgYVRRSvGe
         DVOOCxJsa04zg0YuM6yEXXM3xARG2TpfsxrKru6SSaVHdPXtOjC+I+rLBtUFlDucY8cp
         QBAWnBL+tr849sLP9VAkOs742BqqjTIrapQb/0qkPVXXnYweF1eqAQExcFbz4Lq2ZId4
         kj1taoaBO+ffj4GdvXJf1eoSrM8cDqprAqDSd3blZwP10MdkLGcYnnJpYGyMUAVz6QRK
         hMFg==
X-Gm-Message-State: AOJu0YxH9wG53iev2car2EhIi2i6fLep2A6VA3PsLtNpMPCm65cpym81
	CKS25ibdcOMOKOC5rNsWYkp02ty+/1PksGdBGyA72kJE3IMpkJNdJikak3tlxV85i55NRIw6fjK
	0QcgD5v9HAqbsfWd5eHfaW4IaCWTHk9J3jqYp
X-Gm-Gg: AY/fxX5Cp4kjvBhzj0rNdV2hxgFl+DxrJbQZ3jbKHSCHonKwEpT/pRHmEEPQZn0HB48
	uDJi29lVznlSHWfWCk6+2ARQo8rUVPdYhN3UlaVsKtCxsMSCHZPDaEIqcHQwLryc5ud/pKLctwa
	EEiFTN399b6M5LD3DsRrT8uTK7Q30dVjg9mQpm+42S1MfP9MksMzSIKim1FSD6i8npw2tzxgbGR
	LCpYSBqvFvvsamPOMQosiXW0pHE1q/oXFg1cQYO6dw7miR7HRchkD3Wgu2dCYLI/2AQGaBg+ZuZ
	y+ypFeOWqYFYP8dXYfstjtU4fmLl
X-Google-Smtp-Source: AGHT+IFya0gIXS8bF089D2iFKATXOhjUE084jPolD2BF//nVuh5UId1hf/VyYQ7Bk4CrCK26AyHwZIe1C1B/QhKrUD8=
X-Received: by 2002:a05:6a20:a128:b0:366:2714:7e8a with SMTP id
 adf61e73a8af0-376aa0ed32amr12208004637.67.1766441218705; Mon, 22 Dec 2025
 14:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq5xb0yqj9.fsf@gitster.g> <CALnO6CDm2K0Bn43gjXTvYqJ8gbX+8eZK1YPn1gwuThizK6d5VQ@mail.gmail.com>
 <xmqqtsyjxp63.fsf@gitster.g>
In-Reply-To: <xmqqtsyjxp63.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 22 Dec 2025 17:06:47 -0500
X-Gm-Features: AQt7F2pigtzVFFxCdAGKMh2vdaTl5XS9wAXu1W_UhkGhEPGNHvvXk7LeM5ytm0s
Message-ID: <CALnO6CA4N5yC3oHmtihdyB5mprB_GMbfiLgi+XeY5DyGK97Pcw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2025, #07; Sun, 23)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 1:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > On Sun, Nov 23, 2025 at 11:59=E2=80=AFPM Junio C Hamano <gitster@pobox.=
com> wrote:
> >
> >> --------------------------------------------------
> >> [New Topics]
> >>
> >> * jc/optional-path (2025-11-20) 3 commits
> >>  - config: really treat missing optional path as not configured
> >>  - config: really pretend missing :(optional) value is not there
> >>  - config: mark otherwise unused function as file-scope static
> >>
> >>  "git config get --path" segfaulted on an ":(optional)path" that
> >>  does not exist, which has been corrected.
> >>
> >>  Will merge to 'next'?
> >>  source: <xmqqikf47ajk.fsf@gitster.g>
> >
> > Any interest in also marking this for 2.52.1? It's unlikely to be used
> > much yet, but since the segfault affects several invocations (git
> > blame, etc.) it will be irritating to folks who try the recently
> > released version.
>
> Yes, this is a clear regression-fix material.  The branch you are
> commenting on is designed to be merge-able anywhere the original
> topic that had the segfault can be (or has been) merged, by building
> directly on top of ccfcaf39 (parseopt: values of pathname type can
> be prefixed with :(optional), 2025-09-28), which was the tip of the
> original topic.

I noticed a .1 was never released. I'm not sure what the
protocol/process/etiquette is, but figured I'd bump this in your inbox
;)

I saw your other recent mail about family things, so no rush of course.

--=20
D. Ben Knoble

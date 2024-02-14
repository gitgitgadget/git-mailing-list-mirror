Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658AA41A84
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950142; cv=none; b=rnpTCpKyNhT4nYyliB6ceRDGisGpWzFE/CapauIOvulRGOsZ/fphFqACbyHQ05hrIBbr513vqj+5TzdP9mtNQumkc7eFDcKoB4YHPjHgJne/LVAiS4KFpDDX9G57vuCbWBXAh72oKZwXmPFMYABbOgCxRc8dSqEksNkRzb4Se3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950142; c=relaxed/simple;
	bh=dwv4/UpDVeoZ70xzZzc5csHg8LpFTF/Ujy2egex86qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoblATRTqqwvYiVff9py4C2M81JbLv9wfX5nPWXiWZo353R2YYt7VfDM+QerYnL/HTLq6UQKVnCIItSiz40RafAgPJ44hRRCjz3PdXtiYQRz9dLHw3WZMGsNFWk+JI74v+axnI4RS/1pBSKeXk/JoKsH4szgrATXQZL7DeTimJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOpJJnpj; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOpJJnpj"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-511acd26c2bso319316e87.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 14:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707950138; x=1708554938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6StsZtWf4CXTwOZ2P+okZzbWueyw8O6K+d4/OVs0fAQ=;
        b=cOpJJnpjNR7DHVpIsixmbEJSAmXeQXoGKJ3JZ44sXSo1Qiw03Jr9flj2CrASacEzIQ
         //Jkk92XYYOUAhY6bmtKqjWqZjj2DXPbkKepkVqRFaFZC5IAx5nzPHV5GeAKlSsmml2E
         Lqn23+qu7cDR8OdNtVwRUb7OFpViFQd/NM1DPSCCPdu1OlpfKmf9W0dVCupC4exohuix
         gGbzMJvrrpLb+3QuOeDcJKxW5vk781xzLf39NNqXOL395q6l7Ce6x2fuhTiGKWs1TYXw
         P8516ZhzGK3iJOQd5mdh6TESXGafykUPt/xEiPbsaYSgbiSex01TR9qC53QkjrpH/H4U
         isIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950138; x=1708554938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6StsZtWf4CXTwOZ2P+okZzbWueyw8O6K+d4/OVs0fAQ=;
        b=R5WkoEXcReKz8blU8tcgIXlD21X2ARnuhyAAK/ENhL4OtzBUY0pEsLVpWA8SXhZOcJ
         y+E85mriBDkwf44k8mxDMGQM/bpPaYXoePpL9P83M2ShrOcmNFi+ExjsbFMCHp68DPow
         BCaHurRefqUJ7yb3CKOWY7c4wwVf8gsnCc1nfw9fKldNgDBgHnsdFMUA3K1rc1qASWY4
         Z0HID0+Pz7pHUr6viAQ+9cBbR3id9uXrouIZEY9yYnB2zvNudGKRZ0Va7onP8PZpQFNQ
         xfS7GQLE91leAAl2Z/RW9+x1ymxW5wnKVY0y8diURR0XYqKWcLpM3XEErylzhs0kzDn+
         pIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiUhcn7PrGqqtusfBFSnBPL2cn5xGO8spPdSJfAGeMRjtV1jiMAqILRXmYoxvtwyx8nGBTnzigRXmVCMIBprwSJETg
X-Gm-Message-State: AOJu0Yxm5KBNn8QphBCpZoyc/U/fM4pnfUWxJQB4FYZyVo5n0Zx4ZSDp
	CwqT04m9gKziOcgFACBHwNx2ExZeeFxAQldtM5eKTzAQi+YbbdLv3h7e08wjW0YRjIGiXg1akcP
	vAR42jOKGjVT5heXqc1hvY/svShA=
X-Google-Smtp-Source: AGHT+IFxRtTt23CDFn5Bxi7eTybu+2/ZKJWrQUKpYaWITeDBE6i0vwMufBrkFkSqDU9KdoLGVM/iG8F5/n6D69gpfII=
X-Received: by 2002:a19:ae09:0:b0:511:84ae:9f38 with SMTP id
 f9-20020a19ae09000000b0051184ae9f38mr95228lfc.36.1707950137969; Wed, 14 Feb
 2024 14:35:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1663.git.1707860618119.gitgitgadget@gmail.com> <xmqqzfw2vr7c.fsf@gitster.g>
In-Reply-To: <xmqqzfw2vr7c.fsf@gitster.g>
From: M Hickford <mirth.hickford@gmail.com>
Date: Wed, 14 Feb 2024 22:35:01 +0000
Message-ID: <CAGJzqsmSzMqEG1OU9dH6CORV6=L7qUAFNJSmi41Lqrajf9mSew@mail.gmail.com>
Subject: Re: [PATCH] credential/osxkeychain: store new attributes
To: Junio C Hamano <gitster@pobox.com>
Cc: M Hickford via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 18:25, Junio C Hamano <gitster@pobox.com> wrote:
>
> "M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: M Hickford <mirth.hickford@gmail.com>
> >
> > d208bfd (credential: new attribute password_expiry_utc, 2023-02-18)
> > and a5c76569e7 (credential: new attribute oauth_refresh_token)
> > introduced new credential attributes.
> >
> > Similar to 7144dee3 (credential/libsecret: erase matching creds only,
> > 2023-07-26), we encode the new attributes in the secret, separated by
> > newline:
> >
> >     hunter2
> >     password_expiry_utc=1684189401
> >     oauth_refresh_token=xyzzy
> >
> > This is extensible and backwards compatible. The credential protocol
> > already assumes that attribute values do not contain newlines.
> >
> > Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> > ---
>
> OK, this adds both oauth_refresh_token and password_expiry_utc,
> unlike the recent one for wincred, which already stored the expiry
> but the support for oauth_refresh_token was added with f061959e
> (credential/wincred: store oauth_refresh_token, 2024-01-28).
>
> >     [RFC] contrib/credential/osxkeychain: store new attributes
> >
> >     Is any keen MacOS user interested in building and testing this RFC
> >     patch? I personally don't have a MacOS machine, so haven't tried
> >     building it. Fixes are surely necessary. Once it builds, you can test
> >     the feature with:
> >
> >     GIT_TEST_CREDENTIAL_HELPER=osxkeychain ./t0303-credential-external.sh
> >
> >
> >     The feature would help git-credential-oauth users on MacOS
> >     https://github.com/hickford/git-credential-oauth/issues/42
>
> I do not use macOS to use this on, so let's see how others can help.
>
> Thanks.  Will queue.

A first-time contributor contacted me to say they are working on a
more comprehensive patch to credential-osxkeychain, so let's wait for
that instead. https://github.com/gitgitgadget/git/pull/1663#issuecomment-1942763116

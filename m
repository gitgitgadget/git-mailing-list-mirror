Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D77C088
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315056; cv=none; b=avsRa/BQRGkkjT45Jdz6Yqj3nSaICGquwFfA54VIvn21qJd+r+CJ8kXrl+QBnMC03F4SNC6FMTRqMnz0W8VeCzgcRqajaW1zWjEQOur4iZyBdNJ6x2vq6fyOoyePDJtbVipa66zhb17hRIwxWkIMbGI2S/zNKzfd/nafVJsFCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315056; c=relaxed/simple;
	bh=WhsCbOAa+sLvcF8RfLdNROJL4PJChqY9/zxfsrfsc94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKabbWa0qQ5C5eswKaA5aTwffD1x0LC18v1oiT1+OIWCHx4zc2pup/7Afu8i5p3oVZizdHtEQ/GeavNZWnR+snJsG9sT/8PuTQ6BuopixqrnITZ+49DG7r7elYC+naervwHaYX7OSSKEbvVMRjq8zs14WeVmf/9Tnn9nTM9Q9NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+wb8hMg; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+wb8hMg"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-21432e87455so421745fac.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 06:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707315054; x=1707919854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tpcu9LR8fDI9TzxADElOe7Hr/rRBwaPipNCuQuVClQA=;
        b=Y+wb8hMg9VBeEuAZbMH7QETgfrPsoPgtQ3Y/I/bRw1Tx6Vyh1JSObeEUWuFQUOXcSC
         T9t2PSSyS8n8RsmOJFI2hyyy9pmCtD4KhauyOy3FCCLDcyOVln6+VtC+XXnF0fAJN8YP
         8vtEyxUb6hzdjx48rbpGzs+UU8hHR8XaBFevZO/GX8EP53q8mRsCGsClRoJzwuciHFc5
         I8lM0txwbcpZuUfEzOAI8m7jDRTQ6izCaZwnJrvgfHp4SBbMjtY8XwDYp9ZM9l4iJIGw
         kJg8/CWeKonuFr6H51q7xynw7zfktp7YLzrvWQ5fTJZhVLvZn+HMNp8auByJg7/og00R
         BtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315054; x=1707919854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tpcu9LR8fDI9TzxADElOe7Hr/rRBwaPipNCuQuVClQA=;
        b=dlulRt76+r19ILr/Z0CGbMm01B/UfZ/FlAo3HLkRWTR07V1ol+gvB3bqOD7Ds88dsG
         ZE5ZJmbBwm1XSkWIEBXGKWw9tVn/HgleW3oJ0j984EmxM0g49zPLyOpkpwEQTXDVu9cL
         /b9snBgFVOnzUGyM/bSGTn5mvWFIVZBgtokYbs3UcaWLiHfW+PaVq/Xe9vaN/mjJfjxm
         PuRfkU33ElxIuu1onQfloljGWb2zEMB7Aca+/JQuRbF3/IZbcqtrewkw6R7H9clnQCqy
         yUN1kaiDveaCIJa14wzrKREsdWiSq33sUHGSGK1PJcQPBRQpNhYo9knDIPWLTIHyjpii
         ZpKA==
X-Gm-Message-State: AOJu0Yx2UAQSAXzx1hy4xeiTWIhaLg2vIxXD2uP8iXcf5cal4rrQKXzW
	XDx3WhfChMho1ITw5vlXKSfuxK0Vwy6EWaZglssbi8qNkMuLTbbnXvdTqP5CnZN/XsaEpg3QVO+
	CciKVimAF4ihjVQiQY/AgL59skP8=
X-Google-Smtp-Source: AGHT+IGfx0lV+6gGguARt/yQAzak1gZvzdk89aYCXcWA3+XhusUDZqpnDWV0UufYUmmlDL6zjA+yLNwI9wXcWP6AShc=
X-Received: by 2002:a05:6871:287:b0:219:59c3:8120 with SMTP id
 i7-20020a056871028700b0021959c38120mr6684275oae.54.1707315053969; Wed, 07 Feb
 2024 06:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com> <20240129113527.607022-5-karthik.188@gmail.com>
 <98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com> <CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
 <92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com> <xmqqle7xjzic.fsf@gitster.g>
 <xmqqr0hph1ku.fsf@gitster.g> <CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
 <xmqqcyt9fdc7.fsf@gitster.g>
In-Reply-To: <xmqqcyt9fdc7.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 7 Feb 2024 15:10:27 +0100
Message-ID: <CAOLa=ZRcWYmEYnxh_=ykOerahZ61xaanLCj_JHHLvtrvN=Xs-w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk, 
	git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 11:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > I think this was what the earlier discussion in the RFC series was too,
> > but Phillip definitely helped consolidate the point.
> >
> > I'll send a new version of this patch series with `--include-root-refs`
> > option and we can discuss on top of that.
>
> Thanks.
>
> By the way, I am not married to the "root refs" name, but
>
>  - we do not want to say "all refs", as I expect refs from other
>    worktrees are not included, and possibly the option when
>    combined with explicit patterns, like refs/tags/, may further be
>    used to limit the output;
>
>  - we do not want to say "pseudo refs", as I expect we would want to
>    show HEAD that is (unfortunately) classified outside "pseudoref"
>    class.
>

I'm thinking "--all-ref-types" might be a good alternative. Mostly because,
"--include-root-refs" seems very specific to the files backend. Also, we do=
n't
include other refs which are not HEAD | pseudorefs, but in the $GIT_DIR.

Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D516DC19
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720201201; cv=none; b=fxqKPVhrA/mGvLmoQaLqHgphekOV6TvY2muF/k8S1WEl0OI4vtN0WZw3e+sJ02OBY1AJMVqDWsGay+vZLQXx0l7WwDIZcH2c8s0bwBdnqOC/GsRkhfdO8TRwVM21poqaAPK4VvRJsQrY7WePUcnlb/z5oFId0XUzGADqTlU8/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720201201; c=relaxed/simple;
	bh=X6Q0Wk1BybE/lqbQRhua1UIRjqBMGfA/VX27U5k9bc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ra1aPKEThIqTZs3NA4ywE94uxa4X2TYkO+waRS64xgzXImsXOnhjQtxVyeUnd5GCBQDKV6Fh8q7E1FvGBIgSD20p20c5Ux/+A+GPgne+z1Mgn+Al1Hvmfz1UZ0mwdKyYKMAZBAZiqbC4aTREz6yOplfI/BuWJxCtqtr403V4CTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZn+Bzll; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZn+Bzll"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7f6846df21fso10393739f.0
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 10:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720201199; x=1720805999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWZilmDGvM/KsCsFxsurCbg1jzR7rO5JFqiUoEa+cqM=;
        b=eZn+BzllhGDn63Qk0mCMQHhxEd46mZblZnYj/R6hfkjw7+oaA5uOLM5RLXEMt2Fyi+
         F2Leo3FHso02PGUVsFeZOSNnIRrSYCRrd8EhyhBKOKg4/LqYnN3ONI/TmFTSsmPRnawf
         CTB7f2MrEvPI84C9bvdmC7QneTrcVOM2z8OLqOwzOtiCcsGDai6ijqHxYDFxPnrvBhgK
         BjgOOIBO0ZDNxacElaYszOWnKWSP001wc+2U8/2H5Rsructir1v3akks26e7ESwzYGXZ
         LFqM1sX/ibK+Kb6ZyP8EBBqSc4DNHfETP13XQi9Ik8WHOpjk0d1LRfj5c95tbEd+qOj5
         Cf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720201199; x=1720805999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWZilmDGvM/KsCsFxsurCbg1jzR7rO5JFqiUoEa+cqM=;
        b=QLypGz4Csgp6xp4G/sqc0NaQWxI709Vsi/TanvZVDnwk0GPWWGXn06wPNx8qyBcTnU
         Xos5idrYg+6HW63mNuI55B4MtC1NMil+GjX4P9iEosH+rworqucYMZWQi5WqffMavFAl
         6M7gGtDXOGjml5uGJXD2bJOBd8fVaplQFbwp4Jx5TjbkSkb9KBdo+aWDGOZAm71Yhyl1
         mMhOwUAZ22u4E2rw5S4N8BJgV4EZWhZP5TI7Yo1nYGl3vfD69Ds8i9/GAS4Z8x0dj2Sm
         E6Nnoj2MjH6nYyqfNhGacBRz6t09WjQHWtKLAw3MooZwZIQDUA1ROrBjkfsdL2rT8COp
         gp2g==
X-Forwarded-Encrypted: i=1; AJvYcCXNM8g8mR0M4D5vBJDQm+L7HJOc5kkKxm5NhinyHFEQVbEaPOqvTQZu17IzdV8o0sagY+x1w1x7NUEuiq+AgtyV0Hdt
X-Gm-Message-State: AOJu0YyGXXNd3diIv/20WEVUi7s3uF1Ugx2K71COMWS6GIWXneW2P1SB
	D8kA7rLMIWZqe9urnCEt90soGRp1pdUAezkdATCIYTB8y15Jb5KmuJYucLYLnk7ZPWs50gCa34p
	V+SfQwdJ+JN07Sg7DzCtIQcBDthk=
X-Google-Smtp-Source: AGHT+IF1aYG+xrZffWnPztmoZClL+Kbb3wHZZ1XD462NOYCLPO6aXjwILfdG/soX8pGwvNvoS5bnGXlC78oSUFbnjJA=
X-Received: by 2002:a05:6602:600b:b0:7eb:de88:48ce with SMTP id
 ca18e2360f4ac-7f66f985eb2mr361460139f.2.1720201199003; Fri, 05 Jul 2024
 10:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1741.git.git.1720016469254.gitgitgadget@gmail.com>
 <xmqqmsmycriv.fsf@gitster.g> <dd1f768f-a137-428c-8a60-c5e875b66592@delpeuch.eu>
 <xmqqr0ca9qkj.fsf@gitster.g>
In-Reply-To: <xmqqr0ca9qkj.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 5 Jul 2024 10:39:46 -0700
Message-ID: <CABPp-BEspjHqNXSAwptgxP059qOFU6MzwAd23-893Nw99ft_Ew@mail.gmail.com>
Subject: Re: [PATCH] merge-file: warn for implicit 'myers' algorithm
To: Junio C Hamano <gitster@pobox.com>
Cc: Antonin Delpeuch <antonin@delpeuch.eu>, 
	Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 1:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Antonin Delpeuch <antonin@delpeuch.eu> writes:
>
> > I'm really sorry, I thought the switch of default and migration
> > plan had already been agreed on in our discussion of my earlier
> > patch.
>
> Ahh, OK.
>
> So we did some time ago floated the idea.  I do not remember how
> widely accepted the proposal was, though.  Having a such reference
> and an explicit mention of what we have and not have yet reached
> consensus on (either in cover letter or after the three-dash line)
> would have been very much helpful.

There's been a few discussions, the other most recent one I remember
was the thread over at
https://lore.kernel.org/git/Y+zzh80fybq8Tn66@coredump.intra.peff.net/.
(And beyond the git community, there's
https://lkml.org/lkml/2023/5/7/206 in the kernel community, and if
others know of discussions in other large developer communities I'd be
interested in links.)

The previous discussions felt to me like we were moving towards
consensus, but while I found that encouraging since I think histogram
would eventually be a better default, I did not make any actual
proposals and try to push further towards consensus because there are
a couple known issues that I think should be fixed before we consider
flipping the default.  I have some work-in-progress that was put on
the backburner a few years ago that I would like to pick up again, and
if successful, investigate how much that helps general cases in a
format that can help people make educated decisions, and then again
float the idea of changing the default.  If consensus is reached, then
we'd change the default across the board -- diff/log/merge-file/etc.
rather than just the somewhat rarely used merge-file.  At least,
that's my current plan in this area; if others think I should
investigate things in a different order or would like to see
additional steps planned into this journey, please do let me know.

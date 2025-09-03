Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4874819C560
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756939741; cv=none; b=q7uAvjsQCJe+OfgDpSIvjkvKw/kN8cT9tHaQBGb4s58Nh1w8Y3vUK83PE0hCxPGwWC078sjF0YhmH2dzO/q9xV155FsK/KV/T+GCl3pXwl7CeVXOw+dxIBaqbIC9rXwNEYWZ4EOUf2CjYiPw7RQhrAmLevthqWVP7/aSeLEgo0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756939741; c=relaxed/simple;
	bh=/caXtB7ZOgW7Rkmr1KKKrlyXKICjEWblnXDfAFHI3lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PL41bHknz75xfM1b4rHlhS8iHf0bCA0fxT2GkDjCofzXEObjsMQfPEJ5/j+Fef6UJrIXa46o9/XqYM0+sv40dyxcOvxZjkHNYT1LTnuaAu84odhdu+JX205svSIdD22WvJ+5jOJ03F4mU7+8q9skoX3jb/5hLn+lsCfeqaqjkzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHUtAg8T; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHUtAg8T"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24ab15b6f09so71155ad.0
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756939739; x=1757544539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ixg9/jNUB5QY3QZ5mFb+dgVE+GqihXC87MTGhT7rQU=;
        b=IHUtAg8TEKNIQDDk9bX60Jbf1C0+h8klLhjdprvyDPNQtrBBDsO9PogmLFv40Y3Ydv
         7B8Ux/P8Ogm3i9x6jWGFfwyKnOLSXf1Cm5DN3I6Jb2qu40exl9dZTbG5qRtou+70FbFA
         zna4f44UkZXKkHmLnfHCodwdzvi4zIOPQgojRFa4EO91BKeHh75y8CHITyUmdI6MNC+W
         FPXsGizYK8L0TFNW/1rdTewG48PXwyE8pra6JBpuApWtNpsz7CDpOhyg82tPc4krYFpF
         hpSBQrl4Kut+vo9QnA0uwHEXldDHPXXb0G6cHaoJc7VDFOf1EmFvCIoC2e4QJYmFCZrR
         plFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756939739; x=1757544539;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ixg9/jNUB5QY3QZ5mFb+dgVE+GqihXC87MTGhT7rQU=;
        b=RFkW5fRuDZR8hTDthHXiAOvCB+IZbEDSkIoddHiI5mNhAHa05EoYq7s9MpL+HBN2D8
         FIjxNandjMHIid+jh1fIgRqRSWPW+wVzrnn8+HY8WuRWHTjCE0eQZVnZ8OExtNjYhyc5
         M5efhd+vIQMV1F4b463wMHd+jm+ug1Jg4vubCLvHwVm1VaQIF0Si3tsO5q/y+xpqzqUE
         8xL1L3dcaGTf35lE+SdZOUeAYV3D1yZRL51+hUWTjaSl7fiPj+Se8PJQyCqLIi+FG1sn
         zY14tG7mN6dINWMeIWgzA2+dSBZDQBOpFOfs5MoMYc3/NK+zNtEtcNLghHw3outQjoi/
         GuCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW60+SB2FkanBD9A9gA/MfuAiIu4NvJCpt/AFFoK+h4BmO8R8AuJj1OEqKwz2I8SxQj+YM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2GcqedFdMnji3jHCmVK0NhAg8U0ug1iU7srC3YZWNlj/2KuBx
	u2+i4w8ashrHWQE0urdvtkA4K21Heiy8cIEc0r0tUtIQypV7+cSbILbQSzDSBGaMRA==
X-Gm-Gg: ASbGncuozqXV2U5xbrkUC259Zk4/1DOfHQFR7+EMKEP0jVeVw6OnyV88qNHXZfl0/vD
	XNRkqeegsandf1/r9AlK9EZbRNSAcVCYEZLhr/8zGGWSlf9DfgIlt3R05DiSl1OQUnwZuqNS76O
	oB9VdznDjQ7b3WWI+h0Pk/ybFi8mYqYvudiSpZWMpeEX45yrsO3mfia90+RsOV4ucuGxqViH4uO
	2crePl3OKep2glqFSj8vcFDht8Qx9vzsxjmKNtowSLMNdXow1znE7bwjxTHL8Hc1MTxpXwAOnOk
	vGmBbQbkIHVu2lMHquQDlU8m77hza9xXiPXnZXJe9c12ZzgGYsXj0amC0HqNgNLabNV41/KaYXk
	d8PZqqIY0jGIUtrkiksScmcmwZz+UIJSSNSV7BArB4S6vTYac7AKD9ZakACHqAA==
X-Google-Smtp-Source: AGHT+IEYDWrhAIYKB+BKczY8DoIZMVVnT4svwD3SqPMAdcJcAs8UonDy65zs/fD0rarzeFQA3nwjJg==
X-Received: by 2002:a17:903:22c8:b0:240:4464:d486 with SMTP id d9443c01a7336-24ccb19d02emr208695ad.13.1756939739366;
        Wed, 03 Sep 2025 15:48:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:2f0b:6:9cbe:cc78:867d:1486])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24a956d9b7esm126960135ad.11.2025.09.03.15.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 15:48:57 -0700 (PDT)
Date: Wed, 3 Sep 2025 15:48:51 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	rsbecker@nexbridge.com, 'Elijah Newren' <newren@gmail.com>, 
	'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>, 'Josh Soref' <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	'Christian Brabandt' <cb@256bit.org>, 'Phillip Wood' <phillip.wood123@gmail.com>, 
	'Eli Schwartz' <eschwartz@gentoo.org>, "'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>, 
	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>, 'Matthias =?utf-8?B?QcOfaGF1ZXIn?= <mha1993@live.de>, 
	'Sam James' <sam@gentoo.org>, 'Collin Funk' <collin.funk1@gmail.com>, 
	'Mike Hommey' <mh@glandium.org>, 'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>, 
	"'D. Ben Knoble'" <ben.knoble@gmail.com>, 'Ramsay Jones' <ramsay@ramsayjones.plus.com>, 
	'Ezekiel Newren' <ezekielnewren@gmail.com>, 'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <shv56ip5fs5ij653xyp2blun7e4in3gccjxl7k6qani5lwgich@ih5o7qu2fk4v>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com, 
	'Elijah Newren' <newren@gmail.com>, 'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>, 
	'Josh Soref' <gitgitgadget@gmail.com>, git@vger.kernel.org, 'Christian Brabandt' <cb@256bit.org>, 
	'Phillip Wood' <phillip.wood123@gmail.com>, 'Eli Schwartz' <eschwartz@gentoo.org>, 
	"'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>, 'Johannes Schindelin' <Johannes.Schindelin@gmx.de>, 
	'Matthias =?utf-8?B?QcOfaGF1ZXIn?= <mha1993@live.de>, 'Sam James' <sam@gentoo.org>, 
	'Collin Funk' <collin.funk1@gmail.com>, 'Mike Hommey' <mh@glandium.org>, 
	'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>, "'D. Ben Knoble'" <ben.knoble@gmail.com>, 
	'Ramsay Jones' <ramsay@ramsayjones.plus.com>, 'Ezekiel Newren' <ezekielnewren@gmail.com>, 
	'Calvin Wan' <calvinwan@google.com>
References: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aK5mJI1NfVQDmDXN@nand.local>
 <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g>
 <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g>
 <aLbSA5KsBdD4wW_B@pks.im>
 <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im>
 <xmqqms7bchln.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms7bchln.fsf@gitster.g>

On 2025.09.03 15:10, Junio C Hamano wrote:
> One more thing that I noticed.  What are our plans for the two
> directories in contrib/libgit-{sys,rs}/?  IIRC, the new stuff from
> Ezekiel did not interact with them at all, but it did not remove
> them either, so I am a bit lost.
> 
> Thanks.

I haven't followed this series closely, but I wouldn't expect it to
interact with contrib/libgit-*, since those libraries are intended use
by external projects.

That said, we at Google don't currently have plans on expanding
libgit-*, since JJ has been able to meet its needs by shelling out to
the Git CLI for cases where gitoxide is not sufficient. It's possible
(probable??) that we might return to libgit-rs in the future, but
nothing is on the radar right now.

When libgit-* was still under review, brian said[0] they were interested
in building on it, but I don't know if that is still accurate. brian,
any update on that?

[0] https://lore.kernel.org/git/Z47kr0_fYYdaMWyA@tapette.crustytoothpaste.net/

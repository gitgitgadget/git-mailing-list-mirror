Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C127E07A
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763161401; cv=none; b=ead7wxMgWtaBKkump5v+E3ILG6l3U9lF4eTHs41qFW1ya8qDoi6Y75+XcqloiqjVn9URTlGC6M2exMwJdA3skTCShhJ9CUC/0NbopvC0f4XBmnoge5oiL0UhJmNVIH2HIAO28x0ZiHTZOg5VQ+2Sq+4vB6wkGbLW8o51DEf8FtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763161401; c=relaxed/simple;
	bh=tx3aaqsw3dWAb1jomo4Ii73Mx8V+uBBSLIiV//EjUAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O67RRcOrqudGZ7AQQ6rR3Nf//fwVTisk5XpzPz1AsikWpVdRjo8UL6b85VvHBukVFuT1dtHr/9ftuDkKdcpEPhSrHBBJL3qdb/QJvyV0zx95LJpF3M0L08iV6mMBBgdS3Nx/ILKi6psFfqvEZaByvImj6Bj46EygCQVy4lzA0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxqnshQ/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kxqnshQ/"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29852dafa7dso34585ad.1
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 15:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763161399; x=1763766199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+O5/XfNmSushSExZ1+e+t02yPiRvkYxfOP5VH7OehE=;
        b=kxqnshQ/t3RSGiRneVvuk7SqwcmdAng1QKBKWF8oD1L5Cs8eChSvdWulc+3pre8Dmg
         No6XAYmvq+cSM59ke15iSzmHK0OnMeyNmuA9R02oyG0vgQfj+82VKTifNwP0dgWejvLN
         upzI3xDBgMbnBLZsqmAm9bS+7RgKyMsDytRHKcpc/+qeYmIwnSDvhMMlWNxnEKFFSm8f
         GIoa6/0tt/LFT20jJs5IO6iC7A5eImCPuPm1omV/4XVIyZMBjg9+LbxKtKG68xYuGZMT
         YsoeSed623G59CryUMyz3gXcBUTYb71+8Aa0zW45kY7O3PLpzwRJCO4VCElK4hwOeSBc
         Drag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763161399; x=1763766199;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+O5/XfNmSushSExZ1+e+t02yPiRvkYxfOP5VH7OehE=;
        b=Bj+uKJs00XbujCQFsJwzZk7+tRpfAVw10jI1+5dHD4vIhuSFkX/6d4fmEl3Km7MO1S
         5ZnUD5Qw4l5LmusJtPK7AaqXxlo/gVe0o4RH3zm5WL+j0foeJC8oCWRBPB4ahBqb2k5O
         oQZUCO5RPX6adOZ1O2O4sdGTqxREOFoaWZs56xGqSLeQniiDMHGT8ov3z6t8bSkGAVIq
         wb8u3EArKe6mwhV2GoofspAWtQkyt3ifcpsuZwPKtRcFmYPuSp5TV5ElUh2yraS4/pCD
         X0AD9zcowdZodXc/tO+nAWqFfWS6fAHPQd8sUj62PNsoEzdZa02HAihT/3uXgek/Eqpy
         yhow==
X-Gm-Message-State: AOJu0YyD+Z8A1I4NPdW8TIuflLu01VRlSICA8QYIiVkX9qQYjl7QS48/
	qRxZ6ew4yMR67QYnSG3DXy1xAiv1mhvYpon+W/cyTTCUHmC3IIYn+Y046ONjwn9IQxYejkpD3/a
	sV7rmc9/5
X-Gm-Gg: ASbGncsM3KYHVWD2rSzmV4l55gKdh0QmkRTUBxYeBkJ6z4P4zbQrwZC3Tu13wecoo5N
	AVdM/NH9yuuRNCGI9LuAJX2BCrc603jwKnOHr4ga3azQSWWnFVuhe7YYELwWFp0XIRFeCuuBcBb
	cs/18Xc2hkiZvOC34bj+2g3FQIuo/nvzOlkiPrBD6F1t0zjYnv1lIrW5ZpAiWUCZsBn6b6ehoYi
	zcnJx2RIPhfFK8frI6Rha5K6hY9dM5WUE7E3w6jvE1+9/JDHCaN91Hr+AjRzx7L81plGaSPIUlf
	UkEPgiASlvFNGF4zw+qY8SEfa/RRfos25Dh4iHcraKkU3q8d0JbhZvhxWlC/pLeVQBkCsT3OCaB
	aYqzJJz8LtjxnhzIn4N02YQphdHrvKEoFsuQpdlpcOgtw7xHSOCRCkGu04CikvodbINwLHZHZwI
	4hSk5BvAbslM9QFFAEZ1ek0HjgMLV/QP6DKBqmk8EdfuQn/MTYzvlkQg==
X-Google-Smtp-Source: AGHT+IGUKmUQhCSgd+EJnRvmiUhQnxnh0914/Ncaaw1ntosacA7w+z/jPzuZg7k29JvCulxdCFNEsA==
X-Received: by 2002:a05:7022:f8c:b0:119:e55a:808c with SMTP id a92af1059eb24-11b80fe263bmr30898c88.9.1763161399082;
        Fri, 14 Nov 2025 15:03:19 -0800 (PST)
Received: from google.com ([2a00:79e0:2f0b:6:c6f:dba5:a69f:d99a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm13627046eec.6.2025.11.14.15.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 15:03:18 -0800 (PST)
Date: Fri, 14 Nov 2025 15:03:12 -0800
From: Josh Steadmon <steadmon@google.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 0/4] Encode submodule gitdir names to avoid conflicts
Message-ID: <6m72swbxcm2gi2wtvgc4yxid3o64qbuckzzguzg3mzd6rmrvx5@i55v6c2nq5e4>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107150547.3272180-1-adrian.ratiu@collabora.com>

On 2025.11.07 17:05, Adrian Ratiu wrote:
> Hello everyone,
> 
> For those new to this series, we are adding an extension to encode submodule
> gitdir paths to avoid filesystem conflicts.


Disclaimer for the list: Google is funding Adrian's work on this series;
noting this now for transparency.


Hi Adrian, sorry for missing the last couple of versions of this series.

The switch to using an extension may complicate our migration a bit.
Background for the list: Google has been using an early version of this
submodule encoding scheme for years. We have a lot of users'
repositories with this encoding scheme in place on disk, but with no
corresponding extensions.submoduleEncoding config.

I've done some limited testing; the good news is that it looks like
using this series with pre-encoded submodules still works, regardless of
the value of extensions.submoduleEncoding. It would be nice to add some
tests in V5 that we can create some submodules with the extension
enabled, and then disable it later and still work with the encoded
submodules (and then maybe enable it once again).

The first difficulty I see is that there's not a good way to
automatically migrate existing repos to the new extension; we'll have to
ask users to manually set configs on each of their repos. While we are
able to distribute default Git configs for our users,
`core.repositoryFormatValue` and `extensions.*` are obviously special
cases that can't be applied from non-repo-local configs. I don't know
what could be changed in this series to avoid the issue, so I guess I'll
instead just ask the list for ideas for automating this migration. One
idea is to carry a tiny downstream patch to force-enable
`extensions.submoduleEncoding` regardless of the local config, but maybe
someone else has a better idea.

A second issue is that we'd like to be able to set submoduleEncoding for
new repositories, without requiring passing a config on the command
line. Perhaps we could add another config option analogous to
`init.defaultObjectFormat` that we can set in our locally-distributed
config.

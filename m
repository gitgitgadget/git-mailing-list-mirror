Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E5E28F523
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072419; cv=none; b=IYMWc6gykpIBlkzIbyqc1xE+yh9m3ziiYHDkGQMiA7wJEbDQtkCWdpoDj4b78GSS5+jbZ+xXXXjlNSbbusQY8zOY4XjraTSEzaII/I4jO01rfSThyd1sBHw0tHqISBjYq4qZxrg8U3rWIrTGPEhX1wzfdlV2LPhGfLz7Rm8TPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072419; c=relaxed/simple;
	bh=PdzAEfubc3HOsoyONUshukzp69JbXQalo4aqizmd168=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAMH2qu2NVtK8/fsQanQUjt1f9Xs93fsx4lIXHdQ2DwGrog9pYxrEagmYBIUKkyi9HIlGwN/fFske852+R6pbLY4IsxkD6SgrxHdtXyBiO5xMDegjK9HYwclTXyKqAHukZzc+BUP666jMiOoKfYmt4OM+R8d10gej82R7N3MVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=F9dZK4TF; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="F9dZK4TF"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8b3ec5c82eso914738276.0
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752072416; x=1752677216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+1DObDcgjeGt1NJCnytMBVzb2346v62C+fwTExo/90=;
        b=F9dZK4TFNsdUxg0ko/bLqf6qI8uitPACoQs4D7358iudFzXR2P5wiST4Kko4aw/kln
         OFAjkn7yqSyJwhUWCyMlVSLWKK8pDIsNLfa8EPfofj8RN16f8NmStuuQZm1DYnobFk3O
         jPFGemFHLAQ15EoUDMFHPuiTXPBqHZ1ABaDAuZRV65SX/dSBd0358qWffjvr9qpBPmXh
         /L6sMDnX07l0qztJIAsH9SdewMrmB7MTQUObMEGhxplf37IVt5tRDAPwFa6/k82wxqO4
         LtsSkoDG5Mi2azBM0rZBaKGZbQMTExz17B6VVVkIf567u7Ykn4DMfH4iwJJROKpp9aEv
         NKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072416; x=1752677216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+1DObDcgjeGt1NJCnytMBVzb2346v62C+fwTExo/90=;
        b=blPEE5k/V6vsBmUvJG7O/J7TLBg3dkoQ1fzQ3ol8vzWxoJ0F0+i2OVPf6d/JuMyRLM
         XOAjHzbn9FyZ+NpHp9smruVtNlrOiIEsOQsVnxYbsdKYm3SzDoQtUJJVgCHVK9UXvvrS
         KjKzsCdH5//cAFvX0w46cN15jqA9pm8uLUf53UR8FBxIJGc6DWsqWr3NqkAf1ZFGOMLC
         PmW33JKfKBjkZnh7CmBOlR7Iee8gUhz399m2bdNjJFsl88pQBnrAb+rs2r0bSvlIQl8Y
         gty98RnC+E873sjEdicvxKlg69Z64sdLuwQeJxcIBIwpw6jXwiWfb04fq9lejd9EBKMn
         hOhw==
X-Forwarded-Encrypted: i=1; AJvYcCUqHvCMDdT9fJQHjgU58htel7iW1jh3ZL8ML9vW1QZ4DWqPfWVWeE1WeRhvGCvlFgHmnGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQMmkmuMnS/uYfSaRxUS3uQ+Qik5a2R20Cx4jGmZ4+MKwV7len
	s2+ZZsRF1VInC1LvX0hsqVbfjU5EYwFQ5wv2zwftX2O8wlI4Gd01XVppWu3Om5dp7Xs=
X-Gm-Gg: ASbGncu0bXPZqmjb8Nal3HSme3C5KHcmwyctoLvv8fytoYy/PWLkLmLkRwg2IFX6dN6
	AzwGIerxkCDierlOJjmqmbTzWkXz0fE2bdFQO3aVljCxVSdlPvSp5avpxgTgXC/7j9GsdDOdCON
	Pxsjn7XGVj9S7GLXMTJ8YzyJMupXQdbtMEhUBklHCStKhOuMaq/B7cwveonES+bAAFe7GW0G1co
	5cph8BAvQfuh3fvBcoHEWj7WCyiePHcxG+HkFlyUKb6GaALjYdEWvCRYW6eyo7a8eKDbdsk33Ba
	3KhwhpVciWT+31HB5FPINs3YWXYA0Cqj1/p33Logjhy7L4uGdVLVkVkl+yY3Hii6NN4jKn1v5gq
	yOGDu2Z4qytWxm4SB926ATIVShxyvnp5PkGJh/FIS7oCW
X-Google-Smtp-Source: AGHT+IE8VKR8WDfP0Xht26llLCYFnjQxpBLUUQZ4fBzfJxXS+6qJgUvss7nTRoQCRyUsglUdxPQTUQ==
X-Received: by 2002:a05:690c:6409:b0:713:fe84:6f96 with SMTP id 00721157ae682-717a044be8amr105309677b3.14.1752072416180;
        Wed, 09 Jul 2025 07:46:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7166598b34dsm26060647b3.13.2025.07.09.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:46:55 -0700 (PDT)
Date: Wed, 9 Jul 2025 10:46:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
Message-ID: <aG6A19ZgxwpdJuow@nand.local>
References: <xmqqplebzgm7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqplebzgm7.fsf@gitster.g>

> * tb/midx-avoid-cruft-packs (2025-06-23) 9 commits
>  - repack: exclude cruft pack(s) from the MIDX where possible
>  - pack-objects: introduce '--stdin-packs=follow'
>  - pack-objects: swap 'show_{object,commit}_pack_hint'
>  - pack-objects: fix typo in 'show_object_pack_hint()'
>  - pack-objects: perform name-hash traversal for unpacked objects
>  - pack-objects: declare 'rev_info' for '--stdin-packs' earlier
>  - pack-objects: factor out handling '--stdin-packs'
>  - pack-objects: limit scope in 'add_object_entry_from_pack()'
>  - pack-objects: use standard option incompatibility functions
>
>  "pack-objects" has been taught to avoid pointing into objects in
>  cruft packs from midx.
>
>  Will merge to 'next'?
>  source: <cover.1750717921.git.me@ttaylorr.com>

I think that this one is ready to go. Since Elijah and Peff last
reviewed it, it hasn't changed substantially (other than a few
bugfix-related changes that were discovered while rolling this out at
GitHub).

The series has been running on GitHub's production infrastructure for
the last month or two without issue, so I think this is good from a
stability perspective.

I've CC'd Elijah and Peff here, since they were the last two to review
the series, but I don't think that they have any objections to this
moving along.

Thanks,
Taylor

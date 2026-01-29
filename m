Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56321E4BE
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769717531; cv=none; b=B5S+T8nglEZeP/nZ/lNAJYQbjyd+OLdReX4rcbjmS9G0/41zGSZ0zhpFDQaWBnvuAYXC2X53gg9OzcHhvPfJaoS8MmugrYWJetzXATlr5wf6Nt1/dMq06Ex7Bd5x20rdA00WU4kpUU0/b22HW4hV5mXEXqebQq7e6NX97sKt3HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769717531; c=relaxed/simple;
	bh=au2MH7P/dZm59XNgBHZI2P11IyfLh/i71q8dbAPVsuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJCIo5cvDifMHCIndJFlKBH6LzqH5GL6hrd9c20PXF0uUnAmsPiUHpPzkdljyPaeeuaXeXaKUJqQoLzhuQJsP3SJub+s7glzxvabBzm/7mdJ1JoO6zgu9MT8tBHA68k99jgksLfzuD0L4/DrwEGdS6o8PZEIjn9Ngrhmlt1UZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJC2O93o; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJC2O93o"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-662fda1bbcdso642132eaf.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 12:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769717529; x=1770322329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LF/4sb2JmoNEMs+Hev0HZgYIzYj5VozsnVcEP+hfcKM=;
        b=AJC2O93ow7Z43K/lwp9B88jQ4jEG8oAmZZrZyewBHkIBkfEgvQ3f6zji9BcoxhtmZ2
         YDSZS186lXsSJwWQ1Jbn3LpBDSc0kUy5qqYmxzVnuE6M35V5cjySS3m691rsLHnZHLPk
         iQj8axZfAwxpclzmvnPYFZigpuD1iNMUtgf9VCeMhszpqL3iem7ZGwYTUjiPkqEL67+q
         onk9XswhTG2J55CaGCiiDOOJHKtBVy34UljG8RZbeww6eZwaIojO98nfWWSDyrfW9V98
         q/eF4j1jW4iFeqxys0LZkir7sryaf0BA3IpaAs//EkF3i+ROiOFx2oqbG2oEYyLF9uyO
         uoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769717529; x=1770322329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LF/4sb2JmoNEMs+Hev0HZgYIzYj5VozsnVcEP+hfcKM=;
        b=hKuOPWbi5civrI0N0rClhEBGpnMC+i8DFnNsFje/UFxmEeTrysB18tMNCK1jHyMVdz
         2d40xSMZtU1nUCSaTwyjUMDg/fIfA5OUGaWQQ4cWRMVc9F9Rh+ps/8WMsDWeU2zH8yp8
         MDNL+lz2ZCptmeCmvv6SzP3IuR5dDtmaJplIJJQ8tVUfeWdmKF0XFwV+gwolblsTfz0y
         orQEkE/cs34ekeF3bg8oyHN3+8LQDT0YE5ZiVvGaKeFrp3p+EisxFElBGCdj1nuT1+ly
         hWJXyNaPrHj8iIYyOfPslVmsfwjIWlnjdy2xFlsgtwb0BfW+VwEd2s0N3TsApon45Bdh
         R62g==
X-Forwarded-Encrypted: i=1; AJvYcCUIF5FcaIUbiZIkRZE/iUC4dzAUpdoHGMzPF2PdZjwJjv3dAK0vCNe5HKwFLD7VTzAAIlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVN97fM1DsygctxHo2m0yJvL7BTT0wgBwSvq8mZ6hGuPhVcB1Q
	DlChy0XeETG43SZdcjpR8wLvh83ZThcDO2qwNb75JzqWbM9iHNotu9x7
X-Gm-Gg: AZuq6aI+HwFPds9LhdU07iSRLqIAX1UHtAQkO3kus7lSaEEoCah9hsdfnADa5SWJ/iq
	dvopKx62Jz2k2TIDeIrLk4HYUHSm+AGkiGAB6BNPs04WdTeG32sWZdxqvBqq/J6YdrUVEGFAZFS
	oAXwdPwyp6k3U5Zs5fDpdIX8e0CBH0QT+iiVqpHmjLATwNBBRgmJOXV5DUNW5ov22a2hd9/78mK
	57+efA5s1cJo/XFXP/7iOz1bXtaMWj291FAeqKyytRD1PAg39uXSWHy9ChAf8UiG2f6Z6sGVInU
	C5KTx9Lrfe+fJmYvgL7nSQ0gebf1Xd8Varr1kQEtrri0oBrIz2AE1mobzcO6U+nFdhgggqkxiUB
	qLeq0CgwmNVHq8psNjEut6dxsAnYoPqoduxGtweEthgpiktDDud+/zDFQvmOnQB5rz81w7LwcUZ
	rbf/y+
X-Received: by 2002:a05:6820:4dc6:b0:65f:7088:f6e1 with SMTP id 006d021491bc7-66306180d13mr2039340eaf.23.1769717528731;
        Thu, 29 Jan 2026 12:12:08 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4095749f298sm4260210fac.12.2026.01.29.12.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 12:12:08 -0800 (PST)
Date: Thu, 29 Jan 2026 14:12:05 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] odb: store ODB source in `struct odb_transaction`
Message-ID: <aXu4nttn-SWcMmLL@denethor>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260128234519.2721179-2-jltobler@gmail.com>
 <aXtDYY0Ao24Mpgyb@pks.im>
 <xmqqcy2sb4qr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy2sb4qr.fsf@gitster.g>

On 26/01/29 11:25AM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > This makes me wonder whether we should first refactor the `tmp_objdir`
> > subsystem to receive a source instead of a repository as input.
> > Otherwise we "pretend" that the transaction is on the source level, but
> > we ultimately still end up creating the temporary directory in the
> > repository's object directory unconditionally.
> >
> > It wouldn't really change anything right now as we only ever write
> > objects via the primary object source anyway, so the end result would be
> > the same. But it just feels like a good first step to me to fix this
> > conceptual inconsistency, and it shouldn't be too involved either as
> > `tmp_objdir_create()` only has three callsites.
> 
> I agree with your "not really change anything right now" comment,
> but a new odb source that will be invented in the future may not
> even be file based, and a generic-sounding tmp_objdir_create() that
> creates a temporary directory on the filesystem may not even be an
> appropriate abstraction.

Yup, the tmp-objdir system is really only useful in the context of file
based ODB sources. I figure future ODB sources will have to have a
different mechanism to temporarly store objects.

Interestingly, it looks like there are only three users of odb-tmpdir:
remerge-diffs, git-recieve-pack, and ODB transactions. All of these
use-cases seems like a reasonble fit to create an ODB transaction
instead of managing the tmpdir directly. In the case of remerge-diffs
the transaction would need to always be aborted. If this is done, then a
tmpdir could become an internal detail of the ODB transaction for the
files backend.

> If we have two or more odb sources both are filesystem based, on the
> other hand, I do not think it is particulary bad if these two odb
> sources belonging to the same repository took a temporary directory
> out of that repository.  As long as one temporary object directory
> taken by one odb source is not used to commit the transaction into
> the other odb source, it would be fine, no?

I believe that we only support having a single tmpdir per Git process
via `the_tmp_objdir` global anyway. So maybe on second thought
configuring per source doesn't make much sense especially if only the
"files" ODB source would make use of it. If we do go down the route of
merging the tmpdir with the "files" ODB transaction implementation, we
could probably just pass the concrete "files" ODB source to it instead.

-Justin

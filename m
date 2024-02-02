Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08455168B9
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896316; cv=none; b=N0CWwkakcfeeufWz777HOf6a908izwI/QKuMEZW4RqAfYz0UE2I6E3UcJLnohMaLvjIrOBWh/2yAIP+Tvvi/RpazOtlXKailq0p+pbLTEV2nTdaB3faVqFO0WNb2u7gIVBhUqjrzykbBWcy6dv2SzpN8D4SnW/UYssAo8KrIDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896316; c=relaxed/simple;
	bh=TeKfU1Jbn5K+Xc/tUu563wWcbeIeEMru9mZ5ST3LsOA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=myvEoBCEWiRE9Ju6U8sLukDS9FIwlTqx4OGCWtdGymzwlHh17xfZio/5Uih8A9sX7l6iDZ9gjwg2zgPNwNACzEnJQ4RPkPeJwlBjxrTHZdKbNrZzDbe6zxgK25w1orJit0YFvCjdMPIr3kMyXnW0oXGL+cvStq/5UIxUYacqGLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZD8CLXHV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD8CLXHV"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6de2735151cso1721424b3a.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 09:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706896314; x=1707501114; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1JVgzTpYh7ykQh47NUkmK7mTuZMvGBks1khmno8LGc=;
        b=ZD8CLXHVNqA5+SxPm3cjDSLgKByD08IKqlP8dkyvRms6H9wV10YpwnanEUDOTlkE85
         2b4LVSijxVrVHDG9fObULoF1cuCZA8lVpKNI18W1zwCH4Caw/nPJcU966/iEi7dJJWdK
         0Sp6TXV2DVtYttnjxHBBQzUmHDyDWAirj5/BZYClc+M39nC1UqbAh7rnfMzjiBmViMeS
         FHMDbjU1j16EFCu8ELtGhBhjl0YCXuWRtATI5Y57YriLtfdMTekiipVhf8sDEmN2/ila
         VWuvG1CeGa3HMKYoOom4caMN/nyuko7Yr9UniT8svhI0dxnbjQ98GnkxK3IOawD6kjLa
         PNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706896314; x=1707501114;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R1JVgzTpYh7ykQh47NUkmK7mTuZMvGBks1khmno8LGc=;
        b=u26s1XtoEuJo4R0rNpXACxUd23wRBedYjaqusrzZH4Vk9L2rYMz+r4wn3mc9Tyf6xh
         xNabZdCQcE1HUGlwiCd++S03BTHVorWbPHtH4vTjMBHOvb0xxPnkWTxGKK4JcCTgdua3
         BkYr1Q/a6CepgIa9ePTCtDomZrS5+qweSEoM1Ur7VBJpdQNq9B5i3hLdDBrL2c2Zi/HJ
         WMoYi6UTMJ987dZ6o6pJFH1+CO+8M187Em9sd681CnvFBLfe07x7eFH2RBseJb2Dhwgc
         bA+vP2tacGIiq4tDKW9TiT4KJAaf3yf/Ajn/F9tYl5pojlJNYq77vlvDZpWEwvf6CpsU
         wjfg==
X-Gm-Message-State: AOJu0YwGjPVqFf0aYG9AHugxLW01TrOPICw6lIRnPz0Dw3SFDt3XnaDn
	OoCwWNl2tWomaKhj7YqtkebFdz3GWh/67CNTt9LC8HIRzACKS5OW
X-Google-Smtp-Source: AGHT+IHexZu2aq/ksMa9XXZpj2eVkJRcPHi1tx3Ptv5TF06z5aecEbZf5giOfA7TcnRx0SUIXXyFsw==
X-Received: by 2002:a05:6a00:10c9:b0:6db:e6b9:4ccf with SMTP id d9-20020a056a0010c900b006dbe6b94ccfmr7447518pfu.5.1706896314158;
        Fri, 02 Feb 2024 09:51:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVBvU7uKRMKlrUJnf6A/98WP6RDHfoSilj1MDkDodBuuKnCd75tVYqwLH6Mg3zzeTXd0L6cOt/OP9o=
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id w27-20020aa79a1b000000b006ddc30172c7sm1899740pfj.30.2024.02.02.09.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 09:51:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 23:21:50 +0530
Message-Id: <CYUS8RWV9JY6.15PV2RSRKOXMP@gmail.com>
Cc: <git@vger.kernel.org>, <ps@pks.im>
Subject: Re: [PATCH v2 2/2] add-patch: classify '@' as a synonym for 'HEAD'
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.15.2
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
 <20240202150434.11256-1-shyamthakkar001@gmail.com>
 <20240202150434.11256-3-shyamthakkar001@gmail.com>
 <xmqqh6iqu73y.fsf@gitster.g>
In-Reply-To: <xmqqh6iqu73y.fsf@gitster.g>

On Fri Feb 2, 2024 at 10:38 PM IST, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>
> > Currently, (checkout, reset, restore) commands correctly take '@' as a
> > synonym for 'HEAD'. However, in patch mode (-p/--patch), for both '@' a=
nd
> > 'HEAD', different prompts/messages are given by the commands mentioned
> > above. This is due to the literal and only string comparison with the w=
ord
> > 'HEAD' in run_add_p(). Synonymity between '@' and 'HEAD' is obviously
> > desired, especially since '@' already resolves to 'HEAD'.
> >
> > Therefore, make a new function user_meant_head() which takes the
> > revision string and compares it to 'HEAD' as well as '@'. However, in
> > builtin/checkout.c, there is some logic to convert all revs besides
> > 'HEAD' to hex revs due to 'diff-index', which is used in patch mode
> > machinery, not being able to handle '<a>...<b>' revs. Therefore, in
> > addition to 'HEAD', do not convert '@' as well, so it can be later
> > used in assigning patch_mode_(...)_head.
>
> In this context <a>...<b> names a single rev (not two revs) that is
> the merge base of <a> and <b>.  Perhaps
I meant revs which are spelled out in the form of <a>...<b> and not the
<a> and <b> themselves. But I can see how it can be confusing. I will
change it.

>     ... there is a logic to convert all command line input rev to
>     the raw object name for underlying machinery (e.g., diff-index)
>     that does not recognize the <a>...<b> notation, but we'd need to
>     leave "HEAD" intact.  Now we need to teach that "@" is a synonym
>     to "HEAD" to that code, too.
>
> which may be a bit shorter.
Yeah, that is much better and clearer also.

> You decided to use is_rev_head() instead of user_meant_head(), so
> you'd need to update the above description to match, I think.
Will update.

> > -		if (rev && new_branch_info->commit && strcmp(rev, "HEAD"))
> > +		if (rev && new_branch_info->commit && strcmp(rev, "HEAD") &&
> > +		    strcmp(rev, "@"))
>
> Shouldn't this be
>
> 		if (rev && new_branch_info->commit && !is_rev_head(rev))
>
> instead of "HEAD" and "@" spelled out?
is_rev_head() is in add-patch.c and the above is in
builtin/checkout.c and is_rev_head() is not exported. I can also define
it in builtin/checkout.c, but this would be the only instance in that
file which will use it. So, I think it is better to just add
strcmp(rev, "@") to the if condition.

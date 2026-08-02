Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E756171B1
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785674034; cv=none; b=lys6c/+8VP10IBR1u4ISUdbIl/711OmEfwE095OH5X9mSXthgVtQ+TDD39mUB9BjqQMDnnXB9HF8poDnSRTv1Vf9qQqpBAH4Nk856iVPyhs8/G5QBbLrBSFW8YURXOjwv0cA5WOvdmdDz0UbdGFjwTH2S9LcqQpSym7uX+L8qCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785674034; c=relaxed/simple;
	bh=GvEsNIEA7HgDt9ks9a8pbWTK2UUNbP8BdnUSb0HZyTg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QlqTNzJfIs74ewO1HZsSUJsIQK30Avr/1ygnyrvMCKuzEs7CcYM9eGnaBGT+rfphPWK0nO2yvo9Vm70h1S7Kiokm17wglT8wqm71acU/zpsqbzD5sP0uhvn2jDc4mU+4gAhOHRzIhcbofeHdC8VeyHdwF3MEdGm3Vx4C2w8DVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKvTI0JV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKvTI0JV"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f84023916so2543368f8f.3
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 05:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785674031; x=1786278831; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3CCRst9saojP0YyUHn/KIj/YBmDvg3jtcC8WZm4apWU=;
        b=XKvTI0JVhcYUINb8Zf1KkWzagOarCmEXXiCVgjVJxGvT2ehVyoejYzUNEMQiPgE9aS
         1fqyfiKDPNNby2UCE+88hiSy8WtXCaQE04Rn3tLz7wU1a+iLZovCUVG3mWtynLfmlB9g
         q44mTj1fgy+QrsvFmakV1x1y6H5LszQ2yw2YALoZWkGPpws3kkOLBfZkASPClaR4VjJC
         Tn0I824HNzjD49XOFnYZF7VJ54Ys1KTB4H5tnPAXJpnd5BjhGKVtkUCZpH6pm8xYq82n
         j/LkO4K0va1aos/DdeAeuROZ9JygWaIPkw7pf3e77/9ucb4qUc884VpdcFgBsGqlom1C
         O2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785674031; x=1786278831;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3CCRst9saojP0YyUHn/KIj/YBmDvg3jtcC8WZm4apWU=;
        b=LaQMnhVayqn9Tv2cBizNblKv99k/iYdR11TKAFXjXGfNJlgugYJgza0n6iYMQitqCD
         gDJ6JuIkrNK04gUXsua7LIeLkG/galdvIW7mDaRqlw1VLO8iEJAPip9oKNKNXflA1a7J
         K3TUkcUAWuXWTOiA3qX21pOSObNU0LgzkxQCcq3kq/F+HDt5Cw7/ngNurmPVqBq0inhG
         Jpnj1gh+42jPPRTIbBcGdS2YEqMegAmQAdpEKggHTPX/t1anXPB4laVlCj6DUgihMtmx
         LI4Q2trWNeJmYtExR0xKutIRgLAS6MetCGp4QwpR5dSHCCvqS82Qsd6I5/YKj6yAKSiN
         3dnw==
X-Forwarded-Encrypted: i=1; AHgh+Rq3ZsdwdzZCqlyLlMjgJL6YOClgRpBBXZ1PkF7upZfZK/mEKDoFljXiOuHM+2s4ghzt1/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Kt6s2r+3GQNAuSci/iC4FXznJca6tf1uWpBtrK5N2JL01OBx
	lxobJ6y/ppFJVjrbCY7pd+QfcZ0UbvZpblxpdQU3LEgF1ZfRGQwWfnDd
X-Gm-Gg: AR+sD132oqJZYUQbRD7IGPsTTG+AEH4riQzYgV5I2kbm5D+NdGWw6tb/dOv6u/GjESK
	qqXqhaUDkaoNqbvb1/bG+MLbctYRgXm+XYjnPGTAP3jcqmFfnbCpPH+oPga36HOghmRQJRH9w3u
	NqjSRGKf8SHwOlWNy+osVaycE+fhVpahJIoksom3/kLJHf2LkuNluuddhkKFVkUzp0zl0nc+rY6
	iuM1wTkq4bKvO9+BLmhVmebqezyHlHCstSnIdkO6Mt+yjwa9s4KhngyogQeluMqzhuUYW83DJ70
	/UaMHrmP8SKzQ3wF9g258sOnZmogLtzjMixso/2sFQZdtEW4/130uPfvyY9+akAWwabx/K8qkgy
	wcQzlxGW5IOfrJopne5jQ9ncpTCA+oQTctTvuertn6o7Vc5xTnCd+opoRoMYvaAQDtEaARzN0Vw
	EpddHw+IN0HWXyrlXWugRwmhKHva3Pul2zB86dlOznyA4n6cU+gCmrAlYIfRhsUi4s54d9O9RbX
	lr4fOJJJfpH99i4DAdw+3es/TJ9XvbTY+EMlh4gvCHycBStlO7vKpgl1+GjlnW1Zl7eJOV00efx
	gN+TFKK+VCbwOEyarrQQ8glfvP7T+lFTNxvUAm3RRKiogkpW+pODur11uqR/Wm+hgNKFVALKQqo
	=
X-Received: by 2002:a05:6000:110d:b0:47f:9ac6:c9bc with SMTP id ffacd0b85a97d-47fd72bbfefmr13325679f8f.2.1785674031024;
        Sun, 02 Aug 2026 05:33:51 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d0064sm22913397f8f.5.2026.08.02.05.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 05:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 14:33:49 +0200
Message-Id: <DKEGM4BYZ4UW.UVJ1H8IGVF0Q@gmail.com>
Cc: "Pablo Sabater" <pabloosabaterr@gmail.com>, <git@vger.kernel.org>,
 <chandrapratap3519@gmail.com>, <karthik.188@gmail.com>
Subject: Re: [PATCH GSoC v2 4/6] fetch-object-info: parse type from server
 response
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
X-Mailer: aerc 0.21.0
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
 <20260731-objecttype-support-v2-4-af577461ed57@gmail.com>
 <xmqq7bmaa0sw.fsf@gitster.g> <xmqqzez67yg1.fsf@gitster.g>
 <DKDYGQRTSF2W.25OU81K306HJN@gmail.com>
 <20260801231437.GA2097059@coredump.intra.peff.net>
 <20260801232941.GA2097163@coredump.intra.peff.net>
 <xmqqpl015lfl.fsf@gitster.g>
In-Reply-To: <xmqqpl015lfl.fsf@gitster.g>

On Sun Aug 2, 2026 at 4:02 AM CEST, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> And I guess that's what started this conversation. The fundamental
>> difference is asking about one object (and using pointers to tell where
>> to put the answer) versus asking about N.
>
> Thanks for framing the trouble I had so cleanly.  Yes.
>
> The origin of the pointer pattern you mentioned, 9a49059022
> (sha1_object_info_extended(): expose a bit more info, 2011-05-12),
> designed the object_info structure to be passed as a set of extended
> parameters to sha1_object_info_extended().
>
> Instead of passing 'size_t *size_p' (which can be NULL) as a
> parameter to signal that (1) if NULL we are not interested in the
> value, and (2) if not NULL, that is where you are expected to write
> the answer, and having to keep adding such a pointer parameter
> every time we need to optionally ask the function for a different
> aspect of the object, it defined the function to take an object_info
> structure to allow us to add new members to the struct as the set
> of queries grows without having to change the function signature.
>
> As a set of extended parameters, of course, it was natural for the
> caller's variables that receive the answers to be pointed to by
> members in the struct.  So the pointers in the struct are
> justifiable, but strictly as parameters to the function.
>
> The troubling thing I saw in the patch (and I suspect it was not a
> problem introduced in this series, but by earlier changes that added
> other kinds of fields) is exactly as you identified.
>
> The pointers in this struct were meant to point at real variables or
> structure members that receive values from the function, and were
> never meant to be the final structure that receives and retains
> returned values.  If we need 5 calls to the function, we either:
>
>  (1) Have a single object_info, and a set of local variables that
>      are pointed at by the members of the object_info structure, and
>      have a loop that runs 5 times where each iteration calls the
>      function to store the returned values in local variables and
>      consumes them, i.e.
>
>         struct oid oid[5];
>         struct object_info oi;
>         for (int i =3D 0; i < 5; i++) {
>                 size_t size;
>                 enum object_type type;
>                 oi.size_p =3D &size;
>                 oi.type_p =3D &type;
>                 object_info_extended(oid[i], &oi);
>                 ... use 'size' and 'type' here ...
>         }
>
>      if you can consume and forget about the object in each
>      iteration, or
>
>  (2) Have a single object_info, and 5 sets of local variables.  A
>      loop runs 5 times; in the nth iteration of the loop,
>      object_info points at the nth set of local variables and the
>      function is called.  After the loop runs, we have 5 sets of
>      local variables populated and we use them, i.e.
>
>         struct oid oid[5];
>         struct { size_t size; enum object_type type; } trait[5];
>         struct object_info oi;
>         for (int i =3D 0; i < 5; i++) {
>                 oi.size_p =3D &trait[i].size;
>                 oi.type_p =3D &trait[i].type;
>                 object_info_extended(oid[i], &oi);
>         }
>         ... now you have 'size' and 'type' for all these 5 objects ...
>
>      if you have to return all 5 results to your caller.
>
> In either case, you do not need more than one object_info
> structure.  Having an array of object_info structures was what
> looked so weird to me.
>
>
> Thanks.

Thanks, I think I got it.

I have the doubt of whether this change is desired for this series as
prep or if I should keep on and later make a cleanup series as this
doesn't make a change for a user.

What I understood is that fetch_object_info shouldn't use object_info to
store the results, because it doesn't call read_object_info() like other
commands like 'info' do. Then, it should use its own data structure to
hold the results with flags like wants_size and wants_type. Something
like:

	struct object_info_results {
		enum object_type *types;
		size_t *sizes;
		unsigned *unrecognized;
		size_t nr;
		unsigned wants_size:1;
		unsigned wants_type:1;
	};

All three of the pointers are nr long.
This could be done in two patches, as I was going to do a prep to
prepare the current code (size only) and this patch would add type for
fetch_object_info().

At the start I read this:

> It could be something we may want to
> clean-up much later after all the dust settles from this year's
> GSoC.  I dunno.

So I'm a bit lost about what to do, I'm happy to make that in this
series or as a cleanup series later after GSoC which ends in a couple
weeks.

Whatever is preferred.

Thanks,
Pablo

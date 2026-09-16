Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF4521202
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569047; cv=none; b=aJz0V4Y5bkD8Ka7AR9jM0WJ4tisboUOSG8hfyMmYLBhsMLtxcvaBjWMpRObhU926CIMwjTIeVkpQ7olHS2Ws/MpYrmliiLD/aFYGhkg0Pswd7kSuvzymx1kxg17gWuVgHemEL1PkLxy6psHdgBc46ELAwgW9qq8IF6Tgc4RCHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569047; c=relaxed/simple;
	bh=19f6lH1dNgOWe2dgzeIiA90WF+wKyx6jQfuD7FQjr3s=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=P8yIVlz08/MPAL7CgjzZtkYHazRzPxCkJYUd/ogrONG6Od9TTDl8KHcj2AqyPZYVJfwnU0UwjgKBxeQQI4AzUUAng4noAJM1p2A4/GRaU6j/nFBiTYUAe1O1sWTrRrgZfKqrX2uHzIqz4/vLLcEKiiCwBlXImupSSn60Ja/KI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJWVAfQK; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJWVAfQK"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d4ddd179eso9046877b3.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2026 07:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789569043; x=1790173843; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zOByfHuQTN3sulZ8oKGma6Up3di30Td/9HvwdxO+x8s=;
        b=pJWVAfQKGhq/3MGfNaqIiKDCzyVlXEhyFqkGMZe9vdRXs3Pva0i98b7+yZh+mi4Y0E
         TbJC71pM4W9oDLG6qP8GYldI9J37r/SjzofdOgVsy0c8o3PT5zPEdYrcAWDkpTZ41rNI
         rmVmw8MyeT3R4JGyZN3E6R1Tqq7P3kCCeH4yXC/Q2JoWiBpMLhoPass22iW/Wx5+FNdE
         kRDqaZCehG7eg9CHr6J4eM2urNmSLqdMnscUSyEbPjb5Jy1Elz0oeVAJSfHZPWLVueOe
         nD9HigzPdLrJ4F/xDNHaYnJRWsHLsXC/WRNlHcCoX+ipxwp+oyar4f2Pw4xNgi+YfhXG
         /L+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789569043; x=1790173843;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zOByfHuQTN3sulZ8oKGma6Up3di30Td/9HvwdxO+x8s=;
        b=oxB5e9ZefLnk+U5g+8C/dASRGZTVQj+6A+70boBqXn1mO+HbwP/WQYeNTHUGnv5D10
         Sbw7SkqBVA9Fzb4dig9cSazN+l9D+jwh/ZqRZVcwdV0sYoM8/UUQU7Oa2Zqub3dHT4ze
         p7lGAl20247QWhMCNx3SHklxRIuh8ZNxgXIbYZHjozfj9qsWAG8eAVj7tZpEX0r9RRaH
         ZanWsRe/ZvxjyioAMNeB4IaHPZXjiHaV+YKTsHkMrN2rRqXBHGMG+k8Hv5Uynvs48fwQ
         wD/M32QsmT3cD2BYCuHJa1MXGnIAkbWtWeyX6ughIL7kNZgWW4SLDYu4W2fCw6jQ4U+b
         WAJA==
X-Forwarded-Encrypted: i=1; AKwUvBxPnKkKkp4/3XS2gjfD8Uv3chmj/f/zbz4Ix3hMdH73d9FPH08N8n5JRG9BPRpYn5ws6/I=@vger.kernel.org
X-Gm-Message-State: AFuF++lmecMLYYnKl8X4S81J74i39X/8g/KJRemS6raDUI2XSlPt7dT3
	xXFHmlGxqsgIgk5nQ/NRvZ0eN+h3Pz+QompGEp+Stnjh6oXeuEgntWVEN6DLew==
X-Gm-Gg: AYBFou2G+nXSZJKcpHivYcJS8m/Jmdh4DGPaHxKmwXVk9B2FGif1VKeL2/Os2V8OZlP
	UUy67i6Em8Is4b0G9jlt9TLKbxjX9wBcKq1GOB0eoZscsSNEsK8OMqdWsiDbYka7NC4f2EuHBvo
	CY6+dQ34q1WodpylpOXM0hU2vkZBjMnYN5sE1bC8bDIFqW4djSZ4LjN+AM1s0E5HCqOXo/pnQuT
	QX+kLBuNkAJasEitM9DlMWTY0Txad+QphgpATGYqiiQFffNNSqcgC1CsdTdsbl1JAYQf9kElyLU
	gmwTrON9k9vwe28tsH0+fget0mfA0qIWL7VahjI5FIzHw+OfVuZ23sy0YgKyypFNjXVRYWFsZgG
	IdIGxWwAnRWWEsPdniwXZ0r4l9y/jhp5rbtrr4+BJ9q/2ZTzfrl52jiEIYx3FMQHZSlmp+/Ua81
	ziZ0Y4CyzDTqe8Twn1yTO4XvMx5UXZW4/64wpciGJJg3ag5mB517zhxLL/Df79c2A0RD/3pXHiB
	Pm/g2CksaKgkJ24+6FBlZOJ6Y1aRhVDjdgqQNrP7PCLlOFcG4m+GGFn+dUDvpJeXmNFF2/RAlBD
	xTG6mW9mi6ZVtzBsjjUsu6qKDxk6aKpquak1EExoEc3xvg5v
X-Received: by 2002:a05:690c:d94:b0:88f:62ba:5121 with SMTP id 00721157ae682-892292a8999mr13299157b3.26.1789569042528;
        Wed, 16 Sep 2026 07:30:42 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:6d47:c103:6361:3de9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-891efc0f6e9sm8564897b3.27.2026.09.16.07.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:30:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [BUG] stash.index=true leaves a redundant stash entry after an autostash fast-forward
Date: Wed, 16 Sep 2026 10:30:30 -0400
Message-Id: <0BCA251B-9536-46E3-A6C5-7F917366F92D@gmail.com>
References: <56991232-5d16-41d1-9c7d-ca7ebdd9fce7@gmail.com>
Cc: Eli Barzilay <eli@barzilay.org>, git <git@vger.kernel.org>
In-Reply-To: <56991232-5d16-41d1-9c7d-ca7ebdd9fce7@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: iPhone Mail (23D8133)

Hi Phillip,

> Le 16 sept. 2026 =C3=A0 09:35, Phillip Wood <phillip.wood123@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFHi Ben
>=20
>> On 15/09/2026 22:16, D. Ben Knoble wrote:
>> I'm experimenting with something that swaps that out for a call to
>> reset_working_tree(), but I don't think I've gotten it quite right for
>> this bug yet (let alone run other test cases that might be affected by
>> this change).
>=20
> It looks like stash has its own unpack_trees() wrapper, so I think the sim=
plest fix is to replace reset_head() with
>=20
>    reset_tree(&c_tree, 0, 1);
>=20
> Taking a step back, this code applies the stashed index changes into the c=
urrent index, writes the result to a tree and then resets the index to HEAD.=
 We could avoid touching the index at all if we used merge_incore_nonrecursi=
ve() to cherry pick the index changes instead. That way we'd get a proper th=
ree-way merge and avoid spawning subprocesses for "git diff-tree", "git appl=
y --cached", and "git reset". We're already using merge_ort_nonrecursive() t=
o merge the working tree changes in that function so we have nearly everythi=
ng we need already set up to merge the index changes as well. Essentially, w=
hen merging the index, we just need to call merge_incore_nonrecursive() inst=
ead of merge_ort_nonrecursive() and use info->i_tree instead of info->w_tree=
.

Wow, I wish I=E2=80=99d had this info this morning! I spent a couple hours t=
rying to understand this flow and still don=E2=80=99t have it in my head :) T=
hanks for the pointers.

With the way I batch my side project time, it=E2=80=99ll be tomorrow before I=
 get to trying to make and test patches for this, but I=E2=80=99 excited now=
.

I may try to summarize my own notes (=3D questions about the existing code) a=
nd send those out later today, though, since I=E2=80=99d love to make my und=
erstanding line up with yours!

>> BTW, it's really weird to me that the reset manual doesn't mention all
>> these "extra" cleanups reset does via remove_merge_branch_state()!
>=20
> Agreed, I think it comes from "git foo --abort" calling "git reset (--merg=
e|--hard)" though that doesn't really explain why a mixed reset also removes=
 the branch state.

Yeah, that abort bit makes sense. I wonder if we should have had a better si=
de-channel for communicating that, but I=E2=80=99m a bit too afraid to touch=
 that for now ;)

> Thanks
>=20
> Phillip

Thank *you*!=

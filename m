Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F64477E4
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424739; cv=none; b=DODDMsgaMkSFd+qOVVwgLtPdyH2itsOuUZ5mPzYBIRirArconObCambsjuXrPYPalTao+u5F1Z53ipv/3LbPemA4lDzLzkRP8cw45CpMEKt2FIkBJIsC3XGA1cdzDM2C9UonXVOmN0wrkHBxEcvPGbuN5MK60l64/36YF3Eftxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424739; c=relaxed/simple;
	bh=+lrWkg5K0NyXHcaudaOQzYsThRolNNtJgT1NNPQxKJg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OhNjWW4NWW57kKkhSRxuvduTuwYWTfHXQNHveAVWRPpb5LZHcxAdJJyoLCuB4SvQ28Qh3q9h/fT3dPWu595iHauWS0dfCuWClA9boX+X8K5/p4NZwLz0B7xDhVO6i8RT9fkdbUK69soQA/MWMbTrbKlneq48n7aV2GmfDl2zdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Seu839wp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pQEfja7H; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Seu839wp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pQEfja7H"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F6A0EC0283;
	Thu,  3 Sep 2026 04:38:55 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 03 Sep 2026 04:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788424734;
	 x=1788511134; bh=WEvjDgUCJ4K9Oa1L0VPEJLaiTSvH+V3acldA4mj46KM=; b=
	Seu839wpBdIq29PwZQ0fidezMcT5kzFwoqDEnvZdMcbLAA5uH8WEuXeDr8OIGvuY
	R5nPLaGsms86QaEB3pU3aHAsrlcrW/+dYIKLYvz4hPvU+n2UDHoSAG4TfPw1CdB5
	i5/I1W4d4+rGqdmRq3wFxbRB36XgM1o0x3uu6t6kwIX+YUud1lMSODIc+K1sU794
	Fp6EZdG5dWAtlLgCJOZa0vHiGbbvsgEw3Q6bFGSMnv2Pg6N44MPby3fL5nORJi1G
	QITJ78C9N/Xc66Z6QrianVXznf5aBDlfwuY220IdarDaTvug+0D7XXhB2B75ue0j
	791UuA4eQUXANI/uXw8ypA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788424734; x=
	1788511134; bh=WEvjDgUCJ4K9Oa1L0VPEJLaiTSvH+V3acldA4mj46KM=; b=p
	QEfja7HjpGO/jz7Hsw/I5n3Ur4LT5Us9VVmtl9VDja40Hr75F0uew2Jc/ibIF989
	SmnZ+Y+dmgkW1AsPPy0vGWJHjreeGK0m2BSxqGsn8Ac/0s5L8Qr5xBbpirAj1wyH
	YY4wQQfmUIizcHhZ2lJCaOZAgU/WWjbr2CVAmu3V15kkH6iUE8G00YntwWy4Pcyc
	xIutGVY/F/CihXY3RiJcFUzHaXmdVgubzRRQvZZcAAA8g1Tipq/YTutP4txbyEbG
	PLyvabqIEd/6c3ROlopWKlI54cvtLh8n/itqieLHf4gVxugALILux9IeeFV/wWdh
	rTHJ34oOqqQY6V7KaQJBQ==
X-ME-Sender: <xms:HDKZarX18XjgwFvfAdL7W-J3eZQVrxnY5YueLz_1zLPVUmprC4PWCro>
    <xme:HDKZauYPMTYk1IG6ZSCivXmdxTIgd_SWEMWURMwGrvf4cP82mqEPa0NL03DDGb_m_
    2DmWBXo1Uln6uRw5jbJzd1_X_o05Y_zo4xivST7TMWtzsyLJEgABxk>
X-ME-Proxy-Cause: dmFkZTFTmVr3m039oo1Qpr2GolTm5ksyekhuBOyZzoeBoMeh0EgFNN/RnfNf88LpgQEyrT
    8mhIfatOhBkijGk/kC3oeO1cwSf4238jyTeP6fHgkOJSakaSFx+LGPMzH4H9+Gm+m0UXWK
    /I9/0yv/rxhmji7sVf2Wo//g/NH8+AyFbq7/yAug77xyiTjvINhdpV7gqJXIZTIbeEdao2
    siqXcxjd9l7ATsLAuAN8FT9xTsn+vn9TzWkWaQk7O60BtK/8Aho9pmjImH+0Omw/5AAtS5
    gsyJMboFDyTvSOpLJ3NQajmbhvWZHf7pph4UR27xmHRZsQ/dAdXyHR03VsD32moCuqunJN
    JWvVIU1Hhgc8yV4t91ddn950ses6IVNnOg1SjmGb94vO95e5/2+aCqfXATELZY8HfjOigz
    mUf8xm/uj3ODtX5inBKS1XopD+19Cwtq9I/le3jQrBn2aIOMSuIBqXjeJvgcyps6fDaqy5
    40XflFJAR5FiuD00UDiq/WI09ld6pnfKi8C126ugLVFwgqVuv68xNFLyDSHUkFhPY/pr/O
    nwF6Y4yX5ZVbgOaLxvQs1b+bmaeyNQjVTq0e6Nv63fZp6HjYQnUZuBE/ijnK/vWGZLng6B
    Makc1+RRyRlF6M8928FbfE/eR8vUf2sVwmkaQ+TFILp1+yc/UQN8HZAW6KZA
X-ME-Proxy: <xmx:HTKZao8gSBq9Vi2qxtEXggY1X3sy-Cjg-8vs7oAEIpeSQoobQ4YTRQ>
    <xmx:HTKZauhk6tzEm584Jz9QQ9orQ0pAAjONnup5rZutHIO2cOjdySN6rQ>
    <xmx:HTKZaoeclonHGBX6lA_rax_YXbXE_0PJ9oPw_pvdCANN4U-gksPK0g>
    <xmx:HTKZalo9zJIAzlSUc8U2wR2akwUqdVPLruv8UKHnF73pwsaM4_y0Dg>
    <xmx:HjKZaj_-IZNEX65TiwRQtBbMZWLVXWWMviSa2mM0zbnpWdtt_jd_XVPJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id EE99B22C007D; Thu,  3 Sep 2026 04:38:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdFTpIy9UMIo
Date: Thu, 03 Sep 2026 10:38:31 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 =?UTF-8?Q?Bence_Cs=C3=B3k=C3=A1s?= <bence.csokas@arm.com>
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>
Message-Id: <958622c0-e0a5-4e27-9815-cd1fff2ed111@app.fastmail.com>
In-Reply-To: 
 <CALnO6CCph_xC394v_BetLPyoriYc9dLZY42LsXhjVNdvt2e-cQ@mail.gmail.com>
References: <4e8d8b75-ddf4-4602-a2a8-26e5214c65f0@arm.com>
 <CALnO6CCph_xC394v_BetLPyoriYc9dLZY42LsXhjVNdvt2e-cQ@mail.gmail.com>
Subject: Re: [Bug] Porcelain allows creation of '@' branch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026, at 21:59, D. Ben Knoble wrote:
> On Mon, Aug 31, 2026 at 3:12=E2=80=AFPM Bence Cs=C3=B3k=C3=A1s <bence.=
csokas@arm.com> wrote:
>>
>> Hi,
>>
>> I ran into this issue a few weeks ago. I'm using Git 2.55.0, which is
>> the latest released.
>>
>> `git help check-ref-format` says this about a branch name:
>>
>>    [...]
>>    9. They cannot be the single character @.
>>    [...]
>
> This is the rule for a reference.
>
>> And as expected, it is rejected:
>>
>>    $ git check-ref-format @ && echo BUG!
>>    $
>>
>> However, the following commands all create a branch named @ :
>>
>>    $ git checkout -b @
>>    $ git switch -c @
>>    $ git branch @
>
> But (with git refs list) we should see this creates a ref "refs/heads/=
@".
>
> I happen to think that's extremely confusing given that "@" is the
> shorthand for HEAD, but=E2=80=A6 it's not against the current document=
ed
> rules, I think. (e.g., "git switch @" will fail, since it sees "git
> switch HEAD"; using "refs/heads/@" will also fail.) git-checkout
> doesn't fail but also doesn't change to the "@" branch. Futzing with
> .git/HEAD and restoring the working tree works, but=E2=80=A6 yikes.
>
> Of course, --branch mode is allowed to be stricter; maybe we should
> reject this case?

Not a bug (2024) https://lore.kernel.org/git/xmqqy12z7eti.fsf@gitster.g/

    I suspect that it is much more productive to deprecate and remove
    "@" that is a built-in synomym for HEAD (but "refs/remotes/origin/@"
    does not act as a synonym for "refs/remotes/origin/HEAD"). [...]

>[snip]

Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E74DA1C
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779977; cv=none; b=iRB8LMyEhcfwNysYh4H+u3D3NROosHauTm6OaLe1ZHq8qE+O0Obu2xw/1qaBPWY0ONc7tHnfHb9WYpdBtkuIgK0xKajNAX1CAv9kmuuLKO81HmQlAZcP1QdvRdBeSfGSHDkaUKlN/RAV3qXuWcCwyJMrbMjq/HCwTw6WbAcKDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779977; c=relaxed/simple;
	bh=8A9T3pAr0IsQvkKF9nJtTMx2RD98RYtMxgFL2Bu8JUQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EGp4zPIA//VugQL2k2xOjomN/Q5EdH936IRDUvlBRHXvBoirlpkm2cTw2x1zlYbJ8+VE5AH9YGA/eB3m9lZTQsEQG5tHEIFphGJggB3B12OIorq4eGLjgfjXC4RFvIOdrNaSVbSMvIcApmsi2oK8SfnIXyRAd0L5sAeTOfxrKO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Vwd/Wu8C; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Vwd/Wu8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707779969; x=1708384769; i=johannes.schindelin@gmx.de;
	bh=8A9T3pAr0IsQvkKF9nJtTMx2RD98RYtMxgFL2Bu8JUQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=Vwd/Wu8CxyqvYyR/WxXcrZq5p0Eu6Z/Js3uaVVR2gI4HqYWDOmtJthl9hTip2Y4Q
	 lxBdY+fCVHLNAKTzxb5eBp42+zWkXJJKOrmQziz2DLbyb6HTimvQF7znqJ5ujWP6d
	 9ycWUU/lBxCjpA0HQ0nJGz5TWG5gQRQavqoZpk2VrPDgg0aM0gQV5LJa9JraC3M/z
	 SpYmOmatEzt2yBYGIXPdBdrAJWgu9mTjUoqDRYW78lvkcRLPVXQ/vDPbgSzjD6ECO
	 uYWRT6sBV6W3Yf/7nVGCXWmZOVZdSdHcrMAVO4KQpIlMvbcBxenwDvO4QnO7g7cpG
	 XenGTK0h4kfpykc4Qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.133]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNNo-1rUlnP1GkM-00VR2y; Tue, 13
 Feb 2024 00:19:29 +0100
Date: Tue, 13 Feb 2024 00:19:27 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] Always check the return value of
 `repo_read_object_file()`
In-Reply-To: <xmqqplx9fdyk.fsf@gitster.g>
Message-ID: <fcb8240a-0b97-8554-9eee-8ff2acdb9a8f@gmx.de>
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com> <xmqqplx9fdyk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TxneRtD+ln5arGsiHNafP9g39JJsfLN25YCuIaubdaST4sBohhL
 aftJikUh3/AFN97V0tmZCTGbzmVgoXgxrHTjo5dJ2mbMkYUclVEQRfQQqBF1/Itkil6ut5S
 xK/jTQxx5O2qrmiy3P3Fr7SP5QLhCshanNdyRTd/n+DUB26VQX8/RvPk8VRi0RLfNmjcFVR
 P0gYFgFqX0NmrUrepsG6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GhG+F0eFqII=;chPHpnjrNFTZc9W79OvREIpfd20
 vqkNtW9mwoh0OyNbKzPNy/yTL3UN53ULAFwUEbO8tKb4djPFhqVWi/FbDFATN6ZpdKpwa+DNU
 hHy8/p9YbCU9VVE5osOUDspwgQkoF0QuzFXM5CGDlkJP22e4tKN5GllZUnL9gW7BBeRLfWBjp
 tN/1OX3b/hm5pl/K3E9ZH9mtq8wM5humwKHAFRYvN2iJGbRWHy4yfvHOLFk+qWEe7RopM3abT
 FBcE3L5n2JI36YWpZiANfBpFGfNzAbTXUgU5L00vcgWM4wowLTtIhsLGmW7xL86DLg9AUY7oT
 w3GvMU3VxYwVTlEblEPmd7D9XT0+bNd5wKeadtvOV+GVdjGCirDcQ350UBerA9rgk1lU+2OGE
 6oZ8xnV3vN2hX42EKlP4ft/+iYktwpcrZC3efGzzbrhNLyP4yg3ScXI9Ez21cxxKiFnluLpJ2
 d6zoYOcYo/0Z4uVgb5mFEeN4smhZQ68Q3ISMnGT9uoai/SCqMIsGokCJkjVkmYftxn8zGZmm7
 f0ss9hloYkp0Al/z/BJCq2vwk6UDNvkQyOyJojnc0R8PGarEWHKey/GVTlpsL9kqvrtXnHkED
 DVfNEsvl2LcLaRHtyOy9QK+h3w+JHHGjs+lF+0LhTwSSkWC0QEO+NT0pbadffyvR3Uw2MwfQi
 jDqMwhR+0OqHrQ1/hNDNRnaIL3vNsY5DenP+RipG0oeLMkOnPOREZ7MEj8bGWwmGQyBm8UHKu
 DMHJmR0Fnz/z1exX8K6vkMePDPq0zPGwqx3giM3ziCafWP9AEJYAjMGCIu5t1G/cK7pmnlX9o
 HpW5PiI0LB6fPKN3Z4Jp4cT2TqfSYIxQkFnk8qbGt/gL8=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 6 Feb 2024, Junio C Hamano wrote:

> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index c8e33f97755..982bcfc4b1d 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -571,6 +571,8 @@ static int grep_cache(struct grep_opt *opt,
> >
> >  			data =3D repo_read_object_file(the_repository, &ce->oid,
> >  						     &type, &size);
> > +			if (!data)
> > +				die(_("unable to read tree %s"), oid_to_hex(&ce->oid));
> >  			init_tree_desc(&tree, data, size);
> >
> >  			hit |=3D grep_tree(opt, pathspec, &tree, &name, 0, 0);
>
> This caught my attention during today's integration cycle.  Checking
> nullness for data certainly is an improvement, but shouldn't we be
> checking type as well to make sure it is a tree and not a random
> tree-ish or even blob?

That sounds right, but I am already stretching this patch beyond what I am
funded to work on, and therefore I need to leave it at the current state.

Ciao,
Johannes

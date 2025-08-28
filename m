Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACB7268C40
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756409400; cv=none; b=s2lytEgv4PIpECByBhO4cld8ICBaOD6Du9xiWPqW5KpOqdbVHI8yYh0YLNdlcCFW0V9EXHu0FAc64uew1K/iAlZVEutYMNXr34PXDcHRYArzsPB7185trGtABsOQSbVD/B84DLOMsvc4p2/jUTuHRGn09yKOFD5AwlS7TVU3c8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756409400; c=relaxed/simple;
	bh=ATmLfbsJ61KDoEoNAfd9jATYe9+xKazlH4Hj1L7Et+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXqwEXLydXoWuTVI3PeaMQdHbweOE4sXWI67Gz2d+Hoh47FPDUWT6JpirPVZEj1XjnhhElrUoGz9sgfyoyS3fJjQh7Ay9Uj0O0skpp8iAtjAwdq/7JLpR+K2k7d9yvn4uqaGwaBlKTYxO8bydI1nYFl+vFSC5Gf2QT+rDCahmwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=OdYnsbv7; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="OdYnsbv7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756409390; x=1757014190; i=tboegi@web.de;
	bh=Oh6R6mxA6mWPkr6DCfuRwEzgTbVYe6/Yum2dVVlMepA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OdYnsbv7NST+x9CK1yFa4pwftn5BRZAFzgoK4spMqo06e4ifUb4/AMa1+wPheTu1
	 265tp1jVaMODZhRUXFEiXSuwcrq2GlYolYSeNTHcGNj4rcxUMqYKvsHpDBfcxL2U9
	 WaxD8IpPgAN+Xb/GWoJFkQXtDvOrV5yw1FDzwzk1ooVvka+76YTb2Fyb5Z6ra/9bc
	 bhh3sGxY1gaBy9U7XB6oMYZ+bzAdQTGtLas+0WudHWM4TMM/LB59yUXkSBkxyC9ID
	 QzljSng3XA4GGT/K651p/qt+X8stQijwkpPj22gP99Ou1qXUJUjA6TV14UyIP6DJ8
	 XCyQ4Es4/iAe2gix2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mxpmc-1uZV0i0Jhe-00vddM; Thu, 28
 Aug 2025 21:29:50 +0200
Date: Thu, 28 Aug 2025 21:29:49 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: =?utf-8?B?44OO44Km44Op?= | Flare via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?44OO44Km44Op?= | Flare <nouraellm@gmail.com>
Subject: Re: [PATCH v2] alloc: fix dangling pointer in alloc_state cleanup
Message-ID: <20250828192949.GA18641@tb-raspi4>
References: <pull.2040.git.git.1756238268790.gitgitgadget@gmail.com>
 <pull.2040.v2.git.git.1756337312918.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <pull.2040.v2.git.git.1756337312918.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:ZLn2IsAdLEnypbY2//KzvxYIPLDd4a6R2JfjTf9aSv6B2D+cTs2
 5/uuV5ML2tIGhZwJgJ4YkQ2fw6m0r2jmLfOhcfjHX4P8pBQpM790e8WsdX961AR+gQwXsR4
 qWNzd9hQkPfFBwIOPabplMjHPpdIhEtBRdVw+5S/aXLBU+Q6dxZSy+eJVdaV+8FEzt9Bi8g
 l9L5r6sljDHQDvZOOTzvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q7Zj+AAeYTI=;cKE+WqG+g6t/KCEXVyvhGvUSgrx
 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

On Wed, Aug 27, 2025 at 11:28:32PM +0000, =E3=83=8E=E3=82=A6=E3=83=A9 | Fl=
are via GitGitGadget wrote:
> From: =3D?UTF-8?q?=3DE3=3D83=3D8E=3DE3=3D82=3DA6=3DE3=3D83=3DA9=3D20=3D7=
C=3D20Flare?=3D
>  <nouraellm@gmail.com>
>=20
> clear_alloc_state() freed all slabs and nulled the slabs pointer but
> left slab_alloc, nr, and p unchanged. If the alloc_state is reused,
> ALLOC_GROW() can wrongly assume that the slab array is already
> allocated because slab_alloc still holds a stale nonzero capacity.
> In that case s->slabs remains NULL and the next dereference writes
> through a NULL pointer, causing undefined behavior.
This is good.

>=20
> To fix this, this patch:
Style nit, we tend to use the "imperative form" here in Git,
like this:

- Rename allocate_alloc_state() =E2=86=92 alloc_state_alloc().
- Replace ...
- Update ...
>=20
> - Renames allocate_alloc_state() =E2=86=92 alloc_state_alloc().
> - Replaces the =E2=80=9Cjust clear=E2=80=9D API with
>   alloc_state_free_and_null(struct alloc_state **s_),
>   which frees all slabs and the alloc_state itself,
>   and then nulls the caller=E2=80=99s pointer.
> - Updates call sites to use the new helpers and drops
>   redundant FREE_AND_NULL() calls.
>=20
> This makes the alloc_state lifecycle API harder to misuse,
> eliminates stale-capacity state,
> and aligns naming with project conventions.

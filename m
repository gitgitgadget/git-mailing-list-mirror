Received: from 18.mo561.mail-out.ovh.net (18.mo561.mail-out.ovh.net [87.98.172.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A238F44
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 03:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.172.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102412; cv=none; b=aaAccWj2w/E9qysBGh5pTp5Gn7k9MFqhIPZHRz6ImwbMU6OWe84VxW97b0vjBF911ya7Uus8/RC0qxAHDLKO5gtVK/HGP+G/QY5FY2F3SLPcX1NT5IWOWnjMRb0miYI4cd0257moFeJFT1LairbvCBXk1wMjx0+2VT843BidNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102412; c=relaxed/simple;
	bh=EF+OruQagLBZQO+y8osKNBvYocey2biLHGZ3P5B6+8w=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=B7nOwSQEsziEmfMCLHCZ8h8QeFHmlngEw5EwzKPnRSUNosbg2ArO5yLnvRtSbgsVI5K1UcfXKh3GMpgQW5O4YCYedyBFMDfOHy+ZnbdRzNKusLSsoFAIb1Q5ZsKAJbOBXN1Uu+ZVFXmSINLzZEtLoQd6dSOdSSppjxaQhQ07rt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devyard.org; spf=pass smtp.mailfrom=devyard.org; arc=none smtp.client-ip=87.98.172.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devyard.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devyard.org
Received: from director4.ghost.mail-out.ovh.net (unknown [10.108.2.235])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 089F92776E
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 03:06:40 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-wmfjk (unknown [10.110.113.119])
	by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id B72221FE64;
	Mon,  5 Feb 2024 03:06:39 +0000 (UTC)
Received: from devyard.org ([37.59.142.97])
	by ghost-submission-6684bf9d7b-wmfjk with ESMTPSA
	id nH/tH79QwGUVCR8AW0a7IA
	(envelope-from <ypsah@devyard.org>); Mon, 05 Feb 2024 03:06:39 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-97G002911faefe-0c20-4172-ba5c-d76426687be1,
                    2E889AE26219FFD1BF1F9309EC37D53C5121073E) smtp.auth=ashpy@devyard.org
X-OVh-ClientIp:213.10.167.74
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Feb 2024 04:06:27 +0100
Message-Id: <CYWTAIFR6W5W.1GH1O6KKP0U5U@devyard.org>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] http: prevent redirect from dropping credentials
 during reauth
From: "Quentin Bouget" <ypsah@devyard.org>
X-Mailer: aerc 0.15.2
References: <20240204185427.39664-1-ypsah@devyard.org>
 <20240204185427.39664-3-ypsah@devyard.org> <xmqq8r3zonat.fsf@gitster.g>
In-Reply-To: <xmqq8r3zonat.fsf@gitster.g>
X-Ovh-Tracer-Id: 5818369243839706619
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduledgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpegggfgtfffkvfevuffhofhfjgesthhqredtredtjeenucfhrhhomhepfdfsuhgvnhhtihhnuceuohhughgvthdfuceohihpshgrhhesuggvvhihrghrugdrohhrgheqnecuggftrfgrthhtvghrnhepvdffgfffveejffeivdefudehvdfhveekvdetjeegheehvdetffevvddvtdejgeffnecukfhppeduvdejrddtrddtrddupddvudefrddutddrudeijedrjeegpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoeihphhsrghhseguvghvhigrrhgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedupdhmohguvgepshhmthhpohhuth

On Sun Feb 4, 2024 at 11:51 PM CET, Junio C Hamano wrote:
> Quentin Bouget <ypsah@devyard.org> writes:
>
> > During a re-authentication (second attempt at authenticating with a
> > remote, e.g. after a failed GSSAPI attempt), git allows the remote to
> > provide credential overrides in the redirect URL and unconditionnaly
> > drops the current HTTP credentials in favors of those, even when there
> > aren't any.
> >
> > This commit makes it so HTTP credentials are only overridden when the
> > redirect URL actually contains credentials itself.
>
> "This commit makes it so" -> "Make it so"

Will change.

> > +			char *username =3D NULL, *password =3D NULL;
> > +
> > +			if (http_auth.username)
> > +				username =3D xstrdup(http_auth.username);
> > +			if (http_auth.password)
> > +				password =3D xstrdup(http_auth.password);
>
> Not a huge deal, but we have xstrdup_or_null() helper function
> exactly for a use case like this.

Thanks, will change.

> >  			credential_from_url(&http_auth, options->base_url->buf);
> > +
> > +			if (http_auth.username)
> > +				free(username);
> > +			else if (username)
> > +				http_auth.username =3D username;
> > +
> > +			if (http_auth.password)
> > +				free(password);
> > +			else if (password)
> > +				http_auth.password =3D password;
>
> This is an interesting change.  I wonder what breaks if we
> completely ignored such credential materials forced by the remote
> via a redirect?

Me too. Maybe the original author would know. Is it OK to Cc them in
this case?

> >  			url =3D options->effective_url->buf;
> >  		}
> >  	}

Thanks,
Quentin

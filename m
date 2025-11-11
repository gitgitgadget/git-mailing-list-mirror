Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9F35CBA1
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762899819; cv=none; b=o+Uh+T8ou+Da8sor/OLuHsUJdpEQWKzpd+4bAHDSmx8ziloXDpy+le5KbJaVsD4QTNqI5jklxpztFhqm2SN+pRm7xF1oOKaeDDG16I2KkjKw3aQt+qs48YXSL3J44AAe2dg3s+uzwzHHQ1i1mPOZhILq7KK5RXTmy22W+rsKQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762899819; c=relaxed/simple;
	bh=l5YjwVqHQOAayIjXP6WNN6NbjOsnH7vASLReiUjMTzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nojuhiNhso6maHugVLFUB16PDUlpdvwt3myHSlRSiXQdhCnKtNugqruh8taKIHN9BtFXEQVBKCW0Uzt2antFN931YtVsjnkx7iMRKG1W1OOqfqxaug34YivU8g52B3tAd7QnnEqDdkXf8Fqtc9dAQ3JVuxtMBeIPVu/2CcWrKE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LwjpQUbB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LwjpQUbB"
Received: (qmail 490042 invoked by uid 109); 11 Nov 2025 22:23:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=l5YjwVqHQOAayIjXP6WNN6NbjOsnH7vASLReiUjMTzE=; b=LwjpQUbBuhStPY6enhCAECiohvJi124Prpnj1sn0qzCUmDX7/DUc7HbdpGN5JAnUT4q4R0zq7JMMntlKNWHPFyrxss8JVWT4jZq0y2ku9dEkypXR7j+QCiX6YdOO5+LngrAwKgwOZh3j99jZisr1GZ4dbpgsS5cmsrJYrzlvAwrPudjw2ATZ0kEYabI5BJDRc6GLBtlGR3kLFnMLHPC+3bDNyeIpLwrKNjNIjgy6bfoN1nHb9puMMbQad08TlfoNzJblRBtSxk4fh4uxAgt1nKZ5+DPOuBFvAeR4DQx4Cx+fyRr0llWHxEisxzSfqnBeB9QOwoTMA5dEqnxJwQC6pA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Nov 2025 22:23:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 780823 invoked by uid 111); 11 Nov 2025 22:23:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Nov 2025 17:23:35 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Nov 2025 17:23:35 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: ZheNing Hu <adlternative@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	phillip.wood@dunelm.org.uk,
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] commit: add --committer option
Message-ID: <20251111222335.GA4054883@coredump.intra.peff.net>
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
 <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
 <20251110201136.GB127132@coredump.intra.peff.net>
 <CAOLTT8RweGOmxNK=vKDv8w-8AJM7QUfLBw4WOKeY1EpSVeB6iQ@mail.gmail.com>
 <20251111191508.GA1907007@coredump.intra.peff.net>
 <xmqqh5v0wcif.fsf@gitster.g>
 <20251111213339.GA4053071@coredump.intra.peff.net>
 <xmqqwm3wut8i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwm3wut8i.fsf@gitster.g>

On Tue, Nov 11, 2025 at 01:58:21PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I just mean being able to do:
> >
> >   git commit --amend --author='Foo Bar <foo@example.com>' --committer-is-author
> >
> > instead of:
> >
> >   git commit --amend --author='Foo Bar <foo@example.com>' --committer='Foo Bar <foo@example.com>'
> 
> Ah, I see.  Like
> 
>     git -c user.name='Foo Bar' -c user.email=foo@example.com commit --amend
> 
> Makes me wonder if we want user.ident that covers them both ;-)

Hmm, I hadn't thought to use "-c" config for this. That makes me
question the utility of --committer a little bit. ;) I guess it is
slightly more convenient than "-c" in that it will trigger the
find_author_by_nickname() magic.

-Peff

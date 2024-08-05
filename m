Received: from out.smtp-auth.no-ip.com (smtp-auth.no-ip.com [8.23.224.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D353611E
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=8.23.224.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872105; cv=none; b=ZO8wzQRHDAjsB05sZ9QA58BNxiGz/S2wiXNgSv6/PR11F+bsa2143d7DVf5mjvNyCnxmoR65wSUMblc4DwxcxdSeupG4nUGhOq+MhDkyii1MEzywX4lupDByrkXw3FcuXGWmSl+NgyvhFQdsnLZaA7U9F3LEBEEv/iz6bwvTmjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872105; c=relaxed/simple;
	bh=IqA414Z8spCq8b8MtrO+9v08GPGHW8cC42b8eB+hP3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HD0D1BFOHeumgrXI9PlTijYfkA9SX35w9lp57nJOnlF+FBwd+4eD8EeGnwntxgkcQvKSafL6/AG4OtK/+RNq7uoWRN1AsL7BhM9DD/5EHK5ikt4fj1tQiQpoXjgoYTcHcZhjKY4hak/PPh6Oit7zRasnv+VEe/xesBjsMumGIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flyn.org; spf=pass smtp.mailfrom=flyn.org; dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b=OTo7nrxr; dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b=nj/BMq3b; arc=none smtp.client-ip=8.23.224.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flyn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b="OTo7nrxr";
	dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b="nj/BMq3b"
X-No-IP: flyn.org@noip-smtp
X-Report-Spam-To: abuse@no-ip.com
Received: from www.flyn.org (unknown [137.26.240.243])
	(Authenticated sender: flyn.org@noip-smtp)
	by smtp-auth.no-ip.com (Postfix) with ESMTPA id 4Wd0qf1WJ0z7rtF
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 15:34:54 +0000 (UTC)
Received: by www.flyn.org (Postfix, from userid 1001)
	id 321E01EE0029; Mon,  5 Aug 2024 10:34:53 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyn.org; s=mail;
	t=1722872093; bh=9DC6NnbhTZra+TQBav1uRvo9pfhwjAOjASewWENTIks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OTo7nrxr9rCXDa7Uq5/LQcEZI27osL2Bkx307GAkLR4jafFMczzoPGimT//vxxBz6
	 UWHu3IWnLfr3yxERCcpXO3pn1LFfggm0dE18YXVUoftc9aMjT+gbN0EXb08O4A08Yk
	 M2wRTFYtZT3iMaM6xLojvGNyodSPV9M58AvLI3fKwd0DSz8zjLhu6HUKRz9QE7dcwI
	 yVIgKGMbTjxvg3AAB/SFrNWccMmXNIOi4DSQXb+jHGY7bG9sV5W7AzzcA24lPTNUJy
	 IsYpjZOye/pQ7igZXdgMSjvcG9jr/Kt9SkINJzVICx0lQVGFd/areWQQlK1JFSAtUN
	 9Y9uR4eo4w4ZjnTar/ohS11hhzxUhTWT0SQ8rSfv+egtbOEgt2V+11VX3BpfI1vxIz
	 1Ra1ItANFEcGhe685bFybErZ/kKDTV7J9b5Wi9D5bL9JF620b02XJYbeYkEHxpOPXP
	 BoslPBNk0PSRmPrLeoAKjtnIRWYMoCLHr/Wqi2DTedn3pm9CetW
Received: from imp.flyn.org (guardian.flyn.org [137.26.240.242])
	by www.flyn.org (Postfix) with ESMTPSA id EA7471EE0029;
	Mon,  5 Aug 2024 10:34:52 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyn.org; s=mail;
	t=1722872092; bh=9DC6NnbhTZra+TQBav1uRvo9pfhwjAOjASewWENTIks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nj/BMq3bB+K4rMYLxk9Ik1ag/s383vRjed49PoA1LpDCxc9W4C/8tLurPHftD45+Z
	 Kr5QYDSrt7vfMxHORjWuKP7otjxBmcmEeMV6XMKFhTsEeEA/jFKKfvqyOZ418JyvbK
	 VF2hCkXt6DHd1p4ABsAzuqvk79InyCG3ZWTrUf1fkpnvkzfCe6SHb3cLmnoQy4hhtM
	 cl2ARDOkSACAhuT+vyg600dzF3lNUZya2o7a+BQtAP5UMCclaai0HO/z8cwOOUYkEt
	 SA4ADsIEKznwqq4TjYmDDnjZvtmomWLslFqs7lgtlj61alPq0SpfhoznsIx41gf04T
	 HbsQZs2M14b8dbQjpLXZIMkFz9DL0kVKHOfgaF85vIGkEvwmn8BjTdOOb3DzA77ekK
	 PAKzhdgp2TXOorHTAQi9TU+cCRGyA7naH4yyTIY7upZkYgOlFdXggGhp2m8fhJpaww
	 AcpTPB7pnu1+7uHcKmyFOQVOQ5WyJ7zoGPaXcjLJP+fxpns3XL1
Received: by imp.flyn.org (Postfix, from userid 1101)
	id CD02D2D8DDCE; Mon,  5 Aug 2024 10:34:52 -0500 (CDT)
Date: Mon, 5 Aug 2024 10:34:52 -0500
From: "W. Michael Petullo" <mike@flyn.org>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: Git clone reads safe.directory differently?
Message-ID: <ZrDxHPh-daYPxzT2@imp.flyn.org>
References: <ZqjQi6i2kiY4gcc1@imp.flyn.org>
 <Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
 <xmqqv80m8pha.fsf@gitster.g>
 <ZqlxtGIyz0G9jlJr@tapette.crustytoothpaste.net>
 <20240731072832.GB595974@coredump.intra.peff.net>
 <xmqqo76d7coa.fsf@gitster.g>
 <xmqq1q391afc.fsf@gitster.g>
 <20240801061417.GD621899@coredump.intra.peff.net>
 <Zqv9b_B5wKGp331o@tapette.crustytoothpaste.net>
 <20240805094709.GA632664@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805094709.GA632664@coredump.intra.peff.net>
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.520000, version=1.2.5

Thank you---from a somewhat sophisticated Git user, but not a Git
developer---for all of the discussion that followed my initial inquiry.
I thought I would follow up with some comments that follow from my reading
of the responses and the SECURITY sections of various man pages.

> [From Jeff:] So there's an open question on the degree to which
> running upload-pack is actually dangerous. It's not _supposed_ to be,
> but the ownership check is a defense-in-depth approach to safety.

The discussion here is partially an attempt to better understand some
of the internal workings and guarantees to determine whether or not the
protections applied in some cases are spurious, right?

> [From Brian:] Both of these commands should work correctly and do not,
> and that's a bug (assuming tr1 is owned by a different user):
>
>   git clone --no-local --no-hardlinks $PWD/tr1 tr2
>   git clone --no-local --no-hardlinks ssh://localhost$PWD/tr1 tr2

The remarks above closely resemble the use cases that prompted my
initial inquiry. It would help a great deal if these worked, and also if
"--no-local --no-hardlinks" remains the default for the SSH variant.
Is it fair to conclude that these not working represent a bug?

> [From Brian:] The git(1) manual page also says this:
>   [...] but beware that the surface area for attack against
>   `upload-pack` is large

Does the use of attack surface here mean the general idea of "the volume
of lines of code in upload-pack is large and thus upload-pack likely
contains bugs that might represent vulnerabilities", or is there
something specific about upload-pack that should raise concern?

I do have a related question on the SSH/push side. Let us imagine a host
that has user accounts bearing git-shell as their shell. Thus these users
can only interact with the host (and the repositories therein) using Git.
Further imagine a trusted agent on the host creates these repositories and
any hooks therein. Can a special account, with permission to access all
of the repositories, safely clone and push other users' repositories? Or,
could a user introduce a dangerous hook or configuration option to their
remote repository using only Git by way of git-shell?

Thank you again, especially Jeff, who provided me with some practical
workarounds early in this thread.

-- 
Mike

:wq

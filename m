Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFCB156677
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200228; cv=none; b=YXs7+slv6b+vsObOKWnX8OORdpgGe92W6ANWWR4QBm9xFgb+trFRAwgMcEJ8d2kXAw2EfhGKfWIcKlJWaHE6FCrphXc8RgjFezK0SpxnbcVb61SyuCl5CmF2OuZ+LsVEdsstfZMGVzXYHjyXjBjzcdhkQtF2QfguyNPdEgV5i3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200228; c=relaxed/simple;
	bh=mZh7SPJTjHLw7+IGTrfLMHJu4IYEw53tp4RZ6cRdCOs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=UYqkPub35iu02Evf+TF/f/Mp1P5xVEPQQO+Ao+AKIjf564E4NWVqR4bQViqKY8xwMpffyWS9DBs3/6Wg3Rw6NhZHmhzdS9w4+bYDsXr9R6xUgVCJj+jWY0uE5+6B410+Axasa6Aj6vVq1xFXNZLqBNdEAhXKymcO8Yk53+DYYp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 5E57F34027D;
	Tue, 22 Jul 2025 16:03:45 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: me@ttaylorr.com
Cc: ezekielnewren@gmail.com,git@vger.kernel.org,gitgitgadget@gmail.com,newren@gmail.com,sandals@crustytoothpaste.net,
 Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
In-Reply-To: <aHl4U98BBvpA5eKF@nand.local>
Organization: Gentoo
User-Agent: mu4e 1.12.11; emacs 31.0.50
Date: Tue, 22 Jul 2025 17:03:42 +0100
Message-ID: <87seiofc0x.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> I am far from a Rust expert, but I think that a more modern, memory-safe
> language will attract newer contributors who may have a fresher
> perspective on the project, and I think that's a good thing.

Aren't they likely to contribute to gitoxide? There, they get a clean
slate without having to deal with the least-fun part (bidings).

> It is also not the Git project's responsibility to ensure that every
> platform is Rust-friendly.

That's true, of course. And nobody is entitled to indefinie updates, but
on the other hand, there's still some implicit contract with users. I
really don't think git would have the adoption it does today if it had
adopted a Rust-like language in the same state Rust is now from the
start.

(In exactly the same way, git doesn't gratuitously break compatibility
every release either. Can it? Yes, and git can change the platforms it
runs on, but it's something to be taken seriously.)

> Hopefully the platforms that we currently support but won't after this
> patch series have niche enough workloads that they do not need the
> absolute latest-and-greatest Git release at all times.

I mention this in my other email, but it's not just about ancient
platforms. It's also about new ones, or ones where Rust supports them
poorly despite them being relevant.

> Yeah, I think that this is the most interesting part of the discussion
> here. I am not knowledgeable enough about Rust's release cadence and
> platform compatibility to have an opinion here. But I trust brian's
> judgement ;-).

It gets a new release every 6 weeks and no other releases are supported.

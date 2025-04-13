Received: from mx01.frank.fyi (mx01.frank.fyi [5.189.178.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761F7188CAE
	for <git@vger.kernel.org>; Sun, 13 Apr 2025 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.178.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744585938; cv=none; b=C5pXE5X32y5CsxjrqSE5ZajEhe8V31apiJuxLMvZ0Zc4OQRemQw2jsRQuXhLqF7ndS6XVKGv314qm6iroLgXolZmM17M2s71xsj9EauTHYUNOGvSyZVgGYjkXKdtGWygGrPPF3kkuZZ2gQvOdVn27jMB9dgm6K3pU2rSmV7UMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744585938; c=relaxed/simple;
	bh=vAbL5ifT8GBeGNP3J+k6tm8TYmKakfo7KNAO6O4AU98=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1CM0oShiLYzXhyeDUoIe/Fy5yncPth1TltiCnRn4w6Gfm9o4bdQt4gfqDmA1QVhP/1VQnYaVdUy7z6JzJFM6hR16crVFHl59PE26tIjH9nP5ijmP7fzh6/CRXF9wgXKL5NdBdyyPoKeuMZHTa1CR1H8ETTFoF7DkOhev0IoNak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi; spf=pass smtp.mailfrom=frank.fyi; dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b=Tj9VtXMq; arc=none smtp.client-ip=5.189.178.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frank.fyi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b="Tj9VtXMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=frank.fyi; s=mail;
	t=1744585934; bh=vAbL5ifT8GBeGNP3J+k6tm8TYmKakfo7KNAO6O4AU98=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Tj9VtXMq3/RZHmY3ykb5LW8Y55JIulPnr00hh7imGoNg97KDo2EKEgdO9AKovrg7t
	 6jJX5lb9FfpRdqpNDoxkkoWc6MGCWpYhYQ0akgNdyJVXZjLZGYOUv6tplzcI6b8+/q
	 D0pL+Si9u4MeIFOh8PWPZD1dsMv1iI73kzv0XsOVwE2p87QIKXmZ745oGf4dDkShdb
	 yJdzyS0WuWp+h5UZNFk5qVLl0h+JbZw7xr5i6W8UAHXvMU4LV/CLyygMjuXGw8hNb7
	 jFzxYsYXOVhMOOIx4T8cWAdSt7LGXwWGV0y30kqhDsI8krhaZZ3vKwiHuCQnMkrjCR
	 RcgncjYyCm09g==
Received: by mx01.frank.fyi (Postfix, from userid 1001)
	id 222A21120180; Mon, 14 Apr 2025 01:12:14 +0200 (CEST)
Date: Sun, 13 Apr 2025 23:12:14 +0000
From: Klaus Frank <vger.kernel.org@frank.fyi>
To: m@lfurio.us, git@vger.kernel.org
Subject: Re: How to gpg signed email patches?
Message-ID: <fba4f0a0-3ca8-455c-bfb8-70118de89fad@frank.fyi>
Reply-To: git@vger.kernel.org
User-Agent: Mozilla Thunderbird
References: <fx2ofmmhkjmjqfqya5e3qvmovvmpnjepteqobcz4eia5sw64bg@yquuljpwok3f>
 <D95V0Z9YMEX2.3J99CE4F6ZP8S@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: de-DE, en-US-large, en-US
Content-Disposition: inline
In-Reply-To: <D95V0Z9YMEX2.3J99CE4F6ZP8S@lfurio.us>

On 2025-04-14 00:21:46, Matt Hunter wrote:
> Hi
> There's a conceptual issue with mailing patches from signed commits.
> Once your patch recipient goes to apply it to their branch, they are
> recorded as the "committer" identity of the new commit object.  This
> would break the validity of any existing signature.

You're right on that part. However even though it would be nice to
get the signed commit into the public repo my main focus here was
more to ensure integrity and authenticity until it is processed by
the project maintainers. E.g. it didn't get mangled by some thing on
the way and I wasn't impersonated by someone else. E.g. I was
mainly focusing on allowing the ones accepting my patch to know it
is from me and it hasn't been tampered with on the way. E.g. by a mail
server screwing with the mail content or some middle box that inserted
or rewrote parts of the message...

> This is likely the reason by the related git tools (format-patch, am)
> ignore this information.
Ok, how do others deal with that scenario then? Not an issue?
> You may have also noticed that commands like git-rebase and
> git-cherry-pick will drop signatures from commits as well, since they
> are being replayed onto a different history, changing the commit data.

True, but thouse commands to not pass information through a
lossy and "tampery" media like email. It stays local. My main focus
was on the transfer from my git repo to the (git repo of) other
devs on the project. And lesser on it being preserved after the
merge.

When a project uses a forge like github or gitlab this is basically
not such an issue because of TLS and having to have a
user account on it (and it preserving the pgp signature up until the
last click before being merged in)


Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87F419DF62
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087577; cv=none; b=HHKS2wHxLQmAOHELTk7NzKJBz3l7o3uMovyvN4yVHrHKkARwxcycybJ2seBMZj0qK/0DxXhdUQvHuZpKV7zN0Z+dAMzVKIq9bdkK0xxeB6GmDyWWn8ZE57n9T4TH6rfnwZENAWDQccz0Dti50ImT1qXKmSIPGoQe2ccqaCXpl60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087577; c=relaxed/simple;
	bh=m21Lb8PuxNxgWP8nf+9/M/msA7DX9EuTkjqFdE2+TRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EPUqnUQ4rvQx6htCSYtSXk89E2/umEuoHAkSR7QuD31fN3w8GTLeuuGLHrPIW5GOcAAHU48g7v5EJm9dATXd3DqiIDQDeNBTbUt77tdAy04yixCap2fskhrQ2LkkQmnuliPMhJQaaIx6ZAThxDcvMMDiri6o0gMldYG7vJpYJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=lA0yvW6T; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="lA0yvW6T"
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1738087562; bh=m21Lb8PuxNxgWP8nf+9/M/msA7DX9EuTkjqFdE2+TRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lA0yvW6T9Lv3ky7ivvZg8rsHQxDUVjEuqYROHp41S9euvoTTrbKKm/h0rWyGJEJzy
	 ncRnxfv/ME266hAJ2qgW5WzMAYcg1YMfcyvCXdFK3eEXfaak0LlRktTJiEgAkZlXJO
	 6+i0TDpzc2HdceFbHOF99fxZxR3jegTWH8ctwL3LFW2wL5Q7mglAHjeZJICSOade1x
	 rFv2GSts3JZah91PzsthfbC/sRtVIyWQYgNc1i/1IjybDjbWAUxbrnwLC3Tjt7IA5Q
	 OUoaHJnDssfYdVac1c5NwsraECJxxvz7A9F/rKWIgrznnNtiSe5OqjyitAxgLs6ulb
	 GMFKfwIlevubw==
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [filter-repo PATCH] Don't crash on multi-line config values
In-Reply-To: <20241214181306.296673-1-toke@toke.dk>
References: <20241214181306.296673-1-toke@toke.dk>
Date: Tue, 28 Jan 2025 19:06:01 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87sep2olti.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> The parsing of the output of `git config --list` fails if any of the
> config values contain newlines. Fix this by using the --null parameter
> to `git config`, which is designed for this purpose.
>
> Add a simple test that causes the crash pre-patch.

Hi Elijah

Any chance you could merge this? Seems a couple of others found this bug
as well, there are two open PRs on github with alternative fixes for the
same issue...

-Toke

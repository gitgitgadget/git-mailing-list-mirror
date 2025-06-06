Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DEB2882A9
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749212934; cv=none; b=UhEJVHAbGBFo/5Cq2K+atMFqnegarEcOEsjq21wuGgosR91jvwHnqJ3fE87HQn9wBNzaT9m1ruWGOXuyLdhkiBI2Xa4n1I3EMvZ5dRCzOBjALEXrM9ABJFNxwL8RLHuICd27xY9GAn+C8v4Tbgdso7+RZss4Rm7xksfWyoWWNAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749212934; c=relaxed/simple;
	bh=SzSAQNEDFOMtVOnFscadyctGZPSuAlT0bS/6stbSeik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VyOBTFTmMRAFj8tgV4Q5Gkky9Y1fHlRDM3+55Ge7sCPPjaxPASQ3c5SwE7fqxEV/EWXSOigSZ0SOYx8/2ugC9dajBVzkAzB4lYsH0C0iFOVJO3NWa4rVZGNqnPGWBSEZwrei3JpK9jDOiKCVqNtxVRN2Fkmbq667ZFvpUilVBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=oR6md+07; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="oR6md+07"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1749212928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JwsPx19+ut0GWUs9szc3BnwggAhmc/LYOI6GaC6BqwI=;
	b=oR6md+07JB5NPFdSMhoPiIuqIbgZ6xbyfzg0XHZFWphcK252YkkAd/SnKespRqQJABybDJ
	GxF17jNfGJ7rVRGxpj1jgfmOPmuXWgSE+7/Mf8dPA+xrCWZlyexjLO3p1Q5RH8LnosDAat
	T+tmdo4rR5isEkDmV9HZ8cT0/b8Gick=
From: Toon Claes <toon@iotcl.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Martin von Zweigbergk
 <martinvonz@google.com>
Cc: Nico Williams <nico@cryptonector.com>, "D. Ben Knoble"
 <ben.knoble@gmail.com>, Remo Senekowitsch <remo@buenzli.dev>, Theodore
 Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>, Git Mailing List
 <git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>, Scott Chacon
 <scott@gitbutler.com>, "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
In-Reply-To: <aCJwgWaNoBVjvImJ@tapette.crustytoothpaste.net>
References: <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
 <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <aAgWytQNqtLzg2TU@ubby>
 <CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
 <CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
 <CAESOdVCKTnUbVuXq-=F3df4i2T-GcDpJMENr8wwm-ZXR95+59w@mail.gmail.com>
 <aCJi+4q6DZhnfdy+@ubby>
 <CAESOdVD_Cse6AjwLb-4QKjdo4ESWwF3FzSS5JaHbE6ZrMjFeZw@mail.gmail.com>
 <aCJwgWaNoBVjvImJ@tapette.crustytoothpaste.net>
Date: Fri, 06 Jun 2025 14:28:31 +0200
Message-ID: <87tt4t12c0.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-05-12 at 21:43:46, Martin von Zweigbergk wrote:
>> Random bytes has worked well for jj.
>
> I would like to suggest that we use a deterministic approach.  People
> rely on Git commits being deterministic, including in my stash
> import/export series[0].  In addition, it's important to avoid any
> allegations of side channels or leaking information in commits, which
> would be a concern in many environments and which a deterministic
> approach would avoid[1].
>
> I'd suggest a simple SHA-256 hash of the original commit data (for both
> SHA-1 and SHA-256 commits, but one that would change to a new hash if we
> added one) or an HMAC-SHA-256 with a fixed and documented key.

I was thinking: you cannot guarantee determinism, because the change-ID
would remain stable, even when if the underlaying data on which it was
generated changes. But on second thought, _some_ determinisn *can* be
useful, for example when different tools try to generate a change-ID for
the same source commit.

> I would also recommend a config option to avoid creating these IDs for
> those who don't want them included for privacy reasons.  I expect to set
> such an option, for instance.

Fair enough.

-- 
Cheers,
Toon

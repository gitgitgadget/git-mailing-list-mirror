Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3A2E0B5C
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028936; cv=none; b=fQuJlHQTSxDwIver0zJXb2iQ0SjBVK51shuPji6thMcL9FI72C+ReOL7lAfTmOJKVCwH2URAZjGwLAPcrZ/rdSmGRAP9uaEXfwcM7SrKmVt58EXTEocBnbngdSZSMrmH9tz5ckeYlSqCyKLE17hPeHtccYVDP33WDJJpimDTJ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028936; c=relaxed/simple;
	bh=2id2PWnhGwly3cUYzk3TNY6aazjkB4QlBtwDdckHG8c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bcakQs2qOBovEJwTeKsIYrhDjqfn0UAcuF+yDoP1Dq91EK37BefpzcueszQ9z6VOaIg2gNZVXji2gVZywmTsyRS4RCII8OwZjse8WspTMX+ZrGMJiZ+H56SnSDS+7lZrptSZrjx3IE/3OQlLuGEVQeIYKbVLql9y2rCSUszZb/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=akG7TvSF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ju1spTO2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="akG7TvSF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ju1spTO2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A3C51F388;
	Thu, 13 Nov 2025 10:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763028932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2id2PWnhGwly3cUYzk3TNY6aazjkB4QlBtwDdckHG8c=;
	b=akG7TvSFlwAKO3tq8OkgK/b8p2KG0d++1dRCJGDxNAT4LMjOVwJ8E2ri1oUv8adVRqp6PS
	p8Lr8wNmhgcndksA/Psclp48RLh9Q+b+k7DScNWczu00+L/KoN8oUbC6ZUYS77HwLF8Uih
	Lqw5ggi/oH8BXwMilaXGJK5gbVG3jSE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ju1spTO2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763028931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2id2PWnhGwly3cUYzk3TNY6aazjkB4QlBtwDdckHG8c=;
	b=ju1spTO2p+A2EFNlrH/lB/1rDTLuzXX9rvXhT2cqa1p2hQ6KrGTuxVyuDeOZcb41WZWlZl
	xaFzaATsDvMpkeBG/Rzwqpi7wyjL7tP5oqdL5V5KAiW+WXNgjVj5DcTmikFdPC+gLLIbnP
	2UV3Zw9wbUdDS70kccrIH/IA4S6gJO0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B9BC3EA61;
	Thu, 13 Nov 2025 10:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mFdSEcOvFWnBIgAAD6G6ig
	(envelope-from <mwilck@suse.com>); Thu, 13 Nov 2025 10:15:31 +0000
Message-ID: <a1c0440a6eef8f306f53793b2f96636945d4ced4.camel@suse.com>
Subject: Re: git fails to checkout SHA1 submodule in SHA256 repo with
 --depth=1
From: Martin Wilck <mwilck@suse.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano	
 <gitster@pobox.com>, git@vger.kernel.org, Adrian Schroeter <adrian@suse.com>
Date: Thu, 13 Nov 2025 11:15:30 +0100
In-Reply-To: <aRUaR6IfH9imrF5A@fruit.crustytoothpaste.net>
References: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
	 <xmqq7bvvtdoe.fsf@gitster.g> <aRUaR6IfH9imrF5A@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6A3C51F388
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -4.51

On Wed, 2025-11-12 at 23:37 +0000, brian m. carlson wrote:
> On 2025-11-12 at 16:32:01, Junio C Hamano wrote:
> > Martin Wilck <mwilck@suse.com> writes:
> >=20
> > > > Subject: Re: git fails to checkout SHA1 submodule in SHA256
> > > > repo with --depth=3D1
> >=20
> > I think it is not supposed to work to mix repositories like this,
> > regardless of any other option like --depth.=C2=A0 I think brian gave a
> > response to that effect in a thread in the past few months.
> >=20
> > =C2=A0=C2=A0=C2=A0 ... goes and looks ...
> >=20
> > https://lore.kernel.org/git/aJ5gOPQ9oologqj-@fruit.crustytoothpaste.net=
/
> > https://lore.kernel.org/git/aKPJNNWMW9gtueEK@fruit.crustytoothpaste.net=
/
>=20
> Yes, that isn't going to work and it never will unless we add some
> extension mechanism for that purpose.=C2=A0 The repository in question is
> corrupt.

Ok, thanks for the clarification.

Let me just explain the use case: The distribution ((open)SUSE) has
switched to git for version control of its packages. We have chosen
SHA256, because we'll need to support the distribution for many years
to come, much longer than SHA1 is going to be considered good enough.

We can store the source code of the package e.g. in the form of
tarballs (and we do). But it's convenient and efficient, and thus
tempting for developers, to simply link to an existing repository
hosting the sources, using a submodule. And upstream repos still use
SHA1. This is what lead us to experiment with this sort of mixed
repository.

I get it that the concept is flawed and unsupported. Up to now, that
wasn't obvious to me.

So what we can do now is either keep storing tarballs, or wait until
there's a full solution for migration between / interoperability of
different hash algorithms, and until the source code repos we're
interested in have been fully migrated to SHA256. In some special
cases, where (open)SUSE owns the source repositories, we may be able to
simply migrate to a SHA256 forge. We can also invent a "poor man's
submodule" mechanism to link to sources on some external repository
from ours [1].

Do you see any other approach that I'm overlooking?

Another question: If I, in the current repo [2], create a commit on top
removing the submodule and replacing it by a tarball, would the
repository remain broken, as it would still have the deprecated
SHA256/SHA1 combination in the history? Should I expect errors if run
e.g. "git rebase" or "git bisect" in a repository like this? IOW, do I
need to rewrite the history of this repo, eliminating all instances of
such mixed-hash submodules, to be on the safe side?

Thanks,
Martin

[1] Such a thing exists already, but to me it feels less clean and
elegant than using native git functionality.
[2] https://src.opensuse.org/mwilck/multipath-tools

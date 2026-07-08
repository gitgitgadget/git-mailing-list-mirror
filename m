Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24BA386C31
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783495982; cv=none; b=GD5BaMtjHBgT1nRrZ8Qpos7FEPnfZkfLUVgRWgAkZUhineR+bfc32mP6vxAYW3K7/poZCfYqNVNxcrLvYmsdoelf3sStktfMG+8ulrrFPtEe32XwKZNzRqbgmmRU/FXiciseqvnqqF8R3WpLwLJ3ghP6rySH0yq26uYzoMblEtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783495982; c=relaxed/simple;
	bh=Y9ATKwJevMlPWcMhRG2w92ea6u9Dy0tSSj5gxj5z0yw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aDTNrMTlOeIM+6hGLiQ8Jf+DNCMhfoeyl5REi1TxcNjoXCZcAKsNMsXsazH/pNEm3QyUDvCDNkh4ynaqseX3IDlaXubXv3GQe0FFqqRc6GVGoirCOTY4UvJn4gp2N6nFt8FDL58kEHDTYvtN4kAXw3F7lQ4IPfyvGcxxJDaczMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=h2rLynZx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="h2rLynZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783495960; x=1784100760;
	i=johannes.schindelin@gmx.de;
	bh=YLpuUpJAp3bZJIhXUtMzcPjIMWliDxQGUAI7vZxYBLk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h2rLynZxvmFPFyRHtFKQH243DY0OrMWZKzUeQy27FKG4AoEFjf9D1Gflf1MMMDpP
	 DWso4IablcxyPM7pBwqyfseajb4gzR+wriCK+pOQgU2nPt8B12/upRhvMeRoT1kIL
	 Uxlbad2JCd9AVBb47Z2M4IxRwp9PyNwgPdUWOw/dvgRhfMG5SEUZN5Mgwx8ggizEC
	 AQnx0JLEANu8H0bFjRXsHdCyUsFm2FNrtJUhqDX7zuZxfCr/oq5rK/Zs3JZbHCkto
	 ALPeqorNGjSdShgoiAglg6OkVal1DQw4L8rvYTr8jYe9YAGgv3qEtA9CwlGPMwZ+8
	 Apd/ZwsACbAZZnmpqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbzyJ-1xDOGl04Qp-00gN5x; Wed, 08
 Jul 2026 09:32:40 +0200
Date: Wed, 8 Jul 2026 09:32:41 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Junio C Hamano <gitster@pobox.com>, Joerg Thalheim <joerg@thalheim.io>, 
    git@vger.kernel.org
Subject: Re: [PATCH v2] config: retry acquiring config.lock, configurable
 via core.configLockTimeout
In-Reply-To: <agrIrGwSMFlKTx9x@pks.im>
Message-ID: <b5c80d76-5ef4-cf1f-f4e1-78e63cfea81b@gmx.de>
References: <409d05a5-235b-6b19-5a33-a4e613dd447c@gmx.de> <20260517132111.1014901-1-joerg@thalheim.io> <xmqqzf1xbl4i.fsf@gitster.g> <agrIrGwSMFlKTx9x@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:0Fzd2/8UapGj23+06+Hb71oXeumTFkAYHGkmZ/u/xrgVurGhhvK
 msZ3adPk4ik7dDlj4mwtY60FZyjRzogmNliUVX6KBwrP3PNt0HReOma2nGhn/bd9LtWGIv4
 Hi3zMpz2IK5eAZrlaSeJcyJeWf8osPiVlQjx2mKzOq7E+PyvCJ+0ErZpS5v1Fn8CwynV7Sb
 /8391a48gMcnjlB62AWgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SuSGArr6iB4=;YMkNqMyl1Z7KCE8aKPoZeO0ZNGF
 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
 q/QCjCZLFP7h4X1an1RioQ4G3dwngZDG3v3tYNR
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 18 May 2026, Patrick Steinhardt wrote:

> On Mon, May 18, 2026 at 09:46:05AM +0900, Junio C Hamano wrote:
> > Joerg Thalheim <joerg@thalheim.io> writes:
> >=20
> > > +/*
> > > + * How long to retry acquiring config.lock when another process hol=
ds
> > > + * it. Default matches core.packedRefsTimeout; override via
> > > + * core.configLockTimeout.
> > > + */
> > > +static long config_lock_timeout_ms(struct repository *r)
> > > +{
> > > +	static int configured;
> > > +	static int timeout_ms =3D 1000;
> > > +
> > > +	if (!configured) {
> > > +		repo_config_get_int(r, "core.configlocktimeout", &timeout_ms);
> > > +		configured =3D 1;
> > > +	}
> > > +
> > > +	return timeout_ms;
> > > +}
> >=20
> > The above design means whichever repository happens to be passed for
> > the first time as "r" to this call will fix the return value from
> > the function for the rest of the system, meaning that the lock timeout
> > is a per-process property and the repository parameter passed to the
> > function does not matter all that much.
> >=20
> > It may make sense to admit that this is not a per-repository
> > property (due to the use of local caching), have the function take
> > no parameter and use the_repository to the config_get call.  That
> > would make the intention more clear.
> >=20
> > Of course the other end of the spectrum is to get rid of the
> > "configured" caching here, and ask the config system to make a
> > hashtable look-up every time the function is called.  That will keep
> > the lock timeout per-repository, which is closer to what the current
> > function signature suggests.
> >=20
> > I dunno.  My gut feeling is that there aren't valid reasons why you
> > would want to specifically set different timeout values per
> > repository, so the simplicity of using the_repository (i.e. the
> > primary repository instance this process deals with) sounds like a
> > better way to go.
>=20
> There probably is no reason to have different values per repo. But to
> me the question is whether there even are any use cases where we have to
> lock the config file so often in quick succession that the caching
> mechanism even matters. My gut feeling says no, also because parsing the
> value from the configuration is going to be drowned out by actually
> writing the lockfile and renaming it into place.
>=20
> So I'd rather lean towards dropping the cache and keeping the repository
> parameter.

While the question whether or not to spend 5-ish lines on caching sounds
like a topic that could be debated in splendor and at length over a couple
of beverages in a cozy bar, I am starting to grow a suspicion that I want
to doubt whether the cost of that cache was worth blocking this patch for
over a month. Lacking such a cozy setting and at this time also lacking
the leisure to enjoy said beverages, I'd rather go forward with the
proposed version and move on to more exciting things.

In other words: I consider this patch fine as-is, and in the event that I
would consider highly unlikely where the cache _really_ bothers anyone, it
will be an easy patch to remove it.

Ciao,
Johannes

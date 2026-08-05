Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B40472F90
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937886; cv=none; b=in4yDpFRaT/ZW2JdKQWoAoKtmXXwswKFR/IdF8SjK+oASiOHiU6K9aL3KptEFMB5bHVFHWkvM8F/Hrx/JAM1KLrlmddMPkE7dhFriV/Y5IX4kEcibHEldNKHuBTB94GkldLZiHEe5QKTnW1wxOW+YoGf39e1IUFHUqIw+BvyIJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937886; c=relaxed/simple;
	bh=qhnIku5mgFoZFdJF2kDUGfUsdHj1xrs6U6hB4IR5l+Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WJrgOpq1n8ZBFMokeZkbkmSmMq6+lA8fYoDdCzYeKYQidEvhsl1wAsZ1qBdKVJfa8vVEc06KDMidKN+NGIXSgo7dzQxky/tQbcXKe5OEO/W1Gl90Nj8ZRLfYjU3IGoomxQPjaRNN94Um15NZ4QYCuB6CBkFsCP51sovquXJhT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=qrbiuPY3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="qrbiuPY3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785937881; x=1786542681;
	i=johannes.schindelin@gmx.de;
	bh=uSkVDm/iX+jDHcuTmGULHxxzuviPVKLVft9Jr3mPlqU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qrbiuPY3JE/PyGD5NnSjCY4dOTsyTA+N9zp4f3J84W7GbnrMMiK0SffX7PMAIRbV
	 N5OCz8JQgdvJ22qKT1k1ycEcSTePyK909/yXLKrmxrVVw9gHZ5W7SjHQQiZJMxffs
	 NCsWz6CDOf5n+rjBQVxskrKC4Bf2caqySsAb2CEu56guO4HWC2UL9PFISKkx0zUkl
	 ue6f769jvYWjCzwYFZaxAQDFtR8gQuxMF+DnjE3148Re4diSafc/cTf/6+0nCKBsO
	 Zacgof3haI7+hsK6OjgUxTUCojpdOD1eL4oTomAETIT9WR42wGVmN1gK+v9cv8Y0x
	 7H4qFTpEtRE8Tbx7jA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89L1-1wmMpO2ZyF-00Cs8u; Wed, 05
 Aug 2026 15:51:21 +0200
Date: Wed, 5 Aug 2026 15:51:20 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 01/12] diff-delta: widen `struct delta_index`' size fields
 to `size_t`
In-Reply-To: <anMA8QmycpIksrQ6@pks.im>
Message-ID: <2f4a466a-82d0-5a21-d1a6-4482d4d3f841@gmx.de>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com> <69c2c21f05a2aec95f1ef61f861051c289b03dd4.1783615780.git.gitgitgadget@gmail.com> <anMA8QmycpIksrQ6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:qktEqJa3UYOpZ13xU9irl+vog2TRNMNT8gd+qqDCE6hU1Nexh2D
 Peb/QInii9bJqP1rfSzoUJvu5/Fne6y8rerj190MvqDPf2qadWMCe6zgJIubvJigOq85dpf
 kiF4tCLgBUtn9ypcKtsVtTr9MLuoA29ahNsa0B+7XE8qcuon/VZdY010QonKXN7QoJ/JKai
 rmH03aI9ZzPdDch4HiOMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qk33zQVlu8Y=;YI1IWopgONd6mMbciefNU9KD9up
 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
 jU/orFA==
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 5 Aug 2026, Patrick Steinhardt wrote:

> On Thu, Jul 09, 2026 at 04:49:28PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/diff-delta.c b/diff-delta.c
> > index 43c339f010..b6b65d7607 100644
> > --- a/diff-delta.c
> > +++ b/diff-delta.c
> > @@ -125,9 +125,9 @@ struct unpacked_index_entry {
> >  };
> > =20
> >  struct delta_index {
> > -	unsigned long memsize;
> > +	size_t memsize;
> >  	const void *src_buf;
> > -	unsigned long src_size;
> > +	size_t src_size;
> >  	unsigned int hash_mask;
> >  	struct index_entry *hash[FLEX_ARRAY];
> >  };
>=20
> `sizeof_delta_index` returns `index->memsize`, so we'll also have to
> adapt that function's return value and its callers.

Good call! Will fix.

Ciao,
Johannes

>=20
> > @@ -140,7 +140,7 @@ struct delta_index * create_delta_index(const void=
 *buf, unsigned long bufsize)
>=20
> I was about to complain that the input parameter here uses `unsigned
> long`, too. But the next patch addresses that.
>=20
> >  	struct unpacked_index_entry *entry, **hash;
> >  	struct index_entry *packed_entry, **packed_hash;
> >  	void *mem;
> > -	unsigned long memsize;
> > +	size_t memsize;
> > =20
> >  	if (!buf || !bufsize)
> >  		return NULL;
>=20
> Patrick
>=20

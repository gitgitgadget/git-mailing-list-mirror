Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7250D657BF
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466525; cv=none; b=SZBIJG5Sw5KCgk1RC6ngjpZ4orVFU9seYQe2JEZoiR3Bn3QDqgvV66k7YIgzUOq+/L/zDPDPwooZA79eC0Lpm2zSeImEYsLpQv6CXOu1nafJpObWPZJETyW0yVdMGqmlvsirIXKPu71/oIYQiNVx17PuULLTnMXt8TJFPoS0j/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466525; c=relaxed/simple;
	bh=D8tD8u1mI9llryye2cRb8SeAKqV8UB2cGgfkEk6gTUM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cupcc/p4MdHl7BHF6RMJGPBQhFGtPCiKDHxoED/WtoazWWd/AeP16to1hH9MFJ5bKbO9hsLaDgU71a8XqJvlk/8EKvdYZIoHFMmLV4WDn4gAOUf12od6rs/Dtt10FtQ2QaLSxVW8Z+jSjm/33BmsM8CZ0aHo2Zi/2L2HfERwvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=IobA6vRH; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="IobA6vRH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707466516; x=1708071316; i=johannes.schindelin@gmx.de;
	bh=D8tD8u1mI9llryye2cRb8SeAKqV8UB2cGgfkEk6gTUM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=IobA6vRHbQ0Is54y+6Lkib+3TbOX3vqt1cpue6qKryqkx88j9Ou+7pXyzFeUxB9T
	 6VUHNf4N1d6lsBwuHeKZDC7PEpHPviN2EMh1gYrwBnc7qTSMrTVCthORb6k+jV5wx
	 U2KN4HpEu7WpqY2b/soNKDDnAP3G+OUDfp91p2QXnN+7VW3/Nyr08OPmt4g5xF9qV
	 8xqpLVUrssRqL7RI1GOzup6A/gX/WCHgDQNDXlnDPwcPR50mmPw1YFS1N4givll5v
	 zR6UIv/QYbg/FKwL/zpZphtF+Plu+gwLA+YazmuEioIJj847e325/6lWnQidJ5hhS
	 1zKAXHLmSsEsftANuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe5k-1rKVsY2DHK-00NmWu; Fri, 09
 Feb 2024 09:15:16 +0100
Date: Fri, 9 Feb 2024 09:15:15 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] Always check the return value of
 `repo_read_object_file()`
In-Reply-To: <ZcHW_bc6N5umk2G4@tanuki>
Message-ID: <3f14077f-c70c-5eef-5b25-984fdf7b3b68@gmx.de>
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com> <ZcHW_bc6N5umk2G4@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GjwljpfbIM1heH2I8IsYfA8fDo2DPo9EqgANDC5NsM8fP7wNxYS
 OYoYzckUyZGUo1PJ8a/X7Rgrm3sRda+k/NWEQeDtKoX+ch5lK4PheJkqnsDYCzYmYzHJMCD
 9De3HqXzLz0yiqU0XjAqWLFzmIAMUqeXSAf+TrmlcXNhieNevX6tHa5F9Ey4bh6VyP+Hwne
 lWn2J1nQje3VCHDqvIucA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+2zzTs0msc4=;eyiVf+T8O9UVUtk4yxCi5SjCqeZ
 +beF3xOkbGf4NOV5/JRXiagPpm5MZvl9OtuSJRmFEtXcUkqHVaaYx5JnhnzHVx+J0KshWhW27
 EN0aaA+ntNKL0mYTI5brkf9oSbq5VDR/cX0Ya4NetEg8fXTukb0quVakqqU2/DmWltKGyBTRg
 /7BTYoaMsU+njWXFXfGUhTIX6vhMsJ+rrv5jwLPjmXrLhdf+m6YsCeRFiZ4KEFL0k/YdS5jOv
 G1I6oQkrn0sbbDp55syPx0x3wB8ihX9PtXo9UGkUkH00oSIOfhwgdVYUg0L/Bw1LPTl4DkRDx
 pmQIJpZCovSvqXXpPHaQPFZT5Wi40uTw47Ut1MhcEVyG8vj69WCHjnxt/s5Y0cmaJA3uAxf73
 k+mWQg/arh2ynukzVlzFdmqdpiHtqTA8KLPFuClStJQ+joqL2T4ag3mttFv5DHrDZP7dnOaEj
 NK1H91BhYgRhZdU4v8R1+YHwNvLOfS5tjXzSZIktd2ZVSXnJpNEza04tnD8eIqKVfRWv+sjj5
 xYuSOu7muHt+vt9G1KPdICCSfnBz4Pz2Jm4FOzIaeAy9FlkwmuPhGDniCyftFOtnGBay7s060
 xJlL08ohNHwlEPH4HxI7i3nlGh8O5gg1dtHv9uJy7xjt2wWSE3LhEf5FwkC+vZbVyuUYqQBQs
 d5oih9S48m1SIa+8oEJHGSCk/qk2M/fwHqCPwi1GX7vfTi9NgWrlmUWxF09GmB9r0Nqs9/Nwq
 pobgW9I7TNtR1m4wChNBAhhU32lqavbDgWsYM+U9QjNP1Ft3HbOme4Eo1H6+z9vO/xP4G8wUr
 rPJTXi1FNHW8Pu70GRjh5IrhhYKsjf4ErfXlLRlxUYxto=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 6 Feb 2024, Patrick Steinhardt wrote:

> On Mon, Feb 05, 2024 at 02:35:53PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [snip]
> > diff --git a/rerere.c b/rerere.c
> > index ca7e77ba68c..13c94ded037 100644
> > --- a/rerere.c
> > +++ b/rerere.c
> > @@ -973,6 +973,9 @@ static int handle_cache(struct index_state *istate=
,
> >  			mmfile[i].ptr =3D repo_read_object_file(the_repository,
> >  							      &ce->oid, &type,
> >  							      &size);
> > +			if (!mmfile[i].ptr)
> > +				die(_("unable to read %s"),
> > +				    oid_to_hex(&ce->oid));
> >  			mmfile[i].size =3D size;
> >  		}
> >  	}
>
> A few lines below this we check whether `mmfile[i].ptr` is `NULL` and
> replace it with the empty string if so. So this patch here is basically
> a change in behaviour where we now die instead of falling back to the
> empty value.
>
> I'm not familiar enough with the code to say whether the old behaviour
> is intended or not -- it certainly feels somewhat weird to me. But it
> did leave me wondering and could maybe use some explanation.

Hmm. That's a good point. The `mmfile[i].ptr =3D=3D NULL` situation is ind=
eed
handled specifically.

However, after reading the code I come to the conclusion that the `i`
refers to the stage of an index entry, i.e. that loop
(https://github.com/git/git/blob/v2.43.0/rerere.c#L981-L983) handles the
case where conflicts are due to deletions (where one side of the merge
deleted the file) or double-adds (where both sides of the merge added the
file, with different contents).

Therefore I would suggest that ignoring missing blobs (as is the pre-patch
behavior) would mishandle the available data and paper over a corruption
of the database (the blob is reachable via the Git index, but is missing).

Ciao,
Johannes

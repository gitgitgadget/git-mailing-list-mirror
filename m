Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658584D34
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469781; cv=none; b=SM3vtsezagqtc5u+bGUAEYQPClRvh0Kb7HMINSxLbwDE7yUmHtgmw1c01cqLdQ5mTWZPEFZrxAYfog1sndndWU0dLA7lheLg8n7MNTOs4ZjCY9eGRtT/ukSR3vLbLRbNzuwblqunBWH1UkFS1AwT7kj6EAQuF2R9Pkuaq8DJA/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469781; c=relaxed/simple;
	bh=vIQdvSnN0JVMXtnBBzg2ewBkV4CidCgIUrRuO5Jp+cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leTMzJEHmnDU8bSxN1vLh+HC87hS3zL6FRslRMGg0AUeqFbUKCBAe9PRUS6Icn8ZpmH9B7rrD1IXD1zxUBL9grAm+zA0MfJ9msJm3Y6CLMMeuc3DgWlmlrs3/kj+ZGot8rm+1RXFADF6DjCDr75F+WYp4XdsSJAkgDfv4WTifXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kVFvHc1q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FMyJzBmc; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kVFvHc1q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FMyJzBmc"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7879311401CE;
	Mon, 16 Sep 2024 02:56:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 16 Sep 2024 02:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726469778; x=1726556178; bh=Kci+J7WWB+
	jUD/QZMiGYBF5XutDF++fpWiNMQdsIlAY=; b=kVFvHc1qEvqu5gZEG2PHqWopvi
	OZzQkS3zcQFiIJ9RgBvNhe7ricat4tPiXi0U1vUEmZdHIdS6erEPqH/6ODzQF8gv
	0L2pYuuXYY6w1cnEaOV7ESRYIMySC3gEyMhTNspOl1gYnE+nGcPJGlvIsjLlois8
	NCZmqZ+yI68vjaBSzxtH+lzoDHOZETuuV4TR0rF207RIFiisTy+1mLJTYdDO2m7x
	1atS6NYiAU5h3ghnYwJKzebdnyQhtD3Se/X0m+OdxxJj/+drBCyQLoFGF6kIU5O1
	p4OXN4nAVtJp0mz6ggTGYCJZPKj6zYbmi750dbvQrNZgzBIaJQ+qiRp97icg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726469778; x=1726556178; bh=Kci+J7WWB+jUD/QZMiGYBF5XutDF
	++fpWiNMQdsIlAY=; b=FMyJzBmcrrv/x2gqGuTy9yAETPlMS7bulyUxzkNcqvQI
	amMpCGb3h5hdLCQS+PKk94Q/W022zYZAC1B/9zY0IwX1UgnLM+VWZ3o2w0/+XBpN
	v94wasTdtXYJc26I5XIK+eMZHX8XUIzGURbdDU1xZKl1d/S9sanhC9WwkPa/naB+
	RpARR+dkMIYQ9BR8mLlb7vWqUTw9QJT2YP4R6DL40bCfSxmyKSIxBxw843p2NywZ
	+6KEiT6hLA6WfW9xpwrnNdGc4MSk0UVzMFWOeHApIF8iEYDZC7v37F6g9TH5u7lw
	1YP4BrFOGFvk6FWLbbczVfVrKyHPGNsLzGzE+zQopA==
X-ME-Sender: <xms:ktbnZkbzEOh63wA77BykihkjvRSY-zWzdNiaSL7zxA6RlI8gSoTmKA>
    <xme:ktbnZvaURkoOhJUHnzIwSRe3BFBCpyiqkDO5MLgIH-J2cywUhVNtSpHIPYdZrYDkq
    0TT__I1Eir1wMBQGA>
X-ME-Received: <xmr:ktbnZu_ICqjwNKcf0gSxYrPcdKEl3XrUTmpRp3Jo5ZhEVpNtx08OhBX8LMIK2sDuf7lCi7Iy9-7pfFvimwGdstx_Q-rxMu2T-83SQZiu5jd7FKWR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ktbnZuqzVQBfHbSOpk6ACjKVF7LAw5v2vA_2rFdNXv6EYnjbFlq0pg>
    <xmx:ktbnZvqaHShDVPy9SUQZb_2-DZCSwFyva_7a6dkhboyZNyOAOsX63w>
    <xmx:ktbnZsQ0NtmS0aMtiRqRsTNAdO-8QwNQHJ34F7RiS6Pl_nTID_dXPQ>
    <xmx:ktbnZvogyj6kvFB9dagSjCypVbJmkTEzfI_Km_NBjNrWbwNrFnohYg>
    <xmx:ktbnZuXuvuxui-56Qve2MqgaM4rG1s7bHSRMGySVXZAoMU1cB1O1X9rI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 02:56:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a6b510fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 06:56:00 +0000 (UTC)
Date: Mon, 16 Sep 2024 08:56:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 6/6] refs/reftable: wire up support for exclude patterns
Message-ID: <ZufWkLwn0RQeCCpD@pks.im>
References: <cover.1725881266.git.ps@pks.im>
 <f3922b81db69cd3bbdddcfbe02c99613448fd9ed.1725881266.git.ps@pks.im>
 <CAOLa=ZQikyvJCRZ=mCfve+VWZfrvPL1bg55txB1q0Nh3SW_JJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQikyvJCRZ=mCfve+VWZfrvPL1bg55txB1q0Nh3SW_JJQ@mail.gmail.com>

On Fri, Sep 13, 2024 at 07:47:06AM -0500, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > +/*
> > + * Handle exclude patterns. Returns either `1`, which tells the caller that the
> > + * current reference shall not be shown. Or `0`, which indicates that it should
> > + * be shown.
> > + */
> > +static int should_exclude_current_ref(struct reftable_ref_iterator *iter)
> > +{
> > +	while (iter->exclude_patterns[iter->exclude_patterns_index]) {
> > +		const char *pattern = iter->exclude_patterns[iter->exclude_patterns_index];
> > +		char *ref_after_pattern;
> > +		int cmp;
> > +
> > +		/*
> > +		 * Lazily cache the pattern length so that we don't have to
> > +		 * recompute it every time this function is called.
> > +		 */
> > +		if (!iter->exclude_patterns_strlen)
> > +			iter->exclude_patterns_strlen = strlen(pattern);
> > +
> > +		/*
> > +		 * When the reference name is lexicographically bigger than the
> > +		 * current exclude pattern we know that it won't ever match any
> > +		 * of the following references, either. We thus advance to the
> > +		 * next pattern and re-check whether it matches.
> 
> So this means that the exclude patterns were lexicographically sorted.
> Otherwise this would work.

Indeed. Good that you call out my assumption, as I in fact didn't verify
that it holds, and in fact it doesn't. It's not a correctness issue if
it doesn't hold, because it would simply mean that we don't skip over
some references where we really could. But it certainly is a perfomance
issue.

Will fix and add a test for it.

> > +		 * Note that the seeked-to reference may also be excluded. This
> > +		 * is not handled here though, but the caller is expected to
> > +		 * loop and re-verify the next reference for us.
> > +		 */
> 
> The seeked-to reference here being the one with 0xff. We could get rid
> of this by doing something like this:
> 
>     int last_char_idx = iter->exclude_patterns_strlen - 1
>     ref_after_pattern = xstrfmt("%s", pattern);
>     ref_after_pattern[last_char_idx] = ref_after_pattern[last_char_idx] + 1;
> 
> instead no?

Sorry, I don't quite follow what you mean with "get rid of this". What
exactly is "this"? Do you mean the re-looping?

If so then the above doesn't fix it, no. We'd have to repeat a whole lot
of code here to also retrieve the next entry, store it into `iter->ref`,
check whether it is an actual ref starting with "refs/" and so on.
Looping once very much feels like the better thing to do.

> > @@ -580,9 +660,45 @@ static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
> >  	.abort = reftable_ref_iterator_abort
> >  };
> >
> > +static char **filter_exclude_patterns(const char **exclude_patterns)
> > +{
> > +	size_t filtered_size = 0, filtered_alloc = 0;
> > +	char **filtered = NULL;
> > +
> > +	if (!exclude_patterns)
> > +		return NULL;
> > +
> > +	for (size_t i = 0; ; i++) {
> > +		const char *exclude_pattern = exclude_patterns[i];
> > +		int has_glob = 0;
> > +
> > +		if (!exclude_pattern)
> > +			break;
> > +
> > +		for (const char *p = exclude_pattern; *p; p++) {
> > +			has_glob = is_glob_special(*p);
> > +			if (has_glob)
> > +				break;
> > +		}
> 
> Why do we need to filter excludes here? Don't the callee's already do
> something like this?

No, it doesn't. The code for exclude patterns is structured in such a
way that the responsibility is with the backend to decide what it can
and cannot filter. In theory there could be a backend that can exclude
refs based on globs efficiently, even though neither the "files" nor the
"reftable" backend can.

Patrick

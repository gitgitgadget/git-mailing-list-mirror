Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB01AE875
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943596; cv=none; b=Q4B/hn6qpq7+BV2hY/PTIK4Pp82DP57QjFIfC3o4GkS0KyLQinCpq46x/VTehyEy1mJZ5+dzH9i95OKP891ZFcT8oV16pb/+3h0EkflXezIa4sblczueMy4msHoa95WKvZ1wrv42qe1xv5NkEi6b3t+qNLi9xuzqQE2bOtoCd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943596; c=relaxed/simple;
	bh=UZyAOtEMt+zz7EuOXsTZm6C24WeTvToRGuwOo7odk1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuZOH0UyIcirQQMcF4iaUlGBChgxDKTO3OGbtxV/ueef6O6vFyK4sHvCccW2vRk2NugrjnzayvmfrBl4lbrM0r8hxFc/z3f6wntZcqCJcfflqixpgR+fi+uSIF8s1drk0q28IBFjC5wxnKAI7xhZmRg4zC4wyJ2yf3zCaoRyDwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MS7CG566; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=crUrB1sX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MS7CG566";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="crUrB1sX"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9962F11400A0;
	Mon, 18 Nov 2024 10:26:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 18 Nov 2024 10:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731943591; x=1732029991; bh=J0qx5goARM
	irFGeeZTnYeAtANV0ezLL0szOlNZ0Hok8=; b=MS7CG566pkTdZ/fF4ElAkNIULF
	YMZE6dCMglLMu3K4KC/0EAmp/wEGAmAcIdmkABX7R5gVy/Wvk+2zDyT95yMW50dM
	BHg8d1jnijsykGw3eeFc7p+IU2ES38mmYcYqX6Ve5A7SjwCWzPll1UEPMiYytMi8
	Fuq2zHIrbZYjO00mmzUS2piJNefsDEus4xKcWTc+O9sgeh8r8ZtfnE+2/A8OT8N0
	+ZWmMe6sawn4MKMVjzL68jJqc4Vo5TCVC5z2fIO6qoX666mhiWvsKAPbX2psk0PM
	KtOArXju3IXjEExC8RNVwe4KFvKtDmEt+lXyG54K2sUMr0hFKWYeOtLuTJMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731943591; x=1732029991; bh=J0qx5goARMirFGeeZTnYeAtANV0ezLL0szO
	lNZ0Hok8=; b=crUrB1sXo2gBQVyuaG5rXdhD3eVJpODCUFC3UJg9KEPX8IVWplM
	n/YylC32Yyyv8lAxye8t51tCccDQVCl+aVv+9Nkdc10OxteN1EJRY838OkHAoLJC
	tVJpU6zpbrCWfEBpJLVzwpAtNIT0h6XApL30ySHhUkABPYGP48gVuve2x3Sl+yT4
	yThRMNXbdZizZ8PkwlmQbj7sLsmziaHR/S8DQs3P5loabGGBKkzY/xx3wdpn5zp7
	02d3Sw9PJDchPVxkC+RUA7lw9Jokgsq6WbbrZXbrguENgjhOmdG8nwMMhMOttv1E
	UiOGIzGOUQfgAlbB5e6nNA3vUWjMiekKrQw==
X-ME-Sender: <xms:plw7Z1w7VOFde8ab4zna_Ai3Lc863z9IJY8bcMEeIkVfsKAJnqaspA>
    <xme:plw7Z1QK-GZHGoMbM-N1g_TXP-eWarhZRuh1xR5DOZSbCp5imju9DhnC6Rf5-qi7f
    l2oUsPfD_xTKNxLNw>
X-ME-Received: <xmr:plw7Z_U1tAVXfyyTrMDX8QRF-ynX_tdPiCFLCQQ6c5jaDJyAx0GRlc_Tpuuk1dxYz7Ld8EkwpZuhumf7gWjLbNrElHeMcXMqJ4pQtn4jmGf1-wCK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghl
    vghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:p1w7Z3iD9M6e2ozOv7Z25CQ6vg6aP6ek2JKhkhTUtDPF8nPLUGB5Kw>
    <xmx:p1w7Z3COHUvhrGb-iiDmoyVaBOH15T4WjHO9wANGwuAcGkwIdoV7iw>
    <xmx:p1w7ZwLitHnAvxBEsOB_Nkqlas3lFPCmXSPy5AN6B1M_f-h4ARf-Bg>
    <xmx:p1w7Z2CYh91BWgrOiEvwWOJlHHT-m32O-2GHIQ0wVgnzg4MZYDf35A>
    <xmx:p1w7Zy4bdkOkajGKIuHiXma9OOofgpTriIWr7X26EfDets6vAF-ffqKd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 10:26:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 34d90b2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 15:25:39 +0000 (UTC)
Date: Mon, 18 Nov 2024 16:26:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 4/7] reftable/stack: stop using `fsync_component()`
 directly
Message-ID: <Zztcmgta-DnHFpjj@pks.im>
References: <cover.1729677003.git.ps@pks.im>
 <cover.1731047193.git.ps@pks.im>
 <7782652b97545f95c83aef08786c70384e5cfa52.1731047193.git.ps@pks.im>
 <CAOLa=ZQEmzZpH2SLXNgcPLD=CThQgwW4THUiDuPMaOkZWfp_LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQEmzZpH2SLXNgcPLD=CThQgwW4THUiDuPMaOkZWfp_LA@mail.gmail.com>

On Mon, Nov 18, 2024 at 02:02:54PM +0000, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > @@ -43,17 +42,28 @@ static int stack_filename(struct reftable_buf *dest, struct reftable_stack *st,
> >  	return 0;
> >  }
> >
> > -static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
> > +static int stack_fsync(const struct reftable_write_options *opts, int fd)
> >  {
> > -	int *fdp = (int *)arg;
> > -	return write_in_full(*fdp, data, sz);
> > +	if (opts->fsync)
> > +		return opts->fsync(fd);
> > +	return fsync(fd);
> >  }
> >
> > -static int reftable_fd_flush(void *arg)
> > +struct fd_writer {
> > +	const struct reftable_write_options *opts;
> > +	int fd;
> > +};
> > +
> > +static ssize_t fd_writer_write(void *arg, const void *data, size_t sz)
> >  {
> > -	int *fdp = (int *)arg;
> > +	struct fd_writer *writer = arg;
> > +	return write_in_full(writer->fd, data, sz);
> 
> Tangent: eventually we'd also want to get rid of `write_in_full` no?
> Since it is also an internal Git implementation.
> 
> The patch itself looks good to me.

Yup. This is part of the next and final patch series that I'll send once
this series here has landed.

Patrick

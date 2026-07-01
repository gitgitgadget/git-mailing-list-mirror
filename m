Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B42DB7B9
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886674; cv=none; b=jpbC3QJ7RQcRuTTSj6BmjbJq4sz/d7LpB826YSBlZf2BlhahVXlUvWws9VAs0/Oho9tJt6AGU2pPPp/kdeIxJDZYfYg+j1rHXWJzBlChNd1x8rwYxI7m0FiOUgYrWwHLZ324QK8ORnw67RNYu7tVwJzyzu1ONcIfT06JGFr72tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886674; c=relaxed/simple;
	bh=hSc3qKKjqTjde1MFL64mVYYGPH6Jzdl0UEUEjuvEwS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEOLC3ZM+zoBuTAo5+V4Ckorg48ZHK1J4STw8zQoCeeteF08O3OqjlctWDah7FR0pfF8VWJ5xW2RdTYEgUx5G0cUALGC8oHPki2tAW4jKBEtHRI9CTqVdxyRSvw0TD+oSVSRuRCwO972fPEce4qRXQkgcZ8b5XC9x7FskfjA+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pgBhc0zX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EzBqHmSQ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pgBhc0zX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EzBqHmSQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 92B5CEC0057;
	Wed,  1 Jul 2026 02:17:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 01 Jul 2026 02:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782886671; x=1782973071; bh=fONaKvb7kN
	Pw+58ReaEXQF9/vHImkdqXZOa57UrKu2M=; b=pgBhc0zXdQBZxG3jXPipjJDi13
	Sla2C59Kasw8euSrn2N8vqMTPrXQ9KQzkq4joYziap1/Na4NMxQM6d4kq63N+kXV
	Ry0nXyEr3Lbyg8WfWU1LVJl5TDWCE8CV+xgfd57v4tnIuIPy6nPmbUi1llQzpZ1H
	eZ2/Lm/VuLSmvbculGIbB+S/mn7nBYVgTJj0QgvsrLjlUEik8kRCVqxcRbIOq+oF
	O3CN786+OCzQ5W2cRaHp+bv9NLXVDSarawMLFNyGF56qKs7HQEMGefi1+gfXTPw1
	0XvGcyQpThnGbLCwKnhgnVxLZOTJ2QPEMlqBf9nvbzSsFNQaKrbDPU2tF33Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782886671; x=1782973071; bh=fONaKvb7kNPw+58ReaEXQF9/vHImkdqXZOa
	57UrKu2M=; b=EzBqHmSQGQPFDYVlGuzv/DYr/kojXs3PWu5QOMQc+gpmbelQCEZ
	m5wMyH9rebdP6jYDF/ABVgW8JuYTsqmnKvi2ZMTlgOMRzA05DKiJVdgpSpXlHAnE
	/4YJeSxlR3Is0q28i2He3BOPAVBU8WFYvGuYG9+nvYLrWMZVf92cmeZf4Md9J40v
	hnMA7AIyZJ1udJ9JtTBteNT9aFg+JprggRxlLSm4d/QwOjJJuR4dork9hExB2usW
	c3xiH2Lpp2O0124TLMrv5tHe/62wfoJVUcdBD1WFEwr0b9cd+VDbXz9tSVjkcPtA
	93iHRngiYoI9N0mbEtKjVktyu6H8iFYT43Q==
X-ME-Sender: <xms:D7FEajRT3x_EDnEUK-R5slcbkixlfEMgrjKOy49tXordK3U98dGNkg>
    <xme:D7FEarzl9WVHdyiHm56E1VrrJpNkZbkWAIPQn0dqSXwYIA1vCytchqYxwzVrKp5m5
    F-YpEIc14XtShYdvRCO4KeEmYCp9aI94lD19U1xPO9Wp-GwERrdUg>
X-ME-Received: <xmr:D7FEat3GU5XkRZY7Oo3nHulfIxYpgPWRENXQ8-p-FkuarJd-FcHDvTioEYgCSihG2knYGeou-jZAtBKJwgFjjOCaPjYeifaVhav-vEuW7p0>
X-ME-Proxy-Cause: dmFkZTFUW/GT/B07cUKo7TFy+ertftzHS0PcPhDjtI1aF3eDkHtnKZyPm4S/InomMBS9yB
    7KuE1BEXkst+JZHYhAsJZIAx80SC72HJcv9ySwXMiLZwED4HPIV0MT5mbnOCAqtLfV+Kx1
    jpuP8e4zkPDlsLREWn4TjE4jThtZkwiQOnTWCKJtAYcHjKXRsHleoaGTieQbCi3phPa6qf
    j8wd4HQopdizx9NG7CWKK/zDSaLHe7RFYSjkSoCr7PJcDDi94Yk4NUt38EqWg2lBf6FykP
    6h6d8thh8XU3K8ttWVLA7iaqfkiJzVwZLTiR1y1eHzYtesu+x10JDbHuySIaYcji0+pHAD
    Sl/Kzlx6myP1XXGuBJvi9DG5gFk/dMCBa/4fsH4rygfFFsR9oGXGrHiDd4YWaAkbCx3rto
    exHJo/mYi81aJrPU9zuDInI4q+DSnmyj5ekhFBEhtIWYb/iLB7Olp338IY+e5bnDB3LO6g
    MWIZgW3ShesNFksN8QnhWfxLMp3ekNFwdRLp8VIfEgcohu7SpuM5/MQm+6lTed1rYpYZQY
    jWBBaVJRxNRHUt2m1m2GTSlP7zFjVnxzvKXVvJkSEhaMQF1CQ3zdK7Kx/AQwjK4nRCnH6t
    eplDIeVC8GwSpruOLN0g4Kd5nW7DEizcceUsleY5NLZ8ptyIB0jpHmOyCmjw
X-ME-Proxy: <xmx:D7FEah5IMqzYyF2D1ViNU_Pv4D16u4hd80mQKq3AVxt35geu8NBsGw>
    <xmx:D7FEaoXeHKv4d83Lbr44_BZ1I2nzdjYy5-MgsaQV_NBRlYYiiIeLKg>
    <xmx:D7FEaoCKaJLV1XYDOPuSxWRClsgsOUe2hJrtpr7Jr5ENNZjLp7sICA>
    <xmx:D7FEav4L3XgL7EC2fDa6AWwKPpMXvR8uD-MNIu_fhrpfLVd2P-NGpg>
    <xmx:D7FEavzq5fYjFmcEYaFPBnCqlAhHT6onpE_bVd7kk1B3G4LyTaWDEgso>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 02:17:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ca9b5ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 06:17:47 +0000 (UTC)
Date: Wed, 1 Jul 2026 08:17:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: weird quadratic reftable behavior, was: Re: [PATCH 3/3] t5551:
 pack refs after creating many tags
Message-ID: <akSxCUfm2P7ocLJX@pks.im>
References: <20260628075716.GA3525066@coredump.intra.peff.net>
 <20260628080710.GC107826@coredump.intra.peff.net>
 <akIJQbOUbdBbkTef@pks.im>
 <20260629203527.GA1895313@coredump.intra.peff.net>
 <akOG0oMu2KTqqyW7@pks.im>
 <20260630234702.GA3759976@coredump.intra.peff.net>
 <20260630235850.GB3759976@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630235850.GB3759976@coredump.intra.peff.net>

On Tue, Jun 30, 2026 at 07:58:50PM -0400, Jeff King wrote:
> On Tue, Jun 30, 2026 at 07:47:02PM -0400, Jeff King wrote:
> 
> > There was one other oddity I didn't quite resolve. You may notice the
> > gross reftable.orig stuff in hyperfine. I originally wrote this as:
> > 
> >     git for-each-ref --format="delete %(refname)" | git update-ref --stdin
> > 
> > but for some reason that causes the subsequent update-ref to loop
> > infinitely on merged_iter_next_entry(). It does so reliably, but I can't
> > reproduce it outside of hyperfine. Super weird, and I'm sure I'm missing
> > something obvious.
> 
> Ah, maybe not infinite, but probably quadratic. The key is that you have
> to delete a lot of refs and then try to insert them again. So with this
> script:
> 
>   nr=$1; shift
>   rm -rf .git
>   
>   git init --ref-format=reftable
>   blob=$(echo foo | git hash-object -w --stdin)
>   seq -f "create refs/tags/foo-%g $blob" $nr >input
>   git update-ref --stdin <input
>   git for-each-ref --format="delete %(refname)" | git update-ref --stdin
>   time git update-ref --stdin <input
> 
> I get results like this:
> 
>   nr   | runtime
>   ------------
>   1000 | 0.125s
>   2000 | 0.454s
>   4000 | 1.811s
>   8000 | 7.091s
> 
> So for every doubling of the input size, the runtime quadruples. I guess
> it is iterating through some deleted tombstone entries, but I'm not sure
> why.
> 
> That's probably a more interesting and productive performance problem to
> work on than micro-optimizing out the last few microseconds of writing. :)

This is a known issue, I think [1].

The problem here is the tombstoning: when you delete all references,
chances are that they are not truly gone but that every reference is
just tombstoned. The problem with this is that reading refs may now take
signifciantly more time as we cannot just say "this stack is empty".
Instead, we need to figure out that it is empty by processing all the
tombstones, and that takes a lot of time.

I remember that I did some digging back then and improved the status quo
quite significantly by optimizing `refs_verify_refname_available()`. I'm
sure there are more opportunities for optimization here though -- I have
a feeling that we for example exhaust the merged iterator until its end
when searching for a specific refname, where we could easily abort once
the observed tombstone name sorts lexicographically after the needle.

But eventually I decided to not care too much about this edge case, as
it seems very specific to this artificial benchmark scenario. Which of
course doesn't mean that it's not worth doing, I just had bigger fish to
fry and didn't get around to it yet.

Patrick

[1]: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>

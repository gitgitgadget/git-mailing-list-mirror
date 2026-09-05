Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB443793B1
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788621786; cv=none; b=nSGSCDbUY8Z5j7RxQZ0nd2yIkxWGYeM/OzcFnYNuBeQARBayW+V6qWOUWi4FOn393dgrr2Cj4FTDz2DKJVa9x2fcT0xhen0dQxkeWogi5yuRICMPvips8joE/hXW59h19enEJeKqAFTsc+3T1C9wDhj17aNSKAP6MMgpjOHS9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788621786; c=relaxed/simple;
	bh=+YHZYIkZ71gYqGy4nQLq4g+qsqCfiWimifzX9Nl4yKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K62J/6mabaz8COkdNrdEY8Jc7GEkbzy34qB0qiSYEm3NkxpkLhDYwhUIwKRWtDiwmHqruLQ6+kY/vRbpdgh32rvQe3oLgwn7Rr6HF+3LCSRDVFKQ4uNe1RgG4uCWhmaAfqcgJsRo8J/J8Iv5UIZV9erV5C37fR4JMzlczpZWRIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XdfPs9lT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qQdrlOty; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XdfPs9lT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qQdrlOty"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 02367EC00F8;
	Sat,  5 Sep 2026 11:23:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sat, 05 Sep 2026 11:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788621782;
	 x=1788708182; bh=BumlT/qSriQSdGrGiLxzTZHnCWXDVMX12gUDOzpM53w=; b=
	XdfPs9lTBMYC+W3MyC/3/6BehvsflxlyEOjGiCMGT5fICLmsV4/Yl6fZwSDVvdxL
	OzMS1Tf3Tn7ljswwD+xUr+HGxgKQl4KuQpn7vRXyJGuGviJ1/gamvKi2wkJ9mAoo
	GueQ5kD7WdhDKmIQoenuaDsKknwUhW8Z8sYWoq46wKauBcpEGQ6BjNsxiuqNiCRU
	ItayLpQUubxCn7UrplJ7whH1NJakxNyooEgyZOMuhosaKadRRlGb4JXJJVN0Yt7O
	JEEM2MDa0d7hQEUDUv0lV4bGanXFi7qKOJMn9yckH4i4EC3HVVPLfSA9C0WZQX3b
	92PZd6IXh7wQ5KeytRwLtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788621782; x=
	1788708182; bh=BumlT/qSriQSdGrGiLxzTZHnCWXDVMX12gUDOzpM53w=; b=q
	QdrlOtyNGlt0j22vvXz47ZuZY9KcEFfqkPlgE4fJ+nEAN5/HiqSGCws2/aeC2Qpz
	LBFgA9K9rT/rj2om2yk0UjyF9rXSsrq6POnjdZNYpHLyIJtTf/ycHuu7+5vCml07
	oQGu6j2e/R3oOmWakbIzaagwuXs6RA25s37sBkxmzDt8Ufm9N+xo/eZ63HTnoR7i
	nW+vUyHA6739OH4jx6bXkWArbln5PnYue35IQG7U3qG2rF/lR0az1R3o2m0FzKBv
	m3FlsbwArJ3xlwDYY3CwYm2pw/SC+ahF2JGJasOdYBuEFzCPhy80cQvLu30u0QQz
	ugCI+UCkbuR893KlfBEyw==
X-ME-Sender: <xms:1jOcatk6na4QoLXLlre5_bMRyUq5ZPOQH76L9UHDJkgoKfVEMpsvZA>
    <xme:1jOcavvqCSXKYGE95xmbCd2G8mwPT99Vzv0Ixqpw_-Z69HR3GQfsFE5-GkEfiDeVl
    A3otxbPFBKzFh0AVV2hjORCKWoFX7eqSj5_rRmNIsBZg6ppGZgQ4A>
X-ME-Received: <xmr:1jOcar8hzZoTLHJ7pErX-QRucJeRpPzgS3S7iiynj5gjR2X5ktxi0J97NRIycVO_ikHn1FhmXf-v3rdY7K1f2mjmAHBOHkbbauJ2PtqQMExaDlScv_XojP4>
X-ME-Proxy-Cause: dmFkZTEvZtGGPVW0lccZYSWhBqmuTbjBNmoUIC+NhA02ye96S4lp+y4nbEvbjj8pIxVmzb
    OnaEgtHTuOtG0y4dvT14EEl2ZLUNPlevNZvQvkRC4mZfkAW8yo+BmwF4CUP+Wj4GViMPg0
    UgO5pzKbZMOkrEhFANA/z8OcHGZ6heczRR35Jht3v+y3SeQ2DW9R/wqs4+qgPhRrQVEvYJ
    maarRMsqGU9VX2M8WDI8iNWmGB220An9dQImJCk/xZFyo8Y4eUwY+Xx3uv3hGgO7B3/NjF
    KFY31L77E5pwJLu5QF7yEA87Jxgg+1oKmrWERx8/1mt3UzEWHMpEGPZeBzXOtviSDtAbkm
    3NPZNgWYv57A76uFk/Ky6RIxNuURtd7Ll7UufzCDVmG0cDCfrr2L+TtTtQSWGXPKP5q30H
    s2dJKEl4E0gwzSXaUXdGE7sMtqTfw5jiHjCZYvYUqJ1OaBg/H09vbL319C5uFuIq+X8wM9
    ZS11atH5nVkOgtXn4zjpHYjeWOTuGyTdNHxuHhLnkWNcRuPPMyu5Dsiob1kZfSF/hIKhRm
    bDABgOcC3xybWkEVZ31Y6Bns5kdelMWd5/1dkOtVlNyeulfGe1wgEZYMTZdbCqz9rscBJe
    N76xFAQgtxaZcVq3j8qWfcGOyb0XcPo45ZsKjwPxNkTWatY04BguXEZ+3ChA
X-ME-Proxy: <xmx:1jOcapMiXnm26VkHsbGsdTJxJ-MHuqYN_hoZNJIie5zlQ-Z4YKvCBA>
    <xmx:1jOcapGHvs5ToU2j9iu3P2ocA8cfHJeRjXLq_R7azAtu0p-FYKDh_A>
    <xmx:1jOcanRYlPBy9zBhBPrEQ7WbYojXwx_tWSbuV-NxuVkO_D0oQx77Lw>
    <xmx:1jOcamspyy-bzi47V5fTDZ2sXlgUkqL2ox1S-NvkVs6ypuVGCiR9xA>
    <xmx:1jOcavW1XkAiBS9E6mBhUB2AKAMLoOP9iMNUwkZJ1IIIvXUCI-QF-dA->
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 11:23:02 -0400 (EDT)
Date: Sat, 5 Sep 2026 11:23:00 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= Avila <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] ci: use system asciidoctor
Message-ID: <20260905152300.Zo2Zl39n@teonanacatl.net>
References: <20260902071113.GA70165@coredump.intra.peff.net>
 <20260902071613.GB641414@coredump.intra.peff.net>
 <apfWhYF6nmcFGKE3@pks.im>
 <20260902090146.GA1791728@coredump.intra.peff.net>
 <apfzihj-1YAhn5lT@pks.im>
 <20260905140217.GA3914642@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260905140217.GA3914642@coredump.intra.peff.net>

Jeff King wrote:
> BTW, after having dug into Debian versioning for another
> patch this morning, I bothered to look at which
> asciidoctors they ship. Even Debian 11, which just went
> out of LTS, was on asciidoctor 2.x. Ditto for RHEL8, which
> has a 10-year cycle (it hasn't been 10 years since
> asciidoctor 2.0.0, but it luckily was released in the
> right part of the cycle).

FWIW, asciidoctor in RHEL and clones is part of the add-on
EPEL repo from the Fedora project.

Being part of EPEL rather than the base RHEL is largely why
the version bumps happen in what is otherwise a relatively
static base OS -- EPEL is run by volunteers and allows for
pushing breaking changes a bit more liberally than RHEL
itself.

(Asking free laborers to be on the hook for backporting bug
and security fixes for 10 years doesn't go down all that
well, unsurprisingly.)

Looking at the Fedora/EPEL asciidoctor commit history¹, it
looks like I pushed commits to bring it up to 2.0.20 for
EL-9² before I stopped contributing.  Those changes have
never been pushed out though, so it doesn't look like
anyone's really minding the ascidoctor packages in EPEL
these days.

¹ https://src.fedoraproject.org/rpms/rubygem-asciidoctor
² https://src.fedoraproject.org/rpms/rubygem-asciidoctor/commits/epel9

As none of the CI jobs are installing documentation against
any RHEL-like targets, this doesn't matter much.  But if we
were, we'd need to install the 'epel-release' package before
installing asciidoctor, perhaps something like this:

  diff --git i/ci/install-dependencies.sh w/ci/install-dependencies.sh
  index 10c3530d1a..119e12041d 100755
  --- i/ci/install-dependencies.sh
  +++ w/ci/install-dependencies.sh
  @@ -32,6 +32,10 @@ alpine-*)
   		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty cargo >/dev/null
   	;;
   fedora-*|almalinux-*)
  +	case "$distro" in
  +	almalinux-*)
  +		dnf -yq install epel-release >/dev/null
  +	esac
   	case "$jobname" in
   	*-meson)
   		MESON_DEPS="meson ninja";;

> I don't think that changes our conclusions. Just adding a
> little bit of research for posterity.

Ditto. ;)

I'm happy to see more Asciidoctor support.  It seems to
produce moderately better output than Asciidoc, in my
experience.  Though I admit I haven't looked closely at
Asciidoc after development picked back up a little to add
Python 3 support and keep the project going.

-- 
Todd

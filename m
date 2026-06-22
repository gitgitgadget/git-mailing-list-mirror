Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404225783C
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782105354; cv=none; b=EyivEi/1GaDgfjE5lCpgKyfZbfqkQW9HT222q/DQ+yCTaVq14KA4b+IQiqZylYjyHrrj/Xhx9vE5tD/Q7to2Fe8+najOuTQ3T4Rac6+aR3AUDj20qknryRqlDmntAuCpL6u+ns+d0eMs4KuMrFW6xhJpum+jTdZNeXD6rFa1uGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782105354; c=relaxed/simple;
	bh=4Uqqov/2Bv2T2A/5O2KFuAEwZhhR9dd+qkeY6i6KMkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gc4SC3HfUC4BbO9XhnAm6hSrCAlMgXJQfhsZ/pZKFlLV+qGi+IuiCJpRQm5h+WeMqDQr/3UWfmkBAxC1Rg4cBoo+sVq6WH5lMx+S1AAy/2lzz0ihgotFn0/bgotOWQFOGqxCPMhxpjkAevS63mal119omF5ZFC2Wnm2OL9PWYsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VnLe12l7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZALWY8K0; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VnLe12l7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZALWY8K0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7AF8F7A0101;
	Mon, 22 Jun 2026 01:15:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 22 Jun 2026 01:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782105352; x=1782191752; bh=d/3ubysV5F
	/MnyamJz2sjHvtzOQvPXyUJmA/9u1U+5k=; b=VnLe12l7s5kD7AqsyDS3MADaGU
	W5776VF5mlalnPrhqOvpB0Lb4dyzqHdj7NZVW8jSRGbTZ5wRTWzgi8mYvOS85gWv
	Z7RlUVk/iFryFYTF07/l3qifVyo7HDy6wp9oW6QkcvlKlw1K8asvQN4GYjeYJndo
	IFtVufCIarJS8Ztm5gSM8SpBre6R5b/GAr5tvIv2tNkD+gHwtAqKTyelHjXFtKd8
	6V5ps7iux+ZvYe/gqMdLmVdiEHSc9x/Y1zzFh1QgtYYpCk3wtmVgWkMRidBwcxWf
	DAvG7Kiw/5DFHtVBYt3sTnYRi4ObCBkCDYZuBbYkIn+UqO6a+CpjHdCxroMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782105352; x=1782191752; bh=d/3ubysV5F/MnyamJz2sjHvtzOQvPXyUJmA
	/9u1U+5k=; b=ZALWY8K0uZCadyOrurvCW1+qSDeqSJXZWsca0WfW+ZeV//xIsgw
	EPZzcNiW2cTd+MPlDgnKNupKazN6s/Q5IuP6gPRV4EtS22Wl36V/VIPrxWq077vf
	fIeL38xoLN0Vy9kCWJv+++AMOVfWUdWuUgQZU9jyVv7De/FNP66E0DhTIynkPfkl
	A61yUKziOqx47V5+mlGmmvGesx00+kW4PIMQnsYGG1QxjFUvKiZ/+oD0pvpthb+G
	UGXVNhgaFZnYHakiisf11ErFXccQbWY+K3ZU6xqKR+TOnHy1PpZHG2Q4l1nlpM43
	U32m0yUN03k8EL42zX9RWZ2HZhI5JYywsmQ==
X-ME-Sender: <xms:CMU4avBsGOFm9fUn3qj-8iTwKQ6aVmDTyxttD0ndZ3F03dShLhnPyg>
    <xme:CMU4as_5Vwjsk_glbIx7uCMShrSnsAJ7osdQM7eMocz8sXH3D9oq8InZkhE2kyjGj
    RTK2SFgMDXj_xxJUq_c6TeNp9dWLCGUJmYhvfJhsB0MFD3B-QL2aA>
X-ME-Received: <xmr:CMU4an9fN5lBuCY_fABT58c6mOGxZWv9NQUoPk_nQT13aPbgUiz06_V3t6SIue2QEhzj4ZxrqEUXeyFqUiJ6w71BuOcSFzesaP2l40ODsw>
X-ME-Proxy-Cause: dmFkZTEw2cVtHo63Ej9W6YnQYDw91RhE1CQqpf0LEz10o/2RTEVVF1EFUxKZrt3jUQNAje
    iUwiIBHI1Su6fVXYH5rYDK78LE8J81UIRx8aQY2Yt8lItK3d8sbvK0fJoCWduScW9aIMIB
    ii4I9UrGiiXIPzcFJIv8pD959GavqMbi5eoX/B7vDF8oL5Qt6RN7ZLlW5LWv9yvGIOM1QA
    sy9UQAjZQOiKAvpwmCh2Ilo5jn4xLqLt+TUQo88Jn1rnDXmlWXiyifAkxpOkGoCu/6M0Fc
    CSijlONSfELxC3qA5sC9JUU+2/8T7BbUBZlATii83HZxijL4EUH/7LLjezkcyJBJMHZbm/
    u89eKHhGsLU5bP9CbomFDDO8vQBEHQ1C3kceVT/sM9z+7z6b5wI+ECalCPMPRGs0K2ssrl
    ymkv0fi9hHcw0yluDT0yxi8AcMjRshvyg6pwu0wOkHZ2oWHh/SeLlQW0D1Kxe2P7t/q+Yh
    Jjfnsa/efPFSpuAeOcHVcmdR+4d4EIrmnORKn8BXFRDfNqaFuEVvaFPYpTtCE6M/vCidLf
    gLgnHIy7xlRHJLb9lGxcCa7aIj/JUBAv+lykfHR1uzvlVxKJzwyWovkVAWY3qwxxcrk8wc
    wvetAtm7QygcsXydqLtnCzhKK7329I6XzWQuw0VTzYHrTi5GpAZ3Zj2g5fdw
X-ME-Proxy: <xmx:CMU4ardGPhBG4oK3xWgTrueTFb2CyUmgN4GVDtkPHV00UtWDJceZHA>
    <xmx:CMU4aoEBIitPJofBZQqH7tG3a9_zf5VU9raDXvg1z4yq0pXkZxaddg>
    <xmx:CMU4ahcLUjZ0-hWcgvrnw_Gi2Bbdh6CG97cT5jeKnOjZ4RjgcRWPxQ>
    <xmx:CMU4aqFs7G-DhwosVUp5AHKNTAVrcHJrSy4GYNN3qyyWFZ-DCuGmmA>
    <xmx:CMU4arqAAb0O1FLWxy644haxjFScQeY_BAa8sMbQ0954tR9ntfUuJbav>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 01:15:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3393a38c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 05:15:49 +0000 (UTC)
Date: Mon, 22 Jun 2026 07:15:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 7/8] refs: fix recursing `get_main_ref_store()` with
 "onbranch" config
Message-ID: <ajjFAjyGjk6q792L@pks.im>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-7-f4854aa99859@pks.im>
 <20260618164035.GA1218204@coredump.intra.peff.net>
 <ajTggBKIzgSpp99X@pks.im>
 <20260621211211.GA2297179@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621211211.GA2297179@coredump.intra.peff.net>

On Sun, Jun 21, 2026 at 05:12:11PM -0400, Jeff King wrote:
> On Fri, Jun 19, 2026 at 08:25:42AM +0200, Patrick Steinhardt wrote:
> > On Thu, Jun 18, 2026 at 12:40:35PM -0400, Jeff King wrote:
> > > On Mon, Jun 15, 2026 at 03:56:53PM +0200, Patrick Steinhardt wrote:
> > I actually tried lazy-loading, but I found it to be quite painful
> > overall, as the above setting isn't the only one we use. The reftable
> > backend for example has a bunch of additional settings that it reads.
> > 
> > We could of course start lazy-loading all of these. But that may not
> > work for future backends that really _need_ to parse some configuration
> > at initiation time.
> 
> Yes, obviously there's some true chicken-and-egg issues if there are
> config keys that are needed to initialize the backend. But I think there
> are many that are not needed immediately (e.g., because they relate only
> to writes, not reads) but still block loading.
> 
> For example, try this:
> 
>   git init
>   git config core.logallrefupdates false
>   git config includeIf.onbranch:main.path alt-config
>   git config -f .git/alt-config core.logallrefupdates true
>   git commit --allow-empty -qm foo
> 
>   echo "git-config => $(git config core.logallrefupdates)"
>   echo "reflog => $(git reflog show)"
> 
> git-config will report the value as true, but git-commit will not
> respect it. But this used to work! Back when onbranch was added, we'd
> create the reflog. Bisecting turns up eafb126456 (environment: stop
> storing "core.logAllRefUpdates" globally, 2024-09-12), which makes
> sense. That commit pushed the config read down into the ref
> initialization function, which created the chicken-and-egg.
> 
> Now the config shown above is a bit silly, and I don't expect anybody to
> do it in real life. But what worries me is two-fold:
> 
>   1. There are some magic variables that just won't work with onbranch
>      includes, but the user doesn't necessarily know what they are.
> 
>   2. We try to cache the results of config reads. Is it possible for an
>      "early" request like this to cache a state that skipped the
>      onbranch include, and then we use that state to look up other
>      unrelated variables? Or could we see a partially completed state in
>      the cache when we lookup a ref variable?
> 
>      I'm not sure. The actual backend lookups use the uncached
>      repo_config() interface (and in your series here, explicitly
>      disables the use of refs during that read). But the
>      core.logallrefupdates lookup uses the cached version, and I think
>      there are others (some of which happen deep under the hood
>      through library calls, like calc_shared_perm()).
> 
> I tried to construct a few cases that might tickle this behavior, but
> couldn't come up with one. But I have a nagging feeling that we are
> mostly getting lucky on some of the ordering, and a seemingly unrelated
> change could have bad effects.
> 
> Sorry, I know that's kind of vague and hand-wavy.
> 
> I'm not sure I have a specific recommendation for a direction. It just
> feels like we're piling up hacks to avoid infinite recursion without a
> clear model of what config is read when. I guess if I could suggest
> anything, it would be that ref backends initialize themselves to do
> reads while loading as little config as possible, and then perhaps load
> additional config through the non-caching repo_config() path.

Yeah, I thought more about this issue over the weekend and kind of got
to the same conclusion. Sure, the current version where we explicitly
handle the exclusion of "onbranch" conditions is at least less awkward.
But I have to agree that it's still not the right fix, as it doesn't
really solve the root issue.

Taking a step back: all the values that we currently parse are only
relevant when writing new refs. So in theory it should be possible to
lazy-load all of them on the first write. This should be rather easy to
do for the "files" backend. But for the "reftable" backend this will
result in a large refactoring because we require the configuration when
constructing the reftable stack.

That's kind of misdesigned though: the reftable stack shouldn't really
care about write options when being constructed. What it needs to know
about is the expected hash ID, and any optional stuff like the onreload
callback. The write options should then be passed by the caller when we
actually perform a write.

I'll iterate a bit on this idea and will see where I get. I really
shouldn't have opened this can of worms.

Thanks!

Patrick

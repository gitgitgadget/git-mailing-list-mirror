Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DCC1386B4
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959000; cv=none; b=Am4H5+H6n3sLQnAEi+rd6b5FEIKKMEjxQrp+NUZg3T3JUekAcf1BShxZaWcuFG0uwaLuifVpryqiSgzjituAXIfGuZVfSAw8fk9CZpPm5SiN+N7PQT4V6kVG0KwX/JTNIqQXZIuoyJtYIc54qklVkCBHO5/pdlaiiDpG+PLC8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959000; c=relaxed/simple;
	bh=bESxJWahSSKZ9F7j6kYrYs0uX2gcxt882jiyQ7gcgEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DspfRw0OTaSYdLbMMUHLbmeS4lk8CwS7O+jEKv3uvcSjgaoBTv4lSJZgwglaSCkmBV0MQ4TBZn/WmQRBKzhBZPlq/MryFqgJpGi4zlb7m/lNDmEuFGrkh6uknXedcWwwZdMnGIWcoqbr16twamNbyMbu1KSssIGHndDnP9We0B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uNGGUXIK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JEGNmeXR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uNGGUXIK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JEGNmeXR"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A1CBAEC0B83;
	Tue,  8 Jul 2025 03:16:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 08 Jul 2025 03:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751958997; x=1752045397; bh=GNEPB0ujzl
	kEQIivTocIlFUSjtq8U7zavthg7v5kxFQ=; b=uNGGUXIK5bIWcDUkdVvwqN5w9t
	WZGA0Qe/MyDR+hZ34YDjfZfVmydk7StyXpjUwEfqF6SsdM7KgVskZrvJslitvgZr
	hLugJp/g1RpJd+3rZUWNyL7k81PVQ+SQA8dkg8tJhGkdBwmPs7woCG54XdGyChZV
	E/+1eworAzW94am8rfxglF8ylTCwumgHlyEdGzMnLf756wxHA5+wYXQQmXtTAHFX
	pxWdTQP51VFW1H0CoHLhrMJYYOgUmvQGDWMEv4ExvMdGbYN2DQcxN+XnWsV2Zige
	MT52jD9H/J66r9UQNoqZ7UYfFvoT4A6DDBFXByViZmEC5yBb0R8Q2cTng/jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751958997; x=1752045397; bh=GNEPB0ujzlkEQIivTocIlFUSjtq8U7zavth
	g7v5kxFQ=; b=JEGNmeXRXJyQuCMWLcOejlh+XzupYaDFKsjgANsZdzYB6uI6aMN
	ooF7QRquv3kTyirFB71NvDnd08b4azp0qCbvBzwv0JCamYcoESLnAsMwx1jINwWm
	JW7EJgSA/gKyNkOv2gpfAmil42JpF9t9nNuJY2A4ddXWiHZSX1cCJgQEMEi0E/UK
	/il9cxLx7OP1YyYuebbbLiS3K0oCHcYi15Kn+0+Y8m+vD5OIPmHbT64mGaDD0GfS
	40oNNaNbikD6EcXqKwqRhkvuZ6cWLWU7LNptpDKRtCyF0/C79Jo3uot2V688AWWL
	o2bk+/C14mSGvL1wPbGcwOZJsdVjPucVuKw==
X-ME-Sender: <xms:1cVsaMrh_4T3u1yLpWijiFhEIOz1EBLMOgW7SEXRt7KImQmPZbLSpg>
    <xme:1cVsaDZufD5P2tIsoES7nXwrAbDhpKmiC4_KVVHlPhphu4vHWA5SQpPAa31wdUUyl
    niwbk9P2qPkQpnIIg>
X-ME-Received: <xmr:1cVsaNWP92KB7rxRAAd_obgAoeg6jqAz9crM2j-SzR0T9wXjekPS6H_qmB-oSsHvmFxTtOZK2nmLyExHLJ_3ne8hCVCr_b4elWPcB-iyR7o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    elgeekveejleeitefhtdekteejlefgveffuefhgefhjeeuueejveffvdekveegheenucff
    ohhmrghinhepmhgrthhrihigrdhnrhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtgho
    mhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtth
    hopehirhgvtggtrgdrkhhunhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:1cVsaE8SBuscAxTxVq5VbYcyQJd1npQaFxdYLhtHC4E5AKiHQZUpmA>
    <xmx:1cVsaO_JqueWuwrc9rL5TRK_-35KM0Lk3z6trGSgzs08-y8QM8DxpQ>
    <xmx:1cVsaMSQvGotfTacrjUWzNSPMwTgDLDbbeYy-XVW16sUE_dDi9sbNA>
    <xmx:1cVsaKcpudfk8tHA-fcNighJGZj3sVdH0ceZ1KIznbBcKgLgSq08XA>
    <xmx:1cVsaGYHNvX7iTdaKJ84eDES2A8iwv64FQzrt7pu5VMvEahfgkqRnPO->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 03:16:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad433546 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 07:16:34 +0000 (UTC)
Date: Tue, 8 Jul 2025 09:16:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com,
	Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 8/8] ci: use Meson's new `--slice` option
Message-ID: <aGzFzw8pxZRAvtIQ@pks.im>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
 <20250703-b4-pks-meson-cleanups-v1-8-2804c2932abe@pks.im>
 <xmqqldozzge4.fsf@gitster.g>
 <20250708011249.GA547084@coredump.intra.peff.net>
 <20250708013935.GA549322@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708013935.GA549322@coredump.intra.peff.net>

On Mon, Jul 07, 2025 at 09:39:35PM -0400, Jeff King wrote:
> On Mon, Jul 07, 2025 at 09:12:49PM -0400, Jeff King wrote:
> 
> > I was just digging into this, too. I guess:
> > 
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 673b1c44b9..717bd2763b 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -289,7 +289,7 @@ jobs:
> >      strategy:
> >        fail-fast: false
> >        matrix:
> > -        nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
> > +        nr: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
> >      concurrency:
> >        group: windows-meson-test-${{ matrix.nr }}-${{ github.ref }}
> >        cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
> > 
> > is probably the right fix?
> 
> That does renumber the job titles. Probably not important, but they
> wouldn't match the non-meson ones anymore (though I am not sure if we
> even slice in the same way, so maybe it does not matter at all).
> 
> Anyway, the more minimal fix is:
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 673b1c44b9..7739bd2d76 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -306,7 +306,7 @@ jobs:
>          path: build
>      - name: Test
>        shell: pwsh
> -      run: meson test -C build --no-rebuild --print-errorlogs --slice ${{ matrix.nr }}/10
> +      run: meson test -C build --no-rebuild --print-errorlogs --slice "$(1+${{ matrix.nr }})/10"
>  
>    regular:
>      name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
> 
> with the additional bonus that I can put "PowerShell Hacker" on my
> resume now.
> 
> Curiously the quotes around the whole thing are required. If you do
> just:
> 
>   $(1+1)/10
> 
> you will get two arguments: "2" and "/10". Definitely surprising to me
> coming from a bourne shell background.

Thanks for digging into this! I probably should make it a habit to
always run CI changes through both GitHub and GitLab. :/

Patrick

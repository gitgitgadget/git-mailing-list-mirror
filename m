Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C538A73C
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901343; cv=none; b=tKJntmtpKTVOWhVQhsWEVV2VUeJdfhJaSuFI5m6NdxFEBaniO3XiiaxYGd31oHErd4lKGC8bN2+UBqSgfyggQ43LZg+2JdBexcg16tvetKJHr28lvDzXenkAtG5uuDMGVGzpzQCPEXVyEdihwvfXepFd/8fGTT2QiTwlUe+j7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901343; c=relaxed/simple;
	bh=hIcugufmCeSW+vFj2ls/bavVfaYorij1fQ/wlNOZUS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViHq9FoCun3F7KDbk93wLiEIJ4kAi7bjEmc82PFMkQm7hIynO/TIywh2G59D3jihKA5W7fTHRqKU7fwZSVUWHl1qG+N4ePKDIf1Yj/0levcz2aruira5VnubCMjYJs6VCo2yHaVbgcPzVhZF1vbnTN91pVllF2pe2XMe4KH0Dmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=arjJ1Ove; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VbwvTLhj; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="arjJ1Ove";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VbwvTLhj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 136BF1D00085;
	Mon,  8 Jun 2026 02:48:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 08 Jun 2026 02:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780901337; x=1780987737; bh=Gq4+UNTRLL
	YKMXEikgocJDwsaR7uo4bbK16H/Mx/diI=; b=arjJ1OveOpW392fDhP9FLitmgS
	tD2sNPxdF509f++iZlV+b9CuWVxRcydIamgOLfjwALDCzfYAzNUhBYLy888qPzX3
	0Ga+GmFUL3olmnlA7XJZXXKbbPsnU8abK/jwbOk7F2I+HUAcolXcyGwugBvGMZdF
	th5sW8RjUh7Ilg/N+9RsK9oN3/w318m6ZD6jC5aMCgIdfgrelKK10LrqlCCFO1S5
	sJswmKahoUOIRGwnNf87t8PaO/76vQ+xqqTjQL7wYDY3ifgqsBbTMxnODv0NlBfc
	AOcBU8p5SMcJvXjm3dhwUgUJdUe+uKDTTSw2PCMGoZ1uFQSO/ey/ooSrovlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780901337; x=1780987737; bh=Gq4+UNTRLLYKMXEikgocJDwsaR7uo4bbK16
	H/Mx/diI=; b=VbwvTLhjurQVwks3vtLO2SKzPJsGuBSBsfrYfEapy1J5TlDzjKA
	clyAfhNDTdg+d5r+CuW42RIoYP7rIMX7/tcFMjXmpaPjQ6f/F5IYRw+86m4MR11v
	04HWQ646tAShsliFwLp7n/3c4sFW8clL5pqlIHa4tbm7gw8ocbMk4B7Ces7LZjeE
	RpC4fojpZ447/CuosA+F05WSiWPTfbbcMqNHWGpS0Nnwd06UTcYvoYVznebI/617
	1WQguVqzWYwd+YfXEIU0Z0tybHXYh26Uv7A0MPN0MhI0kBQHnnhAcqLXpV5rKPWm
	HGb8w0BA+WRf9u7iSygOwJdUcYgQLgDNjVg==
X-ME-Sender: <xms:2WUmatIRO4CUGkbIbrRyw-NepRIcNvP3WJmayGMq7o2WUCZ6Zl5Pmg>
    <xme:2WUmaieyrhiivOp7A1utj7HxWyBJzxX70qOVeFKnWY2rPgjEtQoBOrEE71Lq-kl99
    H7rGi2y9z7ahjL1Q7ByAq2A0Jej2UUzt_gZzlCWCAMk4kjwCKQxEA>
X-ME-Received: <xmr:2WUmas-z2uoUxmY9bRWZ_wLcuMW4li-eFYJLtnx-B7Yk83d5uBN677d_M5HnYmEuTQSdLOToMKe-PRilMuDYXf4YUnFLxCWAw24k72V80Q>
X-ME-Proxy-Cause: dmFkZTENzn9ecYy5s7/awozxV6RfVPh7S+FUOL9Fw9Uyh7+SIeHT6mB72A8doLR207AnMB
    ymk6qzWmICWCHPgYovptp8eaFjulFr9qt0pJJX+/cQo28qd4yKbZAlZYVfA7wwZnZaKo6x
    vVv/HLz4gxDVSZdBaxfetLiA112mNb4bJgYWWXBLHcAo4pfKPuqYMtjQGhb5ae01zWE8EU
    My78/+1CKxCFxy97oTUZt/6Q4XlwIPEKN6E/5jiVEAK/XEa54U5HIVQCpdBnyJjBdmpkHj
    ucI8o4MtVEGgyMMxmc5aZk4CUKyiXe/YviexzCNUyCiLTWzJ6hfs3PH/nyp/51NGrcwkmU
    EzLxO4jdiObngkkOezixqZ6UvCY10lasjh4kmEoE0NihdQaue3hRZZpcyAGNlqqLR3a3Uz
    aFp9nxtANhLWPSyNJc8I+nrroRYKdLRpBsA7qLFp1puiJawHbtdikdd/B6e/s8EZjcvm44
    Zn/x0MRRsw/6m19JMqSOhBxD8ZXvqvejgtJY6iz6+hi+N0rEJKWz00PDkQbrv2BXEn/miV
    dXsYXfTfUjurCthMpqtpU9nS+Clk2Q4pAs+jOQvBTNlvqMpgAB8UVIHaOF9Mhptbdlxj7d
    49zkIik1KdNLt8DHZPxSQprUXOeAjncVmjlxjwk0g6fZOUfQYsLoxFW3JIuA
X-ME-Proxy: <xmx:2WUmavqnrlD3TOiPFkmyvAozRvdR3bsZ_QQGpZWB1qF-v8SAA5T2FA>
    <xmx:2WUmahCYyPnI4RjSXnlGjkYMgcxwXxneIbnEdEnfCMmLwahiNxth-A>
    <xmx:2WUmahwjlaD7UNY8sPQdBSYjGr_cExMowGxgEPybPb0tRTo9GaOVzA>
    <xmx:2WUmau32Hu6APAk-x7xN8qF4SjoQ4mcycCKIFp6R_4vdkHSzFTvo8g>
    <xmx:2WUmauV3i4gFxgzblQL7ruE5pu_qa4gGgZ8Zl0gdT9r_Ug05yfsCnA8W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 02:48:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1b1d6b5b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 06:48:56 +0000 (UTC)
Date: Mon, 8 Jun 2026 08:48:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tuomas Ahola <taahol@utu.fi>, Weijie Yuan <wy@wyuan.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 3/3] b4: introduce configuration for the Git project
Message-ID: <aiZl1ZDnX0KvWxW1@pks.im>
References: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
 <20260603-pks-b4-v2-3-a8aea0aa2c23@pks.im>
 <87qzmn20a9.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzmn20a9.fsf@emacs.iotcl.com>

On Wed, Jun 03, 2026 at 03:58:38PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/.b4-config b/.b4-config
> > new file mode 100644
> > index 0000000000..fd4fb56b6d
> > --- /dev/null
> > +++ b/.b4-config
> > @@ -0,0 +1,6 @@
> > +# Note that these are default values that you can tweak via the typical
> > +# git-config(1) machinery. You thus shouldn't ever have to change this file.
> > +# See also https://b4.docs.kernel.org/en/latest/config.html.
> > +[b4]
> > +send-same-thread = shallow
> 
> Is it worth to note this requires v0.15 or higher?
> 
> That version was released only 2 months ago, I can imagine many distros
> still ship an older version, what happens if a version doesn't support
> this setting yet?

That's fair. In case it's not supported we fall back to the default,
which is to not use threading at all.

Might be another indicator that we should just stick with the current
threading style.

Patrick

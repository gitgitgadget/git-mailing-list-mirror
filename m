Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772F4501F39
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570150; cv=none; b=bwoA7AIdZPUizFtU1MhL49dkhDC2lUOrnjIACA3qIMQjcDYhcZGXnzl1ckqkjXtX3ctwN6Hhl3xPbGyd9ildXsqcd2TThqNfm1X+TeTcjjDT+7FPD1WvLslwTjFJWLmxnmqgVylSOvaZNZtk9ZCZ9HA3mnV4nIo+ZpPk++iWERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570150; c=relaxed/simple;
	bh=euAdoq0QRLx6CXEwrsK8BIjEiXKizRlkPtuiFeFSYdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MQOMrMd4s1a0QFhhM9US3RUHLFi+t/8y0UJzV8ZJEOgvvOMYHqv6ggMrRw5FWIjq2X26hlUmxmynGi0MadQ7aGfn1VzX3JM4P3PePK4AEJMJdqf047kxY0wp6xDgLGfoEARxV7arxhG65gI2qAV4SosfhKWQn7FFQysZNwsSTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o88ElMUL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FyF9JPdV; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o88ElMUL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FyF9JPdV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AFEF97A007D
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 14:22:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 09 Oct 2026 14:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791570147; x=1791656547; bh=qfwWDrriA/
	cTO2O3uEkX0TI9fmiomXJNFeR8p8yi2Tc=; b=o88ElMULuSxGbnAZb2YMyh5ty/
	BYVAasCB6gOldF7fazeBqQ4fMrlAEFQG3wNYfHshIlWiUzt50H0Gr3ObTJn0qfSL
	+ppvTfRo5CjaLLxgpAWkS1yT6Pe6s2qiM2ow9prGVQ6UoZrgu3BMKN8LRlRoVZHY
	T1OHgxs09HH/lgOWVQ7dcvJQKbJmukHEYqJ/nP4YWG13YPZSUAwVxbcBQ5dhEE4T
	srOtJ6jkGIa8yyVo08wVnjCdAnee3B7/8eRj/IJNIwo/oCZLgE5sW436rRjiS8WW
	Crzl+sonjH7g1My8Eln2iN63lwioTBhXz2OpN1v63tKW9xHwPgd/b3WpBxFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791570147; x=1791656547; bh=qfwWDrriA/cTO2O3uEkX0TI9fmiomXJNFeR
	8p8yi2Tc=; b=FyF9JPdVmxGr3Z7fIvkGol3h7h3Ai8tvxSzqD19CRcx7c0yhgdh
	feRAC3AFO76IVQebXe5kvfRCkcL38YyFXIMR2C7zzFL8sU/L2awELqe3QE8ba507
	FhPu+8uIqi12kebnlWQvPMhwiV/mztkwOTKW4mSPtpm/JfcYyzFaV/HP0ncY84XM
	YqGFFwMmX0VNtGHrBZTTcxGbLHvNvBY3FSVccD33xKnmJQPpePY4J7dA5lyEgHJd
	SKcGDhYBWg+taqkMboVJsrVDFS66BKMWvsuqThIoFzc9l8jAtbzaDR/1pssGGROH
	LNi7vHrsd1V9davO3Fba7wD7a/B877HYwdg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791570147; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZBISiA+EE0Xva8tid3xU6UwkRHcjT8t9XgPtktG28HfwSyE
	3TKQAZ0HmvUL2VaxFbj4PJsJUVSZr9iDdJ6k1o9Ul0lro48tfW8MgIE8jPxTCUdn
	WGnU5aZ0MTH87TPluzwi5opzN/i228K2UKL7G0EOrIJVKrlw96Zh4e3acuE38HF4
	6fXFSkRVxuOiMwV82SqLOWFUClK6MSb791Gn5ZczImRL64yO89/ecubRBWaSpZXi
	dKZ80kKiPxRWcEel0T8D/s9MKHji991XtMJUpIlaZkQkfkuOc5OnUK4NYTqGGdmX
	DwaJFkJRbHGeaoFtwn4W0vZ/OvB3KMIsTo0UJvQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:KzVMVLip7TaRgQMG6ej8+4SvsvEaQ8fZ/L0wUWbSvzE=:euAdoq0QRLx6CXEwrsK8BIjEiXKizRlkPtuiFeFSYdY=;
X-ME-Sender: <xms:4zDJanyrjcm-oP-FgzXdfwLRvd101WeF5rFMeCEKlKkNEyCzMWxcBw>
    <xme:4zDJahhwgbZsVDHfAhtOFVprRMKNsO3Eq7PYqPa4QlUR2n2SKrCD5RLrWsXhHqBlE
    -NBTEXhAJGFjybMRAblc-lDRTRPXOIl-pX4kg6-IRqpEe4vrDjFLg>
X-ME-Received: <xmr:4zDJajkmNhHy7UznpvHwiifeIJLVRoGHIqNnUCp9p9iSpRQfi71jIW79eIukDYcicn0UeilJlbuTRGZ9yX2_g8qUgRSFC46ES_JG>
X-ME-Proxy-Cause: dmFkZTGjNAUBddnMlco5+8fllAVYmcUbZV5tjSbsbk3hXNes8Fyv6ibAeOAemjsqjhVvaO
    Qr2Orp1iVYqQg0S5jQtgwqkXwKoo867j+W9P0fjZtuGi1QE+Qso40C5rJWNJfrF/6gumhd
    kpHetb5x11U5PYhGFOCqupSQbmbE+/xXTL0sCAKdodgRTzhJOOzoQgGY2rwJmiXcFcOQ1z
    s6tP1aliyB3nT6KrZi0ant5GGYPUOa9cFqkcNPA+DBBia9yX9W/cjiDcNoAidWvWUEcA8V
    lIW+6mkZKtInXO7unNItL22eN1YmKBKFZ/DspTpCxRqkj5gWZA1USr63GaY1QzHJhNpDCt
    3BwRCsnFotZgls+epXoQYORLETf97tz/GAnD7R0vBbsxRN97xTTbM5u0wg+7A8OOo2B23o
    SAHWgXN5JJ19AVC8lo4nzE63mK1u5366ksWpeXo+KiuwEwaw7LfFRcPK1ncZFrlsi0k2We
    8ewPY33JiJrceApbHuc459ZuwIK/Fw6WA9ceBQFc+3z6zZYBkz5ai8X5uFEZc4cSe/pko0
    hoFcx+Pe68AWGV0ogP0hezfJOBUsIX78qKIJngpSHmA9znwONKdnx4m9DB1QETmGpgIoFy
    UscgWblV1YEFqdCNAUd74+mX0Lmn0HxBHJ7UFACnhQwaTKO/64EHdekd3axw
X-ME-Proxy: <xmx:4zDJanjqoDOUaSDzSBdCwrrdkOv5mxO2Z76NyOSaGaFtCDKJjDoRog>
    <xmx:4zDJan15gAwT0wQLLrcq-SE8dnEnotAF_lyoh6VmW-E-PlPO8GOFtQ>
    <xmx:4zDJagJoY3cKaF-iVX3h3CakB8bkv3f7HF5kaOE-t6flKGt95O2aWg>
    <xmx:4zDJanxwdzYZ7JWmX2-e-0LbXoJCRf1GwgABHzXXSlUdDvTqtSapAQ>
    <xmx:4zDJajlPDFG5TEhHkDBApR5fy1OzUHiC1Cl8Ec2TUk-oFVsHeRvzmkdJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 14:22:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 3/6] doc: git-rebase: link to new merge conflicts guide
In-Reply-To: <72b12070455aaf659eab049571451d1369a1d804.1791547213.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 09 Oct 2026 12:00:10
	+0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
	<72b12070455aaf659eab049571451d1369a1d804.1791547213.git.gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 11:22:25 -0700
Message-ID: <xmqq33ueraxq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> Remove some of the detail about how to handle a merge conflict, since
> it's explained in detail in the new guide, and there probably isn't
> enough detail anyway.
>
> Leave the steps since rebase is special and has a `--skip` option which
> the other commands which cause merge conflicts don't have.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-rebase.adoc | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Great.  There is nothing I would miss from these removed lines.  All
are already described better in the new document, with or without
suggestions I made during reviews of [1/6] and [2/6].


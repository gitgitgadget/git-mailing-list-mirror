Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312E3C73F7
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937440; cv=none; b=EDKNtUrjEzRVwHjYfXTiDfOnu1mUbTrpJiEaVSEviEoZ5aYVRzHmxcAmVh48jzXue5VvG7LvAAwZkPqHWTdB/qXn3FMWEG2ZvyuIcV/NUb/Y8LNWMmP3x7AV6WFnpYpadiWAK0Y4DQV2baE15tvK5TdTRyPXW8XI2XATq4MOI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937440; c=relaxed/simple;
	bh=JJuaIBkdAjT+nRq0yecnbrY8633YH6ptex9z9OrHyAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chFDhID9YE0FB6zaWJFcVImEg5WDKTH953JO2ggimuTORuNdgeGIfLNQuWVxwQEPU8HcxUdJ0YwojIVqemJSv+V2Vi5hgE5Du6+ParQM+rZjIbpVah2Yt7JNaX815X4Hb1Z3WgxAl8nDOjbCh3FiUsHKTatBk7BYZyedm50SlkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aPQc21hG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tfZs1ihr; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aPQc21hG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tfZs1ihr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B57BCEC00B4;
	Wed,  9 Sep 2026 03:03:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 09 Sep 2026 03:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788937435; x=1789023835; bh=6Uo4Uik9wO
	XENP1rcxWq4Rfe/XruPJ09Sv5zDlHNS4M=; b=aPQc21hGZz/Bkg/Mx5sYglRFGm
	ojgEWKRlLvQ+qKyfEi/MbdLa4rK/4xq4D1oVkqrh6g2qDBpKqpo0NCBapRKE+3By
	BwmmlfcQijb1A1QfGdcAF8VEYJ+iq5oCWBEsFU036pJUNbdTXEP0FPCk3EhvIaNm
	5Xffawb6EKR6kxaWdlf+KKQtvAI3kWADRrFzPlgsmOJ54jM+W1pvfndqlnXpi7tO
	8GhSNsQKSbJzB1rBR534rWQmZwVOk2m9o3bbYezcxR9/ycICSIC3srVodQz/onZh
	o1ISb1UbdK2Yfe0MWYPKJUp5rgx4WXCSptnY1X0z+8pxp5wm7EXE0YaJe9mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788937435; x=1789023835; bh=6Uo4Uik9wOXENP1rcxWq4Rfe/XruPJ09Sv5
	zDlHNS4M=; b=tfZs1ihrOUXwYxeHJZn29da4owEERO62cU2oPkfq6GR87vR6jAb
	pgcpWCAb2XZhJFcm/RIymh/16Hlh1V3OIv+V62r6HtXvAryucX+6nnRfrPrlMAIe
	0iQrWR0bc7BZKOAxj6BeG4gCRd1NWd17E+HLdqR1CJ7hXCmWGWP0wXlgj2OiclWS
	7dzg3xYlK96sDRlrtTXicVl/xywz/4uMxsWb4I7IerDT89+POqmXDoIPYjrgwmx6
	SDlEgESgKnFrM1/DEus6nSkLJ0oeN/dp28Qx33NR3cjSvBu2rmyxSm5Gf8MEGiua
	xRgC+eJ6FaKfo1XqHZfLyhzp2E4+ehMYDqQ==
X-ME-Sender: <xms:2wShaqf9on69TRp07bfW2jLyjxNfxIG1Yds9hhsZZidE8qbUDe87VA>
    <xme:2wSharPKbGa5L6Ncqe20h-wOofv-0gINo1yHBan2S8_ovqJJQg3bhvdYUDPkQYYBb
    PfEeU_KyEqNNX5s-WirD9Bzbck6ZiXTAVHA6NaRLHA4QXXi1XbxtBQ>
X-ME-Received: <xmr:2wShagguXd98e3ojyq4CwUVqIfYVpNFEGK5AE5vYl1bVNjn2Xrf9zedhB80oSRZ7sg-YqQ>
X-ME-Proxy-Cause: dmFkZTEi3vPitCwY0rccophpCRf8LJn9JhNksaDkw9jWK07M52vOV3j1vWZzsfhIQGUCOS
    PaBWVDKriLr+DpMBmeI6JBelqN1jHTq69E54lXo9Iw5zJvo6J5NWqf9fZq702TNITRIIf5
    WbJlQmuuooxZyz8dHoPC2UevajeW7k96IeZBogMa5SRER9YXmoOSCQdve9FdXn2W9q/TRb
    lTat8gPRAJ2yqRMIrzZhCcoZB9ZQ6gcgK25W5RfR5jJJ2/PQVtTpFftETMrFcq/jWS9dF9
    hBsLwXEMDAu/lldrrsxlKwbLvDKmBmHUENWBl23xQSwLRk6M0AduRHFJUHJn9E0BmZWzjh
    nQXfr1EatkvOVuJdqYwoLHmWuUGMqzFtKUVqqayALBcrXVZw/cj9Epk+YZ/t/LXhvBKmF7
    SIRrLxKrVSmSHivsSJ0K2j0/uj5rIz4aioVCOkINYhi2279W3jqeffe+VnwpOQuVyQK/NO
    ES/V0Nzq/LRW8S1NCpxdoUA+xauqYl0XknQdClPBk1p2YHS/+I7M9KACqFQeZxYjlnLZ1M
    KAuOOoIH8h+rkqnC6cIa5HtOtHy+V3XufRDJDPoX1glVJXTkuwsz03kpsouuI1FvEJpBjX
    MWd3I6L/Nau34zw69uSRziUgs+2/0Ho1/YAOBxd/t6Cab+j480ayxwSOgJXQ
X-ME-Proxy: <xmx:2wSham3XhwqkKEDkJGWJugoEiO6rMj0F4neWFnPwSv2rYCzkoDS2nQ>
    <xmx:2wShaijdH1MGU_JN4pE5cN2dyu5imRxU5zWQ8ikzfSoO5eOxl_fQ-g>
    <xmx:2wShaudnueQvtWP0TWJhTnKdJX4mmgANSE_B9dEV8_CcdflqDPLT2Q>
    <xmx:2wShatnaKZlcE3xSuEpUqXLm32D-MU2K2z0ivrzPnWIwI0cUJxCh_A>
    <xmx:2wShakAu-x0KdyqL4sUclU6kxkwr20Dz_LNv-LiZaaL7C1tyHPBSP1w1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 03:03:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8b729063 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 07:03:53 +0000 (UTC)
Date: Wed, 9 Sep 2026 09:03:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/11] refs: expose function to parse reference URIs
Message-ID: <aqEE14FdUFdgMNS2@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-7-6733c90ca5b0@pks.im>
 <54fc5f97-a8ed-4927-8b48-1b4c3c7b413a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54fc5f97-a8ed-4927-8b48-1b4c3c7b413a@gmail.com>

On Tue, Sep 08, 2026 at 07:17:06PM +0530, Kaartic Sivaraam wrote:
> On 9/7/26 16:48, Patrick Steinhardt wrote:
> > diff --git a/setup.c b/setup.c
> > index dfe05d9a03..3be7dac452 100644
> > --- a/setup.c
> > +++ b/setup.c
> > 
> > @@ -2069,16 +2051,12 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
> >   			 */
> >   			ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
> >   			if (ref_backend_uri) {
> > -				char *format;
> > -
> > -				free(discovery.format.ref_storage_payload);
> > -
> > -				parse_reference_uri(ref_backend_uri, &format, &discovery.format.ref_storage_payload);
> > -				discovery.format.ref_storage_format = ref_storage_format_by_name(format);
> > +				FREE_AND_NULL(discovery.format.ref_storage_payload);
> > +				discovery.format.ref_storage_format =
> > +					ref_storage_format_by_uri(ref_backend_uri,
> > +								  &discovery.format.ref_storage_payload);
> >   				if (discovery.format.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
> > -					die(_("unknown ref storage format: '%s'"), format);
> > -
> > -				free(format);
> > +					die(_("unknown ref storage format: '%s'"), ref_backend_uri);
> 
> If I'm not mistaken, we have now started printing the whole ref storage
> backend configuration rather than just the name. I could see that we don't
> actually have any variable that returns just the name part after the
> refactor. I could also understand that we can't always expect a '://' in the
> GIT_REF_STORAGE_FORMAT configuration so printing the whole configuration may
> make sense. But could we possibly improve the error message a bit? May be
> phrase it as follows:
> 
>   $ GIT_REF_STORAGE_FORMAT=garbage://hello-world ./git status
>   fatal: invalid ref storage format configuration: 'garbage://hello-world'

I think "invalid" would be less precise though compared to "unknown", so
I'm inclined to keep the wording here. I don't think it's too bad that
we're now printing the whole URI, as that may also make the user wonder
less about where specifically that string even comes from.

So for now, I'll leave this as-is.

Patrick

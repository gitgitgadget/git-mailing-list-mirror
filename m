Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8D233928
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781713; cv=none; b=g5HObQzF2Pvia/dr0pyZiWD6pgPDKwGwBPHafBGZl0gfBnsDVeQvLMfiEoVITdO0RFiZu1vzL46qdMAIri7i8eNoT4hi/0tJuBAW2J6EWAE8GWRUeNogRRd9YCe8A+2t2SEiOWEu99mNtaAoCWJq/Fj2hUjBKRCTjb01JpfcJwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781713; c=relaxed/simple;
	bh=NCm7hnOoRRx0svPkIPXsMoergU+zP2sormQ2K9f9K1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W3SyDVccoVRzBOUNQhkQq6TECXbWzwpUlqy0wfJmt0etpiMt4ew99MwRnzMIy3GLgFdj0nr4gmhm4v9/8Z/iWZBkCEYYPTAiNIQrj9WD4ZFIs3IlqbKsb1q4X4iSM+poNf6aOF+uipo013reKDLi2MdobjS2FlUFL6Mdh0q8/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B3MbWyMY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JUYubgqD; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B3MbWyMY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JUYubgqD"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 4CA4AEC0188;
	Mon,  3 Aug 2026 14:28:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 03 Aug 2026 14:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785781710; x=1785868110; bh=abMM7e0Yfb
	RAb47aZRsMIZ/eSDDW0NVf9g9HL+U78g4=; b=B3MbWyMYs4syhxI7O2XXGGYlEc
	c0we94Ee5Gc+lxTiOfw1qV0aZCQJZ2rrTBJAGWBU3awopm6eK2a4Dgh7m5lyyhxF
	KcYhZ+wkx840m+DiOETKkj9dmn0w7OMsCfjjJxDNC7y0veq0/HtUaLWXDqBJUWhO
	Vdcj8rkGhVFGXG0fLRgdUIipbfiBOM8c1pRGePkDgmFDjpumZqIPm/3LZqrA1aKV
	WKaFqm9/WdLmfql2rnVmiRLAckHXx6zqbl742LgliZBaJ2IFDlLwt/BuotWDu6Zs
	eMGSNj5hD1oAkIL++deET/oJjaqGi78acW6vlS1v6Ljm37ToILXuBPAjMqJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785781710; x=1785868110; bh=abMM7e0YfbRAb47aZRsMIZ/eSDDW0NVf9g9
	HL+U78g4=; b=JUYubgqD6PwhI9739evIBO+XPQ2Gd3gq+VcZzRSQexQScMHX2SE
	xEKDT5+9MhcIqiGoQevkjXA+nwWK2P3LwXTVBwUa2H1EZ3uhxzZDYnt1w1EvDJ9W
	W2NI3S+h+QBPTG0VQTUBvz1gIkW0rFw/YIm0Og2AxPTCPhFtPJ/e4vXFamW1gP9q
	nA/63QT8gT03eDLubPMCXZ/bvagIGQ4V4jSY9M5V74iCwcKJp4N7yYPyIdKjOKxO
	iDRclPm4w2SFAlDReoZ1jXSptMPU6nKqQZCFLepV1Ckw4IriZg3ytmMA2ISjU1XL
	3aRiX17u9O8Ef65RH5xp7YG7kS/5LGaKKvA==
X-ME-Sender: <xms:zt1waoVw4hjKQB0oM-sgjTjhE2h8kxCW1cOQ220knPQLDSY0M8gLYA>
    <xme:zt1wagSojhHIIFqCys8RoSvDcAs6FDNf5N4Es4vXgQAyvoSdk-kEDRJTZlcZMOmj2
    GZPEdfmh_M-0isVU4FZhtDoXm7WYqHgjRBi7QIq1z92nBnQXdK6T7Q>
X-ME-Received: <xmr:zt1wamN8JEm7yS1FkOOkW3cHm2yDI1pcxzKAg0_MlPTh_X7HlEkewVt8Vi1uHkJUw3Ttqe9zqPii-3qyuTFtBDpaeTuWnJMdBw>
X-ME-Proxy-Cause: dmFkZTEVHzQ84mVkLmeMtqCxoWRWIc96WLiG2/RKQsoSMqOHxmcKZFVSxG0cC1V3N3uZOj
    6Own7xaOsvz0BwoPoQIevCuCWi5svVyFVB6gk81eUWzBZGzoGMAjoQm1ti3ygBzLPS8J0U
    t7mYJcjNlK5XLJNzCeJsHwC/2kpw73Z7Xo8F9TsUTLqq8XACTGM5rXItoRUG2Kc7eJvlwH
    fCE0VBDsHb93Uzz3oQ5/zrDUK2RFitWAdeGwX4LtRSFJmhgLzHYibCfmPHcKV7gxlFe8rn
    Eh/ef9zKyXvoQQAsH4hP8DQeVjmhROwugdjwDKuAeYQ4KPRfckqzRRD8pLkX05GEyuP6tc
    6MuntRUHReTiqFv7fNt/t8jBhHQxy7gTRPQ4tJT2mnCI5pkkUNWTk9Anp6JDiLCpiLyWfq
    bEtbKPIBa35FItpxEsvZrmMGQ9es/PzRP49ydCrlkpxp2jyuf2/t0XwQuO/9n8YoQd5EXu
    4SC6LIVAqPSSB4F8J2S8dP0jczJQ26H2pan3ePhiGYrO6G92s1IeN1IASWBF38u9ltJpGR
    bSiKRFqEKgQszqgW3socaTctDax0K7ApqwpOGryXhCXyghEp2UTWa54HQ3tYZwpH1+pJYW
    FtcK2cfXFPVfXHAsmoAYhgPF3v7oMzEUZALtXQjjOEF910RQ6dEyXpcvgExg
X-ME-Proxy: <xmx:zt1wauRXe1X_bfmXc1n9vgIb2MLywPlguNcE5A8pjXuwSoM8L-qktg>
    <xmx:zt1wakgTIVuQwWMnTjKtxmvgiAsFo-4Wx72CIx86l-EiSIx4GUpxtg>
    <xmx:zt1wan8E-EmPAv6KftRlhkgCUiCOH1RmVGBJSRsmUEtbM6fkLZ1Upg>
    <xmx:zt1warF6wKdX579-bnvenAToaEMdLr3E2Y0IwtljPyJttjBekdU6AA>
    <xmx:zt1warFytfhVyJYzqnFVFfyXk6paacBqcVEXPB9pL2ozv_0UctQDi6pO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 14:28:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  karthik.188@gmail.com,  peff@peff.net
Subject: Re: [PATCH GSoC v3 4/8] fetch-object-info: use dedicated struct for
 the results
In-Reply-To: <20260803-objecttype-support-v3-4-7176fecf7950@gmail.com> (Pablo
	Sabater's message of "Mon, 03 Aug 2026 16:39:31 +0200")
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
	<20260803-objecttype-support-v3-4-7176fecf7950@gmail.com>
Date: Mon, 03 Aug 2026 11:28:28 -0700
Message-ID: <xmqqwlu7xdmb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> fetch_object_info() collects information about N objects, but it stores
> the results in an array of object_info. That struct holds the extended
> parameters of read_object_info() (The optional outputs the caller wants
> filled). Its pointers tell that function where to write the answers for
> a single object. object_info is not meant to be the final storage, and
> since fetch_object_info() does not call read_object_info(), there is no
> reason to use it. Using it means allocating one scalar per object per
> attribute just to have those pointers somewhere to point at.
>
> Add struct fetch_object_info_results. The caller sets the wants_* flags
> to say what it is interested in, and fetch_object_info() allocates one
> array per attribute. A set wants_* flag means "asked for", while a
> non-NULL array means "available". The caller releases the arrays with
> free_fetch_object_info_results().
>
> The object_info_options string list is no longer needed. Filtering
> against the server's advertisement now sets local ask_* flags, and
> send_object_info_request() turns those into the v2 protocol option
> strings. remote_atom_map[] existed only to map those strings back into
> atom names, so drop it and build remote_allowed_atoms from the result
> arrays.
>
> free_object_info_contents() loses its only caller and is dropped.
>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  builtin/cat-file.c  | 59 +++++++++--------------------------
>  fetch-object-info.c | 90 ++++++++++++++++++++++++++++-------------------------
>  fetch-object-info.h | 28 ++++++++++++-----
>  object-file.c       | 10 ------
>  odb.h               |  3 --
>  transport.c         |  3 +-
>  transport.h         |  5 +--
>  7 files changed, 88 insertions(+), 110 deletions(-)

The direction this step wants to take us looks good, but at this
point we only support "size" and the client side starts parsing
"type" only in [6/8], while the server side starts advertising
"type" only in [7/8].  If the software at this step talks to a newer
server that does support "type", it will hit BUG() if the user
requests %(objecttype), no?  IOW, introduction of "ask_type" smells
a bit premature.


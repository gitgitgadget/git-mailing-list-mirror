Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349516EB65
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314791; cv=none; b=UtGjdPH41GPO44c144EJSFkgMHGCWjNA0rj35Xzu3kp7EVF2rpG4J+RPuU3V45mzJ4z4hc8IiieJeZ+OfCjhYKwHVY3g8ODnIgfzemcDQxbh1zLcp2Vei7sZqbszmGorL7mA/kREEi8+pPkpFC6d+TLuzZREYCkUGvKxb1NFrfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314791; c=relaxed/simple;
	bh=tx33HaoWyhNoaZi/Lu/LF6Fy8joK6IIBoOSDh+Znx5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbgERy2ppMFBjsyS6/lLlITAC1jT1JQ6g8bmIBYW78XhO2QVkKZyDztQ8J9W2eqLi4/3gRioY9W+DlJe+Ww/EpB6Y8YWMxQ4uT3aP5DJVU5nShAQva7CishfVj/qR3VvK0ghXiV3qumcFG+0kY0JGN5TV49xaEnoe7EBAJJ9a3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i/onXffC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S+8FAGZN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i/onXffC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S+8FAGZN"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BCAB91151C0B;
	Thu, 22 Aug 2024 04:19:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 22 Aug 2024 04:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724314788; x=1724401188; bh=Jo8G7+sZvb
	0kp2ThinC6QscZwHfPArUQtVAiuGL+N7o=; b=i/onXffC9Ncti+c9pK4IS8QkD8
	BYEoWBylvpK/IA+THnm2mLywLyT5W3ScCO1z2zY8y1f5rKjcVjjOSp/W7e/K9pc6
	PkqGe+tvAGlngo9ssCOWzt45rb9eKbjhUfaFjXKQ0hN3MXpxCuu8DycyTnIybzRb
	TQKa8NuX1gTkYqHHhP2tmMhK2rEmap3ZHG2hfnb53PzO5yGAQGE0bYT6R6esnVmq
	kkUut+wDowwCkH0zfsRmAId9A5d9LG6ZAgrJpKMFoHv2IV/nTMoJ7ancPD6n/I1Y
	puaG/cGSRHi1em9HUUkH4EUYZV+T0kqyRZSCOT+VU9N6eZenvocfk8cp0lvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724314788; x=1724401188; bh=Jo8G7+sZvb0kp2ThinC6QscZwHfP
	ArUQtVAiuGL+N7o=; b=S+8FAGZNrzXTSidAGcQ3dTB1To6Uhpq73b4rGrDxAtMY
	k8Rq41Wa/sh80JabonLj4cafTxhuQGrtjKM1winbG6wiKvkrsuHzPOhK8AU+5E2z
	pGbcWq0ASO0eHY8RgEmRZ54l8IlarbkL1NeZlyPnE1pWADq1MjJ8LRJ/cwI6r9RZ
	3vSX46e10fa+4vxeR5FSpQIqo7/Cxsoes7Jf/POXFx8w4voBtQOOfL72CZ/LWkz/
	lCzVAHv9EL9VBJ4oxrOCrzo9idwi5LRxUeqGdoVwestKx9IN0ZzarSgkQ+MRSdpL
	lrenkypClzZhvCf/cqchGiYQTmw+7H/1DexX2QoykA==
X-ME-Sender: <xms:pPTGZsD_cJOgpcVirBFkm0GaJxtWnpQxk7HyvDlX5Gl9PcVvQsKSJw>
    <xme:pPTGZuiA2dknhNixpVc157SoXNUtUWB8Z7fWos-N9UD7bLuc13zjOK_z7uw1sAe8S
    RRGdQz65Oi5Xd0TVg>
X-ME-Received: <xmr:pPTGZvmqrCiS3r1ujmVX-3lRAm3FIRUwquT8I5UkxzAXcOEwWf-bOSsqF6Qs2UeMTZkeYXrp3qjYZc_FbIBKzMtT6yABokOdcOppyO_2x8EvDcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:pPTGZizuj0PfNNmUED_xyY7KSY4bylrVsSj2M-i299PapvL9t6ZuJA>
    <xmx:pPTGZhS1FwlJBKXSGRZU2gvIoW_89SJdVma2fLBKHMvPOEeledBz2Q>
    <xmx:pPTGZtatHvMlN9LDXUDUsy-_FVerqM1u5_IWnfv-DgZRt8Rps3YI6A>
    <xmx:pPTGZqTZI1yQ2Qrq-W9E40WD4RF094PiCvQlzY_65p8rlnRbjHrSVQ>
    <xmx:pPTGZsfQNDp1nWSrmk5ZbQiAFBzCZRotu8BtsJoJTBtcXKOnOQanoCtt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 04:19:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bc986cd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 08:19:13 +0000 (UTC)
Date: Thu, 22 Aug 2024 10:19:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 15/20] remote: fix leaking config strings
Message-ID: <Zsb0nspisMs1Csl-@tanuki>
References: <cover.1724159575.git.ps@pks.im>
 <97346d6f944e3587a08d96a5e1b4ead8df8a0bc0.1724159575.git.ps@pks.im>
 <xmqqy14pycyo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy14pycyo.fsf@gitster.g>

On Wed, Aug 21, 2024 at 10:58:55AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > @@ -2802,6 +2809,7 @@ void remote_state_clear(struct remote_state *remote_state)
> >  	for (i = 0; i < remote_state->remotes_nr; i++)
> >  		remote_clear(remote_state->remotes[i]);
> >  	FREE_AND_NULL(remote_state->remotes);
> > +	FREE_AND_NULL(remote_state->pushremote_name);
> >  	remote_state->remotes_alloc = 0;
> >  	remote_state->remotes_nr = 0;
> 
> As remote_state has two extra structures embedded in it, I wonder if
> we should be clearing them in this function, but possibly it is
> cleared elsewhere or perhaps in a later series?

It is not yet part of any subsequent patch series, mostly because I
didn't happen to stumble over such leaks yet. Both of the rewrites very
much are leaky though, and would be hit when we use "insteadOf" or
"pushInsteadOf" configs.

The `struct branch` also needs handling and is being populated via
"branch" configs.

> As the focus of this step is about strings that we obtained from the
> config API, it is totally outside the scope of this topic, even if
> it turns out to be needed to clear them.

Well, these are being populated via config strings. So I'd rather fix
them in this commit, as well.

Patrick

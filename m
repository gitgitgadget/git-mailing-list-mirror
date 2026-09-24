Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0923793B1
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259131; cv=none; b=O/IOI9nuMO9hM+KYh36nI5r9cP4AStLMMLabJ+eh8hHLtSRkEpHtFBK5VO2LEgq9y4ykDDTnhXwEOFU061oWq3oLMiiZGsiV/rpypVW2pXhMY3Dly1Ovys0O9Mck5O4yH2z6yqyXBb4YmGRBsQ8xSoAtDbTkM7UzOOns2eF9+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259131; c=relaxed/simple;
	bh=bHuqwMyJRQCQ9l36NeGHAEUXwsr/MH4nz8MNrYVS3/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwxWJ0sLmcxzRtiV6+SB6IevOgEAZ89R6CfPYbdVJ1DURMOaS7VaA+nkzDSpGXpH4nj9PYj4npgchmXgLGeNAppCAzdtN35ogpyOi+7JJ8zIzIYicMRC2yTQ1TPRNuE4dc4ioNs4uz0+j+WwjKEf0J1CX5BF1SXYX7fsfHBN2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lv2s29zG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vkxwJ5f4; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lv2s29zG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vkxwJ5f4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B5C0F1D0007A;
	Thu, 24 Sep 2026 10:12:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 24 Sep 2026 10:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790259129; x=1790345529; bh=t3DkCuTmsn
	TdhXWhKdqCKIKoXoBjbx2PKuQKSE+mfQk=; b=lv2s29zGtX9DZ9QYH9J+q/szlG
	s7EPaFcve+pvWTJiZxVg57Aiz6Gyll8lZmoiCMGiLImc7kI2tTuvD7aFRgBt+8kz
	FTRW6vDHnVq3VoYSVqwH21eY7YUILjcIv616tKpeHHqsucpMQZ/zBgzztMYX4Agl
	RtLsBRSgP0/DF+BJBvtXa/A2TdlZGqHFerZcMNb/xTK5/wHvYOnNIB92b3RZfTou
	Hz8ewi8YBw4VvwyOElgoODE8EcAo0taR1YGAJR2vBnCwoTfnU5WvJD+Q29BEsxy+
	f23gjFLiEjAwh9uPIcWW8lw158cHkY5L/L03Im0WzsGmWZ21OJ+kQgbQb3VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790259129; x=1790345529; bh=t3DkCuTmsnTdhXWhKdqCKIKoXoBjbx2PKuQ
	KSE+mfQk=; b=vkxwJ5f4NvzsbdtGDp8K+wSF+AnLlThSV43d36w5D7scyV/lA48
	7JDgOMxyGpJcCRfL0Dn331bR1y+Lc2FBvRw4E9mjulSVWdg6RVIFeVEUU/jWLrWo
	8N6D7fZ+zENAyabalM0CeK69hFAqir62r3TX39pRT1ZUOHbEPtiIARqnh6sh8kNp
	OT6l86l7Mgu7X38nvj5sk92FJfYHCffyyjccTxUft0DlnSYL/JYED86J0nhw+LmQ
	LthWAELO34Z/I5GXISoPLFW5lCLw6Sxg0nDJUZcpAqkrluNRWq3HAnj9T+pfvKwx
	NaSQO93HgErMwkzqlMlpatL0j9dZHT33xUQ==
X-ME-Sender: <xms:uS-1aiAFJ7O1W98DTlZ1orU17frZk6TxtzLRuKWTFIlWZrG-8p2nfw>
    <xme:uS-1ajbV5OpbhIAjR8jI25Gf1cK4HG0eImzciLriI1fe1D3nbDrCi4yzc8YfyT7lx
    qE4A-iT4gMyc7pIDeLZZC-AXuhpPUA0LVzXn6Fi4oFSKf9zShRTgA>
X-ME-Received: <xmr:uS-1at7e15_SqsAmPT5ijeivUtMD4WQbRcy1M-7TKzuqbfJT7uGJ29PM-yqAc8zk88VqPzg>
X-ME-Proxy-Cause: dmFkZTFbNETnJOAaKiQyvjDAwBEffioJwbZYokWe3+GPGfYQ6ii4YK61vtCI8M/rfzB/tz
    OcDlwDIDQLL8nxeXv7pB8qLiV9kmGCaJq6ezF6euAAnQqzhVVVNu3urdppF7VSQVzX7QRb
    CCHkqEwCsFXENiITu5pmp8bgaK9puwwgDvt35IyRvuXg9UcIuF/jwyE9JJF64dCEv4t6Bp
    L4svZ7BIs+VfBpy7xROgk2u4ARURCzH0dF2anAOydkxMe8tRNJBROVjV5mHg5xr8EHCEMm
    3WiXMrOoo34V9RvZqhtIfxNFW2VZq+R2F1xX5WfRkHznOk1U2K5J99b1rVULvTXOnoK4Y6
    tUd/OR+MMo6eBBF0k8xt8I/2Ntdee++eUibHA/CRJ8F2YAneQGBmfbqJw/X2jBdoV1x0wr
    z6RWayhIfl8idRri85Roi+3ICfb9+jr9CctCd6KylouTbVzm00yK2y+WPO3mDFAYy8dgcy
    ODbBzlZj0UEYf0w972qpnWD1sRlmycvBzr6xlmE04BYU6eqOddRVyORqjOaMdch+D43nUo
    UkTO+5IXYnrmJWwAEv9nGMDlurNq5nzSqv98b+1yrgdw3UcvF7Ubu6sHiecDfuOZNxGjP7
    QAkLi3DB4g1DEa8EanHB1pCFJiwzYFtA56Wz+8cLxf8gncOeT22zor5Tln9w
X-ME-Proxy: <xmx:uS-1asaCbn-o8rbvb19W35KQNd44DAR0-ZBTb5sPCdq5B0UmaWp2eg>
    <xmx:uS-1akhPKQO3RVMsIya3waPZe2vbOamb5evYC5-BQsyjbRa7yIK0Nw>
    <xmx:uS-1al_LLQC-sACCNI7_k9UehqMgam0Y8BoDJqdtaOp4jQ_FsKF4fw>
    <xmx:uS-1ano5BGxa5id4G8_14zJaqi6wMKbd5gcZJOZsintKy6lqR422Mw>
    <xmx:uS-1at0GVLhUMMmcllXuN6MvfqeffF4kAWICEQiefZogIMaDPkTq7OMR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 10:12:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1168900c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 14:12:06 +0000 (UTC)
Date: Thu, 24 Sep 2026 16:12:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>, git@vger.kernel.org,
	peff@peff.net, r.norouzi@proton.me
Subject: Re: [PATCH v2] reflog: fix default expiry periods
Message-ID: <arUvtE67n5_MFM4C@pks.im>
References: <20260922165433.591551-2-pushkarkumarsingh1970@gmail.com>
 <20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
 <xmqqpky3ahvo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpky3ahvo.fsf@gitster.g>

On Wed, Sep 23, 2026 at 12:26:51PM -0700, Junio C Hamano wrote:
> Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:
> 
> > The default reflog expiry periods were swapped when they were moved to
> > REFLOG_EXPIRE_OPTIONS_INIT() by 85658275702b (builtin/reflog: stop storing
> > default reflog expiry dates globally).
> >
> > This caused reachable entries to expire after 30 days instead of 90 days,
> > and unreachable entries after 90 days instead of 30 days.
> >
> > Reported-by: r.norouzi <r.norouzi@proton.me>
> > Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> > ---
> 
> The above reads very well.
> 
> >  #define REFLOG_EXPIRE_OPTIONS_INIT(now) { \
> > -	.default_expire_total = now - 30 * 24 * 3600, \
> > -	.default_expire_unreachable = now - 90 * 24 * 3600, \
> > +	.default_expire_total = now - 90 * 24 * 3600, \
> > +	.default_expire_unreachable = now - 30 * 24 * 3600, \
> >  }
> 
> and the fix is very straight-forward.

Is this something that we want to fast-track for Git 2.56?

Patrick

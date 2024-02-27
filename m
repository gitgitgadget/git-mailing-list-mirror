Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D563F56745
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078019; cv=none; b=dlQSZ3Q5VrzLMQKk4jFhSYowlEzAFKF0Ja4Dn9+lR7fR8McLOJGspR2g34jkXLiYdPzRxHXAxz5g4FqgOMabuBs7i1aPVUwT1oAu91dNGd0YHeQplp9NnpD8ClqRKpKToTaBs5jdI8tsG5EH+yVJeLI9xx8nWVWClvgPy7mJ2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078019; c=relaxed/simple;
	bh=jaJw/iKFiOdvbEhlYvLQKUd4EEX5LogYqguQRH+OCzA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=BP8rdeReq/hGN1G6ySY/ghMCUJRxppBRRbaSAGMvo7h/LGRRtaqm/oXR1/l/tsYMp1sMKef30J7y75wkdbO8AL/AsIJBEJlzB5vMQ6AU7tAXCF/s8AF+oNIM/j8+cWuXB1k3oaD3h67KaiFRJ90jj1d016NPXeuRyccVoaAJBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=mpvdAbni; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bbjLwrRO; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="mpvdAbni";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bbjLwrRO"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C07C411400A1;
	Tue, 27 Feb 2024 18:53:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 27 Feb 2024 18:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709078015;
	 x=1709164415; bh=jaJw/iKFiOdvbEhlYvLQKUd4EEX5LogYqguQRH+OCzA=; b=
	mpvdAbni18rQkQGOqFj+TAT46SfBDCVYguZ/xLhd/EkZ2lh5/6uaLoQ2SEQ2B9wK
	ul0ze/I7pP7KMl111STr+iNhXGeQhB1kd2Ikm5EBq+mi7d6mLx6LIVNF42kFTFUk
	91SIUe/gLjkTS3y4Ppy0HoHMNAlaWdkUE8pmp1tbFH1X8Ci7U+TvR+pdZmj9A/Pc
	IHQTaYEAFdFziklhErhjnmX3Oy4Do4Bf1tHo7nPRyfx5tbyfi9RrJneRlw6h1UoG
	dBbJwtRy3W/hnihs4uHtT1GyNg8M2oPgngkosaqpj7sWst7RKLN61eq8fGPCO7b6
	vXumqT/TNH9LS0j3+ZNx+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709078015; x=
	1709164415; bh=jaJw/iKFiOdvbEhlYvLQKUd4EEX5LogYqguQRH+OCzA=; b=b
	bjLwrROH+zkue3kJW2F3fJdYCyoXxjIG8RX7eZSIDLR2ZTwlpRfRx36vO1VwnfcZ
	LAhqpK43x1xqmxcarVcjs2oV83WEZf2+huB3WzVJduvvSM58MEQZy2f8prCMG64N
	KzOsv2Wj68dejNP9591PgrROjk/+36Cb0cfCW1VcXAxbZMPRdqg2sWeXMN6xXqAA
	vmWpDQvZ5uLy/j8VnFsrfbDzBNBLevteQml4O+Z7m2/TEjHgFM8M9qFbTt1oecJG
	AQ7CLGzBfZUiBbW+49qylkjEdM3o48wmQRMingpNA87QFWbuOVhV2qCvLUR6VJZt
	XvIELIHCENPX4kSAebFRg==
X-ME-Sender: <xms:_3XeZU-bn_8LRdw9TnLxNOjOwWQknaquYnrzaQ26JK7R276rYJvYXg>
    <xme:_3XeZcs2SDP5p9FWmKGvwDlLYOvR0aY5-2o4vT6JN91ExnErGUQ1daz5GR0IsIFpe
    RD8yk_3IE-xJ6bd6A>
X-ME-Received: <xmr:_3XeZaAOfjuEaJMcNCYwrqshaaQ0XMuddNidCw6ABeVl3x4tb2zMQyCiraNfR_jc4Nj-ix8v51jqCCuce9QMNk6QzGNUOS_Tw2DGp4ld>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeeigdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegggfgtfffkuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgrmhgv
    shcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrthhtvg
    hrnhephfetueehudeltedtjeekudelueeihfevheeugfehhedvieektedtvdevgeeileet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmh
    gvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:_3XeZUdmMxZWnqTI_xZBdLkpGGe7IuiZSAcs-SRCHZN8QYWDVE14XA>
    <xmx:_3XeZZMafrlaf3FjgppilxvZrJ7ek6LWLKoEbzOW38O7rTURH7u4ew>
    <xmx:_3XeZen--8DYZahNLvFNEXQ1QtC9Tpaufbb3oSFoE8f-SF0lTv-sFw>
    <xmx:_3XeZSbHzByI8gnVW-MLr8qKVpeXQA6ottIT7OFLfcxspjy8VbrmJg>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 18:53:34 -0500 (EST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Feb 2024 10:53:30 +1100
Message-Id: <CZG9LAWHCYSO.1D9F91KOUYHIZ@jamesliu.io>
Subject: Re: [PATCH 08/12] reftable/merged: avoid duplicate pqueue emptiness
 check
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1707895758.git.ps@pks.im>
 <68bd6871132bac3ff8d67e908dd31647feab6bc3.1707895758.git.ps@pks.im>
In-Reply-To: <68bd6871132bac3ff8d67e908dd31647feab6bc3.1707895758.git.ps@pks.im>

On Wed Feb 14, 2024 at 6:46 PM AEDT, Patrick Steinhardt wrote:
> Now if this check was there to accellerate the common case it might have

s/accellerate/accelerate

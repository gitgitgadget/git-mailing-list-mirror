Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA6C1EA7FF
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372280; cv=none; b=lZ5moqvSxOqy9ZujeUkmgqJBudL+TxBOpr1HTJ4rOhg9Qwjc4MuexeEFM1mnSX3MTvtl4j1oGEMxHtHVg9ioG53DOfoadll5/fPuPZ/bV9pLOi57fSQz7rq5bjq4DHS6FD29eJWy8zF9MEO7+vdSNKbBZQaxTwnV9Hkq5Pzr/j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372280; c=relaxed/simple;
	bh=HYfYDNALrKn2Chi4TYwK7gATUiLhEycfzFD1rrvsrng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usQ/dd6M8B0arINjQO0/YMaXVwTfe3DLCuPbQzNXxFL69hajsPDRPxVi+AnIuRWiC/afTfk7bSbYRZVKGWAJyaEVRXELUfcVeGGbbNKi/5wW01dVuiHN5dw6wV9/jx87LwsCW0wrqjeX1S0KuB3B+PxnYiWHJsWdhmTXJ+BPhXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kokPhVBn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VpwMsjbO; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kokPhVBn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VpwMsjbO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C4EFEC0235;
	Tue,  1 Jul 2025 08:17:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Jul 2025 08:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751372278; x=1751458678; bh=fTFf12tvpA
	mDGrtMmvGuaxQp5VB+RF0qL1+b2+iK+Lc=; b=kokPhVBnTP7mR4h67ajfwgm/Zj
	SSI0iFaRdP0aHvf8jj/dYogzYfXeFy3VXu5uZdvWPYcp5SIsfrxpIAqvryr29Lel
	jfOSPlPbOEKom6+BtpgYrWZ+ll+3oUSQKjtCAc3fB/gYfSBLKrvhvpTF7je+HW0q
	UpZmSeRPd9fV81SYMDZc/XRzD77eWcKt7tQA6jWJk28X4JzcpOkcChxK5IOlpsfL
	M21XbTy9RToeH4GwBV91YtF3rsC54QJ52mD0h5r22aq5gVolTIhAFNpQTL74wztE
	CdrYkUCWjdrQr+Ev4h/av+t4V+n4D5QjmYPp2nLGV2FSID2Q0yvIJDFFU5YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751372278; x=1751458678; bh=fTFf12tvpAmDGrtMmvGuaxQp5VB+RF0qL1+
	b2+iK+Lc=; b=VpwMsjbO1Ib5B4WPGjV4e+AfWj8p2MB4H8RKA56/r/4qXTE5Z/b
	H/T8/vv77QAmawu5aU2qT19PAg339jWJYKEz6gUT5DmUdpXZ2fxzQcSpERevIYHV
	TA+pGa826fMIlcIkjpmDOuf2Uctro4irXYb8l6v1laU+JEtWWMOlje70PtI/NWf7
	DVxS1GVP2XWJ8xSB9T3i1lTLT4CdAOZs70ewT2/S902XaryZ5Racjn7bgyCefQNh
	J1B//xGSabFrfXIeLnr2uHWYwIUp/jMPL06JozEy8xH9ZJrI4xDu5TSZ8VcCwAwH
	5IIF+KdR5OV40AI3LnTJnaeO2QMJTyrdaPA==
X-ME-Sender: <xms:9dFjaBhAmh2Ar0ojL_g8kUtxVbujsyzOtlNrDog0aGIlJXt_AMTeHg>
    <xme:9dFjaGD2WF5IdWSjV6ICzXPlZ6rjSdMrbU61a99vbAcm_K0BcJOzKtv55Jws0U06A
    tmSBnnfH6sOIOCSQA>
X-ME-Received: <xmr:9dFjaBF_G3GsJfP4YVBma9OXJ8k1S40MW9UuhI8GAAwiqGx_J-hk-Sj-EhHi9FgeS9yjBL8v3__CBrqsaXcrFE3dXAG4u629JU3BOKHwIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9dFjaGTMbQPAGzodyN4G-j-wNR3FjchWKEVS-l8KvS8JKNapTCBdPg>
    <xmx:9dFjaOyi1XuRDMnPd-pwkAkZ0RWOdeQw0MYcfSJYxKMWbQtkAu3GkA>
    <xmx:9dFjaM4CzQTM1znXh1zNYe097xtcsE7910lzLkGavmmPhzpfeGOoWA>
    <xmx:9dFjaDzXVOiG8Eb-W12YQH8u6vjh9alIVG3O5DcuAClbUzuNFRPqRg>
    <xmx:9tFjaK60GOeObZR7rFdnyKRM4gcipEGa2801p8F_IcBtrza-kPOyh7xd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 08:17:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4daa9b4c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 12:17:55 +0000 (UTC)
Date: Tue, 1 Jul 2025 14:17:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v5 02/17] object-store: rename `object_directory` to
 `odb_source`
Message-ID: <aGPR8K_WxZj7jJvk@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
 <20250605-pks-object-store-wo-the-repository-v5-2-779d1c28774b@pks.im>
 <yeimqezalnffifo57opsmngxdyggu2rv53mj3plp5alx37j6pl@slkxiv4brpso>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yeimqezalnffifo57opsmngxdyggu2rv53mj3plp5alx37j6pl@slkxiv4brpso>

On Sun, Jun 29, 2025 at 09:02:04PM -0500, Justin Tobler wrote:
> On 25/06/05 08:46AM, Patrick Steinhardt wrote:
> [snip]
> > -struct object_directory *find_odb(struct repository *r, const char *obj_dir)
> > +struct odb_source *find_odb(struct repository *r, const char *obj_dir)
> 
> Since we renamed `object_directory` to `odb_source`, should instead call
> this function `find_odb_source`?
> 
> Otherwise, the renames in this patch look good to me.

The name gets adjusted to `odb_find_source()` in a later patch.

Patrick

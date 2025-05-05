Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929371C84BE
	for <git@vger.kernel.org>; Mon,  5 May 2025 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746428174; cv=none; b=SxgefVU10m+3AhDuSmpkndQvBELz6n9WkXEBFyIpGqIfRpYrwTYjix84rQMT/sHhVKNSjW9quBVRTGtqLpZLTS2lk1foy4AS76TtwvPoSldlWuz+8Me+solH/C8i2lxV+AfAgxG/nEylOeB3DavHk2f3fnIYwdNV1Nl22sWBgHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746428174; c=relaxed/simple;
	bh=54h8WXrS2YjgJZfZ/NrYdf3QDecRzFDnDNC7G69cORo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoJscGTJ/JOjBs4JIwn8DkUvBHMbETIKnnahInS64jcAZ4+CRhnXlSP8BPTLT+6H4tA4N+2CQ1hqjM5x4DYgBh16SGct+uiP9ZKUNt0APubhImSzovjlrO5LMh22Dl+/dFtLA5xOevybGovtp7/cFsFkYUskFO9Wb75l1GY4vBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KxQMtMDA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PbzW6Xk5; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KxQMtMDA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PbzW6Xk5"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id A4CF711400D5;
	Mon,  5 May 2025 02:56:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 05 May 2025 02:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746428171; x=1746514571; bh=O9ZSdMpbmg
	+OKWBtbWaxKOl45ES3bXo5KUG0LVyFLEg=; b=KxQMtMDAkSgfJA6+IszLrLuP/P
	6r5WOTsJ2uCiIltC6B+38z/eV3vZIpcWiXdNjtSNSfbs/df3pmY92CePhi+BTgu5
	asgvXvXzlTp+PyY3AFbBTeFEtkLRdYz+utqw6We+9zl6C6rGEHcOWYkelePvp9iD
	EqpEv6wiN9F9ZVZ/Ng7BLu7vbokhMXfErw3LyIU5AiP1OGTUu6z7QwnmenKdyEd2
	BKxEZU6MMCoBf/RcWolI2RqaOC05D6vBLF41ygUGd69jVaE9lsBe9dQhq/CcG2k6
	nKDBwfCrEWy5AHJkMfTWLTIDq07xmO3DNx/DGW0N3e6gmktFpxP6eU0rTKXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746428171; x=1746514571; bh=O9ZSdMpbmg+OKWBtbWaxKOl45ES3bXo5KUG
	0LVyFLEg=; b=PbzW6Xk5Qg3LFgZTI+xF1iRVS+CnqtV98hWEz17BW4vGL7c8VMy
	FkgxQCwftMDb4uE9fTMaAoxTItoSDL6EXa2Mu9noTS8Mli6daTXfr+uJ9goaw5IS
	jbxQ31MrqvIa7t5VQ9yY2gPjeMjC8BUvtc1xMNEeSN9fh8firjXesPxcAB4YP9d2
	ta9T7946zazMLd26XrcRqQEG0U/mOTU3oaO5EaSjYJ25yzounhDRRIV8O7XW/yHi
	f/nX5U76nUofCQ2nstv/sMaWRg3GVq5bDu4IOlv38Dc5ib5rfPJUKLRuEYJkz3d5
	i6FHh+JtVrXx5YxqOQozrEFEpyTnXOnVO0g==
X-ME-Sender: <xms:C2EYaJh6ttmRxLVAPpj5CbCakUxdUbv3HhUzztrjC7TrOl9HY2qB0g>
    <xme:C2EYaODe7MD2YPWJ42fS9N0YX1Wbx3eNjtTQy5PhcIiS4xWwT5okQuapDs8SzZ3ph
    4fS7ZFj7sEqERM99Q>
X-ME-Received: <xmr:C2EYaJF9-KLKXtbcQfL_A9dGd5le8WgfPHeDxFJc0UnOwm4NRP0Clo8HqFQwAS4ra6j25Xnk_bwvK7LzQyjkKVC921njp2QsX9Rxd1jP_Vw-vQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:C2EYaOQoLWmlI9M1Cb2EREDxc646_pfaCG53_hxdXToQKZz75-ZnIQ>
    <xmx:C2EYaGwFawEtepE7mipy70lpBwo9FCZfRmbNRPh9ItCAP1_7KVrGsQ>
    <xmx:C2EYaE7z5uk5bwatNSakjHXGcuL3O4I5dDttMkdd0_ZbmpTORnSHyg>
    <xmx:C2EYaLw9c3jdTEKrxmytGnrFyqnAKNk5dIdmp0MsbnRCHYWHH4a4Ew>
    <xmx:C2EYaNjANPE8QaBLt7rT51cWQTsSQWMGgGzLXi6cuoGad06GNaLoAaAR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 02:56:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d587908 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 06:56:09 +0000 (UTC)
Date: Mon, 5 May 2025 08:56:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/6] tests: prepare for a world without whatchanged
Message-ID: <aBhhCF7JpmTq78TE@pks.im>
References: <20250501225958.2947677-1-gitster@pobox.com>
 <20250503005814.3030099-1-gitster@pobox.com>
 <20250503005814.3030099-4-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503005814.3030099-4-gitster@pobox.com>

On Fri, May 02, 2025 at 05:58:11PM -0700, Junio C Hamano wrote:
> Some tests on fast-import run "git whatchanged" without even
> checking the output from the command.  It is tempting to remove the
> calls altogether since they are not doing anything useful, but they
> presumably were placed while the tests were developped to manually

s/developped/developed/

Patrick

Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A0C258EF0
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384156; cv=none; b=fCEStWDXVcLJcs2j458ZbliW0GPmn3EQtnTwxR6rA7lo5dGpAZiLyjA0FdduT9BUwo5DlfCjoBShTBOI3DFBKwHM7uoIK88Hc82z9hLUJL6bDnhXhZF6IZo4dTJdK2As0M+G1dpXUYpyD+lbZYtiFYgrUAAVPMgy668u/fAfr6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384156; c=relaxed/simple;
	bh=iA6DTjQHuDRpstNhJ7yvbFjZs/85vliEfugxrmFNgBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5M141eamRrnR1pePkSWOTWG0tz7icftRyL6aDQRGPQcyvz0xQSGr5A7F11912VkKPKjZj/Iw+QFAOwh45KGaRQHSSEeqrKsC4rpIROV6K1C5oSgfcg4E/aTbLT7IAT2Q21/RaGODvT+h4QwxerX0OgvoG++GJNl7NTtXvfUlkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iNRUkoii; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EWSzI4kX; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iNRUkoii";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EWSzI4kX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6B27C1D00123;
	Thu,  2 Oct 2025 01:49:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 02 Oct 2025 01:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759384153; x=1759470553; bh=DpOveZaqX7
	4fJGq/yhisrpSYZ3uAu+nOoEDCsE5B7ZM=; b=iNRUkoiiAHvIrRZcmYZM/2f0lj
	To/kwOzq6aMkMwHXVvM69o3f4wLMgnTG0dnWrUFnrAOt1o+DFO9om4NDrmbGJaIj
	azo023sl++c/iMou4rsNl/VkxTpS6ZeI1ATj5tx0whuYopBLdXoMHZiQtkpMvL0/
	mV5pY+F2Vfo9TVQbGKHLVJoHIzQYi5hWyxN2JOEN+C+oPbU15oAIH8R+PEBESli7
	pLgF0P8ppBQ4zJD2qxnrpcNqyXiozAbfxtOBI5xHVNAI4Cdd+e1vvmMaEaIjxOtZ
	umqr/7btWS1/4VUpo2E5c+iJmt5FZ+jsQBDq6iGmK2CDkytE9AVb2A4vfiRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759384153; x=1759470553; bh=DpOveZaqX74fJGq/yhisrpSYZ3uAu+nOoED
	CsE5B7ZM=; b=EWSzI4kXV4qvcu2LYC4eSjPR2XvlnmWs7HOwnhuV+wlcDcl8CGB
	I16H3+vNq/zJ6bTojNON8ICVqpA4DDW4SlLDLLel9VD14QawZZglt2DO/8UjX4ON
	Mp3ekUspMJsvtqNnF5repJuBt/sCuIEw2DzDqIoRvER7rDgblbnwOGnJTQ/bSKvq
	nt3+izwuaHHUFDM4XABd6Fe11BzPMGpEu80DYvbnN6Ma36GKVvaVbIxwV54bXUnT
	ZgBndGy/hKkBuKdE0jl/8EmYMMYgEHG+/qpdSKb3uhyb4StWeYd92jVWFurMwQ5o
	ZoprBSaIJ6n9zPRYKMkhUIR1VaAg03nv9CQ==
X-ME-Sender: <xms:WRLeaD1qXi3Iuf59LWhkqFBOocK4FxBujd12TK3iPL1nU1_Rxc9cWg>
    <xme:WRLeaJgBtKxrp98iIhy3ThLVNbpogngzc3sFfI_NBxdNrJzwoNBcPdDHSMm8YssR1
    EBOBYoxyCWNaCJEHYWfeu-y2dwcOr3JCYAQCUWH6WDDfc2nx-MH7g0>
X-ME-Received: <xmr:WRLeaBRGsb7clZMuWkvkG__8vZFM9u1Lc0nOqnvj5-iIR2fWQ0cBgQRONNZbUZK8qF3bjr56brf9M4ne_J7k_H4EL_pf6DGaNaft3-oFhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekhedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgv
    nhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WRLeaChSq1GbRfQIYIofE2h7NMsdkkMoUY1PH4YzH1T9UTtzV70ESw>
    <xmx:WRLeaJ5mA4mNLXuhTIGeKMaqpdj4I9m-xAkFfDsgbMBGzPG2kAkwPA>
    <xmx:WRLeaHAm3gwrMOQryUigpouGCs8WvawIgxIUnUSYLEs_7hRJ3mcBTA>
    <xmx:WRLeaIYHMg4-61ghTqMUU1uN_W7TvkhpH8cI4c9dSzIX4EncGkWwNw>
    <xmx:WRLeaF8zUJgOivHtGzORp5LGRI71qckmnbpICmAC-9DQfl3RuBqPqp92>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 01:49:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6301cfe (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 05:49:11 +0000 (UTC)
Date: Thu, 2 Oct 2025 07:49:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 3/3] make: delete REFTABLE_LIB, add reftable to LIB_OBJS
Message-ID: <aN4SU3lLFi2EROsF@pks.im>
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
 <8549f634153b1ab394a2e6630d8cc1209261a31a.1759341748.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8549f634153b1ab394a2e6630d8cc1209261a31a.1759341748.git.gitgitgadget@gmail.com>

On Wed, Oct 01, 2025 at 06:02:28PM +0000, Ezekiel Newren via GitGitGadget wrote:
> diff --git a/Makefile b/Makefile
> index d89ba03286..4c63045443 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1411,9 +1410,9 @@ REFTABLE_OBJS += reftable/system.o
>  REFTABLE_OBJS += reftable/table.o
>  REFTABLE_OBJS += reftable/tree.o
>  REFTABLE_OBJS += reftable/writer.o
> +LIB_OBJS += $(REFTABLE_OBJS)
>  
> -# reftable lib may in turn depend on what is in libgit.a
> -GITLIBS = common-main.o $(LIB_FILE) $(REFTABLE_LIB) $(LIB_FILE)
> +GITLIBS = common-main.o $(LIB_FILE)
>  EXTLIBS =
>  
>  GIT_USER_AGENT = git/$(GIT_VERSION)

Same question here as on the preceding commit: do we even need
REFTABLE_OBJS anymore?

Other than that these patches look sensible to me, thanks. Even without
Rust they simplify our build infra a bit, so I think that landing them
independently of Rust is a good thing.

Thanks!

Patrick

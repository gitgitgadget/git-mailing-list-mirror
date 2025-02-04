Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82402066E5
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738655736; cv=none; b=n3cgI6sLe9wRydkTn1zAXI+cfWwVR1TzmFmRxxK2TmXKOYbc06FlrrY71ya1o0/UQy59nN5xyu2iAbqO0Qbo4/eGseNoEZDrvIKM4FXPLevYCKZJH+2YvWGoPm/ii7rbctNjjGRfe/7K8MMrq8CPTB+krxrWgf7CSEuOYAVLy7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738655736; c=relaxed/simple;
	bh=K0aWu9IrWJRA4c65yiQGlE2zZTP2m53xuzhJOUuwZ7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUs71W3+5zVqJ5uhFRW+HrQXqoLUFM9l8hBK3Kyu/zvkM2BbDgbrgRu+DHLBqeRIqmIF2BQbux6uy4MZX1+q5HxbwjlXLRZl1UvxdNR1rt3gWkAp8QOkqjTuaHGZJBqI/e0VucLOmgmYkYV/VHgn7c0yLSyy06S6mPwuwpD0VR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tw9xADZm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w6sJKSDq; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tw9xADZm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w6sJKSDq"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2C061140201;
	Tue,  4 Feb 2025 02:55:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 04 Feb 2025 02:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738655733; x=1738742133; bh=K0aWu9IrWJ
	RA4c65yiQGlE2zZTP2m53xuzhJOUuwZ7s=; b=Tw9xADZmpQ6zQtcz3UMMSFFXv8
	2znhlELszQ48g82eV/lHLeFk9Ki0FVXRdPI47SphFGWA32nv3kca3NgPxmIF56yM
	75XsRWe4m5jIMPp8ZiafPSoQxs316wkCy80rqSuwOlz4KyXFnqmOJntkdLD7rG6+
	9JgIGn4iMIV05LVw+yAE/TU63EDfOH+AqiC3Cd+xi8mbTVSHqE+WX8rxvQFCVNhK
	43+9ONMOoch8kPRv91Skm4rf2MJwZUP4sZ3mWlX5tr+MPwOtDmxGIUn1Ps3FV9FN
	bJ6RDZ6qwtH07InPIny61PVb+/g7pCc/S2ANHfcIW7YK/cNsyrpt00Y6G3Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738655733; x=1738742133; bh=K0aWu9IrWJRA4c65yiQGlE2zZTP2m53xuzh
	JOUuwZ7s=; b=w6sJKSDq4xTe5a5DCKm7ZiSJqWYMoZFuxxlsY0TsiLZyzc1xdNI
	8eyHPdeFq6iS1WvHr6HaaDdgq9U2GAmk6DokYsvojqVvgomGI+7xPTBNDxX7XZNd
	3VYv/+lVtYU74XvtKRARqoBl5oO1BmbPQhmLPtw+ynKL81cuuRClfGPDS3qYAMpD
	Ofw8BmaRzHKPkPMUOenW9JJ9UGiiqV1Q/gLiCC0kE/M5diF2gBls9USFR4IJuHAA
	8lenGGsfMokVOlWs2ANfvxvK+xhY5XV34TjRr159DOlbUTDhqtFEyl4e7qQolmFp
	rG7y77IVuzLf9PSeUb19+fxUuubK1Rj4fSg==
X-ME-Sender: <xms:9cehZwCoh4qMeo_oXdviF_2buIEFOVHcvMo4bJT_DnufZKGirSNO4w>
    <xme:9cehZyikqATt-OYIwJKK-nVSyonSj9_d9HBbZO5PMF2M_NnHTXhUR2L-408q6bXjl
    HoJEKnLdVU0b-BP9Q>
X-ME-Received: <xmr:9cehZzktinuQmdSx6rm7eWgp9pwGsxf521CZ1Ms-X7vxbntfqcGgbjYm8ePVM0DP19OI_MPHdKc1tIyu2i2_9U_jSsi6oyfwQkMXURJBBwbipw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9cehZ2zj5SFnZIE8hgoi9SEWypNflU_hisQeYiq1SyVF3cuq7xJvcg>
    <xmx:9cehZ1ShCIXBEZP4Yjk9RVlawYHfDSokiaLBRSAMt0GsBoDENOabRA>
    <xmx:9cehZxbF9He4aM0Wxo6ezXUYgKE0-3yDVHIeXyWTNRvVrnjT2UwBFw>
    <xmx:9cehZ-Q_LzO-ODsF7IcWm0oVJCU7IlRXRBioInWmOyPX4PVQCL-qDw>
    <xmx:9cehZ3d3zIhO8_iA9QDuPCpGbrOSOVoAh9iLawh1zRD-YjyuBVFIsjJC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 02:55:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d65cdc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Feb 2025 07:55:31 +0000 (UTC)
Date: Tue, 4 Feb 2025 08:55:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [GSoC][PATCH] remote: relocate valid_remote_name
Message-ID: <Z6HH8mWDpJUSHDd7@pks.im>
References: <20250204041430.36035-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204041430.36035-1-meetsoni3017@gmail.com>

On Tue, Feb 04, 2025 at 09:44:30AM +0530, Meet Soni wrote:
> Move the `valid_remote_name()` function from `refspec.h` to `remote.h` to
> better align with the separation of concerns.

Nit: you don't only move the function declaration from "refspec.h" to
"remote.h", but also move its definition from "refspec.c" to "remote.c".
So you might want to instead say that you move the function between
subsystems, which would imply both moves.

The change itself looks straight-forward to me. Did you happen to check
whether this allows you to drop any includes for "refspec.h"?

Thanks!

Patrick

Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274902D8DC4
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229673; cv=none; b=IB8DvyG9fjFQg0DNeD38rw28vVjZ2+279+arfqvWyMDr/TQaZLiSwZZZBCxPxlCyV/RRGo9+2wYFeGmXlmztpr4g8ja3RDvKYwGA2E7LkQJCnT0mKgan7hUQGFqqcFR3T9EApUyshVsvvzRxD5YkqYdrqt6iqleOsUDFGs45ToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229673; c=relaxed/simple;
	bh=YV3kZB+G7d4hGUEe5ywNZJZKa2sEn6MgEI1s79k3gtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL7igCHERlLBG1yHeVxnhpT5NqgV2jFCg+mVdOyOY9iHxsRAomYWReKCAUch3OmQzrRO6VVBns82/iluRfMtjndKQKZGBr95USbEvfsspkgW+LuEDXuV9bUdXvhbxKiwyQqluO0TSTjjMx3bu/7iYiDf9aeOVA7KWkj9YCgResw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VCCb1VFP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R2ySz7ra; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VCCb1VFP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R2ySz7ra"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 25955EC00FA;
	Thu, 24 Sep 2026 02:01:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 24 Sep 2026 02:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790229671; x=1790316071; bh=YV3kZB+G7d
	4hGUEe5ywNZJZKa2sEn6MgEI1s79k3gtE=; b=VCCb1VFPO3lSUoEUZLd9T2X1Sa
	U5oPJhkBpIX59ErvHLnZ8lQBqCDvveC68OGNvrpI5UE6RYmrfL2Jlu+iagwdnIP5
	a89maC0xol8mGOaz4EPJPbJRRnI4UiXRiWhZGDhvE4VB6qSkWDDAyJd87CfbYyF8
	E1dOTfj3zOwe6XXk+0IjMLEnCZvOC0wL7EZN8CPTrqk1EomcNey61eA0mEgg5+kE
	zpq+OG2COfK1JbFvcqBswTQid3pYfjkwh7nJuqZiM81KJAYjwZp7C7/44EcTc0Pe
	WcjkyUkYfQbXReNnL5Mx3R4r7Dnd2ALwAO7VW+T9ADoDD+J4IdpLh4sA/pCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790229671; x=1790316071; bh=YV3kZB+G7d4hGUEe5ywNZJZKa2sEn6MgEI1
	s79k3gtE=; b=R2ySz7ra+i1GFXTtXbGffpfm3z64UkQIufiLmRK9nqfwJYuzVR1
	vviSidTFL9N3xQLejnpfSIwlrMrEu4uml1Vq3in5CbrEbkKZkb+afALHACILSIHZ
	vfaiM0Ja2fA2uTaQwuTQHHBVDcjYjKS+AOfEWRAYi78Zt5opjDtVgY+AoxgVEbur
	BEjpS56/P+x3IuVdfOuH8Tu2RURkI6eGrBWUb415b+horN6vG3gsvBinuN1hCaVr
	ES0ly0ceWpS5lY0wXkQkMGov6Hpo2SDIieb1Gm7WXOUDvoOQYzUiR1EI61RWr7bk
	ZOn065nQyAU9nVdGICBfX7rmq46Ab2N+pQg==
X-ME-Sender: <xms:p7y0anqjipDHchZad0ODw6CjWYsVM0leJm9glvkLLb-4PF6vrMfS2w>
    <xme:p7y0apEuMUxX-iocokJQaLUMoVtrFbOnSCg5j4DHJrep-77YhxFEH7AYtcLVkKCfL
    3RnvJAVAANkZkEzWjWoquJTM-D2c_bjZXrX-Vu8jRVW8-s_v_BI3w>
X-ME-Received: <xmr:p7y0ahki8YBgjqnjpKKVNSp0U7H6hJVgYaMrkHOvH9BeG1AIjFcKCWBvZaOQ-tyek_s0dEU>
X-ME-Proxy-Cause: dmFkZTEqg0GDs/zbbxWRJ+OfNqO97ZyLNyjjl6CrSrj6YsDC0eqc74fh5hADn6zs34fv0z
    EAqsYc3I8BO5KY4fxpUweFyp1sfInL69XEmHw5XvthzgX6QL9qGO7i1xtAHLcUEAQXZhM9
    B2vyD7ge38os3NWsXVA4+rq07EM/RP6aXvp6mLvKVLO8p/LXkJc6541490TNf3EYExbRpu
    AmbZfhHWxJAC1x3HixQx/oynU+NT0E20xlMJtwudZfzyzR8Ww2joPqSIMwhe3JutbyCWIi
    l6Ai5zwfkrLvzhMznTjXben0O0NwHjpvaSYNiHCq/JlbjUhpopoo1WEXw+rXujoJvCqvhK
    tkQzqlSFY3gne524fNdnJsVRQ9um4SI+fnWMt1ZEYpBp+Hyj3bkBpdn0PYgc1AdwExBdK6
    q7EJZFtNy9W6lK63wFvxduC7E6Qf5rdJQ6PXCp9q8t8+zV4+roamARJ+kEATlHeyu/sMIc
    jFSSOhAFFrvj/HAQfw+qsMMsWnrqnlA4Xs3buzrKzXrijNjJWJY2IFkHAwfhTMIu64IRzB
    UUkeEPFsjI1HH73pZ9mSndeTY98tU7EDcAAEosMNkKRGqt2POGOgnd07mxyg8wZ03aTW8c
    M7AJjLrRUtWqd2WMQtv+0nnWPWVG7pUWZL273oP+HLsHM3iKZKdLs6ET2unQ
X-ME-Proxy: <xmx:p7y0akl-JJFLzXPk4kt-ziGmKUgRX3rjI4asBDElH0HGb0_0d9kxPg>
    <xmx:p7y0aqvWrLlWlLkOWezWY11KqmuRGhgQs_xVDYhp7-7DyqPcfXsVGA>
    <xmx:p7y0avmJqpFALwL76AVE5STvKMfu_YtgWTFp0BlyZRcfImFZoQxIRA>
    <xmx:p7y0att-8coM8bUD635VlESspcpfhurIlV0DKa8m1ieaUgEU1YjBLg>
    <xmx:p7y0aujHXds2Z3K_V4uXL8SV9SEsjJIVm0iF41Wu1oI2xKDRhgeLHLX6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 02:01:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e031ad1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 06:01:09 +0000 (UTC)
Date: Thu, 24 Sep 2026 08:01:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH v2 0/2] object-file: fix packfile flush during
 transaction commit
Message-ID: <arS8oikUroITi2d2@pks.im>
References: <cover.1789328612.git.jltobler@gmail.com>
 <20260923220315.569424-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923220315.569424-1-jltobler@gmail.com>

On Wed, Sep 23, 2026 at 05:03:13PM -0500, Justin Tobler wrote:
> Changes since V1:
> - Updated a commit message of first patch.
> - Improved test readability in second patch.

Thanks, this version looks good to me.

Patrick

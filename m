Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1151B47F78C
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966051; cv=none; b=RfDZXFmXLAgA6cw3rfnS5rvW5bSIAyqVymYTprhqylEZhBF0x3qVhQAcPszv5zLbg5ZDPR5BIt/dMVle781WS2v+2J3NsWrTaZuV/Z5DAl+5NYe7iQqROQTdNtR2DRFXkiOaa9PZm028xzWlyoA8Q9KLCFrFZ0ZjAAsN0h+XY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966051; c=relaxed/simple;
	bh=Zqbo3YEnif2chvcdXH3RF2gVkipql5jP+uyuGv2Zekc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnaFKdvsZ5nVZ36Xd1LmKMChLMaOFbjJ/0I1MjEfX4gQXNRWOfHDESkyo3C04FAs5S5ECtisEFwwut9RhvlvGvg5JirR/3iH4oMkK4B083lEjFGhXCLt8sX62pmq1tLdi3xV1r8osvqYjyHQvcKyu4Ap91shmuidN+FLikm61RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=clMrrhcv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S5wXUHJ+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="clMrrhcv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S5wXUHJ+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 02230EC018B;
	Wed,  9 Sep 2026 11:00:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 09 Sep 2026 11:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788966048; x=1789052448; bh=7fMDSltPQj
	juau4shPbUUHuYBNO66uOjztQKHb3DYfo=; b=clMrrhcvAELmrdPvqllmGXdiUC
	ho91yO6solc2XtiEpBADFGyL6mYQighzHALFrjdbtaoqvPw7svwdhBVpYi3dS654
	dMKSZPkJC04WSYJKMfoFxS4/7/xCVZhOvtgPVFhTa70R/EZdbdg+O5wid9zWw6cK
	ubKNSBWshnQZxLGstA7Xx7O8IL1TyPKRfjVEPTi4dOpWn7Fd8B0MR8OATV2LhFGY
	6H/EwS0OTZzhG3TC1320WakB+b1w13QRxl/zf4l2trb7r/2ttySzH7W27I7GHSBd
	prRKtdQNMgzFIYLR5FPuDrXLsikJu0w+bB3cySGB0ISiOAiUONiug5hNX4KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788966048; x=1789052448; bh=7fMDSltPQjjuau4shPbUUHuYBNO66uOjztQ
	KHb3DYfo=; b=S5wXUHJ+BKZVJNXYbzT5094pjm3V+3ax/HGhPbTXZyzdL58dPy2
	omdaPIYI6m60krlZbc/GVAIc0ACAzyoRXEof/grlz1qwSzbF1KhO4YppBUKaffuY
	oPP91t0/Fj/E6TwqIRFeaI7lkYL9OBVq1CrnTvCySReRDl8Mlj5pIaKUiLKpfRln
	4rJicW+EyvONH5rso599jyLRTzeuCMg/IQrPzbprD+M4dV7/Lb7VJ5ggI2muSxdK
	l6St2i6VCtVMl3plFgd9jf9tLrZ1QaQE4o82xJsrar20PIMfaJbphi0rr+KcqtYO
	h+yXqzhNMNhdzxDo5ToBQMlVJfAOi7qQspg==
X-ME-Sender: <xms:oHSham6VRC938nsg7Gij3gPwvEjqDFv7ZaS_nwXVJrN_bhZPiLRFvg>
    <xme:oHShapPjycdCH5XNzK3IxIreWLRSjDSpO0L1EFC__QQBcFu4Y_fl9tGwSuYlmMWSQ
    6PXnRtTzQnVZtWEIakuN5qFU4TZ2ie5PMnCCCy9fHwolNVZmJAvKQ>
X-ME-Received: <xmr:oHShasvGZR-TT4RHSL2X_fXAUIPJNYkuBJ6ooYaGz0ahNWOim12oFcVPJDF2u7SoU6DJ2Q>
X-ME-Proxy-Cause: dmFkZTFp0u+W/aU3VuUMlO7vsAelOR0oEIrV2uMLfRqs9PxaGCsfeOxJTd/BJqlkRK6DfM
    iuIYjdoStuIOJ4ehFcHzmw4dY469LeZPDa4mVY+Af7oCFYCk9Z7ub1vt4qhBJTbDpdUQTp
    1qFIh6Luo/vnFYI5ZEUu5JhYb+lQDJQSs49hdSVy0s3IGXfAoEYbNXvHYBnVKHEra8+AAt
    wUQJDW+tItpzW0jCndoHMNnPXrOWwISYxPrzGRhaS3uIT3JbOkDjtP9sZYuWx3M1Nec8v4
    CgkXnRoSnyw5q+Jm2L8ENHm+VAs3ckQqn9EBeslB8/r+6lRnoroVahpWiZOyQIE0Ud0uWX
    YexAFJ2ikKpa+rAkVzMOXANLBKT6cQz+mxRu2KryYmenJuLdH/hoWqs2BKKFtIGpRi/EWE
    DMfnwxgEtL+0Ne5DOImumZIErNrNdalG2TYAmp8C0YNJl9f+PbcOo3zQhY1bffOFPSOoD0
    ywj3bu666p8RsFYCpPuQyXFOpK4DXYsOx/U6dhublRKSrx5Rj+hzHFHu8N7iq7ZJ0G+27l
    /L7PFzeFZmjJFRv7w0IxCaIyfKJROL9IsSZ04W6iMiTfW+WC6oSJGpfoeIn0wR8ZckATWO
    NoisQvq23wQF2axWv6ZyzKzFy2t5EK0wqkVigefP5/kh+2rmf6JN1Be2i5+g
X-ME-Proxy: <xmx:oHShakYlRKsete2Otqm_Aq0FQxept9kEid-Wuk72-eezC81nui4kow>
    <xmx:oHShamw5EUSeEjKR1hE5lXO29F1uzKglTKdYFIFG1-lBOevLEa5zTA>
    <xmx:oHShakh_SgtVgsN2_B39s3g_7GbmY0RpE28O_zRgOLFuP35qeg5DHw>
    <xmx:oHShaqm9tm46YEpbqWfTmK5-VQMt6c-XWolwuXfH13d9oOWoR1MZUA>
    <xmx:oHShamBI-aEyLOYkKenIrqavyCy-ZDA_ZkI-58aC7wo0eKdv59jXrKQC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 11:00:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 00d9ba40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 15:00:44 +0000 (UTC)
Date: Wed, 9 Sep 2026 17:00:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v9 0/4] hook: introduce the receive-report hook
Message-ID: <aqF0mbWgYU5rMR-f@pks.im>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>

On Wed, Sep 09, 2026 at 04:51:35PM +0200, Karthik Nayak wrote:
> Changes in v9:
> - Fix a bug where we were causing a BUG() when no report was requested.
>   It is perfectly valid for clients to skip the report and we shouldn't
>   fail when they do so. Thanks Junio!

It's curious that nothing has failed because of this. Are we lacking
tests here?

Patrick

Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE93DDDD2
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492897; cv=none; b=J4WqI6xbKNEpNFAjV/ezGgTPJitH/XRE7PO5QpjN2wPyML5i9JbRQzgdMJZLatK0ezLR1dP2w/jrotvZd4SCYhxf5ufZR1p3SSfHs4244oyCX1AUgoLvk67+tJl0yOH7DugAvbPDoycPBXNL7d92g5FgCJbyaacbUrRM+mS3MYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492897; c=relaxed/simple;
	bh=HXt458lDIL0Ji4TPLKuw02ARBgRyWWTHhPv5oipjSYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCpvj3TC8b/PKz1gVDjJVRotBt5WDzwOzUOUG7er1ott4HM9BsjNg1qWkpLRTGntLNDz68369MKwOGE488BCdBF0UN5h6vRaV+YRf0jXd1CysNZwpSrIoWEsL8M/0X5AaG2DPeqyFzKc6BVM0iPWUAL5xnQS6Td36j+blhVu/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h8WOZ7Rt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KK6upV0G; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h8WOZ7Rt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KK6upV0G"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 460AFEC00D1;
	Wed,  8 Jul 2026 02:41:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 02:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783492888; x=1783579288; bh=cdRgwWbnqz
	NEgyTVHFUJ7AsA69O3j8miFuZmISmK9sA=; b=h8WOZ7RtqK6m26XCeONxB+oIFW
	EMyDZ5u2ye/ecBQtOjfZT+bgG1aKhQ1e7G/OnbrMqMztMLtWdjE4iJwpMUioReLX
	mpMmewqtuzM301qmCX2Y3Y55qhOQ88Yc+dzw4RCU9Tc45xKRq+cdqKeYZBhxyE17
	xhlCdKzLLLc+k8Djpvpnh1eaLZ1WIFB/bsz0siAWMEO1FE76tdjyiFuRiYOfe3zE
	vtXkeQCng0vB45WpwJnmc+EAskcBNuK7J83Og/orfybrY2sg7a2n5I3HLdgsSo64
	NZpiP16RUlkmctLJttijKuHw52FcixHxwIYNdxzY2ezbtVJ/FiIn+R04iRNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783492888; x=1783579288; bh=cdRgwWbnqzNEgyTVHFUJ7AsA69O3j8miFuZ
	mISmK9sA=; b=KK6upV0GKcjypTcX98EBEEX3YKFK/s065X79TjWnzyf/m8/LCTk
	yu39A5v1g8lIHiZNKoy0f/UVJF/0/EWTAJUr8t7gws82SsSaMV+HjpWvyr8RVHfx
	7btKrk+25KqB470yelVoVlxOBcpe4rQhtXWathbwKq00gmddIVjE1dLlLlEee9yr
	6/ZTp6+AmwhNds17rIOP2b4JWsKyzfiQFxOm3/qwP7+uVHZw2Z/hOFPwiVcLrzzQ
	eFQZhLLuTKVKO90UAQgx3eXqI3hteW2njMltEUhYseeW+U6rs0ULnlFO7MU20JvO
	R+1TwWGlHZ7LT6QEAJ3OUJpUaqvkkiikCNg==
X-ME-Sender: <xms:GPFNamjPOIWM5OvzBtKq-ua209MMVEMS2fBb2P3GZiJm6iHSCJ3dYw>
    <xme:GPFNaue2OdkEychR_3B0CPvNMbEex7AJWKkkEjSRNJ2EhlohOA3d9sziFoa8K_g32
    nOTYTb_JZwXzSKztlgTKpR1yfLYP6X_umW52dJLyQNqjRrE5YsCdA>
X-ME-Received: <xmr:GPFNardyWHuEA3vzHxt1Z2ORp7ao5x0ZfEC4Hw7V25BRuD6j0jiQ5W86Bs3B_LoiSm1YbO0IUa33nZe-HbZh-4W8fWfsk6FeQw1OskIN>
X-ME-Proxy-Cause: dmFkZTEA3WNosX0FT2UkiEXQcmR+2qDzKOAVHm3ZFqZILulG/ECK83NBi/kQBPCuimEgdx
    4+zq8hTWVoRBTKjlq9Q42UyXEfIHIIEuP/m1GYbuRLq4+OVu7yRSb75YAla6wMZ760sSXP
    pE591Ha3r08mlFGe1y/n5+xCE7yp7GbffT/hLnSnJdt39UcSfJDIhZgIZoq9heW85t7wvP
    C66QWgjcaOt1QsPhr28YO2FlInfoUl1fv1osyvW8uA1jBdR4DeZkB/FMLKK86mWnebkA2o
    5hAFv1vHsFLpEXjlLo1RtDoqkKyPeGHCkt6TcJsOt34rGLFSR/L4iKJ6ARKjIP/0KdVZTG
    ++tlR3dZrkzkDb+1RGDyXLL+cfCFlL4BF7vJcSgoT9N1CGQ8BTMfALZamwRqFn+4+WDGUG
    uuqgamH5eka69UHjfWb8Aca93vtYanGR5GvGwIw4oU+dpaYdk/oVHAbWj5V6hTePuKo2hb
    aCWw30WLmUGys/GDhdmWCFRe11KwglbgSaJX6ivPNFTKSWk+vgqwUQNdTUQJAyHUelB4od
    BzG8094pCyMWdRAozSFQ8GdyKKBQZmwWsHCBVp8pF608PgCCcgXWBErhNj6wv+37XyILdx
    Qh9DfqsoeAaymb4RQn38pkeVrjLKhHpPjy/8nZdKRQX2z/s/SPn4uT3+wK0g
X-ME-Proxy: <xmx:GPFNao_FN1efTPLTcbu8nz_6ZVx58rj_CWZqNb9nJT2xLLRwSMGNUQ>
    <xmx:GPFNankTc8p0BusUUTXssr_MoszMlpJvGa105dtzDFtm4ejO1JxeXw>
    <xmx:GPFNaq-Bm4LT0vBrODMaKYwCtDSPhSeBbVRmZrMlL6-EPwP5GRsZ7A>
    <xmx:GPFNall74A9FBsGh58r-lQA4ZuJEBl-6y9yx6p--8zfrwvs_vfy-pg>
    <xmx:GPFNaudn01pC0Oqq5z4OMMBkEc17-94HUjH3aYoRtRNf4OdymP1FenGK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 02:41:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c4330422 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jul 2026 06:41:27 +0000 (UTC)
Date: Wed, 8 Jul 2026 08:41:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 03/11] object-file: embed transaction flush logic in
 commit function
Message-ID: <ak3xFCzvgj1-Ev_3@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708041412.1157499-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708041412.1157499-4-jltobler@gmail.com>

On Tue, Jul 07, 2026 at 11:14:04PM -0500, Justin Tobler wrote:
> When a "files" transaction is committed,
> `flush_loose_object_transaction()` is invoked to handle performing a
> hardware flush along with migrating the temporary object directory into
> the primary. In a subsequent commit, the temporary directory is also
> used to write packfiles.
> 
> Instead of maintaining a separate helper function, embed the logic to
> flush and migrate the temporary directory directly into
> `odb_transaction_files_commit()`.

The change itself looks simple enough, but this makes me wonder why we
want to change this. Like, what subsequent step does this enable that
would otherwise be harder to do?

Maybe this will be answered by a subsequent commit.

Patrick

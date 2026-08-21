Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD42931C0
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294086; cv=none; b=AI6EQ0K2XsbvRw9bcJ8EyV6kei5YUaM5rzJVnOXeqNAwuS96STk3Yau1w3+TgZ59GnRzEC+DmJ0ni8RIkk1XubV1w4A4HO8pHdCRU0mCgWz1ci/nx9Iw6wcI0iPDAzly6uvWChw3Y4gqppf7eTp/xO0ZL+mI11BacRuzmci3Tws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294086; c=relaxed/simple;
	bh=qpB+w9ysGOrI2Ar9hglH/822edwpljJB8PC9Mov1F6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVYu1ikyw9bJ4NGfV9u+O/o5nwgRpZwpBmA0BSdF0tmQU0Olrq91JxPGtuLpFuJkaWob4NIvydlgYfcvA5HeowhNXn8IHrKdrj2dNX/LLTl9CjhcPcpWXkATgkrO4N91nvdrbs1fxUKB98VV81rlqBGbF/Z46bY4mrPuSZR/ihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=epssh/X2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WBkH8+j3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="epssh/X2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WBkH8+j3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BA64EC0282;
	Fri, 21 Aug 2026 02:34:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 21 Aug 2026 02:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787294084; x=1787380484; bh=qpB+w9ysGO
	rI2Ar9hglH/822edwpljJB8PC9Mov1F6k=; b=epssh/X2ovlz8CNvT9hbmRX5GS
	TTrd+6gYqCNTy/MsdDJyc4/2ohyGgbCFjJR5K7RsKPo+B/k1aQZtvN+PiN5IwaAn
	blxC/Nc8Fp5zZhYNzzTa4aoRpa5TzKhjyfFs0ZkZNoVV/MgKHWnhbrKralw+2Hyq
	uKQTmjdmdZoJzBFbwwiQLsPRU1LXQrm4cfU1YL5cnB5GNAwjTE0EMhHfxSnTzTeD
	KQhTGbcE2KN4m0OqRm22JkgFw/uN/YmYXsQTuoMcL1c5zJOMuiMdxEgTS/sgvQyh
	MpVYNpjcMU15qSMp2fYhbyGP//yhxRemwufrnMy7CwlQsccL4QL5D1+VUkdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787294084; x=1787380484; bh=qpB+w9ysGOrI2Ar9hglH/822edwpljJB8PC
	9Mov1F6k=; b=WBkH8+j3EMLMxRjlqYjoFE9zPzJmG00SljHSH39bZE9E1ge00FD
	tHzjvQX6SwTdknq+HGoyD3NQYHDNqVXPIZXR3Dsu8kzQZNUEFa/DXXzHPIlO0sxs
	BOsHuB/pxuKJGPG6bVQ86DQ0M/8rVjdMnqweggrMBbt9NsWimGoxMWpZ1w+DWa4D
	upr+LHdCFLP0Tk8x77w3dAD+w8MLHC97DCBRCJQC/fFKkd/IBsZUjc/GfKZbdfP2
	kjMF00yqfJQ2Oj+rkCpPNzrpzDWtS6Rzbk7ndysNPS7GFB50npkv9Rtv2szo0dav
	xCr7NlqcFPxKzRBiNbCrQqwPLe6Fx9YcABA==
X-ME-Sender: <xms:hPGHauUSlXYUTe5-RfQlJrZHyPH0fFelJzC9p9giV_SKR3LpY7uVvQ>
    <xme:hPGHaiDBYB91wzfRWZIa-5VlkWz3uTcErlj6kLyPd8iqS_IV1iY1BdommxTd04dWi
    KYbfEOTP6w70K6bED2Zn-SYXHAItwEofhZd6wadCaI52ghhei5Upg>
X-ME-Received: <xmr:hPGHavwCs0cetx-5LZw4WNGKpvHB03pFGLf9Ni_9LaqTlVdbCw1AgHf5QhM_YY0a2TU902KIKE3KBBuuH8e5X01Ha4CqeHfDuSu1k_rqB55h>
X-ME-Proxy-Cause: dmFkZTEmmxvv3zr1yG10cJVoLmQkb0yU2qLTqspG79FgMv7JeAYUauXvSbCB9ojHnus0EL
    u+G5qU5SIzIxF1R2AW++rt3MAc8LiwXyoBN53cNOif13EMPdDHx20WJtt5r6bwbJ6wu1cm
    UB4xUs/TPyOjxUa+LSmmTvWN8IRD+y3TqXUsWxTYbWAmpODW8FfIf+RQTqrKsYPbu1IwMy
    BqQ37Q0mKzhSTcdSRtnphYUtAq/5JI4S9go93UKmdbSVDPHv6iipr02SOUzIBSDeAycLGA
    6wOghc4nrFo/BZjSuWLLhTRF6u0DC55Bmhw7RfXAP4sUtzrtinKD5Iyx44G2JWcjr4RTTs
    ZQZXIUmKjbSwdB9QnxIEx1dcNK8B2Azygo93m8Z7XYyna0LQXRhXqgeWX5CVhloirs+Kav
    eC6h0ezLpdcBt6x5L+0bZa2u8UcAfd7dCsbyscUa5t4UZPCUhdcGFXOPeViae8ypcEY7I3
    y+DycLy1NaFOvVrdSEC6djrBBqcrpO8sBdAmYJL2yXiNHRzLDenjZ0xZxbh17Oo0J6IxJK
    CgG5JabtkRHnz2W1Tcs/h272qJAeaHZWlpbW5PIgYXUO/vKgnlchfyN4qDm/iuyDQTHbyo
    mHaWSH1eYPKX5idr6INmCm1qw3gCLfrWD7xFkRRdWna3YJun8x/24cJSOqlg
X-ME-Proxy: <xmx:hPGHavAwAY0wgI3lmYMM-bVbbzEF-mQG7EA_AMMdPPl_BYgpE_rF2A>
    <xmx:hPGHasbxGsP7Ixb6t9W314xyBvKxQMYo6ip-t6wSqBO6jv_Yy07CRQ>
    <xmx:hPGHanhWyujpu_Zh3gJ_gImiWDMSmeBfBZwXhSPOM42W1HLvAJoFGA>
    <xmx:hPGHau6qSRyr05Gm2exS4MtiDDn323_M56QUABYXCYKVocAdfm0E_A>
    <xmx:hPGHatuXysA3hqeBnwJrI6tVFUb3k6sg0sN8KO_Irg-rdaJ7sfdCLWq1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 02:34:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2cebf1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 06:34:41 +0000 (UTC)
Date: Fri, 21 Aug 2026 08:34:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Stefan Haller <lists@haller-berlin.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] odb/files: be less aggressive with geometric repacking
Message-ID: <aofxfh2czxv8ih0j@pks.im>
References: <20260811-pks-geometric-maintenance-reduce-frequency-v1-1-7a54c42355ac@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811-pks-geometric-maintenance-reduce-frequency-v1-1-7a54c42355ac@pks.im>

Cc'ing Junio, as I haven't seen this topic in "What's cooking" yet. I
assume it must've fallen through the cracks. Thanks!

Patrick

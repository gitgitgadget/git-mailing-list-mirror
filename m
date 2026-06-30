Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B1413D8E
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824855; cv=none; b=fMXthtOTcf+CW7MtYP3dnu7BoGeDZZZss6vPLCdUTa6/QclRU0fKpAEdab46g6c4abFWOK10af/YMrGohhMAZ9s7e93R0itbHMswpkLxvw5dPBRejIweB7qP9gYIJBvc23DScVvw20KbtmKEbmkhe3yuI8qXeBvLd6mWjQMgdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824855; c=relaxed/simple;
	bh=6w+LNapS6L2RJQQTvRMt394K1FJpPeW6+5jRMxI4em8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HIEol85gyzdq5uE/oBkOnut/O+5OJyO2Ajy2dS2bNQDSm5ZFhqKjH0okKltwNMbx5/gt64kl0vNGcok+1JnwlvAlyhMSSySdEfM2Oru0nAdl55zcSeneViez/A5X2SwR0FYdv8NirH7LW7P7sF1sguQNIX/OgPFtjjfCboCzx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NcOyb5YF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BXt9/HP2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NcOyb5YF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BXt9/HP2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4F9AF7A00C1;
	Tue, 30 Jun 2026 09:07:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 30 Jun 2026 09:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1782824852; x=1782911252; bh=6w+LNapS6L2RJQQTvRMt394K1FJpPeW6
	+5jRMxI4em8=; b=NcOyb5YFaISl4DEyJB9NXJmPFCi/9q0RvTOc6UacTTbqWCZw
	V5U5E9pZcON4l7oybQkf/B0CS+5y0l9upRJpTnEHt0wUHcdxbpZfU9lqnSE1Kg+e
	4gNqhfK0CoaG3h37Lm8i3zdosHXBtvXfPiFhTUzcn56oQOOFBDIsR4jRFpv+NuUb
	UFjU72umHdnNp4NNr2rj/nIPXeT6tyiIflx2zHUqmrLsfS6f1zN7q29uSXbb8SME
	0++LBdXBpXYqWH4iXTgbaExlEOjxA4Vmrvsvk0yxPCEzLpEEA3KPAI7+tm4Jv9wp
	7KE+a7v3f0Ea/neKHMQS0QUPP+3JaXt5o3TwIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782824852; x=
	1782911252; bh=6w+LNapS6L2RJQQTvRMt394K1FJpPeW6+5jRMxI4em8=; b=B
	Xt9/HP2nOpWR0E8frqrEMQHAB4dWHesMnHXbxGqtYqWz95pFbalxl67JvTAshcyj
	L68Yr93CqcJD9+GAnbbPis06RUrYJ2kkYjtaeuKNhHiXWIwsWJqMKBOBNddvRJy/
	XDrD+T7in0lCxblOnMyxQpr9jpOShPrPmaRduy/xWD4uqWpccfaD46at4W4enJ7F
	MLfVHll9+oWolcFm4sa0HEoQmOnV96RUoW/zloezpKe1RXDJtIv58DgoNdt3cb7U
	FxCTldvkDM1PPKCRlHJGhjrvPFuEnP5ylE/U/Tbv55GGvtAuyWsC2mVVzWI30GNC
	cvAz+nUeX3bPlFnorcRCw==
X-ME-Sender: <xms:lL9Dam1gW--XN97H0BbkOi-Mcctm719QW6rgRmSbV9moLwCdazovhw>
    <xme:lL9DagARphNHEwX1NHCeko5hkteDWBF2CxR0O9qR7sUqp7i1RpqPxiCGjsK35fUwQ
    pzVs0p8w85hhH55AI3r0E73jVjxDrv9-V9YRn0Z5EGuYVsDnX7X>
X-ME-Received: <xmr:lL9DakioHblUM9cpWlMu6yZtqbgBLsAEFE05KAkgJwmtLdLNd4PFEEAarOPJBLt646QuwAgmOUrsn1gN09LHLl99aYcJ>
X-ME-Proxy-Cause: dmFkZTFHlTnaLsRaXoA//oSA58pM5SYTHSN2cUZQnC2lMPiof1EzTcHk8CtgkDw+gR1CJI
    1pewpW0oS10XgfNxGKofCDMTX0+XuzJJSFGIAdyOIhCYE3io+ZDv2/Pv/QbjVkY2VSr6eF
    3Z8v61ytKkhdxlLXhc7GGge0jnG2DVztJXN8H4XKH+usuLOyUy3NSsjgw5XeYbxELiYowu
    c5UKcWAf2swl3FZGy9RW3JOdyVjukkSsYf6rK1Up45aToCd7eCHa/wYWU30UshpQKbljqg
    l4y8rORVJkVFz+BZN3z1nxSeAZWxiLZgAFzguaBNr7glqwvXQzcaU7K4ZQTL1W+v+3WSXm
    1ZjTZYNucefs75C+iaBv69L8jRnTJfX+QcxuYxsGl6OY96bCzRx22jHFBXvlVJQQrB0FRo
    FfdMJo5S4kBBuKtPqPvBFo0EkVoV5/rEY2q0v2pFI8+hENF37neTWvTnOylXz16PBYayYF
    +f9AnkEJzOfDsk+FBK41Fmh5ghm84fDqhoZEiXtLCHxegKI3xZK3VxADS/m/reR3xmyeUx
    jw/8LP0q/1u35QVruYaqMon8T4JhpaWz1/guuR3vHwscOGa7O5nIs5Tn+nfyZwP5Hu7LKB
    sicfQ6JwlAj8QwLaDpbXohT3PjS5UJBbAn4eFFBe8WdjKuIepUS7Rrr8ZQJA
X-ME-Proxy: <xmx:lL9Das_XpnHBMRAKU3hfiDVdi0xIQ58VwHu_22anbIjDyLs3ewG_gg>
    <xmx:lL9Dao_S5l_V7EP40J1uPlmYHxrra9YoIr3oYqeeA0JpHn8alpnImQ>
    <xmx:lL9DatAN8xVWDavYThwoFPoR93GC2CSNgna9YbQN71mBEHI-OeDzLw>
    <xmx:lL9DagzLpOE0HAzgTyfQ4V0PHBxv7swLfcfK-mY8-xWpPbzkZYV4mw>
    <xmx:lL9DagG5zPQAhgkuIFMiezIkCd_-FW65jsSqlxQL7ey-9UD5xWWrhAZK>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 09:07:31 -0400 (EDT)
Date: Tue, 30 Jun 2026 15:07:29 +0200
From: Jan Palus <jpalus@fastmail.com>
To: git@vger.kernel.org
Subject: RUST_LIB dependency on LIB_FILE in Makefile
Message-ID: <akO9JTUIlHqBrgny@pine.grzadka>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20260616

According to Makefile $(RUST_LIB) target depends on $(LIB_FILE):

$(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)

but is that really the case? As far as I can tell $(RUST_LIB) does not
use $(LIB_FILE) in any way and there's no such dependency in
meson.build.

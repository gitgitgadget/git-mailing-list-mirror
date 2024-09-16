Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C96157A67
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487181; cv=none; b=Q/bQNsYujoYldW7/ZL0nYYKVFEvLG0rqKp8Kap5iOoq655h0oza6O8sB+gfWBGqVcFZBrp6MlyBA8WceYoU1jDlEa03QlfuuAYIvvlAOCCkdByYSWX8wvHexDWK3IAugoMZxOrgPSXMltLGtwC5eV1CEQeNEA19grkcq2jnNwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487181; c=relaxed/simple;
	bh=vcFvOCpQkqKmnRp8Zv+VU32U2bXShGpn4xxwP6pSGko=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU+3rmNV1JNAJRzQQOeJfjgxtOBz+mPUlwscs8lr4I4Zd/TH+T/Ra17TcxxQgc95llGzr2Yr4o0S6OBH7E7e6NV253zHSBkT/gyN4WgQHKMvq2izOM2A82R/PZiftTnuqmA7OyrHehHVdvUq+ZUeCTsNSoxY/uolpg7st8AB2wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f7hZS4s3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J3D4Zctg; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f7hZS4s3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J3D4Zctg"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58F5E1140125
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 16 Sep 2024 07:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487179; x=1726573579; bh=880qX5sU7V
	13SxS2gP5qfj8Ab5LBsdAq8B4L02JRyLs=; b=f7hZS4s3//YrJ+lVrC34/eGSaP
	LpuIIOFd0fVp1c0JkOjLUYgvXKTuWo2GKg3JZwBPd1yx0scnvZ0wHoKaF4z7h+LZ
	AmVr5JuRGOel1d72HZGytD66eWMMawF3tgdzNgENNVnZ//cfw2FmzU5Xklt8MuAz
	DCfHy6ueFseHGBJn8AXiS65MDaGGODQ9GAnd6yjwjFmEu60vU7E8il11fycQ2zvj
	3LNnP7UFg+XysYoouAdmVFnVSJWMVNjbi/AwwPeKAro+CA4xnyprmc8RyffXIFAo
	zt1NnIZjDZ8zfWIw00yukwyzkbCwS2O2w/WmRJ5scb+LdaLo1uHKj1ggRUkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487179; x=1726573579; bh=880qX5sU7V13SxS2gP5qfj8Ab5LB
	sdAq8B4L02JRyLs=; b=J3D4ZctgI+ZBuO5h5xmpO4wRT8l5N3deDO995wQQygG2
	MUoRjy8pOj/56rFZ6McHW8IVhVk9KsouOKlz9q8msjomjw0+U3dyrrOaVuEJxYt/
	vmrOO+i13GjM4UyMW+OCPek5lpUkzqnsxaoRkIjy+W1A+CE8tsnpfHjDkKvmoO6k
	JQrRU3A1s0dP9c5eqExf6Bl7QDd+uZF6XCkMJVvh2NuF39BHSau1mVM61yA+E+wj
	OOpBBAEcossPQLpWXAC8bHz2kxXygKLd1vHZRbigQfWqU9HvXzk6PYOKkJvTzBV0
	lwnl1VIOyToFtO0vGA9mmbo9FqlMpwjIGoKV3NGs3w==
X-ME-Sender: <xms:ixroZkKw1O_Q-JpYsf1kMWE88QZqo__VQ33V-1rqbcApZ1RybNvq1w>
    <xme:ixroZkJ0uDQ54lMbeFUDjgdWGXfBI8K4ohmPYa8TT0rIBV0_TIcIkPEmQn_xoOOPn
    205v2gh53zsTq6M7g>
X-ME-Received: <xmr:ixroZkskNYtQcO56WyEJQN2BvX9TJPABXtxwT7c6hzQXt1dSw-ZAADfhJIq-Xpc8K4DDdvOk7IgKH3JWEBgj-KWggAcgBOWianLHgNTof1wclQMN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ixroZhZCQ8jq-vyTm1lZtBTJkvLbdhhdDTaeoIzKHcIf8DUdD090VQ>
    <xmx:ixroZrarju5AWgVZie7J5JCbwMxfuH3Y7pTIOGoLOhHNAPOdJSqpUA>
    <xmx:ixroZtA8s2GQO6NIQJ7w7ilCvJzHWcZgUs1sylQ3-v1m0yAfujm3vw>
    <xmx:ixroZhZWUYS2y2uJdf9uWftkT6GyITSOoTJ8QcvmS2qA-U1xe3Tp6A>
    <xmx:ixroZiw6POkevx1yTaO-v2UL2xE7l-aIb5NwOoS2yD5_I2qL7VfBJLrI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7526d72d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:46:01 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:46:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 18/23] grep: fix leaking grep pattern
Message-ID: <411df7248d2868e906d5ba882f9cd9abf82eaca8.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

When creating a pattern via `create_grep_pat()` we allocate the pattern
member of the structure regardless of the token type. But later, when we
try to free the structure, we free the pattern member conditionally on
the token type and thus leak memory.

Plug this leak. The leak is exposed by t7814, but plugging it alone does
not make the whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index e5761426e4f..701e58de04e 100644
--- a/grep.c
+++ b/grep.c
@@ -843,11 +843,11 @@ static void free_grep_pat(struct grep_pat *pattern)
 				free_pcre2_pattern(p);
 			else
 				regfree(&p->regexp);
-			free(p->pattern);
 			break;
 		default:
 			break;
 		}
+		free(p->pattern);
 		free(p);
 	}
 }
-- 
2.46.0.551.gc5ee8f2d1c.dirty


Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071091A8F7B
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230424; cv=none; b=dTJbjToMyR4FHjL6HU/rQghU3ajOrED95oL/oeKo4xAPFFu/pl3i+uayhthUzu6VdqYcJdMo2DTd1tVcNeKS8WXYdvMz7EPWw0Bf3fRHEFpiFnvD8aHidb8CkYtjkGotVlAUu9TYkU/jRjFGOcUkJOqbT2W5l96dJ//92UZ+6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230424; c=relaxed/simple;
	bh=xqrh3v9SpRBkYGaqfi/l9kfAYhypRosnHwDu+A3Ovro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlY3iyi1WDQ78S9tgrNmNKSO7dJPA6a/8nKuO6Vk7eygdOeb7xkctWhsp+PbbFnMkrRkxsdWYTLe/23hA+PtX7Jy8RKO8iy0bymHjtKTYBDxtu1G6gqgI0IRLHEafh9PiGlWfxXVKTiRUUaP4aq78r5OtBVAVdCmt9BqPx2WJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JW+0UsXZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QkgiTapG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JW+0UsXZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QkgiTapG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2FD98EC009B;
	Thu, 24 Sep 2026 02:13:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 24 Sep 2026 02:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790230422; x=1790316822; bh=xqrh3v9SpR
	BkYGaqfi/l9kfAYhypRosnHwDu+A3Ovro=; b=JW+0UsXZ7DOfm52FQsbQQ8rQJ+
	OzJpukIwMfsEXNWeAxQ7aoHQnE2uTvZF887tCbVXoH2LWMd9lTRruWlXZBal17Mt
	eAjJEt/3phQcRvdfp08L60OlzqI7zUEkpsNhoVEkjAIdi0CmFGqf2hvGPSxs3R7U
	xIGSrZtNFiIN1KuP6VGEi7AtO1KWgM+SXDkrhG7LGZFqstubV4hgVK9Dq7kJxlTE
	m6fPy2BzXngRgj+GApDc3adqOR9wn/48UwgZW7fe99dZRivBj1kQdSImaKMRuboK
	z/6MQBVfkAYbQ91DlKp0BKLsue5LvPed9FCzpVeIPuIRb0ubNHjOv67Z3z5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790230422; x=1790316822; bh=xqrh3v9SpRBkYGaqfi/l9kfAYhypRosnHwD
	u+A3Ovro=; b=QkgiTapGnUs3MbboQM1FzFoO4noOleZV1IvxvcRXcLlaBM+ehC4
	4tVGe5WAyBPExoMBkrivAGn8+Z8fIOTYi8yFooWmFdQ0ysfolKPt31bWTm5Q/qek
	IsAeqaVTi4PD6nv5dAiVBF5m+5OdvhR5LaUGYiItsw0bMKBBmc/HuYmmCWB4t12M
	NScdv5PU1yd9cdv6f9pZzIshCB7NFgiMF/1wgBYk2hdYovSoPifd3SQ1tFjYsicg
	bJC+PvD7J7vqbaMmOfgif3WmuDMWGYFv8ZCXw7k6+hnL/s3D9iFJw8lMu3NxtUDK
	wMgPR+uLwpnN9UaOda9ArEmbfWkHQ+Dlgfw==
X-ME-Sender: <xms:lr-0al4FguOgCDJQtJv6VQZC8EoqucTeLcher4MnS3czCX-30ubpLA>
    <xme:lr-0aqW0qNfYRhRSfBLRQuCJgX1fh-fQG9JwaoJTdWLX5ZEA2-_EReM30Aj0nva98
    oNx30PweLJVLI0qcVKFpnKN2xGx3-u6YT9QPAIIYB3z0XnNVNLcjbA>
X-ME-Received: <xmr:lr-0ap0wuzedTt-KZj4Uw9c9yRyWU-C9vZWmVJVWWx08lgnD4JuXBSs6MzPAOMzZYWkHi18>
X-ME-Proxy-Cause: dmFkZTGVNSYmBsY1DUJIDrUoMga+7nM3JommT5cdgBAvClTMNiRJ23FT/LvWlzW8h9KxIv
    1tZo22OW6QJkYwKVQDfN950X4utuM2WRlB5eVCna40C6hiTcOVDpX69eJnd3yE++3LPHYM
    zEJTln7a0HXQ04N6JND/OKV5/x05e7kH1CTcWm11fhAm98TRnm21nQ/Sp4VkL68yVu1aah
    FxUD+fnXm9xV0AjFnkVJSRVzZmkwom7BzbRSNj8WnPgzDqrAfZ4iVqFASOlHlWn9jyZhZ/
    OiurjdcetRf2SY3mO5jVy9NMVWZ8ZzmQbwQiwaVIzjvQooEI36FnOD+kLFI3b1QKZXEGdT
    kv8H539xqfth8vhLSILGk3FqSYWB2eXTvq5iAXMYSKlazxtVSxqwVuoxBdj7Yxr2anY+TW
    Wj18bTec/p8GejfkzOVXK6WqtjaVlD/U4V4uXIpxIt5VCTz9t3X1FvC8+qBM1ngcFwbwb+
    5wOndaE6iTl4pBAOeJpiFmMFOAGRBcAxbyELI22qZw9TaSHtSB4fQfy6w1Y/z3LqWsag4p
    bK2+8ja9/5Tj/0cWu1NOsSLlem6G0DCzaaP0xdD61yRar9BRbfJqkeFCsFprxbxM47OMe8
    VzaN/vRHwwGiXW7kDqvAPCVFVuv52kRrr+OPGKyXTi38p3XhSBEQFT1FV7FQ
X-ME-Proxy: <xmx:lr-0an1E58cMbaoCQGbzIxp5KxGBfBxQGXdXq7clKUMTniMAucxA8g>
    <xmx:lr-0as_yndjTmIvZK2BI-2neceOL0M5qVosYEXE_hQlP_H6Zl_thPw>
    <xmx:lr-0ak3dy4Yi2_g3FFz7XomgCbLFuGsU2pWdm3f8MySB-sJ3A79uGQ>
    <xmx:lr-0ap9xb8QlSQNfl4F7ePUSn7tTucfvcLJTIgcbj0VxIxcqQP1U9A>
    <xmx:lr-0ajyPBG-LPtBgOnfuyZJx9cmCqIaWeKA0bIgdE1_l7WsgkUj6S34l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 02:13:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id faa187d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 06:13:40 +0000 (UTC)
Date: Thu, 24 Sep 2026 08:13:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH v2 1/2] object-file: lift ODB reprepare out of packfile
 flush
Message-ID: <arS_kcMcgrjfT9KE@pks.im>
References: <cover.1789328612.git.jltobler@gmail.com>
 <20260923220315.569424-1-jltobler@gmail.com>
 <20260923220315.569424-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923220315.569424-2-jltobler@gmail.com>

On Wed, Sep 23, 2026 at 05:03:14PM -0500, Justin Tobler wrote:
> When flushing a packfile via `flush_packfile_transaction()`,
> `odb_reprepare()` is invoked so the written packfile becomes visible in
> the current process. In a subsequent commit, flushing the packfile is
> performed earlier when committing a "files" ODB transaction, but the ODB
> reprepare needs to remain the last step.

Yup, this is more in line with what that second commit will do.

Patrick

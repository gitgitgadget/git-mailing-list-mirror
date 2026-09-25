Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A4454655
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373531; cv=none; b=j0myJ84CeR/EnR9v2RDDb5dBLRiMVi8uvvSo8q0UnRel9dDk9E5ybSI/HUgj7dJrqhH1iJ6INxrtlme8iYuEyoexLazRGA80/VZE0sU4yW/jViRxxZtH3e2B2n9Hy9YTEd2YB1S+QjIvyjU59qxO/M2Ev08fUG8QIttBPZHllHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373531; c=relaxed/simple;
	bh=t63juVCL+GE5JrAg1vO/qEh0Wms1DSzi6VkvgcljfoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cg8jc57acRqe2dj1e8GqUYZdY8xcYa0BORuYNZT6XfaRnMGD45tSYla3JhVptOJAecSYulN2uSgK8lehXXnRyXc48w/xqeaJ5xz8nkcORTpNSKuKWWsoZ+1oGIHygc1TTFZNzOTMWeEVsPXjlQhkFYRYywPn2dTioDOGZY1G3oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AoPieSUh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v5HzriSZ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AoPieSUh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v5HzriSZ"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id B8113EC0187;
	Fri, 25 Sep 2026 17:58:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 25 Sep 2026 17:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790373528; x=1790459928; bh=QMhOXKGy0c
	5UT2GonEgOBRB6ffs8iDxgZ+nz4dKoXnM=; b=AoPieSUhFhD2wXZIuqI37dugcd
	ikLnjde2nLextF45m/uugPu2/HdaN0vZa2yXwIa1ZuoyAh0Eoxthl9v46D5MMIFE
	m6dW55xAA6nAOVl1rEzXbQm/7jLP1czo2Df8wQXGpsLXGv4qj+a2z5z2Zit6xjNT
	9hD98qq56jYAlGsYvGoiXujISyJngCalMR/7zzt3fh4lQm+a/xK4CmeIXV3Hgb7x
	WcWroUM8JUrL61l33HPjbZ+VCPsBlbSz/57791i5WCjc/6rymQApYPhH8qudNMuc
	7saOvo3D5EDYkzV6GiRvycGtzhPWafppuALHfUEUUBvuXO2R4qGb70t+JwJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790373528; x=1790459928; bh=QMhOXKGy0c5UT2GonEgOBRB6ffs8iDxgZ+n
	z4dKoXnM=; b=v5HzriSZnn0+54I3ATfP/JU4H5jATS13J2dssdWO7RZIeN8wqKI
	pjJDKrmB6eiRiqKTvSw/GSXM3vm2LI95rQlBTQqPyTSyA5l9vwC3HwFnlzcArY9O
	lKEf2MjZiA4Ke+KIS+RlQqe9iln7lxdu/3C5AyserXS+ZpEtL7y69W8yAQHUAyhR
	RKD56qNY6iUjzhfMr3L4cKFuNuEZ5vDBuaDrSi3HWrq37mQuzwiUDIKZfZ9yeMWA
	K/2W941KSsGgtsRJ5WsmDf3StKhLEH1xuC8bFcIdwnycDmjfFtHwEGOsuNTHJue4
	dWEPLSMR9wn1Khcm3CmMfRiGUixdQ0LelDw==
X-ME-Sender: <xms:mO62apWmG4s0lNkxmm4Sc7EPXuQsK6a9SWGAYfi_XJK6srS2oRfkQw>
    <xme:mO62agmM-jwwmhezAJLSZ4iQYOJHFnIvl3LEQuiUEtUMWTG5HbykkpK-5n4ZKvGiq
    Y5cHbkhI8dAg3X688y1my3OEivv0_DqMYA1waZymdEXm5wIdhpw3cE>
X-ME-Received: <xmr:mO62aqbDs2Q7cU0jKJhU3jvz7_0pyslrJ7Fy_oMtObaq4GNXTBk_i2M9DHtceNjr_a_sGlNlTrIOtduAkD0nM209TIFmmUizexaq>
X-ME-Proxy-Cause: dmFkZTF/uk7n4pSM5/Ul1oVl1s3/YBsOgsmAUEM+pS98uLMlyq08WWRs+QACPCipsKVg3c
    47O6PxQSc7Da4MxGNk5pXc8EIzCsQR51gJon6dChVVzG/j6E7E2LkioPwNg6h29vS3+Xl9
    rScidUvD9CU/olQ6+zFFP9fdopVjIDN8X8ctiPLQP6Zvlku/dOfnFq9BZJEasQVC3MTBFz
    rz4AiZqeA0eJZUKZNdofoqoaU06n4ibnOJxIo9NhsYUUuAHkcU8/WL9gaGXLdrBE96dPV5
    sXMah8Gws2QV56Mit7P6Qsj5VaJSvZLA2MbtsEKqlWjx9+OBF9hwsEli1N2vVApyoXaBRk
    +C8CxIopMw2Jw2Hn4xfdbrcsDxkh7puzTxbrmEE4NRPokROHkQj2L9RmAYJwNMj+fiUD/J
    ET9K3LSLXaA2O1eEwTAzdKfin5T/7ZV4OxL+mYGNez2+HAmrXhpEXOQVWmxa2Mij9Ht+q/
    eM6PeXzEVlBosRjpVAY07gA/zINMtbsdzQ4oiNe3oRyNmCjePCFD/deJfY4BXjXgLF4uoc
    lh7HIRy9kI2lPI0GrB45RXUGPcGKTOxrNQF5G3dAOV5KmTH0iIZXR93XIWxhMzjVbgFM7K
    n+I6dwjUqCd6t8kpTuazCFl7rNOmpJIp7piEQN0qCfR9WRvP1WNQnqUsmxTg
X-ME-Proxy: <xmx:mO62arN_eYz1Sh1Bcd1XENtu2BwT63KTovSfz4DyIpE7jwXJ4VJ4HQ>
    <xmx:mO62avZmu5hfmYQZ37IbLbITPyz1lWsX_hRJ98-fegjXIvkLwm0zuQ>
    <xmx:mO62ap0oqvPYX75CnJLHYjYSpk7jP7JyXfwYjIKZfZWGQf9mgahaVA>
    <xmx:mO62aldsl74ZWpGCq3h0RHM8fW1kHMR6T2EWb_6qiD7ix6BZiSriSA>
    <xmx:mO62agbtWZmDlUPfirK4-ysGXaEk542v0bR--69-6q0wuK7skJCHyzys>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 17:58:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tyler Cipriani <tyler@tylercipriani.com>
Cc: Aleksei Sviridkin <f@lex.la>,  git@vger.kernel.org
Subject: Re: [PATCH v2] push: fix --force-if-includes when remote-tracking
 ref has no reflog
In-Reply-To: <arbfQ7xF1NgDeilU@localhost.localdomain> (Tyler Cipriani's
	message of "Fri, 25 Sep 2026 14:53:23 -0600")
References: <20260903010547.85469-1-f@lex.la> <xmqq5x0mfgyh.fsf@gitster.g>
	<20260904124433.12840-1-f@lex.la> <xmqqzexx58hc.fsf@gitster.g>
	<xmqq33vn5hsq.fsf@gitster.g> <20260906165052.21780-1-f@lex.la>
	<xmqqjyowz9oq.fsf@gitster.g> <20260909065639.47316-1-f@lex.la>
	<xmqqv78dordu.fsf@gitster.g> <arbfQ7xF1NgDeilU@localhost.localdomain>
Date: Fri, 25 Sep 2026 14:58:46 -0700
Message-ID: <xmqqfqyxt2ll.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tyler Cipriani <tyler@tylercipriani.com> writes:

> So date=0 is always correct and should have equivalent in runtime in
> most cases. And it neatly side-steps what cut off should we use?
> gc.reflogExpire vs.  gc.<remote>.reflogExpire vs.
> gc.<local>.reflogExpire vs. flat 90 days vs. do we respect
> gc.reflogExpire=never.

With a reflog that has never been expired, using all the available
information will always work with better information than with
cutoff, so that is not surprising at all ;-).


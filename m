Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293B43F4AE
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224090; cv=none; b=awVruN52Vf1WHt1o7yF3V4woEblW6b8CvuQSDLlYDuijydIJZ7vLL4CWOyY64ayMiAhJE0fSd7NRY0hNfDjcF8Rot5d9QPUe2Ykgi9AfF+ddjibYgrVt3PZlDvy0oVAeKOZKUqjFvou/phosoXeTW3I4SwXvvHwpKA3/maDJgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224090; c=relaxed/simple;
	bh=EvAVDHnCtddXNxrAZAOTgebSSHLv8df6W/x/YtUVXQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sva8QglmdN6EwleT54T6hp53M8dW8SAP7RT1LEekNNYPP/oq4tMT5es0l1wLcqbkjLaudjz5rd/7tbwiJyKryxgr/4I1jrKOmJGIN7q6uzH4rRPNep8whaoegiiVyFAfTxo1qlsc5lHSXNnaiG5l/iluQXzpmq4eWFw9B91ZfpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vmTd16t0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jL+Q5RdE; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vmTd16t0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jL+Q5RdE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 39BD214000E9;
	Thu, 16 Jul 2026 13:48:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 16 Jul 2026 13:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784224087; x=1784310487; bh=uvNwa8v7Ko
	K8vWOBquDfz0V+LPX2+T0quVmSxsTFS+I=; b=vmTd16t0kEz/hsejoQEbpxC6p7
	cuLkBWtq5EOmWZvqpb+6Vj07oCqCvyHvouX27W0yBBakhxtQ9S2ezK+mOu1soGFo
	mv/NZDRA04GvAjwlqWme0KEQB5mNjcXoRu+I+NxDW8c85RvEAhNTo/EBo6K0z/yo
	uXLUMWl5HEedsEwlmtylD5Mh1sKmsmZkW947WlEFzehFSC2TqsQhVrB7JAfDXiQO
	PlVyvLYPzsEDQqpm8GDF9Lvc/et8muz4JiBL63/BYUQ0NBh8yy27yvFEGKitL0u8
	/2YLIlTgORZ8T1zCz3YJAoRNgE5lxYmmLZ5nujCvUKvQB5/p2mdrjL0zeL8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784224087; x=1784310487; bh=uvNwa8v7KoK8vWOBquDfz0V+LPX2+T0quVm
	SxsTFS+I=; b=jL+Q5RdEUT3R/lQh3p91XdWHCGCWU6B0BQa1rs4OoMJi4SuIfDy
	/AzqzQcIEC8GJ2tpFNB69kTVZDXTI9Aby2G4gS4+u6NfdF/7FAodrqLCPshLoPIH
	o17QN3loUjcqB5Ch2KgsRI2Qh4C9QGLgUiENMRZh5Z+tKhjydtneo7jOKkCXB66u
	FSco8ypqsU+UCfLXVnsW2AIfVpQuNT8IHmMWzffCfjo/Bc5uefeFmj8gwROfCqHX
	DrncqToG3RaEi9/oalFPf8VXFgzlU3EI/sBmKqFORKiIYHmGw6IuB0rZiJjdSmi/
	WsL/AFB+HlUa3iwy4Mq0ziT3sJUmGiNSISg==
X-ME-Sender: <xms:VxlZavkX4zK_B-SKJ9v1k-gxOeh-kk5NB82rt0ysBM_Iyu_aNHbLJQ>
    <xme:VxlZap2r9RxX_EO6zko4yN1qIqhee4E_nuX2LnVWR8QX3E1uP2iNxVb584fT8ioyK
    uv9g69B_R0ZXgsW9xxygWd3EBWtpm3Zm0Rvbmx4Fr5OuSG98xo-OQ>
X-ME-Received: <xmr:VxlZaqotb9X_17DrS4DYMUlMXolQnfP2dMNNw_4WboV5bxrYTGBqwb92iG41I3vrVdnxVtmlzdIESENBt1P_j6wz9QugQcjVHcvlJZk>
X-ME-Proxy-Cause: dmFkZTENJsG12q7mtBj8npXJljYShm1edvrdtZbhwKCmpZE6Es9tC7fj3pX7eRZW2isPiQ
    Be8EEJPnAgb6DyV4l1CLkdrhNaLznymiS4tq5Qn0dHrG2UYAA8tmpfSn5mkd3iXoTmrUIE
    W0ivNzqsGw45ZkAxBOWxzjSiQDdw/KtW0ba4MzjgTGtQB98oNI0al5yQ3A/jIblfuPWUBi
    xtKfvKaO5Xjd96xGebQtalsCLOULbUPQI22h8gJGdjfIo0fdUvqOGv9Ox6MADKrcRLOn/b
    ggVOtdI/HTRiElusuqZh/4DD1L72Hy3/5E+rwNp22uItVw+zypaVUn3wPKSgdL/a1NOzOY
    kCn41X82ntuJY1BHCxvfANoLb847+3ZvV1eaGM3ueEnxtPhGHJWyL8+SN6+y8dZtXa3/Pp
    kfGoXZbwBRd/1jF6heM0Ykpd3olp7iNOqAiIk8qWk0nsC6k7xVs4nb2I2t0pFNxKVaJhqa
    DTKf+4uVgvKmN5U4K0+sXYD5SEk/mIK0dCamm5h5w0qNRxMw/SM7ZlxG/Rl5oJ8b6VlpKO
    GzPvKIvspoNcgrdkp36/XQLgImgPM1FjnUrMtJ0J0nNtPYcX0fnzWF5vZnIMUId7rLCzET
    9fRulcnoOqKF8gr8bm8RGCZ6oaoBztvNIM54fv6LaktNAjWuTp8KfH8t0bNQ
X-ME-Proxy: <xmx:VxlZamc7NSHH-mAi3kCXgSUmH8rcRm8QDQJINEsBbwMYlEu1NwMTww>
    <xmx:VxlZapoKPrnPNydrabEyCtYj_DP8ZRa2z9F1VYMatFYy0JhWBrgrgg>
    <xmx:VxlZanEtfz0NAQ0TlAhHVFgDp57Zp5PR42wd9bYuBfIyLj7sfFedhw>
    <xmx:VxlZapvyENyqh_7uSqiRaq4BrFEg5TwolSvioWlXImOugjiQmSBqYA>
    <xmx:VxlZajHnjezSUTrUwi_eOSnZsZ4rhsSRZ9XUCK_F8EacuDjHuu9Gvw3i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 13:48:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,
    Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [GIT PULL] gitk: Bulgarian+Spanish translations, silent make -s
In-Reply-To: <fdef432d-0b84-4b58-9915-83eb4d7dae87@kdbg.org> (Johannes Sixt's
	message of "Thu, 16 Jul 2026 10:59:30 +0200")
References: <fdef432d-0b84-4b58-9915-83eb4d7dae87@kdbg.org>
Date: Thu, 16 Jul 2026 10:48:05 -0700
Message-ID: <xmqqcxwmhlm2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit bad83ada0ebf9e293d570e6e7ca4f1cd7877f482:
>
>   Merge branch 'horizontal-scroll' of github.com:ramcdona/gitk (2026-06-12 11:30:22 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/gitk.git master
>
> for you to fetch changes up to f1de86371cb85dd09d55070d139e5fcdc595f026:
>
>   Merge branch 'spanish_pr_bis' of github.com:basuradeluis/gitkbis (2026-07-16 10:53:01 +0200)

Pulled, thanks.

>
> ----------------------------------------------------------------
> Alexander Shopov (1):
>       gitk i18n: Update Bulgarian translation (329t)
>
> Harald Nordgren (1):
>       gitk: make "make -s" silent
>
> Johannes Sixt (2):
>       Merge branch 'master' of github.com:alshopov/gitk
>       Merge branch 'spanish_pr_bis' of github.com:basuradeluis/gitkbis
>
> basuradeluis (1):
>       gitk: spanish translations
>
>  Makefile |   6 +-
>  po/bg.po |  45 ++++--
>  po/es.po | 488 +++++++++++++++++++++++++++++++++++++--------------------------
>  3 files changed, 321 insertions(+), 218 deletions(-)

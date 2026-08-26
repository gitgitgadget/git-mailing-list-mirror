Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895C379989
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787774360; cv=none; b=FRYYlC+PWPz/9GQTmf0CyTB9G5ubPgdATuqr6Hjy9JFAXCQZLz1wmrJYEqwkIfeKDLBfMC8YJcHD3V25x5Kfpy0DQQINBndCH6+31GA9aucVdriWmIeYqvIDPXzJ0sx5g19xI2iZyle0RA5vJcruD9vfoH3HCTJJvIoNYTQQ0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787774360; c=relaxed/simple;
	bh=T94fRRlTfodEQv44JT8Rg7zziEhCZr8op/qEvFfjpoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IvFnYfP+r9wYxTYO060Z2O1ywzMavFvWNzkwuPSqSpIV7D49QKGhCY17pn8o9S2CbQ12wxvoJoNJOaGdakPvcSztFeZN1jO6HCJCEwpHgE4NfDWg5t3yGCx5BhvRq7TE8WMX/h35vtD/dQT6Cti2d7vBNzCo6UvGeXZ173naqcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c1PO38cm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y1UnmXmO; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c1PO38cm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y1UnmXmO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 94F0B1D000DB;
	Wed, 26 Aug 2026 15:59:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 26 Aug 2026 15:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787774356; x=1787860756; bh=lKr0hLsXfA
	g7ysX9aV7uqlPjx7WDER1Zqgt1mm0gPtU=; b=c1PO38cmKmpTQ8q1/goh3kF5uo
	6I7hMOcP95DP3aFf1egD676s0KkhaexZbrfF4YpW8kgEyxFzl2gbsfj3XSQsKAFm
	618SmUlbmi+FiNcwKkN2X1l2kLgBrZzXJ7ml89gUIG5IXNSlVu9LfmyKq/M6LJN3
	rX/I35sN60qBmHvoCLBQEmOWaVkFxlDBHGRdLeMKVEbV7puXqY89ClgY8jalPPoX
	qq78yt4Iyi/2PPJw9gJCXyAJVaZGndpIWjhdzhgKfpVuoIvyffbX8l14ynq8E7Hl
	hhVGZruS0U25zpy27O883L3Nj3wnWL00Gty68o9K71ATOJgW/x+rpl61U2pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787774356; x=1787860756; bh=lKr0hLsXfAg7ysX9aV7uqlPjx7WDER1Zqgt
	1mm0gPtU=; b=Y1UnmXmO0obFP8BJ37No7SDcGgUx8MqARAlowFso1epyeVpAXuX
	3FwiTsnLeJn306KO4YxeHH+H9afFpfGd8chN8LHtn/9RZ0ZCAzvb4TJ7/zz61EEy
	cA1vlzy7pnMHT7o3fBm22/ZZAZtVoEwjzS8ONosE6qaNh7qaoyZ7p5XbX2RU58Nv
	ucxp6dFYVA8pM+W/Kp7gwQqA4vJy6HbfQMdV5fXZwmm3v/xoMG0+DbA1L63koYBz
	WErFh4P1/o/+T3YA2ZDib66p1+8xJ8p6nj+SKMIOn62hJGErxE7ph0G7qmyYGwWv
	N0mle5gUaTOYgDQYr2ipKREKMOCExyWuakA==
X-ME-Sender: <xms:lEWPau8UKD39bC9BIQGPoG7qu4aXpCvaA5KovhIDZ1kW4cH_j13DvA>
    <xme:lEWPalmKYLaORQK5HZAb_zJC5xyrQr4r8LL3SFMxeSlI7_NC8TjtCdqrsfqLrQhDF
    RaMN0kQ25X24iCZemg_5AdjooGIZ4R3CM9NbML5i1XzwrGTp9ghBg>
X-ME-Received: <xmr:lEWPasVwhb5UrM5j_J7MRdbey7by-Wun7ZMbE-42qPTxV4dVyA7J-OfELGdv_m1s_sjUlROVpepnoKks3By-P1aP5W9tjOf3Fg>
X-ME-Proxy-Cause: dmFkZTFWLeVqPq32RcZpeUvoxmF4uV830l34NS3RFeAGGjz73Aa+FBS8SoRee2kUvU61a4
    wVQL/b3r2kCefk/692sBzDFMQI6hwJJDvuRNog8RsFS13fz7u4djqPc9rGhD8AG3qp6HMG
    4sZoIdcLGe7+ly2B2S6ECdOpob07psrzl6qr+IsjHJtuy8r7mrfkUBlQInM8xK1w/3GrKe
    s6Pv9IAOrJaP9ygeqgaG/TfdL4Sz6j/mLbTCPBm1pZUngPNNs37LRLUambMAtI6G4C+srZ
    kirDQVrhBeernSa1MrX1SZ/McQuhQzzHwGij6Fv6rd+eNTKMEtFOU8Uh+i0QGvWoD5yoom
    cM7Ih4Hk+JDsQSnZgFVqp4tdRfnltfnEnRzQSw3PO94OqPMmgMvsrxePJw1npOhnAw4SNi
    Y4EIhFFnfM36jgpNcL5UcLkzevaX+/a4J8+YwHeRA/iSEKnHQopvkPnA7oJhnP+l915EXR
    MQspWPFr1zjuJ8e3lQVN64lPKqeOhQjMOR5uSb6pUhcO1flc84VGUke5Mnrp2TXRsu6rkw
    CqbAwljsZIYfbXJVidXHshAh6qOQeVU1UGGvF5kX/2gh+KxxxTr2yefdhJTeiq532vLugw
    R2f7Zd8SfMsHuv1YKxKQ76xtSbOeI0W3jvhxFP0FOLbvFjfkWsVYfy1ntxZQ
X-ME-Proxy: <xmx:lEWPaiEsX1O7dvSych3ukMwvhj3r5Kg9ZTDZ-eXhsc1pDgSWrTobRw>
    <xmx:lEWPagctrYJSFqqemcB8hTx5ohmuQ8BynchPOb6B68al5KNloajq4w>
    <xmx:lEWParLPoNJ0wPJDkzqZ6MJgGXeKMO1ZXQ_8aGv1w_z36XFgueCGaQ>
    <xmx:lEWPatGiY1OswQMIQUqV6-G9rS4Fc00wP-zyTqo317n7HslwM_VDXw>
    <xmx:lEWPapWh4OmG8RViZLNwV2-TiTQEhpPDIuiuVmE-eL7LcQK5kCA0szkY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 15:59:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Michael Montalbo
 <mmontalbo@gmail.com>
Subject: Re: [PATCH v3 0/3] t/lib-httpd: make CGI test helpers concurrency-safe
In-Reply-To: <pull.2171.v3.git.1786583137.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Thu, 13 Aug 2026 01:05:33
	+0000")
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<pull.2171.v3.git.1786583137.gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 12:59:14 -0700
Message-ID: <xmqq1pbkfyb1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * Patch 1 fixes apply-one-time-script.sh (the actual flake) and adds t5567,
>    which drives the helper directly with no web server so the overlap can be
>    forced deterministically.
>  * Patch 2 makes http-429.sh atomic.
>  * Patch 3 documents the atomic idioms next to where t/lib-httpd.sh installs
>    the CGI scripts, so the guidance is in front of anyone adding another
>    helper.
>
> Changes since v2:
>
>  * Patch 1 now consumes the marker with a plain "rm" (without "-f") instead
>    of a rename. "rm" without "-f" already fails once the marker is gone,
>    which is the atomicity the helper needs. A new comment explains why the
>    helper discards the one-time script's stderr: a losing request can find
>    the marker already removed.
>
>  * Patch 3 is now specific to the lib-httpd CGI helpers and lives beside
>    their install site in t/lib-httpd.sh, rather than as a general section in
>    t/README.
>
>  * Reworded several helper comments and the patch 1 and 2 log messages for
>    clarity and to match the code; no behavior change.

After giving a cursory review to the previous round, I was hoping
that somebody more clueful than I am about HTTP tests would lend an
eye or two to these patches, but nobody seems interested.

Any takers?

Thanks.

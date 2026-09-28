Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B81DDC37
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577394; cv=none; b=BO2dCPOEG4AYLWCl5iud/dfLfDJGNIG/YPXT1orMa1+lZWVSfuCzVbIl0U5WRiBuztTrVXuD1AAe0SnrzUMmbKgCc/fuypmkJdgeGbs1UjF0xtxhW/4wf/wbfPIU9A2kPwtegzWKO9Umf3fBbmiwTbTknBoFwOks0sW7qWbOLgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577394; c=relaxed/simple;
	bh=b/eaR9G4TfKp8fjx5onfgIF1S75ZGZyPJoY0dr9x4vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjM30+g8/eJsDh+GIVedgKasuik+qbl0qCm4wdpYRgE1K0pAP22FsFDUlK56fzsjUn5EwKVDOaKNV0Xr5odFUxWApKR71FzQnKibzi8tLYzFUNUFjSvWp65Bn6fJ0wR0dgmdiw9WqQ/YZ6Uy4iAsSynwVpPfh+TRImXzSFdJpiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xtPpu1xy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LN+jWktl; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xtPpu1xy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LN+jWktl"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B7DE14000BF;
	Mon, 28 Sep 2026 02:36:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 02:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790577392; x=1790663792; bh=qdzjrNRK93
	vJfpjvmTvAJDG5ME1bBfKizZNSMXDJaMI=; b=xtPpu1xyMlDV75Vay13EYxTONJ
	hfQJESVd3qE7+vUP85AYjTP8D7GcDAcL5yAX7kYdkzYg8QsfAjs7J4IUGdhWYC7p
	D1N6uN84mn0fUhNb15ECM9Byw/UtmJMvlnJ4wRFgXfgGbEDZJgfTwXroOKUZe2qr
	9mXVeUilxRW8QuLGQwjQi50NkV6g/bt1D5+//lQizdXAoKGeDs7wH1mq/GZLMm9S
	WZp3Bbtb4acyzI8sD9TmfoqTFtC+zNx7lcX2B0Qg1IBlSR+nRErSl52Da4DHbte4
	qHw+mmS8YNVfGAjlhacmxnm4GfleR7f+W5TO59WWiEzkoFgswuZ3uzwwZG5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790577392; x=1790663792; bh=qdzjrNRK93vJfpjvmTvAJDG5ME1bBfKizZN
	SMXDJaMI=; b=LN+jWktlUXeWA0kn+hMPh0tPQYzfVXw/2Kq8IQvV7PvRb984Utb
	vvF5rfhVHDhcbN+mdl7oTbFpAsYKzoc5SVhbrerRMaokLfn3vyZMec3zIQpQJo8E
	bBIz1cEAlIt9CWz5CdoYku1fAAq2Q162JzXgTNccoT2bXUhcL1XrW6tnfwYOxGiq
	7mmejHWvBpTbG6VbZ8g1tGYrSsFwapkYSqKKYm3zOe+oKUt96gQkNAkGp0pEfXIu
	snuxFSFvtzAchsryu8Te5Hs1fpL2li2AkmigP3nBdVJpmwbRWt/RD4rNvdui6FdZ
	0LTbfUQ7QYQfLqkH8BClu+dAsAeiYrC1Cqw==
X-ME-Sender: <xms:8Aq6agwryZgztrQag7Jv5NUQnbAfQ3YUmr6K4AbmKFybLP_w17TsQg>
    <xme:8Aq6arTckkRDlR5ZyCu_ZKn96lpNNcCiTue_tGq_GtsClzeN3FGcGdk-AGV367j8w
    R6kC4fWEP26ELeV-ZVTymzs-WKKqz4ClzTW8UKEg179Wu9zHJziWKg>
X-ME-Received: <xmr:8Aq6anW-qyBOxkXkDmD15wna3PA0uwl9PpNYfE06TE28EV1MoUkIFA>
X-ME-Proxy-Cause: dmFkZTF8nJIusJd7Ore5bg5GkdU06qhnz63/5yXVuSt+673fzXcwtBNOFnQVqHisO0CWWG
    NYzq2yylV/2k4Z+TYq1U4jlFbsOnpatb28tPpx5ftMmD6BU5Zi1uO0XOspE/j/Ut1ELSsJ
    qdeW/ze1LOD2EPavawP7AikhF+YardzhG0HtHjgP6urwJbOzJk738b6dw6otrvSt+f4BQo
    hWqTpOx7JCbpEKaLZ9zOfqgRrdcvEcEr6lx3G7yFp1rVfWMXILeoG9n4S6rDcKYLiDgbHW
    mLkqzJ3hpCZ58MRxMu23l0SpIoHs1NbEonL8QoX6y9fIseIxpkC9GDonlVQdvyFcPM9GdS
    XOBpNkHGw1iWooipAtqeKlueChAK6owJsxx536jOgCDp9i0yL2xIw86uQ4vk3UUiIyBdad
    r59j0oQjP8YKwEeAP239CgFFD/H6dyb6YbGs4yckazck6dZmhCtsG03dyqC2CzfQS9Eio8
    xQ5wmi7Lg48m+Lwugw59qt0u+Wxw5Ge2MwLIjtrYYYJEpr2ujWTmyCBvASAirhngKjhXq0
    S5WzWyopR3+r3q0NDWC02pBryh59uuDwJEA09O7P71awYLCaBe9w9BlIyQzAuijL+rr59n
    azATg/QmzbyWLwXKWu0qITvfw+jFrX2ZVh9Wt25GO8HyConlRHIowsuCIkvw
X-ME-Proxy: <xmx:8Aq6atZDORmOr46RSB1K4yIFzLrJyA_IcVFu2fuX-OpF4K6AiRNO1w>
    <xmx:8Aq6at1b3fqFE51BOSen3gDlJ6lh5ThbldAv8esqYVe2368LZHUejg>
    <xmx:8Aq6avj4GlWpVKjVjZkEDfjKZ0Jm1FnALpThrs0Uwsa4Vk9Mw-X-Tg>
    <xmx:8Aq6ahbltZTbfRENVpKUQzmEE0_gTNPqKbxQLeT7pmJ8C1YQEqSqlQ>
    <xmx:8Aq6apRrjLtcJ_OMmtv1N3lqV-qqRQmxKqd_FwR3xqbaLSo9xAlstnFg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 02:36:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 31bbb748 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 06:36:30 +0000 (UTC)
Date: Mon, 28 Sep 2026 08:36:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] ci: align job counts across CI providers
Message-ID: <aroK7KcRabARSqd8@pks.im>
References: <20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com>
 <20260925-ci-large-test-resources-v2-2-f632cf319756@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-ci-large-test-resources-v2-2-f632cf319756@gmail.com>

On Fri, Sep 25, 2026 at 12:35:39PM -0400, Tamir Duberstein wrote:
> GitHub Actions sets JOBS to ten regardless of runner size, while
> GitLab CI uses the detected CPU count. Use the CPU count for Make and
> prove on both providers, selecting JOBS after the operating system
> is identified.

Again, it should be noted here what the effect of this is. In other
words, does GitHub slow down as a result? You already showed numbers
during the discussion on v1 of this series, and these numbers should
probably be included in this message, too.

> Use nproc on Linux and NUMBER_OF_PROCESSORS on Windows. On macOS, use
> sysctl to avoid requiring nproc before the dependency installer has run;
> GitHub macOS images need not provide GNU coreutils.

Huh... "need not" feels somewhat weird as phrasing. I guess it's rather
"does not", and consequently we have to adapt? I think instead of
describing what you do, I'd directly pinpoint what matters:

  Note that we continue to use the same logic to detect the number of
  processors on both Linux and Windows. But on macOS, we cannot continue
  to use nproc(1) because the image used by GitHub does not provide that
  tool. Use sysctl instead, which is available on both GitLab and
  GitHub.

Thanks!

Patrick

Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFEF3E92A9
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441496; cv=none; b=mc89NCZtY6OTu2AzuFDa9PIVNog7BBCzMgQpzV8z8IWo/6KqH17CXbA8oBtq+9dmWP6e3Ky188ESGHfMMwlPGreBH/Sz5uGJwLPQ2/h60B06AwqJG3s+TJQ3MS98FDZXAMWizl+QAiX6JUTdpOC22a3euHTpDOaN/VJyrWI5uOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441496; c=relaxed/simple;
	bh=FaoKUmQ2iyfgNVSfan1KNf1mshr0eE46H8QNYhgUMvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTNk0Gse4UCh6oIAoMQoCQJGjojSDuykaPUCwPLybiL5XfSlHRtnb6JEPF5vDkZCfzs4XYXt0pF9WzknZ1fW5PgNuy4Kag42E4hfGC+ozGeTaahX7GreVJ2Y5r2/V5BtU9Kr1wje8p4HDaMHlmaAuq/HIWafaHbZy1OnLS62lz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sxLikN2n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y0VAmSxB; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sxLikN2n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y0VAmSxB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A607EC00B5;
	Tue,  7 Jul 2026 12:24:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 07 Jul 2026 12:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783441494; x=1783527894; bh=nZGhe/qmhj
	HF9Lk+Ch6bghLf6sI5udoiK2GGULH8ZLE=; b=sxLikN2nz0PMhBEnakrQBrcDc1
	FLk3jQH3jsdsJ8w5dG2IKL5RAO6QzhjNnFAlQMFpwstx3ipUUMF8r9lZ41Bph5tB
	kC/3fUKGWhSVqY3HhKQdHFOydd3UKW72Rz2+cei0jhSbOkC/EzuWEf6ONvXkZqdK
	0SYSTB9pED2h2QMz4PYI6xxi9BQdxhKHQgKxialO+lx0TSE6q+aNLAWAJVgUfXkc
	OyI4QiMekWexgQVKdTu2WpZxpXYNyJ6eJib0SL0eJSXHFjEp3NpcrnLJW/pMvfbh
	6m1m5uyTKNNgonCbJH0WqQS/WStPbR5ZS/oFVf78+otBqCMhXQwQYW3JtEjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783441494; x=1783527894; bh=nZGhe/qmhjHF9Lk+Ch6bghLf6sI5udoiK2G
	GULH8ZLE=; b=Y0VAmSxBlWDFSUZ0jWTtM1DvmU0ANJtE2Of8CaPNhkft36rTWFM
	O7D//3uIl4Iz/CbSQlq/T1Tc2pPreRZgBgU6ab7ItFcbmqWC1EJstElrUpIJgqqG
	flp5T5DR7uzKLeCysc98Dweg51jydWJNgyR1H75PD1rxPcUZIvcVZ+l+DZIZQqx+
	vI1E+PQuGlRYFZnpU6+/55WWTWthyWV+l0gO3FoBBxsjdqoNjhtcVNjU+HyFzsBg
	MC8mMncv/W57b5rlmAWR4dKN2dCv2N0KuvsNQEWARsKAyl0dxXhpIJV8axgwKS/0
	F088tFCWimLD2pmHOqCd4EkOJXOjz/M55pw==
X-ME-Sender: <xms:VihNamJwG3JAmCv3vcu9YscbGx7c2CTu8g0rXrwUp2Zz8Xh4QVcZeA>
    <xme:VihNalnd0IS5-FelHAXO9AqqBlJJVrURChDmvgrrGm0ztPhf7diknB4fZyU6hT-oK
    lpCgmcpYKm_awGhUvCfzIWt5WadnXNGVnj0RWQr6i1DqEth7VT-QQ>
X-ME-Received: <xmr:VihNakE9VqR6n7uWZZURxxVHezsMdkbUpPhh7GDjCgaUixuSNo98OnIDpcYZO7JaPAReN3DtIeCKVHiMvl2yBB7hRoNDUpukKqkBm4QtKecCTvsxMZNh-9s>
X-ME-Proxy-Cause: dmFkZTFWC+7uUeEmTGgj4LJ8Te1VfbRWu43ffwq66rdlRmMCpLyp3ikj0hMVnkoq7pUCPR
    O9vmR3z0lR6Yw2JG4hgbFD6BeWCh2qVNxY+spymVu0cpG+ISlXO+n2Dwp6KNS1NCf8GzvG
    yQjMlXZ/SsYnH65Pr6y9wzozHm+YZeEgGtn8I8APZFKtk1d6/1CEOegbHhYkWrkPyzIQY3
    Z+yfiY8DwaaB9smROTHvNCjo7rfnxsV1/GxrJ6rQkhpoD0nSka3VakOztQu/JMM3Xdgc2z
    mgbcLfgQsSeh2mdt+lrcnjfstlh0MLhBnII9hOrO39OXflYJ6ceB6f8Wg9c4mfiSE7K2O3
    vJglYG7K4ZR6iPKsCIqi9MIdFpDmdyR5fbSZHVd049My8KRf1NfSO1Fg2JWX98IkYyz9lT
    T6Yx/dORGZdhJx4S4987x3w0GjFgu4XH9oawaSEVptETjPDiq+6QMeVk2o8OaqTU2K68re
    p8+fJd8G84STyzAjBa4lOkdy7ZwFBpZ9hdMW/LSuIbhhKzogSjp0dBrGMqaBft5eQvly4s
    aBZRusbwKKRZQpL3Cbfux/M5KVvC96kQ1QsyejVe2joYmzNXn+gbJNG2cZ1wM7t2f/yqyC
    VfXCW5BViB0Iw/5jrB1i26MJdlq3Br+i/Op5w5crbHKPaOOHucquDy12HK0w
X-ME-Proxy: <xmx:VihNalH-djIHgd9RvNY0KuZOTrEu6JyDihDhAlcvTHkVhTojBdFbUA>
    <xmx:VihNahOKNIBewXd1tx3K6tAykWcXjMaNmp-lY-8gV4I5G3cgmJME6w>
    <xmx:VihNakFdgZhyA9rACVf31AVkUihNZncFBCRIsDGEWLkxKSMlPpyUYQ>
    <xmx:VihNaoMknOxLFJbVsp3iMWOkblpBk3rVFDAFYwYKoqtCJqIO4h4JPw>
    <xmx:VihNaig3_3DCETgwG5PJdDVdO0g1gylqpQIq8zW5fSnc059TjKKpgRHT>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 12:24:53 -0400 (EDT)
Date: Tue, 7 Jul 2026 12:24:52 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Berner Martin <martin.berner@qualitasag.ch>, git@vger.kernel.org
Subject: Re: CVE-2026-55200 libssh2
Message-ID: <20260707162452._tjDEpzZ@teonanacatl.net>
References: <ZR5P278MB19814B2CA717210492C13A73F0F02@ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM>
 <26531fd0-4a21-c8ef-84a9-25c871cde303@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26531fd0-4a21-c8ef-84a9-25c871cde303@gmx.de>

Hi,

Johannes Schindelin wrote:
> Back to your question why Git for Windows still only includes v1.11.1 of
> libssh2. The answer is rather trivial: MSYS2 (on which Git for Windows is
> based through a healthy collaboration) includes only that version:
> 
> https://packages.msys2.org/base/mingw-w64-libssh2
> 
> And the reason for _that_ might be rooted in the fact that both the
> repository as well as the website of libssh2 list that as the very latest
> available version:
> 
> - https://github.com/libssh2/libssh2/releases/latest currently redirects
>   to https://github.com/libssh2/libssh2/releases/tag/libssh2-1.11.1
> 
> - https://libssh2.org/ says:
> 
>   Download
>   libssh2 1.11.1, released on 2024-10-16. *link to Changelog*
> 
> Easy explanation, right?

Indeed.  :)

An upstream issue requesting a release to aid in the
distribution of these fixes was filed about 2 months ago
(after CVE-2026-7598, before CVE-2026-55200 and some
others):

    https://github.com/libssh2/libssh2/issues/1925

That may be worth tracking for anyone curious.

-- 
Todd

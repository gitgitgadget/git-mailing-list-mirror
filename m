Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D713B52E2
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925536; cv=none; b=YwUzBSYZ9YptaCM142OFGB/fR4m9J0fQZkaL+c1zxYwHl1EIuhZVhqif2ZziSt83e7jHvUlE8iaNQm5MuYs5IjBLK1JT6T4hHWWwJe7ol16NOMUoMRmtK53WwG4zSckTCu4HfxdbC+rSeaX+4NQ2RloFM13eQrpUXLrHZVriTDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925536; c=relaxed/simple;
	bh=bxtSDunPgTKbYF6BrVHb1ThIFwTp1x1g+ZRArATZMTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kij/EEswJJ0u/Uk9dEBetJVmJrisCa9lVuKL+p3Gu9ST6zCzgd4h7hcMZBiUgPc07aSnHqU91plNty+wqedHRHqvDZlJj7yBI+OmQMHVosgiNTQ3xUYFK8qIdtWlJUMwQeo86Cl3rMDQ2QGJ/bgOEJVbNt/khHg649LSkiGMSyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A+tPIqpt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J8IV8XtU; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A+tPIqpt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J8IV8XtU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 66A5B7A01E5;
	Fri, 24 Jul 2026 16:38:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 24 Jul 2026 16:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784925534;
	 x=1785011934; bh=bxtSDunPgTKbYF6BrVHb1ThIFwTp1x1g+ZRArATZMTY=; b=
	A+tPIqpt7bwvp1LEmZclSwFf5Pkz1gjRX3E/QCfQEp+RTga8+19MiVT6y/yic3ZE
	k0fqnvdbD9C82AS8WxGVARcrGlM4Ky7IswIOyclC4t6jILGdHtdh6w9gDg+xs/K1
	+EKqr8Gv8EzKmxeN4Vyidea4cFQKROoZxX2M5Yp/wG18LGZr88Qb8qLUmWlkhYXr
	45F2br13AdUNY9eNO80mJXefk3QHZ+1VQ6NnAjG8s7762hYw9hX4OIzNQgTOqdhn
	HCLwhNvw0raZYyf7wANsaZOIGPP1fwRzfKqcMIjytcv+cMObW/lcfuFwSuaLsuYK
	wxqfzW+sClbYj7xHh4wrCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784925534; x=
	1785011934; bh=bxtSDunPgTKbYF6BrVHb1ThIFwTp1x1g+ZRArATZMTY=; b=J
	8IV8XtUM6fUamRU14aEHpXR67yPa2QKIPhY2aMIyzoKegfBZvoll9lEhv7/HXXQQ
	JZs9GrkUl5sS5iOD2AiIZA+cWtpuMGeWqsqAUPj3SiARPLMZnqVcjmGIb2DM6ump
	QPRfahZZmg3RoPqvrUrHZKvw/YFJJ/pbDOcWuIhc1bEDj1HoNSuVW0BAoTSpmM9k
	pqCjtQ9PVEOHYlzQxUqFod4I/WuDQAGErRna5kT6UyT/IIoFgPWkDcVOWle6sxzT
	Ln55sLOAAZXOLt7sL0F4DW64kwglXW6CToictMmEBSIjfcxoYz0ZuIIyIlY3z1Uj
	Pcr3jgAzDxyc+u//IbEzQ==
X-ME-Sender: <xms:Xs1jaiwEMcTn89NvR3WkSKgRwOj9cEACp7cmQwnbJarpyLduaos9eA>
    <xme:Xs1jaq01-grMo56d3qHm9eZNGLEQjRZKJkK07zWmQV9pbxX6WwFx0aHD_tbY2Zimu
    yVWjuBwPjqEGyFqdTrykn3bDcT4LA0UrbUAHUoZmme2sjV5Ybu9>
X-ME-Received: <xmr:Xs1jaoyB5G3t492263k8-sgZnLF4D7APvw-1F6NDHj-wA3Qv0K1ZUCpUr-7OEkSYWsZGjE0IRm0OYsxBq_OSrYqLRmsYMBePzQ>
X-ME-Proxy-Cause: dmFkZTEU/KqM5l94bWl7tw3EIc53igonDuW3YZtQBvms7Zz64manQzAAt7naBgpRy+WyXC
    RQu3xsYziTl15k0/DvhPZbycNcwFmyuz/GglkaLiLjYyIjIfatH5Nt3Ye8bUv2K7nKqRrC
    EikJ2K1mGD3teyZbVWCojbdbjzoRYJcnhr4tfIWo5nVU7NZJSIffY260beaZiSuY07NjCR
    E9hBdydwS9DBH6wy3agkBYlgIoynqdoet7j9/y8wBjZIvsQFVcHTbxYYv+0mor/tslzvIT
    WX7T47lI6c0PIcd7mp2E0jo3JpQeRt9D+G5QJeXOWf8e7FRtUfwRsPunGYW86N8sX8ZrD/
    gucO4kDT5zK5MR+doyTZH5C+7u+4ebcc1uN1B0xl9X8nevNDw0Mt0J/jFl++f+HtwmOwTU
    Q73p2jB+YE7Dz/uJB5mdEpYWsSlIMTDmPFDkhIob5I4eMyTaWSGFXEPOreLPZy/g2BwCO3
    d2aPZHVCkTA+Sm0CDXWTM0zNeLOoGdJJ6/kHUa/oDcD0B5MVmdVJtBVwMfzlFvrR9OqUaG
    RC6koJKn1M63GxBAjFZRTR0AQsT+FJ+zQI4+0ZnuOat10GNpqiW4I/CIZsvMNj+9O44QDH
    fC4P7gb4QQOsglsyzhsOozrkFpXFqeDkGIuusxtYvY3sydRo5JmSR+6Nbi+g
X-ME-Proxy: <xmx:Xs1javXxMxz11P0lXj4lOXOyJsV48RNq_aXVUJ9ucCBAl4YY6Yty6g>
    <xmx:Xs1jak_7eY26pmQnYypKYVHiWTwf_lIuZKbL2B0KD7eiDu1i5R-qwg>
    <xmx:Xs1jaityj9xRAVxXiTbiLpgnaWmTSZWFVyd6XZhsxe-QlvdzExEo9w>
    <xmx:Xs1jak2nCudzre70AT0DVjxa0SakvfJPV4czkz6X20U131oZDid0xA>
    <xmx:Xs1jap97VO6hoMI68y0pBWCMVr3jLsF3LsGecJpRNzGtl4dOKWSzyNk7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 16:38:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Tamir Duberstein <tamird@gmail.com>,  git@vger.kernel.org,  Jeff
 Hostetler <jeffhost@microsoft.com>,  Paul Tarjan <github@paulisageek.com>,
  Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fsmonitor: flush pending FSEvents before cookie wait
In-Reply-To: <CAOTNsDy4pKbPHdK1T688Ax6Mgz15K-qfZR-8fAvTk48z3E43Rg@mail.gmail.com>
	(Koji Nakamaru's message of "Fri, 24 Jul 2026 11:41:08 +0900")
References: <20260721-fsmonitor-darwin-cookie-flush-v1-1-357dc5e32040@gmail.com>
	<CAOTNsDy4pKbPHdK1T688Ax6Mgz15K-qfZR-8fAvTk48z3E43Rg@mail.gmail.com>
Date: Fri, 24 Jul 2026 13:38:52 -0700
Message-ID: <xmqqh5lo5dib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Koji Nakamaru <koji.nakamaru@gree.net> writes:

> On Wed, Jul 22, 2026 at 6:05 AM Tamir Duberstein <tamird@gmail.com> wrote:
>>
>> 56cef9cb1a (fsmonitor: use pthread_cond_timedwait for cookie wait,
>> 2026-04-15) limits the cookie wait to one second so that a filesystem
>> which never delivers events cannot hang fsmonitor clients. A client that
>> times out receives a trivial response and scans the entire index.
>>
>> FSEvents can defer delivery while it batches notifications and does not
>> guarantee that its queue is drained in one latency interval. A loaded
>> macOS system can therefore time out even though the event stream is
>> working.
>>
>> On an Apple M4 Max (16 cores, 128 GiB RAM) running macOS 26.5.2, two
>> worktrees with a 1,001,178-entry index timed out 484 of 545 and 297 of
>> 365 fsmonitor requests. One status call performed 934,519 lstat() calls
>> during a 47-second preload and took 52 seconds overall.
>>
>> Ask FSEvents to flush pending notifications after creating the cookie
>> and before starting the timed wait. Use the asynchronous form because
>> the client handler holds main_lock, which the listener callback also
>> acquires. Keep the timeout and the behavior of the other backends
>> unchanged.
>>
>> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> ---
>>...
> This patch is carefully designed to minimize any risks. To drain events,
> we could also call FSEventStreamFlushSync before acquiring main_lock in
> do_handle_client(), but this patch should be sufficient if it mitigates
> the issue. The commit message would be much more convincing if you also
> included benchmark results showing how many timeouts were reduced.

Thanks for a review.

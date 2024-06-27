Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCEE20323
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719470980; cv=none; b=TOCb/orxzShvkbSg3VTb6OhMB6eAMweHADhk18l2KyY2nxkyJFOc6qFu7QvgKaAbxM6b8C+MCf4ZH/mic3bn6ydQpRtd9CRv4Xr+QoAbTxtytix0D5/qCZY3v6I67xDJQGz8V+UcQT1Zr62Cf5Pcciv5P/syYrab1q2+MgVSwpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719470980; c=relaxed/simple;
	bh=TFIbQIHq4kL/F8J5GCAciCRFd4naUx23CSZPgwlVMLY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T0R+Ap6Dl9RnwQSi8r8tqyxapSQ5uoNFfyxoCwHGiRqXs8vQi3Ymu9z0eLR6xs0WFnqYtq2S7Z3HDM1l/qaJOZJsTkRq0zA69iqgJUJ1crwQao2NjjWPi8QGG8qEB2l2edlBCSPD3zH7kY4ssf5jQ31EWR/jn5MfF8sUW0cPHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=bZhbCWzx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="bZhbCWzx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719470968; x=1720075768;
	i=johannes.schindelin@gmx.de;
	bh=TFIbQIHq4kL/F8J5GCAciCRFd4naUx23CSZPgwlVMLY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bZhbCWzxMoD4Wqh72lH+rydGBSXR3OMWQoqd7MwQZe/03MpEnwC4EmOJNZpaDdCM
	 1g9tuIhYHv1bDILP52ANDwXrnopGQqVAB0TCcB928UWGo8cC/JiKb+bC4BrhFiBit
	 j2KD1dkq3Bvq6V+XVdB91fLERui2qCIdLwScx1TXUoBCsdhvkRUbxVvFKyzD8+8LK
	 sL9irGkt9N6wU+SlKdpqULJWh8M+xZV71xTEEcMOuTa64AQQwxadn2pYY/bgDNDX5
	 oRwOGleTsqhFEP1XVq8cUUa8dltHUx4GISUDaB7HuGkodxF65voOhJGLPPAOKipny
	 whdtSNTPgFsyfqxryQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.26]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89Gt-1sIc4h3DWt-00CX7n; Thu, 27
 Jun 2024 08:49:28 +0200
Date: Thu, 27 Jun 2024 08:49:27 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Junio C Hamano <gitster@pobox.com>, 
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
    Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org, 
    christian.couder@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Outreachy][PATCH 2/2] Port helper/test-date.c to
 unit-tests/t-date.c
In-Reply-To: <ZlbB_T8DkgmPeWQp@tanuki>
Message-ID: <28c49738-002e-6a67-2000-cdcf1c892ab1@gmx.de>
References: <20240205162506.1835-1-ach.lumap@gmail.com> <20240205162506.1835-2-ach.lumap@gmail.com> <tpaamfc3g5mrrbfufyvxi67ja2ko2hiihrptwxkbmdx4qpid3f@7aashrngiscn> <xmqqttkquxes.fsf@gitster.g> <ZlXaDWy0lQA1FM7d@tanuki> <xmqq7cfd7ut0.fsf@gitster.g>
 <ZlbB_T8DkgmPeWQp@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ITjL0/R/KhacmCadSVW4F/AmYMwNONYEFCk9s/O0tWj2vdKIV13
 fItPswcO58u+Q/8m7EzPcv6NPmK8x8QrYAfHUcyRrMCQr4XzRj8+RlmEeGC6P43kD3iYw8G
 BFZKgNXXBmHI7yYxa5+CTjZpk+3gw8tMC61cej/7rX4h1TSKxE/eX60aPKCez8rk2maGB+6
 fR1uWxaKBpjQEXn3VDvWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OLpGlrQkvuU=;N+0Kr/58MhuSxhxwfbNcxW1TnuX
 UZgef3zh3AR2f7A+aCX73Swn8qE5L7SmOGXT+U1R6O6g3IS7fJg2hMO+6SAgKHb+6VC18UNlU
 +61Ke8LJTY3CQq9C5jxd7WbgvgzTGyNOE+KB/ZNnw5sdKDhLguSkvVuy8cqg1Dw9JFdbJ8Dof
 dkQLbaHdtx8OfaWkIbUmWE7e6bQqTu3VOiNlhf9sjMDKz1DcMNp3ZMnInwJHRPCdl5c3MJlMc
 n59w+Z6v0pqcssT4usdDPIC/QpV0VrWGJvqwDYAmc3foU162ogWg4E8OUr8ZFRD++TRKFmkOL
 mr97NpSx9JOv+w2cKl9yrtAyZuNkRCuuXMcNEg5qWpau7SXfYbo/ViPOs4QD9VnmIb/p4Ax9K
 noOmlozKuIZU46Hy4f3NCeeU1Bievc0pXFy+7bAoOjQDg91+SJbq+C7rzfa0ZQQhnTORSXx+9
 Gkbc7ddKb1cIOHHRj0MR+sOS2q/CsqB1rZG1c+VsJGzccuGi0XUZV1q7iR22J4vLkpGj/DWBn
 WQsQ1+tmFVGIjcO2OiPuFT0/ZMOoVF9pTw61ynb6Rn9Nx5Zh+mTKk9okcefW2LdVEUUBDvH31
 jDB5pq/O9cbsVLC85H5RRuKUDvNqZ9S+y8qTZ+Kx15d8cOl8f8yLDqXb66HFheQJNpGsyMefe
 Xj2KUNflThQ5YLXfGRevIujllumyZDi9pMKVEF2NkIUXh2teSeh3skiIq35eesU0kelYMg+FL
 flPeJy3HOOohEfAkEuNF64hyMGeIiXBbBmBq5eMyP7DGw+Y0nmmrIq9+HgY1SYMyFpo1V57h9
 XcXnJJTjUC5D6ghNLlnVAnja5W8mPl36BgFSGmMy0WKNw=

Hi Patrick,

On Wed, 29 May 2024, Patrick Steinhardt wrote:

> Now the question is why we use `SetEnvironmentVariableW()` over
> `_putenv_s`, and whether changing it would be safe.

The reason is that Git for Windows internally uses UTF-8 _always_. But
`_putenv_s()` knows nothing of that choice, it uses the "active code
page", which -- you guessed it -- is not at all controlled by `LC_CTYPE`
but requires its own call to a Win32 Console API function.

Now, there is theoretically that thing that you _could_ switch the active
Win32 Console to CP_UTF8, i.e. the code page that corresponds to UTF-8.
However, for that to work as well as Git for Windows' users deserve it, it
would require a recent Windows 10 version, and Git for Windows still tries
to support Windows 7 and Windows 8 [*1*].

For that reason, Git for Windows performs the conversion from UTF-8 to
UTF-16 and then uses the `*W()` Win32 API function that accepts Unicode
(no matter what the current code page is).

With that in mind, I would love to find a solution that still uses that
`*W()` Win32 API function.

Ciao,
Johannes

Footnote *1*: That support was unfortunately already partially broken when
Git LFS dropped support for Windows 7 and Windows 8, where it now fails
with a segmentation fault (or "Access Violation" in Windows speak) and
only prints a cryptic error message instead. For full details, see
https://github.com/git-for-windows/git/issues/4996. You may note that this
breakage was accepted and not reverted by the Git LFS team, citing
security concerns ;-)

So you could argue that Git for Windows is already somewhat broken for
Windows versions prior to Windows 10, but that's not because of a
carefully planned roadmap but instead due to forces that are outside my
control.

Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624A41CB313
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807435; cv=none; b=my5x4LqUTYGoeUFabhKvdMr9ZS49YOcuwR2nQWfXNYgYQ+I29QR4RewKoiKz8X73prRnFR5KTKQ8prCvDoKg4nJLMneX3maP5qHZgbAXmuDDwORVp5Lx5Z5mQ+elAUx/QU3potD58e/0lJtZUJotkQOXv4Krff5u9IvHOtRfrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807435; c=relaxed/simple;
	bh=nM0sbY1F/Xi3tALgdQWgcWpU5MhXxLfLm1P6h+NYRT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AV+eu5BxQQH5K296D9YHFXMpJO5BdxjHYWHqPITvxJ3y4GFiNt7QNrfQ7fM13noqBwvlH/xIDllxXFUGS+Kg1js/ozTj3j+EUt71xcpYQj1f6Ly4MjDTXMNsMu/cnLCs6BhGrbFHnJr1dRQfIoYL9qaTQ0WTkq0TT4nblVs5HCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=aH4cHFsm; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="aH4cHFsm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727807424; x=1728412224; i=l.s.r@web.de;
	bh=IHqNgLnegnLIC7JD1ZhV3YZIhcbtMZ3spol4OUa9+5A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aH4cHFsmKpMWE5JxjNFpmyRr0oasMjTyXr+mHP/wJUJPbB9anp0trle9gV4M5zjb
	 uRYcRKiQZMoU2C/eVN2IiJSj/hb2RUh/wGVj4zJfIrwIU+HOXLrhtqlxPgE7aF012
	 2yEl9mFS0t0poOUXwZhsAvLDh5eshXocDmMcOXApHPNUDQOllNUdNzyswfiOnVQR4
	 69XXQbM2BTSLHCHqPw/8ySV9KUgXURTLEW1e3VofSaKxH+MOHj9VWMwUIxInHhwT0
	 05OV8RNl6XL2CDL6ThJLGsbi/FSRbyZt81khBtoRADRUD3FJBn9oTwnQfnfG0ESDL
	 Gdu5MBT2lyNvXO5A4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.148]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbkSI-1sJsRd3YL8-00bf7S; Tue, 01
 Oct 2024 20:30:23 +0200
Message-ID: <7740463b-84b4-4a69-961c-278ce2901f0d@web.de>
Date: Tue, 1 Oct 2024 20:30:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/25] reftable: handle allocation errors
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
References: <cover.1726489647.git.ps@pks.im> <cover.1727774935.git.ps@pks.im>
 <xmqqzfnnyakq.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqzfnnyakq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o2UjVNme5kSqcWdG5/o+cmV1FNQ8pnak8nP04bP/YLzHg9ZDsLU
 TwFUOcEwmZKxNeyQXtLjGov2emu6l7r7BSHs9OMJTlPR2ZVgwUQrBgjHGisriMo2tZQGkQ5
 QE3MbwU59McFT/zoyy4jvRz2jLzaL/9awFHMHBsdXESxMyVZStX8ll3XD3mSTbEfTlS0KTs
 HFm0FTb7sFuyN3A1avdWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uNUGv9JJy8Y=;pVOenDDYL9dYcZdj6a44rVHJTo/
 d+dJ54dVuYPFDDnFYOxJiFG5gqDRVsHSRLlg4tykaYXNzfGBmAwT3VJQl+SSvGEwqOrmwNQe+
 XTfy/m7HWnE/+6B+FODru3lJdgnVzWlNmzgnZY0N+4rkjfsw5Mp3Jzup4N67VIzLpkafy8/jA
 wxPLusQ6xV7iXJvurma9GKb8y1qXZd0ZTU9KT0cneDz2Wzo/lf+MaYMstnig8uc7VFCax9XRJ
 JFGxWH6XDqGLUXI2ZvYGaSdQL6voZ0JFPApzOlEoXg12l6NME1KLk6LbaKoUZ4wp3iCI5kqMV
 FC0F+z2/U6KT6+rEg1N8y9jnwpBQpP84MSjJM2B8gp3RxdW690L7RTPvbbwo3MDQqXb1OK7/W
 +5G3qJg1ZcYEfOmGi0KzLq6ussnv4V+DG4Z7+a839wByuFzYl6o5XzFidZsWTum4hPhSPsmaJ
 CiDQe6GPahwtKsV95LWXZ9fHpbR4rZtl4vqULn3p8sZiWdfUsBFmZqLGUDtzsKOtY/OIikS1t
 gfZM9iMD/UgCnm4MWLVwP3o7j9pqfGzbdL3BvJ5QpCjUHC8dHL9TwHbTnG17GrdrzOcVMe3qu
 sXfxWXom1jkh8PYCp2iHS2+gspLrmfqMmr0idnD3EvGY1DZYnVGP3WzB1hyyRfjADdv4yut8R
 6JgbOuGdzWvGpHkhLmfTgAjgb1giagGHcVn3nXlGhu5+cZSvrSao1xHQQ37VqHWqOk3nFSaQy
 1VpaEIHgurvmWgWNk2R67pWeiVMpWWXYrkKvqCjfkNE+ah4QNYDIxy7eKGh4p/NqB7cWqqkFP
 dM+0TNaYUmnw2pn6F+IrlPhg==

Am 01.10.24 um 19:52 schrieb Junio C Hamano:
> Shouldn't we add FREE_AND_NULL() to the banned list as well in the
> last step?

And perhaps the wrapper.h functions like xmalloc()?  At least as long as
git-compat-util.h is included by reftable/system.h.  Can be done later,
of course, no need to reroll just for that.

Ren=C3=A9


Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E038214601A
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046081; cv=none; b=JakJN15bznTocEXX1KcHsLFx/GdP/zt2mNmtvHxnDh7nH1BzCegXYe6fk6RVJLo8Y/yD2HpX9kMjRrSFr5aFtjzIvKL8j1Kaqi9GT3igqmWZUnwV2CBfhc6DsvJcJZirnmDOHHSEXeo+wkZkiNhVuex3AIaDRliUHErrpf/orKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046081; c=relaxed/simple;
	bh=M7TQkhZj5TYO65lHL6a76MiY7CDHa0h8ynOw1NByWQI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FIEuvBjo2TEnQrH4BzRthWkvUyQO2u9BT0KNRwLYewj6/qKh/J7pVFMHZBYoV72r4sIc4bQICzJLMAwceVKtM79KnzFKPhgWjsSGZHD2S1jpCh7kFccACptxNLbnv9NVZsWci1U1+K6r8V58ye4SyNPNnBxDcZ2sjnhjWoo8+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=NOc4THJa; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="NOc4THJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709046048; x=1709650848; i=johannes.schindelin@gmx.de;
	bh=M7TQkhZj5TYO65lHL6a76MiY7CDHa0h8ynOw1NByWQI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=NOc4THJa1CUc1ctdoQf9sgaHDyTO/sB7Rmw9h4wOcQY+wxfNSVEWkacODhQvrQTE
	 Cc4JCezfqSqxc7jgcqYe+lIEzB3j+N9Uq8O/sF543WM5DRtcHiPqsWh2vBFI6XNQQ
	 byvoiZUrWUh6hHq6bcaiiy9ZROzxR5JJ153EoH6ufXUgfVwu358lT+vJpirL+7Tk/
	 6i0qirvU4i75VW0NAJdf4EUtlVj02tmrxC3ClA4hNfYjflNtNUsQbVj3rDZ27a4Ia
	 5CeL+mFw6MGZlFgQCydUsFSv44BoORZTnLE5jBVi3PKL0CWo9Nv8HYki8iVS9IquD
	 PMVYDKbYGR4Fl62gJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.214.170]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9nxn-1rZC383vYD-005mR4; Tue, 27
 Feb 2024 16:00:48 +0100
Date: Tue, 27 Feb 2024 16:00:46 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dirk Gouders <dirk@gouders.net>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 04/11] Prepare `paint_down_to_common()` for handling
 shallow commits
In-Reply-To: <gha5nmnex4.fsf@gouders.net>
Message-ID: <79914d16-f58d-7ab0-5c25-f29870a73402@gmx.de>
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com> <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com> <84e7fbc07e08956e6c493baf499fee455887b16c.1709040499.git.gitgitgadget@gmail.com> <gha5nmnex4.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1042822142-1709046047=:507"
X-Provags-ID: V03:K1:Ye/XwMK3Yrnr7jDD4cyTB4hPI0sveAA1ZZ9ehxUYQHI/DTXWK2m
 OY2GBifFZcWMjZu0jhEs6mNuNOGZ3u/GK2d6YclGZyV94tZcbSq6UR1r1UMiUgSYFL+my6y
 mvqE0QAQ5U0ASktdV57Cz5OizDUvZQFwSxpG9MFjk6OCzmIbxhGdN9SyFdLrUHg7Y6TPFj/
 w1rMtd2NSdA0/BJRoEF7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:T3955qy64Zo=;OWvcbTuU8OQTPpQGMmRqZa7TL92
 DqL1xSnNAiU2711D7JZg/8evjhon0CBK/iaFheAUnfXBHfIJipZHovIl494DN1LUFGsSIzLHq
 fnyncqQzDFS0O9h+GWF7M48sdCKCTK9pDtP+J8uGTS/P+sbTqE90TL3ukQ2BGW+k4N4y1LlQE
 DmxXRcfkK9kJqXVthyYXl+7jO95++mpv2YtUo/t9inoZW7segcex3ImHjYdy/6cCo9uvYwIZA
 LOxcJ1EThtxCYb7ou7uU8VPX29RHO6tRpMrHJheM8jhleOZge4DFv2K9HYP+Xsh74JUF+3Hbe
 LBRVCh1VnZfDi6wMwhNzELR8cazXUymJsp2YXIT4C//o2rDBrMvCytvlUsjCXal0/a1cqdj0i
 4OB1+QQaQJNVLd3VvheXxkJQxP/V9epql2AdK7GEULpy1gUCht/kAFt4RuYDjXDY1p0JVL+b8
 ddSCaoHTpdzLA8oHEwfNs65KbsQp3d2yao6oyqvg4MMrR9jjCljyqwdIeSO0Oh/F74MfETCFr
 XxJO867enZ/1TnRElN/+1V8nRKzigJMmRfLIBUrmDmbRRZf5wSsTe40V/zcgDhHfN7qzkOvE/
 inJebqu+NK3Pfrb8bJAEcVviLtjqAx9o6JboionfWx9dG0Vt2UGF9jsh/QDKJqPzYrvj3tJgK
 wg5DSrPUuUSbFUugY6pFFR7cNvrcPvYobd/3Tb+8QNIMrbSa4pFxvD1252dUa6+MlQ+xAqiJo
 b+xgJuNLjkS3lV1mvYebE3mHHvSHJpCUToHoY1BCjor+jAZRP+TQe17y7ct8/gOHDNf7IrqZA
 1czrLBko6OjdcsRAGn5dW4MPZpK1uv6TRQI1SaI/aTUIs=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1042822142-1709046047=:507
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Dirk,

On Tue, 27 Feb 2024, Dirk Gouders wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Currently, that logic pretends that a missing parent commit is
>                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > equivalent to a missing parent commit, and for the purpose of
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > `--update-shallow` that is exactly what we need it to do.
>
> Chances are that I am wrong, but to me the above sounds very irritating.

Not only that, it's also wrong =F0=9F=98=9C

> > Therefore, let's introduce a flag to indicate when that is precisely t=
he
> > logic we want.
> >
> > We need a flag, and cannot rely on `is_repository_shallow()` to indica=
te
> > that situation, because that function would return 0: There may not
> > actually be a `shallow` file, as demonstrated e.g. by t5537.10 ("add n=
ew
>
> Again, I'm not a native speaker but I understand the above as
> "There may not even be an existing `shallow` file...".

I'm not a native speaker either, but I'll give it a try anyway. How about
this?

	Currently, that logic pretends that a commit whose parent
	commit is missing is a root commit (and likewise merge commits
	with missing parent commits are handled incorrectly, too).

	However, for the purpose of `--update-shallow` that is exactly
	what we need to do (and only then).

	Therefore [...]

Better?

Ciao,
Johannes

--8323328-1042822142-1709046047=:507--

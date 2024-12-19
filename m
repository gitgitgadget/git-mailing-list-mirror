Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D039FCE
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614458; cv=none; b=JibWmJqW00YIWkYE5d28dAuqczy3WGagE7D+EVVddPWJcc+ouVVH8Am1WMlDSZRIWPQcP4NLQ323yXSvBlp1bLjENjPFT2NaVkDsOwW6Vnx4fbwHKaXv3Nt/THPKQTrNVZN4w/18XqLFMuUF4YZNBG7n6pMkadGmmGvSCuKdunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614458; c=relaxed/simple;
	bh=O0UQD93XZdM+rHPEY1Waab03I4yXqjIg+jkyty1syOU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kVwiJCGvW1zN4teXphBr4PVtE2R4HUCgJLGEafOqBnTeK7n8HiZoFrRwmO9ij+hlAdOGNhxKlzl5XesvAbQb22PaGWlSYEJyyTXMDSUv3Krsw/3h0vnIgOB+ViyPVOfumbglsx/dD37Nl51X4/61URSnkd/yQOmeqS2vRqK9i6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=KmDPj7Ox; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="KmDPj7Ox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734614450; x=1735219250;
	i=johannes.schindelin@gmx.de;
	bh=O0UQD93XZdM+rHPEY1Waab03I4yXqjIg+jkyty1syOU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KmDPj7Ox1TiuNi1upk6tkC4KWYTts06jRjTWJF7lckKHoFP9LlHolCRnxi9iwWpd
	 g/ZSt8dn4V09fbzJRGfcJWWlBSwyL9Ry6yUOPlfPWec8xnt9BbzjeAWHJEwfyuG69
	 32C7TmMp5KeE4d8HFKiwN060C04BqDtaoVd9YLoqIQpujcffMG+HodJnldwi+/rIc
	 epICDw/ltMMnSQZpywlk5JDn5JCgAtlcc28x+bRvzPgJDLb8x/CjKa8SMPFDIVbWP
	 JihXmtcjVhyRkX/OcKL19ku4nEB0n7VR4hucFfFYa13ZZldjojAqdddxO4f+Mjgrt
	 gXXVdk1RxkUmUE75mA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.216]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1t0A1a2tq4-00TUep; Thu, 19
 Dec 2024 14:20:50 +0100
Date: Thu, 19 Dec 2024 14:20:50 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Junio C Hamano <gitster@pobox.com>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] GitHub ci(windows): speed up initializing Git for Windows'
 minimal SDK again
In-Reply-To: <Z2JkBv87zXik5QJa@pks.im>
Message-ID: <0176d617-182c-45c4-3f2b-e0d433901c40@gmx.de>
References: <pull.1841.git.1734447458896.gitgitgadget@gmail.com> <xmqqldweyrqx.fsf@gitster.g> <Z2JkBv87zXik5QJa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:V3pqo8X3uKrlL0ALQn0yAo2qmvv/Z1/6PkbXcC+ZB/4TTa9ghLQ
 oGNv39z1RBFSFNpazBucIdGiuR1fy5Ksb74rrA/U8OUuLU0QjYjJltlzgz92xwPdo0eNTAK
 c0tMpNAYl1qnNTiMKXP/Z3bh0VT4m8RWl/atKuQPn/6MHW4AnT32ReAFuA9Tqf7GqUzOE/M
 kso6DhfbX7F0kWVR5MiXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:grTkCsaXuSs=;Y+bwLN7jrfKuuPwelRd++xkP21I
 CQnC7UX2hmfPXxZCQE4NrykzN+l99aT90Q0cgvljsQKSEty298H9F8z6xqtZflGwAvSJhlYsa
 exSAfLQ+0kXfDNpPNH57erjAWpchStUhqIGXZJOdFfLJ7QAca0CblNqCy9MBw53NJz8qaolM3
 FzFE+zdESqaTyw6uLgi0DGSEVVPXv/7BqIkacxNczeNJ7dQIj3Kbm2RjCnfncOoVjo7pWDTxy
 mAIi0VV4uHTm36u9gEc4BH2xYWBZVenIO2x+wJ8JniuaoxVdf4DwClnXC0UaAL0ZOhoiki2lp
 n1oGhpQbR1ewMFBmHJq1RKEj+HqF0MqyIyJ/fUvDC3HkpwuH0uL1r7MfqXExDzJHGxEM57Mrn
 zlKMUU9DYDriBHQZqXKeKurTIwB5xqw2L31wM1RmRjJeUgjdg9BuDIIV1b7n2d9iL742sIbQ+
 CyL4GM18GffU5Coy9tOfh4xo3/0ni2GiSI5bf776xAemAAqrFQNzwpca5MQSFq4x0smteriqw
 f5Nyywcd/gtRPOzY3cRAP/AGmn8CZvJN3a9bwzE3D9KwUAMagEoPSCatBzgCcMnubPXR9yRIj
 imZOZJzNfCEPAbugjPLiKAKJ5yzmnooBIv47EKQFunvQZRUnOr5Prgfokbs+10rBy8O84UUhr
 0WAT/OFjADtG+MCvCA8Igd71TEsESgGYi5MJCOetj1t9nn7EP/kLXNFRWOpuuDnp2I881JUyj
 znTzPC27db42PvLbH1eVemOUaC6FlHLw72+Cxio62ZumSphW6v9CIPIbA2W0puyz14nS/T0PP
 4e0AzABmEi6z4uwZifTJmouXpfj0kn3uOLFKczbuwTJJJN/XNMGrITTyiK4s1FTsuOvGUKSu5
 53oNxmcNv+nUF6F6+hDpA9W55//hz+UNoFjkXUYS1wiCZM7Kzp9bGVLg1oueRBBldjiuWO9Ps
 KuCWItc3rRcU1dP3wWPfO40VZKEKkYsRlLaAPSLXbd66sCgCWqwFzRxTbRGVtix5CGCx8E48S
 XzUlRlJg9aHAietP4BhRatPewSio2IJoOLyJw5XrZVaJEuQRDq1gF+iTze10k52uXJbs0C0KT
 MKsj52zR9eBkyvTD9D1klIpLdV/7Ma+p3SjPJxW8XjVh3LJ1AusWGInxAfVzjbP8XKS+zdKsE
 =
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 18 Dec 2024, Patrick Steinhardt wrote:

> On Tue, Dec 17, 2024 at 12:33:10PM -0800, Junio C Hamano wrote:
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> > > This commit partially reverts 91839a88277 (ci: create script to set =
up
> > > Git for Windows SDK, 2024-10-09).
> >
> > Thanks, will queue.
>
> Okay. Too bad that things regressed this badly with the change. I agree
> that reverting is the right thing to do for now. I may revisit this
> again in the next release cycle to investigate whether we can get it up
> to par with the GitHub Actions.

The way I implemented it should be eminently possible in PowerShell, too.

Something like `Start-Process`, launching not an `Invoke-WebRequest` but
instead `C:\Windows\system32\curl.exe` [*1*] to download the `.tar.gz`
file (not the `.zip` file, more about that below). Another `Start-Process`
should then be opened that executes `tar.exe` [*2*], and then the `stdout`
of the former should be piped to the latter [*3*].

I do think that it makes a lot of sense to start extracting as soon as the
first byte arrives instead of storing the archive as a temporary file and
extracting it only once it has arrived completely.

Now, why not use the `.zip` file instead of the `.tar.gz` file? In my
analysis [*4*], I pointed out that the `.zip` file is about 10MB smaller,
after all, and BSD tar (at least the version in `C:\Windows\system32`) is
able to handle those, too, right? Not so fast. In my experiments, when
streaming the `.zip` file to the `tar.exe -xf -` process, the `etc/`
and `.sparse/` directories were consistently dropped. A bug, I guess. I
ran out of time to investigate this in more depth.

Since the artifacts are now hosted in a GitHub Release and updated
regularly, and since those updates cannot be atomic (you can only upload a
release asset if no asset of the same name exists already, read: the
automation has to _delete_ that asset before uploading a new version), it
would also be good to kind of expect that the file may be intermittently
absent and add a back-off strategy [*5*].

> It would be great if the build infra was shared between our CIs, so I
> think there's some value in it. But if the answer is "no" then I guess
> that's ultimately fine, as well.

It _could_ be done. But the advantages of having it versioned outside of
the Git repository outweigh the benefits of that shared infrastructure, I
believe.

Ciao,
Johannes

Footnote *1*:
https://github.com/git-for-windows/setup-git-for-windows-sdk/pull/965/comm=
its/6db65223de699c4f75ab083f82f43947a53ad6ff#diff-6855ef61b94227f9264adab3=
ff9f2de95c2d7b4e451019cc0105896d32550eb0R58-R73

Footnote *2*:
https://github.com/git-for-windows/setup-git-for-windows-sdk/pull/965/comm=
its/6db65223de699c4f75ab083f82f43947a53ad6ff#diff-6855ef61b94227f9264adab3=
ff9f2de95c2d7b4e451019cc0105896d32550eb0R77-R86

Footnote *3*:
https://github.com/git-for-windows/setup-git-for-windows-sdk/pull/965/comm=
its/6db65223de699c4f75ab083f82f43947a53ad6ff#diff-6855ef61b94227f9264adab3=
ff9f2de95c2d7b4e451019cc0105896d32550eb0R88

Footnote *4*:
https://github.com/git-for-windows/git-sdk-64/pull/87/commits/fdb0cea37389=
3ce7d40bcfcfbeb7fd091a3c4020

Footnote *5*:
https://github.com/git-for-windows/setup-git-for-windows-sdk/pull/965/comm=
its/3d4ea07041d0740b21160a9d9a4181f569e706d8

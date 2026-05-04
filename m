Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023A3E4C90
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914437; cv=none; b=c0NhRiMrL3f6JVCbOPtahhn3813zrt/QnQ5WY5D9kf9n26uBZ/sjNr5vIWIdS6ISKrAqym3s/910q/q64TG5nH0cQhdZL2XzBKqk+xuXBZoVu3YKxkx3olIj0MzM7cIr/oRGyPwZeSJT9D6nqkadKV+EaSPUR7jU72Ot9zBkubI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914437; c=relaxed/simple;
	bh=rGGtBDPFQL9qRTtaUNBZzkhsWp4EMlKOIkS00mEUcSA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BGv7u3VOH/+S+YyFBWi9l54McaMfYuH+qdfI9Spi8YFvrfg6yv/RKLo36ZHD5aamx4LL9mnNplZRRDRa5arAHW2x8BmG9E+FP1TSHGo/r0klI7NMSx6P07yoacHS+9rEgH7WWf5lAhqwPhkD6WtV8hwPi8+aJLq7b0c89f4IYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=aIjl788q; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="aIjl788q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777914433; x=1778519233;
	i=johannes.schindelin@gmx.de;
	bh=rGGtBDPFQL9qRTtaUNBZzkhsWp4EMlKOIkS00mEUcSA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aIjl788qBIIv8xTk/2YkIzIjfNqn66NCXeP/lsTPbYnIyJWXuqhViPp0nfrrZxoc
	 GeQWSxAY7b4/E+ki9rnBMvx95moy5NAz7jR624dWQFLddUoXQvdhDbt/CVa+dGO9I
	 5sb3Sx/8COSjMUiITxYPdO7/vlp4Sw4aHrq7KUTVMyXwG4qk88OUhAjcilYwJQUx0
	 CNxlL+WxT25B7cnh+oT4rvItplao5r7QLUjaOzR8QJUuSoTs4jAdMXwVsUhfESrS9
	 u6hq9rDUB1HQDdV76Tii4O9El4jFx+uyYFMr8aNIM866bXspAHVZEv1GbBs8pKoke
	 tFVsaBWlNBYFRYQzIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42nS-1wJwlE3wHI-00AXmS; Mon, 04
 May 2026 19:07:13 +0200
Date: Mon, 4 May 2026 19:07:10 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Derrick Stolee <stolee@gmail.com>
cc: Jeff King <peff@peff.net>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 6/6] t5608: add regression test for >4GB object clone
In-Reply-To: <ed226571-a095-456b-9d9e-bcc545d7ddfb@gmail.com>
Message-ID: <7ab69861-1508-106e-5d55-5ce5508653f8@gmx.de>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com> <a3019888d8465e0f77926a91a20db170fef6989d.1777393580.git.gitgitgadget@gmail.com> <e1e8837f-7374-4079-ba87-ab95dd156e33@gmail.com> <20260501063805.GA2038915@coredump.intra.peff.net>
 <ed226571-a095-456b-9d9e-bcc545d7ddfb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OTdD7XWYKEegiO6vp3NDpJxZT8YbrYUri8ANgprWyHxbFsdT2Yv
 SO+KneXwHFGuhaYIeNkx6i/yz++YTCJVjiS9D4QYxdarDj2C+PvpuefO+iIjRJOpS9ccgm9
 9xenYUxHvYZIrxsy6DWwKW7wxXLhpSCcNECTX3xXLIFNKOHClLtiV7RBEYAJIosprwf/dRn
 b6Ajjlq4MXzR5kbng0gXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Le5QsclfBrk=;QrWQBIoAheMpl3GRCBeJHN6ZJ91
 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
 +Fw9BA8CjG4kPAQ==
Content-Transfer-Encoding: quoted-printable

Hi Stolee & Jeff,

On Sun, 3 May 2026, Derrick Stolee wrote:

> On 5/1/2026 2:38 AM, Jeff King wrote:
> > On Wed, Apr 29, 2026 at 09:34:21AM -0400, Derrick Stolee wrote:
>=20
> >>> +test_expect_success SIZE_T_IS_64BIT 'set up repo with >4GB object' =
'
> >>
> >> Your prereq here prevents it from running on 32-bit builds, which is
> >> good. However, I wonder if it would be worth also specifying these
> >> tests as expensive. It's less likely that these layers will be touche=
d
> >> often, so it should be enough to run these on major occasions, such a=
s
> >> testing a release candidate.
> >=20
> > I think it is already skipped in most cases, because t5608 requires th=
e
> > GIT_TEST_CLONE_2GB environment variable be set. Arguably it should jus=
t
> > be using EXPENSIVE, too, as I do not think there is much value in havi=
ng
> > individual flags for all of the expensive tests. I think that test jus=
t
> > predates the modern prereq system entirely.
>=20
> Thanks for the extra details here! That helps avoid the issues that I
> was thinking about, but maybe doubling-down and adding EXPENSIVE is
> still worth it.=20

Indeed. The `GIT_TEST_CLONE_2GB` flag is set for all CI jobs:
https://gitlab.com/git-scm/git/-/blob/v2.54.0/ci/lib.sh#L314

So I've tried to accelerate it.

First, by using the "unsafe" SHA-1 (because we're in no danger here, we
generate the data ourselves). That helped some, but unfortunately the most
efficient implementation (OpenSSL) is out of bounds for us because we
cannot enable its use in the default configuration for licensing reasons:
OpenSSL's license and Git's GPLv2 are fundamentally incompatible with each
other, and even though Linus' intention with
https://gitlab.com/git-scm/git/-/blob/e83c5163316f89bfbde7d9ab23ca2e25604a=
f290/Makefile#L11
was clearly to allow linking to OpenSSL (actually, requiring it), there is
one Git contributor I spoke to who flatly stated that they'd block every
attempt to add an exception to Git's license retroactively to allow
linking to OpenSSL (at least for distribution, which is when the GPLv2
would kick in). So that's that.

Second, I added shortcuts for the 4GiB+1 size exercised in the added test
cases. That did help! But only the generation time of those packfiles is
helpd by that. The `git clone` that is tested is still awfully slow, and
that _cannot_ be worked around in the same ways.

Therefore, I ended up marking the test cases as `EXPENSIVE`.

To allow them to be run regularly anyway, I added a final patch to the
series that lets the CI runs on the integration branches (other than
`seen`) run all `EXPENSIVE` test cases. One could argue that this patch
should be split out, and I'm open to it, but in the interest of keeping
the time I am working on this patch series _somewhat_ closer to what could
be called reasonable, I'll just keep it in the patch series for now,
hedging for the possibility that maybe nobody objects?

Ciao,
Johannes

> >> I suppose this also is a question for Junio and our process for
> >> validating releases. Do we have a certain cadence where we run the
> >> expensive tests? What has been our threshold for hiding a test case
> >> behind the expensive label?
> >=20
> > AFAIK the labeling of expensive things is mostly ad-hoc, and nobody is
> > systematically running them. Likewise for the t/perf tests, which are
> > super expensive but do (very occasionally) turn up interesting
> > regressions.
> I used to be more diligent about running the performance tests myself
> around release windows. The EXPENSIVE tests would also be good to do
> on rc0. I will contemplate how to put this into my routine.
>=20
> Thanks,
> -Stolee
>=20
>=20
>=20

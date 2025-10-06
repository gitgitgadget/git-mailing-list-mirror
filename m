Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112E835972
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785428; cv=none; b=KPQO+S1RHWMzuIL4Htl7sL4qbXGStfMvDqZR2cFaC0dCkhJGZbpdjCi3KA/yArECIVe/supBRkHZ6xoE1uev1H6NinrimE6dYRPlA/Fb7OH2Unmw9YgB227TgpvctaNGkhtBalSiBXZtB6yecgtQh4MjNcef7i1mhrI21wMioN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785428; c=relaxed/simple;
	bh=g5XdgvE9Yva16lsCYovWZ5uFnubQwnKDKJjqGj2i8w8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UGOlY0vKDe0jsaIHWVpkeLf69ZYkJR8Kqmsky7tjJC1GYR7o78ulxjHj5IO0InbM7zQ12zp4w/EH6khAxpxQmqNnpDsteiASLIOPVNqs+/znyuNhZQABRw5rUVryBeoPs/aaGlTdcEJzDb3bfiHuz2dm1BSnv4I6jHSbLwxy5mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=JIKeTbRK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mmHkPsA8; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="JIKeTbRK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mmHkPsA8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1580B1D00450;
	Mon,  6 Oct 2025 17:17:05 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 06 Oct 2025 17:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759785424;
	 x=1759871824; bh=/fj1Qh+eWs1x2mgJ06DOxWxg2bvtHLy9rL4GfCn1DaY=; b=
	JIKeTbRKfixCm4qhqyxTM2Qd3IHho89wXzKval7YXpZymseyMnNkOrFMcZ+Pab3B
	x5HVIfZUvGPGEoLafjFvz1sYRFjCOHUIrLad2h2VYeoiiv8rDMR/Ve0fMaMynJpB
	jqU0sfeAwVSV2Sr+lZdEl148LdSjusp9nmwf475HXQtZkeuZwOuwsLXJnpSXCzDV
	vi8n1/tcekESK/3hIZVkeVDvDFpHWIF3g5m1q5PD/k22b9dZWfnnB7mtO3DS/Nxu
	Mj8oht4FsUNimsnc5gJ3JZkYRl1vd4n6gsF7A7WH/+9avPYTnbKljt2ZCh3173IK
	5bk8QS25hKD/VZ/drD+L5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759785424; x=
	1759871824; bh=/fj1Qh+eWs1x2mgJ06DOxWxg2bvtHLy9rL4GfCn1DaY=; b=m
	mHkPsA8ANEpb5+tyvtWeGCcfrsOa2O9Dpy7nph7TYdH0mb3uwy21OsefQ8s61bsK
	OVdwhjEMZ4jnUuIwFFSmXNylGJ7LxJKyGurj6C7fj3dy4HCjFyhUvCmRFcejuzCO
	2GDBrXc1hdwYQKrH4eyBMr1f/K+ZN8g7zs+Z1JdiaokoYp465x0e9N+IA+QNhrdn
	yZr4V/fIdtYpZ97OE/rDfbNvhC6J2nXfCmgbSc6s5YdX9AMj486z9+TF40KH8gQP
	jWIJp7i04hOl0Ht5QdbEJrS4t0+F2vHHMsY/hOVRWnZwTi2IPIWpGTNDXahZfa3M
	e/63/43rStWjlg5ws2OfQ==
X-ME-Sender: <xms:0DHkaAWhGHkvFiPNThlKqAmQ_T7JBgvZJax8yZhaSoJhLFCiuXaMLw>
    <xme:0DHkaPbgUVJN_yuRxnH9PIiwbLJQRQhzoEdG5_SdTglmlD2X_hRbRotd7Dq_QilOM
    Se9-cpSCe3RfDKfO9aR7uM025of5NFE1IoM_0Dzze4yqGXy9CHydEI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    efieeigeegtdefkeejgfdvteejfffhveeuuddttedvjefggeevfffhleegvddvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrse
    hjvhhnshdrtggrpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegthh
    hrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:0DHkaN8eJ2hPctDtZfd77Gpv-8Dn--LeL45ISxrnPKkUOjpIfmec1A>
    <xmx:0DHkaPiMGC9MuYuddglbWzDdDyuystPiiIG_Rzud9515wKbJtSQhJQ>
    <xmx:0DHkaFcL_M0fY_QaZ0vozRefGo5-EuY6FLWE3c-lWY5C_WMJPQBTPg>
    <xmx:0DHkaOpLS1v_088G4MjTEEmyDe92zUdDyze6emJDq0JLPUObR70fOA>
    <xmx:0DHkaHsdpvMyUGQv7O_BV2e6DsX09m_PjCbXMX6AWDAAC-SfBYE6SwEv>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9A32B780054; Mon,  6 Oct 2025 17:17:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATtqAgZ0pDEJ
Date: Mon, 06 Oct 2025 17:16:44 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Chris Torek" <chris.torek@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <6c8790b7-2b8c-4452-bcc6-2fa17d08ec86@app.fastmail.com>
In-Reply-To: 
 <CAPx1GvfK5ZKUG86n=DR8LeO_STwO5FAkDzzD9t6d9R22KdOySg@mail.gmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
 <ffbb9d7c6aff77f9a1caed86a20bcc6b9afe66e7.1758656702.git.gitgitgadget@gmail.com>
 <CALnO6CCkWaxZKGseHR7dk20erFPAvGMqO+OYr3Np+y+=1Y34HA@mail.gmail.com>
 <CAPx1GvfK5ZKUG86n=DR8LeO_STwO5FAkDzzD9t6d9R22KdOySg@mail.gmail.com>
Subject: Re: [PATCH 2/4] doc: git-pull: clarify options for integrating remote branch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Sep 24, 2025, at 6:38 PM, Chris Torek wrote:
> On Wed, Sep 24, 2025 at 1:23=E2=80=AFPM D. Ben Knoble <ben.knoble@gmai=
l.com> wrote:
>> > +First, `git pull` runs `git fetch` with the same arguments to fetch
>>
>> Hm. Is it worth saying "similar" rather than "same" since we don't
>> pass e.g. `--rebase` to `git fetch`? Or is that detail unimportant in
>> this context?
>
> I would suggest "equivalent" or (perhaps better) "appropriate".
> Perhaps even:
>
>     First, `git pull` runs the equivalent of `git fetch` with the
>     arguments needed to fetch necessary branches from
>     the remote ...
>
> Definition of these arguments can be deferred (perhaps
> even indefinitely); but:
>
>> > +remote branch(es). Then it integrates the remote branch into the c=
urrent
>> > +branch.
>>
>> Plural-singular here leaves me wondering how Git decides which of
>> multiple fetched branches to integrate.
>
> here we'd need something along the lines of:
>
>     Then it integrates the appropriate remote branch ...
>
> and here we *do* have to define "appropriate".

I like the idea of adding "appropriate" here. The question of how to def=
ine
it is a little messy.

We do define "appropriate" below under <refspec>, like this:

> See <refspec> below under "Options related to fetching" for the full s=
yntax,
> and DEFAULT BEHAVIOUR below for how `git pull` uses this argument to
> determine which remote branch to integrate.

Like I mentioned in another reply I think deferring the question of what=
 "the
appropriate branch" is to the DEFAULT BEHAVIOUR section like this does i=
s not
a "good" long-term solution because  that section is so confusing, but I=
 think
it's not worse than the current state and I don't want to expand the sco=
pe of
this patch series too much.

However! I think there's a question of what behaviour to "encourage".
Over on the `git push` side, we decided to highlight using
`git push origin main` to push, because the behaviour of `git push origi=
n main`
is simple to explain ("it pushes the local main branch to the main on th=
e `origin`
remote").

So a natural next question is: should we equivalently highlight
"git pull origin main", to mirror the `git push` man page?
Then it would be easy to say what "the appropriate branch" is, because i=
n that
case the branch is "whatever branch you specified"

My initial instinct is "no":  `git push origin main` also feels sort of =
"foolproof" to me,
in the sense that if you accidentally run it while on the wrong branch, =
nothing
really bad will happen, since it doesn't matter what your current branch=
 is.

But `git pull` is not the same, since running `git pull origin <wrong-br=
anch>` will
integrate <wrong-branch> into your current branch, which could get confu=
sing if
you accidentally pulled while on the wrong branch. Personally I use `git=
 pull`
without any arguments, and it feels safer to me that way because I know =
that I'm
likely to have set my upstream to something reasonable.

I also did some extremely informal and low-sample-size Mastodon polling
and my sense so far is that folks tend to run `git pull` with no argumen=
ts in
practice. So I think it makes sense to highlight the no-arguments versio=
n.

And in any case if you want to get really specific about what you're pul=
ling I
think going straight to "manually fetch and then run `git merge` yoursel=
f" is
a safer approach instead of passing arguments to `git pull`.

All of that is to say: my best idea for how to resolve all of this is as=
 follows:

> First, `git pull` runs `git fetch` with the same arguments
> (excluding merge options) to fetch remote branch(es).
> Then it decides which remote branch to integrate: if you run `git pull`
> with no arguments this defaults to the upstream for the current branch.
> Then it integrates that branch into the current branch.

This explains what the "appropriate branch" is in (I think) the most com=
mon
use case and deals with the "same arguments" issue.

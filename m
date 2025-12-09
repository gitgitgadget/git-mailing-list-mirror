Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC04315F
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303534; cv=none; b=ewgSzz62QW51KNY3uWpquHplANaebZUG5cQkTn0cZqtQ0rAVKMwQrE93L8JspyUqQ2dHaeet88ixCvucNKbq06s9j8n6h14+ocZeOBeW2U36M+Q+xr95NvCSODhLfbshMRoSrCpvEVj3vWdhyWIV4JdoeSeIjED6UhFu2TdJM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303534; c=relaxed/simple;
	bh=XABnYywKg8vrPs2QmvMQq5uaL7xijLs0nWXP8njuhIs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mGzhsiAdYI8nUVOV0ll1FHIFiYImNP+J62wTgmQtbGfzxUQ6zch1HwVUHXRBxfrRoNmUYHwrdlMd/ezZj8wamglgYmYfqTn8OpXExJw5qEsKTPfKLBPPvk+1EsfrgXxjVLWloo/LvLGXUXrH5VT+3a472lVbaCDXOiMA4IJsus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=orEvPJzM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q4nzUGCk; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="orEvPJzM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q4nzUGCk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A9CDDEC018D;
	Tue,  9 Dec 2025 13:05:31 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 09 Dec 2025 13:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765303531;
	 x=1765389931; bh=xKBAC/9jd2XJyGW+jlHFWWgarNdTo+0R7YjYQwbVKPI=; b=
	orEvPJzMJkTblee6ueXZUxBUS0pfindQ1hRDVZ1PTdI+IxQmhDqBz47MJculLjk/
	DKUPnfLsx9trZ2gzAvpWEXgmsB9HrAqhVLd/neYF494JdRSAGwUryUI/YWotnzLD
	wqVaWvBbJHf49m/Tc9eATXr2yOdbpfTQz1dTOvQlgde5PrjOIUtgqMSsUr26N2nV
	Gnt2OLKKyhVFV0d1NAb6XB7DrnxjosyQVzPh2YTzVmOEyrvV6AI3JY5xau/juZSe
	ID8+2RhsCBOzZLUrTftPRTMPz4japJxruVmxhDGUKTlMr09Z90kck1v5iF8qtM0v
	o7oRVXfsoBsQ0+cutuUO0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765303531; x=
	1765389931; bh=xKBAC/9jd2XJyGW+jlHFWWgarNdTo+0R7YjYQwbVKPI=; b=q
	4nzUGCksCdgrSEWQDHy45gGVS5Z6RVmhi9ee+876hxlYVjWmnAoUVtt9w24XNQOF
	VpYVbMCt2W6FKl+uMvrJ5y+exSV1qKMF+wI4uX63i8qpJpRSrsP2jBs9QTalmj3n
	0Z/uQ+fQsHO6IEUSujeOKFz9y/gV3mud16k2Xey/M9zOCISFgx07Rz+kuIZEwz0I
	qWN0mnhlM1nU6qfre4Xx7Ss1oyIDUEu65pUUbZj01YYBalSOd8YPgLF3bYUYzosy
	AEGn9NQ0T0j9iMTie0rvaqT/m++0cFbun9AGMtLJrw5uZtipufAAM6xmTTgQu0q/
	hZaDALvJKkaossqzuycQQ==
X-ME-Sender: <xms:62Q4aeG2l81NqeIZEvToDGsUC-g_8BA6kgseF27LnaEPauupkGC-5-0>
    <xme:62Q4aaLX4WjM9b2LabDTXmsbCsnvS-1ZC6rfFNiAnU-ItpqvoACtG1eE5VGXoFlj6
    K9wkMeXC3W8HbmRUjMxrUH0LaRc6QE7cwZ-A45wb-B1mzURcY3FXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:62Q4aTwLw1zZ2LuDxbehK1O-r4TMc4L3I0hDeYE4chYn-xD4ZnKuYQ>
    <xmx:62Q4aUkgYQJ3p3zfd7Tx9mcCzSkA7o6dDGpcu7j1j6sR0bh7xrXWyA>
    <xmx:62Q4aUkkHr7PmE_dHZyVcrQrp11sJ876YoqDeTwCiMOhiwTw4jf9kQ>
    <xmx:62Q4aewn61ftiyjCxlovDCp7x6e2FD3fBhSz-ivrfYzoZtrxA6pf6A>
    <xmx:62Q4adapCyJYIpMANWun3mlGVE6ufSIEpMUHcbwLhsn0SO-5dQDMptAN>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 751171EA0068; Tue,  9 Dec 2025 13:05:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_-Iu8LU1e_w
Date: Tue, 09 Dec 2025 19:05:02 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Christian Couder" <christian.couder@gmail.com>,
 "Elijah Newren" <newren@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <753daaa4-e675-4d28-9c13-4f5ede0f3b47@app.fastmail.com>
In-Reply-To: <xmqqms3tkux8.fsf@gitster.g>
References: <CV_replay_conflict.101@msgid.xyz> <xmqq1pl6lzt6.fsf@gitster.g>
 <d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
 <xmqqms3tkux8.fsf@gitster.g>
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output on
 conflicts"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025, at 13:41, Junio C Hamano wrote:
>>>[snip]
>>>
>>> All looked sensible.
>>>
>>> The second one looked a bit sketchy, but that was the phrase used by
>>> the log message for c4611130 (replay: add --contained to rebase
>>> contained branches, 2023-11-24).
>>
>> How should `--contained` be documented?
>
> The text you added uses exactly the phrase used by the log message,
> so the author of the feature apparently felt it is good enough ;-).
>
> It just felt that "contained in <revision-range>" is understandable
> enough.

=E2=80=9Cis [not]=E2=80=9D presumably.

I read it as this with pseudo-decoration.

    abcde (refs/heads/topic2)
    12345
    56789 (refs/heads/topic1)
    0abcd

`topic1` and `topic2` are contained and will be updated.

> For example, I am unsure if somebody who read the document can
> accurately answer the following question:
>
>     If you forked 7-commit series from v1.0, merged the early 3
>     commits to the 'master' branch, and merged the rest to the
>     'next' branch, is that branch contained in 'master..next'?

I tested that with, let=E2=80=99s say, `topic-1` merged to a `test-maste=
r` (and
`topic-2` merged to a `test-next).

`git log test-master..test-next` was as expected (no `topic-1`). Replayi=
ng onto
one commit on top of `test-next`:[1]

    $ git replay --contained --onto=3Dtest-target test-master..test-next
    <exit code 1>

I guess the =E2=80=9Cduplicates=E2=80=9D (patch-id) cause this?

>     Or it is not because the bottommost 3 commits are not part of
>     master..next?  If it is the former, is it because the topmost
>     commit (i.e., the commit pointed at by the branch reference) is
>     the only thing that counts, and it indeed is master..next?

It=E2=80=99s a somewhat complex case compared to what I think is the usu=
al one:
a non-merge range of commits without any patch-id-equivalents on the
target (fingers crossed). And the setup without merges: two topic
branches in the range gives the output I expect:

    git replay --contained --onto=3Dtarget2 <range>
    update <top/second>
    update <bottom/first>

I think the original phrasing is understandable. But we could add
an example.

    For example, if the range contains five commits where a branch
    points to the newest commit and another branch points to the third
    commit ...

And should the description in the source (replay.c) be updated as well?
This goes for Phillip=E2=80=99s point about =E2=80=9CRequires --onto=E2=80=
=9D as well.

=E2=80=A0 1: By the way: me mistyping `--onto=3D<branch>` where `<branch=
>` doesn=E2=80=99t
     exist causes this error:

          fatal: Replaying down to root commit is not supported yet!

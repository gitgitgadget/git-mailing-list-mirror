Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439035E1B8
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788565372; cv=none; b=qxwHbg10wGtxPOHjae1zgEr7ybnU4ET6s95mEyNiSYtefsw8Dz0WRyXZ6+ROC2Xx+MfpS7cI55FmFhpGtP76EbbWv9Kf+0akNPexoI7puy7TdAETkcE2mhzPnZN8NOM9c5COkciPpBYujaAnkHqF/H92rv0qxqWuHUKqEsWvXn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788565372; c=relaxed/simple;
	bh=IuXgEE9iuKsJ6H8/DgehramAi/gSbT+skvbggCM8PoI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FIQynR6jeqdULxljr0S8y0eoLKZejMtzDRbYhLIv9p/j1WEedMfmRB832g2pU2rycfLzVxakspugRazDniX4sRc1PDYCyjj9yilWtogmd5b7UWNaTWoOU4pgbcgMiO91vM85JAoImYg8ArE18EI1clvTlQc7+RoefCGGecGCGyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artagnon.com; spf=pass smtp.mailfrom=artagnon.com; dkim=pass (2048-bit key) header.d=artagnon.com header.i=@artagnon.com header.b=k//oTYF9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qefRgGb5; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artagnon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artagnon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=artagnon.com header.i=@artagnon.com header.b="k//oTYF9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qefRgGb5"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 57E481D000C5;
	Fri,  4 Sep 2026 19:42:49 -0400 (EDT)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Fri, 04 Sep 2026 19:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1788565368;
	 x=1788651768; bh=IuXgEE9iuKsJ6H8/DgehramAi/gSbT+skvbggCM8PoI=; b=
	k//oTYF9dw76m2FGKthgM7MqqNlsjtBHl+j3lwvz2jPY1K/6GDjptlQcsqHWdoMW
	2DnYsa08kTFlUul34/NxBQ5g1OXUtAfwLeaWn4/8lLKD+RU9I8YfLtTwsNQnM38A
	HKvoGJASbmPM4Dy7K3bl5JEAXsH5wHyG88gpndIuqa7neixTHdXGR32Oyh2RcBmb
	7nbvMfhFRgfON0M0j+nqid48h4aYf5/Q0RWnkVoDo6ehV/sfw72t4dnjkTpTPozg
	Z5OWhQFRNAty8EhnzG+AIkSmob35zWo+nV7e03s6m5ODWn0efkVFYCcvyZQ3a8cv
	Rmt64p20X37WOwrnZ0zR/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788565368; x=
	1788651768; bh=IuXgEE9iuKsJ6H8/DgehramAi/gSbT+skvbggCM8PoI=; b=q
	efRgGb5WC70Ne16qcTweSIXNPE5hcaw8JYRhnYeVzIwgoAzPINtkCcV3YLLD8c4K
	rqvT3uldZgWznOyp9TGiSX8e4O8BR941JQqhy7NztVUrZKWf5n86eB+NSvTYcsvO
	YJ9/1lwwTjj5IWiDH0+5C9fwoPg8Y/EhGO55nAAOK3o2n3OePw4/DCoFixk7YrqM
	2kMNngENdUgXBBkL727HA9F4dBTVDmFvU/24fcgCQFHhX13rY3a9jymrI237nPLr
	njZ7eRqTR9dqQgrG24DQdVGbxe13x6BsVU+CDNXc79b/TPdTrsN8KCnKw/DjnuU1
	hG2m6ix2X/x8ExF4jCdHA==
X-ME-Sender: <xms:dVebatIJydQXaL8PK8GTozTNcCwOJxWyks8WhQshjUgNfDWBH9nkhg>
    <xme:dVebaj-ukj0EN3YZ8GiMH6cedCSoW8DiDhSj6aJGXTwJfaIkJSow--4bQXKMbB4OC
    o-63XlDNrfGaDEdId5Nxnbsxn5Yz-NOWrCa1tgsBDy6vRZOR-s2APc>
X-ME-Proxy-Cause: dmFkZTFxIqhP6WtBpqKTTAbg5+zm93KQGoZRHjFsNw/dqyLXk+sxEE1YsLbBPOSWyM9gx7
    i6xAUpqPu3O2KyQCACSuFcw1pCQGTVRnzW8vjsQmr7KVDGFO3Y5ItW/Ch7AM4+g/ItKJcv
    tnZ1UXjRyI3su9dav9CItDwsSqBs0zqfCEDWMbAW2PYlfZ4TrPAvwYFPkpQJnA85cB08G4
    PSn9VISZWgn+GGxddpqe7O6EujSTf9rHzwdUiIY3nCmBK/d2V8P3NffAAR4eJFcyTxrbFa
    Pp4oXyw0FaaI2J/q6Jn+5y+LBVl/nBx8/qD42Jd1x+u6wFLLB6fZyzBEsYp84fYS2/mcWR
    8AOvOwgbiLBN7w7T64DK2Shhj2e0Nnn1EfBQKN6L+LbeHppoiFfNzLioDxSl1MOfXSFcF7
    B74q9xEm5B0BX7DJK8bT2LD0YW7L9B044Eu8BEGTFAn0icIWXSFBd683axJZgadJa3+yFi
    UJQTqBStMR7dOHvL9AGy09be4tdYPInNqzaPlVDD251x+qcBywE5yrjWd62Jgc4si86q20
    Il826/omCktjHf4rrMQkF3AtVnKQsN/biIT00aX1hNq7loEfy+Y9RjEFZEgFzDWqfJIyLZ
    NCeUv293QvpxpDzvnkQSGYtrsG7fMznOhqpUle0IYRFmvsab0Js5evjIaF8w
X-ME-Proxy: <xmx:dlebahlNWomy2sUpYfXRlt8Y0VI6Y2_l0Dzh65nUXs6uAtayrAURmA>
    <xmx:dlebaknNjUblPgdB28FHjALBTI_HEpgloPS5Qkkp4srrffZNg710wQ>
    <xmx:dlebaqt5fWgXJI4J7-JhnsPwi46tPFiOuupZ1ZOrgWg8_K8CwfKawA>
    <xmx:dlebavnw8bajk4alUzfP2zEFcDcbY_kGXkL8zff5-IAEJrrPwXcYdA>
    <xmx:eFebaobNA8HCYHKxGZF6pD2o1fd3ll1o4l2ihzepGMYq7AOAnLHrQUME>
Feedback-ID: ifc014702:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2EDA8F80082; Fri,  4 Sep 2026 19:42:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHWNdWDjOfzF
Date: Sat, 05 Sep 2026 00:42:24 +0100
From: "Ramkumar Ramachandra" <r@artagnon.com>
To: "Ben Knoble" <ben.knoble@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Git List" <git@vger.kernel.org>
Message-Id: <75f1e307-e567-417a-96d5-ca4f7796c624@app.fastmail.com>
In-Reply-To: <A918E4C6-AF5B-47A8-B2FF-69E87F6118D1@gmail.com>
References: <14ec96fa-897c-4bf6-a2e9-cd0c6e9b4474@app.fastmail.com>
 <A918E4C6-AF5B-47A8-B2FF-69E87F6118D1@gmail.com>
Subject: Re: User report on git 2.55.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ben Knoble wrote:
>> Le 4 sept. 2026 =C3=A0 19:13, Ramkumar Ramachandra <r@artagnon.com> a=
 =C3=A9crit :
>>=20
>> =EF=BB=BFRamkumar Ramachandra wrote:
>>> brian m. carlson wrote:
>>>> Do you maybe have some sort of security software running on your Ma=
c?
>>>=20
>>> I think it's clean, but it's still a possibility that the workplace
>>> installed something recently: I don't see any other strange symptoms
>>> with any other software though, and everything seems to working
>>> reliably? Perhaps the most common task: I run llvm tests over 30 tim=
es
>>> a day on different changes, and it never reports any spurious failur=
es?
>>> I will nevertheless ask the IT team at my workplace if something tha=
t I
>>> can't see was installed. I don't use my personal laptop for llvm wor=
k,
>>> so doing that comparison is not possible.
>>=20
>> I found the malware: it's Crowdstrike Falcon x(
>
> Hear hear. I haven=E2=80=99t observed issues with Git (based on next, =
I=20
> believe) I compile and install to $HOME at work, but I think we also=20
> use CrowdStrike Falcon. I=E2=80=99ll keep my eye out, but the scale of=
 repos I=20
> deal with on that =E2=80=98puter doesn=E2=80=99t come close.

I found the exact issue: Falcon is scanning every file on my machine -- =
since the volume of changes on the LLVM repository is very large, the hi=
gh-speed internet, high-speed filesystem, high-speed compilation, and gi=
t is are are constantly racing against Falcon's slow scanning, and faili=
ng; that's why the problems are random and non-reproducible.

R.

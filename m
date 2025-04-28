Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798F19309C
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745865431; cv=none; b=YMMzLlOZyyesupMPNhgeURuGBIk5JObLd+i2caZG7X2IUqppeVLQRrEJyySnl5GMbxMDHmewLExCMIHWyvC4bTGPxKscYZK9HXtRWRPGcaXi3urLDAL7eaoPgYrWZLlgfAgouHEUcD89c1iqUwPIo7EYE78Ppz47j1Re2ktjsns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745865431; c=relaxed/simple;
	bh=lljg6p2hN5/cYZ2xdWitpOqflu0/4rKDezDcd5P82RM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ni01hIS1h03lA7V4wyxjwoj2yi1C0/kN3PifG9//wP8eHKrT47DK0Cv6QN16Tz1H29KIl3JNmckmr1rR1lK7BRe9d+PpUz0YI9JRGGnQdRV2ACeeS8jg0nMpV84WDzIkMVTWbdMWeAU49rPuHZCU1wrQ/yOvUIgHoK3Jzdi/pRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fkadZYTk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GGj1/uAy; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fkadZYTk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GGj1/uAy"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id ABDD313808BB;
	Mon, 28 Apr 2025 14:37:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 28 Apr 2025 14:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745865427;
	 x=1745951827; bh=NO+8pbnuU/OnyN1/Iw42ffyDhiv5KnIZRFsM4yIImtM=; b=
	fkadZYTkWLgHNAPpksScwAX37jQSuy1cgs8ls15dzB3+zrqJhVEZmkqq/QKJ00Jg
	zHuUZRHBQtxjHAqIh3hEUrzo9jBEQGCwPU6qt6ej4x48W2XHqz3zwcNC5iRl16rC
	8UUdIdiMwGMhh17RYWz3IHxcRURdkWsm3ZVMkfMPfITQHfdWH2UcmZ+YIXG7vUCd
	ldN5hh3x60rdfJFKmZ8xg/tCs/8IUWFkYRMp2kNzu+kjL6D7C8DH5yC7qGqHWdm7
	TMhNfCWGoU+SxtcSiAAp3qaFpWjHbNTU2zQ4VyNQOBPUQAf4Olsr1cyD5nRqIhdC
	01EjVZWkUGaKXBG2pucwJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745865427; x=
	1745951827; bh=NO+8pbnuU/OnyN1/Iw42ffyDhiv5KnIZRFsM4yIImtM=; b=G
	Gj1/uAyQ0sKWhKKLrKZ/m5C0yuk77U36bAJ1sIlmhZ6lgCcpJ32m3Gmw3ytV5nLx
	3NltqMO5xdqAto4fbC+B9K0jbPBuFTyyCH5s4im/qLulMJUgZqBC42uLCkISgiWO
	CvFrs8BMllXsp6tqGwonPVmrBoiDVbimpeVPHC1isGYdmErHYlLmUh4UBd8knCAr
	1jO+N21E6C14lNjrV+YXq8l0pGcXB2Pnf0NNuHQOqjkqhcWqHvv41MWEPafL1OJy
	cwKBf3cUjg1AjoJV1On8H5kEziPwjQthElOU6iYF+12oNYo1XboDy54Zx0AYfF64
	WK6yydFiRRy0f1eMKb72Q==
X-ME-Sender: <xms:08oPaJa9UrIkpt5YZe8LAvXOERytpzixHCKJtmYH1JEmGihORvC0tw>
    <xme:08oPaAaZzWUq86SAyUkh2OXsTEhZMX8BFZCvA_XVn_4R17wPMSNJhmazG-VrgZtlt
    0hkJOEFdPUuZbkMmQ>
X-ME-Received: <xmr:08oPaL_j7Uzn0ZTMxDPAOgw-JoJZotU6QHy6KW0czpQBF0r9Y0VtkQ1B241BI9lUoJ7qJ8IuFVVj7BtLVTBB0uaoQBkNaTyn0W_h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieduieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefgiefftdejhfeftefhjeekffffudei
    udelvdetueetgfeihfffvefgjeejtefhjeenucffohhmrghinhepshgtmhdrtghomhdpgh
    hithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    egpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhs
    hhhinhgvtghordgtohhmpdhrtghpthhtohepvghlvdegiedugeesmhgrihhlrdhnthhurg
    drghhrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:08oPaHr-3laTjrzgWktlJl9HtPjr3d-pn70jlk-TbBT0hzy9Ab-Zrg>
    <xmx:08oPaEq6T_bDs6vvU5RMe-XmhL_Z6jfzjwTeML_EqC2UFxXZGH1V7w>
    <xmx:08oPaNRpb-oNIQ6Sqd-iPFccBcK-ao8QSvsL7RJQmXN0hkYFwbmsNg>
    <xmx:08oPaMoYksQdaLYOMiBlDTYHIKag1SbThN2prmvFLNmmlZJ4KPzwaA>
    <xmx:08oPaBzWhuYNMn0I4siymJL0RFKZthrXay41_xEMppYOJVdnnIcWc1H5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 14:37:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: el24614 <el24614@mail.ntua.gr>,  git@vger.kernel.org
Subject: Re: Probably typographic error in tutorial 2
In-Reply-To: <CAPig+cSfbW9zG0Jv_t8QLFz6SPHFk=2g-eDirEpX8D0ytNWpXA@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 27 Apr 2025 17:54:35 -0400")
References: <15509dd701ace6793f0ae19368e4c0c3@mail.ntua.gr>
	<CAPig+cSfbW9zG0Jv_t8QLFz6SPHFk=2g-eDirEpX8D0ytNWpXA@mail.gmail.com>
Date: Mon, 28 Apr 2025 11:37:05 -0700
Message-ID: <xmqqzfg0ceum.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Apr 27, 2025 at 5:44 PM el24614 <el24614@mail.ntua.gr> wrote:
>> I think in tutorial  2 (https://git.scm.com/docs/gittutorial-2) in the
>> first code box the second time that file.txt is edited ($ echo 'hello
>> world!' >file.txt) there should be an additional ">" because a single
>> one will overwrite the contents. As far as i understand from what
>> follows bellow, the text should be appended.
>
> Presumably you're talking about this example?
>
>     $ echo 'hello world' > file.txt
>     $ git add .
>     $ git commit -a -m "initial commit"
>     ...
>     $ echo 'hello world!' >file.txt
>     $ git commit -a -m "add emphasis"
>
> Note that the initial content of `file.txt` is "hello world", whereas
> the updated content is "hello world!" with trailing exclamation point,
> so the content of the file does change (indeed, the commit message
> "add emphasis" hints at the way in which it changes). As such, the
> example appears to be fine as-is and does not need to be changed to
> use ">>" instead of ">".
>
> That's not to say the example is ideal since the difference of "!" is
> potentially difficult to spot. Had it instead been:
>
>     $ echo 'HELLO WORLD' >file.txt
>
> or some other more obvious change, it probably would have been better.
> Please feel free to submit a patch to improve the documentation if you
> think such a change would help.

Or append "Goodbye world" to pair well with the first sentence?

By the way, I noticed that the URL given in the original post gives
a log-in page.  IT IS *NOT* the git-scm.com that is associated with
this project, but is somebody else.

The URL the original poster meant is probably

    https://git-scm.com/docs/gittutorial-2

I do not think the typo is malicious, though, and scm.com itself is
run by folks who have valid reasons to own the domain.


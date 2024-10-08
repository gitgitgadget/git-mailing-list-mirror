Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5D33986
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409498; cv=none; b=Q5qAIlEkGydMGOa24KFcUrtz1U4Kg8IxL1qGbBEwRPnoj6cEv2Qa89AdeI85wMW558bBIib3fFkYlHSVaIejNz5hCUwH/avBnW+ckmYg2uWlZ2ktm7jrR5B/8G97AQns7E3gFjoO9Vm3aj/3KbLlEbgrk0d4/9il4WLFqIThkL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409498; c=relaxed/simple;
	bh=ZhQlNQAlF+W1R2iPjKx+eenq7tSZ0UPvr89vWsoseVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M03NfxcWXc7G2xBjyvdAN2Zc4JcTFPA8VNumdMDizK8V0TXVDfIWAAnSJGqpZyYn0eC5KX/ixvddO9v+bRiSw44uQTkFrdQIyAM3wJTs7IYLVbOAz9YSbF7ufcWDKCf1z0weWdGkTexybLk+YiAEbDtGyksX7rpQ2Ssnv71I5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EyZmelnn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UCu5uWxy; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EyZmelnn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UCu5uWxy"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 24FD7138025A;
	Tue,  8 Oct 2024 13:44:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 08 Oct 2024 13:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728409495; x=1728495895; bh=cj4BnfPu6q
	Ja32XEA+7DW27PBKtiPObaXB3ojRCzaIY=; b=EyZmelnnU3NJc9TJpM71adKYSC
	7sj2z/sK/Ksb5k1jTW1zGuq1r3Bg4U19qS3vtq8oRbbYb810jC2RVx7VB9Dl2+l3
	HU1TJigb1hT12bptz5sCns7cBnbH2eU7C6bWd7tb9a6AklLiY5xcJWqUHi0s9l4L
	ZSOe0XpyWWs5cn77SqXHaG+Gj37eixIQG40WJjgeSo4hdux4Sxz3emRCTOeh6gk9
	WVrA5pOQG4o346wc6AZTiGnSGEarztI5vLFbpcy+vMXidcISf3Wb9c12chU2MpBi
	ul4Y/zlBtH55O2hkyzU2BCnFzZilj/IHLmOpma+ROAARt6Thygmz+owGfXlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728409495; x=1728495895; bh=cj4BnfPu6qJa32XEA+7DW27PBKti
	PObaXB3ojRCzaIY=; b=UCu5uWxyhHcgnnt1BT6CN3yJCvIBOGtjJ8ydwHJ/694e
	jSs/DF+QodkS/9xfynLlDGd4N8xLkf7pisCV+qvPcjA2bl4uevoNH1qPrcCGUKgx
	HJ6tNF6ZIZsl5NbhiJOfJdl83oNQRqua3gq6sSLdpTalkMCUlSul1XM8OkKEmxzJ
	yV+ERWanDAInEE2ZhmyRFNmNVSV6iAAG+f/vOobppxi1H3UkYfWLTxkBrfzk5gmQ
	D+YHzthNG1K395s7bdYqL3Te/841VbsLuzXirsVQzg9L5tiujqn8gHowCetxVXqK
	bYxuLuR5K0PrAb8IloTvvQKKFCIrOCrc0DHAyp+zYQ==
X-ME-Sender: <xms:lm8FZ3Grkuo-z0MyKb3zcSTymwO0KULoqQuO9uVWzrmVqIyN5unjZQ>
    <xme:lm8FZ0WhnPg4mxQl4fMReSCNBKTYAP14Ff1K_bKbUyGak2329_EuTDVYSwTyUp79L
    sTH4N7T_54431O0Fg>
X-ME-Received: <xmr:lm8FZ5IAkQwQTqFaToZzApjB-kOGLmG4cHz2ZkkDqw8OBaW7m2EBeG3wBGHt2AmWqj_hB3YGr9xCHxuqHnB136pRj91MNX4EDya_2PI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:l28FZ1HWuwd_ZjPDIZiHsX95xeLEWO2vguwUr7On9wK_kTCS8_b3Ww>
    <xmx:l28FZ9XKdhqrGZOoAZsKPD8tdsm1-SLnpsGN_5n-vmGUIyIh3fxy0g>
    <xmx:l28FZwNXEjIMnPM0fSr3Ajory0mGGRkO0xiY--Hkp6QSVHw1sgC82A>
    <xmx:l28FZ81PXQ8x-UcjYjmqs6mlSlT8u6cZTCsJIJMI0o7lewHmXcfGug>
    <xmx:l28FZ7dGZazAMruYBckfpJ6irp_uY76Rph6oMRnCzJ_zjCKz67JKD6zW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 13:44:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 3/9] ref: port git-fsck(1) regular refs check for
 files backend
In-Reply-To: <ZwUkZuCtYu7niuFM@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 8 Oct 2024 20:24:06 +0800")
References: <Zvj-DgHqtC30KjJe@ArchLinux> <Zvj-osCNDMrUQv83@ArchLinux>
	<CAOLa=ZQ3Gytt4Lsttxws3DWqbjteJS8mXvZSPzDwBJi_ALS03Q@mail.gmail.com>
	<ZwUkZuCtYu7niuFM@ArchLinux>
Date: Tue, 08 Oct 2024 10:44:53 -0700
Message-ID: <xmqq5xq232wa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> On Tue, Oct 08, 2024 at 12:43:20AM -0700, Karthik Nayak wrote:
>> shejialuo <shejialuo@gmail.com> writes:
>> 
>> [snip]
>> 
>> > +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
>> > +		ret = fsck_report_ref(o, &report,
>> > +				      FSCK_MSG_BAD_REF_CONTENT,
>> > +				      "cannot read ref file");
>> > +		goto cleanup;
>> > +	}
>> > +
>> 
>> Shouldn't we use `die_errno` here instead? I mean, this is not really a
>> bad ref content issue. If we don't want to die here, it would still
>> probably be nice to get the actual issue using `strerror` instead and
>> use that instead of the generic message we have here.
>> 
>
> Well, I think I need to dive into the "open" system call here. Actually,
> we have two opinions now. Junio thought that we should use
> "fsck_report_ref" to report. Karthik, Patrick and I thought that we
> should report using "*errno" because this is a general error.

What do you mean by "a general error"?  It is true that we failed to
read a ref file, so even if it is an I/O error, I'd think it is OK
to report it as an error while reading one particular ref.

Giving more information is a separate issue.  If fsck_report_ref()
can be extended to take something like

    "cannot read ref file '%s': (%s)", iter->path.buf, strerror(errno)

that would give the user necessary information.

And I agree with half-of what Karthik said, i.e., we do not want to
die here if this is meant to run as a part of "git fsck".

I may have said this before, but quite frankly, the API into the
fsck_report_ref() function is misdesigned.  If the single constant
string "cannot read ref file" cnanot give more information than
FSCK_MSG_BAD_REF_CONTENT, the parameter has no value.

The fsck.c:report() function, which is the main function to report
fsck's findings before fsck_report_ref() was introduced, did not
have such a problem, as it allowed "const char *fmt, ..." at the
end.  Is it too late to fix the fsck_report_ref()?

Thanks.


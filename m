Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ECC2D6E7A
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236860; cv=none; b=lrwhIA2l5XP/GTm8R6P0UBrrt/PbWEltuxwOts3IZYmJ2jbTHBYnTbLFpj9ea7gdZ1aA+Pl+MUIVTdEzD5tdOibGL3EpZlp9/ZmFMrN05UCOqL+hSftI6bza3gdj1ozR/aX20QstInqG7Aalm65EEkUbyxnsgQMp7HLz0qlPyhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236860; c=relaxed/simple;
	bh=Kpa4eeycy9iY1KbAIEje7icf/zReH3bx56UY3ycAwMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=prF6cXfuglHhiM4gbipap9qi1JCh22GofU3YNq3o1hwiU4+0UsuMAXt42fvhV6E2Zpp9iWO2AQ/YkwcT3heauRODILs130s4BOUlzt0Y5Cx+p03em571dV0elbizDPDw0yCPwd3oQOLOhdU9osd+JOAMbKmGT7rCSq83zVxFOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GR6H0ve7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pwRdlBJd; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GR6H0ve7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pwRdlBJd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05B2414000FA;
	Thu, 23 Oct 2025 12:27:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 23 Oct 2025 12:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761236856; x=1761323256; bh=Fw/rxHVAx8
	KnB7FMd8e8FIVDdy55vQEDsgvKgC4y0/Y=; b=GR6H0ve7jcu6anvQbr69M5FXor
	09yWrzsEuxtX1eV41vcWf27R6XzEZ7QbK2XwWZk2KVsu7YGq0OnthlNYrBgpzlZ5
	tU93bEtRTPeRg03+3HNXqMKgoKKNh3EFTuj7m1Ez5Wa3B6hpJLU2lwaiYahaPG6j
	Ii5eiOTAwrqJfQMW4KqUt3v2dRkPUp8nf7CGZ+lef6gl1OHhu6DpjU3Btxg/Z6W9
	7osEmKuMT10ctnS8tSLEQeCL1NXxNR9MHZtmR7lDvbTM7Ds2JKZj6hm5Xab4GrY6
	/XaQGEQwAZDWEaHHlbx39y1X35+afVmQU/qDHattnGv3sTemEw/ajjVoHs5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761236856; x=1761323256; bh=Fw/rxHVAx8KnB7FMd8e8FIVDdy55vQEDsgv
	KgC4y0/Y=; b=pwRdlBJd3jugXrkakxIoIgj/qePAqiBouyoPmOORknLtmkV/g1l
	o2EHFd/41bjDN+uF/VO39ki5da4Lz5yGch3zVA/Y2QpSHvKyNEABr6EC8Hlamkrg
	zVH4iZmKFoLumpSe+O+lmqMUQK5GjkEzXZQ5dJtRYg0o0+6ELSaLy49FYVnDt2d/
	u6WE4q1v15seK3tMlLRUOUJuCaejAQI6vR3Y7l3fG31NBURdBFVvCirjptbd2B0R
	4T55F98MbOV6yPrxCpdnQCv4kY9WUNidg9rNXWxz4cpklMzFf182klpfn8aCvfaL
	RJAtqZLcFzsOT0OKZWVdwkiIECE8fKNhngw==
X-ME-Sender: <xms:d1f6aHPH4yN09EwOE3yB049S1D5s5rsYVxkqzR0BwOR4vqJH-d5MrQ>
    <xme:d1f6aFp_onx9OhS98JZ74nP-kGjjY8wJh-vLzYcKIjRDtJ-bJodCcOkc_5V2OKQa2
    hzzsLRYcoZkFFdUNGsoz_Yd6dun7vsX3HjrLt0wWmAPyQUTfx0>
X-ME-Received: <xmr:d1f6aAFwVstgNIjNOH-Yq1sdv77k7SH9nmEm9I0RkLdFTPdtWHm47XhFablTBRFlB2iQwPpp1h-EFU6zNxWsvdKIt6jEXzaWXv7l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghlkhhi
    ugelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:d1f6aCoGSD-keSfR-f3Z-8BZYDim8LbV9I2E4e1E5PA3sQ2rbgocaQ>
    <xmx:d1f6aBYrYijF9rQ0uC-MMNswtvbdjKu3W1Vr2ZQ-kB7ZmPAfEaGsQA>
    <xmx:d1f6aDU7-r8G2x0oVERXIIzegPB4N7VZYE1GqJWh1mM_4d3CIGlI3w>
    <xmx:d1f6aC9KoSdkozghPZYYuggsXV6MZrvWtL-LicicNYL9PvxaBY-pHg>
    <xmx:d1f6aLxGktiAhhbN9xb5LD6wylUaOzvzhgEvmUGdOhCr6KKIzyowe22j>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 12:27:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  usmanakinyemi202@gmail.com,
  christian.couder@gmail.com,  kristofferhaugsbakk@fastmail.com
Subject: Re: [Outreachy PATCH v6 0/2] do not use misdesigned strbuf_split*()
In-Reply-To: <cover.1761217100.git.belkid98@gmail.com> (Olamide Caleb Bello's
	message of "Thu, 23 Oct 2025 11:13:45 +0000")
References: <cover.1761135129.git.belkid98@gmail.com>
	<cover.1761217100.git.belkid98@gmail.com>
Date: Thu, 23 Oct 2025 09:27:34 -0700
Message-ID: <xmqqecqtwpl5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> Changes in v6
> =============
> - Modify commit messages to have proper structure
> - Changed logic in get_default_ssh_signing_key() to use xmemdupz() if
>   key has '\n' and xstrdup() if not.

This round looks good to me.  Christian, should we declare victory
and mark it for 'next' now?

Thanks.

>
> Olamide Caleb Bello (2):
>   gpg-interface: do not use misdesigned strbuf_split*()
>   gpg-interface: do not use misdesigned strbuf_split*()
>
>  gpg-interface.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>
> Range diff versus v5
> ====================
>
> 1:  df8fbbd3a5 ! 1:  92fc78c203 gpg-interface: do not use misdesigned strbuf_split*()
>     @@ Commit message
>          gpg-interface: do not use misdesigned strbuf_split*()
>
>          In get_ssh_finger_print(), the output of the `ssh-keygen` command is
>     -    put into `fingerprint_stdout` strbuf.
>     -    The string in `fingerprint_stdout` is then split into up to 3 strbufs
>     -    using strbuf_split_max(). However they are not modified after the split
>     -    thereby not making use of the strbuf API as the fingerprint token is
>     -    merely returned as a char * and not a strbuf. Hence they do not need to be
>     -    strbufs.
>     +    put into `fingerprint_stdout` strbuf. The string in `fingerprint_stdout`
>     +    is then split into up to 3 strbufs using strbuf_split_max(). However they
>     +    are not modified after the split thereby not making use of the strbuf API
>     +    as the fingerprint token is merely returned as a char * and not a strbuf.
>     +    Hence they do not need to be strbufs.
>
>          Simplify the process of retrieving and returning the desired token by
>          using strchr() to isolate the token and xmemdupz() to return a copy of the
> 2:  5df667227b ! 2:  e52855242c gpg-interface: do not use misdesigned strbuf_split*()
>     @@ Commit message
>
>          Simplify the process of retrieving and returning the desired line by
>          using strchr() to isolate the line and xmemdupz() to return a copy of the
>     -    line.
>     -    This removes the roundabout way of splitting the string into strbufs, just
>     -    to return the line.
>     +    line. This removes the roundabout way of splitting the string into
>     +    strbufs, just to return the line.
>
>          Reported-by: Junio Hamano <gitster@pobox.com>
>          Helped-by: Christian Couder <christian.couder@gmail.com>
>     @@ gpg-interface.c: static char *get_default_ssh_signing_key(void)
>       	int n;
>       	char *default_key = NULL;
>       	const char *literal_key = NULL;
>     -+	char *begin, *new_line, *first_line, *end;
>     ++	char *begin, *new_line, *first_line;
>
>       	if (!ssh_default_key_command)
>       		die(_("either user.signingkey or gpg.ssh.defaultKeyCommand needs to be configured"));
>     @@ gpg-interface.c: static char *get_default_ssh_signing_key(void)
>      -		if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_key)) {
>      +		begin = key_stdout.buf;
>      +		new_line = strchr(begin, '\n');
>     -+		end = new_line ? new_line : strchr(begin, '\0');
>     -+		first_line = xmemdupz(begin, end - begin);
>     ++		if (new_line)
>     ++			first_line = xmemdupz(begin, new_line - begin);
>     ++		else
>     ++			first_line = xstrdup(begin);
>      +		if (is_literal_ssh_key(first_line, &literal_key)) {
>       			/*
>       			 * We only use `is_literal_ssh_key` here to check validity
>
> --
> 2.51.0.463.g79cf913ea9

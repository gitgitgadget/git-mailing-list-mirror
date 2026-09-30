Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012284E3769
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774232; cv=none; b=hvBR5RMmOn/LycB8ZVxpk5u5/HRWOXi7u5dyrFSRQ92bV/r/1qo34K1CN/4YSg7ALsbwQ7KfdY6KJi8d3KWbEethnjaov1RNLJalIWoBXlJ2sfOasT+HHK9qm7I/PewOCOANrm3W82PB7T5J5ddtGy/ztSY+kx68gL66sXFeYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774232; c=relaxed/simple;
	bh=RsYoF5uEmlNqCE2MQeVm4ZjJ+OZgtIyhJk1U7MBXopI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uL238PijWcjyOtn4FvUv1mNzSl5QBVKHjv5r5QaWEfgGJp2jLD2Y8TDhO+XRHpjJCC+gNLhecxNh/2wBj/bqn4M4sGUcJiIF4qF43/4YeFKfYHFVtOzJlxI9GluZsEsQH/6UaN9N7+dUnM8BCkMtOkwllR09HYpZa7QdBmFwZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=Cb3uRPMw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJWUh8If; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="Cb3uRPMw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJWUh8If"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C5451400212;
	Wed, 30 Sep 2026 09:16:53 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Wed, 30 Sep 2026 09:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790774213;
	 x=1790860613; bh=X4iOrKEr5A5WMoDUpyYBA0pnetNmKP/7ddq6a9Iv7tA=; b=
	Cb3uRPMw/IZHh066hAqg/gAgOR/HWuWbctFyOtnROu4sYhRhOukxBsWcbGxA7gKW
	G6B0Xqf+bOmVNUi7NeSfQoAh/FziRh7YWVzaeohvt671+fPiOhe73pWP01722Ksp
	I4P8f+Ho4Tll5dkhWSVdqhFRfgaZJYc155B/pXHfvYUPwW/r5s6e3+pYM1uFYXB9
	9cSlE4BjvGkzGbRfrgxGkRfheufLEOVMxWehrXfpoZwk7oUb3IL2mqZiDGy5GojV
	Aw7Z4mXAWR24RMB8xM/YlvBfm+HwydwP2O7fVObKfVjsOUfo+rXlU6kawOj9d2jg
	t2lKPSxt5kki1J0JIw4peg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790774213; x=
	1790860613; bh=X4iOrKEr5A5WMoDUpyYBA0pnetNmKP/7ddq6a9Iv7tA=; b=O
	JWUh8IfiEZJMJwkGr+LSIu4igzGGlKemWPMdCHZ+nV4g8gJUafICiVGTLbk1pphz
	C24KZLqQiFWkG+Xb1bsga5UbxPQas4gE2KUhD1+ybS8HqsG/eBtRU6PeoqP1xgkh
	s5hW9WQq6tElIO7Lp+zltn8ZlE8ergJvcdkTwyt9T6Pde55tZLt6lKavBSRAnvwm
	lq8vpvwhnHpnKwClwbTPsVzjtlyji6hWWxp3zp+d1NR2PEB5wJl0+LREC8kgZ1bR
	lWmjJ6j15jcRlekWWEDMftWq8IIRWGfTPy/vrxiB8SUbSsui5U8+3IVHpyc4LK+S
	2X3FFQS8TrpREpaiXCUBg==
X-ME-Sender: <xms:xAu9aglBPzSXbpIvfF0hYj9huWpzQS-sc92im5qJupoQJKjDPJRvLg>
    <xme:xAu9aqqaN7FbDc37NXofHMDDe303juMNqi3qlz66vtpYOpDaHnV_27cSR-ywjnhN_
    dCCdv26b8epJfoE0mxTlvyw1bSZjgZsyUraOzMWCsX7UHtb-GzpWh62>
X-ME-Proxy-Cause: dmFkZTF+cIlI575oMmnypah7+9DLvvect9zuC7DOmJTIsc84fVh8FNIGZ6LbHrKnHn8dcs
    4DR1NmRQCmw0Fez2iT8IZR/xL05DvUhuZ2fAT5+VEbY06tbdJ0jX1X+I8qzByuWG4pxDhp
    ohW8WgMMrREJYACYvFoHzXTc3jWPgx+MW7Fk5raCoEf1UiAXJFgFiAJB448H9z7PLHuth9
    +sWJVsZseYZ5bjUn53u3expl52tHAKdtILvt8H4T1KyT/hQTO1eHIf0l18gAIxUzhwNNOf
    e6HamFjRVZ5vQccFZjSAQ0t2djEOqCLbwixbuUbW2e8uRIV3TERPtxWx6QnAB1ZrvNMzpt
    lAdo30M4AL9RfufWj6YSXFT2uTfFQ/kOkGJnsNxZlye66hj5iDNxtW6EgGCvjysgvyn2dl
    X36ZsfUohl1IXtmbHXUB3F3scpIHl0x0A8vNwxR8Sv/q7s1KOxmRDJyP0VdttUhgxy2hNQ
    /CqfDbEPY5MGJObmWTttQxH5acXCQr5qAwgb2wWUwLybQ3E1pQojz3VndccvVfqJy2X3cz
    WywxdB5h6sWr6AwiwGqpd7phiEFy2YWv8LuYQzKzlSrVpwA4abUo96gokusSM28C77x+YV
    XfXJ8saXeq/E5tlYKqdsE10LucRDU6SAHA8FR5hwvE0LR39IBxcXctli3TqQ
X-ME-Proxy: <xmx:xAu9alhAprnwfs6xQjHcRPN8Ony6PhH6ucCE27sCq5QVwdjVqH-d1w>
    <xmx:xAu9ahz5gvPB1EYgfrTU6mPuUqDcwTjT3ewM7Tulwmb00AA7FYCm2A>
    <xmx:xAu9aoK0xLIo_OxW_SwtPmZNIdTxmHZ2cuKOrsJKnupey8FeDYGSLQ>
    <xmx:xAu9aoQoVwaf3FcPQRUS7poL0yjjcjCqK367lQ9jUKKsiO3hfQcKlw>
    <xmx:xQu9aldJawJCCBwFXrstTYZSSeXRwdgwhVUZefc4kvTk3P0JFpaz4Ody>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D5EA8780070; Wed, 30 Sep 2026 09:16:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqO-TNe5d1d7
Date: Wed, 30 Sep 2026 09:16:32 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <7ca55e6c-d12c-4105-b647-d76ed49d93ac@app.fastmail.com>
In-Reply-To: <xmqq8q4jelvp.fsf@gitster.g>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <xmqqcxtven3u.fsf@gitster.g> <xmqq8q4jelvp.fsf@gitster.g>
Subject: Re: [PATCH 0/3] [doc] Remove gittutorial-2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Sorry, but there was another.  With this merged, doc-lint seems to
> fail and breaks 'seen'.
>
>             ...
>             LINT DOCSTYLE includes/cmd-config-section-all.adoc
>         no link: gittutorial-2
>         gmake[1]: *** [Makefile:537: lint-docs-manpages] Error 1
>         gmake[1]: Leaving directory 
> '/home/gitster/w/buildfarm/seen/Documentation'
>         gmake: *** [Makefile:4003: check-docs] Error 2

Weird, when I run `make lint-docs` on my branch it succeeds
(before merging it into `seen`). But I agree with you that
it fails when merged into `seen`. I'll try to figure out why.

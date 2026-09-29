Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3621938F658
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681387; cv=none; b=NpdVwgWP3slQXidU/5AZvIk9vZ0TZHLuUUIqhAcq/YmOQXSISCE1dv/8j5Xy4eycQ07MSAw1QszzRAF6q6wSkyVVRUexnWmc/okYYZUxa6a1sZa31oAXvxdMfsMP5pjRfnJjssWd4I+HQxejONHvXPW7fkth7LYZq3Me/g4aRVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681387; c=relaxed/simple;
	bh=xyZr1msKY+g8bs130kGvSK0Yp32YSC9gSKtMNI8Llik=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZY0NEHDloEJuge73+qncvaGYd5S3D2iPCjlN6vgLGEoXSilmuvvJ/KF6uf+euJeKoRkVye0VAzyuIgZP8DV6Tf1HeJpHukEXpMvbUpzLk2V2jzH8MLjVDJY3c3nIgmWv60pIBz1m2o+Ku7/8f8VXicpvhe55qlPNTtqJTb0ObQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=A0jHHx4d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bA3BsoWb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="A0jHHx4d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bA3BsoWb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E1FB140161F;
	Tue, 29 Sep 2026 07:29:45 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 29 Sep 2026 07:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790681385;
	 x=1790767785; bh=xyZr1msKY+g8bs130kGvSK0Yp32YSC9gSKtMNI8Llik=; b=
	A0jHHx4dFDRMgTT8Ec1dFASi208/Ap9Oe/aNZZxOQo54IMaYy+cX7fzpu4Iv2zQ7
	1lpF7yBHIeczaRIhPgJcHxMW7dfT/R5vYCLZxg8HGRiOZ9HLFK2RVa5OaMJOBApg
	LVu4F9I4xcJG/YQjGTbX9MvgT5MTT9YQlkULe5yQQcsDDHq/Cn7tcSBK8MgazNLx
	oRHc0rLR7nMQEWvoi4viiTEnc9u17s9gPfY5NhwgnkxRCOLCNKybnYA9IPH8/cqQ
	cqUT+yCcJSS/g22tbRCB/NfPZX/VbKRLHGbaTlOQsb7rEXdsFAGq7q7OoCu3uuTe
	2nRQNI5wvQ1Hyqj0s6Txhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790681385; x=
	1790767785; bh=xyZr1msKY+g8bs130kGvSK0Yp32YSC9gSKtMNI8Llik=; b=b
	A3BsoWbQyuCd6O7V6ccZO8/Bo17J6v/5jNnsFXWN6ej3M1gHsp+arDyk1UfWM2Ze
	ar8EYvBiCCqHGZMBpFcvshHD85SE4ZJxWVTqmPYeGoLHW7D2UFSJbby19QtS39zh
	han9QaRxi5AXI1yj+yrPTqFoye/ZpL2vvuR+ENKJcOt5gc4Jb2ZXYM4s4qmtwY3K
	asWy0XzlNMkU6CsEgR7WZmajy+uJECarUMrWVDDmgVVtQz//loM5Psrorh4bMDUa
	IkE7lOobiDyqabDoE9f1/vZqPuKT+JukQVjjpgoO0kXxx6YCswUfOB2SezB5lOsx
	GcbjyqqIzDUOip5tZOEog==
X-ME-Sender: <xms:KaG7ap_1GmkqyhM7FdadvSKmkC7P8Q9GBVFnzU-TbkW58ThuSYE1jA>
    <xme:KaG7aohCSiWWvWzKGa6NynZcsFnKGAYZkUUNnHzH4RqwvxlOD8SLCuYe08J65k-kC
    HEJpsqAItonsrDWte3US6VmQqPqCHTl4OMIYLSeGvpWi58JegCLfz0>
X-ME-Proxy-Cause: dmFkZTFwHKUCqTbqu3oiZ7qDRM7zA25UC7RhqIIlZV+UwXB/egNRwp8NQvG4xYuWxURupb
    JNQj5MPo+B3MUa/7w2ALOImxRG2fWNiem/1IPnEjDjtSyOFyGLMn1Z+gId4z2/mF9UsxG6
    7WKpifar3FC6AewDsSdj/mfs8YLi4D4tGuNoul8y8xlZiae47L6C2XdfHD6aOSmB6KTfDu
    kT0dPR6w5agurOC1retPHyKSPh1mGTlxx94K/Hj4tEscVc9z0Z6HVxSAoT4vZ9g/DqMHgX
    c9CyEmbAIF0CRt5Qbsc4bmrorR7xWExvvcDXenP1EJa984yIMMA0lmc8Wbt7BJo7ofk9eS
    vyHDQ18akD+IJXbJuKuEUKIS7dZFwfPUOFDnxNmyIwSse9cG3+rgk2BsormezLj4Gz3jyT
    UhXmJL3Dj8uEdwJqvDnNbO0zoNgrTdzIsaBceZ4jKL/K2GeTpDvb2+zyRWAadZFJZW/DEJ
    iqk0qL8hsKDTgGmf/loYyn9RexjI1Q1pdPbYr7w89KWJjbkzYMgWLrX2ZMjKRUhq6qjaL0
    T7npKH4Kml4MXThyO4t2VxTmYGHr7VgiLzOdCujLeGuw8Gbdwls1TMD0gBqfzqs6/YzQVU
    NABVIbp3kMFSPOJ6gknyWkcYc/egJYxFmL0IwASeZqKjh0Kg/tlbuDVj1mPQ
X-ME-Proxy: <xmx:KaG7agjYIGuj4lcPwZpBBelPe10x12YxXriLJPHra-gV6v1jJnSoKw>
    <xmx:KaG7aqhVFLzAcpQuqtMgdkVgNSbdZflwEf5cbbsgV2xFmEyIIqXEHA>
    <xmx:KaG7aoIlkzUW2B5lXG4h-OXMf-cWqZAV2nbGbk4ZJ_b4-t9Fw4a-ag>
    <xmx:KaG7ahEeLlem53gK3fM2z2RvhZp5yt-GUgC1-Tuerki0EIdIGmsLcw>
    <xmx:KaG7ao2T9sGUSiQASI8Vh5oUfUC0U-nLPNyCWbSUn0dHCBDo4h7kUiha>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0180F780070; Tue, 29 Sep 2026 07:29:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6s586G7u8KZ
Date: Tue, 29 Sep 2026 07:29:24 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <064ec9c5-d539-4d21-96a7-6ad0ead5a061@app.fastmail.com>
In-Reply-To: <xmqqo6dgkead.fsf@gitster.g>
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
 <CCB1855E-759F-4741-BE49-23FC6DD402A6@gmail.com> <xmqqo6dgkead.fsf@gitster.g>
Subject: Re: [PATCH] [doc] Use `man git` to teach users how to navigate the docs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> The survey result that says the users are more familiar with "git
> cmd --help" merely tells us that they are not taking full advantage
> of what they are offered ;-).

>> I think =E2=80=9Cgit help cmd=E2=80=9D is quite a bit more
>> useful than =E2=80=9Cgit cmd --help=E2=80=9D because the former suppo=
rts
>> aliases, HTML formats, and various other documents.

Viewing the HTML docs with `git help` does seem very useful, especially =
for
folks who aren't as comfortable in the terminal. I had no idea you could=
 do
that.

Perhaps we could mention `git help` like this:

> `git push --help` or `git help push` for the full documentation

and then advertise the superior features of `git help` like this
(in the last sentence of the DESCRIPTION).

> You can view an HTML version of the Git documentation at
> https://git-scm.com/docs, or on your computer with `git help`,
> for example `git help push --web`.

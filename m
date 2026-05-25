Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA3305677
	for <git@vger.kernel.org>; Mon, 25 May 2026 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779750548; cv=none; b=KmxstB8rAjfFP38mIaS7Cy58/FV/xZFnHsI7Ql84+0gZFJdWgv2gjSmwI7N1hQ7GUppUwk0AhILenxG21e2ZqiLPEODlWAv3hNyOtyBJFKbFNVtLCxwRT6JFyOwttL6wdy/2fE9omWAgGcJjHrpjr1VfUd9trF5L9CZjLCkNcGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779750548; c=relaxed/simple;
	bh=HmwzVh+JZU5uSgl26ZFkL7LQtfKYaqJneRWZ1ADhSx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gN7dTBgz7s7Geo8tl7ddhty7fe9iox6JZGTilfaxUyrZqVP0hGICYppT6uub9I5wV/h1OU0M4E/rIPS9xpxdJyUI5jz9N66D6hH/WgVpl8YX2w6bbsHiQQyHzQqlRpLyz+AsjpVS7wNRCECEpZo3plp6JN+5aOFc4J9SJvqu930=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wQ3Ycyaw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GyO+sKnv; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wQ3Ycyaw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GyO+sKnv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45C2814000F1;
	Mon, 25 May 2026 19:09:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 25 May 2026 19:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779750546;
	 x=1779836946; bh=6C1qKyEmD+67/DBfBdSwhok0VOWDhi4gKW/7Q9S36EM=; b=
	wQ3YcyawlD6HNeVpoO01A7GZmhyP3hQ1pkewKY18Z8zkihdzC8dQOAmGF3ZnyhBj
	56osMVW80c1zIUwFYMWmD8sAyajwUQSHMfrfZ8xQemPe+ObQezsqlwAc6VzaQBb2
	TnUBX4oThlQUyatE/hdUvG6YZqV83oSRwdDc3Cyl/RolJZ+eFoHmBa9Np0DjVvh/
	FcWhWizn1DevR8bP4SzbZ8UGq1tfyAnjgozuLldpxe7NZkkiu2eyJvMN8DdyPS5Z
	/adq0Dm1mILdKt/aK4NNbzBjYvIkp9anf9vE0uCpQrhjYhZguF1oHKqoG05SW1IV
	GSQ+JGnz09Z0WDVO/4HYsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779750546; x=
	1779836946; bh=6C1qKyEmD+67/DBfBdSwhok0VOWDhi4gKW/7Q9S36EM=; b=G
	yO+sKnvxbH+5xZlvVrAeXAHA0J/0pVnCd7i5vIgaOSNhXivBx12lQ4myw0mCzmew
	rTqZVc3mgizN6VbqySlixwOFbhq8WJ61T+T2nfkAgVUJfOHpGsmbvGruiRVATGME
	7PUmF2+wrROu+Ay9C2TVNcJuyoKNkM1Y1zzWzw//ARa6zpyL0gPBuQt3MY9GgrZh
	JU9mI5ZSVZEFA73HpXq1x9IAexK5t9orUHTWVIDcOAJuWn4EEI5L5G6d425zgnue
	3DLZDTPp3Sbb2BeaZDuhkGns3MxBo+ufx39Qf5xAHDfcgqn9miRPyz9OfxBhtgXb
	gN6dWTl5fOQuMHr8O+CtQ==
X-ME-Sender: <xms:ktYUaqC03HounqrD61YGWx-4az1KqWJiQwDzj1e4D4QOrZsY_HB5wg>
    <xme:ktYUarho70A4qRerUP7TgzYOE5ZQ3MggXcxnyZiYCyz-KiUjJo_Oh0IRR9CFYIERG
    2AmCyQb_j8hx7pfLko_vsFPrKCm4wziQncdvkYrhJe-Sl4pT-UGWA>
X-ME-Received: <xmr:ktYUain0jkUkbCux2zZ1pXTTPGwrujrFgzFjIqDtoV8urDIERO5yE02bXkZfn2nptmKSyb8de9ANvpvHwe4JSCCu2IxUosVXwthY>
X-ME-Proxy-Cause: dmFkZTE1wHyAG64rZ8BdbWR/vWwXHixaDbsvYgvNjyG9B3T8XKgxaqE5GMEPi1Mirfds62
    pFj8PFYOVeFop5aotwU3EK3HA6Tyr/Yc1LHxzHaOLmDIJ32y0pfWAVNbWNTBd5thyh3tfp
    X+3EDKX9tkiv9k3hrPtgRbjdoIlDq7BA1sXS9NJdPDiMOcWvLhE1EcrT0AvMKb4QL3KgXg
    S98/OTSn05AS2y6UDyD+RFrhNPzgPyDG7pSebwCF+MVjIA8veRGOGHVrui0qev1gMt0/NS
    AlTNbOpE5A92ZTg/xd2reJlbD0iTFfnpfegiygfDA93wd/6Jv6p4oDUhrydr97Y0hnsHLa
    E2urGPLpeIyYe0AzFUaeZFt4e8ChlJKUQXoYMu+MDxIEBUMgGkhyTYGo/32b4eMRa108Bd
    uuJpHjN9MknAs80zC+/Bdp4lYUbCi4781bgR5n+aFny7Ctzket3ixRrUG/A+iWAx1y6/mT
    YN36ujFb0aZM9GixRwFZSzW4rtRhowx3wRaqD/xdzI9Xpy5X3+oTmUIOScsJgz229yy2Hf
    nTAd+x0id0T4Y7EIak6/ZYPl4WBqGVHSTqg0IGIkk7quzC7Dl35te9+Q1r6PpNEW1CtMpw
    aj2r+QrFnGbmmMjaECBjN5LncuFAww/EhpWiZuJA8ZVbCeBZ+WQPDkw4av3w
X-ME-Proxy: <xmx:ktYUanrZJopTzejkKcidA50ATwvQxbhzTYxmGs2dTdJFZhiKCAKofQ>
    <xmx:ktYUarFqp68et84mu9fCojAnCpvi1pUMeTR6fy2u__qlBCFmXwbcpg>
    <xmx:ktYUajzB5VvM33UwwRmzHjhFKy-Ehbq6Kb8S4UGf7ib5e_6okQPmSw>
    <xmx:ktYUagpCqj8OzQ-YN_0ORMZBA0u2gZQVGG3EXUuPIMalAGYymG7DvQ>
    <xmx:ktYUatmbqJqsBdk51GRzOn_xoZqvAqMPOUI_OVVDbhZyFKM8hEZW1yR_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 19:09:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jens =?utf-8?Q?Tr=C3=B6ger?= <jens.troeger@light-speed.de>
Cc: Chris Torek <chris.torek@gmail.com>,  git@vger.kernel.org
Subject: Re: How does git track history overwrites?
In-Reply-To: <074E783A-027D-4C5B-BC44-CC38C53735D7@light-speed.de> ("Jens
	=?utf-8?Q?Tr=C3=B6ger=22's?= message of "Tue, 26 May 2026 08:47:10 +1000")
References: <089615C1-6526-4ADC-926A-6A232F330DA2@light-speed.de>
	<87se7gasn8.fsf@gitster.g>
	<074E783A-027D-4C5B-BC44-CC38C53735D7@light-speed.de>
Date: Tue, 26 May 2026 08:09:04 +0900
Message-ID: <xmqqfr3fnl2n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jens Tröger <jens.troeger@light-speed.de> writes:

> Thank you Chris and Junio!
>
>
>> [Junio] Where does this line in your discussion page at GitHub (which is
>> omitted from the post to this list) come from?
>> 
>>    commit fda77690955e9b63c6687d8806bafd56a526e45f (grafted, HEAD)
>> 
>> Are you doing anything funky with .git/info/grafts by any chance?
>
> That line is the result of a `git log` after the `git fetch` I mentioned in my initial email.

Sorry, I may have been unclear.  I specifically meant the "grafted,
" part in the message.  I know how "git log" output looks like ;-)


Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA40923AB8B
	for <git@vger.kernel.org>; Sun, 12 Oct 2025 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760281872; cv=none; b=D+2OYnYgfLwYl/JMkUUUpsZGEi8WMelpaRGWNqpT+V1bFxZ74uDKQnHOoeTLYEmXi+nyUxbkPi54ujrL7pI8RlW2aNhoiboKV2lFu0oweq+xoFQbm6dAWMl5wGf4drArr9yAIh6zPGWWkqv9T/E2F8dvtv783TPl3bhxtUH9FXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760281872; c=relaxed/simple;
	bh=BFYE1fOPjMNMd+bx2TxjbLxZiekksK+GvysCb4NBcVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nmLU0v0qYbVhg3zgS42WcY0SGnnkYMav/58Gc7YngFqVzR1C1Lc6hieIaYd9VAOXT/rtXe3yRy9mxx7UmWYPX+tlM6ygqaMHQGoFYJSUcUSo/dH+zMbpNgNUaPn8R23kAM46q8IrdZ7sORipMb7J7Bmwx0/OoOnJF9n77e57ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AsKVEkSb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yo81s9N4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AsKVEkSb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yo81s9N4"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5F611400279;
	Sun, 12 Oct 2025 11:11:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 12 Oct 2025 11:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760281866; x=1760368266; bh=p1ZHi3gxJI
	EjGMIzBM3S9lOeTDn4ev/SifOp7I+Cus0=; b=AsKVEkSb82NPqG8m3RSubcqv0s
	XxG46ijo4+E40dWZL4oaHd9IOc0NGWGTaGGVaqQMjeuPGZfsBhxbJjZF/pIRyhYr
	OE0HN6F+nCkPqljgTOPUtgn94vtHQoWZSHm4kDibYZvnIBc+sEJFWOkjex2nfMzR
	V1tLvTF8yxfVeR2+cnJmOjzauZyJ0xgCVrwUYFLniYnM4RcJOwaC0O1la+hxvlIR
	GMaxTfcJTLNTMHfHSzmW+ZHK4N6u0gg4R7thO/Rb+xs9nu3zLudp6ytnskE9SLbC
	BSZMk7wqfIfsgz4gduLkVyXgSENJ2/LmaonCdDU4JbfKx/NZzmY6FZMuxzVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760281866; x=1760368266; bh=p1ZHi3gxJIEjGMIzBM3S9lOeTDn4ev/SifO
	p7I+Cus0=; b=Yo81s9N48qVCrFNgRSsJg2UPKW7nBuTPX+UOA+BAEIU42HI78vR
	ohpfoq/hvq++XIJfyW7BU6kjsrotlgiSYK01h62vCU8hoPlzOLNnPZctT22D5ijH
	7B7j1oK4z9HXC8Zrq7GD5lekXAHNy4sDQePESMGZ+wxa82WuiWpaKWBRleGKyDxY
	5j98NGNHvRobmh6XTZ1cOD6I19SAzn7xaFPstfopAh82i4LmW1/BGhR+dFeDz+xm
	usWGNqitxxUITKEP9LA89R3N8cPXz4OeZPV9vsn/XM4JQeHScDeyc4roVZGrJI+l
	tIhjOSNn5nBFgF8GfYNl3/2B5DALIuUu0Dw==
X-ME-Sender: <xms:CsXraB-0B6UqRUzBIjvsbgfDh-qEtKl85lQNjjKAPri1aiXZCA4euA>
    <xme:CsXraMlx3Dmjmkmxbm5vOg9E3PI4LBUm_Kj_MhSzXSRdOKszSrjj4ylIfAOwRerxu
    ZYESNcqDqT07o8NdzCd5Z1wk-R5SrdYygEQBb8FlMS3wzyU5_efig>
X-ME-Received: <xmr:CsXraHWbdYduLt3WThLS0qKQ7s8lpZaIUbAKUctqIsAjUFlBQ5IVA5j9Pb6HpxlF7SHvCB_njixiuxUcHS9vLGWqzIUss0qRKXH7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudehuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtmhiisehp
    ohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrlhhgohhnvghllhesghhmrghilhdrtghomhdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:CsXraBF5O6Kdi2l0D9f-N24J7rvfsRzS-faZkks1xVGEEiyio2VV-g>
    <xmx:CsXraDeP2RA_s5MM-iYbqb4kBJo8AjlymQ2GrmRZ-hNSSvhzBJypqQ>
    <xmx:CsXraCK-_V8-X0YOYn3qzzZXy83-WAErZZv5qtoSw7JUMeDRQd98ng>
    <xmx:CsXraIHIbfHKPlFLpttI9Tk5IEYMPz__IcPdiZprracwQnoUSLHKhQ>
    <xmx:CsXraLc_sHKPX63PYUINFCk4iNrqxVoZV3SDDvvb19cc1Z0tdnqmslpA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Oct 2025 11:11:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  Andrew Kreimer <algonell@gmail.com>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH] t1016: make sure to use specified GPG
In-Reply-To: <aOu59eVs7tK6pCoF@teonanacatl.net> (Todd Zullinger's message of
	"Sun, 12 Oct 2025 10:23:49 -0400")
References: <xmqqsefq7947.fsf@gitster.g> <aOu59eVs7tK6pCoF@teonanacatl.net>
Date: Sun, 12 Oct 2025 08:11:05 -0700
Message-ID: <xmqq1pn85f5i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> Interesting.  And well-spotted.
>
> This _does_ seem to resolve the failures in our CI and in
> the Fedora build system.  I was able to run a few test
> builds.  With this fix, the tests were successful where they
> were not without it.
>
> I remember suspecting the gpg calls were not using the
> wrapper command in gpg.program.  I even tried forcing the
> --faked-system-time for all the tests to check that theory,
> unsuccessfully.
>
> Oddly, I ran into test failures after fixing the GPG2 prereq
> long before c348192afe (t1016: clean up style, 2024-10-22)
> was in place.  Perhaps I was hitting a different issue
> initially?  Then, when I looked at it again I didn't think
> about gpg.program again, since I'd already tried to force
> the gpg wrapper which sets --faked-system-time.
>
> It's both annoying and embarrassing if it is that simple and
> I missed it after looking a few times, to be sure.  But I'll
> be happy with the end result all the same. :)

FWIW, GitHub CI jobs are failing t1016 at the tip of 'seen' (which
has this change), but only some and not all the jobs, which may
indicate there are timeing-dependent flakes involved.  I didn't dig
further, though.

>>  t/t1016-compatObjectFormat.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
>> index 8341a2fe83..cb6d308f1d 100755
>> --- a/t/t1016-compatObjectFormat.sh
>> +++ b/t/t1016-compatObjectFormat.sh
>> @@ -116,7 +116,7 @@ do
>>  		git config core.repositoryformatversion 1 &&
>>  		git config extensions.objectformat $hash &&
>>  		git config extensions.compatobjectformat $(compat_hash $hash) &&
>> -		test_config gpg.program $TEST_DIRECTORY/t1016/gpg &&
>> +		git config gpg.program $TEST_DIRECTORY/t1016/gpg &&
>>  		echo "Hello World!" >hello &&
>>  		eval hello_${hash}_oid=$(git hash-object hello) &&
>>  		git update-index --add hello &&

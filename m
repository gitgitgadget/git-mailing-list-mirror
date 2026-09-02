Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79249E5FC
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355218; cv=none; b=rOWQp+Zpcg1LM5LO62ePTWgHfFZNaVXvwVO21mBm/9vSmBRqnbJqg4ch+z27VCdX+Jz5bPRF/q0PDglagphZcqKEl/UTE1zuzQWbOVER5LhcTYt0eG78LME6BxMMR6a2l8PBAzZAmAJn04eyKzIxAJLY1xfG447kSEMvf8fSbeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355218; c=relaxed/simple;
	bh=z5OfIMHVDoyoTzm1PA9ABpL7Q8pVWrdMByeYLrdSF4A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pr49scJ/czTCdlFmX3Xu6eqk2fd+f+xYuoP6UK2xzGULyOUstvsV11Nao4XoDrSDnjgGueyOx7t4M1hN942aRs0ydulJW+zII6BU3fPdYNeQXuCSZAb6vrKwjIGbdbEufsTVSWo7N1/hU58SJxA91ZzbSkQ6IP0N9ZrbsQlqGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kLqb2Cqz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ds4bUruM; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kLqb2Cqz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ds4bUruM"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 19DBA14001AE;
	Wed,  2 Sep 2026 09:20:15 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 02 Sep 2026 09:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788355214;
	 x=1788441614; bh=Gg/TLiPfV49zk2prolo7nNhIc3YRZaz85wKM6scA2B0=; b=
	kLqb2CqzDqiVvyh8kk4caQXXNx900a+RpJvblThBdV3WN1S0GldnoilhiutMtZ1C
	9ArTwd0qYn6sb5EyYL/f6L50rfwRFnVhteMlqEWNYbNn3YwRz68l6FmfgGisUZkO
	b9UMI9qx7wQQezEP/+hTzZlsGMjNX1bALgLSBW4xO6l0GpHNfNF5GY2fcRisL3dR
	QVpgW3Ke7DIINSZfwPNamUjl9fRgirAoGXWy33tg+3J6vA3hKiuch7hVmKc/uJtY
	B8tGWlIHHnOu0/8xLRfrOioTkYl4mkTb+mWOI9D+ZDYRovyEty5Iyxt4BbNY7j2q
	GCWXriwAgLfa30mOVJ8KBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788355214; x=
	1788441614; bh=Gg/TLiPfV49zk2prolo7nNhIc3YRZaz85wKM6scA2B0=; b=d
	s4bUruM5bBv2IHc+gTR0uINSFh3aHX37xMfLQTLWYFfMUDPLWUPLbLvbSroBMD2g
	qB7T7NHCkRGnDdzLjnC+HCXrACEJq0QhCeEaYHslqdwz9BunWF7whg++Vn4xkr8H
	/oJjqsrOL6DJnNaZlp9rJrKzWHp9PQxqJnLoggUT22Lqie0wKYhTdKb1p72wQQ9x
	Pz3lIjpxG7lJjiUBFTx82JHHhqfgPvHzSDO8/Nvw/aSDycHxbnEaGpElvnLrGYBV
	+sNcEKguOVgICAfk08OVIP42GNJNSzafVgFwlS2qqhTqVfteZoi92DTtO1/godw7
	XIYCneNlFm0489USPe+Cg==
X-ME-Sender: <xms:jCKYaj1q4OY0w8fM60Tx1zqBQJEWsgDDtc1bcTgI1Bveo2WtzOxwqw8>
    <xme:jCKYas7dyp7bLKxC1-dEewzX36kjjfHCTM5ErqxkW0gX5Vp_lf1EX8rCb8-tFDIIV
    SbuIuy61VctRiiE_MwEbJHC-6TNEqrv_-YAtlQ9gHz0oGZnvYyYDHw>
X-ME-Proxy-Cause: dmFkZTFyHatfJK9nE3wc2ntn5gS+Ogg2iX8HlruucPGvVjWMuxJszi00MhKnepbwo8Ayj5
    hRaIy9baYIULxHOpHIwoVYzzAx74H47gQJKHOFtfoJ61TfMKOJXvtRjUAaGEnrFRlXcGEx
    hsijXAfB5pkVA+00B3fs8RS9TXRapJJuiKB+lSsiiq890q3FJjRh4LglWZl5j1ZQOTW6OT
    VdINGVDpo7yl0dhoS7bADIZUrUzncyAlnnGlV1WfGXAkSCHUfWAbtm37lWHG529mi+hILT
    /+c3pVp2CvCB30Y9PdLSuzN5TQV+elZ09ka/qXCqFt1i1Bq0sYNG5LpFFkOHyDxTqkBXn4
    M8sKLBmavqqWBad8FWONLWYJnV1uiSj3bkP49EaRZkEBlnSEYogtk4p+k5D8iN08zsv5k1
    K/Wma0dPYVs7ftWnOvzXKgXiWWnWUYnCutmhgsLaAlqDETJD8XZ4ExtNhbInSHGFKAvPmN
    QAIGsGV6LC2E8CuKl2tuyO7gQELdOrkxE5SRVIX1OjKhGiRO7b6zDPg2GXr0zUUSI+cX6c
    W6DYOqzwAZX1e4KOW251mPKbgeECG2Zool8z9LfsEuFCFTvzpFUJ4MYAj1HoyKkYs4KUG9
    SNGyn/JUQ06JueGTMAk1JTDz/jqX2zDX8XGy57vOGNXt2kBIE5YmXWehWrag
X-ME-Proxy: <xmx:jSKYaqjavV549W7XDXss7jtB86cIoqJIGEVT4Z169TsrR2yfgTExIQ>
    <xmx:jSKYao9SA1RdZGIHht47H18WaJPNOU08QGoEEVH5hRWpcvWQSOWtiw>
    <xmx:jSKYapoeMcmyWakFC8snFyGT3yCN-9FEJv6xklO1co22BQKMeDg29g>
    <xmx:jSKYav9O-CoUpVxHanC7Tc_JxttmJZ9ok5lxa4MZFWbOeMF6yhfcig>
    <xmx:jiKYasql9p_MnCDRzyw4SZHUF5n6cnZ96KZxULZZ9HZcI5l9azPYR7Gt>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 71E0422C007F; Wed,  2 Sep 2026 09:20:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aaez0ouLjM7B
Date: Wed, 02 Sep 2026 15:19:52 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <b3c66de3-0ced-446f-9bd6-73412a8c92b5@app.fastmail.com>
In-Reply-To: <xmqqpkz24193.fsf@gitster.g>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <format-patch_learn_--range-diff-notes.c5a@msgid.xyz>
 <xmqqjypfp2vl.fsf@gitster.g>
 <16315616-097a-4fe2-8665-010e424afd8b@app.fastmail.com>
 <xmqqbjan6q7l.fsf@gitster.g>
 <9335a35f-e9c0-4e62-812c-e5855c201003@app.fastmail.com>
 <xmqqpkz24193.fsf@gitster.g>
Subject: Re: [PATCH 3/3] format-patch: learn --[no-]range-diff-notes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026, at 19:13, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>>> I do not know.  My preference actually is not to introuce a new
>>> option whose interaction with the existing --notes option cannot be
>>> defined in simple terms.
>>
>> Let's drop this topic then.
>
> That is fine by me.  I was hoping that you'd come up with a way to
> add this new option with simpler-to-explain interactions.  E.g.,
> when only --notes exists on the command line, it is used as the
> material compared by the range-diff and as the material inserted
> into the final output, but when both options exist, they work
> independently, i.e., --notes gets used only as the final output,
> while --range-diff-notes gets used only for comparison material,
> or something like that.

This is how it works. The `--range-diff-notes` behavior that the doc
discusses is just the special case when the list of notes for the range
diff is empty.

That this wasn=E2=80=99t clear is the fault of the doc here.

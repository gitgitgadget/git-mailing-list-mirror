Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ED2502554
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777416; cv=none; b=QNJLNkdmJcZktHIYCe0b+Pt1e3AdLDpUqR9gsOnS3RN3RxdThOtRdVcwgWdUVGF8AHyCLknpqSyRFWyyXjKvTXBzhXQejdWGLNF4Uo/LhVu0ArDsoxYnZuzVmEjRAhH8TuODU0TAKEhcROkiwMePIPCf+5cOvaZMIeCkVeyWYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777416; c=relaxed/simple;
	bh=5NtDLc1Z42/pZGF0iijXQakrTiO/WG+6TjRJDTxnNIY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=m2R5YrlxplydcbOvGM/4qnn8hTX3JSrnrxyix9SZAq573lk3RRfh3RTEKdVWOcyTL0zmh6jhPDN2efxzDOb/UMlw+dZJaikCuZ28xaV8Xm3/sXdXT4vMylXcDpFhIeNYQz1otGPF7kPJovo30Ma2zC6Zqs527uLteClI8c+HDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GyAWQust; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R47bdfBm; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GyAWQust";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R47bdfBm"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 534471D006E6;
	Wed, 30 Sep 2026 10:10:05 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 30 Sep 2026 10:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790777404;
	 x=1790863804; bh=7IhVr5BCW5CxSf3OolWZXiy1DKlwuJScVYnrPuMgy3I=; b=
	GyAWQustvRa+O4Nmzx4LhpOD9/is/71zz3J6KkVyVnBi/NrhlXNK1050DIHkL2+a
	Tb7AO9URRyb+YC9mbZwCMimuuGYNzm/NJwIacjii1EeWMSo6aBSegq6Jch4M/qXW
	wt5DEdhZ44qfCoZw0kwaUjCpFzJegNpjoe6ySfM8wRlq41aZoMSgdq8EooWGEgrI
	fRpRVC2rp2lTI0cC7vKjxA0JFyQB7yzTO08t6dWm3ZtRMVjcOwKfE02pTVeQLGbs
	Rr4bLxrgNbv/6tdI2mkIS3CgWsN2hp8GMLuMIfQQZAJuv8TQNY/KqebWOB89I1jn
	UhXWD8+QBpBY4fbJqFUQYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790777404; x=
	1790863804; bh=7IhVr5BCW5CxSf3OolWZXiy1DKlwuJScVYnrPuMgy3I=; b=R
	47bdfBmjy/XEoAa1pPaV9XK/OEYbRntJyTvmXoQvAVT0CrLLyFKQ75YjAPcf1w4k
	XHgTzkLbLXHXy5MuZuWVM7sfwaGLIRxsGvljoOjiKQYxtQDd+61yj84siJ5COQQj
	7sqFNlw+8Rtd0kSYdZr29KN9Yss6n9y4QqkvGvkmGJ6Lrg+hU/GZJVllNs+Bwk3B
	XWnxFmfi35g+wZHzRI2FsmFNRyWxq9AlBCTBNKtN6UPwM1FSFv5Bt0VA31f5/plT
	bhKqkUyd4Pq0PqFCs03a3xr7Rgn9kovSyYPelYzE/8FUIzhuozzNELrMsE5+n6zt
	btBXt96At90U2OIqq7Hxw==
X-ME-Sender: <xms:Oxi9avxqGBBUUaXAGckld2_CZsZ2BmCQHXK596Yql43OcMheZNYP-v0>
    <xme:Oxi9aiHJYs6saeDc8xjn_5ivWmhGMZ3jcisPE_7LvOSgNTPqXkRsItdHXFqjFKreW
    ClugCmw92I5V4DwJ2wj3Qe7IXMZlbjLWTczX6k8tTRtU3QJmUGN9rU>
X-ME-Proxy-Cause: dmFkZTEt/qQwi3gQshpyzh+xkdCD7XBxZk+Smjm6OJjELYt/1nHy132n0hzmX459V1q9oj
    lzHJsntZTIkzPggW15ry8aazmn0DHxbMr0qqFgsRWAIQeU3GjcpT08zug70LLadRGZeOmO
    7bDjON71DK7AwbUaq3qo6NRVaRS5g/77b2dl6u53oX/5ahOn6mWPLi7FtHQs8V11c4rbMc
    GbmVm2KFNIwJvaYKnk769eWrYnJ/R0oO2mVuPivYPjYl/SN1buQVcuFaJeyB4jYOXWGtXo
    mExVgYChFdSDMJrmFUHp/BejAq/QBCC0/AC3jq/OK5KdhO08MobTTeLsFc2z+3h4beaspY
    9Khs59k31KubhHwcu9yLigYD/3bXbv0QeuFeDJM1q2b40osgggfxRVNa3r7KZcTQLtUW/L
    9AalKgxTGU2nycPKCeq6yfeEu7M8kE5Lvq2pxEo958BxbL7KLPLmm1aXOUmhYfBhVlO2v8
    eZrlHwY6k7gJIuRp3bGpVCtEa6kAcW+4tI8GmbLKIL32QFHpm2N2RRA9b8+wPl3atSsAgP
    GiE4AH2N6JIsTHC/sVGJ+fjVnE7LABDTgY1Lyqqw6G2WFRcvmYyGgT5jH1m2aBvB3BTVXR
    eeu3r7EYBmHq/HjwHchafrlf4dBHYcHh2DjOwOcZ5hglYIuQ01qBhLkvCMdg
X-ME-Proxy: <xmx:PBi9aieJgzwKQEnS7AuFOuQ27AQ0MDfGhvoOBKqqg7AVyKsLN-8utw>
    <xmx:PBi9aqK4CFvGZj8CJ1Sj_4Fu1DfM7_7Pa4Hx9nRKY17pAdPTawntyg>
    <xmx:PBi9arGmtjO6WcYMQUpIfOMuz4pfjCZ5WeQVH4F0kbVZyxwJu_-Z2g>
    <xmx:PBi9asrqS-X7QtYmMNOO53IvuzbN3p2NJzxulmed1YiwOon82VogNw>
    <xmx:PBi9ai1O5BxdzlJt9U5xzO0MAWMaH8R66KBnReQKeH6gsd-QuI3s2vbT>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 34C9822C0092; Wed, 30 Sep 2026 10:10:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5YEOc4Hum2Z
Date: Wed, 30 Sep 2026 16:09:43 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <5e957505-384c-42b3-980c-da905d69c71a@app.fastmail.com>
In-Reply-To: <ar0OltAkeTiCx81c@pks.im>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <URLs_not_just_msg_ids.d1e@m5gid.xyz> <ar0OltAkeTiCx81c@pks.im>
Subject: Re: [RFC PATCH 2/4] doc: gitbreaking-changes: replace msg-ids with URLs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026, at 15:28, Patrick Steinhardt wrote:
> On Mon, Sep 28, 2026 at 12:41:26PM +0200,
> kristofferhaugsbakk@fastmail.com wrote:
>>[snip]
>> Let=E2=80=99s instead replace all of the msg-ids with complete links.=
 That way
>> everyone can jump right to the discussions.
>
> Fair. The links may of course break if at any point in time
> lore.kernel.org were to vanish or change its interface. But if so we c=
an
> adapt accordingly, also because the message ID can still be extracted
> trivially.

Yeah makes sense.

>
>>
>> diff --git a/Documentation/gitbreaking-changes.adoc b/Documentation/g=
itbreaking-changes.adoc
>> index c6b974b6d8c..9aba419efc9 100644
>> --- a/Documentation/gitbreaking-changes.adoc
>> +++ b/Documentation/gitbreaking-changes.adoc
>> @@ -59,15 +59,14 @@ make the described change that can be easily unde=
rstood without having to read
>>  the mailing list discussions. If there are alternatives to the chang=
ed feature,
>>  those alternatives should be pointed out to our users.
>>
>> -All items should be accompanied by references to relevant mailing li=
st threads
>> -where the deprecation was discussed. These references use message-ID=
s, which
>> -can visited via
>> +All items should be accompanied by links to relevant mailing list th=
reads
>> +where the deprecation was discussed. These links use this format:
>>
>>    https://lore.kernel.org/git/$message_id/
>>
>> -to see the message and its surrounding discussion. Such a reference =
is there to
>> -make it easier for you to find how the project reached consensus on =
the
>> -described item back then.
>> +I.e. they link to the `Message-ID` of the email on the mailing
>> +list. These references are there to make it easier for you to find h=
ow
>> +the project reached consensus on the described item back then.
>>
>>  This is a living document as the environment surrounding the project=
 changes
>>  over time. If circumstances change, an earlier decision to deprecate=
 or change
>
> I wonder whether the information on how to add new entries should now =
go
> towards the end of this document. The target audience is expanding with
> your patch series, and most of those new readers will not care about h=
ow
> to add an entry.

Yeah, I can make that change.

>
>> @@ -332,7 +331,7 @@ The command will be removed.
>>  * Support for `core.commentString=3Dauto` has been deprecated and wi=
ll
>>    be removed in Git 3.0.
>>  +
>> -cf. <xmqqa59i45wc.fsf@gitster.g>
>> +cf.  https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g
>>
>>  * Support for `core.preferSymlinkRefs=3Dtrue` has been deprecated an=
d will be
>>    removed in Git 3.0. Writing symbolic refs as symbolic links will b=
e phased
>
> Nit: two spaces.

Thanks, I=E2=80=99ll fix that.

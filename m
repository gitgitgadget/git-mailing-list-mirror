Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7C0219E8D
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770675810; cv=none; b=KKAaIzqEdFJlZ0a8CEyxQjb+Kd73qUWsK6h5sSh7HDNXXEoDniEjrNqMDkYyPM7v5U8dGUfL3ljRuLD+igmFTYXXrFb2KhA1qfPDwsY6F5WHt7gVn0M8QLuH5u7hjXromOo4EEluxRWiwSn4aV3+jW9K8YmQjNo5cTrrJft88xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770675810; c=relaxed/simple;
	bh=RIKOTD9wKRDPp8Z8woR2+pLA6on6b+GJqJKrwujcokA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l+9/1TdcbdBzP/70MILDNdZlI/5YtNse8wgswcubYPjMBVSPcdzdLgv5cnCQAyoWq1IWJB11/rgz2KEe18say0RSMJmqvDldZXK7/ynpI9X3IZ8gWGtcWc+LfIbjpfOKaBnDMGPmCaWCOfEWmcagRnVhtjZZHPVKni9tifZV2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SBslwED2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MnG5r3ry; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SBslwED2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MnG5r3ry"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E0E1EEC0586;
	Mon,  9 Feb 2026 17:23:27 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 09 Feb 2026 17:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770675807;
	 x=1770762207; bh=oOUvBYT+H3vKV1AxaEvBkHyqtHIPk0678Cj3+ZDyab0=; b=
	SBslwED29c6oNqqtBZ8DmEQMcZ5lY0efdRirbblDK7rKyiKg6W7TlEipcb+4mSO4
	JxZ/GROe/dOHgNk0hpntZptGXR8FMX1T203Ufy6FxIDkWh88JHH7ecXsOj01TFYf
	hLBxFheeVC6T+z3CKgoWOe1srQa6O3GtXGTNedmJOj4/VRATMDjpAagyZ2LLiC3/
	8+EFZH/i4gTAGEIsYNjT4p3c0wXZVLhzk2Lndx8AhfqyQLtymi2AH+ZYmDVLUtZX
	eUIUZa9XDyNlnIHOO1v4Un1VMXojfhreHRsXASy5GTXt4Wj1ISvGECKQwpplkTPm
	49PVzqR99jS7A/XqmzwnBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770675807; x=
	1770762207; bh=oOUvBYT+H3vKV1AxaEvBkHyqtHIPk0678Cj3+ZDyab0=; b=M
	nG5r3ry+oodF/M0vAroJcETXT+sMrwFdnoxkWeP6DhlAHh9CvvBxL1rJyR9JEZsJ
	v03S3keIpAHBBDSLfL2ElkQKRKAqcHPeuftOg3py67a88PqjeC6BjFDghW39JYtx
	QyoKtln6VwmziA/OG3Ina/Z50SS5Kp2Hh2/2zVLoYLR7oDUJCZRId9c/j/F3dO4j
	F8T8KRIs4aAOwK59zUxQhBgg6+0aD7NsBdEqz584GX1no6frlr5WmS1II5ACWMrm
	xEqUOS3RX10CbHtk3gInNKl+i4wjfaykU6A9oH27GtbtLgM7JLxp5Lskg+Fafj9a
	fU9SEZJD5uDlurpHJNPpA==
X-ME-Sender: <xms:X16KacCQpc6DiHqsnFB4qQfX4PFEycPXRizhUt-rc3AXF0jvP6kAcd8>
    <xme:X16KaZX1GYmptwyQd5DB7eR-dAKcbQToQQMiGBPFDwuNroXjjV5rLDYB3MPiNv-ua
    v43bxvZrR2KJzciH7akI8FpxKl5s_l2WH6QXAKllDfIAQs4NoAFoBk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:X16KaReoc6tD_Kc-WRJOgCcVddq3E0SpJr1iMlQzzMuvUKkZKHrjfA>
    <xmx:X16KaW-_Qbma8XFTIzarr1GNU-0CjnITQOf9ilVYSMO34PhOKdK9-A>
    <xmx:X16Kadm3sRnlzGzhuR39araC3A6cCsjyDjiWp9dI2tUYVOrZbJKWow>
    <xmx:X16KaY--dVD7-VwWd4FTIDcX9Etdt8yHFjH5yLdoN2ct0GaE6bK0DA>
    <xmx:X16Kaf4bCSrItShf_aE-mADVbTcb3vYLniUXw5iXxOl2WQ-OBxXmLeQJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B591F1EA006B; Mon,  9 Feb 2026 17:23:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-WdI6L1kX5-
Date: Mon, 09 Feb 2026 23:23:07 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Message-Id: <d262682d-78d0-4990-b89f-5b8fa836e7f9@app.fastmail.com>
In-Reply-To: 
 <CALnO6CAET9GOsNCdmd3_Jp5Qr3Rfxn8cgmu9n0N8s7uNYpCchg@mail.gmail.com>
References: <doc_link_rerere.328@msgid.xyz>
 <CALnO6CAET9GOsNCdmd3_Jp5Qr3Rfxn8cgmu9n0N8s7uNYpCchg@mail.gmail.com>
Subject: Re: [PATCH] doc: rerere-options.adoc: link to git-rerere(1)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026, at 22:57, D. Ben Knoble wrote:
>>[snip]
>> diff --git a/Documentation/rerere-options.adoc b/Documentation/rerere=
-options.adoc
>> index b0b920144a6..115882edab1 100644
>> --- a/Documentation/rerere-options.adoc
>> +++ b/Documentation/rerere-options.adoc
>> @@ -4,6 +4,6 @@
>>         the current conflict to update the files in the working
>>         tree, allow it to also update the index with the result of
>>         resolution.  `--no-rerere-autoupdate` is a good way to
>> -       double-check what `rerere` did and catch potential
>> +       double-check what linkgit:git-rerere[1] did and catch potenti=
al
>>         mismerges, before committing the result to the index with a
>>         separate `git add`.
>
> Minor: should this adjacent be linkgit too? I thought yes, but on
> second read we really are talking about the command.
>
> Anyway, agreed that rerere should get linked. Thanks!

The `git add`? Good question. I considered it. At first it seemed like
too much of a =E2=80=9Capply this command=E2=80=9D, if that even makes s=
ense. But now I
think rendering it as

    separate git-add(1).

Makes sense.

Thanks for taking a look. :)

Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08B234AB19
	for <git@vger.kernel.org>; Mon,  4 May 2026 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884939; cv=none; b=A54ZCgZfFpb9SISUD1euvfoq3L0EY6goKDkytmsLBVD+L7qKEbAwXfT5nm4jZHCNSGBaPjsx1fSSpXSUHixHE6OAwccP9n+VLEO6v8urmF6p/OqBjXGst+PsQWSwRbEoiHrDMl0jY2zScFRcKxzFkQ6+MivGuKe8ALv74ZaeKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884939; c=relaxed/simple;
	bh=HbPNXHb5FsmUn9X9B9NoQ2rTmYjKJEF+/pCuRTGpBGM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h8KHp+QOwtGhwR8ZHO1GLhN3ygALOb3+mjNOnmlfgsGqmrlq/wmG5byIxe2m2cBdv/Fkrw+bH1oK1t4GjQmlB1pHApkCNMVgoCrqY7O5lJuqHG32SMsXzk7D2ml2yHU+frM9M7hwbVylhollzG7xf5BADTPzoUyxYPzy8GkK/lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lujmAtDa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jka5HB0Q; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lujmAtDa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jka5HB0Q"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 201127A00D3;
	Mon,  4 May 2026 04:55:36 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Mon, 04 May 2026 04:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1777884936;
	 x=1777971336; bh=m+RAn4YcB67ApscuBqT1OwU7pS9snK7xDS1UGZIcd3I=; b=
	lujmAtDaKymmCnAdLcmksv3u4KZ6trnnYQcODAC6PB+itAS6NPPGkEFpRvGwfAZt
	kQI4MO6mSzjKDcZZMXi3h/9Zcx48UpkpMXd8Z8wNCl2iQfkNPv5cGN8dgxKnkXt1
	k3izGlWvQ2jzE6gpXPGZch+6/T8Hrxa4HNzM2WCYZCD2u3fFK990sRjKGH1RYxQK
	G4NPnQmTOSPmbZPTwruRUdA4DqyVg4tqv+GfVjWSo8AYU7VaFpr65J6bDhJ+lWLt
	GXh/5/A7UnqEOqXJwbwRoRf3JysMKsLuZttZXmwjhRyPotOgU+TR8/24KPhVUpO5
	0+B+6fw8Y+teJfKStVd+FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777884936; x=
	1777971336; bh=m+RAn4YcB67ApscuBqT1OwU7pS9snK7xDS1UGZIcd3I=; b=J
	ka5HB0QdB/UN7JIvp8I0JQ6Usy4d7BZL1M/+w6yfiLdD0axIzp9Fey6L1iOWN4FZ
	5KSWxqbE0VRft9WgjH42r+1u/izeTgo7Rrn3xhJ5OW7F5UbOFyqOqry/F/bC7e22
	7KlhMFOCm64qTP687DkFRHt2aLsr3EFRh9FDCMmJzM/4qSxF0u240FbUCkYF0l9m
	llQ7NIYTf3q1Sccildfmwfh8cZhZPEmVzIgukd/60rIemQkHqUc9eKa47c2wjxZc
	gO1pXo3JAZE3YGg3y11cD9o21p/A8HLbLSyx60jIXiY5oJ7c2ovB2qAzAl7pKDQz
	NX3xSPwXV9wsqJjV2Bo1Q==
X-ME-Sender: <xms:CF_4aZ_psRSqPQ-IQwgrNY3-YWoe6cLbMwhFijdbf8NI-Bew8XMZ54k>
    <xme:CF_4aYgmyMMoei91Rzl4778_X_CzHN4uM-Y2ZMMmjywgW4nPhp8mWYQwqXqM4_Z_i
    i8F57lZL57TJsrzYcgdL4RBeokwjnDXsGNmChQTGTZm58Ar5yQaiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CF_4aVibaytnL0goTH-NImqzbWVtrFa2WOTmkzbK-St_uhLo6wH7kw>
    <xmx:CF_4aaK1E7q_UK-psCBnjqau_LiWrTcKycV4oy_0WSUG73ba-ZPYPQ>
    <xmx:CF_4adDrvkrNy7__wvZ1FAZSsKa7ewdxJcpDPlMG8bUUghuP0Xjy9Q>
    <xmx:CF_4aSgIFoJ97-NxVFNQy_8TyTkxrPOGkxZetAuqdmEUGECb5FMAww>
    <xmx:CF_4acNLRmU9F4Ywt71BMxXgLlPMoaN-Y_zVnJubikz4hNsHT1FwFkmu>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6BBA5C4006F; Mon,  4 May 2026 04:55:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHDyktfZDWSB
Date: Mon, 04 May 2026 10:55:16 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Ramsay Jones" <ramsay@ramsayjones.plus.com>
Cc: "GIT Mailing-list" <git@vger.kernel.org>
Message-Id: <592c01fd-1e1b-4850-adf1-77fffdf71321@app.fastmail.com>
In-Reply-To: <xmqqv7d4ou3m.fsf@gitster.g>
References: <e74a8fd8-0617-46a8-8bef-a454d51a99c1@ramsayjones.plus.com>
 <xmqqv7d4ou3m.fsf@gitster.g>
Subject: Re: [PATCH] name-rev: fix an 'may be used uninitialized' error
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Junio

On Mon, May 4, 2026, at 03:13, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
>> Today's seen branch fails to build (with DEVELOPER=3D1), like so:
>>
>>       CC builtin/name-rev.o
>>   builtin/name-rev.c: In function =E2=80=98cmd_format_rev=E2=80=99:
>>   builtin/name-rev.c:885:28: error: =E2=80=98commit=E2=80=99 may be u=
sed uninitialized [-Werror=3Dmaybe-uninitialized]
>>     885 |                         if (!commit) {
>>         |                            ^
>>   builtin/name-rev.c:867:40: note: =E2=80=98commit=E2=80=99 was decla=
red here
>>     867 |                         struct commit *commit;
>>         |                                        ^~~~~~
>>   cc1: all warnings being treated as errors
>>   make: *** [Makefile:2932: builtin/name-rev.o] Error 1
>> ...
>> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>> index b941e93834..5b7f7a00e5 100644
>> --- a/builtin/name-rev.c
>> +++ b/builtin/name-rev.c
>> @@ -882,6 +882,8 @@ int cmd_format_rev(int argc,
>>  			peeled =3D deref_tag(the_repository, object, scratch_buf.buf, 0);
>>  			if (peeled && peeled->type =3D=3D OBJ_COMMIT)
>>  				commit =3D (struct commit *)peeled;
>> +			else
>> +				commit =3D NULL;
>>  			if (!commit) {
>>  				fprintf(stderr, "Could not get commit for %s. Skipping.\n",
>>  					*argv);
>
> Why not
>
> 			if (peeled && peeled->type =3D=3D OBJ_COMMIT) {
> 				commit =3D (struct commit *)peeled;
> 			} else {
> 				fprintf(stderr, "... skipping ...");
> 				continue;
> 			}
>
> 			get_format_rev(commit, &format_pp, &scratch);
>
> or even
>
> 			if (!peeled || peeled->type !=3D OBJ_COMMIT) {
> 				fprintf(stderr, "... skipping ...");
> 				continue;
> 			}
>
> 			get_format_rev((struct commit *)peeled->type,
> 					&format_pp, &scratch);
>
> and dropping the variable "struct commit *commit" altogether?

I see that you added this as one of two =E2=80=9CSQUASH???=E2=80=9D comm=
its on your
kh/name-rev-custom-format branch. I will squash both of them in for the
next round.

Thanks to both of you.

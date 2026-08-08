Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCEB4B04AF
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218381; cv=none; b=F2zu8/aoplFRBeqeCNcGUGzhNPxY5purGzAZGy27YanPqXK//G7y4KuZEWpQNTd72vBMnaSGAbKHKu8fdlrurVKqV06OiUxYSeJNm1o5VrUzV9EfOXo0D927P91eLGZIzNtemPQilciP8H1mMqnsQCMB/CvfF2vOTGqnI+9++10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218381; c=relaxed/simple;
	bh=eguhJxYft7f51j2Fprh/q96pYaIRj9SJA9tqY20fr50=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qgCCmCRq4dEqVo/q+9pVURexNoqinCW7Vmfb+bICXrZTbZCKCptdiFMoVjJaUaxLBiiTozeu0U609Q11DNA62lDQQn2W/mtHN8V0bhF467olCXVOfE49UeuT4Q74SK/bMZbboXybACLDb95sfjTKoJrdItqO1fBVKO7Bow8Lig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AtTo0hOD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Stb044mq; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AtTo0hOD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Stb044mq"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 46230EC010E;
	Sat,  8 Aug 2026 15:46:18 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 08 Aug 2026 15:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786218377;
	 x=1786304777; bh=3atqRFYH8JIgT/nUSOLPbm7UxNV0OCSNtF/rp8S3DQE=; b=
	AtTo0hOD21ALz4vq7ACvJKoO1pCSLvC604BblHXHVscTvTgr85Mk6weyaFYJc/bf
	XTLB2xZGOtThXtFdmCWXU4q2boO/2YYhJ8X/6RfoVj+TP7i6DKWKzKkPa5E/ofJ7
	GzOV1k1B2mv09D0hIfAxVziQ6/Sy3/Tg9YumzqRx1iz1xOr9RqjSBUYJPnuC6iiJ
	81w9mU7Kt0HsaC9Se7dXdE4pvAMqOI1JqW4qSZHtTuCX2S6HQ+gz8gymkoeFV7QZ
	SmL4LBxEj2wNQ0Ma+vjh8hB99M6hxI4JtHJKevvvU2RTXLQLHiifLUJ/MhIQyHWi
	MKTCEL+4NFRkphUo/2kBhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786218377; x=
	1786304777; bh=3atqRFYH8JIgT/nUSOLPbm7UxNV0OCSNtF/rp8S3DQE=; b=S
	tb044mqifegWargiivTIuhF9V6MLa6uRUWD0qzS+xp0ou/MQI096LNa8bJ8UbUfH
	WTwGkeVkgt1NtpscEfCy8TJeythM2TmkNI2f4o4r8LWi40WFouXk9ppnJ8kVusz3
	Q+3g8ktcQbB79JMiBTon5eEN6VWfHCBTuLOPbve/Z99bMA9dNMYl5+Vw857UIpLy
	onSZa0ST72vn+MXIcB6yKvPe+mWZ9QjhyoFUwXHtiyrQqunXiNvykPZk734ZusIt
	yYJH8MmM6fw/3ITUY6R4MhmEs8gYnoHnJ+WGMpT650N+Z+l2T7S+31dcD4MXi/X9
	/UvC5P4UFPWAbI7RrlGiw==
X-ME-Sender: <xms:hId3agVG0liWNUdvOFx0pEjMoGClZb8wIoLmTYl8L48Idb2wwUVb9_g>
    <xme:hId3avYhm3rixQHnTo9anyvAqi6J83PKIOty_PbTxB5qAicQ9Rv_PY60_LlPHH283
    20nvn_3fuhq2IrsvTtYC98ulrmyFx9gBKH7nG9FOQ7QBmKKPmWVjw>
X-ME-Proxy-Cause: dmFkZTFRkTBlhCMpREA8/qoPacqlmJFyJlHb3BW/H7scNlPJZFJJPFvASE4U/q5iH70dUh
    bupRSYoFsc9y3CgV4VEcoVuRSZTy9ql7uCIazCbsF/clnQz5ygncwYfx2tCYkN6J0YsC+i
    2RLKKLfj3uEt00ZcXF++6C7FHuHQfJfyZQD28oOev4t5y/5khLOte3wW4fas4k0FXx8N72
    hKInUmyUe0NK4+geHSDqgzaEoT9/LVRqB0wHLqiilxqdYnslu5I3fB6fxdod9mpA2RGYFp
    F20xqhRIXWo2izN+KKeMfd21EMGIR+zfJ+sD0vW1qR6NZqc+S4jQJyYIAF6sefVDHE/Lt9
    hTD7cv1lKyqmYVUgue4uG9ih1Mls/RRvS+22Gmlu0nKoy8qc6BrfKqJ2hYVfiLHpuI7P9Y
    M5MHBxgAMt3sMBLIGdg3bLU1qcBAxIE/bPjMFyG67qK5VAql75Gct488cGubyAjxVDI5gJ
    bsBQnvUV1vzXf2hZdnwAfGa7bjAI0gh9hsLLdDVDfEu+FxgVc3ntc0Alq5oLhlXlWpwyX/
    TTkw/Vv46yIzhz+XPbK5BDc8FZyH6pIkCf+Uy49U8y1vEMyxnmYvpGyjNTAjznxpjDybJp
    AqcfBedF5R0ZiGZtF94khonSfVuFTSb15lOwRBp5505Mz+GyZFQTnA49C3dQ
X-ME-Proxy: <xmx:hod3aos5X8FViVFyQ6t-eqon3Athw_RqXDKqxBethRnjArtZOEwx1g>
    <xmx:hod3amLQEQiip0jzFwMAbNmmU6YvuGbLi25A5l-DGDXiUCd6SKjVcQ>
    <xmx:hod3ah-a2s4ABAEMA0qXUBEMBPGO6dp_4Imoo43eBqXFAMQtNzTS2A>
    <xmx:hod3avzYbML-gHpwrvDd41_yfjczCyqznyMWVaMuqtZv8UKrh_ZpjA>
    <xmx:iYd3anHOOtXorLEY3-LeCrAmSA87Gtea3YhGEqtmj1ZWSgzHWBINJxPr>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A980022C0070; Sat,  8 Aug 2026 15:46:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUgMtfrvVkyR
Date: Sat, 08 Aug 2026 21:45:49 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git <git@vger.kernel.org>,
 "Christian Couder" <christian.couder@gmail.com>, jackmanb@google.com,
 "Linus Arver" <linus@ucla.edu>, "Matt Hunter" <m@lfurio.us>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <b9cac360-ec97-4715-b176-7850a40ff433@app.fastmail.com>
In-Reply-To: 
 <CALnO6CB_0ucqnAowrNcPmsXmxxDfJQZPVGkbsHVuya7NLR4dsg@mail.gmail.com>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
 <V4_trailer_comment_lines.aed@msgid.xyz>
 <CALnO6CB_0ucqnAowrNcPmsXmxxDfJQZPVGkbsHVuya7NLR4dsg@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] doc: interpret-trailers: document comment line treatment
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026, at 13:52, D. Ben Knoble wrote:
> Hi Kristoffer,
>
> On Thu, Jul 30, 2026 at 5:22=E2=80=AFAM <kristofferhaugsbakk@fastmail.=
com> wrote:
>>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Comment lines have always been ignored but this is not documented.
>>
>> The primary motivation here is to reasonably complete in the
>
> "to be"?

Thanks. I keep staring at the text but in the end you need someone else
to read it as well.

>>[snip]
>> Notes (series):
>>     v4:
>>     =E2=80=A2 Msg: rewrite motivation for documenting this. The motiv=
ation is
>>       not super solid, but it reflects my own ambiguity on the matter,
>>       so to speak; I think we ought to be very thorough about
>>       documenting the format, while making sure to not use the main t=
ext
>>       to exhaustively lay it all out. The information should be
>>       somewhere in this doc. But not in your face.
>
> I agree we should be thorough but not in your face, esp. based on the
> work Julia Evans has done in the past around Git documentation.
> Thanks!

Thanks. I=E2=80=99m glad that I was able to communicate that. ;)

>
>>[snip]

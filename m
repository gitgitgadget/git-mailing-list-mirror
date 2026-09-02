Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3698A4AA3EE
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368905; cv=none; b=oaksUeR+6nYy0yPrbW4jF38FFm+YDJQ5tYVeG0VEZevXCwWTt4Mb/eD+8DB54fWwqnzNMkUouqPysLvVeGMUBEuKA5U7UXHg+7/TNrWUMjTC241MDuuPNtY1xHREo6/s5+9uDQ48J76h0sEOCxija0CdRHpqmqHIb4qhsf5E6nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368905; c=relaxed/simple;
	bh=51tU2bTQWL7FfifOz574ZD/VK1p5DAR7cE1uAD/4sqw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jtGvANJSd8mRPxgcM5mpqeWXvDO2qilYd1p3K282pBKFQ5jfJWGsY7rGh5bMOUMOSLH+0t7PJBbs92fSjQRUDntt31/mxxwMm+nDA0+ZyYnu1xC2j7XYBDOC7LUC701YqgqjACbxjWV5V92EcjvEGQeBWAIQasE8zMSatyWQrKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=olbTUvbh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fo9Un/wm; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="olbTUvbh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fo9Un/wm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2436F1400108;
	Wed,  2 Sep 2026 13:08:22 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Wed, 02 Sep 2026 13:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788368902;
	 x=1788455302; bh=ZztUct2LqEPI5e9jInBFCHJG8X/JLVUBvKBY4AUsL0c=; b=
	olbTUvbhgpphRr+SciD4LhPb0238Lkfv9sqG1ZHESAcmYpfmS3gA70mllY+mx3zH
	izlVLkk07pmBT/wGmkJBg2sdzUx0jvCH4VxqDcCRUmsvXh8dr0oGRV4oSski3j2l
	MClmfAG+xkil4KnB0WdUHfRJaHU00jqJx/juQUdyvQDiQp3w3a2jyTc/MYfVHXP/
	C36lg/ZNaEJv2cHLy7hp8s/f1qYAy7Ug/B5BPcWdO3X6Ic9mqhVlUrQ29Pf3yDSL
	xmwiZJfw4oWO50YioyEg2P2hWeA7jdCUfja1Bt2+rA7EgrXuGXOhFsDBMP3Ohgm6
	3QLSiF1ZDUrHYKqgG3CoCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788368902; x=
	1788455302; bh=ZztUct2LqEPI5e9jInBFCHJG8X/JLVUBvKBY4AUsL0c=; b=f
	o9Un/wmfQO3ei7k2tcwv/CxbdvTOjrjtE8cdn5GgAHECC0nXHl/d6uuBT+8ITw4M
	iL/dBKzZkgCB+akTTbqNzryGM7u6skcjUUcwJPmJCaEiwORtDvACRnuR/mPTecFe
	+deiRtC25UA0WTUDHpYXX+vaefaslvIm/Hc4DaSm8aWDxc2tTDlJn6w0Rz3CWiOG
	h7w9y84e29Z+pbLPyZw5jMYYxAmRQ67T0za1XKkA9w9CnzqmecUsv77DL6DPl9pr
	t6KoudFNBl7yHVtjT0DEsW1WE7xe5hVeVwTi2gGRN45XTEZfzxqW7+VS3Ez2l9W0
	Ud4gF08aBj4eLmkHW4YJQ==
X-ME-Sender: <xms:BViYar0GUZR_DOD7lVgc0zfLDdSyMK6rolYJfiOzIEg6IWCLGIHbwA>
    <xme:BViYak6AWOrgvmv_rj96Rx8DOb8v-UY5l7-E5-66RwkBnhs4Nc5k8Qr6LyIKcwg64
    fHgVMIvYCj1yPZL7MZ2E1y5AnWg08MCq-AnqL2g5xt3yro0ZoE-eWWD>
X-ME-Proxy-Cause: dmFkZTFIO8rRDZxovK5hVu+Gm0tjHWu+KJiSTOFTsGLib3DqEjcrKWdmWrLaswbT+oVul2
    1gUVh8aZ9KWMNcy2oTz8TdK7CA8rNCsAChSE82zzw1AK8dxaVJo2YRsfgnw3HSxbKXRNDS
    cZxAs3ydAgzh1XlGq30Ss68Z2iZZojrjSCNzfT6GrHfGTxAOUbmQuvQ29wuass+Uo/RfkW
    2d6mU37mvLgcSl/VndmWiPw2ANZv3/XdanTqfb28IQRU8TU2HX62amUD1Cc6ic/VJ2Slge
    H+Ev9NkV1wvG0gY3A9ItKqSBCg5Qaxv+MfCFefpF6urbJKnpPZY0BcEuVbyeZp9/fbApbs
    jk7SQnvudOcLamJK5x3yQztMuhSOMEG6boar21ZCiD/Ius1ITxm0XOuHiJPf+N1fza1NPM
    qjIX20UGutl1cXUsMz0OLXSWiWy2ivE+zu+0ca5kT2XfY3QxgSCzbG5ZUmesEN3EuIrR7J
    HBainn4IrOMa93Efqg5cfym5IlkZnLMovnK1yfohtkTWFrI0+iML+tst6fbFy28DKCcg4D
    3/SsXhwBOAZJjSpoDdLyS4OwsqbyWBG39Fdf+WVYoMxOsIssFfA7SdMTpUTailsv2iL0W9
    95O7NFggfUXeaBWjFPS22F4WdGw8tRuyUP33i/BCDDqlzc9PC+UnBVCT5Rkg
X-ME-Proxy: <xmx:BViYaheVZvi3BfowaJwDDBccDgyHxIGJOGt2d0p8voM1c3OFpM3fww>
    <xmx:BViYatAy9Ck_OwQDwSjKgYxgeeAGX0BjTpfnIBRwuuFJ5Cc0Fbr20g>
    <xmx:BViYak-4oSdLTbdDp_BlSO1aLXfm-UOYVo6I1VKxtkQl4fY5l2hGDQ>
    <xmx:BViYaoLB3OTXUer-Tuxw6Du_CjrAk7QBTVkPAEnR53hRePmlkmtlDA>
    <xmx:BliYaovkmf1iHTO1Ma3H43JpHF-N72qGcyFJb-yHw9EGNt59_MKGvWyH>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8F92A7811F0; Wed,  2 Sep 2026 13:08:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ankacsc59pRc
Date: Wed, 02 Sep 2026 13:08:01 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <5e12e3ad-a80c-4c7b-81f7-e028e461fdd1@app.fastmail.com>
In-Reply-To: <d0430082-3f19-4724-ac95-1efc1f9143e1@app.fastmail.com>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz>
 <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>
 <V2_datam_to_glossary.c24@msgid.xyz>
 <954865cf-5984-4e0d-9e8c-7c874896a1f2@app.fastmail.com>
 <d0430082-3f19-4724-ac95-1efc1f9143e1@app.fastmail.com>
Subject: Re: [PATCH v2 4/4] doc: datamodel: link to the glossary
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Sep 2, 2026, at 1:04 PM, Kristoffer Haugsbakk wrote:
> On Wed, Sep 2, 2026, at 15:32, Julia Evans wrote:
>> On Sun, Aug 23, 2026, at 7:32 AM, kristofferhaugsbakk@fastmail.com wr=
ote:
>>>[snip]
>>> diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdata=
model.adoc
>>> index dcfdff0346f..d588630e633 100644
>>> --- a/Documentation/gitdatamodel.adoc
>>> +++ b/Documentation/gitdatamodel.adoc
>>> @@ -24,6 +24,8 @@ Git's core operations use 4 kinds of data:
>>>  3. <<index,The index>>, also known as the staging area
>>>  4. <<reflogs,Reflogs>>: logs of changes to references ("ref log")
>>>
>>> +See linkgit:gitglossary[7] for a comprehensive terminology referenc=
e.
>>
>> I'd prefer to put this in SEE ALSO instead.
>
> It=E2=80=99s also in See Also. Do you mean put the whole sentence in S=
ee Also
> instead of just this link? I have never seen See Also be used for more
> than just a comma-separated list of links.
>
> I=E2=80=99m also okay with just dropping it.

Ah, I didn't see it in See Also, I'm still struggling to get used to thi=
s email-based
patch review workflow :)

I think just dropping it is fine.

>> Also "comprehensive terminology reference" might be a bit aspirational
>> like you say. Maybe just "terminology reference"?
>
> Yeah. The idea behind having any adjective or modifier was that just
> =E2=80=9Cterminology reference=E2=80=9D seemed to not contrast the rol=
es of these two
> pages enough. Since they are both about terminology after all, just one
> of them drills down into the core concepts/terminology.
>
> Or it could be
>
>    ... terminology reference for all of Git.
>
> Which seems a bit much and wordy. Or maybe
>
>    ... general terminology reference.
>
>>
>> Thanks for adding these links!
>
> Thanks for reviewing. :=C2=B7)

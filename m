Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578404AC154
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368699; cv=none; b=bB3PVOtShZGmLE3mLW34kjXjcC6IbsGhqUSNIicXsRqs+HAyS5wKw8gnCHY5DNZ8u6xApTgxpBgLZraP3ZzGOpd20Nimj5ZsjcMxCCFHVBM/lvMPF3MtKzTcBMD2pg+Ez6BDtEpfDwAP/4FXdIB8qzjKfAEoimFpCBEsAmkQspE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368699; c=relaxed/simple;
	bh=TfDw9pYVaOCsc+HVNOM80JW6g8zkohX68nUeRYQrGGw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UWd4ufuzLqA020j0s2xWq5OoTotgQsFkd+PbCqpy6/YH5n4yW7ehl+ApwwKtF7iAIJIpwl7r5syV2JYxBw50VxKUJnVlL4LhehtZk17CFdK9GI21Fs0y40NaviKG7w3O6/6aI3LzOl+mZch5YjWcE986Q44miqb8AYHuqOcoR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fpuz/Vzz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ddYAp0cI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fpuz/Vzz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ddYAp0cI"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id DA83BEC0014;
	Wed,  2 Sep 2026 13:04:55 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 02 Sep 2026 13:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788368695;
	 x=1788455095; bh=5xAh5+R3cMbMLllOudZ5LtFec6FoGNK66tdyFE4SXB4=; b=
	fpuz/Vzzbr/SLBosBDjZCX09VnU8HkeZIBMfURRW7rDi36XHN5X4Qhnn0QieNC5d
	Qi8/I3CNRL1sWjX8IVFoF5KhrHXkvzpFKfOhoqtYqZ/UQxGq+lnCkI9Jo84895ID
	UKhZIFbUw9561RFd2/pHHxDVVCPKligkq5ZckIgmUsS5czlASfUKamJuEsWh+KfH
	r/u5QXyTD/Jw+ww1m5QLH/TKgk7fg7spGuQvds8Dw8fU5TCLI8eQ4A4siKO+mPpV
	sg6LGWzm5pWvqzTJN/bPlMdgw/7YMNtuaZyBmCVgu64RS96AnQlX2rhh9OKfSBXi
	CcqH3Cp/UpszD1MIzRwMMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788368695; x=
	1788455095; bh=5xAh5+R3cMbMLllOudZ5LtFec6FoGNK66tdyFE4SXB4=; b=d
	dYAp0cImCyFA+3tEA+HWKCEKEDXim6HY/KB5EhQrsOQM7YQdpVBiDEx0u00J9hPr
	4eru5ZTIhxJlR2U9BOoPBgtTyrcLZKjJWz/yMoZ6oercZvURHGxuXkeovpmIbvlD
	mbMzImaOVKCkd4vcGE2sjGPaffeMR61mlAYEqX8Ge1yyaXHJKVJuI8VD3HXUe9Yl
	AYMrXZB6ZzgVxqgJ6sMj4RnyhUgNVV2oqatFPrAutQAQKW9TYUMMTeuGaVKsP/2Y
	UVGIVB9BxJdwv1HqFxfpzMXJOcZ2+jABADrZ6/J1O6XhN5CJ1nVTkKlB3ZGQGNsI
	U90n3MuITkEtDiOyRN2WQ==
X-ME-Sender: <xms:NFeYakmS9b7UxI1VI1zycKjMf6IDc03grukk8155YyXzT70jsoMPDE0>
    <xme:NFeYauqy1_QOINCis4CvwrvCFAmvwG-IXGMH5DB9AnUqfZPXyqMB7XOgpiS20e2b4
    plFJDDhDiyXJZCSp3ZR0A_sF_iX5cwETsi2waMBIyXfkLY7eKnMZuE>
X-ME-Proxy-Cause: dmFkZTEHVu7r3Kf79Z5St+FMCNvdic+9iRIWZ0vQ0omSjht38ZZD82IbyJs4tKYzw/dmDA
    DW5C536ZXnlUnLqTZ7h3QANdG8QLP8hOURUFmKsCfvoLfJ5GOcxs5BqbP943OSvde1CwIr
    8Zt0LGD+FgtROyBdy6qe0CbPGjjObuGg3vgJIsgbY++aGXbn4Bn6cfTFigjpyGGtPFdH45
    y7/XWMqFL1LbXkSBTlNSxpr6sRK1MepjUBE2CjLQLT8hB9zxwWOjje+8Nd/DPwtNUXBJKw
    /zUh68RJOzQKKZ4XtCtdhVkhAL+pZCwxc1ga+Cf1pYt5yRbmovpDqmcCElz4FTE6tMFGBN
    J48XELSq0yLnPvkeW2qSXhH3RcObpJNTaHOnoeufJ673XxjG63e9Gk57rMI1B2kz7ScoQB
    K7t8aKQS/aadCMXYdydbw46ZhKlScaNMi+pTmLo4PrnAqMW8atSZGugusLGZIUJTo1Db6s
    BIvYIqPK9SMQRzDIzq3gT2Rws8sZ6gg3WUjK0iKU7EXw8PQqpaVMREBSWv8kowKEgmGxXW
    Gvdnyz5ZYS2seP4TozM2qfZgS6z+cloUCi+VdaLGo01VgUhxMkc4h9YfV/pX+5FQFpm2b/
    6yv6Ejb04sNJjewA24nVF0CZXg5ia0X4PnYjC10PcwFgiG6tIrubVVs95+0g
X-ME-Proxy: <xmx:NleYauMVYDtAF3FyuEhH7bTtcElgXNVBgkY1QES1nEktmpkpWqFe2g>
    <xmx:NleYaqxR93vJ8FXRX2G-mrByxThoQrV6PqQEQURN5qABgL1_j1I8FA>
    <xmx:NleYavuDfxtdQSuDtKWg2R1xwZV-_r-Jq4KV5um5EsPfVs1Bvk51sw>
    <xmx:NleYar4B2endE4DSfFxJChDSKRfZcNRoiaHpG5eIfpgVcviIJ-Bgxg>
    <xmx:N1eYagfHvF9XOkz7_8LJ6QpJnXF47b2qVfLueV7AzfQZSBu--PPNKhjO>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6D37822C007D; Wed,  2 Sep 2026 13:04:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZYtW0UehPVc
Date: Wed, 02 Sep 2026 19:04:31 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Julia Evans" <julia@jvns.ca>, git@vger.kernel.org
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <d0430082-3f19-4724-ac95-1efc1f9143e1@app.fastmail.com>
In-Reply-To: <954865cf-5984-4e0d-9e8c-7c874896a1f2@app.fastmail.com>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz>
 <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>
 <V2_datam_to_glossary.c24@msgid.xyz>
 <954865cf-5984-4e0d-9e8c-7c874896a1f2@app.fastmail.com>
Subject: Re: [PATCH v2 4/4] doc: datamodel: link to the glossary
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026, at 15:32, Julia Evans wrote:
> On Sun, Aug 23, 2026, at 7:32 AM, kristofferhaugsbakk@fastmail.com wro=
te:
>>[snip]
>> diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatam=
odel.adoc
>> index dcfdff0346f..d588630e633 100644
>> --- a/Documentation/gitdatamodel.adoc
>> +++ b/Documentation/gitdatamodel.adoc
>> @@ -24,6 +24,8 @@ Git's core operations use 4 kinds of data:
>>  3. <<index,The index>>, also known as the staging area
>>  4. <<reflogs,Reflogs>>: logs of changes to references ("ref log")
>>
>> +See linkgit:gitglossary[7] for a comprehensive terminology reference.
>
> I'd prefer to put this in SEE ALSO instead.

It=E2=80=99s also in See Also. Do you mean put the whole sentence in See=
 Also
instead of just this link? I have never seen See Also be used for more
than just a comma-separated list of links.

I=E2=80=99m also okay with just dropping it.

> Also "comprehensive terminology reference" might be a bit aspirational
> like you say. Maybe just "terminology reference"?

Yeah. The idea behind having any adjective or modifier was that just
=E2=80=9Cterminology reference=E2=80=9D seemed to not contrast the roles=
 of these two
pages enough. Since they are both about terminology after all, just one
of them drills down into the core concepts/terminology.

Or it could be

   ... terminology reference for all of Git.

Which seems a bit much and wordy. Or maybe

   ... general terminology reference.

>
> Thanks for adding these links!

Thanks for reviewing. :=C2=B7)

Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E396353ED9
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788623304; cv=none; b=SvbqZV2+wcazr9f8XmZLz7sYdiUUd/UtKlpg3Z9ix980xY3JqaZ2tmUCOHTNTlNUQWh19EfGFz4ZmtdcTF8dbz1JrtknuQte+oqt+OOujvAVQO21hm1ZDmZ2Isv3O79h4R639obrpdmKK7Z9CZ36T+AgJNBo1vDSPrRJo3+QJMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788623304; c=relaxed/simple;
	bh=lTTavRyMfO4vtdW2E6R6AxJotC28qitb3XvqBn+Ss/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iD0tk5fgalY8da0RnUiKn0+FxHWF80Cqn6mDTYcB4AAvylpHk35SBpoIcU6Z9xENl1FfzNl51vv6zneN8ic96gDevnOWJdoZ81MT+spfP3oJF3KPMSSVkOl5VY9pJq5JQ9I5xehc74wSbwCp2eEC0hJw0yNWHCoJqRK0sa5+ugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TpEGWhXN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pILi8oHU; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TpEGWhXN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pILi8oHU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D79081D000CA;
	Sat,  5 Sep 2026 11:48:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 05 Sep 2026 11:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788623301;
	 x=1788709701; bh=tHXIiPR8DH/43icNc6ebxXFe4KCl/4PNo2D7EImoYFU=; b=
	TpEGWhXN7Wk5GDzobWr8GgF6KTvTyCg1VvfnjGG81KewzEmoCaaMz3YDhZF0hG5L
	9cXA5VvjZfalIqBGqBapNlfRhBfuL5Jnf3xYujxT/0fs8LGQT8v8/yOx8ou6El8g
	YeaUqt1PsoIyyy5SHFPyl009m2XZXEeB9Pw/X+JjMVBDnkpW3JajVt47W67kigiE
	Ne+SZvB4Y5cW/POC7PiXrPraZ5vMs+U+Ws5CNQnB0/h5gFARsB2yF86Kk8QSy22P
	qcBt+vlvXA+k4KUe+1Y2+9K242sMVeSx4oKuwhvb1QoGizMBAB+fCrHbETRHyZO/
	cx2dBtZu4GYCvmoP+oeItg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788623301; x=
	1788709701; bh=tHXIiPR8DH/43icNc6ebxXFe4KCl/4PNo2D7EImoYFU=; b=p
	ILi8oHU6h55G8kQyqjiK4joDbaKJH8jgT947oY7BPabaUTM7AGNvTLBB7kBczro+
	1eB6SHXmNPiSIxZTxGTIRCXY8KLGBUU5l9SVyAhAcORMyPmaGxKEBanqHhUh5psw
	HGu+yloPmqJE7Zhc8MR9+6Z66yfNqx1FGqkhhXRqujBT0lwJdQczX4WfdpjAQ6Dy
	InGKntnRk6HaFOz7Z1c3PuDFcxHDbpYIHVWA9kY/tHXjFL2HA9jRDY92Zz44rFJl
	uUEnaovP+bimqvRZZBqltBl0lrXcWlLc4WL9psbeoR/OTWptGouOdnuTyFTEWqby
	+fvxzvXWQ0QWG0nwuWTyA==
X-ME-Sender: <xms:xTmcalY3bqoAxhYSmPJU0Jbn7uavynnfmg3ApaA0BRB3sJ3A8wm0Og>
    <xme:xTmcaj3Lvt89EScFGLkMtEbKQp5NcxNx_HO0QcGbg6gW82hKcETSYuArhn5q4QKcm
    x8Bel2GA9jNUKbYDngkcxl1nNxtlSTBhYr6OvYA--1B6tFLsU8-c40>
X-ME-Received: <xmr:xTmcalVfjyUUk1i0YVts03g1ojWDTvjl7meaHY9YEfzurUMC6xEIypQha884bN9KeCU-j3SESlNBnjsTCAYb4U0Vjd28lvefYpi5>
X-ME-Proxy-Cause: dmFkZTGTlt3NLYUWpaKM/OzcgscHpYyVP2NxwXVYHLMREztufawXFrPhccl1ltGfDq+ltS
    BMFyNwaxL7pqxlzJhYkFgrwX/D+W0P0rzcZNK8RQwRmM+NRwpePchf8tZ1mhbzspuO/PIj
    IPB1Gra2g4xKHUL4FF3SO3lwWD2CcZwlqJE0WgJneTBZgt62bnZIv4nneSUiB8bjT6Ii69
    blPbpCoNQrl7JLkL3a7afrNw79KdKMQyCemaiNgAz/2WZj6MNKIYvW9An5aC44Mg1CwUZB
    x7/UO7SR4afvvvQ48UM4ZgmAaYJ/xjbVN3I+bEAX4P7ZCKTp0XZpvc54PszD3SL/RM5mIQ
    cqEBLZPUvFJho8TSo3iWH3+eVz15NBHsnTNIQT82bHIYwkB9NJTyn88796KsxQSwPes3Of
    OYokQ73FfYDopvr/YgBRb6q2QbWprzSD7GC5ZRVkv6xXJ3MWpdzh/NR23B54PGW30Bp5yp
    6mZIcfPSZmqD+jhsogV3ddciOX5FIPpF693NDENzwOa61sWgFtt+DIU3mB1zIvZi77znX0
    iip8g7+Gmqi23wPABPLBlvXTGYHImh+eHYl7CbK4zII2JyXAupOqT/cifE1JYcNDIvdDxQ
    WEXIx/6aQWU+iUYRzppHNFe5awGLcf6rUc15M3X8t9QghrRMLHp6uAkV7aPA
X-ME-Proxy: <xmx:xTmcatV42E4FLkzAolnc3UC_d9BQk7n1HyTB5gKlwPLx40k2186wMg>
    <xmx:xTmcakdMeJMGekipRkAJe04Vcn_vQPvRFaAfbSLJnf36yDrjap4n5g>
    <xmx:xTmcamXFxcykOjew5M5EuSQAKgE12eCOKxM-EETql6zsqkLks_Wdnw>
    <xmx:xTmcatfTfNxy2laqi8U9I21V0dPNr6GKW38-FtgXdDrrXblqQ2HfJA>
    <xmx:xTmcar-buZQ0tbwVfF9z72PQKazLDmcPs8_j3r2F1V7Djo5AetIijQHP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 11:48:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: kh/doc-datamodel
In-Reply-To: <9461175c-b6cc-415e-9344-fa19c194876d@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sat, 05 Sep 2026 08:29:48 +0200")
References: <xmqq7bl03723.fsf@gitster.g>
	<9461175c-b6cc-415e-9344-fa19c194876d@app.fastmail.com>
Date: Sat, 05 Sep 2026 08:48:19 -0700
Message-ID: <xmqqfqzn7l8c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Sat, Sep 5, 2026, at 01:55, Junio C Hamano wrote:
>> * kh/doc-datamodel (2026-08-23) 4 commits
>> ...
>>  Will merge to 'next'?
>>  cf. <apUrC_ROf9lyiuAm@pks.im>
>>  cf. <954865cf-5984-4e0d-9e8c-7c874896a1f2@app.fastmail.com>
>>  source: <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>
>
> Please don’t merge to `next`. I will make a new version to address
> Julia Evan’s review. Thank you.

Thanks.

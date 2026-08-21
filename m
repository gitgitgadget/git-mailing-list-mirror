Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A091F1537
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315184; cv=none; b=T6VgM536NFzfqZoJfIuZWW5Tlt3uZxf3FZrSpfJjpmMKGgwmo3+blRgnfGo4wzNIfOC8pY9iDZZYND4fvKPiK1zMVIwNACj09mD0uWHW9sL4lg8rkh5IkSbRjb7lyd7bPiM1vRnXfLjOR+cZCkm987hjh7sPpe2a5vKGd8tgt68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315184; c=relaxed/simple;
	bh=a1phGSHVeEOszcqFvVkNJw/uMgEIQ/oEhvuPN7B/by4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fmb7latJs1KGr0d6QY5ITmd2seccpfqosDZvvjuqL85B1JJP1MK1K7/bV/HvmKwsREkbE13HUsRLsF1zbL8MP+pAf6WHrvq27DfzdubkYczBvBpcxOPn0GKP5Iw/lnG2XQO+s25IdZlx0LWjPLIOKe+/V6VqOab3gMSNtCjaLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oPX6POy9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QP1kRzs7; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oPX6POy9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QP1kRzs7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E488A7A00E9;
	Fri, 21 Aug 2026 08:26:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 21 Aug 2026 08:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787315180; x=1787401580; bh=4Rwa/UnXES
	IFYzL67tx5JjnITSBM22gd4aYtu91mr2E=; b=oPX6POy9ADzYo58NIZkVeAn8Ge
	RU32ksdlfU76tZo2OKdEkkGR8sBzcyaYEvTCQb7FGNnVugfwZfT3w5ihuZL+m2C8
	qS9+VfOqKFIco2uLKdUfDVBnNOOdYxT04YsiZnsyd9Sg9TqcbIfeMJXUT6zV1NEK
	/3FQykqMwMy3Akw9sTvkYBAw6KgpIM/iVoaN0vH0+4XxRXwekD6VacjXzHp37Ndn
	/E6WduU+fdyHX8/CscNvztj3PRgtlcoQrofraZHHqOhVTVXqydna16tE9o8M56M5
	YWJu3JhUWxdhEPVlagwkZEc+ifVavx6pz+XrmU604NPyXSFX93fiOR5KlsBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787315180; x=1787401580; bh=4Rwa/UnXESIFYzL67tx5JjnITSBM22gd4aY
	tu91mr2E=; b=QP1kRzs7oK38HC/YpjPS3cWPidMY8fzcmSDOCbUQexoqK4OOfbQ
	Cn1dhWNusDgILhoCGrlFaUtGj8pkAyKItww+IyRXYZXx4pfDmDFASt5cXi4eX5vz
	onFtAYgrQ8/LfWHA1TjjWxtS4EIoHtGmoDZbqp0jeJ1pWDuwHbaxxP9nQMfHieUY
	0HuMPz9v7Yg8ByfXpXlTuoWdez0jlcwzV43QklUFe1afFHTp99tYzGndyKr2ACdl
	zwm5A4x3/d0O13x6BTLpQmesmpQeKCBSoScHhvLd628kltgNoA+Uz6FnL0BmCyCu
	iKwSeOYN2LH46qltSfgg+T9WWi9deBUJcKQ==
X-ME-Sender: <xms:7EOIanQQHKDHTsTkUrdfuYpRrsyCcJPTrHgSsuiSRAnN3ZEcVSaAAg>
    <xme:7EOIagMxfdcwmWux67lJQgjp7QXCQ9PGHzOhAgamyjfwSnqn1qMYW7cei2Jkr5urS
    mnvOXXHI7zkTXyFZ7-ON5RiqA77Mo3V-nGeLP5YkDb7c7IFbFnTpKE>
X-ME-Received: <xmr:7EOIaqOYmDd1ryBO6pTG2lyjxnRFMMUSJFv6LsyE_NZgHKiHyU1ChLJr7gwhG7cr-EUIIS6uTV1qZwNAosJuV3p49mE87kc9DYBHcLvdqO7P>
X-ME-Proxy-Cause: dmFkZTEg7jjBiS+xD0yFR/iOkCzMgUQhY2lV4pyzyLYrif4zrZZJmVfRsfhjGRaJyDpco4
    71HHFwbsnCtaXPuUOZ9RAYXrmla6BLmFQZck8DHteKqTV7NsoK/b6O5R9W43sKPt+f95EO
    lGN3Q05+8cwNs3OxjKdRfP0asYU2TktDGvAIhlC1uqmtIMWzobYhOzVzcRfsPdL3GU1up1
    rhOzYuKx+bJ5BBTBUgV9OZawQod+OhxSDwIUh8gkPQPNUGHbNRnoy8Ta2bbe10G5R1NW/s
    BUQ1qJC7YwAlgmjMMkIdOKkzdfCyXel5rh+YMkwK+l/Ci28vhbImFiEh4D404c/sqQ62Zu
    3nBiAN9QAll3sUloJXnTTa+mWmJw2hBIF0RRxRLChMB1Ax9EEq4OjtFZQCbCfS+vNzqh0F
    IEYtYVzU/cpTjKPutjH9SiQ71VLAGrwv0PAt7tyX50KDsXpUAad9Xal3RIIN078CoUtLBL
    Kae2JOl6GhvcbzB0fR8hAxk9VbfMepCS2d+lY/qrFy8coLFK7Vlq5czjXqYADZz0yeJUAF
    ffgz6OKLVTYK0XPwHlsEivxbQlNXqOENVHv2h+xw9qleJ0kO4Q8E6H2WAOfpoo6Bii+7zc
    rQo2CfuZCcyNw61w62Bq4j2U7gsj4daMfjWHhVvIsKVTzXc1peMbNH2QLGZA
X-ME-Proxy: <xmx:7EOIagvzKb757S8dNNq0TB7gcJrTtPiuShaPmrzjq9JV-OIBdlBlaA>
    <xmx:7EOIakXZvarnw9XphbjO4_uJnnZGJOBOZz3dXPuuHObWHN5Pn157Qg>
    <xmx:7EOIaosBN3ArE1cnrnw8U56Cbgv8V2azSQmviOO5xkx2RNDrSt7awQ>
    <xmx:7EOIagWUxZZXW6k6Z-1ki-s1KhTu08HxtOGQhIKTXrVJOWyICRMqcQ>
    <xmx:7EOIagMdzv4UDfTYWge_-xP-YYwm5ZkRtvCvsgHjJTz_sx_v0EsLXKef>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 08:26:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4416ae70 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 12:26:18 +0000 (UTC)
Date: Fri, 21 Aug 2026 14:26:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5 0/9] builtin/receive-pack: support pluggable packfile
 writes
Message-ID: <aohD54ZQEyybw008@pks.im>
References: <20260819215311.3880274-1-jltobler@gmail.com>
 <20260820234940.894624-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820234940.894624-1-jltobler@gmail.com>

On Thu, Aug 20, 2026 at 06:49:31PM -0500, Justin Tobler wrote:
> Changes since V4:
> - Added an additional test assertion in the frist patch to ensure keep
>   files are also migrated to the main ODB prior to being removed when
>   the transaction is finalized.
> - Updated a commit message.

Thanks, I'm happy with this version.

Patrick

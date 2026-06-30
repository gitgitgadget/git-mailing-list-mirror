Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76820360ED7
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847664; cv=none; b=qBR7LGxodBAjxHxpIlGD92AbjlgYxxO/SoMNx2qSzsRdbXN2ZdfQgC9M59i9ggLNMnGRwPUlRkotgnQ4eLrsMarIDw22zJoERWCcRwe7Rij1DWUVEK1Vz8x5IRb9xDFWSUayKHtpxg5UYkcb7H5AwL+xBCYa1XbBgLt30RUdPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847664; c=relaxed/simple;
	bh=/KZwgZICTJgpdpMUJVs0W5OgRGMrdL+FAFUwtLTOi7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=URlfDBkWXT28rPVvDS6ErHhC70VVoP5oWtkFSbyl4xpaV104/qhtL+jX9OEnijRb6NzeRzJ7dI8eswhlDHFhLXK1y4XH6uhtpwcZoI4PqlvkWhioqYxT9rbe7VqzDtnjk7dbgO+RaUk43Ak7B3rk3Y0leh/lbX2Uobf6x3fhJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oybmmMOY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=diwY6faM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oybmmMOY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="diwY6faM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA2B91400138;
	Tue, 30 Jun 2026 15:27:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 30 Jun 2026 15:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782847662; x=1782934062; bh=ZealaA7ps3
	ijsGx14uxvq9qYgbrVhAXnFUFZ95+j/uI=; b=oybmmMOYLvBmvN525fHEOVWJKT
	5IoNhkfSBrlHTju/tTHsBsFyER8jM0Q+ntv9nWysZxexj9Npm14b29Mr7322aeCy
	oWwmPZ+/QuIDQt67rBdMQxoLaDuIWQyZ9kgn4iw4CHuKssM44fP9IIurqykZH6CT
	mrfbUfdgSBO6IA+Y3XUtsP1VCmLgN21/0xKf+b7f9PfIH70lrU2O9gd0QQLQkXP4
	TRM2aeKS+YoKOt7njrf2F8o1v6NYZsQb3I3v9EfKdvl7OQAeKMXyc9SS5HVQ6K8+
	KKOv4LFrz2y/EUsM7MkTy1jZUM/XrBGAxaSh1zWpIWb7KdsMg3mmlvMD+tBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782847662; x=1782934062; bh=ZealaA7ps3ijsGx14uxvq9qYgbrVhAXnFUF
	Z95+j/uI=; b=diwY6faM69m6RBdGGwZXTvG3Y8Mabp+ZgnLq760wfPtTr9y8POy
	3uRjW0NNEFNtT2k4BKzLuATePMIKFjwvEdpPVVDRyxTb0g1uYz2QpZ5HV/MhesS+
	9k0DRcmQhr7EBtYofwtiLJZkq6KXnzehCO7CkpPYdIIB1RxPtZBgKUhFSbmhctW/
	UQaxK9hdDtbyBMAbMpNhzhP6DV63GAIPFqnIeuIPiuT5CBsUVnsiVE9As2FIIpN7
	FqCAisaHW5iPEASWEkqvrQwWemLFe6yj1gjP0gm5tEtc8bgE58o2bpCEwId7UX49
	X5dmO/IwDcSD2rhoZ6/tEj/U2E8DiW+uWBA==
X-ME-Sender: <xms:rhhEao31PcTBcAIq7XQwCR5gMbprV347t36CtDDxvLgAmYcGNISpqg>
    <xme:rhhEaqgyzI5gs5vECaSt8XFxddPm_NISWRR7ICc6Bw-X0JlWEzorpWERLXtrCMre0
    04-QQolFigRIPmdwdHIlDIKUK_0nRE-6zYdXrm4fzcRgScG_Pye>
X-ME-Received: <xmr:rhhEauSJ0tnwJ8SlMvess-vLQA6W7Y73EseRDmU9m6jyah2U47h-5Tb9cFeR4IYLliOzwmSDDWAJgkQ5njmDSKfAiEn986mfEWek2vs>
X-ME-Proxy-Cause: dmFkZTGGeJ67dQrtXdMB7KCgv7z1FmSOZoPJ/QIDsEwSwvcAONKoBdpvMa31Lilefnw+0z
    un4oYDeX5X5lFu43pqkdbhzGnb7iK5HE8K/TgPaEvvqXNrCh4Aff7ePUGYLK2QEo+XBRjX
    rB6D44HV7HUDA+HMVvzk3mNqz2ov0ofbfnX50NIcM6duFVoq3EE0b7Orc1DuPFglq0gihi
    nI/mJanXhkOHjyVwGjaFqV8nb7W1wX0aYzvrOoaW7V5nzdIZjypP0neF/Xt+ozN5sDSB/x
    fVfw5A7uEUU0egYs1eWCjAUQX0h14YWh7VEhGedjEWVtvTl1VdNY2y2su9N1Ke/ESGclCw
    YsRGQYpjQT31exERs8fHlv64XD/F/0PxiKpVNbU2J8hhBJn7rsgyWnJ82bz56HMiUbxnNU
    OtWGDQbF3iI27wVd491Y1pnw0NAjaWmHoM6Xe+3NnAJpWo+hCW7EtRNPz+pVsluCvZ4L8C
    Q9IKDaXPTlU6D47d5rVVL99BDOD3CxhOPnJm+zXkFtIMJlei23dG/EFEMkXq4seOFABLLN
    zF254J3CGnAf+P+5FQrdl9Ld+r88LUhPynI/bKYlLvlS4ygjuPSTDhIgMX6rxHJU7D7944
    xTyQ+AlCvA3+pVGZGhP58GaYQmu+qCvg7f/eSSknBoIAtxpAfJ+Qmo+XACDQ
X-ME-Proxy: <xmx:rhhEargRgqWVB0E19UWz655WzfH3CZm8JcK0RqHxFjxu_oCtp85rvw>
    <xmx:rhhEau5WTqTeaOEDiEI5ZxJ1WRWi--FgI9pFbbybRpruTubXKrPTVg>
    <xmx:rhhEaoBYbul47CQTRdoqKIU4C_Z9gNfKs0LAdDmrDxSsc3lN3B9g5A>
    <xmx:rhhEala4UYvKUrndnDNvCjUzH3clMKTBezh7ufCyZ9jHZ-Kr8qqgTg>
    <xmx:rhhEagLMF0o5VwAI-frofCTcIbbzFGlLMlIzaACEcxNij2w8JvQOUtMK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 15:27:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2026, #10)
In-Reply-To: <87cxx84exj.fsf@emacs.iotcl.com> (Toon Claes's message of "Tue,
	30 Jun 2026 10:20:56 +0200")
References: <xmqq5x36dtyf.fsf@gitster.g> <87cxx84exj.fsf@emacs.iotcl.com>
Date: Tue, 30 Jun 2026 12:27:40 -0700
Message-ID: <xmqq4iijsuab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * ps/odb-generalize-prepare (2026-06-22) 3 commits
>>  - odb: introduce `odb_prepare()`
>>  - odb/source: generalize `reprepare()` callback
>>  - Merge branch 'ps/odb-source-packed' into ps/odb-generalize-prepare
>>  (this branch uses ps/odb-source-packed.)
>>
>>  The `reprepare()` callback for object database sources has been
>>  generalized into a `prepare()` callback with an optional flush cache
>>  flag, and a new `odb_prepare()` wrapper has been introduced to
>>  allow pre-opening object database sources.
>>
>>  Needs review.
>>  source: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>
>
> I did have some questions/remarks, but Patrick answered them, and with
> those answers I'm happy about this series.

Yeah, I am also happy with these patches.

Thanks.

Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2A42E408
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396802; cv=none; b=bxnQCi1gcacMg1Xir/Rh2Io9xGxbjJcjH/xK1p7tfzj0DUc9FUww/LJ/Lkp8AGhEXItKpOJ40YZR4p0c7x3uGbCGDVCkTKr7KFkEKS8srCD3F+Z1Acn6PgGfF3FnFI+KADmXha2iL7091JrG+B5D5QzqarSuBlwVmhwzkl0pmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396802; c=relaxed/simple;
	bh=LNR8SK4vtw8lma0LBVqpCIl9QDJ+NrCEsJpakTA1q2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jmqXdZRK8S0g5QEZxhxz1l69Kp0CmDr9hlQOPbaPfN71NIpdRkb+z1CyEiKsLVz2XYkK9a8A0bRYG/h6r0eFKLSdu6S29IU3mPiJTal0WQX2wLxKEYiyBZWxZsVfugRRPayLrPR5kUEjinYyNBm93edbGLMN2xkgz5ZKZCVSxzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NCTaqKrw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fhKgvWJb; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NCTaqKrw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fhKgvWJb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7BAE41D0011D;
	Mon, 14 Sep 2026 10:39:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 14 Sep 2026 10:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789396798; x=1789483198; bh=rbcy99Lu+k
	72DThpc9WktFZAoEIwYM6L2PAtHUTy+74=; b=NCTaqKrwhYgxptmuz8ZWcDjizG
	0G9WIoIJ7Qz//ruLKgUjXylBKK9brgYGih4YuVRMVfnDTsgZ/C4reo3LlcLvypYK
	FVlolMlnROO2C3E4cgI7KNF8wFw9uJzsZetrori3a0O62C+GOWmX7ImlqGb1Rkyn
	6k8Z3gBM3BPF7AhnMRGDwL4aqi3FLADj0I5qoq6cFOE3m6zNGLwiilxbiS0JdiLY
	IZfENn30xeD+HfDbI609lv7qPHy0UcJMGuYv5SV4gVxtJmgG43SIkjMDkwb253tX
	td6hzOl2joVYNYWX+8IFikdVy2/NZSr4dShZ9rLynoexoGx6hb3ntcFLugqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789396798; x=1789483198; bh=rbcy99Lu+k72DThpc9WktFZAoEIwYM6L2PA
	tHUTy+74=; b=fhKgvWJbDQFQKNZVNZw6U4gh5ZFXGspW9Det6JP3yyrbsH17M7Z
	SG3UB5XVIllqkaAZgnEDDEx6GJvovCBoYNfy0UxCOeN9jSgqYtmZWFJjMhIYq0vK
	EZnnIfFfjOTH5uZftGTnGYIeLyIgZXc2U65TSvnuap8tKpof9WDYTM7pcyaT7rIE
	woUTzf8biEw3BBRzcU3xQZiK24ovj18fyLUV4+haxianP6DfOCHc/FTDRyob4EQw
	glVtOtwoUa8mxBDqepov6LXkCA88txpi9S9yD3iqNXLPGkYGEqtsuOVOlfdEimao
	+waJWHk8UT+/IPPMPxen8dxiqoCUg8Q0sLA==
X-ME-Sender: <xms:PgeoasfFl1aK2-w1CVt-hN_Jg_yJ-lwWv_dG2mBY7jHCPizyo_PllA>
    <xme:PgeoalPA8oKz5WpAxmNT42hIdn79Gt6NQD8l8RxKS5NvvkScMwFAJ8tSEaOunOT8F
    _DThwl-Th36M5Pj9wa5NXZEFzb8XmKIl1lRzaImygegh_8v5qdwOTvJ>
X-ME-Received: <xmr:PgeoaiiDlI5KvF654uWb8NgHNrsBM2vt0XACIZU6XlVczM-AkooDSYnSrVVfKmmG_EF4pZRL79YADg3Ol2p51MIXJ8bUMZkmm9QH>
X-ME-Proxy-Cause: dmFkZTGCSavEvHTm6an9QTgeZiNFJzrLdeKTb+rNdglzDBP20f8DC8L3hIQN3wFQJuQ6ti
    h8h2PGIwCJr7/ZXOAYtN1inovy32RqSI8iBtDSromVGnvFDIeuQDOMWf/fGn41K59a/x5r
    t/ieQtbdrWf5Rc3TW9qBZZYRSwllUHwuhzR78XCn1RsXsxaUFNcmXu2uw5LcJNV4+ZT2+B
    IWCq+m8OPIcIriyzeXObd+lT1ST+lKgL72einSEJMEmHf8lwZOa0KhQffFZLXziuD9LB/2
    cHrWYumpc+SU/WAHPt0sONfaCifRGmL+yRGWkQUookJ1pPvla6xp3lG+CEqCznbZCQdXpn
    FlEXY4liEttMTSoFAdwFpqYobgbd53wPH9hjmrFF2FQBmaEwkqAQukVjL1Oay9GkidwGYa
    A+1wnS8wyNLR1JqIstEcarmY1k2khd26XFH6gAJ0t050eKp8pMXX+L7rvvH8GHtQx3Bx2i
    GEY24xKnqE5etweI+LJ8TdBZczMXS+/j4lQujNx93uS/t1MD2t4y0gkM64BptvtLm7wSIZ
    /Q+jvBkxqlwWUCNdWat3nMA4Pu+rRA+F4Uf6qunZLjtGHbiNHiP6MZLWaPpFtUafq8vxiI
    vTVgXcmexnDvKU2xVCVNrPUfMxqPfkocIsTdUEY26FihQil0nrJBf7xW3BKA
X-ME-Proxy: <xmx:Pgeoag3WEZXdpf0Mz3w3YW0FL_6Wd6W7pg4KoZz-pNv9sJX072qFFg>
    <xmx:PgeoakgHJcZxo6r-fmWyEVR2oPWbz2OOkpuoMvgiErpJLxM7UIut4w>
    <xmx:PgeoaocXRReo3SNgjzyjxjq-v3YWqEax8r7HY-NFsf9-gBKnzqz-UA>
    <xmx:Pgeoavlh7UXAxD83EUkZGutRiKe0mokF2QtjGw7yxVy_oIXSgvYFFg>
    <xmx:PgeoamArpHJRUZl7eIyDH0fIYt7FVab2vFYoTToLJG2kgYzN6jwW18dF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 10:39:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ariel Keselman <skariel@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3] refs/files: avoid packed-refs lock for root ref
 deletion
In-Reply-To: <aqeLMG7lTJy3bM-h@pks.im> (Patrick Steinhardt's message of "Mon,
	14 Sep 2026 07:50:40 +0200")
References: <20260912014609.535922-1-skariel@gmail.com>
	<aqeLMG7lTJy3bM-h@pks.im>
Date: Mon, 14 Sep 2026 07:39:56 -0700
Message-ID: <xmqqtsnr7v7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Sep 11, 2026 at 06:46:09PM -0700, Ariel Keselman wrote:
>> Changes since v2:
>> - Run pack-refs after creating AUTO_MERGE and verify that it remains loose.
>> - Compare the state of all refs around the failed mixed transaction.
>> - Feed the deletes directly to update-ref and omit the optional transaction
>>   commands.
>> - Drop the redundant test summary from the commit message.
>
> Thanks, this version looks good to me.

Thanks, will queue and mark it for 'next'.

After -rc1 what is in 'next' will by default wait until 2.56 final
unless it is an emergency critical fix, though.

THanks.

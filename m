Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B8365A02
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970121; cv=none; b=MvGu/AA1+/JH4nt/+UFmUdp22SmtqvYBV1C62rVEvA2SX6bx28u8mQHdTGorslY38c2nEFW+BuILXFDqC7MYX7jEn2i2K1J3t5xNVZBHdPBBa6g5+k4pO+g11pJDrSu03sJ6lTeGvIM9SGf2/F7SC1jeQxtX1yeOXJnlnVxCMxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970121; c=relaxed/simple;
	bh=2gl96Rmq66XeF4Tz5lAurFMW0RfDTgn3P0wbBd8GaC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HKuVQrN5CKYgBYjAqUUARmW4zTGryygZkLDqD1gK5ZQOhUf6yVqfkcZlkk+YQ9q1rXI9IfZr9kf+rDubs53DDx8gW+SO+145qQWTMMsuYdEA6f1DvPgPqGfwGTdfleLWO5mNU+O/rbOn5G70Sn7szqjxSyS+qVD+JvUMGOKo7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NRRTwEjs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hvvlz4Q2; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NRRTwEjs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hvvlz4Q2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D73F9140013A;
	Tue, 31 Mar 2026 11:15:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 31 Mar 2026 11:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774970117; x=1775056517; bh=XKjlWFbicw
	crcaco7CfidtGXUMxa/TiIPXn2azTvDI0=; b=NRRTwEjs7TM9qbiRwtgzgF6q2g
	Fh+hH524fMOEn34mtgegiLO4iXFpcAzJJGtlQsOxKUBzyVaObj3pbWTiP9kERCpP
	RLTxg+d1x6EL4AjT6HzcFXyybYtFSOLfhILCRHPPqKlROygTV073iEJXetXlU/1u
	lMpiDPjz64Xcdy5rb+Fj+RoffcN8P3bYWphVbSvEHwzchEouikurn/XLXSZAzQzV
	jZxg5Mpc+bqpRtDlR0lDGp4fBWH94HwgO8W2Lqs0TVNDp5xVMncZ58ejFw1WNrNF
	B6bUNGgaTSGOWN4hsvr8LZmGiGJ8xy9hq8PQA+6xWwBfWy8LaBvTOtzoOFBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774970117; x=1775056517; bh=XKjlWFbicwcrcaco7CfidtGXUMxa/TiIPXn
	2azTvDI0=; b=Hvvlz4Q2TeO1NtRNHi8STnMjfn+Wy5oxI10tF1ttNSZv36tf2r/
	VO3pOtsCaqtncbgzKPV49krnp4cDcoBZ+MWgB8AqggBHgnnckHNeqLX3nfiD2tT9
	p3Db2Yk1JT2I9xT+17gdOKUhRMrqrJ7uAkbdr5M7hivCEendqLNlNgFTF3rp+4cU
	QiRjSd5WSNbdr2ezXnzwiNEiHVZ7AWocPrKTtFAjGyt8eRWCTjtmS58FljRrluP5
	VXJPMVGGoEwghPax2bQgdkYPHIX7WgzasN3yK75Z6eMOZExL+SqQsJwQpLIJ+62B
	wUC9tRypfzvlVIh1biHRa5tmVSlKRpZzoSA==
X-ME-Sender: <xms:BeXLachDEUiGb0rPo5lYYrNMlE2vB1lZM1_luOu2DixqK_ljmTlYiw>
    <xme:BeXLaceDcdD9nJI8muo78gbnxUG6vbs1OZXhJsNjBpgJ0Hn35pnQfEilE-7Wb1sCz
    gDQvQ7z0DAluk-z1PQx9T-TSabV4ccm9xSHTJR1jqUxmTBk0_Q->
X-ME-Received: <xmr:BeXLaRfuq_7oIv1wg1i7Oww6skjJn5rYoAKkzT-NMXYoB2iNdcus68Lw0xUC7CpVjOBO707nQVp4NzRlVRcL6T7UHjU_0c1Vaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufe
    ejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggv
    lhgrhigvugdrshhprggtvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BeXLaW-NGz_ZgV93ADgVNWcpwDxnmzeikHO4k24FkKUZn2WaiH9sZA>
    <xmx:BeXLadltgq7z5cbf76Om4h2lg3e3odB2q0gHMS_GL6DcoewmvPxBhw>
    <xmx:BeXLaY881_hrXVjBsw6tGITPPo0L8BZXZpsY8GafUdXOzpuYjtVbrw>
    <xmx:BeXLablMtJe68CEJzYdlhyJNSPXzTjkgc4Cdce8gG8sD_3fy9-tLow>
    <xmx:BeXLacpAhK4yMKHIxEwnbkTIyNOa9T-y3PPJakUJbh4iouaF7ZB5ycV6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 11:15:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #12)
In-Reply-To: <acsRsp_dy1_Cd5Qp@exploit> (Mirko Faina's message of "Tue, 31 Mar
	2026 02:20:41 +0200")
References: <xmqqcy0k6epp.fsf@gitster.g> <acsRsp_dy1_Cd5Qp@exploit>
Date: Tue, 31 Mar 2026 08:15:15 -0700
Message-ID: <xmqq7bqs3u9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> On Mon, Mar 30, 2026 at 05:10:42PM -0700, Junio C Hamano wrote:
>> * mf/format-patch-commit-list-format-doc (2026-03-27) 3 commits
>>  - format-patch: removing unconditional wrapping
>>  - docs: fix --commit-list-format related entries
>>  - Merge branch 'mf/format-patch-commit-list-format' into mf/format-patch-commit-list-format-doc
>>  (this branch uses mf/format-patch-commit-list-format and mf/format-patch-cover-letter-format.)
>> 
>>  Doc updates.
>> 
>>  Will merge to 'next'.
>>  source: <cover.1774640789.git.mroik@delayed.space>

Yeah, you're right.  The other two should wait for this one to avoid
disruption.

Thanks for noticing.

Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E29288C30
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111181; cv=none; b=RMiForey7HUdSpU5SSJiBJtVfiksqlcAQjfjx/z+JJpGHKATDqkLzR4k046zrMWNazHmSaNtsz2Zo98FcLbZxgQPHZSjCEgaOg/WmR7NUDRSpKQgBDwruBFiS14wRCUzkilz6IuSF07e6c1VFardNUZC46cDX5FWBFaAi+j/OBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111181; c=relaxed/simple;
	bh=8cE+MjoqVG+p4XNVzugu0OKNKs1u9TBkloxeoKng5ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VHeFwMmvaRfVeR32M66ZP2fXdvNYvBvcnF9ihMMnQNE82sgaN2u5yUg+yq8NJ2VqWRqMLQbz/ugEBLXpCxfhFYYDLmEe1ARAw7XYX1Y6xbe8Zvvk8MMCmTQ8BWlS6LZMrP8l3SkYNo9b5RSbU8kozZpCXFqSguZQDhSm5rWWE00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UHDm3g1V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VYmQFcVB; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UHDm3g1V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VYmQFcVB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EBAB77A00E8;
	Fri,  3 Jul 2026 16:39:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jul 2026 16:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783111179; x=1783197579; bh=8cE+MjoqVG
	+p4XNVzugu0OKNKs1u9TBkloxeoKng5ec=; b=UHDm3g1Vid9tDACSa8tDAKvaou
	CCyW+YqK2bUw1px+YtCXFlHw6dP8UOmdWU2ETUBAgZ80MMx3G8ZYKzoOmhZXJvvX
	u6XTcCNiP5X5DPYRGIqtl4HWITfDsbdUF+I+l9Rk1A39XxB7SCRciAruqWnG3WQm
	abe0iEYarrYlTzJqdiDzJnaJXvZphbHqBQl2hRZPsNVF4+fJqzP46lF5rQWP+toY
	Aj5wGMM3CUwXBgp1wptMaFrVjynex3NdoSwtccuiixD9Dao0zWfrI5F54FEgKMt4
	Yth2bW/oX58+ixvpTYaRh0qVEuf+wL+sHIJZzueU50m3icJ2wB7UHSQ+/QTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783111179; x=1783197579; bh=8cE+MjoqVG+p4XNVzugu0OKNKs1u9TBklox
	eoKng5ec=; b=VYmQFcVB/GyA5TZhR9WXMVvyaABDQzrqSbAoBZ6GHWMPLmlCJig
	nhcNOSewHr/bjzZ1yaZPjAUvDENu0z6xX0ag+YeZLho5bg7/tb15RdbB3zyNGxRH
	XniIZH8UpiNYd7t3CtsCj+gRCMdU0OZPs2OcM/p1m94nllCbkZQXzT9f5k694Paq
	7VwesaV35KBKkNRzmkz2ZVQjgQMj2qKKux8eLxnuO63LT/CVs9NhYbs9uwKYGSf+
	iECwh95l/dXqSxWkKft0Ggn2tdY54/gt1lEfUQqDz9vCegJB5uOTittWWiWjkQE/
	6E6rHCxWSDRons5v2phC72GDFuQ4u/MgWNw==
X-ME-Sender: <xms:Cx5IaipsjaqdHkbOR9_v8MB5HqCpoQEnfkXWHHq5xNpOFvGzQ_2_1A>
    <xme:Cx5IaoHB7oHT-WXu2040b5hI4zjaM6ZrYY637Uz61Q_DNHuV2zyd3akXIIR5BVEWA
    2wkAvERgo0gmXPyCs-La_SY4IBXS8-zW1FPHaXu_2f8_oMMVXfvvA>
X-ME-Received: <xmr:Cx5IaklS7EntxlC8nxfIwcfTpmW76qCMy821_oTcT2SZ_RFsArMkCthpp6x-IcklbW83NdpxpdY2ClNTsTXYc3ZlZV8ySp5k6SIS_Z8>
X-ME-Proxy-Cause: dmFkZTGwrZ44aALTTaMnqlKPsqq2SL5jUpU5As1iMtDkNIqfNZK/jTy5n6t4cAM98TVi45
    111c9U8RwatMnvIqFZUMXWNYMqQRk91vmRRr/0YVGKjoE4hUcWhmYuq9j2hTtOhyvo7n52
    o+1vvNfD2gANdK0RjBTP6g4+6qstuoZcrMDumKh3BPAzE5eDkJQc5/LbmtMVYKESaoDcJ4
    kWyKXmzLELGMno/uJWjlITh9sjzDNKDPgKQIaThQsuiuQMvU8od/7Vx/cqruOILeMrymYU
    3wsyhv/qGvWlgYwS9V7dmIKr7+DD/8UlWYlBZpweEtw9o3G28C1MVYQPn8oQ/A/Hwbf6cs
    bXuIYjeJaryxWUPYDxCyc5ZwpLFf0LATHoGEJAsYM5qjs5A0pCbXfJMBeNoQHNubxL6h0u
    TbkdUx8oAlnrDEm/ykhySS/dfoQa6l9hY1dJJZiK6YnKPR2BXNTzRCQ3skHd4mqpeCn2uq
    B1PNxJQMNR72UGHUXCfaH0jFQ5G8K4nK9GN22Br5YKHi/Gy8k1FazfY1GXRTtweSxdUb5W
    KuMF5WqBBZMLgLvNpHAnuTbH3QQL1GKgWI1W8qVvj5EUwODLqhNmPIbcljaTRi7Pn+109T
    OzfVPm+et2KwJll8Fy+0oAv0Dw3O5Tv43dsU/AWb5lnrF/D1P4gzGZ02F1DA
X-ME-Proxy: <xmx:Cx5Iarkio91V_z82_yW8-_bJtVeQraBwD2xP5KMsOQcKiVGZaPMQNQ>
    <xmx:Cx5Ialt6lcq0C6mSQzLL97enbzo4_-HIRIo8U4vQUODimHRCkprHfQ>
    <xmx:Cx5IaulbCE6Cfp5JekBsZlkN9mPR3Uv9MhArI3w_srLB9zi9-OQNqw>
    <xmx:Cx5IaguCwfLUzsuXOBtqfvy61mpEX915WKSsp2RmEpkz1a1j3HgfzQ>
    <xmx:Cx5IagMEFrO5MV2W5u-sO7O5w_gLq71yMSkrACH9KKctoTesPF5BhUto>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 16:39:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2026, #01)
In-Reply-To: <akY_oce1EcsgsN9b@pks.im> (Patrick Steinhardt's message of "Thu,
	2 Jul 2026 12:38:25 +0200")
References: <xmqqv7ayl1nj.fsf@gitster.g> <akY_oce1EcsgsN9b@pks.im>
Date: Fri, 03 Jul 2026 13:39:36 -0700
Message-ID: <xmqqse5zhkon.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jul 01, 2026 at 04:40:16PM -0700, Junio C Hamano wrote:
>> * ps/odb-drop-whence (2026-06-24) 7 commits
> I'll send a small reroll to rename `sourcep` to `source_infop` based on
> Justin's feedback.
>
>> * ps/odb-generalize-prepare (2026-06-22) 3 commits
> This one should be ready.
>
>> * ps/refs-writing-subcommands (2026-06-30) 5 commits
> Likewise.

Thanks.

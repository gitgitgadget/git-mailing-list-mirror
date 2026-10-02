Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0652F39C2
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790952608; cv=none; b=EkvkFVSa7rZcQz+Vhc/OGFcH4/ZyY+s3OOhdOp5aOIVXBQdNzppjyW4uwNmAGiASDnla4Us9+n5igjbZHISrVZueeFsS54OsUrLwagvz4449mCoe/7BzKctKMAyP/RI8jSwfRJL/hxoWLICwAKwn/8Y2lD2x+U9x74ytQlAkdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790952608; c=relaxed/simple;
	bh=OvxnDQhCznTx1U70lHZFkUw7IqL6c/daVi+3civTEEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C7r15S9DRzT/iMLXPSscxWbR1rvDSCrL9SMnudQbKKllLUtYlZBzOiK5e5R8Ff2oeTtA1qRlDjdB78CE3hJ6FQbLFA0oAooYX1NdKS/HwGldjkWURa3I7QOtHbXqcLem/lGMO59Bo4RYCdwJWzxGzwPr6BZEWUvxIZxEPT/WFOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GfgOjIQL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nCIjRnsT; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GfgOjIQL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nCIjRnsT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 61A641D00097
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:50:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 10:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790952602; x=1791039002; bh=aIQ/+Y9Gdu
	ehLCaTHZ6HmbZWEE7MCzaRTu20irzsd9M=; b=GfgOjIQLi+zcggGLT5BoGM8Jj9
	p+BMdAFnerXlsU60Php3r1LRjZBMg+p+DIapdv8R65EHjw1J36uwDF2tqTDNPR4l
	DeHu1qE81VSWN6o0xX2Cd91ovMj0KnPmJce3T9vjwL0Xvb0/Z4xWySQ2EmyxE6Ee
	5aFXNmR1QaBtaWr3vCDScwbmYy6dO66BxgehLTwfXuLlWD+vwglHpwaiMVhHh0V3
	5GXQ+Qyy0qIbdNhbiVQiTcW5E+OO433NNKMwMS7J1g5M1MjfLRJ6a2PQJ2trSv+g
	Ovo8p0EIS3g5atcwT2OKMyAi7FU1prAQEXvoxw9BrMUUWTj8ju/MMXP2t+ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790952602; x=1791039002; bh=aIQ/+Y9GduehLCaTHZ6HmbZWEE7MCzaRTu2
	0irzsd9M=; b=nCIjRnsTqCk4ECVM+CLO0xfYFu2Sxu9lZWrXffpwFY5VPHxJ/Md
	d3gOO4mnPJrNa4Eaq+rlOhjH6+pmmu8SG3E4mFIQPHvHfRCvXYR2p1ySPKhlUtEt
	4ZHCCIjFv07080dCqhkh2YvqmkIN3zwZQoNClO7ipefkfqIORuOOY8F5AE3nCsny
	XC8Dtlu2x+CZx4DAxFP8emAP5Lt1Cud5P2M74JnYym5R/lduEiZ9HhiNzxJcL4LA
	nq2yWc4U8I5qbd8OWSFaWd5qSmHxm4R0sG+MZ3vwvzGtBLF2SW40yTB5ug6+rnnP
	tDgjOLaqCUjuAYWekRYO4Ox6L0SUxnnZX2w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790952602; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:PD9Kz/ZXxZ3EA2dJ2twQ7vMl369ioESY35ieV/RRkEx+us+
	uVsWH4JjmQFHOFu4EJzcs7A/JIc/rpXXyMgK2QMAYHB1qS6FsnWnh4nH/1mYbxqz
	MeEEZKTtvz1fQ5aYw4sxKNLkdjIC+ImunvRSbJpn63YLlczQ3l/Ra+SRkzcjAuHR
	Pz9l+zv9HM8uh1+ShCOo1Kl9VvljmWMISc1A2D2ZHSVbVOx8sE+NJni0rzc6XO6l
	WhPBM3YlpueASSPOF8YsoU7S0vFaf6w6L1opSXNf+zfdvtXgP9nnrlf78e83YVd+
	P63vk+50zFco8QFlTHwjk5YUuCupTdhk2priJtA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:oYqzR+m9dMT1NEAn+hS+7+e3CvD4jDFG0OCgxMugd6Y=:OvxnDQhCznTx1U70lHZFkUw7IqL6c/daVi+3civTEEQ=;
X-ME-Sender: <xms:mcS_atMPEwWdTpR8N2nGJPZvhef9KAreKH6Qnpwxc9i0-y-t6Ljq7g>
    <xme:mcS_am8PCD3i5JPo2nvBhgbcFo8uUtXhf-BRVvoZiTDvgG32MuTTLt4xNlMJpzWbw
    meUi1Pue38tDu7C2fczH6GE3xiPx4Aghrtmh6L9dPFz7I7IG28GeQ>
X-ME-Received: <xmr:mcS_ahRaiiSp3XlvnebF4jcx-3LFF8oQuE9dY2teP6O9nXog_6Lar_0HIK7h2sa4IxjDEx29a-X0eTMJOTQU_v_bjruBuYOWhfxD>
X-ME-Proxy-Cause: dmFkZTGZfS7iDcj4DNCvH15tNgmtr7Qy4Qn8H72yQRzfLXIsDqEeBBjfhocgL32F/LrRfP
    ayn1tDzGlvoGiOyDOC22omadmZ5v/8TwzB5QyX3df+1CrCJLuJSlgz+bREgEXWiMX7Es3B
    2w+MtdkooHQMIQAqihmN51NlfYCOJzF3dKqXACUDAVMQCJ+sGI7iY+kC8YxH+HbFFaSTi5
    Tx1C7cyR/uiiIdi3W15SwMUUly5xC+I6CeMBuX9IQ66M1c2gpk1YOCBq111b99n3znKG4B
    A2IcadM/bxaPito5JpRcrPkWUyyMExzx0VYCiNmxcgbvu5QVBKY2c2cl2FnA/V7mXrNYEB
    YuujLQTY7J2v2TrrT3L2K5hk9tl8UZC8N1LeyVMz3W6COqUi9oL4nPsn1Z3Zs4jQh8NfGf
    AjTySzD3HLSa+UJonrv13LDxkbywa1TVFyCs14X/uVMu91cD1V+WT+2jK5aQYE8o5IDFH3
    uFYxxc7UBfE84p6Pq5cyhqvZvtPxnaf4KFBJSOnpsLWc94ytocw7uQTlJBGWlX5K3yOfkx
    SmtPxCb8mHpH/DDDR+DxVD93CSO4AkwLJz6GBX6xmjLG+f6v7c3H1Uzbm7WcytevbCUK//
    3UUtQod1GTn6PM4Yhmjy7qG/Woiu/NDEGe6LeS0G+kgpVxbokbuTCxbVl9dw
X-ME-Proxy: <xmx:mcS_aolgZhcX-V9PjasvUecEZHh4hyRlH_kyCemzgrhLi3pFEO5Lng>
    <xmx:mcS_ahRm32rcVDZvtVAv7a4A1JFIV9lDbAi8o6OrSp3ElX08Z-DB2Q>
    <xmx:mcS_amO82vdd7D0DXqZs6Gf_nggv_Kj2PkJXqzy9Xo_ojK9Jpn-2_g>
    <xmx:mcS_aqU7khq-6tmP3k9ve-XmG8rOhR9nZOJV9jPZ2ichubpWbYy4Cg>
    <xmx:msS_anW9zf2c215y1ZjQwNxpGex9B0umNh6IV3WQZ2fwZLhWWd_h8cTc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 10:50:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v6] git-contacts: allow inputting patch via stdin
In-Reply-To: <20261002-git-contacts-stdin-v6-1-49878e872d3d@brighamcampbell.com>
	(Brigham Campbell's message of "Fri, 02 Oct 2026 00:50:20 -0600")
References: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
	<20261002-git-contacts-stdin-v6-1-49878e872d3d@brighamcampbell.com>
Date: Fri, 02 Oct 2026 07:50:00 -0700
Message-ID: <xmqqo6dc17jb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brigham Campbell <me@brighamcampbell.com> writes:

> Make git-contacts accept patch contents via stdin for better
> interoperability with other utilities. Read from stdin when the user
> passes `-` at least once:
>
> $ git contacts - <patch
>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
> I verified the documentation changes by rendering html and inspecting
> the output in a web browser.

Very much appreciated.  Will replace.

Let me mark the topic for 'next'.

Thanks.

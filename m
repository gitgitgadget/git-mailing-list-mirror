Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC24D5995
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474362; cv=none; b=F9YQZaqGy4ZRyZIVrrl9923DoMwfnxVMuXSf5XRhxtu5HZlWypS1+o2mSs8Pt/ii+qh1r6VZ9yUHsYbRQnDFDfgb6MaZww/oyIREM+Oo6PcPbaHlztu0UPmz3MvwP/2JwsullOL6+X2QQQeDEAtAWUBlJxFykhZ0cqra0zsuTPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474362; c=relaxed/simple;
	bh=gt8xO4vnfzCXUuhuyE3j8HSr1fSop4zcHipyZ5reov4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qFR5TrjkpEzUeN34o3KkNnGQbWH7reETxlEJZ4Em4NEdxU/ypM4u47Vu1LLniNASROLfs5xLq+Toh5IcLGMtsf4EooLkk57m5GKrFnHtW+xwVtnJTQUdetPzZP/KtY8YwEVzKBccauNZ3vGvUlcNZV0nr9yPZUStlquKkmdKrgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o4C6VT6W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ytFS9w5i; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o4C6VT6W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ytFS9w5i"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 897727A0104
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 11:46:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 08 Oct 2026 11:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791474359; x=1791560759; bh=gNppN39cqv
	zPvjQtsZrMHAUo80y+rA/ahx/iVB7+A/0=; b=o4C6VT6WfxOzL/B8hFMb5KRrXE
	kgM/I3+JpyzoFb7RY6F8zgfGehGmBakGd7LwBxYZ5CxSFaQ8jI8dI2gYHOfofcXt
	AfDl/VB/A9C6BssOP9vRTuyOAxmtlGBptQAizjUldiCI9L4C7IHvry0HG0s78V2F
	HvLNoMbKul2/qUYETZ1faRKFVnmTTrQTDIw3b4mimNSNfLMmBW7tou4USBX3OIHg
	AJikaiI2tL1/Bn2ehjeiNj9ybsWzJqWou0GM2C1d+trFVD1XJcGQ/Nxq4ijUbSlV
	526VkS3pmygsPsecYUsrVZxgHBoHSBvmYnZQroh0pLPtgkVgJqB53HpJvSdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791474359; x=1791560759; bh=gNppN39cqvzPvjQtsZrMHAUo80y+rA/ahx/
	iVB7+A/0=; b=ytFS9w5i8G89aTzSwgL6gNasJFflMhiunw28xslmCiWC69qYCht
	MLMjE1iff3bD2qIxRULbrkGJ8l84grYz9EgLnyv2h4DxpMRg3LE0CKj2s5udUo6D
	dxyhMIrpL5oHXsb7nK/gIs7xoUe0d5MC4ohHID58KSf00LHnWrwfgQ5N3H453yB1
	7GEZPLTjj6FFKsDzQ51mwD5AaftSmzx/MeBftPub6YEUpG0RMJRnkE2Pup70NEkU
	AE56DjTOR/rAz6mZLIO/35NWnmhLlWuzAFnfjgnhQa8VjSEwiSa4tynFJ2V9W6UC
	++/jPqGchE83bHyuGV44l3jUswajZ0Eafgg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791474359; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CYnP+wHaE9EMsHlJCU4ElRc8hFX7pRsD+cFjsOxZ02XIeb4
	q8GlBcdECNJ/MVG+zgRcs09MVGdpD0iQG1YxToU5elMKm3CsfpkXrbCiXdBOMyVl
	RcbXensjLlruILChn8S7AXRSyAKMCK0hjqILDYw7bDxcoUejF3nG0jWtVck9zJZ2
	KRsKX1yuqMP+oMNq6u43bC0k8k4WAIXpnA/6Jffmz2YpIKjcCGXx11QS7An4b6O2
	XWjj8pQ7rVKeq1AthlLCF1TY1/riTVv8kqHMrzCUbDpslyOGBsVYhjIqSgUtW3W7
	253b4Z3quQM8Mf23Nt9X0SBKyIgwr/LIH6ryOFg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:RiVywmuDPDY3zHan0ylzgta9AjX/b3beDvqdM/VoJIA=:gt8xO4vnfzCXUuhuyE3j8HSr1fSop4zcHipyZ5reov4=;
X-ME-Sender: <xms:t7rHambDmu1Xrr0_vIxvBJVzhumH-7JrX3fqEhiXNyvWivortpn3iA>
    <xme:t7rHagS9p-fWBLwZPd5B8CW7HxmUeINoORxwv6HjYGr5HhwdWNZZeZ0g5ObD_EtZz
    nDFfaljfhhm7dyt9NZAJxTxg4XZySVYXOJ2VAL4WIUjtsmOFiJc0ifU>
X-ME-Received: <xmr:t7rHapSl_7C7N30Xe3rktSZU-0AIHr69AdpPCgLq8pPDhNfBkIZYnCx9waSLY6MEV7r8jxdV6LCDeQTIG7G0Q8kn27sERTz2RlKL>
X-ME-Proxy-Cause: dmFkZTFnMU61OfYMASvk0y07ZbEF0agPxS3VaTcx8D6f6GLZJmYd92WZn0rEgR3JpUK4ev
    cqGH9/B07EfZBf0kEffkUHKT8Ex5EJPDieh5v9SlmuosBDDm6McMK/bq5Pg4Py7e4dkRSi
    uSAjoAChOcu5LgT34C3sAzzsENAPKdXS9NbPqD6Judc5t3tgmaYGZnlatRSW6NXApus0JZ
    9vlT0Vg1udusUM/zwP5dseJRo/CHT1k/Golg4xmNv69uEhbkduEhUUiX+tLfYYxdHXFg4d
    yHqgiHkhpBmAP5A4PTwMvcmu8hakWMg22uU9EYkm+oQArZR46brXXunas1M8f1PyU4gNIZ
    kfyc+zY6ZoTDs4cFeSCsniHEeanDmuXJZyBP7Hk5kk1emXIlDvpiRf/XoQjXOPGPob0i56
    tiHtecT0ZPCkE9eMaTromI7RJ1V4GGkVQITlaxIOPQi2+D3Nh4WcGoPCH8kEgZJQKciuxB
    kYF1yU5VqZoTXLE0esbFQXvSLJsw4RCbQqWmM1V3/0PraUw3keYsZMQfv0XfIYE2DB8h0x
    ZoBq7KSgZSZUCI8lUgSuqH1FRfUMMFQnrDle7RdP6n85h9uHQhir/BWmqMNGC7sXq8pRdb
    xPiQaEEYS910mEZjsLi3ZSwnyqEJB770CCgBUrG9+JGXYlZ4ke6tIOPSs/AQ
X-ME-Proxy: <xmx:t7rHakSirY0UODXkH7qYrKTR33-6Wzhs2Lug6F7j1OIVAs2yBAXomw>
    <xmx:t7rHau7rfBbpVaZI0AOM5UBx3iC91oIXtgYajedmrLmwgd8gPoIUvA>
    <xmx:t7rHag2ijLZGzP6zH_OXmJ_zyOx6oTU0tE0f42_Xre_a1-ZTScvFoA>
    <xmx:t7rHapD1rRMka_ypAYGzc77XgPIRCjZkvyQbsT6Hw6-dmJpyjlEE7Q>
    <xmx:t7rHangBkPis5WXk7CZ_UYjISa3EEEiioJUBUDpzMWZJqlxZ6TKDcWLU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 11:45:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 0/4] refs: run copy and rename through transactions
In-Reply-To: <CACQ=SRGOdtUvxDEBeXz93nrC01oRaTALx6EztyBEfuCtnmTk-Q@mail.gmail.com>
	(Maciej Ciemborowicz's message of "Thu, 8 Oct 2026 13:01:10 +0200")
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
	<cover.1791452597.git.maciej.ciemborowicz@gmail.com>
	<asdsIjNEUOpaAnX5@pks.im>
	<CACQ=SRGtpYLCcAaJz+yUR564wTm8wsMy1qn7hZ_iJfDTc_KTeQ@mail.gmail.com>
	<CACQ=SRGOdtUvxDEBeXz93nrC01oRaTALx6EztyBEfuCtnmTk-Q@mail.gmail.com>
Date: Thu, 08 Oct 2026 08:45:57 -0700
Message-ID: <xmqqqzi02o22.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> better at it than I am. If I had written all of this by hand, first,
> it would have taken me a month, and second, I would have made far more
> mistakes than AI does.

And thanks to your learning, the next patch series you will write
would be of much higher quality.

> I understand that the patch is large, and I'm concerned that this
> could be a barrier to code review and discourage people from reading

Large is not a problem; unnecessarily large is.

Code generated by an LLM tends to be unnecessarily large, replete
with poor refactorings and outright repetitions of existing code.
This often shows that insufficient thought went into crafting the
final result.  Perhaps this is unavoidable, since they do not really
think.


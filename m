Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DCE246783
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560984; cv=none; b=d9sJHyiFQPE7ul7OeTeFewNwYT44qtBVjkuWPGwFnMJqfPo7RRlLXDrcB/CjSdu9m/rHE2bPwzHmYUdeESYixufeKKloklKTLyIuuK0j1k4VkqrbeKXUJqvpb0KlHY4I/zT7Zyc/h8opCrk3H1bBEEX6rNW0oQHp5TNX5pObM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560984; c=relaxed/simple;
	bh=0S4RYWo/1GNdEp63xexcL2gmNjczx+ioAqY2FEiddeU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=T47FPPEJ6UcBdYhvS9aSmbsz021vwIc+EBVoxoxhJmffbdLqgoKKcD1g06gG3uVWIoVl8Uk0MesULNIikNER8K0CKJp2HdLg38u151c7oLP9t3mqDUl4txzudLXiK63Qk7+JYbKHeR3CznhA0JLQN1pnFlMFwQQCnkvgPSsODfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Lu/PqZuh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e8Eh+SKF; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Lu/PqZuh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8Eh+SKF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id DD65C13800F6
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:49:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 09 Oct 2026 11:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791560981;
	 x=1791564581; bh=zeJQk3tmqWLU4qeEbq1ItkmIqd7Lbp78I7NuZ/N1VzE=; b=
	Lu/PqZuht1VsPyLlHjAozVx8+dJHpVpcpXayDKmVEYNqvL/1kWy7rrJtuj6FRoWp
	oO05WK4cSTJQjoXoYntBUOJHMqaANbAP3z4mpyR0Bdy5wlmVZ/s+0iwcTjk8wzf+
	joH8XPNrlfFZrxEF+X9dNxvKeBVr8tZIXod1qNGG4rqhYHMTCVJcZ2LA7+YBwFmz
	UAtCqYcOmhKUngqoMtjbTVJ+fZ4MvOCB1Wn2nOh0U9NdBwFRZTLIhWFg/Z3XYvK3
	WGOSgIY65Vj+WZpCs8B7MepJLgz8nXR1Y/wKvB9l5LbHIpxpqwNmvaJpmvtK8W7y
	UN0GNUfRlTwWtr/zdYRouA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791560981; x=
	1791564581; bh=zeJQk3tmqWLU4qeEbq1ItkmIqd7Lbp78I7NuZ/N1VzE=; b=e
	8Eh+SKFFZ8oKAE01Ei51SVkfkeQ3towsXQ5PPE8rwdxdyI9tTLreYZIlVHVjD5Zp
	UnyU0sP7Ov3mi91EDWE9eGfEqDbVTEMtF+4M36aJiV9BVZ6bKxTRvqo6izG21E9b
	YChOcjnRvRbueKqjvgr73/4y7VDNFZ44YOV0dQO6Br/eYJW28cDfXttu8tkUcQ4M
	f4IzJx+/1/J9lhw/ZfxDmmSsrTD+eeNG7L6am4DXv47YunvOV20vJ+tYNRTOFfSh
	/WOg/XWsaQWKVbbtYE17BddIv1Ksb1Zz7/xXtGxAxs9vgHqTK++iCbwb20SfM3rZ
	14MqwBpiCD4by4FK33Nfg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791560981; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Y6ArXpTUnQdldnwrk/orwpT5NEoi/5j1dwTsuYXzkf00OH0
	llxJy+WVwuI7thnSeE5FZ+TJhxlqFDe03XZN0TXnT+paPfbn3JfaO47wwUte8uCy
	VhhqPYbvEVqUN+QxHZKOKoFS9CUlu9Qa4DdMNdUm88hkgdcdcNhzIny9udQTLVfq
	qEtwS5R/G8ZjdEOThbQcvq4i76P+2WfLkt9vFgIttTq/Mwcoun3N6yDp/BjFgGnk
	XsA2/DqnnNn5zUJhiimP16d+CBUZLPjOlqjygDkA9TWDhxRW9tn4z6mFpH047zhb
	lv0sm/i8azc7xPpz0fKhp0zhk8QfD0RsRMITpBw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:FhcVYzO2abYIoSksrDxQN4sdxH0SN7UX+R87ihBj+Qc=:0S4RYWo/1GNdEp63xexcL2gmNjczx+ioAqY2FEiddeU=;
X-ME-Sender: <xms:FQ3JarA0VoXygIqTGW_pcOngso-7oyUPrteaCRSX7MYnRP0WVqzDVQ>
    <xme:FQ3JaoZ1d4Yj_Vo9ERwml9FGXsxKbqGw5hC7QuFog1yyB-ULgsYZ_ralzI4qjvghF
    hT45FFQ0-aUTf8tz5RSuYrKWDbn_WRTh9yOgpq-QetwNFPc7zYfxKcF>
X-ME-Received: <xmr:FQ3Jau4ADsN9sOO6DSFmOJ_YncljXlOk3CbJFnV1Ypto5nwl8YqCGAEOrV20-5IuFBToXvhoOeJ1D_YxIrIx8NOe4oST8bKNWEbXIFdki63MGRGqHpV-qNTWzg>
X-ME-Proxy-Cause: dmFkZTEwGHtCyoech8RKqlRWCju7WrJRU8J19jP96do2BceKeH4wLohaEH8v9XSAnNkgCH
    6eDFDekXi0ZX5mlPtC5/YwsNfBdFhZ6gS/h8rRTAqTOOT7sG1jFyUxclo35EfFsRvwo9ie
    kZWwiGsN5o7Iq2Ku2bXJPP7aWa686SB+uueQpldCySK9bm+Nla+Ic2a8TCnwpyU/ad8pox
    xnSziS87+vL0yBLCUpYsIJnOYjg3dc+K/jbTzYfadC90dt0Ni31XDnMfyCbuyfM85HGsiy
    wLkX7/wi/6VmXAZAgK36pvdv+KaTpGq6psP1KtrjAIYcJhtJSmkKSUvVzs3O7gHx4YiLgf
    tAjYD8d3KUJ58HOWzCAitTIxjDlX90PMmT+V7zPzFFcaMECaQrPN//rMlV5N8sFsFEhf0i
    te15KfQ7TRGHg9UvgMEHuCabWrF2GckEYdyQ2RppPJ8WN+ly4zrzChuKJaM/xnws7ltDHg
    XosQmiuowPrVBARm1lUtU29lZlnBMchDabfyvDK+w17z9p5rw2bOOW47KKc5A7Kf1efQCO
    LIb1GOiM4AzOpu+Hvl1ORGxn6dBnwaF2FCCUqYeH8J+nmAuef6Lxy882HuQ4zWzXsId3WK
    uGztVmnBgiGSwkWw58XYqRz+YfccHqKuptYoZ24d4rtPQT9BxjkbIM4gsblQ
X-ME-Proxy: <xmx:FQ3JapZj1WYmc2TT3DVeI-B-sNumd3fUSQnXWo_OMB1ciyUSCOeQdg>
    <xmx:FQ3JatjnsZckfJLjo3frrHfMvYdJ-oLreQKA0aMSLDARAsBiNl7UjQ>
    <xmx:FQ3Jaq8gKHwYGwRoedW0BUPmofRIPBnFi-ob8UhpMjjQC9SX422zAg>
    <xmx:FQ3JaopsACQvyEc0xTOkTAf6qnIxBmCYvkNhvVOGc9sPeaKoOBFl9g>
    <xmx:FQ3Jakrd5e-Fat6uMO8527TKjUqY_fJGPdorjupWSfeKi2_K7zZl3HrR>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 11:49:41 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 11:49:40 -0400
Message-Id: <DM0FD46SBK3O.1YAZ1A9YPENY@fastmail.com>
Cc: <git@vger.kernel.org>, <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/1] repo: add filtering options to "repo structure"
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>, "Patrick Steinhardt"
 <ps@pks.im>, "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: aerc 0.21.0
References: <20260924164503.119506-2-markchucarroll@fastmail.com>
 <20261005174045.1900391-1-markchucarroll@fastmail.com>
 <20261005174045.1900391-2-markchucarroll@fastmail.com>
 <asSMX-K2qLsaXc3v@pks.im> <07eeee7c-4086-4b7f-b59c-74ba7227d6e0@gmail.com>
In-Reply-To: <07eeee7c-4086-4b7f-b59c-74ba7227d6e0@gmail.com>

On Thu Oct 8, 2026 at 11:46 AM EDT, Kaartic Sivaraam wrote:
> On 10/6/26 11:21, Patrick Steinhardt wrote:
>> On Mon, Oct 05, 2026 at 01:40:44PM -0400, Mark C. Chu-Carroll wrote:
>>> Implement filtering for repo structure, imitating the mechanism
>>> used in "git log".
>>=20
>> The message should give an explanation of what this change does, and
>> what the motivation behind it is.
>>=20
>
> Indeed. The cover letter provides more context about the change. I think=
=20
> it makes sense to include a significant portion of the cover letter in=20
> the commit message. We could even likely drop the cover letter=20
> altogether if it feels to add no value.
>
> That said,
>
>  > repo: add filtering options to "repo structure"
>
> I think the following may be a better commit title:
>
>    repo: add revision filtering support to "repo structure"
=20
You're right - that's much better.

    -Mark




--=20
Mark Craig Chu-Carroll (@MarkChuCarroll at gitlab)
*** Software Tools/Math Geek - Software Engineer at Gitlab
*** Work Email: mcarroll@gitlab.com / markchucarroll@fastmail.com
*** Personal Blog: http://goodmath.org/blog / Personal email: markcc@gmail.=
com


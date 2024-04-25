Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A32153834
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083387; cv=none; b=OFQx/bGrLgeeh2+duNBVykLO54FFkl4Sucp75tcELfzE+6le1N6Afh7VAbR1zcTPr7bOZwgWD9cN+YwLKy+YzOciUzduMTc2vvMuYbgsGA1La+ST2pei/F1djmzA/Yeh7SpDX9Tt0YvMPvtx/YyHSvVCaifJ+XO2kNzft69qSyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083387; c=relaxed/simple;
	bh=7koEkSXH7/NdTRkUuU2BBRFAmb/A02lZFUr1UM0FhVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bSuwaPXCqYC0fmxInRgR9fdms+uGGFSmwImXJBmwOibUnR4vjltbTBCYU2juViqy6j2v0QsGgyYDlWSbapC1fXJ29I/73jfLDXDC1n5vwGn5EVjV+DLABi64rLo3EwpEIoh4xYLV65/iPrPw209PZ4XYifFd7V6HDHIEhJHdeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kTu55ZU+; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kTu55ZU+"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F3E03F4DA;
	Thu, 25 Apr 2024 18:16:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7koEkSXH7/Nd
	TRkUuU2BBRFAmb/A02lZFUr1UM0FhVA=; b=kTu55ZU+zj+2SP0ag8dUyWVZsf4R
	LOs/RBm2GKk494B8CPmQAHsWzh/VkBCuCfsz9m0LIoZAnm0H7QeBDijs5KkML9Z/
	kd+CsTx/rFpbUC9hfHASNxAzcDZNytigrD9vHXUKySblN4Z/3DolbJ2Wk+FUQpP6
	sI/eomNV1W7bPeA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 45AA13F4D9;
	Thu, 25 Apr 2024 18:16:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5F4F43F4D8;
	Thu, 25 Apr 2024 18:16:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Jeff King <peff@peff.net>,
  Git List <git@vger.kernel.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4] add-patch: response to unknown command
In-Reply-To: <5854e33c-b84e-47a3-94c6-c5fe8c9a4c98@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 26 Apr 2024 00:09:20 +0200")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
	<db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
	<b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
	<20240425014432.GA1768914@coredump.intra.peff.net>
	<CAPig+cST4_hUwWg+P_drqT-mv8+eLAzBmuMFXm=Dui14kfYZzA@mail.gmail.com>
	<xmqqedatfay3.fsf@gitster.g> <xmqqv845dug2.fsf@gitster.g>
	<5854e33c-b84e-47a3-94c6-c5fe8c9a4c98@gmail.com>
Date: Thu, 25 Apr 2024 15:16:19 -0700
Message-ID: <xmqq8r11dr64.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7225ABD6-0351-11EF-98C5-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On Thu, Apr 25, 2024 at 02:05:33PM -0700, Junio C Hamano wrote:
>
> I am assuming that this change will precede my series.

No, this was merely "if we were to update the series I queued to my
tree, the squashable fix may look like this", which you can use to
update _your_ series if you want to.


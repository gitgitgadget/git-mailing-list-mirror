Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3181C1E9B1A
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785558464; cv=none; b=prrJPNLgNbewKkh2+IecFwOLvJ1wwG373TWbFmY/p0s89c4En7OXoTn7ZUZYhjRms/j+1+Gq81B4eCoy/U4SrT0J3TzbnMU0AxSiJj1L4cOddpni01xlk6RtEZk543Aqe4NiuisppJJcdV9MInG7IrK6XWx/nmOOUI+Dk2oOcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785558464; c=relaxed/simple;
	bh=hU6xezQyMyFd/Nf3fpXdb7jyCsOP6Nc0aMFrw0uC/Dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LhHbA6vWTtkDljWGaswJGstVcMufwNcVgFUx5HFgml1AM++zKcZT7DheGmuVkMEmQfOpVx/WZq/CrOx9OKOMB5kNBRTZbveh+duI1Vv0VpTIOKJ+9rmSDP32Wr9+6N45AQlmS42hm2i6iDSA3H8WL5IwGXGHRheWjKwoTTONCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Riw+76o9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hCwy7IZs; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Riw+76o9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hCwy7IZs"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 28FB77A00B2;
	Sat,  1 Aug 2026 00:27:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 01 Aug 2026 00:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785558461; x=1785644861; bh=vxL5IkFjYV
	NB6/9ECKF/fgq8ACbl268qgV/9qC9YQNc=; b=Riw+76o9fg2p2EAcfeuoZ1vuxq
	jPOh4lGutfD6WHYZpnI8OFfO+9zbwOUKDrEayauk83wndyPcvSKzo3EV5N3QbdkH
	FydHk99Hr0IjfHZAdhfoCrROJXoFKFKew9QzoCZeQst79z/86mIN89m3h4AwF5tV
	FEXkyx0zNkzEkUrb1MFl7lBvDSWKo3SaXcKxWo/GdnDCdOTcAQq+C55snbjzexac
	QIFx3vPdDaMEUsrdekQkEN63e88TykWXvspCwdMz66fHEDzKTIh1gPefXpJJmS8R
	IL8VXOZzdawGd2Wb4Ddr+UCmWYW4JTmtF/YaM/NMerVu6JNeILd7mghntmOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785558461; x=1785644861; bh=vxL5IkFjYVNB6/9ECKF/fgq8ACbl268qgV/
	9qC9YQNc=; b=hCwy7IZsn7kWuwQyk4oXtb5H0Y/hQRXLfN1hJOmvfQLsg7KmYMw
	1Vo5IXdrM/dSNK2jry1J8N4zFPh5hs85KDuaGx7rTh/58l1uIoFb8VDGSIA020Nh
	U40IMjaB3Ay6ATadaS1ZpLN6dw6+pY8VDzI8OynFah906HdItxgo1fGHeSdccSoV
	frm56H7uuQpm4nGoXKo8xAN1CUcq0T4u9K72mSIjPFY7R0OEhGwfwWTJIhPV4+uj
	qng2CQqLWBTKkIKespUw7yBedjX2oxT7SBV/DBtpfspXwUO0G2dSFrWlYB8KGrrU
	2FEW0D/lcB9493sidzcxUMy7A58rRgaUUew==
X-ME-Sender: <xms:vHVtasIDybE4chKh1l2fP3JuxajlJNXqbtDmXB5Cg8uBhtFK8h8Tog>
    <xme:vHVtajDM-xkX1WUO0SGNnswAdxlmwV515TTRYqH_t9dAnVmzlL3P-8UdsqPtYuX-a
    cOR_SRiCGAWy-HUZ3eq8UwgEUNumlWd4jM7EdnznzPpgvNH-yoNWWg>
X-ME-Received: <xmr:vHVtalCj-8jNMo8ZVin8dT4vHAf45X6rzs9UMDkMan3PI_6Z9WCPbBJtwq2esLA6crMvrZwHe3K8Q2aTTGY4Mb-mrew0yVr0JQ>
X-ME-Proxy-Cause: dmFkZTEQIOgbElImS8POKwLpmldB3h1NAsbsiQVeqdIewBg1ppZkO7y6zZY88afeMCbbcY
    6wC7fMhusMgbeWoQYbx5wdFmkzZBtlu5aLHi67D5NIip27+w5fxmUcc/PB8CPxkw03y+aV
    W2Gd+EYKnI2oko+7Jcc4RCkMkFG8S5nMW3ZMLsu3yKxMrZ4Uie18t+h40BHD+N2Kunc8PJ
    GlbEqxi5xXXIJSME4+cwU34M3hMCT5ZxfED+4mjRe+TZea+IsRe/Ku1myHXMNa9pJHfR3z
    WV9PXGIlDevdOFN0tqtpn/nVcZUuho4k7x7UvWNAqHjI714SxqFbaj/IzrJ7nUSDhhthUi
    3UV9iyh2Kwsu0VYrUjKa2wERKs7zxzZo75veLC/Ri9Hy1kWg1IUh+WybCf52EK75bKUakS
    RrRa3oZlRnWNS2loDjuMnekmplRWH6iqJJ1VyaLL64ushNntWR6f3s10v1q34wfGtAzVLv
    ttqvSVMlFSWgdXoGk/b2dU8sG1ZTmQpELnM6GM16zBbAHIEpdqFZlNNYCRNef/wy93YyJf
    PFcmj1t+/Xapx/Ft1Au3EnFSuQvKfUucpEIxhOtuGhr6zvtYRKuxbIaqebo0mGtcjhVGwx
    Qjy2itWwU3F/jwBVfAOjHlEOYiYHkl2WGZ8eP6TI8bnblemHnraB6QYJE9jA
X-ME-Proxy: <xmx:vHVtalCTPxvZ64Xz3zoaviNlqpXcnQgveZM-F7_nliQUQwVu6XbCAg>
    <xmx:vHVtagpWQRv3SvpbjqStJrRqcSa2DxWabWUlTpBtuAWT5O_t9uOUhg>
    <xmx:vHVtavn3Uk98JlIJMH6mU3ZZrlOph28MtUbIx8GANSxNVxg1tVwdiQ>
    <xmx:vHVtagyT4i7GeCf_hHTQSww87E1CRsXVN8Yr6_WRsK23A_jsbbUd-g>
    <xmx:vXVtaoQ5CUVaUfs_LcYbFejZC1CRmRwmFRE5TYmCAipQfVvH2lXTmlw4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 00:27:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,  karthik.188@gmail.com
Subject: Re: [PATCH GSoC v2 2/6] t5701: use the test_file_size() helper
In-Reply-To: <20260731-objecttype-support-v2-2-af577461ed57@gmail.com> (Pablo
	Sabater's message of "Fri, 31 Jul 2026 21:49:35 +0200")
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
	<20260731-objecttype-support-v2-2-af577461ed57@gmail.com>
Date: Fri, 31 Jul 2026 21:27:39 -0700
Message-ID: <xmqqqzkia2is.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> An object-info test uses 'wc -c <two.t | xargs' to get the file size.
> Update it to use the test_file_size() helper instead.

What is missing from this description is what is wrong with the use
of that "wc -c | xargs" construct.  What benefit is this change
supposed to gain?

> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  t/t5701-git-serve.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index 9a575aa098..b4d6beef11 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -356,8 +356,8 @@ test_expect_success 'basics of object-info' '
>  
>  	cat >expect <<-EOF &&
>  	size
> -	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
> -	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
> +	$(git rev-parse two:two.t) $(test_file_size two.t)
> +	$(git rev-parse two:two.t) $(test_file_size two.t)
>  	0000
>  	EOF

It is not like we want to avoid piping wc -c into xargs and hide the
exit status from "wc -c".  We are already losing the exit status of
"git rev-parse" anyway.

If the test after the change were like this

	two_object=$(git rev-parse two:two.t) &&
	two_size=$(test_file_size two.t) &&
	cat >expect <<-EOF &&
	size
	$two_object $two_size
	$two_object $two_size
	0000
	EOF

you can sell it as "we do not want to lose exit status of 'git
rev-parse'", "we do not need to run the same command twice", etc.
But it is unclear what we gain by rewriting the wc-piped-to-xargs
to test_file_size.


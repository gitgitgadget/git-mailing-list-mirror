Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84C948EBF3
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725659; cv=none; b=orTahTDcX27B4zXoSXqM+HWf2Et5iJRCPB9pn1t6xNqRXC6qw8wfJMQOIolO7TbJRnxDlosUbfkG6z9ZUVROsWIU9jWDsxzgRvF8V/6zkwMt75oSJIz0NSBmHNhUgc4SezLyNZye0x7rIzFamsfLuYwILBpSGKMyi9+y6g7CpQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725659; c=relaxed/simple;
	bh=s9p+IG4ZFIMUV+BlFqkDGeRVRh6Ze/0mS3DjUAFA+aQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=epe8nALr80IITo1TqW08fwlFXtsfiCgjZRoyv4vW2o+DMsu4Yy0cDrgrA1Je8pbi/RWmDiYv6AYrkdxfH9qN5m9tM+jr2oaaR3No9iT7f6uiP9WFg58qxFLY9bVwxW+QLZ8bUCzDddTl5rncTO71ZOZB7/UaXmBN1DaNUULJk2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qtwBqUx2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EnS24+DD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qtwBqUx2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EnS24+DD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 415B1EC01DE;
	Fri, 14 Aug 2026 12:40:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 14 Aug 2026 12:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786725655; x=1786812055; bh=FWXe2joiC5
	MWVKu1ZakRyz+IYwaN8ko1i3+mVwpJlVo=; b=qtwBqUx2suVmf24zmU6gR27b34
	70uNN81ReN+tRFk9EYzy93YDbbqFw08zqHgjv8EuI7g05InOJ2RU6/e1FHDhmj12
	q6t0Ph+SSRPwMcp++p9NOUen0nS0TOVJ9aUlSJk5OYRedycl91hRxKfZGDGtk1c1
	yxINthJS0HCLPY+aPtwxvYtJb+lzuwSCyLVVAHOqg+LqLicIwwNN3dOANGoMQ0C/
	SlETwN1+13dN2s+Ak7zA7kf7PhJjZ+Fm355WzlUtYfjwvJGZUREkoIDiX4sUZEBx
	sjo5e3+aMALhnlcXvcySsFO2eQ6JErDPPY5ELaZr7qFjFzxF87B0Pl+DoJbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786725655; x=1786812055; bh=FWXe2joiC5MWVKu1ZakRyz+IYwaN8ko1i3+
	mVwpJlVo=; b=EnS24+DDJXEdnfY3yUxYWxt3vvqleeP9dSfBBGHFfW4nSofVDSr
	H1aqAMMDzsZWBscU1riOqWaPHeIPpIPIov1oLYuTrNpo33dgQ7YeBuDbggVlJlp4
	YX1izYNj4C80Oj07OM2bKzBRW8juY8ucv34GKiWs35n5rr6CNY4ronNnErx+LBqE
	QobecR6i+UmVlU09b7Mc2jiJdHkaq978Nac9btm0WDvRh7ceT85gwBhnNQGPEnII
	Y7V/6kvmCeJs8tIsxim6NpLv/ZZV8ug1TFTefK5MaPljqZd4I5RqwfQ6ApiLlx9u
	XsUnOmYWqHsI5Yl2nu7sPKXCsKhtKUAs1Zg==
X-ME-Sender: <xms:FkV_akcqhI8VK_PYS24KkEKeQHRwUAFkshKr0MrlUmSKEzM2y6ACHA>
    <xme:FkV_alTFHvNZg4NCNUa-mhyGH8Vq2ShrAcbg0re5kLxEk8840ZG--rRjAVHj0CxEz
    CXcxbJ0AP3HecSNtV23I9bH_h5sTEINkbV8ticxdzp6EI8FSbzD>
X-ME-Received: <xmr:FkV_ars6YH6Q1QfCZzao2lggkhkmogJcm-_RTbRr-s3QGpPMyV0eTgf6s60y41hK6YT30Lp3xqpHkVuFxaqVZCG6o2EQieZJWA>
X-ME-Proxy-Cause: dmFkZTF7LNQp8SavGN6qTj0Uhm6iyuAotWPzbS6qa1k+Qar+Rl3GPkL3VwxL0sOZTyN5Ar
    lkT435PLlneD7Kl5N/dHGfawBnFcyciLwnQV1BvzmJcKE8nq3izV65HH/Dn3/UT/uRsmg1
    DYYp/EEdGUctste8iLeTMphqVEOBrb3CUxYz+zYd2NwvE7D57q8kG2aBrO96568LeCDI44
    iSyHnzWv0H4v67YqS2UD4jdpwXS0KC6mtGosWCsvO+BZ3D1lI19hBtkpnfd+ECbQXf59eX
    HSkXaZNY0YhsJsV0vLoZeVf9WikHIAvYz+4SOm0JNe2zWQdbQnQxzgPbnOelVEoixe0CIa
    LEHO6bsYlImvLvhPkRORgIJRxk0p0tZ1OQPaoxZxiRhQBiJAZf8v8VPhPDuIOXcw3I5gw0
    GgRPLJ0yliZscrr8WRa2ObM1f+EgDMdwOclNuMr/TRfqWDUm7NdkXPGTI4YVPsl3AMdNIu
    rknXiPKHKt8TikM35MCBcEuDlw7yvo9Utt/ljdwMDKH/8vEr6I5moJeAEQTxd9OL3fB+eC
    zaBIWcgjbayYAjyNNezJm9F0AO59ux4nbx8VhnCLK1odrE8quwP2B+Fc33WArtJT+POZTw
    2eRqABPb9isSV4RIRqzIfwrcf17+Yrt8NeMQRGWPnZAZMXeORZ3NptN8nr3g
X-ME-Proxy: <xmx:FkV_amchCgcXWvkKi15-DpDJ6ZSi7sYnW0fJVPbkvUTZbJjGLUrjyA>
    <xmx:F0V_alZRhV4qh5u8FVuzQzp4Mhgv2qm_m8OcMOv6La9MALasrR_2uA>
    <xmx:F0V_aobj1nUAGV-1tACPYEFvGg032qyKkoetbcOLniHcT3QwVy_oLA>
    <xmx:F0V_aqKUNLP7-rT2dWnTQgrpIMWENmozk6t1_BsA_EDTEJ7FxPi0iw>
    <xmx:F0V_anj1L6Oo8FHIt0AykLgFu8aVAKVDNtsFugsSOapYUGNIZsQZ2qGI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 12:40:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 0/5] Introduce 'uploadpack.lazyFetchTrusted'
In-Reply-To: <CAP8UFD0Mr=6KkJShU+7hfWGZEyi--B=Y1aamPSXO7z97sbTBmQ@mail.gmail.com>
	(Christian Couder's message of "Fri, 14 Aug 2026 18:31:42 +0200")
References: <20260807135511.1818458-1-christian.couder@gmail.com>
	<20260813154748.2378747-1-christian.couder@gmail.com>
	<xmqqy0e9rcd9.fsf@gitster.g>
	<CAP8UFD0Mr=6KkJShU+7hfWGZEyi--B=Y1aamPSXO7z97sbTBmQ@mail.gmail.com>
Date: Fri, 14 Aug 2026 09:40:53 -0700
Message-ID: <xmqqv79codt6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> I have never seen either plain vanilla send-email or GitGitGadget
>> produce misthreaded series like this one.  Do you have some custom
>> settings to send things out?
>
> No, I just use `git format-patch` and `git send-email` without special
> configuration.

Perhaps you are contaminating format-patch output with In-Reply-To:
and other message-id related headers (perhaps using its options)?  I
don't, and I suspect your mentees probably do not, as their patches
do not have this issue, either.

> Yeah I should have checked more carefully before sending. Thanks.

Thanks.

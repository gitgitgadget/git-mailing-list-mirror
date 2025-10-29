Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606637A3A7
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744105; cv=none; b=aisJn31Pn2PDx4RILy7LL5gevkyh1kmIeaUZba18MMk7l2CLnQMoCz/whtPqwbQWT09E1eI5K2921qEJJlMimZkCND7Xbid+uFBiKZ1VKdntHcHSzAIOVTydv5lacEQwyRrL9a/7KAvtVtmb6dbNR3+749Z8GdJr75TPYe+hjGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744105; c=relaxed/simple;
	bh=4MOraiqJw6S3Tq+JuKlZa+7G9wq7jTF0KWyM5Wye5wU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lS0Z5aZ7genf059QJx4eBV8OCCx0+/L0VgbQHz4E5tmuogzbcQKt6iX41+wuOPZvPwm490xFE5sVxn8+TAPV9Vr3YjYaqyvs1Fi5MufyY9WFGKyuxfSm7k2Z0GdiQ0K5s4uW6SYnb6JcynLV0edmvIO0GD1V9D9KlRbg0kFuFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Beo0oMwq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NePg+fXS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Beo0oMwq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NePg+fXS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 38E2FEC0866;
	Wed, 29 Oct 2025 09:21:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 29 Oct 2025 09:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761744102; x=1761830502; bh=4yzG/iJFH5
	WVrfWUPflXxSlOJ2YA0pk50Tq3Pjj2vvI=; b=Beo0oMwqson//bgzf/cj8G01KA
	ejQTT6b/FEtB9MWFtdncoZrzvAkT5D6kkrA/juXTkFY1vjuNro9UgpkXe46gCojY
	9GLex1XPnknVnj62A8JmwMhM27RMINLYoJrZ14pW0au2r96LHJsaGXFsnRjko+qQ
	I7U5cMUAS95lg7ta8CqjWXBJy+9ZOZi84WVLbXLYzZxWE1LQmOftmYYtbwSSKHbl
	QcakAf60oaDAEgIi7VFux+Nw+5LB+7H7EZ8Xzva5cDU9MJPMROCPOHKgQIMlHLIM
	pItfQs4qG51gFI3QQRuV8pPaMlwY41z2OPYdpiGRpC+7s610qGOewsSPyYAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761744102; x=1761830502; bh=4yzG/iJFH5WVrfWUPflXxSlOJ2YA0pk50Tq
	3Pjj2vvI=; b=NePg+fXSvVSdG54vJJZuhOTtJ9yHylYIoPr3E7uEk8D+vtWbJxb
	rfGPzBe8b+3UdYMhRIDqPDmox3RVF9ThF9Qc+JG7MGv55iHLnvslVDjKwLhmXStp
	4mw8CRRcYhwjI9fnAM+ZkXygwtZTIwCdUn6QC3OfkWK++qoymj+9L8CrgbtTaOeJ
	4YH0FbGT+d8G8rdenQbz4BWlv9VZEWnKayVqe6cBA9n1tOzOCaDPzJn9IDcnWeH8
	RMnvJZ6AUbOmCuabtSbeJDyqYIiDwqVpWxTZ46CDl0BOBI1ChpgogExKcr8cRuEC
	OhliqvBEkVw59IVKL05UpxiZfGQf2Fowptw==
X-ME-Sender: <xms:5RQCafFB907aX9BNbSD-9d-KIRRrD7sHFHn9Ep5yHTA0Lni7HJ8FUg>
    <xme:5RQCaTyRgz7P10EdIFcA3Xf1NT0XoSV0gQ8Vcft6uT6c_IhbuGBgWvbgv39caWz1X
    PjpKEwkgeXMNwEbU672TaZJ2Dz4VBI07upb6c_XdmmZ_W4JeABZy0E>
X-ME-Received: <xmr:5RQCaejGTvJSUD4uQduEVi6dlYondWZLzeaLPLi2UV2nHbQngWk6wWMiXo1UgWc9pNroH167USxy8oYhXec0bEEfbJczLRAkC-PZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:5RQCaWyk6Wj2cRKbuoaNaKChLCsrXjrIt-bocXNNuE8RmWVxMAvHDg>
    <xmx:5RQCaZKFJTsRja5KnGTl9derrjJPq3Z00Izfh9F-vzWIfw_NBThl_g>
    <xmx:5RQCaVSMJK5LHSIuAaHY4U9KJxL6gy5UhEoiWqJ_OciTmvBkHRr4QA>
    <xmx:5RQCaZpB5p4mE23XiHlyGdcxO8k4dCRl0Jgvn03X_aNgA_JhwAfBZw>
    <xmx:5hQCaT5NbDgFomTbKXwtdZ8By6TSOOm374WWpcnMD1cZWC3zMAHFFf-1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 09:21:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] whitespace: correct bit assignment comments
In-Reply-To: <aQG_eRPmsxKqJ0H9@pks.im> (Patrick Steinhardt's message of "Wed,
	29 Oct 2025 08:17:13 +0100")
References: <xmqqfrb4hyjl.fsf@gitster.g> <aQBlCCDWMhLX_aBa@pks.im>
	<xmqq4irjf8mc.fsf@gitster.g> <xmqq8qgvdm0y.fsf_-_@gitster.g>
	<aQG_eRPmsxKqJ0H9@pks.im>
Date: Wed, 29 Oct 2025 06:21:40 -0700
Message-ID: <xmqqcy65c07v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Oct 28, 2025 at 09:33:01AM -0700, Junio C Hamano wrote:
>> A comment in diff.c claimed that bits up to 12th (counting from 0th)
>> are whitespace rules, and 13th thru 15th are for new/old/context,
>> but it turns out it was miscounting.  Correct them, and clarify
>> where the whitespace rule bits come from in the comment.  Extend bit
>> assignment comments to cover bits used for color-moved, which
>> weren't described.
>> 
>> Also update the way these bit constants are defined to use (1 << N)
>> notation, instead of octal constants, as it tends to make it easier
>> to notice a breakage like this.
>> 
>> Sprinkle a few blank lines between logically distinct groups of CPP
>> macro definitions to make them easier to read.
>
> Thanks, this version looks good to me!
>
> Patrick

Thanks.

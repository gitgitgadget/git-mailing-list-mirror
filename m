Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542CF502BE
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761541; cv=none; b=g+o72CjdG1J/P0r91hImouOY8cAQJ2j/Z9d0dPEJu++vz8Rwu54de8SdoXqqi90QmP9l2M+pWZWYfORRbu3f01cT/KJ/NYqPrsMudRCXYsqpcniheQyp98cw2L2VRxOsRpwTMGiGh+SCLF+Ze+pJBJLOnxfKAeDjhChb5bmRtss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761541; c=relaxed/simple;
	bh=2PFR8ZpyqtF+Aa2xrhW9PFY5FdVegpD5RfrVjuqhtew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YtIRE+fLqmbvnUa33riu3ef2f1af7IgJghs58b6+m4Sf5pVvBRb1RMxk465IAv71k8ts57Zo4jRCXjFeB3q5rO3P+K9P3msGrwjvF94HJVoKzIo7/Lpt3jgSx6CEC133Z/N12zIXFkmhV+CZ1whpNjqhkWvi/o0wQZG+bOXamNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rTI/Y7RQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sBcOA3uz; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rTI/Y7RQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sBcOA3uz"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A12925401A8;
	Wed,  5 Feb 2025 08:18:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 05 Feb 2025 08:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738761539; x=1738847939; bh=6wQORl42vF
	sLadmZS6YLw8Ez4aStPobZjtcBQVin0p8=; b=rTI/Y7RQdzmvHLR4Q1MhPgsDGC
	D4JU6h9zX+0teluDWeug+EIchaqQD51MGI+HyAwaSJ0+zuYUKGxRl5E0lPZHYmnl
	Mw5T2AA4KxmVmc+JRvUbkfHaISJqU4qru7MY9h+07zSyY91s4D6ITZRM62vRktGQ
	yLoD/hpa1U30mQVR6ybgf/kCqgvo9EYnfVYyfaRzlVLL28uL7w5MP+eNK8EoNgPV
	wsZsJvXGUI8fKb0L3LOuRKtH66F2axxtEgdy+5ZqLkiygnYXW8uKPEPexnsyjzsY
	9YxA4crmVzVyeHbg4vwFkWJbSM+XFWt3HVbWjhhmmwZo8SCzAn7mAH0OIv5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738761539; x=1738847939; bh=6wQORl42vFsLadmZS6YLw8Ez4aStPobZjtc
	BQVin0p8=; b=sBcOA3uzYbhL7Sp3QGg35nzuXyYIgwsB41WGCzJXESWPIMPVexR
	gH9+oiPJE57urYodVX/MUDZa5A9yw7XJLpjpoxFGL/1ECq2uF4zb2V90av7CLub6
	NnN6AkZ/LesA4vxngVU6p0J2Kzyx/MuxK27xIrY/6JFQAarqQf5hO/fyCKschz73
	EYPikRVVrCjNaePWP5wAiEYcS7aLqaScyoDgY9nNq9JE4Xawu3/36VHnfYfDjsp3
	YQ74QT/2n/KjoWoOinB3y7FLs3Mj98ZZ2HDjTLbQKUJgtJ9FZJ06Uw6oOLnWA2j2
	LGC9jdiXqU2Ni0lRu9uqY2VE5det3OKHqdg==
X-ME-Sender: <xms:Q2WjZyuMnQ-Kfo-Vd-Mt-LEZNIRGZF8ssw4X8W74a4GUXIBBvMUfXA>
    <xme:Q2WjZ3dsnfvWc5C7_OwpbGlOETLP0XohlFrbRI7ioLWlpcpYZZ518Ohd5CF551jjS
    ZBW_gRB0Z5yChfgCg>
X-ME-Received: <xmr:Q2WjZ9xwjridJBzOPfzihOorI3peGlgD-49Y2XE3hrKGsQjUkZjF2-9zrUBXYi6Yww_i39rRuaWyeJuWR6XFp-Yoih2RbcwfIouf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Q2WjZ9Mhv6W5Leptqcs-zx4brK-Yf5xgY5jbpF4yhqjkldpslAiqaA>
    <xmx:Q2WjZy-9jK8NhmWzL-e_IYzmWm3BInQGphqZWxeZUJPtJwTaxxmgYA>
    <xmx:Q2WjZ1VjH9vuGPHKfZesVgf1er0ia7zwWSW6SDWRPUb0YqJ1OXdzzA>
    <xmx:Q2WjZ7c6lTpjN1eSlVjtGnfoQeGWPcia20NG4H06m6q47XNgllL5UQ>
    <xmx:Q2WjZ5la0IyBSNkOHXrGalpyii-skcQ7gNx4_Wn9YX-2mRxpoiAUgK_y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 08:18:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v4 0/2] rev-list: print additional missing object
 information
In-Reply-To: <20250205004147.887106-1-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 4 Feb 2025 18:41:45 -0600")
References: <20250201201658.11562-1-jltobler@gmail.com>
	<20250205004147.887106-1-jltobler@gmail.com>
Date: Wed, 05 Feb 2025 05:18:57 -0800
Message-ID: <xmqq5xlor0la.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> One concern I currently have with this quoting approach is that it is a
> bit more challenging to machine parse compared to something like using a
> null byte to delimit between missing info. One option is, in a followup
> series, introduce a git-for-each-ref(1) style format syntax. Maybe
> something like: `--missing=print-info:%(path)%00%(type)`. I'm curious if
> anyone may have thoughts around this.

Would it be so bad if we said that in -z mode with --info option,
each record is terminated with two NUL bytes, and elements on a list
of var=value pairs have a single NUL in between, or something silly
like that?  The point is to get away with just a fixed format,
without any customization.


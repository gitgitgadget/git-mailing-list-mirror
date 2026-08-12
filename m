Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1AE37AA64
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544251; cv=none; b=K7TZeZcK82XZauuZhlw+wbepGumrIFoOXxQRCrxa4ZPrAxzpR2DpDffzHQ3WeHBDUFfDpaFQzvvuad8g5YmNBjbEZEN0wBjKd9AXJm5JgGsaibMk5YdDomx9Yw8pVVRdxb25jBPL9kxHxV3pJy0k1QWz9I3jPIWI3P/25ilxrFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544251; c=relaxed/simple;
	bh=lYH6C6GMyn4ozW8rYUfgboTS1oicZbkidAl7NUD2uDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rFjNQFkrIQ3WFyjkrRYfQ0xasbAbm58Fg+i7fD0DflbupXPV9sOu7aTxteQxvjVzPmt7R/NTDnMs/5LSbo6y9AQ1Y+nNxkak+FbVaTlka+FTFlQHkwwezydkhWTWDGRsZBja7gAv7M9rMxTctwcPDq3ThTf+oCJsqQH+gPKqqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ncni2uEg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gjnewi07; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ncni2uEg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gjnewi07"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A254714000BF;
	Wed, 12 Aug 2026 10:17:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 10:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786544246; x=1786630646; bh=FlJbAtbVSR
	YIeR1IoN+55Ok4C6khhqDdJn4iwlm8PhU=; b=Ncni2uEgsVn4TLX97HJszY/HLJ
	JedIoY5cyO8Res6pxfuz9hxDFJPwH3jLJRBvXwl4tMVhr52VZa64ZwyZNgrTx7wh
	JOTjeTv40duj3nC8lfTTRpqOkRlPDN7Q6M4A6lDFDDTpi0vXhYr4lgbIGMTjQBAy
	bS0CFSS4ae51nICxDDNaXYNWTDjqHfoElm5KnsIMYcISYQSPZO5sBEkTWYzP9g1g
	/GJnFPjdyacKeMVNje4TXKfbiUsI+EX+q7ISYt0yVpaK0lXs3Hw8J+gimL7ieHoh
	SgqcYjhdUYyePttjqHX0jb95ApzngsMnGvWWS602D85gnafzBMlNP7cj8/zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786544246; x=1786630646; bh=FlJbAtbVSRYIeR1IoN+55Ok4C6khhqDdJn4
	iwlm8PhU=; b=Gjnewi07WoJ+qgfpyFo1ovhDJoOOHThQ+rdTftJQKa38zqkhpRw
	KySyNXdd1KxqER7dlCyvghwkOyObe+mj8nBY2M1FNWwjcGVScWbCoqPQ1NycZ8dD
	CxCrrtudvV8VhbbYSlOPFudYsWROui3wBciQdJYOp7CK35T77DiyGLEhy7K1MuxS
	CxIhdaMoT+5p3lA6/3bUreDAJttXJpwJItDwmA+kV3Vd5C3N5RFo7kri7jDLDrVZ
	lYoFovJL6/NswAslkvRcLpbi8dQtrMMAWdaF2PynFntLYHukYwKifXfzZP1chr4V
	cx4QTi/Xvm/JKiQYLpFtPsp3pOC4XdHidAw==
X-ME-Sender: <xms:doB8ajxOAOJni6fldt7gln-OW9H9CglmZL3F-HSHDk6v3GALmVdRyQ>
    <xme:doB8au94LJ9Zc9MegZadIcEwubq7tNGX6ywdKusTXFEc7YnR0j-8y9K1fnrvt7eHL
    TpIrO7mr9-zNmmCYOTVVqaouToG2bq0NvOVMvn3gH4sVRs7rYkh_g>
X-ME-Received: <xmr:doB8anKSrcGHnvQVlqo8jxU405wl2Usb5mPFpjFTLpDUMLNEw7zub3WdcVJe-_1jYIr8LoyQpFvoyiGOtE87xNy3Kenc9O5_Hw>
X-ME-Proxy-Cause: dmFkZTFa3qS+bvtfoXiqOqE8t9ZzbeZ57fc019bq0YxsQnR7Cz022A/vZPa9FilPRCAv34
    x4DEBa7qlhPW/fNgd58ReFNwTQxKhurxsQe9008Obo+OO7vXZeGUwOLm9FfssRYUXyjTRR
    uOv8j+1tA4pvxTXntq8BoSREmtmMamhlxgPYjr1qIfiq0TaLnqrOVf56QKEooBQMeoXe+y
    MIE35XboqLtStmjsQioXIKtq7oPvt10ODEOpd1YrBKZeUS8HxlKsSQLa/4kOAoTC0CuZ87
    NbVwkXvC6hka0WOHHbO4c/fBtsu3mFF4BE8h3D3xQXImZp+cpHvjUBQmkgBIPFDI9z2IB8
    SpXYjwwrsBFo/8cB7wQyed13ePj+kf/ZLtNcux+RSHgXEPnWvEp6N+RYk8HzckVDos/4sb
    zTMvGHolGmjSJzBKjfHQgh9zFQh5pMQB+jqyKhLo+X8S3sWFH777+1wm51HZkhkXMOeQFh
    5Jkyb6DpLQD/yByNxbKQO1hdpTHXEFWKcqolY520nkjRcdaAr3T3FKqo7hQsYE2Ac90r87
    0DqF6qLleVPGDXpiZwXHqyK9WNXMVwC0cdU6Sgg4DsPkp002/rce0jtFJK/m5FYuK7gaas
    ZHnw9Ur3OjyzU97/0WPDIw6T3oWrljLaSfTZDrIbO0tyH4FYCXfc3eMle6Ng
X-ME-Proxy: <xmx:doB8akc2fynQObgthBqQg9qI_BSZoiEHmj5enNzLxhHJ7dCFJOMe3w>
    <xmx:doB8am-11_dCDcEu_76KUOVy2nUKc1MBoc3Gai6bTS3i8oJd1rrmoA>
    <xmx:doB8ahoZXmfW8nVumN6l3hBbLUg-DZuQdSCK-4a50MFvCF-AqeSD_w>
    <xmx:doB8arCCnkslgIdWhpXRyVBVB4HiAPovf4d83sG-UjTDqN3gZ-8Erg>
    <xmx:doB8aiaauFjZ-lVwRkxv12MiC5Nth02tNtQm612Xj1IyL_m1P0NyWmhZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 10:17:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: graysongordon-gl <graysongordon1@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  avarab@gmail.com,  ps@pks.im
Subject: Re: [PATCH v2] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <20260811204407.52471-1-ggordon@gitlab.com> (graysongordon-gl's
	message of "Tue, 11 Aug 2026 16:44:07 -0400")
References: <20260811170200.43097-1-ggordon@gitlab.com>
	<20260811204407.52471-1-ggordon@gitlab.com>
Date: Wed, 12 Aug 2026 07:17:24 -0700
Message-ID: <xmqqldabzamj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

graysongordon-gl <graysongordon1@gmail.com> writes:

>  Documentation/config/http.adoc  | 17 +++++++
>  http.c                          | 10 ++++
>  t/t5567-http-verify-status.sh   | 72 +++++++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>  create mode 100755 t/t5567-http-verify-status.sh

Hmph, if we need a brand new script, please make sure the 4-digit
number is not taken, not just in the sources to released versions
but by other topics that are in flight.  

    $ git show origin/seen:t | grep t5567

should be empty, but it is not.  It seems mm/lib-httpd-cgi-safe topic
grabbed it.

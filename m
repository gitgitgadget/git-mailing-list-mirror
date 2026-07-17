Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D44B3F86EB
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306611; cv=none; b=OPDkAdyfWqQQQO+2CjWkCGn4hk6LOayKa5QNBlLqQGyqzGBk+UBh3t092T0vo2l8G5ptY1TmK+wJDDfqnryAJ+Yn27GuueqF5w+rPPz3R5gS71Z2g3V1iVvxh6QqO0X/Zbrgm+RfFrvoY9U6azKzTjKsKHJSu9p+Z0/Dj9H3ST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306611; c=relaxed/simple;
	bh=aMhn5EmSiPK7sI4vEG3HY1x5ea8ven2c0cbXj8j5p0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cMFo23Zcs3NQifPz0PvL/Wl2vartBfnKxY3USdc57aXqY64jfV6vSAS3yp+i+ecIA1+6vVbMgT/2LWplnzrZMw0lMuprcd+bDU0n+p5ejYLyl6GY8NQsui/UuIC+x70BUGAtjR0FIt5X2bzqrE8qjENzhB0fE2cjYwmxEggpqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=URXPgU6+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=keGm7iiz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="URXPgU6+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="keGm7iiz"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1313814000B4;
	Fri, 17 Jul 2026 12:43:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 17 Jul 2026 12:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784306609; x=1784393009; bh=nMYjyi8DNZ
	BjBaws/ueN8mXgmERcXhIjDJDbWqOWbiE=; b=URXPgU6+VoeHIheLXe7gWxHNn4
	N8eUc2usVwYmCcPZhU0HEPwv/TvjfCeudytSU22Mww+nPMlIxdTr2EvQ5LhlzmOi
	YGdCdoYWIoE6xvvzToeloiH0aZbIQ2ZpneiJDp6JxpiZP/zuBqqBLookTYK1iKvt
	R2/Amz2Eq9+mvCESx4UC8WIxzr7PfygHJUnrGfFVOFaM9dJFdUNRGxiIx7JDMml8
	HOnW+aXhAgdv4oD6lRkvZH0bznfyiClrhzOL97zq6xboyx3LwKPofSB6zaSM8XtL
	F8rXehz0Vcy/qYlLBWSOo5bbrvbbr1+Rmiso7kExA2P/uQHAOTZsPQT/hwKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784306609; x=1784393009; bh=nMYjyi8DNZBjBaws/ueN8mXgmERcXhIjDJD
	bWqOWbiE=; b=keGm7iizYerD061G2JPWN/tn0O6E1fS8FiRbjwKeWl1/AaCT3oQ
	NSYhG/68oQqWqiLS/R4CPjUKmTXKfi4M6m3hePSR2Ou+W+OOEltk5KpltgfakAGZ
	/XUh2XJAl85buhFFRF33M6c/APMhZhG2SAdY0M1aKprZP3m5sBuAewR0/8eqaaWP
	pqJrheHD97UkyeWYlEzAnzwxNQ+5WF7JhwAYAbSLDjaWIF/AnXY6MQpRSeOWPSO+
	RR3GpvZ1t4HHqxHDVhwhkSS+8uCO10s/rwU9LIyGEj5f588XoLZB0z+gpK34Ossd
	xPdoccOFNX/Osxw4RzWNeG5JJRbRGa7uTLw==
X-ME-Sender: <xms:sFtaajwkVY_IdK7V3BwYRfIS9-foHm1GKzK4XH60Tlc8o_45HotQsA>
    <xme:sFtaaiQWTVg2aZbQ2ylq3IuYop72cUdkzYFv8hIThBUPt4TLG-y0ezRcgaQoSa2dg
    5kfi4faYWt2ORUJ6dBijRqFnGBwzm82TzZfDEDPCOl4BO7bRWIOKTE>
X-ME-Received: <xmr:sFtaaiXT0OkFZaq2N0HsEs34wkTMOa0hCYvH3mEswwn1zE7xO2qPmCQc2g4yasQUReqI4Ck-NtZVm6ucSOGkJcZIdCio3MMVTtCElvk>
X-ME-Proxy-Cause: dmFkZTEv7cheHZGB98yPCu0ERqHae9+6HwXDPOzS2+hW4G8H5FBQehRArihcf43I7ZyvOr
    vtUeZJUXgSf/8t0ekDWpVlJ28qc1DOVlKE/mhFJ7FKWbHJ2+Up4vtBwRisnexxaNZltEAS
    n4/rZgiELioS31HOrMKV19POy6lpkFdsD0R5xCh9mpFAFQd8eRzU8bqjhd7a7N/qilVoGM
    oQVPeo9+IFTwSy3pgjpmT2fiYG7jI4qP68qRjT3m7eGm4pviUyhqpzZZufmmg5mV4CjCOT
    P1eMBpI4l2DslPvaz+dp+ynZVy/4akD9ITU9Ax2zvcRzxIWn6yKdiHntufzd7xDNw3gyjy
    iP6YMa6urp1JbNd1NTM76QMpE6osee12wYf1ejhti9Jsp4rerZJArMUtw5RdXzr8vXQFMJ
    3TrE/6j3rAikAEAJdaTOR1SlmQbhSB+aDCBUbsswxxb10VZjHYSYsUVG9J5S/1AWKa6nXo
    1WjRvL1tc9ME9ia9BvDSFXlYjpzkJN5nm5Hg41kNmqFGPEzUoxZcDkqE9LpvG+uigCGdQL
    pWcwwzTs/igRGYZYjitGZsUbvCcvtEdjLNIXgOPH6yTvZ5y2Lop8XoydNAcJ9Cuw9Gz7G0
    htxXMkwBLtbKT0AZwn4SpZa0LTG3nhj/n2Xqd49AEjkj5JcpsUviaRgwvYFQ
X-ME-Proxy: <xmx:sFtaasYy2cArpuqEW0LUhhWEm8Qx9e22EKZq2G_Fl9fTZBmXD3t9YA>
    <xmx:sFtaag244W9aCcBC4AF7hr72IBAdSO1qDGjrNKmf-0hL1JRg5X-FvA>
    <xmx:sFtaamhZCa_iyubl9BROBHAnllh4pKqb4mCQdBejcrqA6wHhYJM9pw>
    <xmx:sFtaasaUGRFpUXSHxwTNr6g4QW_0zG2DAYSwLQ9LcPiN6dnXT_hmkQ>
    <xmx:sVtaahBUE5G-kkYHkC5kzbWKPN4hzCyl2meIqMJAEhyGal4g1SnX5cZ6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 12:43:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 3/3] bisect: add --auto-reset to leave when done
In-Reply-To: <CAHwyqnWOnDoMpMP7gwrQWRmaJqBrSDpdLN0Dp7U6vPU0GKSmEg@mail.gmail.com>
	(Harald Nordgren's message of "Fri, 17 Jul 2026 11:16:17 +0200")
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
	<a9194b1d00b260a7a7852eccec54c872618b5fdf.1784180159.git.gitgitgadget@gmail.com>
	<xmqqse5ihmsz.fsf@gitster.g>
	<CAHwyqnUFfewFm7tr-Busv1rKP=4Rqnq+vJ7mEdgbaRLKbpbo=g@mail.gmail.com>
	<xmqqpl0m9pnq.fsf@gitster.g>
	<CAHwyqnWOnDoMpMP7gwrQWRmaJqBrSDpdLN0Dp7U6vPU0GKSmEg@mail.gmail.com>
Date: Fri, 17 Jul 2026 09:43:27 -0700
Message-ID: <xmqqtspx4le8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> That's a great idea!

May not be, though.  Depending on what the bisect session finds,
where I want to reset to may probably be different.  But that merely
means that in such a case, I cannot use "bisect start --autoreset".


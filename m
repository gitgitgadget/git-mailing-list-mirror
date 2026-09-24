Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB283BCD2B
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267691; cv=none; b=oVQ0SeImyaG0uurvsYo1nAe1SovIGHWZyEusI7V3AXfSQRj4/7YBI62h+k3rLbyw1bFVU+XazFDveOybA8OPgnt8X4lG5AKvQDL2IY476gnhjsToJNM636YTqet5BQm9KAck+DDWdosz0W7VQ3EMtTzEDE0irMqhpmlw98E0w0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267691; c=relaxed/simple;
	bh=eQ2GIYBUkjFpJSZUX9tQDhAGuIUFPR9gn0OuVolfgh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jkednFWLyl0f8LyDoDiI3ylOLZE8H8EEzijuUY5gptRWkcSZwnquwDVpTHqYM4wxYKPNR96KxfGTnPgd4Pl/+iv4+SIeZeZepZpN8k8Iqbd905/TQWUh1j3J5aOj+DU59eR5gCuLbySBG+PS7n5PutyEUunM2rTyAsqi4zwAhwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rGKk21yp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MkoJ6I1H; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rGKk21yp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MkoJ6I1H"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1904714000ED;
	Thu, 24 Sep 2026 12:34:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 24 Sep 2026 12:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790267689; x=1790354089; bh=uZgiZ2ECfK
	n6qVFzuBIbkOSR4KKL4zRFThN8jKaNN4Q=; b=rGKk21yppKJohqSn72k50akNMN
	K4m+ro9O/9+CFN8GGtT0MfxNGgXIGTFjPLJWfh/q3cvpFNHrXrrkTqZsc7GdaFy+
	YSyRtgmDsGui20H0f4foE/maBbw+YERfGRAQQkAjWB//LJL3wJE8gpgctPzylJEM
	944xTVekzxX5U7BLHJzIF8/wDQm07gv0J3Thbq3poM3UXt3g/y2BJ78RwOhN3t8y
	GTpdU8zzuuKIDyTQXde2RpV69antefUsb1eZFHIrPHFZ+wxoJLhlHg6OBFsQJr4z
	HaZdPGwqy1NjrcZVRjHxtFyWT+Y1088X40bin6m7yGghBD+Fnm+qfifN3l1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790267689; x=1790354089; bh=uZgiZ2ECfKn6qVFzuBIbkOSR4KKL4zRFThN
	8jKaNN4Q=; b=MkoJ6I1H2u5FscuIiTVpwnIJzZsxbCyRqgvM93d6lWimpDDGL0a
	xdKFTxw6ELxTTiaQlHtV2xYp7xKUUMmZM/zDWRFnq5xzaEuSBhywx+pn+KB1TMJ0
	03hoEN9b14q66WaCcWJBeFLcuhP/7C3vd7NheCCa91WFpPX4NTxzDcjR8rMn5WF9
	aZUz06C+vgMGAkhb9/ZsmzVOJiqLxgMgjunCaT45Avpk21Bj0UeV7tNTt5ihvwPF
	a2244NEUTXNEBig8zeq7Cs5jL0ScdDVWNItWGQn3lIXe+oLI2rJ28m3tUjB39FTQ
	om8ZSovsT9MD2OmDZ6yd/kgqomZV+ZiuSOQ==
X-ME-Sender: <xms:KFG1aiWIIVJQKMLHY_0fTsasKvVbZMhYbTAmSZPwi3Up9SOQ8Q2lTQ>
    <xme:KFG1ahIWaOPwzrrZSDh4HSzXbEoCF5GsnaN7bXGBf8ackd7Jtw6iF_zEnjNBloxGw
    OSOzIlyYtnXOkqqsrqq9IeUZenNLb77rzRJ8KQh26Md2LZVPqd17tM>
X-ME-Received: <xmr:KFG1aqBm29KOh_Rsqj03r6E5hTZeti5ATfE2vbsmSbDOPpYSDFliS-xIJIUkPVE2rq1ejF6n4yP5M1PDsd0ZUuIjO3W1FQ2xS2Oc>
X-ME-Proxy-Cause: dmFkZTEWLe9KswLgv0uv/ve+QUnpoDl8t98R5i1fZ6l9vC0H3KBvWNiD1Ab02XjedYJHkO
    oieEh4ZVHWA6aX4l33Gvd5oiOQx2M0/b/06YzYOL1WEnk2mzfE8LdjZZ6W1hSgAOZ1S57T
    xUZdoqh2r5/QBWGWIrk/vDBmr+3dIWpzip1rlSZHXKy7VNPi3O8zxJRBOQw8UAedT571Ly
    SXH/1YR+T5PARLr+yD9sG3aWz5NgHAuOsn85zBBhKE+EXun9GPYMVddgKA6GE3F3Y8dii2
    RV/UAssEr+AKbF7JiJybMm8gC/qZ+M3x+Js9yEQR0Xd9O3eisvu+A73L3afy6emNQZXpSL
    MUNaN0tjJs8gWX6Sryw+3aXgfyHSLGOQNL/8rh75J69aLbwUrh0XJrnitxQBGwF8PO4mLk
    bK9zDKVPj8op+h7n+oTf4VqEXSbsNPcyEiuEoFHCcok50F4fF7WD+Uq91bacByVBoCMMxZ
    PxWna0zl/ojeLdnHmOnzK32H2kHbofABoAsFew6kOlTMDqFUGcA9R66gyq7gCvoQsyHUSV
    HwKWael/jtjgxa8ZUoxMwsWjl83kDto8zfPS0AQF4NYpOqTIvmHPZtceaJwhRzFBi9APfq
    3yRtlc8ftwIA5alIyqfYmSbwYytbFAC4HwpIkc6IvLXy1nb/8R8v4klBUUdQ
X-ME-Proxy: <xmx:KFG1apcnq04-H-cnOwz_rB4GqDIJIwrTt7pm_06GMSFAJtRSBxkPVg>
    <xmx:KFG1ah21JTdbmUHeBJotR_OcXM25j80V9z7NHQl75rSEQp-AjaDrew>
    <xmx:KFG1aojhI4rDfOEBXK-ENXvy1Da-MVPHwggmp-TeiHH_03Ne0ZDGTw>
    <xmx:KFG1aikzTrCGtDomvr5_RDgiQxe-SdfSfmErqpz37XRm1mR5VFtoiA>
    <xmx:KVG1apSfDa2CbGwkXvZ8WUdExvPHcGITL7jgrVD0QYc7YjAx9Wvg6uEw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 12:34:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phil Hord
 <phil.hord@gmail.com>,  Elijah Newren <newren@gmail.com>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  "D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v5 1/3] refs: allow callers to supply old OIDs for batch
 deletion
In-Reply-To: <CAOLa=ZTWq6eiqCwUyUhCffTn1=f9pdAip7nsYJMnaPPUuccB8g@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 24 Sep 2026 03:04:59 -0700")
References: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
	<cover.1790196627.git.maciej.ciemborowicz@gmail.com>
	<9b76cc2c40a2b1fe727677a9400e3b26ec1ab437.1790196627.git.maciej.ciemborowicz@gmail.com>
	<CAOLa=ZTWq6eiqCwUyUhCffTn1=f9pdAip7nsYJMnaPPUuccB8g@mail.gmail.com>
Date: Thu, 24 Sep 2026 09:34:47 -0700
Message-ID: <xmqq8q4q4nh4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> I'm also still of the opinion that this shouldn't be done. A zeroed out
> null_oid is usually a user bug, where they haven't initialized a `struct
> object_id` correctly or ignored the return code while reading a ref.

... unless they are using an element in an object_array and want to
selectively have object names to some but not all of the elements in
the array.  In such a use case, a pointer to a null_oid is just as
good a representation as a NULL pointer of "N/A" for a parameter to
a function like this one that takes an optional object name.  You
could force each such callers to notice the entry they are about to
call this function with has a null_oid and pass a NULL instead, but
why force the caller to do so when the callee is capable of doing so
centrally?


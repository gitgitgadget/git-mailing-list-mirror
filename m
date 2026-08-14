Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B83D5643
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740178; cv=none; b=JTtTfLj5sTGm5KPp72+HuZ7WiJZuDAXLtJqFldEiQmDOpqeEy0Lm6B3iR8/+/x9/h8xCikqkHaGK45ETCDlU9lEfILeBK1QqxGKHAgLrGZMfePRNDDJHgHB1IenhLip1s+1+73xL6pY+56wIgeGw/OTEg1hTd8zetz7ZwOhGzpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740178; c=relaxed/simple;
	bh=QztX1+2kET/tE+I/mPMxY77upvepnv3bAOh+e0lsVNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OPFUlu3EzSxhcoPawp9+20X3BMXkJK2MzhCjVe5G/ScdMLK/7rckTGU13WF4MG8VLAsCvyrokpA0OC9owDWmtTgLS9gjs2NjnBqUNBjis4tM2yAeQx2dmTPYamY+EMoCsUkJjuBF5yxZf+LbD6wltXQAxAf/52Jd8+5I6v8ilvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G7nhHeM8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hsOGz13s; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G7nhHeM8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hsOGz13s"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DE58EEC014C;
	Fri, 14 Aug 2026 16:42:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 14 Aug 2026 16:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786740175; x=1786826575; bh=DA67CCyBYU
	otxC7IilbzyHYsG5sRVlDyq1+SdBfU1pY=; b=G7nhHeM86cxme/Dzp6xMkmpQ3T
	XzcO6bjRWthI0obKg6ROrB28atGGYkbCqI6Xj+mKA4mtE+n/uL9ZPsOFVuCQUOsc
	enJ6aDadDMY2zHJJ3Bvx2KKDsJ0uW5hax72EOW/I9/RlTfMtFz/aufHmSGLIKnP6
	siwsED3haTTH9lsIlbrFsKdU37qY2xzKS1ZZFUh4F/2PCgMLv6KlrTX3GNMsnfpK
	JrcYfg8eFW+QguvGNmr7bUM0c9nFvqzDpo5N7xv/IOPlpnBnLudIw4yKg/0bDtlc
	prwU07vNhYc1kMwhaP1Em8BvyLsHF7PDMS8f68u+tM3VRpf32xu6x3WiGzVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786740175; x=1786826575; bh=DA67CCyBYUotxC7IilbzyHYsG5sRVlDyq1+
	SdBfU1pY=; b=hsOGz13sGpaZLp7ph6t/K4Ms19MoBsegHpAxGvXFb6GxT6wvhJA
	WvdrvOnGbTuFnfEsfkCoqgtnDTz5rolq6hR+GntMF03MzKN81+pvMGaEA0L76Tzs
	eV93DNZC3tFr/mxoTswmV+l0SuamLwdXZ3+XS/Wd6FNj+WhmErR7C+ZPS1PexCzX
	w7BVTe+VnIoh3dWG8EbEuqOP+an/s7+2QaAgIJqryoQkj0gulgtMTYgqFITSr/Bf
	cRgl5UWffyn8jGCaVWvNfKyqvnr7MXFCAnnd+JvnnW/V0LJJBj9Z2R9udLEG6wTG
	3NjDQ3zZgz85z+1a5OMkFBn81kI1t8JV+iA==
X-ME-Sender: <xms:z31_aqCajjDofZb_AvBHyH54MQ4nbWkPMmLyulla0kuGU4KypyoUSg>
    <xme:z31_arZ8UDLKF11z_xGDULEOfa3anA-IIfyi25K2xQsl0qqb5y2JwB44cZW_g8cYc
    FNVsh29nMBT4-j2wuNZ6QSZ32eIkoIMtXcXBuKPOU4PWzWKUKpp>
X-ME-Received: <xmr:z31_al4wKytCSUvcTF6LFJrEAzkU3T1VL3qzXspb9YrXzEQUejGD3hIA2dpTCzcBit4wx-dK8zj25K8jNNV-sN2RzmPrb8O2xQ>
X-ME-Proxy-Cause: dmFkZTF7zBlBVqZTct9ycdaRpNc1586O2NSk2pgTEBFBoZSe055l8oPg/xXBzTfVdjX1mW
    Zmg/AbJB/XfzlaLupRC6Gscltajw+qh1Cz7l4j/FHG/xw69t07B/Yhf4dcLM4hJIrp52am
    2FKXFz++hpyq4AxuWp1xOhJ8nhpowqx4a1IYCKz9UqKbC1cTQCmHSkYvfN/xUKh6qe5+Lc
    +lqiZQFMa9F9Q0V1tuCutBmADscBUiWlGiNSYK4KgQrJEZYsWk4lNMmELN+1y7JoKMrnit
    VyDUsk+EMgq8TwDYhGffORgOHwbvOJf4ecIBDt1h+MF6trmXkM86t4SiH31TVaHnQWTffl
    ySxhboOUl9LxTjQLiJMFY8ku/g+Q0y45kmlI4cV4MnBH7ZztN7fPucC+r393pmQ9FOjj22
    OdW7aP9IrYzktt38IN0YeIlDadGhlZ5XdT0belr2o3cdLX57sEC4YGVAqi5kjEMnR5e8zo
    vUTrz1CnnQLVaeaNJij1ygCEqTheQbh1bo6R/hNl/5vtuU1/GwGLB+hAE3NMUKImakTrhO
    uJlm4MQc24qe/LfQF7m7Oef91A4SdF8h+qq4QsiFoVURaFAa4K9bCb4Rhxw4HzdCK6tDsQ
    DLbsMlZ7QsgHbVyB4vEqRA37Qrg7IybCEcyxXc1ubhjoK9yXkNDH86X9EtBQ
X-ME-Proxy: <xmx:z31_akY2Ic86XUtxGEr2SP_FGpJtt8j8ARt-n01l422sytEn9g0ICA>
    <xmx:z31_asi8hPniRk41ZIMCfTGQdw_d9KNpfKfAfmbKUmceV9SuPgQt5Q>
    <xmx:z31_at9qfPuY04u0MweCdXwDBLMm5V3x1FYIStTkUpdoRMFYHYmWuw>
    <xmx:z31_avoiyxm2n53bTG8CmnDS1lH3V2kfYPka20jIJXUVRmxnrVT4Xw>
    <xmx:z31_ao72TMJ154EaAAXdZKLWieSABkO59KZtUd_dbpduJIBuDXbdDc5M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 16:42:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Colin Hinton <colinlewishinton@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] chdir-notify.h: Removed unused param 'name'
In-Reply-To: <20260814203100.GB2575854@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 14 Aug 2026 16:31:00 -0400")
References: <20260814193849.1538-1-colinlewishinton@gmail.com>
	<20260814203100.GB2575854@coredump.intra.peff.net>
Date: Fri, 14 Aug 2026 13:42:54 -0700
Message-ID: <xmqqwltsl9gx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think this makes sense. It is often helpful in cleanup patches to
> summarize the history in the commit message. And then we can be sure
> that the unused field is OK to be removed, and it is not simply a bug
> that nobody is passing in the value.

Thanks for mentioning this.  I also was curious when we lost the
users of "name", as it is hard to believe that we introduced name
that nobody uses from day one.

> I think ultimately the reason is that the only user of the "name" field
> was chdir_notify_reparent(), when it produced trace output. That went
> away in 5bf546755c (chdir-notify: drop unused `chdir_notify_reparent()`,
> 2026-06-25).

OK.  That is fairly recent.  The reason why we used to need reparent
but we no longer do is because...?

    ... goes and looks ...

Ah, because the files backend of the refs subsystem started solving
the issue it used to solve with _reparent() differently in the same
series, losing the last caller of the _reparent() API.

Makes sense.

> So those other patches were preparing for that world, though I think the
> ordering is somewhat confusing (and I won't be surprised if there was
> some intermediate state where turning on tracing might have caused a
> segfault).
>
> So AFAICT the patch itself is good, but it might be nice to give some
> explanation in the commit message.

Yes, that would be very helpful.

Thanks.

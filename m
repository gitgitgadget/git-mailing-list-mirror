Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571184766A3
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763621; cv=none; b=ll9q2i0qyKzD6Yn/r4zVA4QXlAMORwH2cdnV/pEy3XTITf9jmM3n8HpdHi4UWQu++ZhNMIaDbWHYrMWpHSkE78ES4gKgsdqZU3zDf8j6/EKLj9oon+D3uPFpW28qwSru96LtTzL3hmUO7ypOSBvScBsdWNJXuZFs5f4DZ2ZNTO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763621; c=relaxed/simple;
	bh=oNbe0bKG7wbY17L/0wwPq7Cy1sS5cydVrVBXlgsWFQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cc6TK5zGSeukLTM7AhUvTyDo397HFydmCndNiSEqaC5BQlJeM0wpuhlQfvOJB1qVFpU72npPsrtT7My8iwqBycRuajPwugRcVkNVB9Bgv5+nbyn4w2uONRgSj9kQltljknnFUvPa3GZ11ZeOroB6tRIriFvzQwK+K0LdbS/DQmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FeDppMca; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P9tVKbpd; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FeDppMca";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P9tVKbpd"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id B293A1D00121;
	Wed, 26 Aug 2026 13:00:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 26 Aug 2026 13:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787763611; x=1787850011; bh=OOrvHaiZmi
	0sES5NmL4NQfhNODO4avVQlw2qDuzYa+g=; b=FeDppMcaOuUIIkXze9ERoJ5epi
	fJo6z3ztQUauZ3Dqdf7az3KL/lBSqWDVf8bGUNid/lCt+AgiBBI5q87ulJ4i/1Am
	Cc1c0Z77Dz4rx7VhAiL2lRdaMRIrtjrg+ppx4DeYsR8pM/cFV9wI+azAO31o5BPq
	jjGNBayqWqBJ0RRLquCk/BEDD843pohxoJaJts5U15oKpwonvbYhMUf3+lS/BW9+
	7FCMh578AXcIVg7uSmOwaAETWCuEmeuDDKv+dobPEVLE0Lgsp9TRvLbsxWqRZf/9
	osRfwdT/iOQ890PSswXP8vY94+/jdwK3lQ7HQ0DLvfmskrSofe9yBO++lTpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787763611; x=1787850011; bh=OOrvHaiZmi0sES5NmL4NQfhNODO4avVQlw2
	qDuzYa+g=; b=P9tVKbpdwlqMH/KJGMOB/S972NNqZ8xkBwCaxQF6yZfGozMCBTp
	BRZtmXHdmPYJPUqXhAChQqYxeYOTC7+QEaaAS+YftaXoqDMruLy0bnKCIGcBQLqY
	5rBUoGSIv5NAe07bSaXgMTADkemoSpzStrqtH30Nb97uljJ+CbxIsxCkfxls27VP
	/r5eM+Ed7MU3YmEiyTrFhOUBz5Iryy5i5LtjAqUBSR9byZJXweu47k8sFzdB+Ge9
	IgMnba9eqIVhoF9U2+GqgWpNfnjt/3UQZKdQ9nolyJHLUNE7mD6sVP2z7BV9Vtu+
	75v2CAL4K2eKy/2yZsB0vxHuYW09GDSmuKQ==
X-ME-Sender: <xms:mxuPaqAR8eL8hIHCjdCJUBarIJLDQy1gWykz1yEjl_4JnqfcJ81bGA>
    <xme:mxuPar84zOezaokUCKaFY9Keq1KC5CWnDOELCQWqOZTdCWF6gyYug3W8U8RDYN3nn
    hdK29y_gOQLamMbPT1OJ_0JCc3rcjOieYDMcNaubKvKn7KrkNRG>
X-ME-Received: <xmr:mxuPaq_LgVOPSPC3TTJfw-fazPlS2s6bmNLfFL2d5hrpJJS1XOnI9_lo26wk4GEsMzQOa5MQGhD_UaqPPLPgMjG17dp1jwc5eQ>
X-ME-Proxy-Cause: dmFkZTGdz7tba33edHTQMArVVK7iX/ujGMkyP+mWLfmOlcqofpypCodymkE1L8+Tm9M2UT
    jV4PIdWUMbEACwWtZOK5Z9pVEEQjBUGZCkUMUGS0t0y+0zlYVI7jVfxoSXsf9q5bLXWop2
    LBODpAtDXeIdD/KVtrxMkTpeRbaKSIBvGA+C0mOUnQm3/ZxdIALDrP4ba8j5HJdyycNYnc
    iZmciGRJmw5y5sY1+xSWIISZlEhyxFVBla/U8+AG96uWK6lGqBel9zeW2YBYQPf+ncCsOg
    Xb5bY58cvTVByCq9YHlxpPGq61ppyiybwWXijzQ85w788xX+S7qyp+Ksuuh79pwKMxMUrz
    UNmnseb6FIKhv9ADdQMqV8L5DUoPsX/H+lbRJkv1do6JKRzRCGBuXAJpnFRGOFmsrNvq1B
    gmZ6o5/0oDnz7QYkPaCLf49z5sxo51Mxw1rMf73+RoUzIqGDozj2QO7LIGZRo2wPuJjl9X
    X+tfoi+kz38I8zHVe+71cuBKrcjGE+DPCPU+4XK16vOXp8Dxp+x7XYUBtsVRo4gI6CKxlv
    5L4JS/PXv8QjiOAqDXhxECon1rBEyjOHiljfk2+UixKZHvDidh5Ql7I3kifWgsyxIxhpaa
    go0z7DoOihDVEgW1q9mGbOqgd4vXifPbMKjMnpbMGFPy54sChEbk0Qr43cvg
X-ME-Proxy: <xmx:mxuPaid3YZvN5Upw8D7mzUysNrFfRN_kzwpDoCwCuJ32xK4GHamq6Q>
    <xmx:mxuPajFB4s322lsKPIOKUlWNTIUvW_7zcbSY0q1A9N4a5wHRyuCv3g>
    <xmx:mxuPagdJpZE1i37VJg42u_HobkkQf_Y4rtJ24XX2eYJ2681yLub_zA>
    <xmx:mxuPatFrQ1W27hzBae80AGtMFJUHj6yW-HXIb4MnZMlCZTPMPSXM_A>
    <xmx:mxuPar-nERA_4IglxFifZIdUXop5M1MeydbbXqAyjALeSoJBWxXGvDZ_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 13:00:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] you_still_use_that(): reword the instructions
In-Reply-To: <CAC2QwmJ_fjNw9z+8an9Doq6Mx_29R5mcGXT1=NnVvu-g71QByA@mail.gmail.com>
	(Michael Montalbo's message of "Wed, 26 Aug 2026 09:04:31 -0700")
References: <xmqqo6epj6is.fsf@gitster.g>
	<CAC2QwmJ_fjNw9z+8an9Doq6Mx_29R5mcGXT1=NnVvu-g71QByA@mail.gmail.com>
Date: Wed, 26 Aug 2026 10:00:08 -0700
Message-ID: <xmqqik4wizqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Montalbo <mmontalbo@gmail.com> writes:

> I think this change makes sense.
>
>> +                 "- Send an email to <git@vger.kernel.org> asking for help, only if\n"
>> +                 "  suggestions by others do not work for you.\n"
>
> Maybe a slight reword to reinforce the idea that the command is not coming
> back:
>
>   "Send an email... asking for help, only if suggested replacements
>     for the [now?] deprecated command do not work for you."
>
> Other than that suggestion, I think the change looks good.

Not repeating 'replacement' there was deliberate for two reasons.
First, the preceding instruction mentions others suggesting
replacements, presenting an obvious opportunity to keep the wording
concise.  Second, this message is meant to be generic.  For a case
like 'whatschanged', the "new workflow" is to use another command
(i.e., 'replacement'), but other cases may involve doing things
differently and are not limited to a simple replacement with another
command.  

And that is why the message only says "suggestions by others".

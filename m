Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24251C84CB
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791855001; cv=none; b=k0MI3elkdvnbs1jWZWmD8txIYKGUbX5Tn36SkR/RWt9yRYnl50IujlUEaIae/F5poJPVJ0QjQsRwpyY84Zv/kNmfu7W1YX7vzCiiZitYuLP2hAuoJ+gdQ/+GM0k+DJSas9k/YN6TE3lAgA5exaTO5HuTyyUF90W8/Wdl8ryD+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791855001; c=relaxed/simple;
	bh=msobiWbYbfQ22po03jS7UNya1y0WRT4bESUXKBf3Qww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=enJwLT3rUn/a3+SkGk7H0m+xA0+bANuVFLVwCamcDxrEIAHFz2dwC9N1aM3BWKXqepuxQGgy8h06CxEWILmo25xgycLhnz0qHnFKyDknKiWmUt5MdBwdmc1EP1xZcrL7CmYAIY0+h+iIltRplRl5Ssk4FzeSD6t6pyuPmA0TUZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jJ6/s/c9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P7VQKRED; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jJ6/s/c9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P7VQKRED"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C1B81D000D5
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 21:29:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 12 Oct 2026 21:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791854998;
	 x=1791941398; bh=U3Od6qAgJz6HZRw3Z5caLrwEpsns5CHo4van5dTm8iM=; b=
	jJ6/s/c9NXl+wa25LM5BKJbAMnZEkCXOLT+KR8Y+GYnPno7Uu7HKxoISYVQDyGFL
	EHGpMH1kCQQS2h+60WayspQHeuJ/mucjUI08mrINCB3c0XUZURzlGnD3TZuGJ8UV
	YBwrQKzsEaP4S4bYc/yFwxBudlvPmn0QiFdey4ycB2KncAj8om6PRK5ofVEG+gtV
	sb4JPoF95+0BhCGTDmF6e11STN9dPhjbhCF/9zhzQV20FGsCMvODYUmRhOOpuqAK
	S50PANgbj/U+GZL3n1AhPVkAEiAlyQo5kN/pu65cSkOs4HQXXqHp7QlepdaWKS2X
	cbMgla8T+sYbZSdMoDJLVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791854998; x=
	1791941398; bh=U3Od6qAgJz6HZRw3Z5caLrwEpsns5CHo4van5dTm8iM=; b=P
	7VQKREDoh5Iu1u1Js+DB7NPOSwAjNhD28owbERVuHuQVIvP7orqTd0Z/xuG/pcZD
	rhxKNKzuMp5IRTA0jQKibrECen+GI7h+zehtsPh+Y7lqEDSzSlk9q2Y1I28M9xz8
	VKJoomgBGgz2Iq5A9HdQTlrDhH7zNshnDZfTz5bNeZl49xGa4u6ZQ2ysfcWTrka7
	Aj30LswkQ92SO/JHQPIwRQuMSX1YAwpJeIfhKioFMXi5MgE3V7aQVmi4s9k70myA
	Ue60s8Sf0FrON9BnSif5GxpJLuXbBP/VVup70gg0BoFOMeM7NGWH7f/C9V+yp0zB
	rv4clNnh7btYKrnXJpVbA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791854998; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:iMWL5ERMJxpm+kb7+8LpOpfpSGsk+/lONIHI7AyJhBhrE2s
	1x2mbqsZpVi5mq7ZkpHvzjuBLr3ZFwuh9gz1YvSut2pXAn95/CBJNOTHBn0zoQQH
	X6JMVy3QNLxaE9snUFq232CKYPclEti77uC5gIYsCHd+s/3MIgxHC5wjrH0m9ZnA
	Ys59xBACnmdrP8IidNB824w4ldjjv601IxQMifxsR1bRGGKW8di+r3IzxJrbG1H1
	foyXfavGs66E3D7He3WM1EqQ+Y/s2djYR438AXt+C4yVKJgiBMo1c/pOPur/n9ij
	erRjbB7nO1Ri5eS/J63vURxHwcHC1J5zo93ZQVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,importance,in-reply-to,message-id,mime-version,references,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:1MOSiBWZJHCmvAunEC14BAO9DUo0TPUQe9vN54xWDYg=:msobiWbYbfQ22po03jS7UNya1y0WRT4bESUXKBf3Qww=;
X-ME-Sender: <xms:lonNapEISZ8i1jVxzkes4q9SF2W89x6arCA32X5d4hPd_aNSzfrnCA>
    <xme:lonNalWspXbPUm3UQ_b51IjnqBeX667XLJoB9aSsj4hD_WtsCS8lqz104Z9iS9lws
    vsJMjC30nu_anrCi9_VH-Rjb2Lvhejnp1lOMhnVDOF5rh2uh0MfGbZn>
X-ME-Received: <xmr:lonNagLMpF_rsDbLJ4FqIDka1M6r4-GPSaWQEMMjOPHKA2VWrPCW8byPGgRIGlk0gPOx9XXzjnWARcWTU4iWuRrsCJPfKngBR4jU>
X-ME-Proxy-Cause: dmFkZTFxWLSSS51FgQL+krRo/v82YeKgPagUjnj7PUE3LZEpRhpsA6Sf4BlmPevgvgrb/+
    8icPWZO5vCHH+D/2noFnrKH9/HHW71H2wpPv5LdAnr570dRlFD7mqcJUvqP+KcnH7M3avR
    P7KcWYq/uq90L3gPqfuij1LWI88hrlR18YoICKTDflo/fz4u76jwXXdcnwofVCAuV8Crqo
    Dow9YSfpOuUOggTNX06Jw510cQ02HoSl4uE6a2rJ25LNS81SlF172wu727R5RcT2A+GfRQ
    lYge3YU4giju557fjuhfLAAYj4lL0yK8vf133R9aoV2bblQMKqxyZtHDV2vSrKPzdqjat3
    8uNuLjVfCP2Wl19vkLEBENf1KdWpy0PApXVNQR4dT5+YjK8VExRzpgQ+yBAH0if/BfR4IK
    CTSHi+QtdX1qqrIyt4WBiFSIi+r+i94GnNHAUaXJKcnv5y0xUUe5a2mzH6GW3u8cnJJ1YU
    N+RVQFJTsaMJjJ05R21OS6uTYp/xavf4vVLp14l/cervIb8yjqb5rV/l16sGrWKru+4Mbq
    SH9aectJGgo/Uduj9bNzf7PvDrnS9XOw5vFQScGCd3cIY61fDUH5Aja1FjoNtErY2HQQJW
    vSRBH71UyE5xBpY9xNg9vE5rnxkAclGykUqR0qdU7eR93EAnl+n7SkwxGw1Q
X-ME-Proxy: <xmx:lonNat-2bG-eDjp1ElVGJZbFGEOVNzwPJY96SPbfDBdxwI9yUI6kjg>
    <xmx:lonNarJsa8J-uhd6wpMO-Ft8epRE5kxYgDq_W_tacdqLifzm3nKu2A>
    <xmx:lonNaqmBEyp1KDjTgOjyHEjc4Jp-jtLYxmiVG7aMsnu2yd7k2JZffg>
    <xmx:lonNanMegw5jBjm8MZ0fOpYjSlGxkSXL9UG-lQj3le7cDyME0Ectbw>
    <xmx:lonNaqLh4K2XWZFNxByMJ1iBvBDmopupI5QT78WclP8UXUyuEvrgbQxX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 21:29:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  curtis.allen.smith@gmail.com
Subject: Re: [PATCH v3/RFC 1/1] read-cache: do not trust a size change when
 conversion is active
In-Reply-To: <xmqqik3668ff.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	12 Oct 2026 12:11:16 -0700")
References: <xmqqwm1no29m.fsf@gitster.g> <20261012175638.3712-1-tboegi@web.de>
	<xmqqik3668ff.fsf@gitster.g>
Importance: high
Date: Mon, 12 Oct 2026 18:29:57 -0700
Message-ID: <xmqqqzhu2xre.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> tboegi@web.de writes:
>
>> From: Torsten Bögershausen <tboegi@web.de>
>> ...
>> Signed-off-by: Curtis Allen Smith <curtis.allen.smith@gmail.com>
>> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
>
> How is the collaboration going here, Have you taken over the series,
> or are you two working together on the topic (or I take that your
> intention to CC Curtis is to work together starting with this
> version)?
>
> I am wondering if we want co-authored-by or similar when we lose the
> RFC status.

If you two are collaborating outside the mailing list, that would be
fine and I would have no reason to complain.  But such collaboration
is invisible to others, of course, so I would like to double-check
that you are not unilaterally taking over the topic.  Can you
confirm that you are working well together, or say something
similar, before we proceed to other technical points?

This is a tangent, but it is the reason why my mailer settings
drop into the trash all incoming Git-related messages that are
addressed only to me without CC'ing the list.  This forces me to
resist the temptation to collude with selected others behind
closed doors.

Thanks.

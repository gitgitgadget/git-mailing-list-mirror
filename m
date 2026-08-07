Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2848441636
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786134406; cv=none; b=UjkXO6J+0fHMDfv1H3gTLfLoAUaWkCN4glu7QuKi1KERy/4/ZNIpFBxsKdx4kxC3wdiF1DItl9RJmxKqJTT/MdoY2Wc5XLUFnCcQfnahnWFFy1oMlBCkpHJZc+4r0hb9zg1EKElLOnQU+vWAGAlaK/WUTpmy1Y184lBWsZ/8qGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786134406; c=relaxed/simple;
	bh=Zujb1WJgzXmjVEmb/ld4eTKC7YOZsUFJ9XD9qWym934=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dYVOKa4//kBdfDYzpQTkZUpU2NT57jJQkP93xCmkLE+x8cfhyeiTxI6NzQePjwvkr6cqe0v4l0sxHVFyy5OLS9koOHfXpm+xqTQ+XkxSUuBrHWbOOOwAxBDnRV3b6GLpirfwwR6chzI32Lw4XuOlXbSuiYfsrLOCnnhVxtdQvBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jKqLr7J2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A7+e9jWP; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jKqLr7J2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A7+e9jWP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C65C1D0001C;
	Fri,  7 Aug 2026 16:26:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 07 Aug 2026 16:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786134402; x=1786220802; bh=Zujb1WJgzX
	mjVEmb/ld4eTKC7YOZsUFJ9XD9qWym934=; b=jKqLr7J2ysXFs/kJ3eFxRwK63i
	dY25gVgpAOMsBffD8SkKcoQbwdObNMIbD+80s60gqBoHDMKzGt6ryrzgn9lkyjsB
	+SfbprI0HeHimaUVktf4JXLeXryb/sWDgy7nBJBdc61oaEgh4ZvDX4U+LD78Y2mb
	tukUPlDd+5hid+UUeFZXmKyy8OVBnXjqD1TN0XuAeqUXg3zChbBkPNH8u5l2S5l8
	g+KUYSHccbfPY2lrLtRAT7NpluA04HVvmEqOO5mS2wzl6Flnx4gbTngyKdHaU/Y2
	YYsOkezqkU6NzOpK6rSLjpKDnXAJgt600DHTBqa/ttszDdRjagZMAZ8wPhsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786134402; x=1786220802; bh=Zujb1WJgzXmjVEmb/ld4eTKC7YOZsUFJ9XD
	9qWym934=; b=A7+e9jWP1LRkCyCvgTMZ8/D1f3CMJTKvvMFMFPTIS2zLmO9Om7W
	jpDJLmsstAetD0MCtPnXCZzPitOh+4YazIB1g1bu+eU+0ow9k6giDISGFpSPyHDU
	5Q2QQhlTmc4euY1HDR7yieFmjH2arJ6IA7WBQDLZP5kUGUTN2Z5TFNyt69h/QDe+
	vhD2W/UVoXsZfBwY6v5KPxb9YlGQz0i+6rUDA6yABbuloUWJbNyQUxn1wkHkbId3
	zQRpmL0SpHi4wjkWoGuInOBE3/+iwcvW1mkJXIhV9vy4zaVIq4w+wVodqmNgwDPZ
	Oh8N2p4tuuVwpkbPKxLeBXvAXsadEVHNPZQ==
X-ME-Sender: <xms:gj92ajqI2oaj3imYa4PyoUvroO_GGuKoXyfxDHt5pps5weBSkhWsTA>
    <xme:gj92ahVeWZoOFu93AUhnTAYIy3JFk9WOUJYBETGLktGdbiait3kzGpmKciqNAwTRT
    keQK_6KTy5EaI9Oce4nZJL2Vqc4Aa24spwF5WN08WExRGtzg6-d>
X-ME-Received: <xmr:gj92aqBHszzsJuRt9b9rVE4XbFL6S8zuQe8PNwwJ-tWtI8fq-yuB7_RQPmFNik59-UbO9lxFR0KDcDYoOO7okmEjIwC6vrbNXg>
X-ME-Proxy-Cause: dmFkZTGjr8iaNItkmtNihhbvAiTrVA1tI/+mVn6kqzkCDr+YU5a4vfo73LEehKZT4wIYv6
    ET5c6lmPne4o369TktHAomED7B3atO1PuTbDOP8QtFlQFUMNPiTPrVmLQSZ/WEl5MvKVSW
    13VZXLeP0gyiP7GLl16Os8HUMugaKC9TdX4dftZR7JJ8bz/hkc8W1Hkbog+BlpligciViZ
    QoyUOsJn3fsCIehJxklhTgMF2nCozR4SH5MvXYQmA6cyZr8635D7SB5WC2kACLn2iB0dEp
    o62IB79Znemj+sinwaq0WtmF3ea60pVgOKdWAT+g38icFOfwTbixLLl6aOUSch5RIeVkB8
    8MG11vyuXhj+Z4XKRrQRMGoX/4ndIPq/QEAuhyeyI1Hn07/ACL4NFyJsUc9VD0vydQLp9a
    wMzGTb/8yjpd9dDvbfr5GdAowMPc5i7hPRubXkrRMyJPS+dt1xafd4ZyRk7wf5lbcZBfn8
    Fq7bG8xS0JnkLxipSOD9GK6XhtVVBNjsenuumGZkV/yNoX2xrIxNZSqOPB2i7cVJ3sz1PZ
    2xd78rAuFNC0MtQVU/M5yY74xAyNSJjSO2x19oILQTzmVuYold+s+FkALGZmKhZTHpIuIk
    Y870CqX+TwOVfihIIl1CfKiFLH9JtQfcngsUVOWix8gUCwm6q3fWeKCL55+w
X-ME-Proxy: <xmx:gj92at2uHJbE9ch3HSyTnM1uUMbK62hFgKed97yB6FxY4uFHV5Lspw>
    <xmx:gj92ak3Rgu9L-RlHCUub2Hirgzlnka519O0jX-vng2iDDqZxj1hLxQ>
    <xmx:gj92aqBq6spWMHOcgYDCCt85LQ7-P1YZIMLYwN8oV3EMkxLFaNZ6fg>
    <xmx:gj92ar6cIxsEtDFc-js80NaPoA7QV16v_00TQp7tbjOH0rFpJIxA3g>
    <xmx:gj92arM3Ffq33YNKmEywVGfeUy4C3bUX6gDn-PPivVRKcBiMIbtZxK8c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 16:26:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <christian.couder@gmail.com>,  "schacon@gmail.com" <schacon@gmail.com>
Subject: Re: Can we do better than "git checkout/add -p"
In-Reply-To: <CALnO6CAEbiwRyJD+Uk_Aq0gKy-XB1=9PmOUwW6itOMCr+mBmwg@mail.gmail.com>
	(D. Ben Knoble's message of "Fri, 7 Aug 2026 16:12:21 -0400")
References: <xmqq8q6ih924.fsf@gitster.g>
	<CALnO6CBu8ZBDk9YwLW2jVJtBUk1=pvai5QHiLN6XLOOL-3KA=g@mail.gmail.com>
	<xmqqfr0qexps.fsf@gitster.g>
	<CALnO6CAEbiwRyJD+Uk_Aq0gKy-XB1=9PmOUwW6itOMCr+mBmwg@mail.gmail.com>
Date: Fri, 07 Aug 2026 13:26:41 -0700
Message-ID: <xmqqfr0pekxq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> We should be able to improve this workflow without deviating from
>> the 'one hunk at a time' model.
> ...
> Whether that's in a more complex interface or not, that seemed like
> the thrust of what you were after.

It seems to me that we are saying the same thing ;-).

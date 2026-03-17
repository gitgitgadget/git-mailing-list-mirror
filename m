Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D035BDBD
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779138; cv=none; b=i0xhB1IFncspzkjTpcHT3pm8dRsqr56r2PHTRGaW4jfWMbJG4IeX+SpV8kJhOlpvOrHw0fnRV/Xpr63cEhAKK32AFvyjl8qDQlhqUQd6cYH4q/wZ/cdROXtu1rqOhgx+wzf3ax56qzGXEW7i8N1wpHxdpQiW95nFN+WVQkqGLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779138; c=relaxed/simple;
	bh=ei9+rwYlls8jw3J0CCFBNAR+DEIVyHashSDPHRmO4RI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e+DG9KSeW6MdoSfO302OqLqStHC3FhWdFOvpMe7ojSZRC1S12pGK3vJapJ71NM488IqBrURwcESL7yZ4d4vd+Y5ahaWO5SkYUPJ5/TIDtbpKxvThgYP3d53tkEP0qdgF4UfgvhbpcMI2nmHX+EhB/sFGDZpZw+1ec8vKeaixaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OSWWyxhm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5ZH1yznV; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OSWWyxhm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5ZH1yznV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3883D1D000F0;
	Tue, 17 Mar 2026 16:25:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 17 Mar 2026 16:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773779136; x=1773865536; bh=wIJzh9WsNI
	SXEwHCSKgwCqquEXr/WVBCfc6Rq9uVXV4=; b=OSWWyxhm/ApVDzde3gPVHyCTJK
	MbK4B8XV7N0H+faOyQSr3iN30dHlGWxOeD4zk6ziVva/I4tsYW91vRBTr1ngC7I5
	B4BTn3IXzDGSa0kOwUW8+s6+g8pb2bGvmHX/vdv2ecL6jASBi2XmTmTNziBmG+DV
	DqNxvOLdBY9eohdxjHzVfl/NDTPzRFCHYG6Iv2l6XhuQy7xMpM3nY57W8d0Acyfr
	A2hWdDA8aCqQjWeELpnKDVuFQtWnuV2o02oulUYWXe661Vp77ktlnM4c7mHuLwPt
	L/ziqBxrvkPf1atSxdKFNMvG9gHAHBGzgskRiicIY7qra3CZQnNINTAYeOnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773779136; x=1773865536; bh=wIJzh9WsNISXEwHCSKgwCqquEXr/WVBCfc6
	Rq9uVXV4=; b=5ZH1yznVhM4dkjmHnfHWc/XkDrY93oxs/t83bmGOK2CddhE5IE0
	vL8RQrPX/Nb8teOZMQ+gL8mUqknK9CALK0s7oIKXgxCixIZxAR3ayOQpzcWJtVx1
	jguTnPm82Lg8oq7uy701xNoFcBymZZhMB/3/gLz/HmH+0dWTXNiLFsBlAHZVxlz7
	+mxfF73od7G0PWn1oEMx0tpqJEWDZG79S3PcLFcNvjhVt1/xdpzxwicHrCcQhBFF
	Vl+PCwlG88Ka0OeVBdfanVZdhj9NL8OgUA3cDH/BrqemtNEzyKIIQZKQFQU7/0dQ
	qN+Ql0X5w3cv3LW++94PcW1hYtJaIsL4n0w==
X-ME-Sender: <xms:v7i5ac8FRSDf2vrw4xrt9XK8hE_Qpt0y-nUtbBvwjH-uLozll37Y5w>
    <xme:v7i5acJqQU-4Nh5kZNsu9qe08fl3X5p6-kaIZnNlrAEbYh1Vw4j5unt6ApE6v9Llo
    cDk1vM002-xA_ToMs75HSv5Po8ngVhkCbNcgJNwDrIk3_lzpfSWVw>
X-ME-Received: <xmr:v7i5afbIGmBG9p8kP7n4lxdfr943qkcSIbNd_QNIxzb4L4kk87SLJUA2vmRSEwFYPW6f4wXsFkqQZrpJteugMBeYnqYIeQ_IUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:v7i5aWIYh3uTtIdjrXh7htVjmSw0UM8KlZgk3Ia6XWH9OOXsTT5Q8Q>
    <xmx:wLi5aVDpJtneGZw7layIc4C0q7wxFToQX8oBX5YO0W3ub8QLW79gYA>
    <xmx:wLi5aTq4gOtqHY-KXcQ3tcCFDP0oP3UdwxZ4pW7WOTN8XAr3cbbJnA>
    <xmx:wLi5aYiWnXoTs5F_-Ry0I4ueKmqyvm_UooX7lrGikeh9NIEAI4_N0A>
    <xmx:wLi5aYJbVdHUi5MVuNC6gzlhENGeBKkvwXCCmskXPxvuKMXszRWiE1ma>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 16:25:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] add-patch: use repository instance from add_i_state
 instead of the_repository
In-Reply-To: <xmqqse9yjjz9.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	17 Mar 2026 13:10:02 -0700")
References: <xmqqzf46l7x1.fsf@gitster.g>
	<20260317165230.628705-1-shreyanshpaliwalcmsmn@gmail.com>
	<xmqqse9yjjz9.fsf@gitster.g>
Date: Tue, 17 Mar 2026 13:25:34 -0700
Message-ID: <xmqqo6kmjj9d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Having said that, please make sure your patch works well with
> patches others are working on.  In this case, s->s.r would no longer
> exist after this one:
>
> commit d51b61f5dab9c8e715fa792f31d572bc96fb5687
> Author: Patrick Steinhardt <ps@pks.im>
> Date:   Mon Mar 2 13:13:07 2026 +0100
>
>     add-patch: remove dependency on "add-interactive" subsystem
>     
>     With the preceding commit we have split out interactive configuration
>     that is used by both "git add -p" and "git add -i". But we still
>     initialize that configuration in the "add -p" subsystem by calling
>     `init_add_i_state()`, even though we only do so to initialize the
>     interactive configuration as well as a repository pointer.
>     
>     Stop doing so and instead store and initialize the interactive
>     configuration in `struct add_p_state` directly.
>     
>     Signed-off-by: Patrick Steinhardt <ps@pks.im>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> A good way to ensure that you do not send a patch that does not work
> well with others is to make a trial merge to 'next' and 'seen' and
> ensure that they produce working Git, after making sure your patch
> applied directly on top of 'master' works well.

The above "good way" is to notice and stop yourself from sending a
patch that wants s->s.r to still exist.

After that happens, it is tempting to rebuild your change on top of
'next'.  But please do *NOT* do so.

Instead, identify such dependencies (i.e. other topics with changes
relative to what 'master' has, that break what you developed
directly on top of 'master'), and then merge them to 'master'
yourself.  And then bulid your topic on top of the merge.  Work hard
to limit your dependencies to absolute minimum, as these topics will
take your work hostage---until they get merged down to 'master',
your topic will not be able to be merged to 'master'.

In this case, you'll be likely to do something like

    $ git checkout -b sp/add-patch-with-fewer-the-repository origin/master
    $ git merge --no-ff origin/ps-history-split
    $ edit ... && git add ... && make test
    $ git commit -m 'add-patch: use repository instance...'

to build your single patch series on top of 'master' taken from my
tree, with Patrick's history-split topic merged into it.
After the commit is made, send out only your work (i.e., above the
merge of Patrick's topic) to the list and you're done.

Thanks.

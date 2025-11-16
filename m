Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B07825333F
	for <git@vger.kernel.org>; Sun, 16 Nov 2025 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763311902; cv=none; b=EpcEmdole7b6d1Y0UAJTeZroS1RVLJADZpiu9tcqMgjezQlBV717oXse+L/pj5BEuVxKwxAmjg2HdcTEyg9oN6WfeVfnzQZPgMRulLWffjGuGgryx8dW9IGFiXCGl1RjDzIqqDgf6uk979eJEqhrOH9edtE041vohoZS2wMIuFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763311902; c=relaxed/simple;
	bh=ZXuYC4XFxIk0GjrSVzF18YRMv+2qUGk89LxLmJGNcC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ru08/ob0mjAjmc6jG4jzidpVRrdyUI7KxTV+Yae8EkJ5H1ybNu/bB8Jq3myt6vILCHWrA87S1etRce9rM/qV9vLOKGC+nq5QTKI3WweQxyV8qoDRZa6SirPCtVTJ0jx632opFuvBW59pQRiCy4x9iuaWqvoizcoJKmrefTkmWI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iwUKY9AE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S8Cjb4Zx; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iwUKY9AE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S8Cjb4Zx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A45C51D00117;
	Sun, 16 Nov 2025 11:51:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 16 Nov 2025 11:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763311897; x=1763398297; bh=roA+jb/VQx
	d+9wGTp9Nc/VWCbl46hrudvL8CiUJFJEw=; b=iwUKY9AEohIuCCB6FKLX6KY5vJ
	0CrhM6BizQ8a9R55Y0YO5rne1Z0Z4BMy9e6jPpwtU8hFB3vZ4aIfO8CE9NRrEeth
	xiJa6vNK7biWVINQmUjC0KUYFO6EqyleYmqp0dGl1wbhDbqUeoxBxapnrsrqioey
	Q6V7F1lMSdQbOLsJ8iiI84ogIszbtwHySzkZh3Ir0eINmT7e0Ham5B+bNqwrizWl
	arjoCPJCBoZEmdjtBijlHKmZmHgulpzKKk0a5+d2XK/ez0gnHrseH4c34pvywOAF
	zxKTba0VEbJIi20oXWkTq7hXDrU5iU9J2BpgXCqh0Ahq4wWUesL5VF8Y1KwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763311897; x=1763398297; bh=roA+jb/VQxd+9wGTp9Nc/VWCbl46hrudvL8
	CiUJFJEw=; b=S8Cjb4ZxtTM/tuklp06h7CfZeoGmZUT7wlc5cFrWRJ60SxV9hA2
	7ZV/VcZfMxgVzYQ7Q4e431YpAZks+RIUSKuIiPhMA0F+FcDRcSDpCX3rISErHTbi
	5iusU7gyIlof2+NpdDQv3JiY0xg+inUgspLbehd1+6lQ56Qnn7isieoBZmq/tdWf
	mjlAUdgNYw+nzj3E8HTqxwejrHS4LGt/wnGEGU/C1qoCxqhU8SMlxEGj07egNg3u
	mDCRS1IoOYDnMnEVR9GEdpsEZCnjFi9ezKx13TtxNQlX/yCyNuw6Zhi1jYkUVGY7
	wyQIGTcUQefkYdqdSL84ESmNYpUjmXxdIQQ==
X-ME-Sender: <xms:GQEaaRl8YPubRK5ygxgeOCwrrIB5C1ea548YeOcnPmrnIEfsvoKWuw>
    <xme:GQEaaT0Nzi_Eyge-lcIlTs2lequj_KsDxXjJsobZyWBpfFe5Uzsax4woMF9lBlOtE
    3jq1KNREjsi3onNQ_d8c7Sl-oqQ4M9ykgAXDGxxAtLf27SOe5cRk2E>
X-ME-Received: <xmr:GQEaacp-xgKHQbys-ajV5oZqKp1F7KcGGcDjhjavmf0z_DZD1QO7GgTA8d9DdWHPV2oAyuN2jT32kTuVZNwvJKYuROPicz_J25xk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GQEaaQeGxWs6r-JLcTGFvWcZj26mWtwKgGyE0ciDKdvGEb26ljfdYQ>
    <xmx:GQEaabqQOad_cAEh5A28CSepNhuSH8_3iTb_-HNs4VorS_UUNJQGpA>
    <xmx:GQEaaREJmPHfB6XQK8cNlIVGGVXBvBJ8obGN-kDKsurY8hnehRZFJw>
    <xmx:GQEaabs1eBcQMSyIbr87Dy-w6N5mTa4xnr2gLtRKUr0B29rNT7yt8Q>
    <xmx:GQEaaYJF5hU6hI8uRIaGt7o_JSGeL-ghSPsr0KHhShWWcpyh73JONbkx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 11:51:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 2/2] builtin/repo: fix table alignment for UTF-8 characters
In-Reply-To: <CANYiYbFcap=c8xDy-=ZyaY3U4-jU9OEe18LPgTEAHi2wx2M0VQ@mail.gmail.com>
	(Jiang Xin's message of "Sun, 16 Nov 2025 21:32:52 +0800")
References: <cover.1763098804.git.worldhello.net@gmail.com>
	<a50bcde6446fbd87b4fb04b28c579a915457813a.1763098804.git.worldhello.net@gmail.com>
	<xmqqa50oiduy.fsf@gitster.g>
	<CANYiYbEFN9BHtNh1PQ9C3gDJasq1PaKnkcH-Nq=FddUCAcMGqg@mail.gmail.com>
	<xmqqtsyvfe2f.fsf@gitster.g>
	<CANYiYbFcap=c8xDy-=ZyaY3U4-jU9OEe18LPgTEAHi2wx2M0VQ@mail.gmail.com>
Date: Sun, 16 Nov 2025 08:51:35 -0800
Message-ID: <xmqqqztxdip4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiang Xin <worldhello.net@gmail.com> writes:

> t1901 already includes test cases to safeguard the output of the
> "git repo structure" command.  I could add a new test case to
> validate the output when localized in Chinese (as shown below),
> but such a test would be inherently unstable, because it risks
> breaking at the end of every release cycle whenever translations
> change.

I haven't considered the i18n aspect.  We already compare program
output with expected output, so a change in a message has to be
updated together with the test that covers the code path, but po/
updates tend to come too late for test updates, so the problem is
much more serious.

OK.  Let's omit this feature from end-to-end testing at least for
now.  Thanks.

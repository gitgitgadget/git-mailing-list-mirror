Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D57748F
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748745644; cv=none; b=VhPodJ1jpEANYtNvZzTl3pFVvPWR6qRkDEntTOci3Zkp2uyxwifSC+4npW/AnGaqGLRL0IG3Tncswsvca8L6Tz0OyDMizM85L2/2t19tizgIFKN9uZFM4ahHotBIgWKHqxizBL/q169hZ3rycg7yIiptxhqmsQYFsNqrsQk6x+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748745644; c=relaxed/simple;
	bh=JNpRYG1kIauCmTzwe4TuFrJ3zDaBFl/7E4l0dHdp+6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uivYaSKhIiZ98UR5VOiM/zzxk5jtrLUmZj1MqYubWGusl4+sM8vj2P2z+C+DPMjO4jAmxwC7rklMHIkFdgvmwAkwW/SJnBa07nRsJT/mFJt388i5QFkVZXkFatdmA/14VEqKrHF88JxwHYIl8pChVAgCQ/Ayd5mFQ5XQJ8V3Ogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yOqKpbQX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UY0firkF; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yOqKpbQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UY0firkF"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72B4B1140141;
	Sat, 31 May 2025 22:40:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 31 May 2025 22:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748745640;
	 x=1748832040; bh=yFzjXUzE9LY2yUYGYyNsfzKWMo7+Zoo8OgW+mr1X+Ko=; b=
	yOqKpbQXoAHjAIgkpwamOsMI8laA19bxhjlnGeQQKDqbz0gSBsfYbZjG5YrdzfQ6
	1GfVAxUZUEWVsGMh0o91GV7xcIRzdGNt6Ab8MGdZ8zveA2Nqkn5dWsI2RZ4547nr
	DknOjqEU5OqkFEB6I+AfDKVLStrHF1hUbHoqMMJIdOHjnKVrjObc3PECCuq6RhDv
	AzhVOD4Bb2cf5Dx8VpB7M5eg5bfDjOG5lqwOquv9Q31Uj+FzNoTjy3xFcOkZMHt7
	3cSPsi11yvBcHj91tyv8xfS0xL8ncD6Bak3jnOjFk/npe75pYfjjR19RFcvAu3jH
	ilKPHCOGIa+Jj6chv/qh+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748745640; x=
	1748832040; bh=yFzjXUzE9LY2yUYGYyNsfzKWMo7+Zoo8OgW+mr1X+Ko=; b=U
	Y0firkF64CYIlIlM9jTs3W5whw98kjeMXnNuFqCny+U5hDdQJ2ZuNrrtVWYH7eBV
	4qTdDSs3/Je5iDR9zt3Wx3631zveKebBlwaouPpeQXzohXg2dgjQqg9O95a0cXCu
	rtdbcvvBVAX6BXFlirC4K7F269U6i6TzTmmOzti/cG8hAK7436scXbBK4+il4his
	5TeMkQA/QGZ7uAvojY88xlgpySUzcaORKWj24GA1m80sSqN/A8FtYwYuCuiihsgq
	gFA7Xee40C55gm8fLe6iIym8Srj9K4upkn4Imw3Yjkgtv3XKSQD6JM1HkAo3xLnG
	yMUQSxOdjaOo9X8DbkE+Q==
X-ME-Sender: <xms:p707aEXrZpVmAbeNfmnx-U0GkDgqDS9KF6LCur8WM5HVP_iZUg0Eww>
    <xme:p707aIlGxBXh09XADSSlbsW2X5LeQRTFej2DM-ypnRMYDcPAhcCjXesN_BbFUVnkP
    IxvrxVdI9dvN5WdpQ>
X-ME-Received: <xmr:p707aIZ2nWdBxGH25Aq-0KnL6BdvKxYdE4mRUgYc-wkMI4lvOavG5S3QPhsCenYC_qyydZFs22Yg23omuGv6pVMylwT-_Fjfk5NR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffeeitdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouc
    eoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdet
    gedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopeiiihihrghoseguihhsrhhoohht
    rdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegs
    vghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:p707aDVH81I6NOFlzSIXm1UezXmmIhOwnYdr0uWDW88zkw53pS4L1g>
    <xmx:p707aOmzrro0jYAkWtZqrGLdedbwzbPSYkvFLMfmHynlQixGJgpZEg>
    <xmx:p707aIeMuNsajSANDzA9Xt6G4pmMmZd_wFIqPxMR6gJb5Fdc3dCYtg>
    <xmx:p707aAGx5mx2F8jlRxEd7dEZKyNcJKVNkDAjGqLCaAV4WlAuLygVEg>
    <xmx:qL07aEjCSeyiOUpru4ddjl-fchk-LmThaeCQw1g8NtqdyQ4CNtNSBjUg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 May 2025 22:40:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,
  "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,  Jeff King
 <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v9 5/9] imap-send: enable specifying the folder using
 the command line
In-Reply-To: <PN3PR01MB95978465D637DDDAE5B66D66B860A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Sat, 31 May 2025 09:16:01 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597C14385FFA97ADF5ED3C9B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqecw5d2w0.fsf@gitster.g>
	<PN3PR01MB95978465D637DDDAE5B66D66B860A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Sat, 31 May 2025 19:40:37 -0700
Message-ID: <xmqqo6v8xjyy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Aditya Garg <gargaditya08@live.com> writes:

>> On 31 May 2025, at 6:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> ﻿Aditya Garg <gargaditya08@live.com> writes:
>> 
>>> Some users may very often want to imap-send messages to a folder
>>> other than the default set in the config. Add a command line
>>> argument for the same.
>>> 
>>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
>>> ---
>>> Documentation/config/imap.adoc   |  5 +++--
>>> Documentation/git-imap-send.adoc | 15 +++++++++++----
>>> imap-send.c                      |  9 ++++++++-
>>> 3 files changed, 22 insertions(+), 7 deletions(-)
>> 
>> Did you forget to adjust tests that expect the traditional messages?
>
> I am not sure what you mean here. Could be more specific?
>
> In any case, whatever folder is passed using the --folder argument,
> will be treated the same way as the same folder would be when set
> using the config.

Ah, not this step, but if you ran

$ make test

you will see what I meant.  It failed during one of my integration
run.

Please make it a habit to always do so, if you haven't already,
before sending your patches.



Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8EC215055
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228629; cv=none; b=Ut1cmS9FVf6xEW8SxINCjvcORK548NKolwXHcU53Iu6McJA22nHbIQnTSAB4UOUt9ae3cKtn9CfNVZYx5/l1GxWOPGLdKhl5wJTpjJJQQ+pNy4x0CBAS2CX60j4YswrG/81k1YrbDh4kCRWS/OBmHB3EwZZV9SHaCfiYmU9n1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228629; c=relaxed/simple;
	bh=Lv8RqACgH3ssbTuz5dmJZx/lCBJ8amdep+h2d1446AU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EAC5zdYf+QEA/Cpj/4p6beW29liH8CDm0juSQ+W7WMLFu4ZxAlLzL3LeokDoB3lhFaZmZq+9IfDS8nnUflITtbVku8MPhNbqoP40GgMZfybaW71TioFi5956cULNkdGx4J0A556PJAwlN3X2GSitfs1vFzwVzazq4DH5Ln/X09g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r55ZXgJH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vQf08AhJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r55ZXgJH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vQf08AhJ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 09981EC05F7;
	Mon, 12 Jan 2026 09:37:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 12 Jan 2026 09:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768228627; x=1768315027; bh=5n58/tUor2
	nCYFIBwjyyb3d8/yh4nnm+rByRNQO74NA=; b=r55ZXgJH0hnVr+DkN8qt1l3XUX
	lED/L4VhzHKkTu24kpY3LsSO/n3pt5Jif0FdL/K18o1NQ65AqjP+uWt/kvquFfaB
	k06jbEtGi5v29Aj78jY3rZgC+PxdB3TQdtgjorrlbGFOogfEPS3xtPyToi4Qb9IG
	ViK9ox0B6GTMMu4f9u285JsALupXzxWX9g9010jVaODIglbAZlbLsUocXgpTwFNv
	kQoQBSElU3t6hX7AvlbsceBZdI6lHs/PZ0/IDgcaMc5D70b6AneJLZb4OBMsJ3dX
	n9dWHAAwc8Nzv4gnMmPIHx2CKCdNAhkS/qDsKmBqZqwxx8oXyQa1slElPvrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768228627; x=1768315027; bh=5n58/tUor2nCYFIBwjyyb3d8/yh4nnm+rBy
	RNQO74NA=; b=vQf08AhJTKHpiC8AslXPGQ6MsMP7aFI7wgwim9YZ04Yn3VzeK2+
	87+CpTLL2p3kXW/HsZKs1UuBxCEmeBt/Km0yF9ttF0Q6z8CIAA8flu/y0yzv1A2y
	EObnLGsLtVU3+7bq8HAcvJhkTFkHsEk6TkHei38eVLxRFBCZrxikF0Vx1wmmnXeP
	hs6o0B+FAD9oM9kFntlNI/3fCj9ztEm3l58Sh4+fpRaDFetvC05pEpicN+8yHUFw
	QEa1vImsfyVEMIbgY5RqJbiOA2E3clhOt5ArKyo+sjd+3oFAaGMggUDEh7oIl08w
	uuO//FiBO8r3f8348NCFOCV8fo9z4m7bWgQ==
X-ME-Sender: <xms:EgdlaSXyWMsMPeSGWjoBqsC01piuovZSwt2ZuCkzoYG-6verujwZqg>
    <xme:EgdlaVc-temVUWv7P6x82z16Kcjs_MhH3kh5Ko7MT9JNONAyw-ptRt0OpR1DUpbJj
    zyAf8kr6YlZUjdtdewZMybI8qLifNGn57WW-u1ZNs-4dJ8JRJIrvA>
X-ME-Received: <xmr:EgdlaetHdOXIEz2Z4rmBy5CrERWhu6hBbeqkJ0bkLZWtdmpSr99S-IRd_vqqRrA1xokmYuH6BB0B353OU3P1wqfoNsSnHQBMO3IMVIk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EgdlaU_rZMcmxcN60_wv1G9wf1sCfF86VOT-KAOdGo4kdEMVP0I0Tg>
    <xmx:EgdlaZ3nSjWSO2wibJMgmztGcN22S2Svn6i5svoouKuf_FXtxbbJJQ>
    <xmx:EgdlaZAFtKuB4DpPPMVds_usqJ8mCSAeGoHbMvDv9H68uf3PQcO9gw>
    <xmx:EgdlaVcGny9FhmtW7cNTQpi5bpmtt9c114rb_8JFhMj9z1p6HAJaxQ>
    <xmx:EwdlaUPm7Z4vsMDbFqHb1R0BS97Fhm2d_0WaE11HJlApPUE9ao2RgbLt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 09:37:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  shejialuo
 <shejialuo@gmail.com>
Subject: Re: [PATCH v2 10/17] refs/files: introduce function to perform
 normal ref checks
In-Reply-To: <xmqqldi2oqve.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	12 Jan 2026 06:19:33 -0800")
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
	<20260112-pks-refs-verify-fixes-v2-10-2e9e453bd6c3@pks.im>
	<CAOLa=ZRMvbRT64+XdKobM5RZhgiPd=2k5_Yf=rgKyjWnbpMg1A@mail.gmail.com>
	<aWTyXufNdKckmBTC@pks.im> <xmqqldi2oqve.fsf@gitster.g>
Date: Mon, 12 Jan 2026 06:37:05 -0800
Message-ID: <xmqq8qe2oq26.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Mon, Jan 12, 2026 at 06:42:04AM -0500, Karthik Nayak wrote:
>>> Patrick Steinhardt <ps@pks.im> writes:
>>> 
>>> > In a subsequent commit we'll introduce new generic checks for direct
>>> > refs. These checks will be independent of the actual backend.
>>> 
>>> I don't think we've used the terminology 'direct refs' before. Took
>>> me a second to understand. We generally use 'regular refs', but that
>>> includes symrefs, so I think this does make sense.
>>
>> Yeah, I didn't really know what to call these other than "direct refs".
>> We could instead say "non-symbolic refs", but that also feels kind of
>> awkward. So I guess this is good enough...?
>
> The latter is understandable, if awkward.  The former is not.

Well, I failed to elaborate why I think "the former is not".

The former would have been, if we were calling HEAD as "indirect
ref", instead of "symbolic ref".  But we use the latter, hence
"direct ref" is much less understandable than "non-symbolic ref".

Thanks.

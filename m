Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815C2E736F
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988713; cv=none; b=FLbV43y3ptfdo+BYXgzoduaASpgH8xg3MH8yo66/YMuOq7d13+4LjlVlrcebpJdJOwIX7sA2CB6hNrJpfnxHaL+4lhKrgAtd9xVrtHGVR1BAWooGChFZFGteRmrlsdUS61uWOtbCIQqsqWiHFtxDtfaAeLxQEzpHvdlNkn3VL2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988713; c=relaxed/simple;
	bh=nrYHzzpnGAicVJ/wRM0B4BMKFJZKo4W8tbDQLkMqaDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpb44xmoU3U8Jjgk7k3eAiNHo7AzdYiFPDDrx4f14Vxt9NOeVZ+9WgIhS5wgv1a9HwPD0PP5BvOwL7JQ3Uvm+kkdMak6z8pDV9FcR/DIb0fcXFuTQWWZdyGVGFi15ieh6tWMCIj0t9BFAk1wnXxSC3BXkY48mIuEuwAw4ukZmH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I/TxtjC1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S5gN/xe0; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I/TxtjC1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S5gN/xe0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF4F814002A8;
	Thu,  2 Jul 2026 06:38:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Jul 2026 06:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1782988710; x=1783075110; bh=hygVS6cRhl
	YhYc2uoKyeCg3sL7Sq+b5hugA7ncf/Xt4=; b=I/TxtjC1EOe6kZAL/olZIHSYhS
	+1xbe8f0CLxTVv1Q9bgRK6efN12hYeZ0rirY8RNI0bQ99UhCu+l6ij+KMZPYfU6V
	DwQQEAVEGkEQixK09VOyvOocok0k/Od2JGa7qGbfXyrfVHVwTmVnqmqMX+OYDKVX
	A8Vq0nRLpO66tc+sE/h9uHHGn6q4JHAMyi7cXFtZu/vtVrYAOaAcdVBrSvPY9UOc
	vMnfUlegr7qBXwx/LMD2XDNPIr4+hdfJQapuyBr76lr4D78u4LCSqUFSYa5qu/yC
	RSsbQtv4Yv+pCLnWqKBQkJHUOsJRLgNSFKQdZmKd22PYjR8AT+emxzDP8gyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1782988710; x=1783075110; bh=hygVS6cRhlYhYc2uoKyeCg3sL7Sq+b5hugA
	7ncf/Xt4=; b=S5gN/xe0XlM3cXNkpTv3Eo1KHSRAA6KjMzD0zOMjlEzweiGFeqZ
	tRW5owAz1KYhdPiskKebI52ZXn+4Zq9OFO/QOoc8NdmJTXdyes4zS5owY7qYds5C
	ER5YqpJ96m/EwYhZZbK36bEZapvC6G235Ta7BYGE2/VPJPasffl+DVL4gYlZzcIo
	ehjU941h1qIpbwyga2KmGidywSWq9yr1/71mAtkJ5kl5wCmhZ29EnH9Wq/2TpjTX
	QOAqy1RKAB4Q7VZp62kjI6Fu7gLQRJKPk6OhqjMYxbVEbFD/6dkcigTYBOAiGln/
	BnaJF6lq1r3jzbmgZsTRZqvbhrmzEavVHSQ==
X-ME-Sender: <xms:pj9GapiJaZ1geZxxsWA6VqUKhNKQCIQbOsMrzTZVKOIGmNguTvchLQ>
    <xme:pj9GakDFQVh__EidLRXWvzVPcOPogm_iP2tw3aPkXIp-Rayskb-vcbtWBc5Q_FIEi
    IuhbCE7WZYLv8UlsBCTBIl_BVwk9BV7TRQ-YI7hSWbcsepu7JHnng>
X-ME-Received: <xmr:pj9GamtygTZsXW2xqgPk21HQQ3dw8LGhZ9YXdKrMQeCki1XQyWYlMNyilFNL2ma0DMId3ZAFbXNFTWOwMT7Moax-r12OMJREDox2aXm6PZfrIA>
X-ME-Proxy-Cause: dmFkZTF7gj8bboTUoj5PcRqrfQ6ZhkOvzFqHvv1huToKOHc881vegbq7F4nhlM4xJGYUv6
    toi/7zjU7mCtHtz8IBRVMp1HA1Pl3ARgy6Lcsa1HD5SHNPcqch5YSBrh8XOndwe74x86mi
    OS27JlpO8teCHi4ITKLAlDBlE6Eah5N7vP/3OX7Szvm4DmbbGBSFLnry6twPqRe4jyjmd5
    ARJ8VyKYoECXeN6s9YmL7TW6AbcFlWpgzeZGyyyIb0XVDmz10bxZHc3wNCWuJAbM1CaYn/
    KjipBD7dhsUinJXjHgb7lel1lkmHl2m3Ky6G6YY4duOVqVeYPt0A8ejJFhv6l/Eu/T0+lT
    tuHFrKB9z7mhg3xUii4f8vfkvRKn1+r1RGeRTXKlVCOJyzokmAC9nO9hDTZsvDdo4jlqy3
    lE5cFb1fkj1wPiXlQ6w5/Gz++3IHT1brFnWG0pkwc/IbNLoTPeMzymDyRtWb6QJ+NISZn+
    TjG2Y0Jl4S7BG9ykeADGSELcaocrRpRKE51u6GJmLxGZ+JDWoTImMhkm5ONAyNAgoYvmWz
    63ioT9Hr7OhSeak+dnFmlf/j3Cl/A8MG5/FxOxMZ8A8lYSb6Cg8YCF6rmdLxXR4lWTsgmF
    ZzKFFeCIiDbjHR45w/NmeFtKfmg7PAVj8tObIUDsRCOI+cBT0AOTwY1jJI5g
X-ME-Proxy: <xmx:pj9GapYiaO6zmgBuTwbeATJFkaN5pNIg23nhXCwjT9lbaWII7ON6RA>
    <xmx:pj9GapX7d_FDdKXBxrX5N7qyabBobmI4OFO-4wi63w-cbM-53odr9Q>
    <xmx:pj9Gat7nEV1wnrjcJoTX97SHiLQAv7KoIFphkQH2uwRW5QaImxlAOA>
    <xmx:pj9GakjgLdfNxkpI-03yjCtreejWJfH2xyg3hutDNh0XtaniSBSSGg>
    <xmx:pj9Gas5D-4gRwtlndxWDLkTugvB7nupH1Z3Z1DwihIqihqNnAqJgrVBz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 06:38:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4668af9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 10:38:28 +0000 (UTC)
Date: Thu, 2 Jul 2026 12:38:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2026, #01)
Message-ID: <akY_oce1EcsgsN9b@pks.im>
References: <xmqqv7ayl1nj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7ayl1nj.fsf@gitster.g>

On Wed, Jul 01, 2026 at 04:40:16PM -0700, Junio C Hamano wrote:
> * ps/odb-drop-whence (2026-06-24) 7 commits
>  - odb: document object info fields
>  - odb: drop `whence` field from object info
>  - treewide: convert users of `whence` to the new source field
>  - odb: add `source` field to struct object_info_source
>  - odb: make backend-specific fields optional
>  - packfile: thread odb_source_packed through packed_object_info()
>  - Merge branch 'ps/odb-source-packed' into ps/odb-drop-whence
>  (this branch uses ps/odb-source-packed.)
> 
>  The whence field in struct object_info has been removed,
>  refactoring backend-specific object information retrieval into an
>  opt-in struct object_info_source structure.
> 
>  Will merge to 'next'?
>  cf. <akOod6X1a2axIXKZ@pks.im>
>  cf. <xmqqv7b0rmt6.fsf@gitster.g>
>  source: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>

I'll send a small reroll to rename `sourcep` to `source_infop` based on
Justin's feedback.

> * ps/odb-generalize-prepare (2026-06-22) 3 commits
>  - odb: introduce `odb_prepare()`
>  - odb/source: generalize `reprepare()` callback
>  - Merge branch 'ps/odb-source-packed' into ps/odb-generalize-prepare
>  (this branch uses ps/odb-source-packed.)
> 
>  The `reprepare()` callback for object database sources has been
>  generalized into a `prepare()` callback with an optional flush cache
>  flag, and a new `odb_prepare()` wrapper has been introduced to
>  allow pre-opening object database sources.
> 
>  Will merge to 'next'?
>  cf. <87ik704f1j.fsf@emacs.iotcl.com>
>  source: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>

This one should be ready.

> * ps/refs-writing-subcommands (2026-06-30) 5 commits
>  - builtin/refs: add "rename" subcommand
>  - builtin/refs: add "create" subcommand
>  - builtin/refs: add "update" subcommand
>  - builtin/refs: add "delete" subcommand
>  - builtin/refs: drop `the_repository`
> 
>  The "git refs" toolbox has been extended with new "create", "delete",
>  "update", and "rename" subcommands to create, delete, update, and
>  rename references, respectively.
> 
>  Will merge to 'next'?
>  cf. <xmqqcxx7susi.fsf@gitster.g>
>  source: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>

Likewise.

Thanks!

Patrick

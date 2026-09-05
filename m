Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6072F2DB7BB
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 02:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788574635; cv=none; b=fZ33/Txx75rE7GDkLaiZiJnSKYipKIN0MSnbe62/9l9lgzxDdlozGnpKuG2rKzpHh1j1Sj/PCwiSpljUYi0j+FREpRExpmJBEEAxY6nMpn1/ZN3GGL+C3nvufCVLS7pa8EBs7iwpNJfk5UijjpNW7g32sJMhdgw6oZjbcocaWCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788574635; c=relaxed/simple;
	bh=2saVQhcmoXNu99Ns1CKCYbuYKi/aY5gwYfLsbKcQ5Ls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M291aJbpJ7tIvKld/yW7Pa+GKuPWkdhFdU+JcGZ5ULf2rCU9yKcMqPHhGO5nFCTar4BAtC0681kpRO+WfMwJ12nZi54eRFGPsB5bnD2tsoqX/UajKp6qIelHd9+IFS1wqCUQQX+Bfxq++nTMQDLTXwJ4AF8iAkMi3zzPOVMNrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=caVopQMX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PT4ZgY3u; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="caVopQMX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PT4ZgY3u"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3DE9E7A0098;
	Fri,  4 Sep 2026 22:17:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 04 Sep 2026 22:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788574632; x=1788661032; bh=Jnp+NxlP+E
	55reTwaqxuWIrTvOoq/GtgOWysIiaQMlk=; b=caVopQMXBk/WVycIKeNmM+ZDgJ
	v+CzhhK7+5E9l2b/YFTikvRrz+CWCHQAPfM98Ug5lW0ivWyxbwCsjSlH0snkTk1L
	wrS1uZ+pSSrGqQ17bTAs4n8437mfGs8CpVJt0lXckYfLvwaOgNWPeOlOkrbYHOd7
	Hw5DILJ85rlU4NvV80/3M+APBOPkH1iViRlv4zhswp95yYy1Vl9/x6bg0FUEufSX
	PdE3d9hUzzW5+qt3wlWQQHo0heNFuYM9knJa/X0sPHYiT7MYQxPgnLfT0Ibe+lXe
	VwQzFPmtoOQOLkpd4QIoIbEDN1YpUjpP5c5KlDeMKD5h1XbmQw0NCAB8nLwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788574632; x=1788661032; bh=Jnp+NxlP+E55reTwaqxuWIrTvOoq/GtgOWy
	sIiaQMlk=; b=PT4ZgY3u7BkRxKjhgFGkU1Slb/XHyVzIekgjn8+v60upxXxeEia
	xSWXrondqppGnV7bYD675f6MvXh9sN8VqCsHh3xZYR2ynD/4APxtF0hh5/hTdgGm
	NXUDSfyW1y/DVQCAs7s42N+FaJqv7FEELVCZJST4ajQdTzPVS6FMiqLYzeX2JDpt
	LAAAFKjWrLF6oSv4LfbZo82+Gh0DyN5ClMMj31jnqMPBimWL45dO7dSEuXEdoedK
	G+Ob/WfsPzElmN9ANoSrJyNDJNkKGbV7h2cgweTTY+nQqt6RKhe8815CBf2vuJOT
	dBKdqA/UkT92M55Hi6pIE39kemCED612dwQ==
X-ME-Sender: <xms:qHubamBa40Amdq8FG9XOKIiraqGYHVtItTxyncm6KTLw0uzudxWtgA>
    <xme:qHubanh7rtdpgFbLN9t6dIOXNzil7qUqxuyNeBdvZWOLRZewGcdkzlKrSI3Nzsy0h
    oKPHEMz2dLpxXyRT1YLJ7-rZsuW4MgYWCd9T7yfPVrk9AfY197joME>
X-ME-Received: <xmr:qHubaulvwugGoQkmY6jDaVc82nuTtrkmVmSyAaZwJBSOpQjcPgntndCsE7EcbqE95GKHHDmKFfo5bgG8VYDrWO-ib_kBFDqS9A>
X-ME-Proxy-Cause: dmFkZTEucn5EMTqbgxEukAjbiwaHigTwfADNqkETERN7280dCZlwneKAe5GjpkC9oZqiaA
    c/V5uQB3/atrFSvRUt9t6qwHhiSB1vgriMVrEtWx33J/v97c1UUiZOpioYd7UWCp03hey8
    nxRtvbsH1huBPIal35YnkzrFfaZnBNbVSOmfWanQgMC2luWLwWFUo1wWvqD5ptV/6z5OXy
    YXf0S0+64/BVtaD59icjwSuV1CirYXdvo79OLKD39GdB8cX8kwCPD1IibiEEyoEggMtG8w
    Kz3KomCE91UXIPQcciN0j6pH0+nHYk1id9yKYONqrpEHBkCFaVuqvjYHl3t6iBmW2TFdMu
    /qRNC9rSXy5t4ttaLhtwuDYMj2TR+/60wihvLYVWuZ5k/gSJaAkAVK9dj9NEBrpO/eJHYU
    QpYOMcgosgAP4H+a4lreF4r26HDorGs0/6kptk5IYTWwrc2936K8y4eGar8yLx2d0Gw1Uq
    xa+9LLT6wAFO87RkSsKzNydYjKfGsB/W1MxZr03WWYRIHzlOZ9Ba5iK3FvZ/yOhix/WtO9
    HB/Gh0hK+uGrBSfaJZbQYdsLEh7v7WLbykxGV/x4fiuBha1mZ+ja6V0qB5icDFtVv3mqbq
    Iyl8qXK3XFW8agnpwQNaL23zU4YxZ2lXM5u1KPPqHgagP5innzJ69UUE92hQ
X-ME-Proxy: <xmx:qHubajoKQd2e2IDfH0vaKuzF_oGd8pmLZFUIcnLRQEJoxec-wKb2aA>
    <xmx:qHubanGsmgpe-Ng9iZfUxvGb9VYtgy3Nheud73ryAzWeH8tyAS0Qxw>
    <xmx:qHubavw_i7__zDi_df0Oxebw6zoocQV-cL8NVVfg-lmk8x13CBxDTg>
    <xmx:qHubasq5Abac7v0fa7vl-OsrxPfhkD8CF2536sIe47Xhp_3TbFgj5w>
    <xmx:qHubavUYs7rY1FPVpbbjnTF4A4ZkLPENO4WfY2w3scZSli4qaRoTR1iF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 22:17:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mark C. Chu-Carroll via B4 Relay"
 <devnull+markchucarroll.fastmail.com@kernel.org>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: Re: [PATCH 1/2] Update shell tests to use semantic functions
In-Reply-To: <20260904-file-tests-use-shell-functions-v1-1-b66f9cb4adbe@fastmail.com>
	(Mark C. Chu-Carroll via's message of "Fri, 04 Sep 2026 16:35:52
	-0400")
References: <20260904-file-tests-use-shell-functions-v1-0-b66f9cb4adbe@fastmail.com>
	<20260904-file-tests-use-shell-functions-v1-1-b66f9cb4adbe@fastmail.com>
Date: Fri, 04 Sep 2026 19:17:10 -0700
Message-ID: <xmqq1pb830ih.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Mark C. Chu-Carroll via B4 Relay"
<devnull+markchucarroll.fastmail.com@kernel.org> writes:

> -		if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
> +		if test_have_prereq MINGW && test_path_is_file /proc/$shell_pid/winpid

This is Wrong.

First think what the point of "test_path_is_file" and other helpers
is.  Once you understood them, you would never write them as part of
conditional expressions like the above one.

A conditional statement like this "if" does *not* want to shout when
the test condition it used to switch between its "then" (and "else"
if it has it) is not satisfied.  If this "test -f" does not find the
named /proc/$shell_pid/winpid file, it does not mean that we
detected a breakage in the system that is being tested.

After looking at a handful of hunks from the top of this patch, it
seems there are many more similarly wrong conversions among them
than a few that are good, and I won't look at the remainder of the
[1/2] or [2/2].  Sifting the two large patches that lack sign-off
that span across many files and finding salvageable bits is not
something I would spend my weekend on.

This kind of conversion first needs to understand what each
invocation of "test -X" is really trying to check and why.
Brain-less mechanical conversion is not sufficient and will produce
a wrong conversion like the above one.




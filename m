Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD830DEA3
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790288194; cv=none; b=L/0Y8WOv5d7SGBsk3YhWmLR/hop9KdPRm1LopK0+Q1PxEN5c73SxiRN9p3crDfIgrT3Rg1xgOBU00XIbZVmSbs0RkRrfSelMcRW/PRaXVXqX+F+D6dbmm0OvI3AmDx5EdEMTWBNZChwXT/cUK1K5B5qW9kVvuZIxPOigKMGZKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790288194; c=relaxed/simple;
	bh=veyrWLNUbtqoxKX4biPrB5mVmq/kha/cDNNyDCmZe8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EgqTFCkllfC2pRx8uqwwRsbh4cXMbyMPvRIZZa1wJ1gfxBYkymejg5iZqdQkQ9Kcqu9yiwADydcUJRAnOr10BvgrTiAU1re0VvMvPh3e6LmiAaUpiBL/USBEYfoPLFjosAVPHXfZHxnpvMBPSLGyuOrCyMGmad3yiNqfYxy62no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ad51yxgP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QrEHvk3W; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ad51yxgP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QrEHvk3W"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 51EE81400114;
	Thu, 24 Sep 2026 18:16:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 24 Sep 2026 18:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790288191; x=1790374591; bh=GrGuzjaDR1
	8nJVwbdDnxKhX2R/Za4/PgEQj1/GGRP04=; b=Ad51yxgPMqzAaKCKXYiCuMmkih
	MWA7QI7zXW6Z9/WWr1cLWCgpaRLGUarremP47gnIGk4oi9dhG/PeEGy//1cIjyLd
	Gbf1Yy2he72ZemaFxaFXWSFKUdTFNiAaxa3wwB1bO2GftJuByJKcqQorVckOuzcv
	6z5F9IlFZFv1TImPUlhH86h0yCOKwCemWuxmrQVd5vIRShPhKM1hIccYxt76Md+X
	6N/X583K7gTuO+GZYQnVfNJ/sWD/Wjs7PTmTcl0FzEZoBrjhGLT/YUFCd65qVfyR
	aTGnk67zMImOEwJZ6ioinc1H/nvhcdv+XtjCtpZqxnf5CRp4oWbxJjL0DXFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790288191; x=1790374591; bh=GrGuzjaDR18nJVwbdDnxKhX2R/Za4/PgEQj
	1/GGRP04=; b=QrEHvk3We4snSlnIljDnDDPMzkoFNHrIteino9zT7eO4JLh1EFr
	lFOxbtm2OposBNVbI3jg4b+Q79Y1GTqaIlF1oPD9LB9bL3QcXK9q+lQrXptm+EJF
	j3F4p8FPszkzrbCjQvsC8FY5wsYNt+yPPpL2IjVD+GI0xQVSEvXc87z6ntEtg5n5
	bSuiOjecCX/af+sshIun6wUt9z0/sLZQG2KOhP2DURa3rbY7wsz3vgb2vV270+Bj
	OVBch9m9uhJWSfDA2vLvGSUo8czjDt0ul23GMYUxI0iwuC0xY7WMgVsIsMUHIv7M
	BO9ItrDiyqfuujVqnFW7wiHIHaaj18A3DPg==
X-ME-Sender: <xms:P6G1aszmhNQmN_XZfeY64bIfOVc6qLQ3bw8CaFmG2WhNxUwdK3zdjw>
    <xme:P6G1anRNMPP0ayG_1PtCepHJ2_CWG2BDr-HHQG61Foot4MjaDyrf6n1DJX4PClrKN
    Bwu0XlaTg4iLxWn0YCED2bj3BV-N_KccacbUAUas4SzIJZ_XZgH3L0>
X-ME-Received: <xmr:P6G1ajVAAV5_umTB-uRK-4vq1xylFAXrOiZldE7M91hOr91IO9xQrbUVnqvPoxiKqbTcJ5wLtt5V5pDRg5kzB32G5fUVXSDes59i>
X-ME-Proxy-Cause: dmFkZTGsuz0xjYQZldCG2JVJc8537B7EEt0wn02u0RlIH8/OU5cL2bUw16UzALitUUNtN1
    AZmKPKpiAPRehGk8zikDT0s1FxWk0HXOojqX1dhwv2lLrdhrKEhLnF0c/F7oSUoCWwh9Ac
    rpK7WG5lP+i5kzhSgg4CQqwUsvJZ5i0EiF/AquwAY4msSZ/+eF5lWlTC6g5Bovxk5Q0U1x
    nLoUI6n2RPRsKkEwilGbEEYPelsDTILc60Yp017xwJk2HxuLY5Y3rjO+fE6u6i1annzTF3
    +85cXrc+1j/qjPSQ2eDLLk91XDtuJ0TQaEqcBsYm9SR9qMRfcK7dHtcfbz3+7t31gtawk8
    KDwSKJtGpzV7XD9g42RLKuYZwLzEWtnQ5+w8T8J+30nIzbEd6p23HyC55H5SMrlv0rTdfX
    aYbBRmumq8EyCG5aDN7bQ3oQdccQbVAnV0knUdlrG+vd2nAoWnmDXm9FvtW7qLvEEQNdRW
    0ft8TLc9Zj/1rPpxzMdLCR90JH7OGwZNWFeBRClx68/NdVwYAnLB8btZJIEetHnPlCxe7Z
    A9QGxfeqDBGdhpaSzGg7mdZinS+eYNj6qjx2xL29PpKf6VkNj2rNWqFDFCIimaMSDOQ5O3
    FSr7Oht0AeHlpiMtXZfw0Wi+pn2fbK/436IEv7BfgqDFciWtSVAb5s5JM0GQ
X-ME-Proxy: <xmx:P6G1apYCNCb0i-XFVNr4ecFM0tb1I73EgT9x6z4RQ5R6ko-KMcuW3w>
    <xmx:P6G1ap0TASKUY8wJrNy1QY6nA5b3zL_hXuenAJcDYse2CVXxg71dhw>
    <xmx:P6G1ari1ZvuFFUEmvmit9a6GC3VFyLRkdbwN4mLC0oS8NPZRnKe1qw>
    <xmx:P6G1atbCie89Odl_rgJH9OYVL6dsXxPj9cXdgT1TFciznLafpkhlug>
    <xmx:P6G1aq3aTSOAAXguP5hzJVQnnmop-o9Mfzz298Hgl3xFllfgk0hmeXbV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 18:16:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [RFC PATCH 3/3] setup: communicate why a directory is not a
 valid git directory
In-Reply-To: <20260924120502.2642141-4-kaartic.sivaraam@gmail.com> (Kaartic
	Sivaraam's message of "Thu, 24 Sep 2026 17:32:21 +0530")
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
	<20260924120502.2642141-4-kaartic.sivaraam@gmail.com>
Date: Thu, 24 Sep 2026 15:16:29 -0700
Message-ID: <xmqq7bkaz45e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> +		strbuf_addf(&die_msg, _("not a git repository: '%s'"), gitdirenv);
> +		strbuf_addch(&die_msg, '\n');
> +		strbuf_addf(&die_msg, _("reason: %s"), invalid_gitdir_reason.buf);
> +		die("%s", die_msg.buf);
> +
> +		strbuf_release(&die_msg);

You just called die(); nobody will execute this strbuf_release() for
you, and because die() is marked with NORETURN, smart enough compilers
would scold you for introducing dead code.

Why are you lego-assembling localized message yourself, instead of
doing something like ...

	die(_("not a git repository: '%s'\nreason: %s"),
	    gitdirenv, invalid_gitdir_reason.buf);

... which is what is usually done?


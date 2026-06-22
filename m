Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455A346E60
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782164624; cv=none; b=flh4q5BdjHIwP86u19ftZsKeAVekboQU2YoEOuvFErbshDWC+KDdSr+BsCrokI+zrin1QNAHHuX5pedMpi6i2/2ixuV3ehEWRgSvA/47NFS1B9xeK7rr0hbTKQLxhxhQRLTfqAQwyiaB6IOzijLuwiW9jbiq/xLmUoBS9Vbd5CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782164624; c=relaxed/simple;
	bh=7t4AwX0lcT/X0dbOx/vYCzyxiEtrLex+m7/pwZSKbGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ShnR7oigzom+ZeeSQPiU+ciRww8rowU+h4Y3YSUnbl2lCP5UJmHjnLPKgRsYf4lf/c40tCK56M7r+q0/GlxSfm37KnAq4rTAAEBYx20NxAoVIUKeRa4JxvBQfaGrzz1HMObfnL06xr9OTjW4511IBmjzg/vPY4Q5tq+vpG+F/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ot93lsvu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ETouDd48; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ot93lsvu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ETouDd48"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7C4311D00125;
	Mon, 22 Jun 2026 17:43:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 22 Jun 2026 17:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782164622; x=1782251022; bh=qhW66xjuGr
	dZvIOLssy8hTrrbca87lIxiBG/9kE3TNY=; b=Ot93lsvulP4aP4+e/AILf0ujpz
	TVKJMhupFCOrxUBR6xOFsoSg7gM/tW6cenSB9OFvmS+O4tCbBfWbh+sL7T1VixRx
	4k1BMmKPvdjPbXTfe0BlrnJQMlLTs78dWlkLOLanzidQDxrRZEVZ9bKAFcKLkR6D
	fJT00bkzGgAiChLYCc/PJrfLXo2KiI6+04F9FX2xz1uKjFmW3wZF+SLtfnWbkiP/
	jD3pdUx8FdKsTwnw8j9Sm2Eu3x8e5E3Tyoe3+EvOngkPehNmEIWsbnnVKTXnY768
	pvW1+HzKegdjoJJ+cjUYd1cwEd3s6uYQBAyei00Pqdd7HjJkkZeHqKPDpplg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782164622; x=1782251022; bh=qhW66xjuGrdZvIOLssy8hTrrbca87lIxiBG
	/9kE3TNY=; b=ETouDd48MZoGvSegplEintIYn/BUeWOz58PNV7dfInVe/SsHACG
	lZ4iEf/E9Pm0ULWoYdbKsF6F10w/vmdvMvJKUoTKeC4SCEZ7gVPa+tlAgaqeLbzA
	qimK4eTq2P9UpJ/c5NMoIc/Ny0ip5hiSCs4C6JCjFMpSBQYbqynV543OMX3yGdtH
	knMZ9floU9iibbL2Z1G+Mjz3gysHMIHzv1EG7nbnZKgnEDWC5ldxxb8t/SHXQbso
	SuB9pOY8YdS0FklggjiehSSh2XjXZ9t7JsZ+re5mlW3bQtR1zmn69l02wHleG4LJ
	K/x0JQ4AZlzWvADIDA5AiyHnncG638djUYA==
X-ME-Sender: <xms:jqw5aiumxDfya_vJmqfh41rR7ApDoLehlr869IeRH2QlhX1jaVTKYw>
    <xme:jqw5auVI1gCeonRtD_snpn5OK_HexzhraoHiPzE8KDHwv9vHHzYnmZ9Bdot93Q_Uc
    ULmhvDgnFlF9H_3E1XgZVmk2ctPlDjqlK1bZIS-IjET1Z0s8sndn7I>
X-ME-Received: <xmr:jqw5amFa6UxcMVl1dBThtw_9nte1ChvkIzuLDA6SMGI4KCkwYsAlxhF1DLq6xHpaXnndSVtvkkjExPswX-_ojv9NP89YXWXw0NNlRDc>
X-ME-Proxy-Cause: dmFkZTG4kzkhnwivcMDf2D08tW+LibW8KZIUzE+QSJFOUgHUJevGcJfpAy1KABDoK2Fw76
    ujZe5buUteTMscMm0RWlLvRv90umo9WW9SSG03a8gw6B4xd6YVCgZX+dkUkmEJECd5d/1Z
    O+AekFjvHm/ge6Dn9FOxUDIejnoCpCGdgQjrWH0sjbnyiBKMtT7TMuQeBg66xSYzY/LxRb
    Xs40PV20QBuaHVRMPN2yMSMW1XsQtkZ8DEyzRNKWGurwvnl/VovujVCUXGUsX/3Xo6Hgrx
    I2p1R3X0kIdaXxGzKdqAMLaFqWBFyZ3rb5cA0gA66+8fxgGFgw6lv1hvDZftxW9seaSYmR
    zYXgHFltG4U7DZTz9K9t16fsniCiW5hO6QSumcP4exwyMRjSN5HrfOIqCmHgPyq6Xhogso
    TbhxyrYQXa1nBHaiIUOCzqqdx8YlpfijsMseeQ93rkt7KQR7lS3IdKN7Z4V2E/jI+yXzMH
    mgpZYYRkixssjbYhuSVCQtqyhPUa5YeHavcLcc3Z7jzofSug8l4tiHg8ZIiLIEEX+DY3vp
    gsQIB7XcpZPDp1o840NUHyXsdGkD5CYkTLzsnLS5AproRRMvC/slUOAIW9Z3PloK4dwvAM
    KwXAaY6kGA0hmW7IHMB8tQAZ32GHM7iAY4MBxvVrDm/uajWMwe8Z7cygb96A
X-ME-Proxy: <xmx:jqw5ao3Lm1uWttAqIB7geMqamjh_FjTYPImxRkj3-6tPLlUKySbDsw>
    <xmx:jqw5agMWSBuTOIawy6nSrN3bPfcYRseBjBiMTsToky9czGOY5R5ilw>
    <xmx:jqw5av5qOEqYEJBDJBnpaOhQN0P0DyrZ5CB49nK11V3vZkACFFJuiw>
    <xmx:jqw5ai0Kh4bx_jX6NsVOnD8D8Ot5OP812PeGfk7DAYnvA9iGGqN-Aw>
    <xmx:jqw5agFAakX7dxkRF2Tu_fLJWy1W3gKqOSs99OTqY_RrQDR36ai342VL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 17:43:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 2/2] status: improve rebase todo list parsing
In-Reply-To: <b3514e9b1c9515bf1a7f7983b9f120d63edba97f.1782117361.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Mon, 22 Jun 2026 09:36:04 +0100")
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
	<cover.1782117361.git.phillip.wood@dunelm.org.uk>
	<b3514e9b1c9515bf1a7f7983b9f120d63edba97f.1782117361.git.phillip.wood@dunelm.org.uk>
Date: Mon, 22 Jun 2026 14:43:40 -0700
Message-ID: <xmqq8q86s12r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> +	if (!sequencer_parse_todo_command((const char**)&p, &cmd))

Style.  Missing SP between "char" and "**".


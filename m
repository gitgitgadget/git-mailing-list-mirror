Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DC925A645
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 04:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791174453; cv=none; b=RNUes7UAbXnu9uaTri6tTy6cVWjZrQ30yiNWur0YcgxaF4cf7Xr/k9SYaelZLTX6q6onqY8ZKICn9m4yZz8WnqdFNpWiXOAIbYutT7UabtNF6TDMfAuzBFwG/cvntTg1mLVqZir23RAFpD5okGrprHjS74iSVM7lKiT5kG35WNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791174453; c=relaxed/simple;
	bh=AwH03RWwdF87EEF0uYKwO6bGxDLBZS2kSH0017JTN8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bkbMZozy3ISx5xZ7YouYY+CatCU2NZWYvIbPehyzOq1eusbUpdG5qelbtPaczZOOaNrIDqLO9kqMLPSXPRiHLSZaoFQG5U7eXJiqH4EkSJmskvGhjKKCnY5dvlAlH0cJTVKU1Rakz99ZWmD+z2AezpQGFVjLyC8QRI7KBYK2Vdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gJMEaZ36; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QmlsrSIE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gJMEaZ36";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QmlsrSIE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DB3D8EC03BF
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 00:27:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 05 Oct 2026 00:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791174449; x=1791260849; bh=hC+D1rpBwE
	EryHEGgSybpl2LHQbqTE3PdU668H9i7wI=; b=gJMEaZ366ZuGmKPOmW96tNlyLl
	KkUg4GfaRyx0RgcM9P10MeprAtdsMiEIwI7KH7hMsyKHg87qvQKzIPk7J5P24oLD
	zEiPpDKvvAHOFBRQBwMUy5Od/LyA0FfjGnbH2uvT0s9Cko65QXlxElODJKrYE2kR
	qFH1VfEaJZVdj38CFoAVa7iJ1+qMH7SuyMlfLRoosKX+WoVWP1dPbUMPCNvma3Eu
	agMawrTDpFV87QWmEXX2uC8DHPkYBI8x1x77ILfTOqGXegfGp9EFgsETI1aEh5ta
	JasRft763TIzhxUX31QvYqHUdRU6rXethWp4MCI7cVg7wiYntH5gA5eYu4WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791174449; x=1791260849; bh=hC+D1rpBwEEryHEGgSybpl2LHQbqTE3PdU6
	68H9i7wI=; b=QmlsrSIEVGasKxvDwiScmAOCIRg/lU/yf73jdSVLtMe0rbi9ynK
	DdOVP3mggJWTgdwLrRt2YNxZEDK0lvwI5SIlPZFv1p9fnz4eyH2H8bTBIENDrFIF
	YjjXICqfgL2ijOQlneavn57XRXKBd6HhHZ7stjS9UfMgj9GClhNQPUYhZpzhe9w8
	5/J4JFdUa7kESsgU4gI1wvfxVYZ0b5MMsdBJQjg0Y7WnjRELdDL32wBG/l6/gwcF
	Xv9u1ndg15qqD0JGOTf8tqiUXXttHDdH/qxECVyxsiMt3/JqKoOzdJg7H/WiomZx
	ENPX+XrLxJYIISmiiS2FcCO2bPQYvAFEpAg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791174449; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:fyjHLpUxt1jOgrt6kW1Q/NTTiFSOPCE3AYWJw2lnjeNtg/T
	359Ep7NI1w8K29qpMgYAXQ4vcUNB6FaiXmAPOA7OorQ9bFWKYcYvG5N9IPpF43aw
	Xzs1CNhupdExNu3NRRgz1W72BykauXZkdRRxFC7xbzIO1BqPZ26aHedvHAqdfX33
	HD2ggJjanexXgl4irilnt2cYkJYE6JrL76QF1GsdjVWLL+D6LtFsgY7av6qXs1T9
	MuOv2e2VqBCtu+CxGzH2kipZ7IP4v4hfVcs+Be8IBJvnZYR5hlfQxvSfHNebYe20
	KlumMYdzg5srkNYCYkRUoF5NEgg+4pWljKDtEvQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QB0X4hJ1h+ZsXvNuP7tcgpDOlTgZUGcMoXNBKSUj5PA=:AwH03RWwdF87EEF0uYKwO6bGxDLBZS2kSH0017JTN8w=;
X-ME-Sender: <xms:MSfDar9rblMvmKtKHqH1F48AqpUUXNFdOXkUE3uf2hN8OcOnLhkkbA>
    <xme:MSfDahDq0pTTjto1hHkv0K9Fjk7kgb21SOs6qvI9zPLheN5FmSevGuNSz7uTF8dFr
    smOWA6zyzGsEGTzFkRhUL-cxcpWEBsWzjSqzGuq-R5rDiTZu7lYVIg>
X-ME-Received: <xmr:MSfDagTYTemzW0RW-API5600MsrS-UstFeGJPmZC-2ACgp8j6pLaq_jlo06Uts8UChK-aSDRjaGp6CYNw5k7_ln8sVWps72CjmZv>
X-ME-Proxy-Cause: dmFkZTGPbvtmFcuDHJj6fE/Rku/dXWNlMR0RiAZATkrjNUF5FDA2cAwpBobErdSiH/VIjG
    lmZipPTdI4zlkFOTThthDczifLqK8pMeb7++IRoM6aEds/MVn/wlUUww9lB+ZgEgKVSI7l
    yNenb/VkE+7NgJw1MUy1eZdUgmtTTl83bpQW5vMoInE0c/OnuwN8EHh21CZ+YwuhjqFcu3
    ChP4gPqtxTYiLmEYUJXo96Ovud+e59RPXSKpf4WbennN+2Bku7Mc7ipBA6jzG+ScULCtHm
    8Va7zhe3+NULG1e+jaHW3q9QWF/huQfWadJLMU2PNYOB3YtcOF3dKwlxJ9DAgEaE3Milfg
    iwT6Evs2pSGj6bZm1duLqtmNP1VkMhrJF4mPhkCSlKHDy5NQ7LGTAkQzHGvVr1Fir4QT/P
    hpC+VWx08EWuw5Blf5NVA/XkaxRMJnzHm4MIwJJNim1GuudgZ0dwFJgaXxjqg6vGL5FRWC
    uqt6B6Oztpo+1Jzfl4i3mZWH9sUMItG0mniLo5ecUEyYkSENLdEqu9TzlbeFIr8ctL1ls/
    6sBaMA4ThJ+cTh5yBNbOyi7g/a8z0a8UE7VbRMf1ClKB6KbgOSeDnK3X1kbN0kZx/h4tpa
    KZO1TL6v9uzsfn1W0wKoPqlHimF7sq3aj+xmUiNpdGklyNvfi+s5ASm/5Cow
X-ME-Proxy: <xmx:MSfDaouwGHGwgECIhS_mNAExwSxgBv2VjAyDlGPmAn07MbHhme_EWQ>
    <xmx:MSfDas2DTK4qtLu1Vbi0yS0NTq55fzGmwRkKzqhJinO5S4nur26XUA>
    <xmx:MSfDapVQyDr7Zb6w-jt6yFXIOmwzhJW6iFO7wdTdLWVyvzAxv2IRiw>
    <xmx:MSfDanIJUGoKEdLvOo22eIlGk4muT6tOvlLoYgWm9CDEwdpW4ZEesw>
    <xmx:MSfDalGd7M0GScxIeQuE-eyNrPpz0KC-etZkBtbcOzU3VfmzKJO62Gie>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 00:27:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  phillip.wood@dunelm.org.uk,
  Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] branch: let --delete-merged default to every upstream
In-Reply-To: <79a242b0-ea1a-40d0-b1d2-8ef029fb0521@gmail.com> (Phillip Wood's
	message of "Sun, 4 Oct 2026 19:42:56 +0100")
References: <pull.2428.git.git.1790960147943.gitgitgadget@gmail.com>
	<ae47baff-daaa-4b78-97e9-94faebb8e694@gmail.com>
	<CAHwyqnXN=DZ_EzfTfxZ_==8HS7zX25NKoQw58Ou6HZELP_n+Qg@mail.gmail.com>
	<79a242b0-ea1a-40d0-b1d2-8ef029fb0521@gmail.com>
Date: Sun, 04 Oct 2026 21:27:27 -0700
Message-ID: <xmqqld8cpya8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... it is helpful to think about what we can do to try and avoid design 
> mistakes and feel that spending a bit more time discussing things and a 
> bit less time re-rolling patches would help. I also think that would 
> likely end up with things getting merged sooner ...

I share the sentiment on both counts, even though I do not have a
ready reference/example to point at.  Thanks for pointing it out.


Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACD73DFC7E
	for <git@vger.kernel.org>; Thu, 28 May 2026 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973896; cv=none; b=JJ881oZgUXx/us3pZLjJTr3TPQe6rp83pEZ+ZM8qdngOcM1zqrnMZm6IGne+83T1+feeWJyq4HHuBc/IGvmmx35GyoKVs7fCeJrvV6G6Dpc/JCCbUxZ5tmixrhYgL+hOISSjT6TmNwOwPmB8K5oB31mDyh5W2+exH7y6aVzlN9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973896; c=relaxed/simple;
	bh=0sNmDx91YkcwuN+bRDZ4gccAJTqVP4ODLYpPdUldVFY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l69NeJYbbzecYEvNguNWUFS524/6UBG6AjIuw9vHJNyU8gR4hjMYB/gVJmDbsbG2wRri6iT/czV0LNrbOYRU7YmB+zZhGFnHyxKZ3Yn/mfB7duKYjbR9KYyqjy0p/+XqgeOJEFPvEwgkhpaIqPIvmyeCqSq+vifwBkevMO+JAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=MaxkBjiU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="MaxkBjiU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779973886; x=1780578686;
	i=johannes.schindelin@gmx.de;
	bh=4xAJVqzB3AfYe2BZqNhjyd1z91Qjuc9bwOoaBn2EktM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MaxkBjiUwgWXKO5vxhSMxM1ylW0IgHphvVLPKQQgu56w4wQKdq4MBG92lKH0/miz
	 hTt+rwVALdL84WFs0PhGZQxXWqh9P2ohyvzOJthJoIluyqv5IqhVvfcJpPEgasIU8
	 Giw/zd1OQmKlhmLrw1czLMfNvGRB6NQkJnPJ1PQ3n4q+IexQOki582rav7oTQx0fx
	 8Kvx1bZo6OonzWl7OaL9/wLof1BgF3m0KIHW7h6KA2kfyD5bGvD9Bl/2MBXKUsLAe
	 TRU5kntxYVXrkzgwWP/AaHyAjQoMcBo75e4GtpcSfntAYfKgPcmqLnr+V5v2vY7zO
	 z0xaRzZqf1Q2pwu3sA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMfc-1wY21K1spA-00CWGQ; Thu, 28
 May 2026 15:11:26 +0200
Date: Thu, 28 May 2026 15:11:24 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Siddh Raman Pant <siddh.raman.pant@oracle.com>, 
    Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, 
    Kristoffer Haugsbakk <code@khaugsbakk.name>, 
    Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] compat/mingw: Allow SIGKILL to kill in mingw_kill.
In-Reply-To: <xmqqwlwwt0mj.fsf@gitster.g>
Message-ID: <7c0384e2-0d8c-17f2-9881-cf14b24c0a21@gmx.de>
References: <20260522061652.50078-1-siddh.raman.pant@oracle.com> <xmqqwlwwt0mj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iKfe+EkFYObuZ5j7NaNRdzdpQj9PJ+3cHPdwcz6btQCShCm7oyt
 QkP89A9fN5IoxkNO0oQ00zoe+JPwg/BLptYcjl/qoCzndmVAIH+/woCtUT9YQwokLx4NA+s
 GIGOHtK2Hzwxd0sl6AB9jM0IDXDE4Gpw4IRnneENKPDfxjbRbrIt340fOp7DXzMqruy3Khi
 ucS/5sKPBQedGimofsaeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xP2srxpWJY8=;C79ka+achIMquulvHzc+ppRCJnT
 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
 dAbzGOpt5EclsL3bMYhPz2PcAK8=
Content-Transfer-Encoding: quoted-printable

Hi Junio & Siddh,

On Fri, 22 May 2026, Junio C Hamano wrote:

> Siddh Raman Pant <siddh.raman.pant@oracle.com> writes:
>=20
> > mingw_kill() only allows SIGTERM for killing a process.
> >
> > Let's also allow the natural SIGKILL for the same so that callers don'=
t
> > have to do ifdef soup for special Windows handling.
>
> [...]
>=20
> The current code only handles TERM (to terminate) or 0 (to probe)
> and everything else results in EINVAL, so the updated behaviour is
> to pretend as if TERM is sent and do whatever PROCESS_TERMINATE
> does, instead of doing nothing and erroring with EINVAL.  Which does
> sound like an improvement over the status quo.
>=20
> What I am wondering is if there are different kind of "kill" in the
> Windows land, just like there are distinction between TERM and KILL.
> For example, the program ought to be able to block TERM but not
> KILL.  There are other termination-inducing signals like SIGQUIT but
> until we start using them in our code, this emulation layer does not
> have to know about them, I think.

The version that that Git for Windows carries is actually really
different. For one, it gives processes a chance to run their `atexit()`
handlers when being terminated via `SIGTERM`.

I'm afraid that the patch under discussion would severely conflict with
Git for Windows' code. Git for Windows' code, that is, that should have
been upstreamed a long time ago, but wasn't, out of time constraints.

I'll try to polish the patches and upstream them.

Ciao,
Johannes

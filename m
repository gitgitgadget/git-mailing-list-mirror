Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70712389106
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282212; cv=none; b=DZ+wT6iQYCnZZX7KEov4t4V5rhchPVksGC6MA/Ie1oBdo2T2VlItFJqiiE3CYrR23b94Stgihkv1MdOjw5kj9hx+tRxq034ETJA5uEXj8jIDHxHxdyD+mHpfr7oaaM7qqWpOeDEfZcs12uZpgixfL3GdNdePAY4cJNhoyNiEsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282212; c=relaxed/simple;
	bh=ICNf2DsTd6xv4wAu+WqgUTWaTk796UQYOKoVbZbgIJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X4b8gdJwnt/NdL1XuOZCUDXItTOHm0iZxteFAxpSo+vdN4jlexbNORnE6bH/INaU2qztJsHuY68SXtyqxm0LkWgy+Mh6OlXerevxYkYry3B+6HIaFarTWXXT6D6fE+nVBNoK8P74YtONBZUSyuLhAmbxx570K/8BmqgzeYduliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xzLrNzam; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=STHwtF99; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xzLrNzam";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="STHwtF99"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7374A1D000CF;
	Tue,  1 Sep 2026 13:03:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 01 Sep 2026 13:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788282209; x=1788368609; bh=WCvbo2im8r
	HpcWvySi8FK0RX8G06miJRAjx00PKj3WM=; b=xzLrNzam0pM6kvj7Ak22EPwmtx
	PMWBo4cmdoQKjZjP6VLJuVGF6/UiZnTb1e8bC2jnqVeNZGBW8C5k11mg2bXMc8us
	C5wA1Lbap157D5SjNfr3gzKF5dvYlU7690ynQJVRkOv1LfGmxf5MqpXQsgUd+Sk9
	C6d5VcPiM1p923keQdLo/kuC2zthRXr3bZmHtwYEvZkAWgSWkAWspCQb8jYP8VMl
	w5s+A0h7xF0TwrNo57GVem30FDkaieJgMfeHN1sn4hh51TpkdP0n8tn2UNQqabOt
	7OnlRZDFG0DgnQcB51ddQ6P7kpnwZnww19B7Rko3irJt6cpUkkQXThVrVOeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788282209; x=1788368609; bh=WCvbo2im8rHpcWvySi8FK0RX8G06miJRAjx
	00PKj3WM=; b=STHwtF99sVKGNKo8jGyrwpJONQA4g7kmlwUDsGEttwCuKwFHopD
	mNRtxV/wyVwLBRxVcRXHKfFPqjYakyztO2GffYSLZMwAGIUMX6jlyIN3brGSoqNl
	+bb18/04Byv/UslUFjo7B/6OLmkRSx6x7B++I9qsT/wSO6y47jqIWGZFx2x6pqQK
	L+QZOksyL9a5T2WSe4AiTfCLNRNSqlV4dsaEgalpaQ9Kxv01KNFvWXfd4nlcgaJi
	z8P61Zea0pi2eQQN2EDExXkG2u3L2z3Rfc2n1OGm94R/C5gE7tbA+g6BscMeunkL
	mk+Gwbl/WnF78djP6BEifAsX1S7XSjIHoqQ==
X-ME-Sender: <xms:YAWXarRPRo2bet5ZgaB4CsdNgdKLto-uw5CLbkTbJ5ZHPhjjUzyy0w>
    <xme:YAWXatcVK3PJiL5DqGhx6ODibc95wAPtL3lXuHTUj67qe_ww355_caGae5rU4X9J5
    Jsp2NPlXnX3D7NHdzu84S57KcIBapdn6Hp5Qz4lBicuEt3wW_0W5Pk>
X-ME-Received: <xmr:YAWXavBK4JqSt_rEdwHLH8kKMco_u_tqZbYsFxcbgiLTHe8YJQ0tC2dBXkgp8dB8uuDnszjNAF7S5q-X-vRB1TsDjuvgH9-xUA>
X-ME-Proxy-Cause: dmFkZTFSWNtBsGf3KvLi7vcTO2ntiBSeXh8GlFwvxmK/HQwmgl3w/SdqPa746hEhi3Mk1S
    d13pQRNgrTyB2pxWtrcoz1ZuZQ7o1QsePC9FIjmLmfVvY/Bg5TLkIC2GMzYDGrb6lOUwC5
    DI8dywY3A44477N+Pq3loKYe1RTDgL3ScrYgcBNI3tWxLpafuNUNXeX98lw3+xrkIbEn/w
    orlqwfgtKdkWzSNGiGAhTVfAaUhhlXcQp+lLiVKN6bGuApWwOR4o/yUjGsxiPf/7WDzneO
    xoQcdNtf8D/z7Uh3S4jKa4Dl1Pk2M2hy7g3WJpUp5xwuPiveEDYPWKGn1ac1rM3Qu+6pi0
    bVSU7TY44JN8Sdh/hwyql6l3ZVDx8OVDrw/iUej4FFEPR/MvwImwyuw9FyA/demGRBjMB8
    lcXaXfwDfzu3vqyFs5bqGBvYFPF7yzDScueqsMzvjhC5DoH1i180vuYNgAZFAIuNRNDJUW
    1Sor7xJeft+mwA6tJeEpLTJQADjFfPfggFOPz76ZmuUhaLQqplt9rX+RJKW33Ogrd1Nket
    fcbLBBlIdycRlzUWceSKyKKP78yy3yKPIx7gg1myIb3NsZbuaFkoU3iHgZKXLl8wd6tWjn
    LlqCGJ8U7kGspGbD4dx//w6vSxMCzQLIYZcE59HcUP3UpLQYgw6t8LxIOdbg
X-ME-Proxy: <xmx:YAWXavnnYPzvBN4A6Bb73WPMSiE90B9olJpcepw5Mcwf4QY-Ca8h0g>
    <xmx:YAWXaqfWEsEs7CCopPnqTr_kvLBuqGRcxZ9J_t8boYed88CvjHEswQ>
    <xmx:YAWXajRqPGSjAg1lhGploJnLpvgWY1PXsqTK6huQrERT-xVF4d3H7g>
    <xmx:YAWXahuuoIjwxGTadMP3XrtNIcpqqI75TTLdHBg9XrooWpBTs0xdKQ>
    <xmx:YQWXatsGsBLmtKqxgUK7cWu1jCKW_QO3hHKCGlP3Logyoui8iAHD5-Yt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 13:03:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 3/3] hook: introduce the receive-report hook
In-Reply-To: <20260901-758-introduce-hook-v5-3-35cdc6be3cc1@gmail.com>
	(Karthik Nayak's message of "Tue, 01 Sep 2026 17:19:25 +0200")
References: <20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com>
	<20260901-758-introduce-hook-v5-3-35cdc6be3cc1@gmail.com>
Date: Tue, 01 Sep 2026 10:03:26 -0700
Message-ID: <xmqq4ig8uco1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> We cannot use any of the existing hooks as:
>
>   - The pre-receive hook runs too early, as we haven't updated
>     references at that point yet and we need to have the full view of
>     all resulting updates (both objects and references).
>
>   - The update hook is too inefficient as it runs once per reference,
>     and we cannot trivially determine the last update.
>
>   - The reference-transaction hook cannot be used by us because we care
>     about the phase where it was committed already. And while the hook
>     fires in that phase, it does not allow the caller to modify the
>     result in any capacity.

Here you explain that the reason this is not suited for your use
case is because it does not allow the caller to modify the result.
The transaction hook is notified in what phase of the reference
updates we are in, and what updates are planned or have happened.
But the hook cannot interfere to change the outcome (except it can
make the transaction abort as a whole in preparation phases).

>   - The post-receive and post-update hooks cannot be used as they run
>     too late, at the point where we have already reported success to the
>     client.
>
> Introduce a new 'receive-report' hook. The hook receives the complete
> pkt-line encoded status report on standard input, after all ref updates
> have been applied to the repository by execute_commands() but before the
> report is sent to the client. See linkgit:gitprotocol-pack[5] details on
> the protocol structure.
>
> The hook's stdout fully replaces the report sent to the client.
> receive-pack fully buffers the hook's stdout before acting on the exit
> status, so the exit code is known before the client receives anything.
> This gives two distinct behaviors depending on exit status:
>
> - Exit 0: the hook's stdout is used as the report. The hook can
>   rewrite 'ok' lines to 'ng' lines to signal per-ref rejection to the
>   client while receive-pack itself exits cleanly. The client marks
>   rejected refs as '[remote rejected]' and exits with a non-zero
>   status if any ref is 'ng'.
>
> - Non-zero exit: the hook's stdout is discarded, receive-pack modifies
>   all references to be rejected with a 'receive-report hook failed'
>   error.

And the new hook lets you pretend to the other side of the
connection that ref updates that happened on our side is totally
different from what actually happened, but ...

> In both cases, any output the hook writes to standard error is
> forwarded to the client over the sideband channel and appears as
> 'remote:' lines on the client terminal. Writing to stderr alone does
> not affect the push outcome.
>
> Note that in either failure mode, ref updates already applied by
> execute_commands() are not rolled back. The hook can cause the client
> to perceive the push as failed, but cannot undo server-side changes.

... it still cannot interfere to change the outcome.  What has been
committed as reference updates have happened and there is no way to
change it.  So the reason to reject reference-transaction hook seems
a bit weak.  The explanation I heard so far makes it sound as if it
is an equally viable, if not even more viable, alternative to teach
the reference-transaction hook at the commit phase to optionally
allow rejecting the transaction, instead of adding an entirely
different hook (note: I am not suggesting it as an alternative; I am
just saying that the explanation is weak to support this design).

In any case, if the actual ref updates and the reported ref updates
result can be made different, somebody then needs to step in and
reconcile the inconsistencies, no?

The way pusher perceives the state of their remote repository they
just pushed to, which they learn from the output of receive-report
hook, would have no link to reality when this hook is used on the
remote side.  This may matter because the "git push" updates its own
remote-tracking branches to match what the remote says (i.e.,
pretends as if "git push" was immediately followed by "git fetch" to
the same remote).


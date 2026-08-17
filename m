Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6B37F8A5
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994976; cv=none; b=fUSzDX60P0FPV/TmffMiukIczBSBRzFwUzUGjykUhnB+50quhDfNGyTZzOJPxwkoF4GuItcEftMgAexT/3zNifa6ETT9WfLQIQ8NPD1WL9Uv34z6Cy2N7FLlqY/2ZRfwfYxXhcr5mcAdcLr6iAFFPE5ePwJUOapEsK5cjd6Nlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994976; c=relaxed/simple;
	bh=rz1cwgARTK8CTMM/Su4u5uxXCOn7JyKER/xfMLH3v08=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=W4OIA/0d4IjBxluBYwH2WIdgJPapzz98OudpUiONsl+kQ9chynKdVFyQ5CZqUqkFD1EhysLl8rwdMNCTLASP1TftQgHaXLmu00j2ePRpa/87IDlhw6TvjgNccm5xSZm+m6IrwbDrsDw0Mb2gY/b8nzsHNHRurA+qYYKDxxnKIo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lengemann.net; spf=pass smtp.mailfrom=lengemann.net; dkim=pass (2048-bit key) header.d=lengemann.net header.i=@lengemann.net header.b=fd3Bmpyp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lku9fye4; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lengemann.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lengemann.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lengemann.net header.i=@lengemann.net header.b="fd3Bmpyp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lku9fye4"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 190D6EC0281;
	Mon, 17 Aug 2026 15:29:31 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-02.internal (MEProxy); Mon, 17 Aug 2026 15:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lengemann.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1786994970; x=1787081370; bh=NgWIVnfD8wPB0x93eGBpCeombHcyNZHd
	+5hJ5FNyfcw=; b=fd3BmpypxnBgpPakupCR3K14YHhSzjN0YeKhgYwLATD17n6i
	ZdnlEn6I7fMDGQB5/LAb2E7Sn4aFy8dhH5B+z9avMINyeeyj1lrjmqwy5D+67CfT
	4vj/jPvbNIJa0Zh9P1AY91RKkR0OS4zC09GJS4jan6g8M0kHD1u9OLitorpasJ61
	d0iNmOb7I/mFt96ZyhK1LGCE1zxXuNa60qAcHnJMEhhJhvZAGs29LTy0/3uPycBs
	+zcvQWp6qK4B+mLpEEtC1nNzbAx7RtBNTrP8h/0+yZzs9QR75jqkKrDC01P3QSbp
	eHTZfiqxzRfAEdM36ZaZBTcckCDvGO4sHU33WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786994970; x=
	1787081370; bh=NgWIVnfD8wPB0x93eGBpCeombHcyNZHd+5hJ5FNyfcw=; b=l
	ku9fye45iFNBI+ev7tFXZKOy+imersRTxXx6h4TRwU0344bgFvQzEBTr+gmrKw8H
	8daYpRqsfpbHv242HH8dK8zglWWvpgBfxJzI8hhmB1tKPL2gGkjMtkDZGy7zO7ET
	T+/S0uMGjhkYIQSYG40zlz0BZIFORNvH1gc2BqLSyUsy6mJSY/vIT91zF4jsfB8g
	cI+9tBv2Ug9oqe0tqooiQwMh1HwYNfUZTZGweW+IhkKHrhcob7GMGMo0xyvsrcMp
	quc++vp0Z05Lj6FtFgkDtyEUa+fEEcymEOt6lejOhanpQMhw9N+zjy7F/R809ZTZ
	txsXkEI1oMDmjlneWeLOg==
X-ME-Sender: <xms:F2GDaihrMpyPKQ7ej6p6rcAiHEmRB8TtUUu3KwIYRXcXGqws7FiXtw>
    <xme:F2GDat1jLCK--PQUPvdNE5QtJwY3wwYUSpxxre8SxPL3pbRPVBcYN4_Airo69UosK
    Uw3mdqiXzvAOzaN_yyFiLic-4SVungQb7tlFCehw_yPUp35UjV5XIk>
X-ME-Proxy-Cause: dmFkZTFJPuFSrOQRFQi6Xk7zbkjGu/NoG3kVVI37BwBbFgX53EXZNF+N4hWDJJi1WtM+do
    dRHjEuz6qso9fzgsZSTgDyYxYYn8b8wLeghp4QIT/5awJx+tpSH35E7pFBkcmdOq0/J2+K
    E4DJrQ/zBI1BZ7IW965ZodBtaENepJ5SYTVu9MAC0nGSRgdZMnDR3feMZXj7wELHzEXfFz
    KTuAp8m5Nxri0MbIi+4/8x1pQx71rCdsiP4bGuY+6rJIRlRsaPNmrXWj3M/cP6Jr0BQA9O
    KXu6mtzeoDQkCCywQnnzITSH29sSXLj1rubNBGctP77UD10YGG23rVMJHEbR420AcEoSDk
    IeD8wGl0aJbqjkeYEwY4aaiPVbqtDlsXjvexB7mWeTmyisVZ3SfEQ2z4DDK4kcEnXqeV6c
    KnxyiUoaWcPI9zrX/tVq4rea1GvXaYyt/rTM4kpotqzCHpCQaq4+pBcZ0lZ5C18TiHnaKB
    eRZROHOy0IJE7K0MIJ/YfGYU/RK3mlreihg22LnO8+AKdKf1JZkY2hRCssuChxcJjTU3PI
    dc3pVddPT+9rrIVF9/KoZOrImGWiupCtWkFrfro6vT+58TdmTCtKDdRATWu8et8L86EjaF
    b11vYUlOKxj6OEY0wnOfspLvKaxovKyrYh5kol3jNd/TdkLPGmSldtmj9lqg
X-ME-Proxy: <xmx:GGGDalLSYIJn2v7fg5ro095Ia-5SF-xEiMPFccocS-ep_xm1RdMi-g>
    <xmx:GGGDau9G51gkZ_vKzHTr-W4XW0SjDpFIseIRIbfLwhBoAEpwJJS7Jw>
    <xmx:GGGDaoIjyfe_WT4BypVV1hfZDttvaWiWBrk1bNS4klIxxhdYbDg76w>
    <xmx:GGGDajk4-fx6rbSKO7wXlCVjtS7kHGcUU9-kpa3xC0IBhEg-huM1mQ>
    <xmx:GmGDaovYuXRzXS6iyLiyfhRetNhiXLdbg5rUC7RR9XHmK72WptiK_TQ2>
Feedback-ID: i6aa14946:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1759C22C0075; Mon, 17 Aug 2026 15:29:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqhX4vTKywgV
Date: Mon, 17 Aug 2026 21:29:05 +0200
From: "Lutz Lengemann" <lutz@lengemann.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Lutz Lengemann" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <a6a9fe7c-e46d-462f-b3b0-7ae6c2d52fe4@app.fastmail.com>
In-Reply-To: 
 <CALnO6CB1vJ7RtBzTUSJSfYtfH+W2MZCFEkqNWeBXbWJ2r3Pdyg@mail.gmail.com>
References: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
 <CALnO6CD9P4+e=YPdKaLfSBOk-H3_ir64pBP-qMKNNvzUNqunXQ@mail.gmail.com>
 <CALnO6CB1vJ7RtBzTUSJSfYtfH+W2MZCFEkqNWeBXbWJ2r3Pdyg@mail.gmail.com>
Subject: Re: [PATCH] completion: zsh: support completion after "git -C <path>"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ben

(Resending, my earlier reply was rejected by the list for being HTML.)

On Wed, Jul 15, 2026, at 00:34, D. Ben Knoble wrote:
> Any progress here? I just found my local copy of this patch and was
> briefly surprised to see it hadn't graduated anywhere (until I
> realized conversation had stalled at this point).

Sorry for the very late reply, I was on holiday and then other life
things got in the way of answering :(  I do have a v2 ready, which I
have just pushed to my fork, and which follows this message.

Junio C Hamano <gitster@pobox.com> writes:

> Doesn't it want to do something similar to what __git_main in
> git-completion.bash does at the beginning, namely, this part?

It does, thanks.  v2 no longer skips only leading -C options, but walks
the words in front of the command and skips over the global options and,
where they take one, their arguments, like __git_main does.

That also makes "git -p checkout <TAB>" and "git --git-dir=<path>
checkout <TAB>" complete the arguments of the command, which they did
not before.

Two related gaps are left alone, as they are bugs in the _arguments
specification rather than in the command lookup: -c is not listed there
at all, and --git-dir and friends are spelled "--git-dir=-", which
accepts only "--git-dir=<path>", not the "--git-dir <path>" form.  I can
send patches for those separately.

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> But we mark these local, so how do they propagate to the other
> functions?

zsh scoping is dynamic, not lexical, so a variable declared "local" in
__git_zsh_main is visible in the functions that are called from it, the
bash helpers included.  That is how __git_dir and __git_cmd_idx are
handed down already, and __git_C_args works the same way.

> We should probably note in the log message that the _directories
> completion will not account for previous -C

I added a note about this in the log message.

> I think we could do _slightly_ better by using a state "->dir" or
> something, accumulating the current prefix, and passing that to
> _directories as a prefix with -W

I tried that and it works, but it changes what -C offers, which is more
than fixing the completion after -C, so I left it out; happy to send it
on top.  Two things to watch out for there: the accumulated path has to
be made absolute, as -W with ".." gave me the directories of "/", and
the accumulation has to stop before the word that is being completed.

> By the way, I've realized that "git -<tab>" has the same problem (a
> giant list of files after the other option completions)

That one is older than this patch: the file listing comes from the
fallback at the end of _git,

	let _ret && _default && _ret=0

which is where the "use-compctl" and "globbed-files" tags in your
_complete_help dump come from.  I could not reproduce the repeated
description block with "zsh -f" and only the _complete completer, so
something in my setup or yours may differ there.  Either way it wants
its own topic.

I hope that the change now looks good, and if there is anything I should
still look at just tell me.

Thank you very much
Lutz

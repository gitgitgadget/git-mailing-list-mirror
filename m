Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283231;
	b=ol/iulbN6OS2CaqehznAcZCL74AsnXM8KCNPC3FrU3Wv07mO0nJUiLyNEFvNnVqqDJB7
	 I+PMkfh8tTxQEMr/wC95vNd2kaTeqTdcwcg55C8UGocjLthlFXpaDWuu7ayKrt12h93nw
	 WXbXNgfD0i+1mKJEAYGr64iPCewdzS66t+GbKO9EvHrAJfANyJaLVlr1X41dDR3BmNs69
	 XujC3oJhQFfORInVny5VOdSOtV6JqW2mZHMC5DrSN2OX+ypCEvg8XIfOPpsAv6VSTXKNN
	 lYrol1mPJ1gYUmyCsYMgAsddsUk+9lyH0xE1H0BZDmaoeefOnLdOdHwgB37hPxWk2Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283231;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=rI9Nl1ZRlvvzhtH0grSrahQNCseoQcwaGaA4H0SzSag=;
	b=3LBYQCRwXJ++Isll2oy9RrfDjCyHWomQvhaAke/+UZ3j2GuSNTYMtzHyxT+ZZ1NNMFbE
	 e3AYJdtymAjcoOps0DuJYAh9sjBxincDqyNlgh3m6w9Z7+E9Q+O3VSVa65Kf2gCRDGILp
	 NDKXQJm/xbooaOcSSOtoFywlsTsIObtkI6kiY4OMY/L9R+CDrHvpZeFMbK5OUSKnlGaeJ
	 81O5QI1FthBOemYQMC4KRv0OvuLnz4xXwvPXkziDa+ZaRn/ZJv9/AkhtfaZWUvyRO/y3j
	 qfv2C7RopL3cnRGcfPMHaVgFBzU7pb31cibGGjRkOjAC3Jx8OFQZlY4B1yUsK0U/55g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94EC606A31E
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D94EC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rI
	9Nl1ZRlvvzhtH0grSrahQNCseoQcwaGaA4H0SzSag=; b=NLlaIPhNlTrZwaVpTH
	8kuJ6RmAXT0NpsVzQIy5ervU2eRStGl8dWCe8XpIjEGeOn5JCdm12+Sx0Wyro+Fk
	lA+0dQP98RLdbBptCDDwElSQichYJetX8+upwUoKQBU2URyOjrByDsaPTWR379z8
	vykUD+OtXkMa8xqGokk8MDiVA=
Received: from mbp-home.softshell-mine.ts.net (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgB3ppt0VONq9KUpCw--.34562S2;
	Thu, 29 Oct 2026 22:13:08 +0800 (CST)
From: ian4hu <hu2008yinxiang@163.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	hu2008yinxiang@163.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sigchain: recover from concurrent double-pops of the same signal
Date: Thu, 29 Oct 2026 22:13:08 +0800
Message-ID: <20261029141308.163936-1-hu2008yinxiang@163.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgB3ppt0VONq9KUpCw--.34562S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr47Xr13GFyrJF15tF13urg_yoW8KrWkpF
	Z0qr1qyrZ7GFyxuFyDZa18GF4fArZ3uFs8Gr98G348A3y5Ww4SkrySya1YvFW5Ars7W3Wj
	vFsY934DJFWDtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRpBTbUUUUU=
X-CM-SenderInfo: dkxsiigy1l05pldqwqqrwthudrp/xtbC7RXFX2rjVHU+mwAA3v

Hi Phillip,

Thanks for the follow-up.  All three points make sense; let me
confirm what I plan to do so we are on the same page.

On SIGPIPE: you are right that my wording was wrong.  Blocking is
not ignoring, and the write() fails with EPIPE either way.  What
changes is that the signal is not delivered while it is blocked;
and since a SIGPIPE raised by a write is thread-directed, it stays
pending on the writing thread instead of being picked up by the
main thread.  If that thread never unblocks it, it is never
delivered, so a worker that blocks SIGPIPE simply stops dying of
it.  I left SIGPIPE out precisely to keep the "upstream of a pipe
dies of SIGPIPE" behaviour that common-init.c restores.  The set I
plan to block is SIGINT, SIGHUP, SIGTERM and SIGQUIT.  If you
think SIGPIPE belongs in it too, I will add it.

On the blocking pattern: agreed.  I will block once around the
spawn loop and restore before the join loop, rather than around
each pthread_create(), via a small guard pair

    struct signal_mask_guard guard;

    block_sigchain_signals(&guard);
    for (i = 0; i < nr_threads; i++)
        pthread_create(&t[i], NULL, fn, &data[i]);
    restore_sigchain_signals(&guard);

plus a git_pthread_create() wrapper on top for the single-thread
call sites.  The loops I have in mind are preload_index(),
index-pack, pack-objects, grep, name-hash and the read-cache entry
loader; the fsmonitor--daemon and simple-ipc threads I would leave
alone for now, as they have their own lifecycle and signal
handling.

On sigaction: agreed as well.  The handled signal is deferred by
default, so the remaining hole is a handler being interrupted by
one of the other common signals that share the same handler.  I
will set sa_mask to sigfillset() and save/restore the whole
struct sigaction, so pop() does not clobber the caller's
sa_flags/sa_mask.

The one gap I cannot close is a thread created by library code
rather than by us.  libcurl's threaded resolver is the case I am
aware of, depending on how libcurl is built; I do not know of an
in-tree instance, and I will mention it in the cover letter rather
than claim it is covered.

So I will drop this patch and build the series along those lines.
As you suggested, I will wait a few days for Peff and Junio to
comment before spending much time on it; if nobody objects I will
send the replacement as v2.

Thanks,
ian4hu


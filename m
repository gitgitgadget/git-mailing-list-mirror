Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283372;
	b=NbGptNRMOU9uO3AA6xSqTvcSk247acgmWb5yOLXN0wv9Fj1VMtH8pdD1SCtcoAgY1N+V
	 VWf7iUn4qtZdp8RuT4iaDpbIsCpP1Hy2YObTls7NYzwnOb8IcWiMgr0/3cs7Rwp8Q4a0x
	 +kGZfwINrRT/40hMEIyYC4KkYpn1Q4HiPFgoxIXQqTC213E8OCjgHWRvt5V2CWZNjDK18
	 jX8GgGgNk58mHepNZTXyl9gYeuk1gt+kOL/tgnJdZBTrglYE6/Ee3uSb/HKLUxzhdjYxG
	 fQqXSIrKHzGVDq6gfTJ3asHJieD04Wyimzazre/59OYtC72lE+YBsgiLAB/J8RtF0Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283372;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=rI9Nl1ZRlvvzhtH0grSrahQNCseoQcwaGaA4H0SzSag=;
	b=hKmYrwXZwuPZPSLmj5EVcKjSkT++5vypYamjr/3V1Qg5KkiJnbZj3506ealUwMuTFIgC
	 ywHfPLov6vzGUWAef8thBowxDtm2JnDB9heRVnLkyAaTHJsLL9rWwvDKYmaJH85P5BYs8
	 GrhuSQDh7KqspNd3pPtY6pdXGayTeY3lCc8WBvC0j+RuHtyq+Z9QRipHNabufLxAA5vcc
	 uMejPtaLq13C2OtZP0BqkkNCmcxfcjIi2IJ+KSSY/oCy015GYsyPvmwGEpa9UeSx5qpNN
	 Xru+nwnBbhS38U9on9S3NgjWaoiCTkMsjywZuSqp982i7U1kT5qV8cioEkEXKVMnzXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="J/t3i8h/";
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEC4606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CEC4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=J/t3i8h/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rI
	9Nl1ZRlvvzhtH0grSrahQNCseoQcwaGaA4H0SzSag=; b=J/t3i8h/3Hx/YcDvil
	7UG+SzmBqPTVjoDmVUZT8Y4vmvYR/qwoJ4Or3VHmnFswhNHlamojK0YXDQdDv/H+
	1s+NxMyBx/jAZH2l9WqdgV57QUJUW5jmzNQgyKo2PUKYJzzbBez0Twxd44uQpN4a
	untjJRHhebkAQcIbr/NyhqRgk=
Received: from mbp-home.softshell-mine.ts.net (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCHgJH5VONqe_ApCw--.34741S2;
	Thu, 29 Oct 2026 22:15:21 +0800 (CST)
From: ian4hu <hu2008yinxiang@163.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	hu2008yinxiang@163.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sigchain: recover from concurrent double-pops of the same signal
Date: Thu, 29 Oct 2026 22:15:21 +0800
Message-ID: <20261029141521.164544-1-hu2008yinxiang@163.com>
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
X-CM-TRANSID:QCgvCgCHgJH5VONqe_ApCw--.34741S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr47Xr13GFyrJF15tF13urg_yoW8KrWkpF
	Z0qr1qyrZ7GFyxuFyDZa18GF4fArZ3uFs8Gr98G348A3y5Ww4SkrySya1YvFW5Ars7W3Wj
	vFsY934DJFWDtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRGsj8UUUUU=
X-CM-SenderInfo: dkxsiigy1l05pldqwqqrwthudrp/xtbC7hrmgGrjVPpJmgAA3m

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


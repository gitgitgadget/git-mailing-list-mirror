Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054713699B
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533476; cv=none; b=K4BaMe8INPQoml32e4hA9z+64U5GSEC98fRROLXAch9g6UvgyA6GEQSwm42U2FvGYcmvNhslNy7LKVLb+gdpdJFw9CqjQ7fkz6xIthpBNx4dEi3arAoZjGIyZj4Uime6mt0MOGNcNLBtCHr0QM6C44wgXuJglaFh/xbGLFjshPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533476; c=relaxed/simple;
	bh=XmkTB6jxtXARBaWDG5rPAnVGrArllhsJEigdfU6PNxE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tk4eFUv0JJ1Q52+FQwUeV1BY0tpuiNbCYFW0OuLInjoY0MzNUw5M2iz25c7e1Nco2eoq9O94CI/farkUGMUVPhx8GNaa0Rs6RIifU+HG0S0duxF/dQEvlL1DQB9zoVwR8RnEi1We4ef7RAhRtOXKc9lSMq1e7hNpsb1hl9/NHhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YpwiibLw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SUqSiCGX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YpwiibLw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SUqSiCGX"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6B612138FCFE
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 03:17:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 03:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723533474; x=1723619874; bh=5tYMlbLDwv
	m982XMJggbaMnOEuW6BOecxZBgQpD8Tug=; b=YpwiibLwIX+pIXQYz3CLSmGW04
	5H6vbnihSNRF04wRJ8iPAmBMrfDm8Y3cMPF9xp54p3jqulMhvGcG7DWUGYm0aE3W
	hpK1UrIVUTweSsaX/g+xeM/Mv+3b/t7DePYAL5GEd11EDgFqAgzKrRnD8IZaSkJS
	pj+BO07pNqsZ0DQQ/gbbzg3fdwpR4mwJoj1UEU04d4sP7uh4neFr64IL9Ecu3UCq
	X0KenQO0uqJARzZRhS5z91Vd43pxjmknN/+0TON4onSR1F3Zx3aRrw2hnvLxHQl9
	ZX6WLlmEe4aRSYdylSP339OiWEDiKYYep3tMESJ2BBePjRA24R7jriQrIRwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723533474; x=1723619874; bh=5tYMlbLDwvm982XMJggbaMnOEuW6
	BOecxZBgQpD8Tug=; b=SUqSiCGXFou969r0uGjsZj4EOr4Z5SYYr2TgDzdIk7+W
	SqXvn4XZ5iJrtuXoVnDjONthFUtmgTdC/ChQMERn3RsqthnNyo5bwZSCAgpcamfQ
	VI/QURmNEYBQCF9OryiIRaQn4vAB/Vcls2WPNJ2vu4jM0ZbEYeXiXRkX619Xragk
	zOZGuIxKHzM1K6n2hIlr5GcRsbpq/VN4akqTdWJaQZrpKfAy12Nev7bX6ITzT0sF
	d3NcD7jmUTb7USOA+mkWTnE8rtOkEh6IpMsIyQieImyHTdrQmYGE3rOGu0ssJMA9
	t/ZByYwIWMpmDdXkG7XevX9LofOJ9jOxuWT73aJCUg==
X-ME-Sender: <xms:ogi7ZoSReMbi0eWAfJuBcryC0lEKmtWbC-k7WZPUbWrF8H37V2NUig>
    <xme:ogi7ZlypuLlefeLJdoEfWiMy3dzlnd3PoODOjquHzHhILw-ogc9AwRDejM3jFAHuk
    v64HcR_vvdNtenMBw>
X-ME-Received: <xmr:ogi7Zl0c-dspB80cm0kezyAH88jzrSObcfJAEtIUaqq8nhoeQD4v54CE4HJ1gHLeIJ3JFArJxU6KQHoSTBqf3k89vyqflBxRIWxyM9Y6Ltz57Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ogi7ZsANLImt1ek9gGdhSbfezC4Adhe5QFgzmGSDQPsm0yP7H-_fEw>
    <xmx:ogi7ZhgfYGWg4XtEUGYONbLL4TavN1VqbZ1ZwN87hzh7bgohn-JtlQ>
    <xmx:ogi7Zopp44DkxOED3jxBNRpJaRWFU-vKHigGd2phiE-HEN1Z7qRW3g>
    <xmx:ogi7Zkh9e5t4sXt5bi2gMrrOKXQ8wSfeoknvZ2l7yMZladsiDfq2qg>
    <xmx:ogi7ZhYRT2M0yEAu_yiMoUzaDUyuozDI1mEnQKk7OX6zdSAQn6gjAKwt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 03:17:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da4656e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 07:17:36 +0000 (UTC)
Date: Tue, 13 Aug 2024 09:17:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/7] builtin/gc: stop processing log file on signal
Message-ID: <812c61c9b66d7608e41c6c1d00a6e22e995cef06.1723533091.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723533091.git.ps@pks.im>

When detaching, git-gc(1) will redirect its stderr to a "gc.log" log
file, which is then used to surface errors of a backgrounded process to
the user. To ensure that the file is properly managed on abnormal exit
paths, we install both signal and exit handlers that try to either
commit the underlying lock file or roll it back in case there wasn't any
error.

This logic is severly broken when handling signals though, as we end up
calling all kinds of functions that are not signal safe. This includes
malloc(3P) via `git_path()`, fprintf(3P), fflush(3P) and many more
functions. The consequence can be anything, from deadlocks to crashes.
Unfortunately, we cannot really do much about this without a larger
refactoring.

The least-worst thing we can do is to not set up the signal handler in
the first place. This will still cause us to remove the lockfile, as the
underlying tempfile subsystem already knows to unlink locks when
receiving a signal. But it may cause us to remove the lock even in the
case where it would have contained actual errors, which is a change in
behaviour.

The consequence is that "gc.log" will not be committed, and thus
subsequent calls to `git gc --auto` won't bail out because of this.
Arguably though, it is better to retry garbage collection rather than
having the process run into a potentially-corrupted state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index a93cfa147e..f815557081 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -109,13 +109,6 @@ static void process_log_file_at_exit(void)
 	process_log_file();
 }
 
-static void process_log_file_on_signal(int signo)
-{
-	process_log_file();
-	sigchain_pop(signo);
-	raise(signo);
-}
-
 static int gc_config_is_timestamp_never(const char *var)
 {
 	const char *value;
@@ -807,7 +800,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 					  git_path("gc.log"),
 					  LOCK_DIE_ON_ERROR);
 		dup2(get_lock_file_fd(&log_lock), 2);
-		sigchain_push_common(process_log_file_on_signal);
 		atexit(process_log_file_at_exit);
 	}
 
-- 
2.46.0.46.g406f326d27.dirty


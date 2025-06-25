Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A021E5B6D
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868582; cv=none; b=qI4cX2FwTZT1LQe6oReP+DNg8HztK5j6KyvjPnQjyvOi8ni+GeXhx8MJOHgwK8zI6gJ2XaN9Ayxeg2XiXm+aVu76lj95BzeGc4aGK5LShkuWCiUwJw1/BkeKa2T2a0n9zadzVZJdjeUCQbzg84DkiQkD/nm1Vz9rL0jOYZafz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868582; c=relaxed/simple;
	bh=DEhV2R124cTRlbmEVYhuKtMvALVMOsQj/So/RwshiyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NKx3J1Mzp0ZncU7O9LaKE8Z7x+UYrwbP+xd8L0rIyM66bU/W9ZB6kKbrcqZT4ohAVpgje1Uh7X2aMwr/Nyl+pPAIiEMEI7lpWbz6ohXykSgDN6GqwRrA35zNshFhXxHNB+/lG1tglJaRrUghuvM57Z75J4CHOuRIcYwTuYY3uBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CpNR8fSz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JgdJS7BY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CpNR8fSz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JgdJS7BY"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC053140018E;
	Wed, 25 Jun 2025 12:22:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 25 Jun 2025 12:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750868579; x=1750954979; bh=67m8SwSKrI
	dq9LDRVj8zUF38qZfPq/Q447xphkSk820=; b=CpNR8fSzxDqClSFRiBIgypYDC+
	QK2opCADRqLV7RVaJu4GYNaoNOYkGhaqbt580I5la0S+mjvjBeEyvXiaGEBot6Nr
	gHoCsF0tMakdpPXWXrEcULvy1cwckTOq617bspCG8+4ttja0h+nQXURDw7BIjm5x
	w6jdr1yiTLvkKK6bxu2PMkESzk3ng4uDO3bbppG/6xNo88fQARuB4Auc9XQ5jE+X
	X7sABlNZxMYYsoNlceV154A56+MPDRlTgfrHtmxVN+486c33Zx/dqO8zjPeNRZ1C
	tJUMyMt4AbFCl5tqcR9X982yVUlnYGz3t+ELYbufWcmae7K6rEVE/jA+EPSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750868579; x=1750954979; bh=67m8SwSKrIdq9LDRVj8zUF38qZfPq/Q447x
	phkSk820=; b=JgdJS7BYWHNypzgpZkeftHRj2Tn3SqtFplm1KCWNU6CFDAqWbj6
	j79RNgk+QpmzAtVesbcW9grCyCgyq1C7Qf9mK2AGUQFY5cO9W0kfRXZaAUaSabjJ
	2q7EaBXPVkd7Mbh25w3sZDLFzAVqo2pfSSXLnlQBMbvJgJF6ekqFZId9BQFtlTbB
	InB4Kzz3d1rj6dR/s/8zxWwvOQnuHSTGlwj7G4zEtqTDQfvwRciItGWPIjuIXEnh
	3hVZYkl06T8bwzsKu7QVtbHqysfGsLFjFDLdglEkK8mqmhEqsLOnFoYjNBJ8YkYU
	zxnEqeDQcF71AkIWhd7Cc4j2Isk8OArHZ+g==
X-ME-Sender: <xms:YyJcaKkkFtEmUcOBE64spGumrVESDQnqLkLr-GessDEOUQOdPGzutg>
    <xme:YyJcaB2OH41c-mmqWa33H8ezuIvSe89zSWz2NkMB3vpqgEPIlBu9orbi4mhV92UMn
    OyTdgGRhnjxKS4jtQ>
X-ME-Received: <xmr:YyJcaIroOZDoTiYRTOzlsM8H9LCPMo9lf_W3mnsQZJSu5mLE7uFHuFlzqiZP5pKTSOpmhoWASD-TEw3BL7ykpD6lCAeYSQWqwONPpgc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefueetleeikedujeethfevudeggfetkeetleefffegtdekffduieffuefghfdv
    heenucffohhmrghinhepuggrvghmohhnrdgtfienucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomh
    dprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YyJcaOlqr7-QjdnqdsoPSkR_Vudbxmb7UoXtba-Oz3lk6is1wPQ71w>
    <xmx:YyJcaI2fzRBMu7kWWeFlvmhzMQeiq9-PnSsTDSQ0beiT05vGDxU-KQ>
    <xmx:YyJcaFs5yMFKvtQcvaTbiwAf5IqGspV81dh0b6BzXxZfvWn5coyYUw>
    <xmx:YyJcaEW_SaKxXcgg77NWYDb0GY8PUBxxWKAqk-scPs2feJMboyhScw>
    <xmx:YyJcaPE0mLBU9nEEKp5HTD4JuFPx6xZBxzwD3QyIjfzwtEPvDlFupq5g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 12:22:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,
  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 2/3] daemon: use sigaction() to install child_handler()
In-Reply-To: <xmqqfrfnyff1.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	25 Jun 2025 09:06:10 -0700")
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
	<05d945aa1e546bcc028e215c8e4d174b5e0c32ad.1750836928.git.gitgitgadget@gmail.com>
	<xmqqfrfnyff1.fsf@gitster.g>
Date: Wed, 25 Jun 2025 09:22:58 -0700
Message-ID: <xmqqsejnx02l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Does this #ifndef block with #else lack its #endif probably before
> the service_loop() is defined ...
> ...
> ... around here?
>
> I am wondering if it would make it even cleaner to also define
> rearm_signal_handler() in this "if sigaction() can be used, do this,
> otherwise do that" block, and move the whole thing a bit earlier in
> this file.  That way, the primary code paths do not have to see much
> of the #ifdef conditionals.  With IPV6 related #ifdef noise already
> contaminating the file, it may not be a huge deal, but these crufts
> tend to build up unless we tightly control them with discipline.

Applying this on top of your series would illustrate what I meant.

I didn't spend enough braincycles on the naming issues for the
conditional compilation so I left it as USE_NON_POSIX_SIGNAL even
though I know it has to be fixed before we move forward.

Thanks.

 daemon.c | 81 +++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git c/daemon.c w/daemon.c
index 01337fcfed..8a371518b8 100644
--- c/daemon.c
+++ w/daemon.c
@@ -912,19 +912,54 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 		add_child(&cld, addr, addrlen);
 }
 
-static void child_handler(int signo MAYBE_UNUSED)
+#ifndef USE_NON_POSIX_SIGNAL
+
+static void set_signal_handler(struct sigaction *psa, void (*child_handler)(int))
+{
+	sigemptyset(&psa->sa_mask);
+	psa->sa_flags = SA_NOCLDSTOP | SA_RESTART;
+	psa->sa_handler = child_handler;
+	sigaction(SIGCHLD, psa, NULL);
+}
+
+static void rearm_signal_handler(int signo UNUSED, void (*child_handler)(int) UNUSED)
+{
+}
+
+static void set_sa_restart(struct sigaction *psa, int enable)
+{
+	if (enable)
+		psa->sa_flags |= SA_RESTART;
+	else
+		psa->sa_flags &= ~SA_RESTART;
+	sigaction(SIGCHLD, psa, NULL);
+}
+
+#else
+
+static void set_signal_handler(struct sigaction *psa UNUSED, void (*child_handler)(int))
+{
+	signal(SIGCHLD, child_handler);
+}
+
+static void rearm_signal_handler(int signo, void (*child_handler)(int))
 {
-	/*
-	 * Otherwise empty handler because systemcalls should get interrupted
-	 * upon signal receipt.
-	 */
-#ifdef USE_NON_POSIX_SIGNAL
 	/*
 	 * SysV needs the handler to be rearmed, but this is known
 	 * to trigger infinite recursion crashes at least in AIX.
 	 */
 	signal(signo, child_handler);
+}
+
+static void set_sa_restart(struct sigaction *psa UNUSED, int enable UNUSED)
+{
+}
+
 #endif
+
+static void child_handler(int signo)
+{
+	rearm_signal_handler(signo, child_handler);
 }
 
 static int set_reuse_addr(int sockfd)
@@ -1123,38 +1158,6 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
 	}
 }
 
-#ifndef USE_NON_POSIX_SIGNAL
-
-static void set_signal_handler(struct sigaction *psa)
-{
-	sigemptyset(&psa->sa_mask);
-	psa->sa_flags = SA_NOCLDSTOP | SA_RESTART;
-	psa->sa_handler = child_handler;
-	sigaction(SIGCHLD, psa, NULL);
-}
-
-static void set_sa_restart(struct sigaction *psa, int enable)
-{
-	if (enable)
-		psa->sa_flags |= SA_RESTART;
-	else
-		psa->sa_flags &= ~SA_RESTART;
-	sigaction(SIGCHLD, psa, NULL);
-}
-
-#else
-
-static void set_signal_handler(struct sigaction *psa UNUSED)
-{
-	signal(SIGCHLD, child_handler);
-}
-
-static void set_sa_restart(struct sigaction *psa UNUSED, int enable UNUSED)
-{
-}
-
-#endif
-
 static int service_loop(struct socketlist *socklist)
 {
 	struct sigaction sa;
@@ -1167,7 +1170,7 @@ static int service_loop(struct socketlist *socklist)
 		pfd[i].events = POLLIN;
 	}
 
-	set_signal_handler(&sa);
+	set_signal_handler(&sa, child_handler);
 
 	for (;;) {
 		check_dead_children();

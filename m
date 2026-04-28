Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA2224AF9
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340837; cv=none; b=YnytCTxciU8d1YW5aIa+r/WT54SWMl+UoJ1S8ZGQE4SGsUBQqHZiU+aPvC9DQCBbPBRBhR1XvC+otcBeIcXzkh079CrYyGpduViz1l37frswyb9HmvTIbD23OPezaX5l03/R//Vg2nnduMW1OEBN4puY7XNjVXicI76mQNkb6Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340837; c=relaxed/simple;
	bh=TyciM0QYFQPU4nxhMlMPI3viSxiOBn935qERX9GMVHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uroMC80gHgPwkzPknmljM3RsXz3t+GcpEJdE1nirkg6CEcwD0NdRosogDyLDc1MG3iBfJ1XefdpiJWH/dWOCGN7aAT7XNEH5Xq2syKUTW3P4CuFB9PyGqekGWvAChR6Zkpgny9QICbOyZlOCgT2hgNgwVhYmuT4duNzj9MMoD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fnwQduzy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G+jtRUC6; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fnwQduzy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+jtRUC6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9CA57A013C;
	Mon, 27 Apr 2026 21:47:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 27 Apr 2026 21:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777340835; x=1777427235; bh=/d3AsTtXMZ
	+aWYh/HC4Bl35dwJW/2AXc0/pAqOVGbCM=; b=fnwQduzyAtj9qEFu9PQeb5BSb3
	We6/vJfEyEhIsCpPmtWAA3jdEp5hBdwFidVjdu2NEqTrDCL8M6MEB+WxHdwqx0aW
	lvdL0PiWj1zVqQ/+/DxAM30iNpzaPj54b5OdfygtotEcjvivZY/AnafAVTXHwSrC
	57SktpX4Fn+hq1OoSspraQ0DO+JDAq1+G5ilsfXJjyaVIW0Xtlb+O3449Vvv5SDL
	F6S4pOHnrDhVu8tZnaicJirNCDorTuwZZpwviR2mQ1NRGdZ9UO6pAHbO122QCpjc
	fp8DRUzCiax2law3eYRQ29xk0SjFm6YcyMsbfouwoOTu7DkUNKxA7Yo+Efqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777340835; x=1777427235; bh=/d3AsTtXMZ+aWYh/HC4Bl35dwJW/2AXc0/p
	AqOVGbCM=; b=G+jtRUC6xVNdr+fw93CbFSi6fsKIUlXO+HVnNT9WhJz+K/JvHSy
	MmouajKHT5sgkLGXwf/26WqsahGum4KuHTQCwzla2bY3VQdAmwsg83BWqcs6OgWW
	GQmca5bwuZKJqvtkQ73LbtMhWWgvXktjiDf4P9XJh0Qsl2Mz7RhsqC3TcLA/ZYMD
	Qlqd6FM6aaOJ0xQb0okeoY54xFl7CCK4UEF9+t3vWon7zOMuelpTbuc+Bq6nUy8N
	H+Al1UWMW3R5ToN1bQ2IfYqypN3d1gtHmYs0QitW1qJaveF3uTPu8sOpsOH+sjwe
	OvYX0gYSjBF7ZN7MnSetn7mUHi0Asa73Dzg==
X-ME-Sender: <xms:oxHwabiSu6i4b9QmH_Wwylj-Q1EosKUtlwTG6fALMQRPgDz0psk60A>
    <xme:oxHwaaTMHC6alcQxL9sd6sy9WXkoH9EzGkzDe6-oFRxZtwTmMJuwuxC_-ZgZrKFX9
    0vQonm6LsO5m_s3dRn1_cgN8TkwaCaVQr_9enCrsf9ZeyPakrfqAZs>
X-ME-Received: <xmr:oxHwadVVkkymCUkECJD7q4fn_LY7c_Un9bVCWN8i0Cf6r3T12VNa5VdaUBzlzGt4I3lRTR_Upqtr5Q7yswHBXNhTLinpvEM5sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilh
    drtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:oxHwaeRXd3hDjfD_rdm9plHsPEKC1_5VkhPkCg1xYwMatdNYxpylUQ>
    <xmx:oxHwaXkYrInnJIE3toSCuxUlLg4cPttEBPXDPkXxKXvQPezkDx8fEA>
    <xmx:oxHwaU6BHAy4mkTZSWKI0vAkweE5RIouyc5Nt2t6Lk4uGdeA3v_J1A>
    <xmx:oxHwadh9ERACU7Dwewc_STj1bmTS47lW9mXoGwswCqjM6C8he8Hd3g>
    <xmx:oxHwaY4QsdVjlsEgKQDyk1a4i_7aDHuJcxdliRt09jAsaW3GXPVcDd94>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 21:47:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  me@ttaylorr.com,
  phillip.wood123@gmail.com,  ps@pks.im
Subject: Re: [RFC PATCH v3 0/2] push: add support for pushing to remote groups
In-Reply-To: <20260427140530.856125-1-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Mon, 27 Apr 2026 19:35:28 +0530")
References: <20260325190906.1153080-1-usmanakinyemi202@gmail.com>
	<20260427140530.856125-1-usmanakinyemi202@gmail.com>
Date: Tue, 28 Apr 2026 10:47:14 +0900
Message-ID: <xmqq340f26vx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Something like this is needed to workaround -Werror=sign-compare complaints.

diff --git a/builtin/push.c b/builtin/push.c
index 10384f265c..6021b71d66 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -552,7 +552,8 @@ static int push_multiple(struct string_list *list,
 			 const char **refspecs,
 			 int refspec_nr)
 {
-	int i, result = 0;
+	int result = 0;
+	size_t i;
 	struct strvec argv = STRVEC_INIT;
 
 	strvec_push(&argv, "push");
diff --git a/remote.h b/remote.h
index 8ff2bd88fa..7915be3111 100644
--- a/remote.h
+++ b/remote.h
@@ -430,8 +430,8 @@ struct push_cas_option {
 		unsigned use_tracking:1;
 		char *refname;
 	} *entry;
-	int nr;
-	int alloc;
+	size_t nr;
+	size_t alloc;
 };
 
 int parseopt_push_cas_option(const struct option *, const char *arg, int unset);

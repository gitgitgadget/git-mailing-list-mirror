Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74F92C15AA
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422973; cv=none; b=UmifH4h0ipSlhofzQCwF9Lr0OgJlMYq7X12VwxNZtGjyKUC2dRI09xhcyTovE9jQWLkcAX0i3ak/CxHfz0EgOCkIKwVghTpCjdgNvzeI4UWClcQmdUoZMUH+srTAulxyIbtk7AD/Smrgqjeo4rJTri2mGGgV3vhig+79dMKAkKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422973; c=relaxed/simple;
	bh=aWXFcCvosdooKBcqHkAZsJAsOnKGA4Vv/BaAfH2qGKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ezki0d26tEPUyfCjzJj5kSjlzI2tuLs/2R3PcqMGAmK9MsRt6OnWqKG1h2CqqlIXM2ms6zrn/WvodiL914ge7L3EDEXc1sIwVVcyRlEz59EcBq6IpB+NFWL09qB9c2J9kHanjpfuWyig2x+LA79A/McTEayVOJgGKPRkvgUAjFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e13viORq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=54Aj+vjC; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e13viORq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="54Aj+vjC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 19B341400278;
	Wed, 25 Mar 2026 03:16:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 25 Mar 2026 03:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774422972; x=1774509372; bh=vuvV1T84Lm
	NIIPUBkGEHvZL7mlI0Aocskg+NFauBB/M=; b=e13viORqE/3oCwudhSxj6d0mzn
	Bzj7rzvQFbLbaPWStAPktUOYh/gHinXNtCQPDEkW0kaATLbVDfvCnJITocToUvGU
	ej3ZIBcT1VBFZIyhod4IOTsr8XQuY+pJm+lP4R4NdOLL8AHmBpP8nI4yJ4i9yqQ9
	SQhLMjSR90+ulyonkKO15zb5wM7c8uBsKU+JId+afaR0tsxq6Fs0rmBYYl+m3gat
	cNfOkDVSDMU+wlCUe8x0Levl74Tkk3tfDVXYZKnGH+bOxBYlgwKnJZWiVWW9oPnI
	2cYiuqtmchrBgQhucAX3GDhe1L2V7JLX2Led9NrAObHlGggqilGNMWNNJ6sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774422972; x=1774509372; bh=vuvV1T84LmNIIPUBkGEHvZL7mlI0Aocskg+
	NFauBB/M=; b=54Aj+vjChikzOL2kYdGF5eTOpVj7f8qlWUtU4/vfaLphIVtAf2l
	BxqD+g0gQP2uyBSTjtpJ3X4KdOk3YzfvrjFTDX/JZTMqaeX6dMkUPPOLQPOMmez0
	WTMN7orQsqUNUL2a+guvhle+RkmxeNr0G4unIdR+UQda36GhAmkhedUNGSPUJJPx
	uTy+k0y1vNWh3JMu6RPnrVvmv6Ic2HPHxa9edyGXqJEpw0r94jXGxninR/M6/fHT
	RlHEupTjLWJXImkdwsHD96MqmD2iUVZM+1+vDsQ1T+r4lZGZgOeClpmroB0TNrg+
	jybxY5EPWv5Wzz9SDZOB3VRiaC9LLFrp4KA==
X-ME-Sender: <xms:vIvDaUyGyPKYAFgCfhxeVSp4zxPnH2MKGT9K08q_eb5JB-FnG_Sr6w>
    <xme:vIvDaeQVrRax8waCGpNzDRn6Q1N9GTCjEpGCw-_AARCkh0QLuxOu_uE_LYHA3DRpp
    hj1zCt6KrgHVaH41J_9JAsfmfjtlKUgedR5QDxygGaEA_4fkxE>
X-ME-Received: <xmr:vIvDaT8g1kMyom8q0-qsM8krK8lgmcUvk6uHZNXh4QIQEfIuBKFcourVBx3-ucL_2gGj6oIVy8faqphpU_XeaF4Cpk4b7ECc3Q7I3mX-N4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vIvDadqdEscuanA3i4ZdO8k1lhLyHib-Ggyx2KySDWI3_Yh-hTG1vw>
    <xmx:vIvDaYmPffcictuQCp7iU80HRxQjpxrh6nJAf3COY4KTdDfRL6O8AA>
    <xmx:vIvDacIeT-3lAxTV_bY-XMHoloSC1Rhl7zGOyW1SqtzcPTp9V5o5fQ>
    <xmx:vIvDaVwXv5KEM3HSCa9PMRvn3BTzLAPz84qYjzsEwXhfuqqnkMAKzw>
    <xmx:vIvDaYKqOvR2i8pKBkLYH6xO2yQq-gyBywDyD9aTeIX99sOrtPJflJIn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 03:16:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a24bcab7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Mar 2026 07:16:10 +0000 (UTC)
Date: Wed, 25 Mar 2026 08:16:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/11] t5570: make test "set -e" clean
Message-ID: <acOLt7GuLTpg_QYM@pks.im>
References: <20260325062114.2067946-1-gitster@pobox.com>
 <20260325062114.2067946-11-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325062114.2067946-11-gitster@pobox.com>

On Tue, Mar 24, 2026 at 11:21:13PM -0700, Junio C Hamano wrote:
> diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
> index e62569222b..6850f08c1d 100644
> --- a/t/lib-git-daemon.sh
> +++ b/t/lib-git-daemon.sh
> @@ -86,13 +86,13 @@ stop_git_daemon() {
>  	# kill git-daemon child of git
>  	say >&3 "Stopping git daemon ..."
>  	kill "$GIT_DAEMON_PID"
> -	wait "$GIT_DAEMON_PID" >&3 2>&4
> -	ret=$?
> +	ret=0
> +	wait "$GIT_DAEMON_PID" >&3 2>&4 || ret=$?
>  	if ! test_match_signal 15 $ret
>  	then
>  		error "git daemon exited with status: $ret"
>  	fi
> -	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null
> +	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null || :
>  	GIT_DAEMON_PID=
>  	rm -f git_daemon_output "$GIT_DAEMON_PIDFILE"
>  }

This test actually made me pause a bit. In theory, you can use the
function to verify that git-daemon(1) exits successfully because we do
bubble up its exit code. So instead of silencing the error code, I
simply added `|| :` to all callsites that don't care about it at all.

But in practice, that turned out to be every callsite, so that exercise
may not be worth it.

Patrick

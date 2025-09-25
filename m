Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C193F23B0
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758831346; cv=none; b=MPOcW22nRveC6mb3Ss2kyw9j2iuKPtvHdnGGOrhgVgv118JzVj7VMNhBGVLCNXUSltZkgi376El3qssFhKdAF5JOP8DPvRpXxIc42i3Cwz0uTdfBpfrvVSLbTGhViVEFIQUuia6uqVm5limaa0wTp/pm5FBi8ITqgcbochySi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758831346; c=relaxed/simple;
	bh=ZUEEEvxGO34izDu+zKaz0V8n495c9Vpi7EdLzca2TQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qTAdjs9A0Ckmi8qexAPw3EmSRMtsrQeen5TW++iPv5UAvAj0MZ2tjKhKfq7nZok58JRXNTAhPaM07Hpt5efvBoP2TF3GSAO4Z/vcfWWB712nPJ4Mp7rfSMtVQAjKAmf61ABAF7TJqPheQLbe1YZtUKr+vYkp42Z1mL6WELqfSqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QofmCxYc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PJ58KUDB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QofmCxYc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PJ58KUDB"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D727314000D6;
	Thu, 25 Sep 2025 16:15:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 25 Sep 2025 16:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758831343; x=1758917743; bh=KBjnRXF0aW
	XKcK5gnMf+8UhAUErkc4UikiGYqfulrQA=; b=QofmCxYc9lwiCWiveu0YQ7Lei1
	FBqEm5S+b3bZlZ79qXD29TvZ2v+IEXBVeT2f18vA0g0mTL+44my6T/woR5765M4B
	2rrAwJCoOaKGBS3UqmiWs8qDfDKcFM1Fnwox8W+0hAVQtbQ2980Zwl9X7aFWi5Rj
	c77eSk8V5LJDvRu8qH4EC0s9jmm4Z4vzkuFQJWx0lHbiiadjghXSBdZWe3aL/g8F
	fIxIH7FM0tplXRCAwI/8aPuVN6FFH9/tFq9ax4RwOT2VufVejUNAXa/oWXAAQdi5
	IObqnx7uATCE+8IJuxsNHTBhVHcW72pDxi7qlLeK8KcMBAGP4hZY2BdFwWiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758831343; x=1758917743; bh=KBjnRXF0aWXKcK5gnMf+8UhAUErkc4UikiG
	YqfulrQA=; b=PJ58KUDBKaiTFIOrhyORAw3M0ZH6HL0bI/hVeQiWQfcUSR78hp0
	K1XDJQTfZLe0d5qiut/kMMH+stJmzlL/XXgtWdp9TBBmzplz2caid5qmL6+oS+xB
	9pjdtlg8rIDp4jGeTyQyw17dqPtG58qN2u56XPhhH99ttNL3gje1byVFsxvu63zf
	gyky21lgNRv6LL/gj4Z0QabLjIFWDt7XJVgHhjm2Qf2sPMG9PmrGJuVouIfWhfjU
	hWe4emvWkNoFGFrPjcmlEu7XqlEroKOnwztUcKW1f8gCx0wJdu3Px7coie94viIg
	RfOU26DnGgvN5frChGsRwKmhd8VPAEWnaGw==
X-ME-Sender: <xms:76LVaI_XS9i1Kz7Jx9lUgays7fqSoiSM98fI3i1_TAmM1Oc73nkf0A>
    <xme:76LVaPw8MoSmMaoAuLEWCI8LkWDbe7Vp9V1X3Pqh69vvYLN4RbloseECHuZwXaxw9
    UpcHRfc9se1Jmkcyjfau1ltmFOdn2MElI9-1Hvw_RaOEGfE4Wwiamk>
X-ME-Received: <xmr:76LVaEMdC8CvUnTz_X556ssapdoiBnkWkIlC6LNMWj3BHUI8amhISxAO47MF6rdEdDmjkZX_gmi-lGAmusYSt5c9AEZhTT7guCv5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrg
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:76LVaE_FsknktGknFEtCWuW-d57vKUYAwHcoy4NR7s7JJRLnpOyxvw>
    <xmx:76LVaB6LdY0yawwFWAcCTo2it1xWchBq1InbYdguqoj69bS2k3RFrQ>
    <xmx:76LVaK4tafoJeIdN3N6xoLfOXiyk4vDLoOnECILYPi0lms8AdvRS0Q>
    <xmx:76LVaKoX_qASmpcpAygESE1HaqcdoofbN2fI3zIxqNJZ2Ed3K8Lx8w>
    <xmx:76LVaOq5DTUsnNNrU9FKiWVmAZWn4fDb9lfnSoYVLnGFNs3m36tM71Cd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 16:15:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Patrick Steinhardt <ps@pks.im>,
  Josh Steadmon <steadmon@google.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 03/10] hook: convert 'post-rewrite' hook in sequencer.c
 to hook.h
In-Reply-To: <20250925125352.1728840-4-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Thu, 25 Sep 2025 15:53:46 +0300")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20250925125352.1728840-4-adrian.ratiu@collabora.com>
Date: Thu, 25 Sep 2025 13:15:41 -0700
Message-ID: <xmqq8qi2ffv6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> From: Emily Shaffer <emilyshaffer@google.com>
>
> By using 'hook.h' for 'post-rewrite', we simplify hook invocations by

This "By using 'hook.h" is somewhat a strange thing to say.
<hook.h> has been in use by the file (evidenced by the fact that
there is no new "#include <hook.h>" in the patch).  I haven't
carefully read other steps in this series, but from my quick
skimming of them, I got an impression that this comment may apply
equally to other steps as well.

What the commit does is not "use hook.h"; it is to replace a custom
run-command call with a call to run_hooks_opt().  The shared API
service function may happen to be declared in <hook.h>, that that is
secondary piece of information.

> not needing to put together our own 'struct child_process'.

Imperative?  I think just dropping "we" would be sufficient.

> The signal handling that's being removed by this commit now takes
> place in run-command.h:run_processes_parallel(), so it is OK to remove
> them here.

Phrase it more positively, instead of "it is OK" (which sounds like
it is also OK to leave it there).  Perhaps say something like:

    Another benefit we gain from using run_hook_opt() instead of a
    custom start_command()/finish_command() invocations is that the
    hook API handles with sigpipe itself, so we no longer need to
    toggle signals ourselves.

or something like that, perhaps.

Thanks.

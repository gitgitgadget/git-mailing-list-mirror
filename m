Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F1CA6B
	for <git@vger.kernel.org>; Mon,  4 May 2026 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777858880; cv=none; b=CyE11YAecUbXcVv3VLN+ftphBmjO/M7qG1dJAyca9L9LgNdWKTf6hRcL4OH4G8TxBiCVmBB8cvZh5viPECVCRtTWbq9OGPLuYrbZdJ5ugtwKIgG99GXvwrT4J6iVEGvIlSbipFQz6ObRhH39HbJ7Uu6ZW9AqZuxuJbt2RqimNWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777858880; c=relaxed/simple;
	bh=2PeB6ketRZBU1UQEI86gdGMl2/eCT+gT4whZp4ZOL9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rxgAmat8ag2OMTPyBKnzvoqKVwu2tiqPs06ZFH2QKTWj+6F35+lqYHTNWz1a1EGUYMpfsbZhjQyV9DdTuxGjt5+XdabAlIJ6hfIlZFIuP5kp59XWvGmTYJAkwRdZ6Zjq38LrpNAPAcYpkuczVjDsUz/3yztSzpR68i/8gTqAfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U6rO+Boc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OOUVH7aB; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U6rO+Boc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OOUVH7aB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4E247A001E;
	Sun,  3 May 2026 21:41:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 03 May 2026 21:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777858878; x=1777945278; bh=7Rae7mzc4B
	NhmotyzaZADHC3itlxcLQQaWKoQHuVybI=; b=U6rO+BocZVSvErYA7DoCD4Jcvf
	qzglBzq8cZGYvPZnA+/3+Cp/EZU57FXxZBhMmyVVW7LKAhw2o4csq95CWabDV6fw
	hdExPsY4NlniHQF/ryUzMI9dSuFB2kZ0h+fVJXzKV8lmeUd/DOW0UDyzBxqTMCvy
	uAXln9h1HFnCSkW1G7qxRjCjojyI5lN+TA03u34wL2kn8LuEoMxI8CpIDl17A6ot
	2fKo7eG4N/NWDTe33xvikOF/KQ77ZXe3FTQ/wnlANM++AAw67RnLFbG3YItsXIWs
	4Sb/GA74ZVdT0UCFm4Iba6vUaPApcIT6PBzTx81hyaTrhNaMl80f7q0PtCaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777858878; x=1777945278; bh=7Rae7mzc4BNhmotyzaZADHC3itlxcLQQaWK
	oQHuVybI=; b=OOUVH7aBB3opt6Um5rScKCSpz7xsLo98w+ARRGi9JQRoR2Fqxr7
	ZGXGFiCuYtRu1c9Xt2I6YmYPoEIYI6+6ueXNgDuwqqVM/1urvFIjnpiaEd84zG1U
	G6Hv19gTukwYxc4zZoqqxWglVmT/EtLMeoN/pMdti7VImpNM4ZWxD+MxFQSQa1eh
	cAlBzVQJiwWJ4UUwdNp65dUrSAcYozkJX4yPRs1xhfnE9TKJNNbrl+qNuavdCo8U
	aUhNkXkce10VYfpeAu2Tw11isp1xl63Q/WoFjtWEQDZVTfWMo5oWjzj+72ZbC/k9
	ULOflqRuFjtWZPOCXPvF9Ja0wAG2sTQYn8A==
X-ME-Sender: <xms:Pvn3aQHCXjQFyw0mecff245AQ4IEdmI9KGD19A-SkW19kMb4YEsEFw>
    <xme:Pvn3aSrwfglbKAOimrAN3dAaUKJVIUe5vmYFEMk1G-hYl_txnzr_iu0NEvQW1sqUE
    RfEM3seaPeLxwovaWAy-1G6JglWSoffV0FfcQTUVTcoaRQE4nsG>
X-ME-Received: <xmr:Pvn3aRbN_09-2yNgDLLHj--nUhE7MQiM1NdhviMgJCBWBsoNx1RcZhHpJFENnjKZIlm8op1sxmTCo6xlDWs5c1V2406OMbq-8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeljeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopeguohhmihhnihhkrdhlohhiugholhhtsehunhhivhhivg
    drrggtrdgrthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghsvgguvghnohesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghsvg
    guvghnohesmhhithdrvgguuhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Pvn3aTU1pJU_K-S-iEROVHsIu9nSeFcKAfsWz4v4zC3o9pKxbFtkyA>
    <xmx:Pvn3aS-8nE81RNCJ_otLXfzK4vbezx-9JcREBPntHw7YPqe0NNiUcA>
    <xmx:Pvn3aU9e8PJd9cekXKPaHtoBRW9_ncmo-7JzZPC8Iq-cyuDTfURpxQ>
    <xmx:Pvn3aaT9KsMzUlBjqKFklwu2ssd0KV9tL7UMF_MaIYa625WmIN2nKw>
    <xmx:Pvn3aeZKOKBoown9QfOquQPHvrmm7VNpK5ZSHu4EH0OpqitwnoRIrXGe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 May 2026 21:41:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Dominik Loidolt <dominik.loidolt@univie.ac.at>
Cc: git@vger.kernel.org,  Alejandro R =?utf-8?Q?Sede=C3=B1o?=
 <asedeno@google.com>,
  Alejandro R. =?utf-8?Q?Sede=C3=B1o?= <asedeno@MIT.EDU>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH] compat/posix.h: enable UNUSED warning messages for Clang
In-Reply-To: <xmqq1pfsq8sd.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	04 May 2026 10:10:26 +0900")
References: <20260503151210.36036-1-dominik.loidolt@univie.ac.at>
	<xmqq1pfsq8sd.fsf@gitster.g>
Date: Mon, 04 May 2026 10:41:16 +0900
Message-ID: <xmqqqznsossj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> I am not familiar with git's minimum compiler version but this patch
>> drops support for Clang < 2.9 from 2011.
>
> Does this "drop support" because you force _all_ versions of Clang
> to use the "deprecated" attribute, even though you _know_ some older
> versions do not understand it?  Don't these versions identify
> themselves so that you can do
>
> 	#if defined(__clang__) && CLANG_VERSION >= 2.9
>
> I do not know if the userbase of GCC and Clang upgrade with a
> similar cadence, or we seem to say that we care about GCC 4.5
> (2010), so giving  a similar version detection for Clang and exclude
> ones older than 2.9 sounds more appropriate.

IOW, something like this, perhaps?

 compat/posix.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git c/compat/posix.h w/compat/posix.h
index faaae1b655..0dd0637fc9 100644
--- c/compat/posix.h
+++ w/compat/posix.h
@@ -22,6 +22,17 @@
  #define GIT_GNUC_PREREQ(maj, min) 0
 #endif
 
+/*
+ * Similar for clang 
+ */
+#if defined(__clang__) && defined(__clang_minor__) && defined(__clang_major__)
+# define GIT_CLANG_PREREQ(maj, min) \
+	((__clang_major__ > (maj)) || \
+	 (__clang_major__ == (maj) && (__clang_minor__ >= (min))))
+#else
+# define GIT_CLANG_PREREQ(maj, min) 0
+#endif
+
 /*
  * UNUSED marks a function parameter that is always unused.  It also
  * can be used to annotate a function, a variable, or a type that is
@@ -35,7 +46,7 @@
  * When a parameter may be used or unused, depending on conditional
  * compilation, consider using MAYBE_UNUSED instead.
  */
-#if GIT_GNUC_PREREQ(4, 5)
+#if GIT_GNUC_PREREQ(4, 5) || GIT_CLANG_PREREQ(2, 9)
 #define UNUSED __attribute__((unused)) \
 	__attribute__((deprecated ("parameter declared as UNUSED")))
 #elif defined(__GNUC__)

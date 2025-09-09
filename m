Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B7D26981E
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447241; cv=none; b=XFvqsgVNbPqJD0VpitkT3ZgQF+75w894o6y//TCcFIHh6VP4Z92IARWgB3p4MKxEjcw3MKpDhxVgwdeYSK9fbiT4PXstWppCpjQ4FAfVTxf4WRUQL1eZ+OzEcJKUxhgwLn2Lq1SRVdajI/ne/6+K9e3NSjjOi3RFU3LI/d0r2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447241; c=relaxed/simple;
	bh=n9bszQEtZv1fmQuEx62loMPpBCuVBgVMy6Vde73kmJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ey9LL6NKgK+tS1JnlZpqasgr7Xgj4yYdZhuGanptYUzEWzprWo2A6YMplAodE+4MvYBoNXMASz4cDmuF4tQMd6aTVUN83mBVssid/sSEC/GCYIiBBRxtg0MDOYXaSb/NwNC+OJSAGFXoJXzXmaPYxwn6JNSO4WaxmdXKPj/gyN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZwYWqRsN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V3V9wKMf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZwYWqRsN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V3V9wKMf"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AD86FEC00CC;
	Tue,  9 Sep 2025 15:47:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 09 Sep 2025 15:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757447238;
	 x=1757533638; bh=Zr2ODWmc76hMQxIPH5ERbz3j7M4JuqLFoQHkUu8IwQM=; b=
	ZwYWqRsNkiaSN89hPZRerm2EeCgoTTGPUAwhSSV13zv8Sw/KIFOAtpT++Y2Atj8L
	kfctdrR3/3/ct7knPTwn6OCPisFEDtK1rAGPvn70XboZxoza4SB+Nd51EbfdQTel
	t1d/nD7DxUvpT4ST/L0BGyLe4PS8dd17XQnCuOO5gyVM40+An8QsMhz1bUpCAmX5
	jSMMwDl8OeT/Sdj/5OcMRoRTLz9ugKwRco7Z7s9XnSnAB7DJO/n0avQOYX5hMSzQ
	B8wr568J1dhmYlYRt6sUoGv42UVopBsyNrmoLDBTjeOEnwj+sSUZpSkDpqprIotj
	YSRlDMN8PVGWCGhQjWUWyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757447238; x=
	1757533638; bh=Zr2ODWmc76hMQxIPH5ERbz3j7M4JuqLFoQHkUu8IwQM=; b=V
	3V9wKMfly/DONOMMWDbyaXO9APXspoZ72KuOS2poABv3B0iQf15y0dEolyIvLDHu
	L1mET26efH6hbgphlCLwonQLNU4gQJFijTTZBWi7aOWBZRy31iaQ2la5TcKCbuR6
	pbkA90tMSehn9HaJTyLAUD2IQRZFDP4lgTOGF7aguO/XPLZJJ3gtP/4rY8I2VDtp
	UetNGQ7ePjM2xmlWqM17Fn9OM5UEaYvXmTO0ntKcvplhFrIjmqPlhVDSveyh3Sra
	Kn5qH575k4uJ+4QuAxFnD+ZvkuEgNlyOGy31cGbjftiF4Db5DQAy90nL5JzI0SuU
	G+rCD/ah8HGJVZu9Ocy8A==
X-ME-Sender: <xms:RoTAaPeQe3Wly_FPMvtvm658Wlriw9boXLIRkg0wOeD9Rrb10kMrstw>
    <xme:RoTAaAs2oYKSH2njwZbmHNJ5W2lP-5pEzBQfICv-neG6FG1_-GT820BnCHcMe9IVb
    eSRQEqO1pjSFCjd7Q>
X-ME-Received: <xmr:RoTAaO8O91Y0Q-ffs-UV3ZqXDW1QYusdkkkcMzT6rEyeC6kDAKPZioYMglCeJG5e-YKOg2DNijjToY_kPqeZpnOM-lCzh8VIyRVdp8OF3k5xk0qPVFYNx4ckCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhephffggeelhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhs
    rdhimh
X-ME-Proxy: <xmx:RoTAaL3SBTomZzqJAX7DJFmlRrgUo11gL0jKu1WvECuIXO4gdeXk-Q>
    <xmx:RoTAaDDiCCB90dxjJhGTU4-4qT_nEeoxyV-XUxsItZz3QuTRUF43Fw>
    <xmx:RoTAaHe2eBkntC3a6XbHalfGTplOjEQpiEenJ_jaoyZam_l9dTns-g>
    <xmx:RoTAaA7ceavB4LfLSTg4d5NnUpjTvR6ZaGuvUlTKgdvvf9SjtVg9bg>
    <xmx:RoTAaNlva3E3Vmt7VwIzUhzrXVbQEyvTiLcPbZEin9H3fJNqwQLqi3HF>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 15:47:17 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 3/7] t0014: test shadowing of aliases for a sample of builtins
Date: Tue,  9 Sep 2025 21:45:53 +0200
Message-ID: <00108f28f82e618cb39dadb8161841c29a766d1f.1757446619.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757446619.git.code@khaugsbakk.name>
References: <cover.1757345711.git.code@khaugsbakk.name> <cover.1757446619.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The previous commit added a test for shadowing deprecated builtins.
Let’s make the test suite more complete by exercising a sample of
the builtins and in turn test the documentation for git-config(1):

    To avoid confusion and troubles with script usage, aliases that hide
    existing Git commands are ignored except for deprecated commands.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3 (new):
    
    Only a sample of builtins since the test file takes about 600ms longer
    if I test all of them.

 t/t0014-alias.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 89bedb9f73b..bf7e6512bb1 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -72,4 +72,21 @@ test_expect_success 'can alias-shadow deprecated builtins' '
 	done
 '
 
+cannot_alias_regular_builtin () {
+	cmd="$1" &&
+	# some git(1) commands will fail... (see above)
+	test_might_fail git "$cmd" -h >expect &&
+	test_file_not_empty expect &&
+	test_might_fail git -c alias."$cmd"=status "$cmd" -h >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'cannot alias-shadow a sample of regular builtins' '
+	for cmd in grep check-ref-format interpret-trailers \
+		checkout-index fast-import diagnose rev-list prune
+	do
+		cannot_alias_regular_builtin "$cmd" || return 1
+	done
+'
+
 test_done
-- 
2.51.0.16.gcd94ab5bf81


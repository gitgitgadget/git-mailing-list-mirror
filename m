Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868227877D
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529203; cv=none; b=Db7fIOAw6nRng7aZwI9NG7Rz3xYQWrfZ04BdW6qnNsfs7TKAhyOu27HLPuvlWNKCjIZjn+TFJ39BUqYsrIqKSCt6IvKoSoVh8sEvzP8dGHRrAWkV3vBNM7Pd7kHtXTk5bk2FjY/F/IsB3gE5cllkSfC7CaYMvM9XAJ2U88a2by4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529203; c=relaxed/simple;
	bh=MiyT/RyPpEW5Q4za/uvFghMe4dGK8xUQuURC2M9fks4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ca4KLMNjYwIMCp39Ox9n+a5HtLu2vluGB4bzaWCqJ0+Juj3ly7vwV5YIkx7ylY5coAsh7Luxw6Uhp0gCTh6IvpWh6wc3WhcDZlb1GiffL0p0TpkVDLd3EIfd1uJSRucCfxnaWcPymndHdyiVxM8/0PoiSSm0wF3uMh3YY47VFtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kwFsJBCi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GJ9C7Adi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kwFsJBCi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJ9C7Adi"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A86BB138100E
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:00:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 06 May 2025 07:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529200;
	 x=1746615600; bh=mNooLtoOMY5aSf4fGUX3ZUqPg2W0MNlTjri4XZVkJGU=; b=
	kwFsJBCi/3TC7mxc4jEyWW+lX78yRS17DRZXuK+cv+xoPci+0yCHcoDEIythPz8S
	X11yNwDDQb5+7Pwv1yQiXExREKrN1oO4WCcQg3+fG4O119sSXhQRNNtl9o7uY21x
	az0aWDUejNZQhRIcSMSTWRt2zSa5mslJb+JlYgxMDjhhXnhCEIX/qXd2eOhQH6dE
	u8i8Hq8o6FcW4/ITbwpFY0o/rlvHn1wZCFKfSSORvG6ZRExATdrlXcivxFv37tEf
	QgIAfjvvj5iIMX8ZxXwT++L8C9RvLUtiJS5bBo43zIKY/hVAApuG5++TBUN/OlCz
	cjvNqKYE8My0niykyt5AzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529200; x=
	1746615600; bh=mNooLtoOMY5aSf4fGUX3ZUqPg2W0MNlTjri4XZVkJGU=; b=G
	J9C7AdisV0xd1nBglwz8U69wD/UL1VcDSdcYzwXGA7ewbJpRRzevgneffQ1ux/so
	DXV7xYlFpVuF9hdpO2B6QDYCiIq88M2fqkL4iiJ8HuOl4lQvFx2SHETr0Nc5RL+l
	f8efyPU8R5HjDqZZMOGKe2gARYNZAOFA1SGsw7pJ7jzdhUTNUdsThrSrYG4kQ5oG
	fJ7//USy/jvLERpBxYaSLWEQWSBgZkHGzxrmn50sfLFlgbhTjLidTnp8Hu2p3QVf
	yPYI0Q/Sc4D95toUM6o4fYmczEorg9qdbSbxGUsBrLQ70bL0LNM9cOzSMYf6nWl+
	7uLdCmB5ltYEyVDkBUjjw==
X-ME-Sender: <xms:sOsZaK_MivWZQeaADHPgwbRyvIk6e5-XfBEEv82swffzpLoVg2WhBQ>
    <xme:sOsZaKt8SPt2uCkgpnJ4c3d6YeEctiz9HttYNzsBJ5nayGOYke7uAy9wFQsPoUEl5
    b_hnW74x4b6LPsHPA>
X-ME-Received: <xmr:sOsZaAAP40yuTQsm6Puj-xW5MXgjUXRV2ft5FwLFrN14wbpMM4CIppKkN7BteuTf2_nyTyhdBf0WXQxcTN5y4GIHzdqMRuu6gsrQLpZd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlh
    ihqddqteefjeefqddtgeculdehtddmnecujfgurhephfffufggtgfgkfhfjgfvvefoseht
    jeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpsh
    esphhkshdrihhmqeenucggtffrrghtthgvrhhnpeefgfevtdevudefudetudfghfejgfel
    geehhefflefggeffheeigedvgfefheeugfenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sOsZaCfPCtUVZAOVHAyA6FFt4Ztx95BPbm3wAZC5usgmphcM5ZHnpQ>
    <xmx:sOsZaPMB73F_B6TcsFIwOWu_NRmjy66iQllQ3spk1D49hZ1zb_x4Jw>
    <xmx:sOsZaMnCbkV0QGv9TROiYmdAn4KNj9q8eAAB9o5qoMqsJvz0SfUTig>
    <xmx:sOsZaBsXE2XHP9pDGYgu87aTYXCvQ3FaaTkvHWPzPwJqydKCxCSRzA>
    <xmx:sOsZaKoHHsgbOjSoxYdd1u2lcPA5hX1NYUglBB54FFveL-Mr_pXBt3xo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 06:59:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1ad49925 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 10:59:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 12:59:53 +0200
Subject: [PATCH 4/4] meson: parse TAP output generated by our tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-meson-tap-v1-4-5aaab2942a4c@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
In-Reply-To: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

By default, Meson only knows to pay respect to the exit code of tests to
judge whether or not it ran successfully. This can be changed though by
specifying the "protocol" parameter. Next to the default "exitcode"
protocol, Meson also supports the "tap" output that our tests already
know to generate.

Unfortunately, the "tap" protocol was incompatible with `meson test
--interactive` and caused a hang. We have upstreamed a fix [1] though,
so with the recent release of Meson 1.8 that fix is finally out and we
can start using the "tap" protocol when running with a recent-enough
version of this build tool.

With this change in place, Meson now properly detects how many subtests
ran and whether test suites have been skipped:

    ```
    $ meson test t002*
    ninja: Entering directory `/home/pks/Development/git/build'
     1/10 t0024-crlf-archive                  OK              0.17s   2 subtests passed
     2/10 t0022-crlf-rename                   OK              0.18s   2 subtests passed
     3/10 t0029-core-unsetenvvars             SKIP            0.15s
     4/10 t0023-crlf-am                       OK              0.18s   2 subtests passed
     5/10 t0025-crlf-renormalize              OK              0.21s   3 subtests passed
     6/10 t0026-eol-config                    OK              0.25s   5 subtests passed
     7/10 t0020-crlf                          OK              0.81s   36 subtests passed
     8/10 t0028-working-tree-encoding         OK              0.85s   22 subtests passed
     9/10 t0021-conversion                    OK              3.45s   38 subtests passed
    10/10 t0027-auto-crlf                     OK             26.35s   2600 subtests passed

    Ok:                9
    Fail:              0
    Skipped:           1
    ```

[1]: https://github.com/mesonbuild/meson/pull/13980

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/meson.build b/meson.build
index 94bd525dd7b..cd8df189d79 100644
--- a/meson.build
+++ b/meson.build
@@ -2031,6 +2031,14 @@ if get_option('tests')
     'timeout': 0,
   }
 
+  # The TAP protocol was already understood by previous versions of Meson, but
+  # it was incompatible with the `meson test --interactive` flag.
+  if meson.version().version_compare('>=1.8.0')
+    test_kwargs += {
+      'protocol': 'tap',
+    }
+  endif
+
   subdir('t')
 endif
 

-- 
2.49.0.1045.g170613ef41.dirty


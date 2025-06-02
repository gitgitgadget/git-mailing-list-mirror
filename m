Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646481ACEAF
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846706; cv=none; b=ZkImsF3RgGUT1rOYsTO6QV1rFJQb13qxWtoUPr0/D6gHR4lLsKWSYZnS3sgLeCp8mQ+1vSFIjonWzp/2swSsNPyZ/LqAF/oSnWhuBTQ6OnSlR/HadIt57sqjn/aP4HtFrSAHT1gRra78KErplvleuvtgzOfscI6V25MXM+/8oXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846706; c=relaxed/simple;
	bh=d8tmWZ4nkF7ZQ0vrXZ3nXsFnOhnlTu7F/jpvjSFsp4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d6sHDU0IvVpwM/VhouGfzuRsouv5I9KMuuKPaaKWx6zITVwcUMMd2Vt4EVzXUVUWv4AI7U9ZQwCXHqB2U8yeDyQ54SJwdGqkHUu+3Z8Qu8Hx5WadpEYww9MQsDThHmbSgD1yqcvsqGzjcRsOrZQQtsP+RNolkVDIcxifGZtZHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P9D8Ds0+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lLhQnq0N; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P9D8Ds0+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lLhQnq0N"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 595C7254013A;
	Mon,  2 Jun 2025 02:45:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 02 Jun 2025 02:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748846703;
	 x=1748933103; bh=z7A7LVvgQYvgoU4At6K5GY2ph9rdc0ttWBcsNYp7Rl8=; b=
	P9D8Ds0+V56qEs8eXsGfs/qi8MlyunWBhbiSnQFp7Bqo/ydyYioLGeQt5cvPnPnE
	Lh2+lUfsigijFXtFl+dQwBj2kYzFfHMPL24RpG6+uJS26zv39fK20YubbmEO1B0q
	AgrxIh2h5quCm4ltvilFzTLavziJdO2JIvroggs0y1adyaLHwoopnNn4uGUyjGD8
	Zvr/nZPdk0A7+QK6Bn1shoiiPA6z5eT5bvkN3t1dhRi0CpalYzPXd3XPObwSOcKs
	veZXT245luxaGJiqXmwJxex4TrHL7JbLgZz8zhB5eRoBQz7zkINQCz+kt3KxsODd
	tSg0JznVCiqajsby/1L02g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748846703; x=
	1748933103; bh=z7A7LVvgQYvgoU4At6K5GY2ph9rdc0ttWBcsNYp7Rl8=; b=l
	LhQnq0ND0Azwm8KV7zlso/cB+rRuyAXjbfLgCc2spVjpBgGIqwcTwdOkFIz6XycQ
	m3LALafoGIIkrmTNIdZ9f87RMj2nxUEhdsuxgbIh7c+axA1TwjVpA8thjYNPH7xK
	H/O5tw4oaaTeornC23ZOF5hcOttZjim4oKL727FQdir2SOLJiAG162wgWSCzWMmk
	oYE+NAEUh5jkXUeG8DdlO+zmgQvm3jTbYfnsQTszpo0eHmLthGPbAxDeV7Nd2Ydo
	UrwvLCHAOWpjve3+dVEALqKBb6J3/o7jliDqZ3om8+CXxLzUYF4vzJQTHJp+SdwG
	S7eg4lxmvnALdGSudJrGg==
X-ME-Sender: <xms:b0g9aAZg6pXo17SM_jyEtw_f1qXf5u2WVSuJUsuq-L2rc3B4tG4r6Q>
    <xme:b0g9aLZijmj79ecl51h05-aFAnJscxNsJhMrwl4K6G_UmZLPPJmSjli3AGBsfSSYr
    eEf6Rvu_F7GgFJU4A>
X-ME-Received: <xmr:b0g9aK_jdzz279QHfYHGxYASjFXY2WmOONiBHJemrUDWw6DF8JRxrYUt0P-XrKnS3SW_yHEhl_2Z7fbwiJFDLRxxE7LXGzhXk1i2jQdIKPcd1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieelleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfefgvedtvedufedu
    tedugffhjefgleegheehffelgfegffehieegvdfgfeehuefgnecuffhomhgrihhnpehgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehrrghmsh
    grhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhope
    hsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:b0g9aKqX0mE4m9t3Jw5V2WKSPAgAyyIxgMxvW_GfezCOqDAtwIISgg>
    <xmx:b0g9aLoT6VMjp4FAOYIikd9X12FYm1DYATbbnlEPi_86nF8A2X7vZQ>
    <xmx:b0g9aIQeVR6RE5D6YDSQ0QQNjAInfnuWzOLf-ePw4VO10UYXxkPf8A>
    <xmx:b0g9aLon9m9Yh00RWmNWSmb0fKEX-uLS-rhv15oLZO1-3HNL8uP67A>
    <xmx:b0g9aF9G0wrE6N5NAKnHT7QgS-2YzqJg3u5N5R1JA4VNKBseP718E6oM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 02:45:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 209191b9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 06:44:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 08:44:50 +0200
Subject: [PATCH v4 10/10] meson: parse TAP output generated by our tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-meson-tap-v4-10-052dfde0818a@pks.im>
References: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
In-Reply-To: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
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

Note that when running `meson test --interactive` the test results will
now be marked as "ignored". This is because in interactive mode the file
descriptors will remain connected to the user's terminal, and it is
expected that the user interacts with the tests (e.g., spawn a debugger
or use `test_pause`). As such, the TAP output cannot be parsed reliably
by Meson in that case, so the tests are marked as ignored accordingly.

[1]: https://github.com/mesonbuild/meson/pull/13980

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/meson.build b/meson.build
index 6fb898a21d1..46c5d068e05 100644
--- a/meson.build
+++ b/meson.build
@@ -2040,6 +2040,14 @@ if get_option('tests')
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
2.50.0.rc0.629.g846fc57c9e.dirty


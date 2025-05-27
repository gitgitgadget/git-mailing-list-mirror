Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E56C278146
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354586; cv=none; b=HpDUpb+53cYe5YSHP0vpfpNQCHLt5HaBR1E48esXFOBojzn1S319dqTt6PnDKoDwuev7qNCPVD1vzgFjb82Rd7Aev9ZMtY0UilPD/mhAHW0SA58DyjH+Cdh7W1E9mSZ4+QzCpstAmiGXVW712yCEzyLmcj92zPjk/VEkapYFlYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354586; c=relaxed/simple;
	bh=yVzumGDLETxigwckCzGErizjzfn13cltWetnDGZuNsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eD6Iuw/or4Rh16oyNoUCm28G1iCbN7+q/6I/TCfgha3JFKTVJ/3YrRWqc8JRNBDh5UvJz3k6VS/Gq20t4diOBhBy0fr+P6PPFb5GWFerG492PUsnuTjXW42EVQoeAXKWLz+xoKKfXTmFos09X8HeV7WWmWGciDmEGzXFBJpaR74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gQtdxuZd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MdeUHjLG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gQtdxuZd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MdeUHjLG"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C3AEB138384F;
	Tue, 27 May 2025 10:03:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 27 May 2025 10:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354582;
	 x=1748440982; bh=W5IeKfVxum6MEVkNFXosU/IPWf2nFU7vlN789q7xN84=; b=
	gQtdxuZdVJ8BCXwDwC7KZBUnuJirpPWmXuN1DFhx8e7vpetOpmfu5jj84cWlT/8S
	Pqy5MmyYpo56M3w1YwnGLXE06xnpPBFEArcQnsUBGiaH603cfNXvERVN14i7zj8W
	t1mhNRTTd48AidOtKzbr5UWcRDhp7RViT8rkeM7htpoNbLNxUdjgcRc0WLZQJgK9
	w9CNtQXZFCw4NAwohZmOIGnhVqAokazSsGSS7Q426LdVJgSPDkvqn9hE9DXu059z
	s292f/Fj2/7a69SP7jUxLO18eKCJ9PRGbSN6UjP/aUK3H4vWwNr9P8yHykPEFXQa
	KDbZ1FawSFXh0vwxm1dnfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354582; x=
	1748440982; bh=W5IeKfVxum6MEVkNFXosU/IPWf2nFU7vlN789q7xN84=; b=M
	deUHjLGizC8lX0F7Es7GP8BtikO3wRpVn7Az9jxf8Pt2n8Y/xoUGA3wnLGw3O/ud
	OZQOpste17RRtSwkxOkSHsU8uoeuokD1JEqKxqdObo9ekTJCqYz0ifzwc+i+KjwY
	c45s2aqxZkQ0k+kEnKEJc+Sfm0qwC88BDygg03VMw6vP1/kB25rt3mamwhMk5i0Y
	0/pLAloVbVtc6fTTo3IEyPnrpL20blOAboxaANz0yvzSC6JVwvbhsDpvtPEWM1/h
	q/HP0WLuRpKuRNL+x6ZJn4Q9SlsDrOudtnXCHMq0ELATqde1k6xmPYjQ60Czh9Lu
	9gGL4xWdYAr9foQ2EKvww==
X-ME-Sender: <xms:FsY1aA2smgIhgPNN1nrpH8UGvYqCcymS3zs7haRpk3cXIcuxhI0o5Q>
    <xme:FsY1aLELYTzHYR8e88Iq9jc4QazH4AfIHrLYJmvfVQuW6iX7OpgWwEXwTwa_i_Hqk
    j_WYHNxWUlk3igI8w>
X-ME-Received: <xmr:FsY1aI5YXyKXpmKeRolbp-B3DNO2RwIPlYNQPW-Rz2sv1PN_-70ezg5ODRfOYTJhkC5nRFmSkmsTJtgDuRQTGecbxmRfGvNPkdxYetBHpmff0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfefgvedtvedufedu
    tedugffhjefgleegheehffelgfegffehieegvdfgfeehuefgnecuffhomhgrihhnpehgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohep
    rhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:FsY1aJ2081cRtDjk1zNnILymw3mVJN_YlK058sizN1Wd1oAgZd0X2w>
    <xmx:FsY1aDG5CEoSIk9WZKKVZDPe1tlZMik4Y0WArN-BIp4UpihOBwAxMw>
    <xmx:FsY1aC98KxRqblRbTk99lR_LvYBf4Kwh3LqdIRj54PrUMLbwWjY3Qg>
    <xmx:FsY1aImrB1io5q4Rgx7diL2XfXIQhyfmTBizLfq-p9l1Lj6B5gbSgQ>
    <xmx:FsY1aNbiFn3Kn8r_WduUvT3XtYfvduoOifLyh22w6F0yVbvqzsy9DarQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:03:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ff87f197 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:02:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:02:54 +0200
Subject: [PATCH v2 6/6] meson: parse TAP output generated by our tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-pks-meson-tap-v2-6-ae360f77786e@pks.im>
References: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
In-Reply-To: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>
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
2.49.0.1266.g31b7d2e469.dirty


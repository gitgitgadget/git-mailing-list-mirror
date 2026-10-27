Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122357;
	b=DGz2U+MKuEmAanN4hfO817wesKiiU0BEcESYeNq71M3i9EbzSeH2DOl+tfnqTa9pdcJ7
	 5NlyA5/LIP9BY0NNMdeBMh64gWXrkO/qvWFmWSpF9GsyAcdWA7z8gO/nXK3tAFpffc8My
	 iiaJ2za79msZYD3y00xuP0qZ0Rk8hmxeWsB22GY2wZELdY67LekLHPa2V04m77tzELA3q
	 KtUDnt2J8mtyuRfj11wsS1SOedaIOM7RcPDDTVaE3UiAcbIChJm23AKQtCRVpErDFhxxG
	 +7B0rt2a/SlkfOZA3+Hn88Q+qRHdbR/2G+38D/9YQv6CdtdhgVk2D2sFHErbpcJuQ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122357;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+QATuBgUGjls7u9/jicUzNJKv4qJW/WclQhHLAOotx4=;
	b=Ol7x4DXs3zzrToL6oB8HqKqT0Qj0KyC7vW+YOXrAVpCjbE5np134NoEWrcs9kockCBlJ
	 MgyAp0cfwGRtFw6lkJMQwUj+x6YYWRnqUFPP+a53jT6dGdunAh8lxAmQK4obM69yE3rWb
	 tKWd4pbYB0F3r/fV4OWSaTsGiJUndnk/eRhrABfWstjKWVC6adBbV2KX/EqT1xsrJJN6u
	 QhfVEEEjhF0gqmb9AYla/gbChACiEK7VKraaviYnT0vCqtFyhsOq+vEIvmbwJAXPk1AaK
	 SvjLBAhIxzhj9L1S2jwrcynbAMuaYz8FSUdD0/VOeJGfbeIuzJMECUrT+8BayqyPQuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=heshsbRq;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9D606A31D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17D9D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=heshsbRq
Received: (qmail 38336 invoked by uid 106); 27 Oct 2026 17:32:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ommFU3RdmjIxXXZBRM9vlLkwnOpI98BTODo54QIznP4=; b=heshsbRqOoBqgbD6+cwHVkDc5Pf1uuzhLsiswXG0WRwoscoMDTQvgs7ryh4nMjUhjKFJj7pCyQRJxbEujVlU4Mfc6Wahh7738J5v8bz6g/tboeCqaW9rY1gX3n5ThKngb+mM0B1wQxLzK10UAIL3LZ8NABG/Bz4988kN8wRFhCpW4GQ6yKDSTt4DxYnIadOhnOQHc5tImEhznyOuxo8dQXT1AKfOLFV97haOpMiAV0VHUHnEM8tLRLcVHFfOxbBRl46GBcrqZFfoCLLcPSXEeRrMFj9zwaXQatUN8/W/uL4dKIDviQbh1asFq26YHDKwUBiOpxI+9yWrKrzxc2BBUg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2026 17:32:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 275892 invoked by uid 111); 27 Oct 2026 17:32:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2026 13:32:35 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Oct 2026 13:32:35 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 1/8] unit-tests: report the correct unexpected argument
Message-ID: <20261027173235.GA136740@coredump.intra.peff.net>
References: <20261027173205.GA97799@coredump.intra.peff.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027173205.GA97799@coredump.intra.peff.net>

We use PARSE_OPT_KEEP_ARGV0 when parsing the unit-test command line, so
argv[0] still contains the program name afterwards. If we find an extra
argument, though, we report argv[0] as the offending parameter. This makes
an invocation like "unit-tests foo" complain about "unit-tests" instead
of "foo".

Report argv[1] instead, which is the first argument we didn't consume.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/unit-tests/unit-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index 752fb38fb3..8eda87856c 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -48,7 +48,7 @@ int cmd_main(int argc, const char **argv)
 	argc = parse_options(argc, argv, NULL, options,
 			     unit_test_usage, PARSE_OPT_KEEP_ARGV0);
 	if (argc > 1)
-		usagef(_("extra command line parameter '%s'"), argv[0]);
+		usagef(_("extra command line parameter '%s'"), argv[1]);
 
 	strvec_push(&args, argv[0]);
 	strvec_push(&args, "-t");
-- 
2.56.0.559.g7c1a1d8168


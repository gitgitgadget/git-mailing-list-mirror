Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5B13D898
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721768058; cv=none; b=LCQbfnbfg6LJuLWv0GTPIXzt6vuSRvERJqxyYnyuS2se5+rNT/EJbo1pJxDzE6kBfRkk33shcshoKkitQHRFqZk3aDGZi1Mue0eCHfEXx1zpF6o8el6qkY2c9DtN/rFpe7Vey4HjcGybywc2mXuY12s9wge1ZAcn5UqR42uPVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721768058; c=relaxed/simple;
	bh=z06Xo8E5YcQ8mczQ3cSsC0+KlXcPY27hlfK5IizBIJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqzUpm1Zij6xBkbOaEFUvKmYHGwQbRbaOXp6AU+HLVp/dnWS6wSObHDnlR0xUjaZvo+7uvigj+sAQnKna3yANE/5Vp3Nl9Oa6wEIjledQSzkw/Ejg3umQeJeXvya/uMkYmp4wlSNSXMf/HcasHlOp+tE3czmDchww2VJvg5wdJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23311 invoked by uid 109); 23 Jul 2024 20:54:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jul 2024 20:54:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3183 invoked by uid 111); 23 Jul 2024 20:54:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jul 2024 16:54:17 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Jul 2024 16:54:14 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] t0080: move expected output to a file
Message-ID: <20240723205414.GC6779@coredump.intra.peff.net>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <af5b8fef-073a-4e85-b660-9672b7d5f629@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af5b8fef-073a-4e85-b660-9672b7d5f629@web.de>

On Sun, Jul 21, 2024 at 08:15:48AM +0200, René Scharfe wrote:

> Provide the expected output of "test-tool example-tap" verbatim instead
> of as a here-doc, to avoid distractions due to quoting, variables
> containing quotes and indentation.

Just to bring our earlier conversation full circle, you can do now do
this with:

  test_expect_success 'TAP output from unit tests' - <<\EOT
	cat >expect <<-\EOF
	...
	EOF
  EOT

since those patches are in master. But I'm OK if you don't want to
bother with it.

-Peff

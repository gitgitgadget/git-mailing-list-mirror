Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F13370ACC
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 01:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991113; cv=none; b=X6SmU4/gvNB3c1Rktz8v43WHvNiHc3Fl0L4Mnxy+DQWsO8asKOHLqqdrfDWP7o4hRFB5MZHHhG86GHmP+CgXfvg6HupeGa9JLG+Ij7ON1g9I/Sno51zM+4ay9gh5jJiiDV+qTTjKO2D9IHu7w9ygmzzOMfrQ3kV28DqcjvZIBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991113; c=relaxed/simple;
	bh=cOFxtRL7g4VFczRvGGHm5LOh0BIgIq0q3P8prSJkmSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RXPAkcjLj8UFAeUuDkSqB0mm6GsA+H+0yGoEDNE+fBMuXEEn2S83eBA0veGrs4SzwKOBjk9eWH6bZgohyDdPE++Jb0eFWSzHEp0wFIUB+TWphEi1hG1fyfES7V1bb6fXMizPYhs3mFb9gzjxRs0w2nCzIUPKZMpiRgXVuX3oRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=muXxi3G4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m1yskvUh; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="muXxi3G4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m1yskvUh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 828A414000EB
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 21:31:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 02 Oct 2026 21:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790991110; x=1791077510; bh=Y9nqFvEcmy
	gBKHm+2cPyPrEpbOmbk9AIlSpkt7VpMgY=; b=muXxi3G4GkaWtMATjmITSOfe0q
	Ojmi3PMMt0shYFj2i9ukUNaiqqhnJh7rJx0SMjSzKCP8X3lfLN3IU2n1CnthLVAo
	Oy+Ox7KOVVO4hjCrOm+SwwKJvrmtk7G9bt1eTzLYwgNUjyv/CQuwkrZnyBtid8+W
	Bcjgd/UqVoZxw47j2zAFHmU3svT6fOkFWA4r3Jac0EH4wvBvHABNqP04Ah7rhbA1
	wmkV52k0t1nsZaXnl/SZ3OVfSw7FyX75Y+lvwB9DKKVH8H+pgQYSFHtRPPL3b4XX
	pNjp2xihGnVuETQOrfQh2jzSPTWX5XFAkn9EkOnJWSKZnefQmv6CaHHhWWyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790991110; x=1791077510; bh=Y9nqFvEcmygBKHm+2cPyPrEpbOmbk9AIlSp
	kt7VpMgY=; b=m1yskvUhVNhOsR7am3X6mCZ4vBR/P4OJbnWDZnAXK4Q+viObiRC
	wPg6ZFKhQyOUynan24Qvg9UicsL83rMG0O1UZdMbLf/wh61ySMWSP9QzhI9wQiPm
	7eLGwBHa6aOHqzirbI3+lm5VcZgZX2mGvhkPpJ8ZDAeRfIobxfgO5VkBIs0++YhE
	q2NfDN5M1ajATwB+4GmZ+hnlBnXdNjbihp/yyfzrWp9Wofu/0w7BfqVh4daQ6RDO
	WLnTRXGdM4MswDZ5BUh3ZCFT3YY9DU9v7hBxytkctatjS3+9SIp9pvcl/O+MZYlR
	1a82d+ohN5aOwL9ieTeiGaGCVgN9G2AYagw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790991110; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:OpiQd17AaiElDlDFEDvAchQV95lV5UtbHxl9xuLBrWfGwX2
	VL3MysYIqAluqKbzNhvXMJafTTQDBlYMyqFNKpc4wgZA/glfNYIJYAWUs2dywI6C
	ocAuUC9InBCQqcWaFmsY/puq/PM6IzD22jE2V1cUfiW5CaiqZ9xf4HoYBVhLiCPy
	RO34o2HMHGzcJovcn22M3whZuiYgD5pBns/8pYQ3uwVggCNqCzO/BQ9na8QbdjSd
	tMywhEjExqfhJIGJcHjx1nXzNTdRT5rT68B5SU8Rv9+RcGj76wBjl2KtrLJLutJO
	wclEiu/TlTDZo+MZ5UDLP8yAN/qz3G4P/29j2QA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4apCcDxPEGWPC10aE0N2AHzf3uGu9arKx2ij+mp+1/g=:cOFxtRL7g4VFczRvGGHm5LOh0BIgIq0q3P8prSJkmSc=;
X-ME-Sender: <xms:BlvAal9bdt_QbWETk8y52LKk3b6RIWGIJmguEdD_r72D6oXPPq0P0w>
    <xme:BlvAagkoPTRA2kuSLifD8ECJltWU4GT_oT6xckgz-OKZolEZ32CfmEFFueKpdXwJc
    v9UM5bnEHOiHNz2fRTO5mDFO3i7eNGIijoF42yzGVCEhUjtN3-fOyo>
X-ME-Received: <xmr:BlvAarW0YIklRE-_49zoazOFcFb6YfuwbWSd431L5WSaPKxtHt1HcdhKQirYqspg08_WKn5FM0Lvs0ytvLNyW4djZAAHL_Jg8pXe>
X-ME-Proxy-Cause: dmFkZTGlj0tRlendte76tkJsae1LC1D+gTlT3QY/R5xo9zE6RX47GrbgllXpsjPmGRmfRw
    PC25HQkJ2iRdE0cY2LcG4RkAGcvrFkyJ5iKGyG13TBlSKg5OcLgU9yVVJ5kEEEf38gZedM
    y9vgqNLQJ8Em4HmEW9XQRsel2FGqLDVPdUI/raYB3IiliMS8sjzPw6ZgO0Z2YagKasLt+e
    y8VOD3me0OrSvB0VeUvhx2I8MeXbjT3ujyhgwbE5deuzF+FXZFwS662/NFCTIAfTebyN2u
    qPZaZxN5gkAWRGDCpart0jPaPQPqI5Z32lHUpK4p08hZZsgO5Su1H0QK4AObIim9G6TYTY
    ShsBJo+hbLbzr6TIy36yVnzO1nQHmcZPM3eWejB9jj2D4680saiou/NGHD7K2colPKvKmG
    7WTFWbiMMZ78m32vuuc5bNXnl8xzw7muZ7yR+iVah2Mm+KJLQ6J3YuCxmUIiv19Zpbo/AN
    hXlCFEQVnSShB44qStmXOjuR4XDS0NF4Mndm7WWtHPs5SGE0D20fVGZtMhxMOYr1Ze1rZI
    3NgXbRuXXwgLD9h0YBjV/gTkf9X99t+uE66cDhRa/eDNK6kzC0qJXFnFUJamvStBu/nBmL
    jjHr8iTjdS1PfnGDLg3gqg6wPkquvyp1ygpSksFduRS3SQRWJrWNQ+JTV2Jw
X-ME-Proxy: <xmx:BlvAalG5BHMlwiU4ZwqeeYN3rgPSIIY7D6uUiaM-N76Zeaed2hVVeQ>
    <xmx:BlvAandqQ4GbBOe7Sw8FBCX5Wpzlpczzw4SZ-z7NmF4LZ31IlELI3w>
    <xmx:BlvAamKYC_ezAbqLoYadCrKWXXN4PwTRbCRWtDF0nDS7npjuqGPpNQ>
    <xmx:BlvAasE1aWcqA-Rux3R0D6cFpWZCGlloBAxBmKc7kZWtbsjGOAOGfQ>
    <xmx:BlvAai3mXAQ0KmUtdmraJg9HJLAF10rKo5_7I1PQZpQQmBV-nO4aTagG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 21:31:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Scott Chacon
 <schacon@gmail.com>
Subject: Re: a "limbo" object-format state for empty repositories?
In-Reply-To: <asBVY1WniGUo6bQS@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Sat, 3 Oct 2026 01:07:48 +0000")
References: <20261002224400.GA834158@coredump.intra.peff.net>
	<asBVY1WniGUo6bQS@fruit.crustytoothpaste.net>
Date: Fri, 02 Oct 2026 18:31:48 -0700
Message-ID: <xmqq33unvabf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> There is some support for multiple `object-format` directives, but I
> don't know how well it works and I seem to remember that we had some
> sort of crasher bug in the past.  That would be the best possible way to
> advertise that, though, if older versions support it.

Oh, bad.  Telling the other sides "I can accept this and that hash
algorithm" with multiple capability advertisement is so obviously
the right thing to do at the conceptual level.  It would have been
very nice if it worked.


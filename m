Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90EE4D0A12
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605600; cv=none; b=hUoAS84YEeHnRkcPGat7pXPWOJq+oIljUz+BclCoZCTx10ubehuPpUGrLQzNSQGzXBwd7cSqOKUX1vIosvPW1l8NTqJB+6M/Ayg+/GNHyIm5Jetfgi5jn8i7SNddtSGt70i0dWfsF7uzZFgiZ97PzYxFn9H7Qz20mFmott7XcVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605600; c=relaxed/simple;
	bh=TQq3gYBSWxa6L+R+I6qLMVORpWcqnPLR2HFsB8LMWdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NW3S2IIQhahykiBGNahw6GYDKEz4jjRNO+pOl2HnwQKKvBmdLDy5m/9EIdu+VvKmf8agq1LWG2rIvnG0ZVX7Np/Wg3+HlhsoKZZKT9razrF3fWTneUgTnmv/I9ZPOT4lGKeZRk/26sJKgVVHgYe3xriTEl+skWXZEnhYVW7fyuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c0M4DrZ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qlGzZo04; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c0M4DrZ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qlGzZo04"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 842B7EC00DA;
	Mon, 28 Sep 2026 10:26:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 28 Sep 2026 10:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790605596; x=1790691996; bh=tHAyZ5RII4
	QIWXPyz/aOhRBdveTi708stcFI+012F44=; b=c0M4DrZ+Q8aaoYN5Qnn8jv+Hbj
	POsaJqVeARdFukpGd1q4P05e5e+jwIhbl/aSdBdqoz3GZ4pZsCZ08aBdrmkwxMnM
	kK+KxPjgRdC0Dy9BuHXkYN60CUCzaHNAMlZXSEpnHi46rFB7PgEw84zASq4hn3f0
	y5rleZFRUbugPME3Mu+oePE/o7UTxUn2dzhWPXMXfEoJRVxkoK/7ZBjS8SYUhukk
	s3sAiWrg5g5R5hWeXpaqOwWPHgkqPDFmhnT5T98OqHfehykl8imN9Hwha5tdbsXt
	5Nz3vJotlNlJhuIEAPWqgY9ThqSRVlU2zQNFSIo6GuAA3jENBlax9hfmJauQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790605596; x=1790691996; bh=tHAyZ5RII4QIWXPyz/aOhRBdveTi708stcF
	I+012F44=; b=qlGzZo04JWNVfh2FMGtzelvDKr/U6WXGoE6ErbtNu6na21CuSSl
	CTHg3Ja9WJURLTOFeX+3jYocRj7CQgyEiS3B90JaazeHT5eIRu0eh7OSC6bDjWa0
	VrFAV4//t3cDunOQGZ8k5cKKilK04sNuqIkalp2wH+TcK6BhhzLCCecgWwpQ02n2
	w1LmXTGYme9kPcVBZEEFvnykEoF7F3SGKH9RF9N2INvc9PBgHL1JzRQDUwkEUI9b
	CEtaF+/+m3vhLbz74Tg86I1DUCgOhNnXZZjv857Mpx6G3nMhUJthQJ4y+BfDNPrg
	Jpqe8NPekST5Ih05HoBV+UdqDVliKqK1Rvg==
X-ME-Sender: <xms:HHm6akVtYHnQxAu8ugZnzvYAV9_vYb-iyR3eJGaAf5sFs4I1fFaBpg>
    <xme:HHm6asTFR9nxDr_sCi58qIMrK8mXpZ9D0iU4g3tQrjEQR0Dh1UGZliaWwd9pm8B44
    FGoHLIHfVrkGvY3UF5dFcqlw3wUv6wLqXTI51V6EzSwSXdmvT_50Z99>
X-ME-Received: <xmr:HHm6aiOnsJBWlrIvz7IEzcR3zolszE0Owfpy2PAWPWqtD233j0MDqfss8UK9M45ANjqOsJejzAuQXQ0tuZTPn0-OnCnP3_Fduz0s>
X-ME-Proxy-Cause: dmFkZTFogO1RbF/K07MhvHAcLccIM4ga9/w2i8rCn8OOewgu45R4KL3jDTgylu9ppRbI1T
    xcQYeW1c0UXr+LbilZ/m/RR/kf7Jzb6NR0aXHNIiGfagkjh3MxCSdCwdSXDzmEqcE40wzs
    HuF138wlYGBRkqxWDdF8BRpRYY9znwJ0d+yNQ3KqCwYE51t8dFEeOv/ip1BYuskrQuc+at
    31lKMC1kNC6TXraXo/ZJmW2s1vi0CJ8snY+bGrkAGW+anYA4P6VPPCfAc12oqw5YSUKIii
    +vTJwEdcGpNetliZqBBzVcQtHppSIm20jjMK/mqA4nZLqEWTleUWJF1F6Efu7H0rL/IVQm
    lOJwCP89+L2cFGEDBSlnwyYf9Ja4nb1jJtbJ6cy5NLsVsTXypmB6zBzQr3a00W6QOuaWSh
    yqqZZyvOvUI1YUt/TiG35BZyQGpmsQ+jMoePpzoMIGo/a5SIisqtysoOGlUrwK9RZsmMxC
    M1A5Em5PktzEpyMctTT5HRf4IjZk1NLBZMp2HfS5gsVtAUAcAMTAurHn0OihzknqzjzZi3
    6ejKCowCCvC3IZl3WLwljDvMxp47xhg7YqIUxjsSWRBrmD/UuyLF7dcJ5XSz+RzeYCjfYU
    r9YYHXq31QexgKesECY+Lnnyt/T370mBnNn3FzuON7qfUdr9FqK5SoNwRdYg
X-ME-Proxy: <xmx:HHm6aqQLkqMYUsxqmexPmm0pZ0SznFnDXzhWo1ABUnI73eCtse3Hjg>
    <xmx:HHm6aggcSjV1jabIFKeQsT5wznQZqQsMBqNS3fymILufGDACxm7xBw>
    <xmx:HHm6aj8-TZzWoElTpBiNFyUlfHegDftaPjz3J-WbVc5TOsNQ7MpC2A>
    <xmx:HHm6anGR7ARwI3NcmAiZ4XG9RTTDS4bFBzYA-CwexjQASPgISSk27Q>
    <xmx:HHm6avwan7WCgQbKnUloOYa0WOP81DuXN0R9w5KhLcZXG6jbIS0Wj5Nm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 10:26:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/4] gitlab-ci: fix the cargo invocation in the
 Windows job
In-Reply-To: <aroOHoSXsemSlP-7@pks.im> (Patrick Steinhardt's message of "Mon,
	28 Sep 2026 08:50:06 +0200")
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
	<pull.2233.v2.git.1790280113.gitgitgadget@gmail.com>
	<aroOHoSXsemSlP-7@pks.im>
Date: Mon, 28 Sep 2026 07:26:34 -0700
Message-ID: <xmqqcxtxpi3p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Sep 24, 2026 at 08:01:49PM +0000, Johannes Schindelin via GitGitGadget wrote:
>> Range-diff vs v1:
>> 
>>  1:  6a389b2bad ! 1:  cdf2eff480 ci(gitlab,windows): provision GNU Rust for SDK-based MinGW builds
>>      @@ Metadata
>>        ## Commit message ##
>>           ci(gitlab,windows): provision GNU Rust for SDK-based MinGW builds
>>       
>>      -    The minimal Git for Windows SDK already supplies Git and GCC. The
>>      -    MinGW Makefile build needs the GNU Rust toolchain, not another Git
>>      -    installation or Meson.
>>      +    The minimal Git for Windows SDK already supplies Git and GCC. The MinGW
>>      +    Makefile build needs the Rust toolchain that targets GCC (as opposed to
>>      +    the more common MSVC one), not another Git installation or Meson.
>
> By the way, are there plans to eventually include Rust as part of the
> GfW SDK? Just asking out of curiosity.
>
> Overall I'm happy with this version, thanks!
>
> Patrick

Thanks for writing and reviewing, both of you.  Let me mark the
topic for 'next'.

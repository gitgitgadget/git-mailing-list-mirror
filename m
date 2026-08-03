Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A0B33B966
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768129; cv=none; b=lb41oi653+HxE5SdBocf0ofsgCEfPjK+QwQvL9sbt3+wCER7wssCkhfDIvwil7lbSj+mgQcgXemtgZkiCwV/egzoS+n1RBs3cr5BajxqwGQo/KeV/a5TTzNeVs1IU1RkD/BDJ9moiURVOgQkPaXmQsRvYmrS8cy53xqnsjMxcRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768129; c=relaxed/simple;
	bh=zsxmBAcmKT5gODChic3ghKf4if7i7u1PP9squmbe7E4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dFcKqb58csvmeyN1dZVum8t07Yk+Q9FOEshb5igaWDWbFg++o55mIIcFMDnz+pfhJCpNO+y8kQ190QNtYtQiF8Pt2Nf+1wUxxW1m7LXnUMlizXOEzkTrdx2ZojQ95xo8vYDvqaTajtYoNLvM7Wftu52hFtGMHPrrWLsDJK3OMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ttRDoh0I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RCKUBDt3; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ttRDoh0I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RCKUBDt3"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 9572C1D00025;
	Mon,  3 Aug 2026 10:42:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 03 Aug 2026 10:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785768126; x=1785854526; bh=CuILClksLT
	EToQmJ7dHAOF2RB8cD/RN0VVVjcczqWxk=; b=ttRDoh0IsGFA4l1bI7VblO1hM8
	tfSd+I0HOcHRWPPQhEl5ffmxWYD/gf0Z2yaHncEYTSINGrA+fYEvBhmQm7gYHkh/
	d7aMvNJS6EGzzhAaKyhTZE6NFjZCEyzTbO+C272HnbkzMM4MCyyza+hQn4mlbJG3
	NHoIxApYrqzPnRYcRYVGBTPysSUDZD13a1uLCY8neCIue+rg89IcclRpVLB0fbgd
	feJfJu+aGGjKzbOWJUeok4HPkly+RCFMYCuV4JwCsi4eIvguEy2d18VvCVx8fb1u
	jz7pCsNB8isaHGRJ8Htt+BNbvhrvEt0bMKCtdl5ATV8gvRX1tgazrVgm02Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785768126; x=1785854526; bh=CuILClksLTEToQmJ7dHAOF2RB8cD/RN0VVV
	jcczqWxk=; b=RCKUBDt323gFWcRFpzUUEgoK1f4fZIEabZ1LNWMd4s2x4CiQEZm
	ehZg9A2tpsomIyUtptcp18PDCfPqDBY2AohcW7GvxOM0Fc3ZspQw4//rAMHtt44m
	0Qthy6GCOrCqlNFygzfS8Kwjsi5cQEHTVlPkXziZcaMEf0pE+VVXP/Y+nq3aTAFR
	Iq7r5Mz3/hjU5Pz4LIky604Dz7QxBbNt8BXZf2xoSfsSbbACZkozJZ66nweFUasc
	msmAQhh8sYPTsXKQ6PnCT9j8Ve/7tHv3TenuXbLbuUBgM0TbgCNt2mjXwbsA3a6y
	bdITZ4VI2KCt5M3t7i5wNyU8rOTCNJKMmtA==
X-ME-Sender: <xms:vahwagLRQ9wvJHgPs3C8WHe3xGRZLewsB_xYTbWD1WiGuPxzFdRw3A>
    <xme:vahwavPE6K4waFtfmWC9sDMS7V094O1a1dkPKwZzf-WJcxYTtY3t8Kx5PVGvAr1Gd
    az2gjA3LYDYp3Uqj1iMbC7GVi9J92vZ4rvbLrjU-0nYG5O12Uei-iY>
X-ME-Received: <xmr:vahwam7rnnclUtfudgtZexq2ACqKmUqjvZ79zhEmAebJeXecmq2tl8weU7uWJT9XmsduzTrECAlOB9kH-mdoUZE5IcjgHca6ow>
X-ME-Proxy-Cause: dmFkZTFdsp8kqXIusjiWCcCR7HdyH3aNKy+HYK+1XqyHci+5lexToiEhr3DUuUVjEpyEsG
    wH3INEfLx+NnYa7qFcpScRXQK9PIMit4/pCNbwk+hio6Rz8egmaEc+cRbTQr/kiKY8+phj
    ZvJJwU9eVFxVywQ2lCgI2yzYf6M20tTvvz33xJXJwp36+Nvhz6wcwu/PmEXejtGsJgAxk4
    62aUuB6zN10dH7WuALUotlUWEDnUmC0D5B9RoIPf6+hz8E8p0AuVEXuRRROMGJ1M+Qkncc
    CWlNMtQpW8Yfo/l7XtUkPq+NX8QIh+UWkj6x16jZ1aA4BCbaaiP3LDYYcCCCkbW79ywFVU
    kBluUaE/G+43OaQoB7Z+1MGU+saTVOPSEAGJdeao9KmhopOq1RHRJVKPqFQfdGeTyVqUry
    uiH76B8se9cubb64OymB3AHlauSAAgi3ZKq66lP7dVgNkwLnssk6XUgp3ukbtDUCMMLSH4
    iMVVwG79KK9s5MHXGsXkm2FqOGJG9WtLcEoH3xyOjXrA5z26QYqhK8mNVOUY5yzY37XGd2
    RqQC52UNlySphvow5MaG/Zto/P4IAjR1D/Y/mqrBvmHvXPKJNOIEK5F+8xTZRF3eq2Pcq/
    kxzhdnoLrjTKSB14uZonBLocVRpFxUrjca+RmZQmqRHIkZd82VNUVHBBeRcQ
X-ME-Proxy: <xmx:vahwap4vgJjn74Hwx0F9FTg0bvSBgV0IgXjk3L5LIAacc9xMoXNBag>
    <xmx:vahwasHIQitcKVcC3VeLLTs4LJ2r9ixekuZVUhs4ZJYGx2Pejw0WIg>
    <xmx:vahwahXecLyjKQRT-TACMziE0PWryp5AshsfHP00jWB14IWQfwRRKA>
    <xmx:vahwaoW9tBcS8Jy4LQ0UvyjN_lxHpQzNoT0h_V7IAM9oTCXMpRy7Iw>
    <xmx:vqhwavBCbAwWr-OtqnPc87QoldeNpD3D25fVaDwGEOktUhdix0lsn3E7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 10:42:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Kenneth Lorber <keni@his.com>,  git@vger.kernel.org,  redoste
 <redoste@redoste.xyz>,  Fabian Stelzer <fs@gigacodes.de>,  Xi Ruoyao
 <xry111@xry111.site>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/1] t7528: fix failure under csh
In-Reply-To: <am_5YymI-UnCT_s1@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 3 Aug 2026 02:13:56 +0000")
References: <20260803004105.36913-1-keni@his.com>
	<20260803004105.36913-2-keni@his.com>
	<am_5YymI-UnCT_s1@fruit.crustytoothpaste.net>
Date: Mon, 03 Aug 2026 07:42:03 -0700
Message-ID: <xmqqy0enz2o4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> @@ -82,7 +82,7 @@ test_expect_success GPGSSH 'create signed commits' '
>>  test_expect_success GPGSSH 'sign commits using literal public keys with ssh-agent' '
>>  	test_when_finished "test_unconfig commit.gpgsign" &&
>>  	test_config gpg.format ssh &&
>> -	eval $(ssh-agent -T || ssh-agent) &&
>> +	eval $(ssh-agent -T -s || ssh-agent -s) &&
>>  	test_when_finished "kill ${SSH_AGENT_PID}" &&
>>  	test_when_finished "test_unconfig user.signingkey" &&
>>  	mkdir tmpdir &&
>
> This seems reasonable.  SHELL is defined by POSIX as "a pathname of the
> user's preferred command language interpreter."  When we're running the
> testsuite, we don't care what that is and always want a POSIX
> sh-compatible output, so using `-s` is the right thing.
>
> I also don't see any other instances of `ssh-agent` in the codebase, so
> this looks like the only place we need to fix.

Thanks for being careful.  Will queue.

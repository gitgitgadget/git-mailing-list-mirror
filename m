Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89B63F4103
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375737; cv=none; b=EqRZ+KGJgAnPNBvyiB+OIBuQbUmatGHjUsTDgC2/u3y5ou+VNGFveyeNo2nGaNY5dKjuzF6T1AxYrThX7rLxL90EsAtQzHu2TK+zLVQgRqlzBla9zN3PpDKQ1obFFtoG8HSAwTbFqdUq7peE3lLihIHMht2xiuZrGFqpBeCgmKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375737; c=relaxed/simple;
	bh=4KjjX4RfiuBAh0uD02B9II9AOoqilxmTLXvsXAkh5m4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rtm7zZG1EdGAiu/E0lyKnjza1I/oXMwGGV8LiAQ2HGxTx4jmS92sin0ixTG8toapzg7JFILs17R8pEO7MGjI521SQHFuSWP6HCAquUdhdnnErtwbBVcij4E2PFyg7Lgzl0thzK2yULNYmpKvaiiJ5b9aYgf9Uqti8PCYYs0TFLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NIon3QIC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lZfc25qa; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NIon3QIC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lZfc25qa"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF78E7A0138;
	Mon, 10 Aug 2026 11:28:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 10 Aug 2026 11:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786375734; x=1786462134; bh=q7Im0p0BvL
	KK9O2P8YL7nVz6n696BgHcyLUCeUZ1fpM=; b=NIon3QICD9+bpqe545pmFqmrcw
	HVNaLsJNPW1rMRpN+5f7DU9/PzhGWkTn4LJEZShZoJniQ2+XseBjpYRbg8LVOLJf
	nbrZA5xc01JljF+EM5vAU49P5GPyTAxK7TozQtwSjBkc47V1hes80sju04di6hlK
	CuIIFVpiKLDPHPVfNDxkW0kG1y26vvxIQueKbivz5y2b4iMzl6c8I0e9Bs4Ww8MT
	qKFHYi6b2Cj8t73WLeLwJYzE26o+IgLw3LlWLopoIjPGDCaPCKTSA56BdqdY3DC6
	vwiri2uWi4wbXT3+RNgWEj+rzlN0IKxhDD11zsmqX5YV2DMHqsBA1ZBhGLnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786375734; x=1786462134; bh=q7Im0p0BvLKK9O2P8YL7nVz6n696BgHcyLU
	CeUZ1fpM=; b=lZfc25qayWTg7Ig1uGI/ycucFdQ282f1QZ0ngNoPYg39I4ht7+z
	zjY+ITBxVI/V2xEP5B6x8GHoa9AKxJGeWB7MEtdgpNCxvQ+ExGf9uvtyDDawlU6F
	v8/6Md/8MbR9NigG+MUFfrKYwzrmlXyLcm01WmgyA7I4xGYcziEW99ntQdN9374J
	toMkX/1PS40V3RIoOe09n4L0Y95nsy6o6+yWxgPgt35yCAONTkBjCk3kTXctjEcB
	2QaIC2Xb1Vk7HShmz1TsUl3MPlFufIH1zHrLmBqSKLxxEUWKxmRKYXizbEnjrgwH
	LLC37ORqK+uftFKsnLQqfsdNXnwaty/wuIw==
X-ME-Sender: <xms:Nu55auGR1_E5LjZsjGNgzOhFmBwcIHE94QdBjTLHWtuzM7LYY3c0yg>
    <xme:Nu55amUDdKKeG6AZNgf6HplldJZd9jr8CVy9vN8OIAEackUebwExFFWM12CaGZMk9
    mP52T7Mo1vew0csFZ_9nxCWoBJxspicqHacZJjqqhRaQKWQFiFqERU>
X-ME-Received: <xmr:Nu55atI9eIuOaSwkakG7Qeg_2cYfYfUNf4r8REsuA34OFCqGXg5nTTNWvWi4AP7e3aHBTZjn-rW_R2qON1kVKa3vpzVYVkpxew>
X-ME-Proxy-Cause: dmFkZTFyty2b/XnudEjsij2NSlW84iSVpnU/2U73peEZ0/kC6BDbUuTfWpF7ZlmcEcikiR
    KsJWQHvqcF/hTqFa4F7nJ+sCZSES7fbd7FvYa3Cw9EcB+db97hrTpqux2VkAFrMPeEAHu+
    EmT+eSUSDEm+1GJo4gvxrXsDT7N1yobbd3mX+8m1jyqRCfxEaEUs6YKEVyaal1/nkty/VU
    4+sKl7N5uGK5AkC+LfAGliPOdFwFrprLsgYJz4NLVA+Hu0WU82OChsw7ynf+tvvvBf0Saj
    IcctLT4NSCKnByNr1MLpB+T0J5DKCpwFnjbg85w9sv7f+ea6oJQqPxOL0IQ25bge7kGDXa
    0Y78Thp9/5R1pAhK/NS9y1UMGszZo/QpVCpP5MyQYZWZjzDTxqhg1N2FlKy5mxzr1hDDXj
    ihOjnF/5BLfTTvOt4kKjoIE8PHP66fKZ9aZp8nZpn8nYFDxalM4QhwFQn8Su6TZGJvO5ZM
    Dw5D8NQRcHumfu1N1/2fxp4+gRY24q0Bx5/wUOgyIer6q/rRgDma9fcQMVgFukyjVXwdpl
    mj+k/WXvCL/mpXuOANraNWk0TpzB3ZUJ0ZVTsuxGkGRj54l00v0ouRJE7j2XfLUaarkJv9
    G0iJ8ir08oRMKuWBjwY33IZjcrmH1UnVvW48l7Wj4QCwLCkRkZ9IbiSEZpJg
X-ME-Proxy: <xmx:Nu55am8MdVy9P7KGYtyBLtPbcDkQORBQZCWwgMG2N_g-u95WmMLatg>
    <xmx:Nu55agI7l-waJ4MPC0U9GMW1RiKNa4fDH1ayA-4kNZcoVPrbQOVQdw>
    <xmx:Nu55ark51gvuZX0lj4VaiBzXJHn67YI9ZxBq7vPXpc-5AaZi2H2zDA>
    <xmx:Nu55akPdia5jWRQ5qghBaqjMGCy9xwV1Z0urjBjKkHSPVUdbmYK31A>
    <xmx:Nu55aooekpIKeS9wqJ0n-emIJvoDbDAkD3XDGxYheKwCTq0i1sYZ_TOL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 11:28:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] send-email: clarify missing subject error
In-Reply-To: <CAHwyqnVWgNThSPnPBVwOb11S9MSjD0R3BRg1ci6yEQR+Vn1kXg@mail.gmail.com>
	(Harald Nordgren's message of "Mon, 10 Aug 2026 11:48:07 +0200")
References: <pull.2375.git.git.1786267394375.gitgitgadget@gmail.com>
	<xmqqo6fb85v7.fsf@gitster.g>
	<CAHwyqnVWgNThSPnPBVwOb11S9MSjD0R3BRg1ci6yEQR+Vn1kXg@mail.gmail.com>
Date: Mon, 10 Aug 2026 08:28:52 -0700
Message-ID: <xmqqh5l26ll7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> An input file to the 'git send-email' program is often the output
>> of 'git format-patch'.  Such a file begins with a UNIX 'From '
>> line, followed by email headers such as 'From:', 'Date:', and
>> 'Subject:'.  The 'Subject:' line cannot be the first line of
>> the file in this case, yet it is a valid input.
>>
>> The only condition that this subroutine flags as an error is when
>> the file lacks a subject line.  "No 'Subject:' line in '%s'\n" is a
>> clear message to display and is an improvement over the original.
>>
>> However, the fact that the first line does not start with
>> "Subject:" is irrelevant to the basis of the subroutine's
>> decision to issue an error, I think.
>
> Yeah, that makes sense, so maybe we don't need to focus on it being
> the first line, but Subject needs to be there somewhere before the
> body.

Yeah, the curious thing is that the subroutine with the loop is
happy as long as it finds "^Subject: " somewhere, not necessarily
before the first blank line.

That is why I said "No 'Subject: ' line in '%s'\n" is clear enough
and an improvement over the original.  Anything else will add lie to
it.

Thanks.

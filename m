Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168E5345CC9
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784232579; cv=none; b=pRozdSxVKWL0rId6FkTHeBRT+qyXCPCjURfiJY/C3bQVC2Aktl0dTWFohJHXjPgyeVn+l5c9bPqrWOKVTU0R42z1w6GehiqYabw1ZSSWLCKGqEYmTd1gipcUGoD3ZUk4pq/COn/XHZNtr7cPV8DL7sb0wKJzfti/vT7vKKev1Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784232579; c=relaxed/simple;
	bh=n2KwpzZiXVXTADAZ9kx2hgjpRf2MKOhUBB0FX4hsf2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fNVCt158TzYJNoiyX45CI6b73FIC1pOzD1G+LvuGBBhnWz9Tfk446cB7ZDj9eGSOFFyLKJOuToxpwvcnv0eXU7vfac1FdRlpnMANFAqjhfc4qsehuPMFORejTAuoYb9+bsJYPmx8/U4LEDjkZmJrs8s8kV+hIZs9ur/YbW8tN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YDGfNXrM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=haJBHJ22; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YDGfNXrM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="haJBHJ22"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CB57AEC0047;
	Thu, 16 Jul 2026 16:09:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 16 Jul 2026 16:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784232575; x=1784318975; bh=9rzf83Y0qz
	9tpVx/4r8rBIqmqsASvBG9gEphxXkmxwI=; b=YDGfNXrM1/6swbwBYP/InehEpc
	OO2uWzDwoy1kJDmInl3Akrdkq9X+fq25Kf31pSqU4v9pWVcbCfjYHjzpjBn9yTm/
	vGMtVSV9ynw1oWwC9aL99jFJjgBb9Rhg0Gaig38yGUR2ysQkT2R9+kKqX2VmFf1P
	6UxoNHRKh/XP7tbFq9KmAUUhzdPVb+QG9MjeVe7wz11KS8PSsFLRGPLjy2tAFyCB
	cEnejCQW/FMG9p+sjVcfJVZY0sySyjtn6+CutKo+4WaQQlhqcQ1JRPZf/lZtvzdN
	nuBlovAS8SWnRbLKHOTn61bTdgknehp6S4LvLxgyJSAaQ8byrMOVH0V3IeMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784232575; x=1784318975; bh=9rzf83Y0qz9tpVx/4r8rBIqmqsASvBG9gEp
	hxXkmxwI=; b=haJBHJ226k1z7segksoJLdNYgM436kjqDgAhB7xRoV7FB+0YOg+
	lp5ID6dsop9u03Fq2uvHYdUfD87Ea9ixyggK9EiTL+dZ79UgBz1oOax5VNnRvEuV
	+UnD9k2qOursjJ6Rdgemy36BKwuDK0yD5OEUUUOgE6Oeia052taJaeOX7G9jqMgy
	Qfa/DLcvJVrDWRTow5yF+V/wulV4BMt0sEcvP4zFdFJI9Hjs+02LLsh/2oDry6ZZ
	7Mvpxr+ZFVrgE2jdRHSd3toJk7WZk+znz01k4HkBFUbTDu2V+LofHqnw6KqmDFbo
	AlqOrQWkb4dvB4gEdd+BYaHr3T7kX3iOlcQ==
X-ME-Sender: <xms:fjpZarEnSicXagsimma1XV3jqjXOyVoUxp69l7ZUjISx7-xVAutBvQ>
    <xme:fjpZarbt3J-CQ4OdJV8asF7KWKnyClBxZRwtfQkA3P0G8PJ22cLCjSducD_1r8_u8
    xoVEHHPmyDULg6RRTC0GxKYFLJTBdgSBeetEDc8mGe4c1fpnizsOg>
X-ME-Received: <xmr:fjpZanySiOK7nqrCuv45JQW_-qKEEDZhjQIsMEzSaSR6bDST3Q18v8ogOm5VF6E6Qcf1KcaNrzRO7rUipUKBAnLgLld2pGPcOAEA1Yo>
X-ME-Proxy-Cause: dmFkZTFhqgQuaM5MTg/Qt9ZAf3n18GXF+FuzLWtNyTTuaCi89gb3M5FEKbxx25U1aYHYPF
    9531GMWJdNTrFXz/NB1PMiB1Zk4W0ioaUMN6jc0z3q8wlfI1YvbHGc4rE6k7rjJd0B2zoQ
    BOAeHEMKM4EP7Gpy27J+HtI5DEyeCBdrY1hlHzbz2CmcwtkwOCN3em43L5q8NNqdNfqzwg
    VYGAftpAcAc6pImdKJZ8pLmGuDLnEwFwt1HkOgNBa1exuFB1pVEgqIx4p7IqPn7y2pnloD
    UM2SR1NGDBPQdNdUP7ETtApACrxvy0X+UNNQjHVpCOwo2KNv/mct4yfcdGh0By+SSCfUi1
    BVk18l2q9zYkgpZBuFmanXMZygRoytUIS85vrDV0ITWduUR9TPAl4UAhsaQTMYcXBSc1Hz
    IQNuFg/VNTbEIKSi7c9rN67RKAYcH/KFkrccMhOD4zKX4R9PWvJMbp++yUELQpye9ceVz0
    VGBKXxFA1gfJ7Tocjwgyz8CvUEKqcacVTUC7tF6zz4lwEfwqyTZQKqKloojK6XJTGReBNB
    uVuOYeJiZTbEHkKMY3rBLQqHqsWRDu0IsXFLn37QEApPQYXzOjgKwOmuN/zrLUPqbDkr8k
    +B2IUfnPl6sZA3BewfnXPYO+c5ExvsiLBprjiTEwfmL5x2Zi0JVgVOtSpu1Q
X-ME-Proxy: <xmx:fjpZalQ-FJMtn50wYsyxjasLhPH_t-l4C8pq8NktaGR5C7I656n3ug>
    <xmx:fjpZasJqzrBIqFqnz6ZQDq60NPXwOZKBCSbB2DXc-EJjMR5pfNJc4g>
    <xmx:fjpZakXRFyXyRoPCeCRzFpIRRJXxDrpSbRG1IEWsKM0_fQ2SO9V14w>
    <xmx:fjpZaoTaPnzgWCa_aCUdS_NSzGjyXZH5pO-RfVIWvvq9m23LauAH6A>
    <xmx:fzpZatzluv-_nauZWs5lUOTjygvZGuCUWYZkqGDOzKwfXGVd2cFUjsIl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 16:09:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Ben Knoble
 <ben.knoble@gmail.com>,  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] compat/posix: introduce writev(3p) wrapper
In-Reply-To: <a2676ec6-39d5-4220-8549-10a17daec668@hogyros.de> (Simon
	Richter's message of "Thu, 16 Jul 2026 17:47:25 +0900")
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
	<20260716-pks-reintroduce-writev-v1-1-ea9038c884bc@pks.im>
	<a2676ec6-39d5-4220-8549-10a17daec668@hogyros.de>
Date: Thu, 16 Jul 2026 13:09:32 -0700
Message-ID: <xmqqfr1ig0hv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Richter <Simon.Richter@hogyros.de> writes:

> Hi,
>
>> +		if (iov[i].iov_len > maximum_signed_value_of_type(ssize_t) ||
>> +		    iov[i].iov_len + sum > maximum_signed_value_of_type(ssize_t)) {
>
> That feels like it could overflow.

Isn't it checking if it would overflow (and dying if so)?

Ah, wait.  The addition "(iov[i].iov_len + sum)" can indeed wrap
around, and comparing it with the maximum value of ssize_t wouldn't
catch that.  Is that what you mean?

Would something like this:

    if (maximum_signed_value_of_type(ssize_t) < iov[i].iov_len ||
	iov[i].iov_len + sum < iov[i].iov_len ||
	maximum_signed_value_of_type(ssize_t) < iov[i].iov_len + sum)

work better to catch the three cases independently?

 (1) The value is already too large on its own.
 (2) Adding them together would cause an unsigned wrap-around.
 (3) The sum does not wrap around, but it exceeds the maximum
     representable value of ssize_t anyway.


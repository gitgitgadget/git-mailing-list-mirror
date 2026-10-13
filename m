Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA553E2FC
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919026; cv=none; b=haHr6MYU+ahIV6Uf82wsNOXXJYDxLcTINPuT7/YvkddzQk8JpNBqmRDMa9MIwxb79tfvTR3yXb9Dn2WykI3bfkqsDp8AslQ2MoVy/ds3SpoXWeSm3vRitfmW3JKXPvGPHJ7T526LqOq05y+AZaBkF6KXtIRFt0TZndNhpyQX4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919026; c=relaxed/simple;
	bh=RCbvCOP/x5yOa5sEasRP/Jk7UZ/E/5pUIz0CE4k9k2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pQ/IcKBych21J9pzob141FzcqCEa6szzOhzLEknY8/na3mFPjEAXDtPl3w+BBnDAZ/Zw5szAAARREXPn4wI4B/d6hB7DGXPvUX9GwELMJJb+SxmK5LLfEBoGTwiGk6EK8e03qxd9DP3MFt+1SgeCYN5wTrE4GpHgWhwOIMiQCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SmfB9x1a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IWjZCR23; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SmfB9x1a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IWjZCR23"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70B3C7A00D8
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:17:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 13 Oct 2026 15:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791919023; x=1792005423; bh=uSvqdP/Kbz
	Ax/0Kbpwpqc+ON+IJTygCERtsINwfvZec=; b=SmfB9x1ach6lPSTVc2y/jG6jmH
	mkhSxUTIcwpnfrkJGMjvFLAl4mjRlVkGygmoQmsnK6fT9e4LRSr9R5wk4aWV1BQg
	lUTWPuMGYSuxEHtxQstKddfArTwMmxbn4Blf3d7QGp0l+Uuzd4UL0ngAiLkYFhyE
	CBnB5G5FtHdevPn/DauFEhwqEtj7/l4QDMPh8Did480AAa0Sf02YqEcAEuuQEAHZ
	vOTaPqo1jfX85PJdrqKd6ledeByeMshOmUBFZxC0hP3RxX2My4+v9aTs0eqlqV89
	HYxa8FrRSzuQPaaMehGtop8cArElShYN4NXBBQdSrmEnQGIFhVp1vHsgO++w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791919023; x=1792005423; bh=uSvqdP/KbzAx/0Kbpwpqc+ON+IJTygCERts
	INwfvZec=; b=IWjZCR232a00RQ+tSiVCnWm5lj9Ou7uIV1jQ4RXlVvfdWrqOjug
	3eC1TqxB7I7Naie0zFZ9eqPBcfZatK5mSDqs3YJlmWZV/cUjERWUOX/cWC7mzDkc
	bAvEHN9CWYNT9GGf+KcKMOgKhSok6EKp24+ZZEFUh0XMLURWZ9FBTYObRZZ/eUgj
	X/KENWBnxvfJ5qFtlwOXq0sujNxOXoY7XEyqUb9c01kDP7VUUDhRv/heEEVkfhjG
	FjYAYjCG/gLy7J8AwpBI+Oh34o/ZbDBKhOHW/3ch5z4qdGIqx1xipzjgd9WrWOdk
	xA9mgrxwC9sJjdvuyIZBqxf2Q+TppPk0yqw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791919023; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:SkePwyCKnJAH/vLTKhZSmamomUILJ3PfbTmoaKVqUjwT9Vn
	H+aSSxcnEpripOSoAMVeLMl36yf/uUz6vh/1C1OCz1MmJDERJOXwG2qkVJY9EB70
	rgjzUY9Atcg9+qJK3+q6Y7/ghel14vMQGGMwRM0g6METM+FKX7RlEPmI1kiH5olr
	2w8vK6R80I1yD3Q7mT52DJ263b0HnLMsybiJSgLOQg0suOquxxar4FWeUs7/+VYi
	1yHHlQPKnIFcNsEy164sz1DCbNX9YVxBj/xFbOVL2FrbRJ/2Ck2dDHOeBgppPv8P
	s3LUq0UWz5p7uRxAGHsujWHgNa2oku9LA4ZNCEg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:3+qRKfooUy6zXQsnq47qXglvI+H/UMo5Hc9MS0XwsX8=:RCbvCOP/x5yOa5sEasRP/Jk7UZ/E/5pUIz0CE4k9k2s=;
X-ME-Sender: <xms:r4POar9KYrjL1Rpaophk9AWSAjz6bInbdU_BFoX4B9KUqy7fBN6XZg>
    <xme:r4POagLI2KP3rbMpbhzkPMMZnOpCAxDvBL54X7gse6cGxs50NIJHmQghVioCuBdqW
    uZa-E725tzuI0pm9FtTlqZsFBHYVW57hwf1kAPcPG9HAoR8AcMRVtc>
X-ME-Received: <xmr:r4POapdkxIiJgTsjeQMa2YkwBC4J1KPUFdwjv0aJCQYC1MxrSfATIKExi0A1ViObAAAxd65lqQBjoj7YoClp5PvQYMdohKImd9o2>
X-ME-Proxy-Cause: dmFkZTGNsSBeQ50dxBSQHc8cdGbPLFZV2we7pvhSrSIh9InSBdxQ+uPtRO8TGcqT+4r0zh
    0hruFjq8PJZ12lE2fAo2e5aOgYC2kTWf9DDtpyfTTrCO6NxIN+ocVOXxbU24qc3ey8cUUS
    cAJOmmPUrk7PKB2VwWEKCl5ryXcavZa3yUVHkrONBbjB0ZhJeQ7mra9EbZYYrQMZaAN4sM
    4ScPR1J8RuTFigUG0k5XKuwwglsrS9Tm2w95nkyGkZuAXmrZX96G1eJgY2sCIN3T22hP3s
    FN9OXvsGwEOc402zupxucIo+jiKivIYQmhEZmh0nu8zXRTm8Mw34qUDVit3xjmgzF7PVa2
    5KVzF2ehtC4+LlQy+YCSVkuUIlX4XJ3b4uaYQjPCLkfyywpSBBOqEZ0YPV169bUWZSlMFT
    FdgvQXrdEdPT0ohHU/eSYp9IxWv+fyz+59VyQz9worRi4In0czb25zHAy5hczzbha/py0c
    g00prSHndlL47UnpTIYVYCjxemiJD51OYbJW1OShObJBEf31ln1qCB1yVXJFq/wlXzpl7D
    gFQE0HFxEQE4pmExceBmDgXtCG4GHjgutiOl8kDBYmzfAUw5gswOxe8NhN5FQV05oyf3hj
    uf4nqCynxxT05noaEmt6JNGnplxK4zm7Pu4gZi83At/aOF9qcW0PTWVsQrVA
X-ME-Proxy: <xmx:r4POan9NqMGSItmb7q15ClwiozYieZp0pfeo1uhbetAjNntKMQ2K4w>
    <xmx:r4POauo3jcyZ9XouRSrSbHfmL3grWpcf0OG8jZZbYyutqZDnOx0_2g>
    <xmx:r4POakCBHX7hKsIi2_ZWldf4SbuLoN2azqGH8UQP_mi-VsCKC6xbsw>
    <xmx:r4POaoyMfdpPIfSkfW8lZQ7yzP0Sbf0_bk19vhYpMBL7wNyIbrznMQ>
    <xmx:r4POaph0nR8lBt6H_85eMBfnAbfbiasmbRMl9bQs0n_qkaphcl4zb7vE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 15:17:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v6 0/2] ci: link failure and leak annotations to the
 test script
In-Reply-To: <2554cf1e-9612-4dbf-958f-f9ff7ea71dc7@gmail.com> (Phillip Wood's
	message of "Tue, 6 Oct 2026 10:52:02 +0100")
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v6.git.git.1791269798.gitgitgadget@gmail.com>
	<2554cf1e-9612-4dbf-958f-f9ff7ea71dc7@gmail.com>
Date: Tue, 13 Oct 2026 12:17:02 -0700
Message-ID: <xmqq7bjlxvf5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Harald
>
> On 06/10/2026 07:56, Harald Nordgren via GitGitGadget wrote:
>> Link failure and leak annotations in CI to the test script, so both can be
>> found from the job summary.
>> 
>> V7 CI job where failures and leaks are reported:
>> 
>>   * https://github.com/git/git/actions/runs/37205086805?pr=2426
>> 
>> Changes in v7:
>> 
>>   * Revert the linking in annotation message, direct direct line fails when
>>     error pointed to an unchanged file in that PR, which regresses the
>>     experiences in many cases. Instead now show the file and line as plain
>>     text in the annotation.
>>   * Don't name the the line number as 1 for leaks, where it's never
>>     available, just omit the line number.
>
> This has been sent as v6, but the range-diff looks good and matches the 
> changes listed here. Lets get this merged!
>
> Thanks
>
> Phillip

Sorry, but I somehow missed this topic.  Thanks for writing and
reviewing.  Marked as ready for 'next'.





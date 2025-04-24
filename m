Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C78238166
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745528191; cv=none; b=K+7RiZeLiWYQ3eLI9CUCiefkAi6+mRAitwfk7bcrwB6EM8P6bSojs2dQ/DcO8wYobf7JN8c4XrCrgJOYDaAk3zRjZ51jWRtdCV0fBUqqRkSXTgT4pcldvqfTLyQqnKZ3YVbchLFOKOUB0wec2xJbWZTSMe5JG/ZAMVYidhMCJNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745528191; c=relaxed/simple;
	bh=BEPWp6BP7TuWN+hlY+ABD6nfQNdD1d8oVJTu82HSz3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aahE9scLgAFnaynv9nF5uPVW4sME1X/ZBzvG8ZFVB1h62m8QmT11JhPApGmg4KGY/MT2FKFZShGtCy5nzKu8cCFp5PLD4FXdIlNQ4kjnHSelHnqpVN+lNWbbbtuU9iWRv6LuXRlcPKylvC/1HTTmqp98Nxba6UvF7rsk6Uo69So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D42SLmRe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M1o460Df; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D42SLmRe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M1o460Df"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 72AF21380411;
	Thu, 24 Apr 2025 16:56:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 24 Apr 2025 16:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745528187; x=1745614587; bh=OTvakfK8qH
	ArpCq76vu3khiRpcUKGNuozK3D0ybwfwk=; b=D42SLmReVhapcIiv5mEFwXHr/l
	NwPdB9lNmr47O4eby7rB/RiuXwQuSY0LVMlS/CeCpGpFGngsmlUrDWA5ZqDn/uv7
	AOY3jSPkMRDDqSx82lVBHJbfgGIX2xIPEuGFlhCt3cvksgKzid9vtQVTvdlVs8U5
	Pg34HcFz5GLNxIImKVDk5rwuQkLnsMpY79TTDIEAP70KwFVIyjfWfv6nNzmVuRih
	p4YB3UImJSb9gf41x21xNT72j4C6+S+CR+eG0AK6/CQDYDeRLGZ/pguRnjaVNLv3
	EOra1s+QssoUMm+TAeGwMal9/sadZukk9epX4B5a8zpEXz/eQbxTiBVfPY+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745528187; x=1745614587; bh=OTvakfK8qHArpCq76vu3khiRpcUKGNuozK3
	D0ybwfwk=; b=M1o460DfpnGyd5mtDNv716O6H6Ol3ES4bgeuSMwXWN7cvP4lvkW
	KRtwX3eoQzN8YVTCiQdfilEpNIbzX7xgmQG12mi8f1DdgmLIcX3oBSSGnZeI9rHs
	pdOAkjdyU2aj9wwAEe+Dh3SaIAtgkxsWGFKY+QZlhjiCsk3eaOQw6VLerwaB9IdY
	kSsDFEyjD+o9L3Cjs5Hmi9W0Rw+67ZpQFbVrZIX2DV1a18Dej517Vl2BiAVQYwJT
	wV22PI1lT14+gWYG+wzJZ0hfVXANI5tcp6yvV5Un60G8lHcJvByUhmlPd4No722/
	jHSN9FP077qtaUUFz/hTKdzCdn82Y7MWn1A==
X-ME-Sender: <xms:e6UKaIZBpO5xRWPj-o8AhbTDZQ-kl9SKBzJg3B7IvcYcg0nnzjjIKQ>
    <xme:e6UKaDZmTBIBxC3FMRN2bhHrV4ZANuu4CBbuKv7Mq7x9mzsKgWnJ818JWLJ7BeJJa
    MTRCkHB9vEEwWnZKQ>
X-ME-Received: <xmr:e6UKaC9hhHMaWSMA9sh4GqJbFbLjmIsZkcFtHQVjpsYNZdf-T8x5YMI82Y50xguWjOd46w5M2RwzAQV11zvwASpird-jUkaphNZF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:e6UKaCoH5bxvrQyx_09XE1iArh-GtirbtaEurtYUop7lmybb4O7yxA>
    <xmx:e6UKaDqN73QWiVaYGZ_8iukfEYcmEB-Y2gGPlYwzOdogw0q6g4W55g>
    <xmx:e6UKaATaPwFB69C3HH1-u4nUBIJNrOww7h4or2g3wcFdPuO2v_ihTA>
    <xmx:e6UKaDr9XMwwn0G9c8KU_tLQNnEn72qO2-LCZV4lyjly3HC3AqZ1kg>
    <xmx:e6UKaGl5mPi-0fhAIpPobq5xKY6ba0X_jtd3wQpbyvsip587_OiJiLUu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 16:56:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH 1/3] test-tool: add pack-deltas helper
In-Reply-To: <9999f7f2-759a-4721-a4d0-6d3bdeb17b25@gmail.com> (Derrick
	Stolee's message of "Thu, 24 Apr 2025 16:06:58 -0400")
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
	<5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
	<xmqq34dxuz21.fsf@gitster.g>
	<9999f7f2-759a-4721-a4d0-6d3bdeb17b25@gmail.com>
Date: Thu, 24 Apr 2025 13:56:25 -0700
Message-ID: <xmqqy0vpth1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 4/24/2025 3:41 PM, Junio C Hamano wrote:
>> I needed this to make
>> 
>> $ SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true make
>> $ cd t && sh t5309-pack-delta-cycles.sh
>> 
>> pass.
>> --- >8 ------ >8 ------ >8 ---
>> Subject: [PATCH] fixup! test-tool: add pack-deltas helper
>> 
>>  t/helper/test-pack-deltas.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
>> index db7d1c3cd1..c8e837ea06 100644
>> --- a/t/helper/test-pack-deltas.c
>> +++ b/t/helper/test-pack-deltas.c
>> @@ -122,6 +122,7 @@ int cmd__pack_deltas(int argc, const char **argv)
>>  			if (get_oid_hex(base_oid_str, &base_oid))
>>  				die("invalid object: %s", base_oid_str);
>>  		}
>> +		string_list_clear(&items, 0);
>
> Thanks. I'll make sure to apply it. My GGG PR validation was broken
> top-to-bottom due to other environmental issues so I had not seen
> this failure myself.

I squashed this in so unless there are other things you need to
change, this alone does not make it necessary to reroll the series.

Thanks.

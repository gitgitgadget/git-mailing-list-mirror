Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964EE284698
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749591100; cv=none; b=u84DjKLDIBgjUAYs35w9kk9ZK5eUhgX7omlgUCJ9rgyDFG6kCovHAe/WCD8yC6/QOecPX7Sk1LYrNYsRkeANyKZAdiEp9e82pmxIHx/zLYyUhM9HElH1Fd9lvqz+42tAUyJNYrdLLMWUKUy4cUhIn1X5mtJkzKjHCQf1OUPgs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749591100; c=relaxed/simple;
	bh=gSGH/aUZsOvFI/YU+LSkW+YtghPvQ2Nv9ncZ29k7pKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HFsloDq9qAJg64+5N2oP1YJ5Z3ublMUbMt8WDV7fN3NvHttmhpeVS4PDIPxUTUOLGj4c1BuqXvqduZWQA0EVbTa3jNiwsmojPXaNt7RUT4Xt/dcoMBoIZ1ikoS13K7FXikey30eamvUdaBC6fxi1CL9wECEDiqU39J8/Vf46TG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ibfM9/bP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tt7xOFSz; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ibfM9/bP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tt7xOFSz"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A40A4138008F;
	Tue, 10 Jun 2025 17:31:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 10 Jun 2025 17:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749591096;
	 x=1749677496; bh=aRdiVisy2uxZuLWuhQT9pDIMpoJVK5d71C6emMAbxlM=; b=
	ibfM9/bPvSz0QewqqrtGIkpf9JclS2r0jQkQ4qzjE5zxPFhfBX4d0q4Hqxm0Q6vN
	ABPjoOByxHlX2HlMsaeymzpvf82E+sG4acZ0iAmQWVlQa13VJyaqiTOZIk2hJRUI
	YaHMTkv/TPjt/fiXL7yYXNr6nDJbXQn3XGj2YVzmr7sCknjXAwxGIbLcTKM+jjzH
	HxoO04T7NX16i+FsyKEv3SyGX69nwTXkrTVUV5VjX9sPv7YwzU+1wvSQLbRjdUB8
	OBkdPbAmsHdR8W5e/n+0szy/7Q53F5wShArwWos4YqZ+ETaYfjhVEi0R1CEHS1TS
	u/zCWWbQhXhSryi7643VwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749591096; x=
	1749677496; bh=aRdiVisy2uxZuLWuhQT9pDIMpoJVK5d71C6emMAbxlM=; b=T
	t7xOFSzZR9DIbCtrW66u98qB4CvLxZvxaBC6+PP6JUNUjCAGefgsKnELLdG59v53
	W7olCtv0Ra4JMUrwAEItxgd9AXK3vsO+QPG0EaOtVBGr237zHnRnEqTET9mJn5c2
	B0oNh5M4ZKuzdBc+CYS7qff6DZAbUdoZ49DqCx+w1iH3eFxvoMaY6ffnZha4nlOX
	qkhagep26cT1pXqLlEjLD5qk/vYDr9DiPzo8JQ7lPaUKL95JaCGCYTwuSud/gFbg
	P4LI3IKpDa3erfi5FwON5FHeTrAlte8eMrMfCjlXSvSaf4/IDBClPXUJY0Z471bU
	TcJS5uDkuYOtUsF0RSYlQ==
X-ME-Sender: <xms:OKRIaCa_aBCrNaF7QSFa77V1_8YzpWcm_UHLtaJqY-ja5Hvfj_WQJw>
    <xme:OKRIaFajU4uWJTMrwPV8smlPi138rUJay-HnpHkKGcjm8xwwqAW9UTfG9fufLfY1o
    JvPCyT0zgY6BDQSIw>
X-ME-Received: <xmr:OKRIaM8nBJY7VGeViPwiY4XgnX_ijIallDR5orem25yOMG27ar5RiJxfL5zsbsvk6fOQnz3j9cgPMzBB8HqsUd3H1q6fx5i3gp3L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshiivgguvghrrd
    guvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OKRIaEpZQBUFYqITjsDV2eBS_BSEz2qEgmpOQAxZzPirB-ggkBReTQ>
    <xmx:OKRIaNpEGpU1SMSRyK8wJKg7oQEUC7WU3Z46qzo9XLlaFN2iMwIv9A>
    <xmx:OKRIaCTJ6RuyOFhQ95IuKPUYj8r-r0GRER_WfkYnTshrHjj3goSZrw>
    <xmx:OKRIaNqNDgV-HrJImJdPdEf5kzw6G4WJeH2jOcQ9r2v94koUvRAfgw>
    <xmx:OKRIaCqvZTsCu8RfyT314jW9Z77Smb3VQfAY-jghZ30uCZ3fFUC6NbVq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 17:31:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 12/20] t: refactor tests depending on Perl to print data
In-Reply-To: <aEiNBwUkjbo2QlFY@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Tue,
	10 Jun 2025 21:52:39 +0200")
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
	<20250403-b4-pks-t-perlless-v4-12-be20ac3db39a@pks.im>
	<aEiNBwUkjbo2QlFY@szeder.dev>
Date: Tue, 10 Jun 2025 14:31:34 -0700
Message-ID: <xmqq5xh3mgg9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> -	perl -lpe "
>> -		if (/^From:/) {
>> +	awk "
>> +		/^From:/{
>>  			print \"From: x <x\@example.com>\";
>>  			print \"Date: Sat, 1 Jan 2000 00:00:00 +0000\";
>>  			print \"Subject: x\n\";
>> -		}
>> -	" patch >msg &&
>> +		}; 1
>> +	" <patch >msg &&
>
> With the conversion to awk I get the following warning from gawk:
>
>   awk: cmd. line:3: warning: escape sequence `\@' treated as plain `@'

Thanks for noticing.

The backslash protecting the array @example from getting referenced
can safely be removed, as "@" in string means nothing special here,
unlike in the original in Perl.

>> @@ -241,8 +234,7 @@ test_expect_success 'pseudo-merge pattern with capture groups' '
>>  			test_commit_bulk 16 &&
>>  
>>  			git rev-list HEAD~16.. >in &&
>> -
>> -			perl -lne "print \"create refs/remotes/$r/tags/\$. \$_\"" <in |
>> +			sed "s|\(.*\)|create refs/remotes/$r/tags/\1 \1" in |
>
> This conversion results in the error:
>
>   sed: -e expression #1, char 41: unterminated `s' command

This not just misses the terminating "|", but the conversion seems
not very faithful to the original.  It used to create tags 1 2 3 4
5... but now the tags it tries to create (unsuccessfully) are the
names of tagged objects in full hexadecimal glory.

> I find it suspicious that the test still succeeds...

That is because the downstream "update-ref --stdin" does not notice
anything wrong in its input, which is empty.

>>  			git update-ref --stdin || return 1
>>  		done &&

And the step after this, which is not touched by this patch, may not
be testing what it wants to test.  test_pseudo_merges produces no
lines, and iterating over the lines in that file produces an empty
result in "remotes" below ...

>> @@ -258,7 +250,7 @@ test_expect_success 'pseudo-merge pattern with capture groups' '
>>  		do
>>  			test_pseudo_merge_commits $m >oids &&
>>  			grep -f oids refs |
>> -			perl -lne "print \$1 if /refs\/remotes\/([0-9]+)/" |
>> +			sed -n "s|refs/remotes/\([0-9][0-9]*\)/|\1|p" &&
>>  			sort -u || return 1
>>  		done >remotes &&

... and then it checks remotes has no duplicated lines with

		test $(wc -l <remotes) -eq $(sort -u <remotes | wc -l)

No wonder it passes, as remotes is an empty file ;-)


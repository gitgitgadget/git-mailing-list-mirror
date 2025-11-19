Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2344D41AAC
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763594702; cv=none; b=nV0l+jscfxmpLElkBd/9LzvpTncjWvQJlFSID1f05unMCurCw5Bq58IX9fTk2fCMA4254YQdymMEymcMxRFMJT/hDW6d1CRhWsgiHLmLLM1fUwskS/TNwTdPf5UYVarnsqt3t/YNded1UC0B8k5P/DIbqVROHRU7dLLC8N1Tm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763594702; c=relaxed/simple;
	bh=j6YUE1h27D/S1az9jAK5/HFTrma79orlKLLMMVhJ1Yg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=grAISz0sFTRdIpkTp9gawhxB9EF4P5x8QpvZ9hLb9IxO1+WOaFLSUfkmhXiqXu/WwWD88zhZQwe3k1oQxk0bNQpE+X8b4Lhge254zqO7Ui5s7yh4w8dcsIBHSXJeG3r/lvusniQixL1DbXxZh3czVcq0iLYWR05kFU9//x1wnAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k6BO59mU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hdgSvO2W; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k6BO59mU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hdgSvO2W"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 46CCFEC00FF;
	Wed, 19 Nov 2025 18:24:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 19 Nov 2025 18:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763594699; x=1763681099; bh=RL2GHc/54C
	kmBC+UQtW1AbxaHrRFKNcRYfN05/74zRo=; b=k6BO59mUQ1XL4x/okNc82D6fHJ
	VgZCXBCR4ni8tHyeL0IM5msBmlnvtWC4oWiH1s92TGsXRYRO3MiyBMOTFC2A5T8N
	V5JCVkfri+9urGz0Y36Lzn9AW/c0lGSMo7wznKWtXuAysNlJ20GH/iLzoM9PxZd+
	DxN4XxzHY+uRaDo7SDDpbvyTKF5oF4j05XS0WOBtgTM5af9l1kgAbjhdR2FWzcqa
	weqwies0nyJSIRLs+q0+iaQC+hAFrBO9nPAZhAN5VQhiJcVVTlmHvfdlbiqoIKqk
	z3OXFIuD2yu+L7bakQsXOdDjO7364lKbCswb8BcaeDdQag7HkJpnjk8zpRTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763594699; x=1763681099; bh=RL2GHc/54CkmBC+UQtW1AbxaHrRFKNcRYfN
	05/74zRo=; b=hdgSvO2WftxF8DDzMiiDJhdIhqE6nnxt6OvSSh/PCMOgCgMXi5r
	aRy6FKYaMu9PiJHlYmmKJkO2UEhyK/r1iNtE1WWAAtDDfW07lkOyL3v02Ll9UCc3
	J0S5d0nmbdShHkGsqkU0jLG8kwNrnQGxe05w1ShqwztUWiDfs6W1wFQltA7qQMrn
	RnamGxXsCTUgdG0ct56AdO++TcdBH3ggyuY4IebW5L3B3Xtyfa+sra/3auelJcSN
	kFJiFsiQv81JlPB20hEEtC/x8egSu+6vA0EDOkZiZc9C4EmfIwwyw5v7Uy2X1d0o
	Kb1Oe8n/CqAR9GTPVbK4IYvLs3ATaVeh66g==
X-ME-Sender: <xms:ylEeaSW7FUaKctm4ySjXFXwg__WtyyaNEpEkIAAJeayrO8UvdyX_Ww>
    <xme:ylEeaVfTrBQ79W0AeXacDrlvO5Pgp7zjZJ4xbHYDMgmKHFdqDp6JH9bcwBfwtGh9y
    s-1RkRcl1bwWGeow1BmXR8xMg-0jw9oZImXJoCXIxlGo2IwLaaEsKQ>
X-ME-Received: <xmr:ylEeaeu4vPxAxGJdtT8V2az2X6gUpd_nehZ3cIJ_smVH-1qzoVYThuV208CX9Anze5MlK5AjmSFeDpM8YYCOwNj4YVnl0aEMOXgZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:y1EeaU8Iw_KNLvJ8Og1Ucx2Ff5Eosd6TLBTj4ehXmotdqr-WVu5hUw>
    <xmx:y1EeaZ1Aa_a5YqrW9Y_zk1-zvTJPn5k1yr96tpon5TtZpq5vcle8Jw>
    <xmx:y1EeaZDqbwJumQNaCspoNQjele5HCMMcG3aPeyyjXkK244_DBHOeDw>
    <xmx:y1EeaVeHXQmQPW9dBfaQQvNkVjRjwuoKwzHgBF8OPKvD_SKJpMQMUg>
    <xmx:y1EeaStY3DB7OMpmbF_eQT8cQSoDWv9IJHVgqTK1Go67ua0kxzZAkyxk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 18:24:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
In-Reply-To: <aR5M65HDuGlTsR77@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Wed, 19 Nov 2025 23:04:11 +0000")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<xmqq7bvsjzlx.fsf@gitster.g> <xmqqpl9h9mgo.fsf@gitster.g>
	<aRudLpkRdRtCAoi3@fruit.crustytoothpaste.net>
	<xmqq4iqsgpu3.fsf@gitster.g>
	<aR5M65HDuGlTsR77@fruit.crustytoothpaste.net>
Date: Wed, 19 Nov 2025 15:24:57 -0800
Message-ID: <xmqqjyzla9me.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-11-18 at 00:13:40, Junio C Hamano wrote:
>> Thanks.
>> 
>>     $ git log --oneline --first-parent -4 seen
>>     3f252ac9fe Merge branch 'ar/run-command-hook' into seen
>>     672cb7c62e ### CI
>>     3af201233b Merge branch 'bc/sha1-256-interop-02' into seen
>>     950efaac03 Merge branch 'cc/fast-import-strip-if-invalid' into seen
>> 
>> It seems that 672cb7c62e (which is an empty commit on top of the
>> merge of v2 of this series) fails win+Meson
>> 
>>   https://github.com/git/git/actions/runs/19447841443/job/55646336507#step:6:689
>> 
>> but 950efaac03 (which is the merge before v2 of this series is
>> merged to 'seen') is happy with it.
>> 
>>   https://github.com/git/git/actions/runs/19448271167/job/55647611566
>> 
>> These two runs roughly corresponds to the with=bad/without=good pair
>> in the message you are reponding to, but with the v1 of this series.
>
> Yes, I think we'll need someone familiar with Windows to take a look at
> that.  The message doesn't indicate anything obvious and I don't have
> any Windows systems available to investigate.
>
> My guess is that it's something to do with the build.rs file, but I'm
> not certain.

Today's pushout includes jk/ci-windows-meson-test-fix that restores
the ability to show the failure log from win+Meson jobs, so we will
hopefully see something a bit more usable than what we saw in the
previous runs.

Thanks.

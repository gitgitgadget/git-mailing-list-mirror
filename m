Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981D28A2D5
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471963; cv=none; b=iZq3GZBKEf/CizcCrz4Fw/l08L5wihtLuf81blDOjZeXExnWaYph8rbKgwVaH1z/11noowmFQWnMPMsc9XIJnv7PneRWXyjI+Z609Ssyvb6Z/wyKRU/cs/qQYMgN+2/yqQAE0h2GAZumva/ftqfEKlz1/v/dJwYK/T3fXBF+gk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471963; c=relaxed/simple;
	bh=CjqgVd2TsU6sBS9xgswk3OMk7Pmr0lhtIUh5DOAHXRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dgpBmgs13XugTFQnGbb8xMRjhhXq9jiYn5TMi+wnaCWy37cqlI9pZiHK0Cg+BlElt7hlO1hCeTCUOStTEF68kpCVcES1/yclQxu22D4m91aza2pbPr72F17pAwSe7/90b+Afn9P9JoTfVXYY3aSXGSkXBmXanLwpoKwbN9eJgBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tyINYPvF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sNGJXi+f; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tyINYPvF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sNGJXi+f"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 61F4811401BF;
	Thu, 13 Feb 2025 13:39:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 13 Feb 2025 13:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739471960; x=1739558360; bh=YvqrT+Dvmk
	1x4mpWnb1KdrCP4giBLuMixQQwyMdbTwk=; b=tyINYPvFnA2fOgptT6O000MuAO
	NEsP5d9vpvg+y2DOUBD4dXO0YAavMyu0C3qGwdl/AAeCfkyawRHXthuC9AbRM0YX
	4mOezeTWu+Eu4zcnlUrYppoCP8O1ppw636NU6gOCZ0hJ0jfkh5pCht8BUCdg60LH
	e+NDEudwBItBvma1ctfJGcuEjyIMlV3XVP9w7oJpWyqzwrsarAJCt3Gl06zdShCc
	jg8aLMa2c6my7a0nIvdSTRnN2jppfmj4CzweSOL2YC6wjVRYyHC4iz010iaiOSr6
	bhVYWYF8P2OUy0BdWpErLaP4/W0fVAiqCzvqBcRbDUCjRQs0bUHuPeMl6ztw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739471960; x=1739558360; bh=YvqrT+Dvmk1x4mpWnb1KdrCP4giBLuMixQQ
	wyMdbTwk=; b=sNGJXi+f0jlK+MyfyQS+X68J2ZucYEq6YMSDSpWbb2eJ7SiMVhe
	uY/K4sNaMcrP5BCxVyaMoOEbc4GA+WNJIpNxuw9Ei3AxqH2l6cscwKeSlviIZlPO
	q1H6cBWCbsRI3VrACucPm1RdtWtXmLhPh/OLv1+BsdRlMpVHE8r/Q08g3Hs6s681
	rWT1th6OdG/yzk8g7XN4o6CLU50X9zWSeNisakCETWskKL5sccz562Jup31vzcuj
	GIbvpyE+e0Thxf/0ZioG15mT+0QaY78F57iNEAY0ObLpFQkhMjtaXcLGZBO5/vrg
	6fHn2qul7XSKVHTzzlM0PF0RtYo2zLpM0Ug==
X-ME-Sender: <xms:WDyuZ5mRv_RhcwdZbdKKWx-fCmp4jDGanm6oO9BIHUj-FlIUmdx_eg>
    <xme:WDyuZ02QYoEW0DAQw02IsylvWGjsn4ozYumh3oREIy0b036BzYSSadCCAAfeS08iq
    mrtcmIyTBkq_I8SlQ>
X-ME-Received: <xmr:WDyuZ_r2-GhQuE7znJ3cJiroq6iIv6GN3_ILp9ZfVFSKhmbpsAfuw_E6GTiEsyJlljujMgOhAMmNFIuvl2x1a-Ww9gnVoQVB3Ss7whI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgvlhhlhidriihhrghordegvdes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WDyuZ5kwQR-dtt2pleglHlnzCuefygd5LEfLKUkf-hLGZrJyZJc2Cg>
    <xmx:WDyuZ33rupeVlxZdXIn0fW-C9NVw_bNn5vO-T7QUZjHqgxJwYHOLAw>
    <xmx:WDyuZ4suS4j57kRsvboTWlv8x41YYY0sz33hWWW1ftXoKKvgOoAgMw>
    <xmx:WDyuZ7VElXgtgjbJ4JoEa_bi_Rw-so2hurdWl4ykhdCUHmtkC9mawA>
    <xmx:WDyuZxqPiKi6AzMHSqgp4VJb9ro9aTo4Q398QCXGvOASjSpczK_mGHNt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 13:39:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Zejun Zhao <jelly.zhao.42@gmail.com>,  git@vger.kernel.org,
  newren@gmail.com,  ps@pks.im
Subject: Re: [GSOC][PATCH v2 1/6] apply: change fields in `apply_state` to
 unsigned
In-Reply-To: <CAOLa=ZQbVBmGnsvWUz0ByW8z5NMgLY2oZZ1RLJeoWJST9PGAvQ@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 13 Feb 2025 04:51:12 -0500")
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
	<20250209081216.241350-1-jelly.zhao.42@gmail.com>
	<20250209081216.241350-2-jelly.zhao.42@gmail.com>
	<CAOLa=ZQbVBmGnsvWUz0ByW8z5NMgLY2oZZ1RLJeoWJST9PGAvQ@mail.gmail.com>
Date: Thu, 13 Feb 2025 10:39:18 -0800
Message-ID: <xmqqikpdofjd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Zejun Zhao <jelly.zhao.42@gmail.com> writes:
>
>> `.max_change` and `.max_len` of `apply_state` are only used as unsigned
>> integers. Misuse of `int` type would cause -Wsign-comparison warnings.
>>
>> Fix this by
>>
>>   - change `.max_change`'s type to `unsigned` since it's just a counter
>>
>
> Looking at `.max_change` it seems like this is only assigned in
> `patch_stats()` where we do
>
>   int lines = patch->lines_added + patch->lines_deleted;
>
>   if (lines > state->max_change)
>      state->max_change = lines;
>
> In this case shouldn't we first convert `.lines_added` `.lines_deleted`
> to also be 'unsigned int' in the first place?

Surely.  Or if any of the internal API uses a calling convention
that yields number of lines on success and negative number to signal
errors, we could also unify them to signed integer instead.  In
either case, using types consistently is good, and thanks for sharp
eyes spotting this instance.

>> @@ -2257,12 +2258,12 @@ static void show_stats(struct apply_state *state, struct patch *patch)
>>  	}
>>
>>  	if (patch->is_binary) {
>> -		printf(" %-*s |  Bin\n", max, qname.buf);
>> +		printf(" %-*s |  Bin\n", (int) max, qname.buf);
>>  		strbuf_release(&qname);
>>  		return;
>>  	}
>>
>> -	printf(" %-*s |", max, qname.buf);
>> +	printf(" %-*s |", (int) max, qname.buf);
>>  	strbuf_release(&qname);
>>

This is the kind of fallout that makes the resulting code harder to
read.  How bad would the code churn be if we instead unify to the
signed integer type, instead of using size_t, and making sure we
use the range-checking versions of arithmetic when needed, I have to
wonder?

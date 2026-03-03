Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B836C9E2
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559652; cv=none; b=pnYmdI/jTIdxNsfes18KfUE/plrpCFJqkU4fQ4A4jiO74XMRWFOR+U1DEjFPvnV8J4syonbnI9+XjXV/u7qjetxkbxCKuGcz/BXkfpvYgC4mcM6T6F8tPQ/aQ8eV8eLRYgJzW8aEaQaYucD31Rw4Ut9AfR9d06VJcOTudVZ3wUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559652; c=relaxed/simple;
	bh=jbd6/u/pyMF9l9YJQUhCa+mIoBg6hp7yrGXVIsEWcAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rJcvGth8rYpprIPR6JvbBiyDXSY2ZA/P1+N0e1rhKlD/iD3pHRH8ndI2rO6QhNcLdIsI1QD3ODsqInmPQhU7qxVRDNRvWiSXvM+XCWFJ2Am4vaoUH9OK+ecHSTQQf5pcTMYm0AWtY/2CKT/sll/lkXqvvJIeIWnmhnkiHaEaoug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A59B2gjA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vByOmk8F; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A59B2gjA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vByOmk8F"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A6E7AEC0629;
	Tue,  3 Mar 2026 12:40:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 03 Mar 2026 12:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772559650; x=1772646050; bh=Tm8SyYXBnW
	lJL/SDClF8VMRl/Ssmgrachzqn5dMwB1k=; b=A59B2gjAVOaD5jBuzHidgMAwfY
	qyf7PMUq/AH9y3nCoAjPNrQFiJVbiUvcQyaT60qNaEawpxbPVwvASlQL8mh7BNv3
	eCtziHtdZWuQSlkFlxENQCMTyW9aZlssyHvZGEOgf95r6Y+vgbT6inAvlsEn+VNo
	Osd3sX5mbqOvs3xXcT08aR1cRsACX7OGJAdGTBpbqab+f+BG7ziza1ApKw3GpjcX
	8cLJN+sxM3P8lUkzo1AN61tSaF97MYtx95/i5DBiR1W2zl0IfmMguCLjHVM55L26
	GHKFQwK39yZ563HlP1At/EYm10VoSybqDYttzRiZFbNpoQTmETRvtVTYcpKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772559650; x=1772646050; bh=Tm8SyYXBnWlJL/SDClF8VMRl/Ssmgrachzq
	n5dMwB1k=; b=vByOmk8FwlhfvaQhBqXoW0W47LF32J9g9pQyjlhAcK/Lf/omgAQ
	vBlycSfpFZmIqXpIEDSUSBW68oxT20GTeJEnFvptbTdPzr+a40lI9Hby6Rjt/Rmw
	FpUfCXAIg9K6DMHTKP1C/flCqGb3tXtxyM+ypCeQBUxt5VTMbHPJvOs5EwCl/jVY
	9aA+3VIvut270DnLuXkVaWCUrEqdhdT7LWv1lkWEBwzpE6OsVeD3wV9CTGMNVi7D
	pP2D+xaNo2z6ZMemdsPb2/x3gL2/f/HT0+PJz0ONJmSwTkYQaWEFXZFnLga8u2nM
	tImv22JdPqQ+YyvGF60Tf7wkw5IKhfSumMQ==
X-ME-Sender: <xms:Ih2naRNQnmT8TpQvqCG49gFn6-weoIsJlWJP-s_toeISu7Uv8YZqpw>
    <xme:Ih2naXprTlbnkxe6SQhISAmfa3mRE5x51zRdq5AmwMcwuSgZlxI6mNcDhUiOWQX_c
    mUGYX-kdmaZ0IcKuujFkb_tXJyW2yRGe-EzIR83BbGKF2CaJj3TMw>
X-ME-Received: <xmr:Ih2naaG5Ll2_qIloJtDcHAtVnIuzJ4FqsnEneBQB8cOHJRfHzW7ayOURM4HpkXcVccMN4IOTpmIrw7ANksrH5j5sV31wjSZu4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhho
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ih2naUofBUqTSiNEmVRh8RaxOtrBNBWmst_bU2tBsQnTo8S785Ol6g>
    <xmx:Ih2nabad-IirWSaiQWWUZSwZzONzaBX0Z1mMx_OXMzdCe27kyCx28w>
    <xmx:Ih2naVXJhHa7q4MS1eoIqUc0uNELQ1qqk5RFZdTTsAfEkeIcXVAEUA>
    <xmx:Ih2nac-N0CGd6cb-9rmO8Vmha8dxMHGyg7BYYCFNS-9U0UqYO89vsg>
    <xmx:Ih2naVxBFhRgw7_StrH7fCBjUERHorivgUoWIBFr5lc3sXlbZmSZLYAP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 12:40:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,
  kristofferhaugsbakk@fastmail.com,  lucasseikioshiro@gmail.com
Subject: Re: [PATCH v3 2/6] builtin/repo: add helper for printing keyvalue
 output
In-Reply-To: <aabhtfWZG90YyhQ5@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Mar 2026 14:27:17 +0100")
References: <20260223174120.2356504-1-jltobler@gmail.com>
	<20260302214526.2034279-1-jltobler@gmail.com>
	<20260302214526.2034279-3-jltobler@gmail.com>
	<aabhtfWZG90YyhQ5@pks.im>
Date: Tue, 03 Mar 2026 09:40:48 -0800
Message-ID: <xmqq7brserq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +	print_keyvalue("references.branches.count", key_delim,
>> +		       stats->refs.branches, value_delim);
>> ...
>
> It's still easy to miss any mismatch here, but I guess the result is
> definitely easier to read regardless of that.

Sure, we could further do something silly like

#define P(name, source) print_keyvalue(name, key_delim, source, value_delim)

and reduce the above to

	P("references.branches.count", stats->refs.branches);

if we wanted to.

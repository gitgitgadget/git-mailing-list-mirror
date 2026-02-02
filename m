Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA952F3636
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770057777; cv=none; b=SE4lTRI/VBBzS8F22yTcsK0nQAhs/aB/AnqASUevhLK0KJjwgB0y16Zk9yJXnLneCOPI0K1fzwvdjobG9HA6GXgmxJzrZEFIIkrmBQWkEB8QxiHMMRWqK27JJHdYwasZRz+sfThj+sQo9dqTyJ0ovq7nYk41mpNI3eGx8Uz6QK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770057777; c=relaxed/simple;
	bh=K1YMYpt+OX92sX0a5nPsNh5yn42qosNckYCkQ6A32DU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gh6oaJWOLYDXVWcOp0xU8Ptq+AvGCOD4ik29TjqUQ0cU6M8eyTthSk9w4wKy51Q4G48kxo+1YzINtJTg/xk8hYmXBTtztOrTD9Nb2CmHmZMprrIM8c4WBJvVN0jMoXvAOveRs97QLo7kWb2oATvTRMmcUnjHtpwN5QXM3Kb3etE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RMysto3x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WfEoKWhV; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RMysto3x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WfEoKWhV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3CBEB1D00027;
	Mon,  2 Feb 2026 13:42:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 02 Feb 2026 13:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770057775; x=1770144175; bh=Pn2Pis8gB/
	oHBE+yDGAjDo+XtbxAAlvHVWVoHS4qXkI=; b=RMysto3xE/ZZjH6FaigpfFHTOI
	rU9eYbcGd+kUhhhQTe7QfyNh85h6hb89Yy7UuPytvFCiR7wh0BWP32z5lr2YOXtN
	VdN9Ji9qZ1hPBmNIxtkicJ+uZqSklbBtldLyrb5finlN8ybxpFbMEO5OExBqgKHI
	4oG4r/tetnXMP9Zvg46ETayqSy6pvmrxlkf6v8xxh0wJMRfvjC7Cc19JF+PqR9VY
	YAiJJIl2Tn5fwtcB8qQYZCsIPtRpHRBygVQs8y5WSL6LsRAiUG2nYE//apm7skyW
	xEmKp5dua1hUh2dBlHiXeQnaRI/JTSbrQyxEV7m684znVNEyBimfBek3L00w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770057775; x=1770144175; bh=Pn2Pis8gB/oHBE+yDGAjDo+XtbxAAlvHVWV
	oHS4qXkI=; b=WfEoKWhVfBAMBSx46eVaBOlvSSIpbThmBBzuQRHwdiYSiMHR30E
	Vc6t1FZ+ZyUa8qG4OxJiCxFtl86/sRsmVj8/wBl9i24Kzh9cA/uuNfHdIA8PlchO
	z68/RCQBVfGKO2z0d4/ophlSGHElMq3eoIwdVGVgANQrmGtJcsikO7/392CGHfg8
	f4nFEb1qCE0cndYkWFpNyfnBrutYO6QrTE9TDIAXzLobMYY9pcOMthBPhIRx0Mlr
	kHD9p1iWDOLEAYACxx/LwHIrKuR5pjuEQGa/Sj44GgvCbBY0V64Ip0sLqbQ+6w8N
	St+yOlkkfRXLGKqARZxibwkmF5vnFxT2Ddg==
X-ME-Sender: <xms:L_CAaXZMUv69zTPFqtvcBCdfHy4Uk4KWaI1Cipu8xIF6TY2LnRoHaA>
    <xme:L_CAadZSs21mZmxqVEsPjhxqIqKeriSL6gWqvdT4PvpQrgu9yDBggQX2F6qmfSQrb
    li5z5duah_bRysJMARd577aLCyRyq9aqowpKFk9r8wHaEI3vnIZCw>
X-ME-Received: <xmr:L_CAae-W-DBVpBfXSB0QMHatOW0AyH3gaUWR2jPCTmElhP4A06CHeZ043d9XNrQOptqRGZq3gKc8_QPtxkygvc4KTS079d8Agg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehshhhrvgihrghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:L_CAacgL53ACicCjbiuzsM954etzpyQ3QDbRhCOGooF9rdEu6hihxQ>
    <xmx:L_CAaefplqBG5V4mIc3qdRAQ2Yr9iZqMHE0fluKQuccibwTf-2LDxQ>
    <xmx:L_CAaTpv8TfqF8SQ93CFr8_V0VjgWTH7omW73VwnNGTdnL1RZSbjkA>
    <xmx:L_CAaTCLHRlmlO5RMTvmzF22OnG5ZufBwV97CQvLq3qHXKLhtaeKLQ>
    <xmx:L_CAaecdVdUBGtbNZiId4cyS1AumNsr0k1tFAhygXtryFAOfiuUDQyNg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 13:42:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/3] wt-status: replace uses of the_repository with
 local repository instances
In-Reply-To: <CAOLa=ZRv4xsy0adY_BcXQkypsgYkLNM6x5LhJGX+B+=aKCwmgg@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 2 Feb 2026 05:02:08 -0500")
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260131190106.389289-2-shreyanshpaliwalcmsmn@gmail.com>
	<CAOLa=ZRv4xsy0adY_BcXQkypsgYkLNM6x5LhJGX+B+=aKCwmgg@mail.gmail.com>
Date: Mon, 02 Feb 2026 10:42:53 -0800
Message-ID: <xmqqikcfyok2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> One missing information is why is it safe to make this change? If is a
> repository field, is it holding the same information, is it always
> defined?
> ...
>> @@ -150,11 +150,11 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
>>  	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
>>  	s->use_color = GIT_COLOR_UNKNOWN;
>>  	s->relative_paths = 1;
>> -	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
>> +	s->branch = refs_resolve_refdup(get_main_ref_store(s->repo),
>>  					"HEAD", 0, NULL, NULL);
>
> Wouldn't it make more sense to use the function argument 'r' here?

>> @@ -1723,18 +1723,18 @@ int wt_status_check_rebase(const struct worktree *wt,
>>  {
>>  	struct stat st;
>>
>> -	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
>> -		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
>> +	if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply"), &st)) {
>> +		if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply/applying"), &st)) {
>
> In the same file we make a call 'wt_status_check_rebase(NULL, state)',
> so wouldn't this break?


Good questions.  Thanks for a quick review.

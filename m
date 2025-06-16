Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0BDA31
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750035208; cv=none; b=SEGHprDY61MEH8r59iPgKypwxAV3kEI8IisnF+aYASbvplDXiLy5WcwGKCzLRBRr57Wi6ZEG8McNoXVoh0O5hKHyDl+nP5dah0EdMcCTurTPZtzUwKjnuPfzO0i5XP0b5caozyqX90pNVhNYUod8z2b8JxpLuctghp4hiRpPbmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750035208; c=relaxed/simple;
	bh=OKynlPdD7t/sqLfp7oEvSVoG1gL/ZNmEB2Se0q+YyPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N3KmXIhEiJdli0Pbc8UGduRdM0urJaIBllfUjQ/y7HNy0frptdXtG1HA9/Rmsqc5LARCH1snZeXTQF3/UDDQ0++Zf1bRX6J4O6BRtFmWpUZ1KqdKxWlxbCY7NQg+eOQbpwXHeIWWUU++5kJJDKaTS5j7Rw8mAzWHF6eu7eXZR0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UwBc7pO8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bpBbiwds; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UwBc7pO8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bpBbiwds"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8114513804DB;
	Sun, 15 Jun 2025 20:53:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 15 Jun 2025 20:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750035205;
	 x=1750121605; bh=vGvpzASfnE+RzxVe9PxXvCxVK33U4THRxlIBnuN2vEs=; b=
	UwBc7pO8PDFI3TFkSlchz6IVlgj1ZJgQfRDEyc5m2vz5BKewYSPcMLV7jMHQJ4/b
	GHSjUBCvvT/l7ia1aPrSGsz6oMavoqVKQozMVFJKGdSGzrrMyL8IpaiysRU9B8sk
	rytkKbHxoPAoTLwzKJUha+2Epgy69/XekZtC5cn0gKlHRuw4UkfB/oKekV0yCKRH
	qLn+9f+Mnl+CDd3kzcn0VMh9j/qm7lqabmEUtwo4grPLQpYwUpdKB+mO1Zrgt04W
	GJ2OPrwCAZSmMbc01cLhMux4ex6DhmLGdXSvYiPPaITBXTyAfFRflkKuvV0qfxp/
	DPKqVa1aN+lCIAneNMe6PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750035205; x=
	1750121605; bh=vGvpzASfnE+RzxVe9PxXvCxVK33U4THRxlIBnuN2vEs=; b=b
	pBbiwdssLkUYynBC3xov2mwvIhNHbed4Y4FUdoR756ROMVg38vIqyY7AdzX8Og6e
	wxK49j/dMRceoOzAQ9hlj+ZVgtEC5rsoMhm80IqjIvhi+/kE3m2jTH8ALVNIeVsi
	T1Oj//MXL5uQqfBKoZOB4eBA0YqNJ692BlzQu1QO5uM+xO3vLQaVdEf2ZHItS7FA
	NazpiQ5DhzGt0HixLuKMX28T51VfBUa7iWAl6byGXvRe8ji7q/+2s86PhBymUIaH
	bLJldhgA+IfeY75Te9bAFyht1EnoSqAe3f7Vl1wGAY5zjuKlWUBHCvBpjqAWtFhG
	peNQlkJdsAVKIwHZ+fAjA==
X-ME-Sender: <xms:BGtPaMRlo_BT9JX1hU2PzCB9WUr-HA-hiA8rQBEVM4y_yRgyq8Ir5w>
    <xme:BGtPaJyIplNaXhT4316qkJrdxRQMndGy6tKkqd4CaRFtRdlz4LAXG2d3FrH74nqyB
    oeYubfnqw09sfsBsg>
X-ME-Received: <xmr:BGtPaJ2q1GvictkQn2pIaaqGy-V82m9uwVbB9r5CyrStun9_akTu1EYVPLR2o80_HHNpUTYR9QkW8V0lYhTkvIGrbnWEEUueCpGm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvhedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopeehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuh
    drtghnpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhh
    higrmhhthhgrkhhkrghrtddtudesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BGtPaAAfda4SqiZ61zrVGe8gnzl38E_eaM9R2GToq57MP5gx54oQKA>
    <xmx:BGtPaFj3-1GsOCLcwa-V4kDduz5VrRoofEvUuxpWHKGgU94QKkJ38A>
    <xmx:BGtPaMr8hx7L011iI8KlmFpJCsQb3ZQxpmsbyf849ELDA0rUIGMjag>
    <xmx:BGtPaIiv2dWy3ROePd4PyMLqP_JokZgwuyIhgkXn5dPFF3caqH3hxw>
    <xmx:BWtPaOFdQ3poX8QuWQTv6ex_SBAMKcv2eKF0bXNiUpTsfT2hcZg7hRep>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Jun 2025 20:53:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <502024330056@smail.nju.edu.cn>
Cc: git@vger.kernel.org,  ayu.chandekar@gmail.com,
  christian.couder@gmail.com,  shyamthakkar001@gmail.com
Subject: Re: [PATCH v2] git.c: remove the_repository dependence in
 run_builtin()
In-Reply-To: <BE43915C-E780-4166-9C23-81F9A8CBDEDC@smail.nju.edu.cn> (Lidong
	Yan's message of "Sun, 15 Jun 2025 09:49:55 +0800")
References: <20250612045905.3023227-1-502024330056@smail.nju.edu.cn>
	<20250614050331.304405-1-502024330056@smail.nju.edu.cn>
	<xmqqwm9d6gn0.fsf@gitster.g>
	<BE43915C-E780-4166-9C23-81F9A8CBDEDC@smail.nju.edu.cn>
Date: Sun, 15 Jun 2025 17:53:22 -0700
Message-ID: <xmqqsek04id9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Lidong Yan <502024330056@smail.nju.edu.cn> writes:

> Junio C Hamano <gitster@pobox.com> writes：
>> Sorry, but the above makes it sound as if 246deeac (environment:
>> make `get_git_dir()` accept a repository, 2024-09-12) that retired
>> get_git_dir() and introduced repo_get_git_dir() was the culprit that
>> made their semantics change, but is that really true?  It appears
>> that in the version immediately before that commit, get_git_dir()
>> was also a reference to a variable, without any lazy initialization
>> the above message says that the code tries to avoid, so I am even
>> more confused after reading the above.
>
> I was reading the code in master and noticed that repo_get_git_dir()
> no longer sets up the environment. I’ve learned that I should use git blame
> to identify which commit changed the code, so I can make my message clearer.
>
>> Perhaps you have 73f192c9 (setup: don't perform lazy initialization
>> of repository state, 2017-06-20) in mind?  That one did stop calling
>> setup_git_env() and instead force a hard BUG("") when git_dir is not
>> set up yet.  And that BUG("") still survives in repo_get_git_dir()
>> we have today.
>
> Exactly
>
>> So the call to repo_get_git_dir() may still not be made from this
>> code path.  It may not attempt to set up, but instead it would die
>> if we haven't successfully set up the repository before.  The
>> relevance of the comment was not changed by 246deeac that moved this
>> code from get_git_dir() to repo_get_git_dir(), and more importantly,
>> it was not changed by this patch we are reviewing here.
>> 
>> But stepping back a bit, is it what a9ca8a85 originally wanted to
>> achieve with this comment to "avoid calling get_git_dir()" in the
>> first place?  Once the guarding condition is satisfied, it calls
>> trace_repo_setup(), which in turn calls get_git_dir() anyway.
>> Perhaps it wanted to explain why startup_info->have_repository is
>> checked here?
>
> Yes, I think so. Maybe updating the comment to say 
> “call repo_get_git_dir() after setting up the_repository”
> would be more appropriate.

I do not think so.

e5b17bda (git: ensure correct git directory setup with -h,
2021-12-06) unfortunately moved lines around and made it look like
the comment is about what happens when the if() condition holds, but
if we look at the way how a9ca8a85 (builtins: print setup info if
repo is found, 2010-11-26) initially placed this comment, we can see
that this comment was to only explain the reason why we look at
startup_info->have_repository there.  "Only if we know we have
repository, do the trace_repo_setup() thing because that one calls
get_git_dir() that would die otherwise" is what the comment wants to
say, and if we revert the moving-line-around done by e5b17bda to
recover the original layout in a9ca8a85, I think it is clear enough.

But the theme of this patch is not about improving the comment
anyway, so it should probably be done as a separate patch (if we
really cared, that is).

Thanks.

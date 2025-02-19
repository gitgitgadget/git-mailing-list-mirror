Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357C14A91
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980986; cv=none; b=PZdQELKQ43rxAWpn9EYPET/18LcU9+gOvCBSPUlKAe4QXnQF4SGnxI8opoYY1Rr0wxX7T/fznO2nJhosyZEk0gMxJid0cys4BFk/Aq4FNsqlj5+3JyyJ7A5zjX7agDDB9brX6cD8Km6z/Wic7+THk5g/Fyl2QIX8Wt4wDIsdHo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980986; c=relaxed/simple;
	bh=MHd7KCn/kV596PMBu/sMFu03m4yHA4QDtG0xKfMPOSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fvMmZq6esrvXFO6FKoMly/eNR7sFv7OtNsofAJEuNiVsrRoc0K3r2tR/4iIHxYRq/Y78J4zkpcW1OTmsG+ZLxH1UmbF6/DAPSdFEYdUA+FuKWxmcef9ZsIkKrrOxOB3nKduZUNs93l0dBlDUobNoHtzwNrUZbD68PID3MCt8Iyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f9dDaXAb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AuW8PXcl; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f9dDaXAb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AuW8PXcl"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6940E138018D;
	Wed, 19 Feb 2025 11:03:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 19 Feb 2025 11:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739980982; x=1740067382; bh=4jLv8uGN1l
	ckM7J0AIUuCTb0vqWPZcDuyVrK8RwOdFU=; b=f9dDaXAbRUTqbV3iQCKQBNKg4I
	7/sKkDqdmVREVmrJxbjhqm6eaaLYHvev5P6RP0mC/SN3gW+IzI4Gbs2m9vNlTyZP
	sKUh9kQylPxfMpNWzsVHOKtn4nEfIaZ5i9rwD2fOWopu1LJ66E/uIz3uNkCsrDmk
	OHIQQMK1gkv13e1D2jwoESjAZg2OxtHEJSKhsEGuPGIv0AIA6J89K6jKKk/b49ef
	XoTLne2hLt8WAC9acYYsU/TbeQHVTIvWxcBxN8IjBiTsaWnFzzkaHuKCzRMGMoAS
	efABWeuHxlXOqDaTDpjDuLGiotbrOH8Wsjav3mlnfwvo7MoO4/3bBDhm7CYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739980982; x=1740067382; bh=4jLv8uGN1lckM7J0AIUuCTb0vqWPZcDuyVr
	K8RwOdFU=; b=AuW8PXclPDWyzu6A3nfxCyulapHwSEU5jcJwpY58si9Cg2lF+6Q
	xyKW3i5t3GD0wxIDBazUszpVMGQN2ELxZwX/LRtNWYhpH7HdXOjzQeipTDBiorXP
	Hq4xK195lvwZ2q1ejtifLfavfbeBQyPtLpF00w7GHnTqCwXmMv00IjvBOaht2vid
	rAT363IHyJSxelt+0BfJMeVcT5DQqhHfGZamPnKkjSoTYssg7HfsSoaW22KWW/4P
	NIC3giJ1AORLZxyvCwvqxf3e4iTu7B4kuU+UGu3kbN3OZr2ggl4BoZt+uWdvR09c
	4/o/hj0pnZHNQoSUrxbo4J7QrLa4G1OP0Ww==
X-ME-Sender: <xms:tQC2Z-2MmYQr_BoyIiXikxOSMB0Qwrtx0OaECrrJO4GbqqKGfTyEyQ>
    <xme:tQC2ZxELcCIAyrf7GD7yHXSk_RWjs94SY1-_Mq9wofqop8Ny8GlQK9gP2mzMWdlXr
    1Z-GdN6GMpozzLqPQ>
X-ME-Received: <xmr:tQC2Z25Usjx6BloUABamKEfVzbeok8i6hcwYdhIyrJCtcTZMaxP9GV-eHN0Jy-gdooPtTMNsDtqI8yqLbI8Gcs6OKWVVEAW0Op880Ak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvg
    hlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tQC2Z_0yFI5cNkwb39CH-52KDpOMyzAaUtkJK8XyfQbmkN69GkkDgQ>
    <xmx:tQC2ZxHI6EdDudrGD74Oojy0zPsHUKC44IXIwwk9qt5rnkzNhuafGQ>
    <xmx:tQC2Z48Rb3Bfl1xhXbJgK8JlDwF1sx2m91y5o6vYTRLHTEZ6gAY2jA>
    <xmx:tQC2Z2mFgk0GHUeVr982sEcIWJ7wZDHcFX8FY_0exrXoML6pZMOLYg>
    <xmx:tgC2Z417pvSDDD-PqMrsh-9fuTntzP65OdIMv5bWOuSXan4-HzNT11F0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 11:03:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/5] merge-tree --stdin: flush stdout to avoid deadlock
In-Reply-To: <Z7V48_q3Uu9d0D3Q@pks.im> (Patrick Steinhardt's message of "Wed,
	19 Feb 2025 07:23:47 +0100")
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
	<pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
	<3b3179785098580f3336bb24bdbaf0aa1366bfcd.1739895879.git.gitgitgadget@gmail.com>
	<Z7V48_q3Uu9d0D3Q@pks.im>
Date: Wed, 19 Feb 2025 08:02:59 -0800
Message-ID: <xmqqseo9hqh8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Feb 18, 2025 at 04:24:35PM +0000, Phillip Wood via GitGitGadget wrote:
>> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
>> index 9a6c8b4e4cf..57f4340faba 100644
>> --- a/builtin/merge-tree.c
>> +++ b/builtin/merge-tree.c
>> @@ -18,6 +18,7 @@
>>  #include "tree.h"
>>  #include "config.h"
>>  #include "strvec.h"
>> +#include "write-or-die.h"
>>  
>>  static int line_termination = '\n';
>>  
>> @@ -623,6 +624,7 @@ int cmd_merge_tree(int argc,
>>  			} else {
>>  				die(_("malformed input line: '%s'."), buf.buf);
>>  			}
>> +			maybe_flush_or_die(stdout, "stdout");
>>  
>>  			if (result < 0)
>>  				die(_("merging cannot continue; got unclean result of %d"), result);
>
> I was briefly wondering whether we should rather move this into
> `real_merge()` itself, which is responsible for writing to stdout.

Indeed.  Its "if we are working stdin mode, emit a line break" near
the end does hint that the original intent was to ensure the output
goes out before we return to read more (even though the code forgets
that the stdio layer buffers), so it doubly makes sense to place the
logic to flush before the function returns, no?

> But
> the only other callsite doesn't really care as it will exit immediately
> anyway. So this is probably fine.

With the current set of callers, yes.  When we write these
sentences, our imagination most likely fails short to come up with a
reason why the next callsite needs to be added to the program, so I
would strongly suggest flushing inside real_merge() IF it were a
public function, but because it is a file-scope static helper, we
hopefully will remember we would need to add a flush to the caller
when we add the fourth caller.  So I do not care too deeply either
way.

> Overall the series looks good to me, thanks!

Thanks, all.  Let's mark it for 'next'.


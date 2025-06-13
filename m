Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4C1F9ED2
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829568; cv=none; b=ShfNkOiyWNwg5xCKa2fKV5+vp+cRyB1yOWjMkwuLqOhoA+GeVqT9mayX7dLlpt7J7TmrdJ762t23LNbqwK1hsu+xoXHwothRCYadn7+ImTLJZBY231iu1Wc1eDWSZl88OI+EBuzcqFvQPSgvCUfDwluPNuEy262zcesva6AN4bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829568; c=relaxed/simple;
	bh=IOD9sGBxr7feZxH6+88wdC3U5tSL7TywY+jiXYUCDos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rn/G7/Ify9P8+6NNV6Xrhnr+KH2nxacUcQGl5lgxQzlgd9UXg2pe9yuwidehHkkbQ5Z/Y0h+mEHuvh5ljbvLje84fQvIDtLBNTMxgxn45T7bfUaZta/pAqPIMAZnecsE+HqQPGgxaj7i4NqM1mMG2iYTjdCmI8l7s4rrmNKf79k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zOQRRd8U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNJlDRyU; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zOQRRd8U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNJlDRyU"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A1D71380398;
	Fri, 13 Jun 2025 11:46:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 13 Jun 2025 11:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749829564; x=1749915964; bh=P5ekxK23bf
	mZYDdozwmULt3DVfFzrgm6llpJXg86ISA=; b=zOQRRd8Uh5sW9XdTm5egAqpvRc
	XUoXUxrwgU12/OSkhpMH+0sX+OITWDfORCZze3Dbi/ouCe9jz7X6hhHmgas3Rsdl
	+e8c7yYKMF3YdR1qfo0ranFlxGb3wWKZBmkmD2LSNGePCCiFZRqzj2KFnVcSK4DZ
	duImB6pfnFi/Erw9ilz/kd4rE513XakD9eQN8EYKlE5COXnVS4hUPm1ibFUsrsEI
	LQ4lXVsRf+xceantA5T9a8Og27B0zNRU1xGNEUqZnw0XHa26tdATOs+5kiLlKYMi
	/FkHnl/+q5CJVFmevrLIspbtxQRnA54QBytpFdUDdAvXyACsLTCOMKRP63Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749829564; x=1749915964; bh=P5ekxK23bfmZYDdozwmULt3DVfFzrgm6llp
	JXg86ISA=; b=RNJlDRyU+hYZ5deDBBXOg+VS/Wf9f0Dse5Ko6Bvmo6OTsMsAZwl
	IE8hFVyDzv1qXcXL22gsBj62m48od4U5ax/u8az3uIO3814hSAdRX0rHP8kax0ld
	1eaQVV+qvl/MMUZAFN2/mdJXTlO9v+zbYCoV8fScoWgAlP/xjFl+UcPZf7nWDzoS
	tCFZpodnG0QNOcZUEQ7CAUcJgsUt95T3+FdlByARvg0ki3uZd/sWiDfyqePVlTMc
	nXUIHAe++40iY+dhumVRt38TmtrAiiOIggjDaDOqI9BLnULfamuoHz2+0gQG+CGP
	GcIhkGMU57+r7p6r++fTLM2rI0UvhdLBPmA==
X-ME-Sender: <xms:u0dMaBaG5ilNpz61iG-0CUBGq7Svk_qfQW3iFtdqzpWQK-LQvu56jw>
    <xme:u0dMaIb33OuzNYS1ffz2AqHnE5kh7iPXckGCmx1SQNJqt-2wnqu4_YfgkyyjTVjC9
    lLqFjVz3rhdJgRPvA>
X-ME-Received: <xmr:u0dMaD8gYE6KJLE6Gsys5eaI2cjD3hAVwjrlnIq6YHq7i4S3l3J3-1xl_1YPbMepZ_NzuhJ8xn3Lhv7Vl2V5F_z7quBq915affl5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:u0dMaPrA3Vyk_McmQ3sdFZxNr-JoAaz1eT8FN5I21DrrlolUiIhkaQ>
    <xmx:u0dMaMqKh7RCBkk7aODLnn4z3k-ZDAjwiiRM3pp6xbZcb9HOSOtDXQ>
    <xmx:u0dMaFQwhkPplbvwyTJlz7wWPOTcjpmxigwpPIgezuqFJR3mq60Xjw>
    <xmx:u0dMaEqdmyfQ4QsBecOeVJ1rpbo5-3A1uMSiMcNznOIwhuw1ivJYeA>
    <xmx:vEdMaA0BptuOlFJmy2HFII0KyJjhw_4jGYrsZpvGmuGl5m1IU3aQsz-R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 11:46:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  ps@pks.im,
  sunshine@sunshineco.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 2/2] receive-pack: handle reference deletions separately
In-Reply-To: <20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-2-ebf53edb9795@gmail.com>
	(Karthik Nayak's message of "Fri, 13 Jun 2025 10:10:18 +0200")
References: <20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-0-ebf53edb9795@gmail.com>
	<20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-2-ebf53edb9795@gmail.com>
Date: Fri, 13 Jun 2025 08:46:01 -0700
Message-ID: <xmqqldpvably.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19)
> we updated the 'git-receive-pack(1)' command to use batched reference
> updates. One edge case which was missed during this implementation was
> when a user pushes multiple branches such as:
>
>   delete refs/heads/branch/conflict
>   create refs/heads/branch
>
> Before using batched updates, the references would be applied
> sequentially and hence no conflicts would arise. With batched updates,
> while the first update applies, the second fails due to D/F conflict. A
> similar issue was present in 'git-fetch(1)' and was fixed by separating

Do you have a reference to such an earlier fix to "git fetch"?  If
so, let's add it here.

> out reference pruning into a separate transaction. Apply a similar
> mechanism for 'git-receive-pack(1)' and separate out reference deletions
> into its own batch.

The implication of this is that the earlier "delete" half of the
operation can succeed and be committed but the "create" half can
fail, leaving the resulting repository without the reference the
user wanted to have.

For now, this "two transactions" may suffice as a workaround but do
you think it is a viable solution for longer term?  As long as we
claim that the reference updates are transactional, my answer is no.
We'd need to fix it at a lower layer within a single transaction.

It is outside the topic of this patch series but we can at least
leave a NEEDSWORK comment that this is merely a workaround and we'll
have to fix the later?  I see a in-code comment that says "To
mitigate this" to hint the nature of the two phase solution, but we
may want an explicit note that says that "we know this is broken
even though it is less broken than it used to be".

> This means 'git-receive-pack(1)' will now use up to two transactions,
> whereas before using batched updates it would use _at least_ two
> transactions. So using batched updates is still the better option.
>
> Add a test to validate this behavior.

I wonder if we can write a test against a remote that accepts
deletions but fails the actions in the second phase as a
test_expect_failure documentation?

Other than that, very well described.  I know it is hard to describe
a patch that knowingly does a workaround instead of doing the right
thing for the sake of simplicity, and the proposed log message did a
very good job at it.

Will queue.  Thanks.

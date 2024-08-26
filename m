Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C714AD0C
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700403; cv=none; b=GpknbMQQ6EOtHLDbsDkprpalvFfFxHGmADxK7qOE9OcBd0JQ1rEsDEDSy2I/xK5hqSeTxD5yilV4nJsTPXkBdZBBPT4TsI21kIcBmEj8lrFvv1WuCoa78wXNvEAYcdr6i1jOVPrgp2O4LsL66MQnrTXjU/Tz3jyNQLsuD++7v1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700403; c=relaxed/simple;
	bh=dGTJs656ixkEgCQYmNNyQTSsAK9l2DU66g4Ln4yB/dM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fdRQELpVOQvAbl05VjybB7E/E9Af5EjPvBc5IwEbdJ0OPHR4cGM3n4uRJQYa35PepFVcbqeCUH9lwIN4H6WgKx9sMMwstnjkv43o9AZrluo4C2lZZf/ozF2oL4y+Ycg9NiBlW4sTu5WjoAnKXMlHan58HDiBKhrjaP/xnNh7QNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AnPAB3NB; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AnPAB3NB"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E4CC01C78F;
	Mon, 26 Aug 2024 15:26:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dGTJs656ixkEgCQYmNNyQTSsAK9l2DU66g4Ln4
	yB/dM=; b=AnPAB3NBXqPtfcjWqSsl8KYy0FSmEu4W4IlePol231ZbKY8VFLECN2
	uv44Jgi7BVpszk09wv8SYeFS9wRwbz6FcSBI3m2zoCsFGSLe7IxwsIvfjhmU/zyp
	fn9mIyIG4uMrA/qZuIBUzLOiwE/5rqN928yhPZtSZ6dHkdi7N9Nzw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DD6551C78E;
	Mon, 26 Aug 2024 15:26:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 750731C78D;
	Mon, 26 Aug 2024 15:26:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v3 0/6] t: port reftable/stack_test.c to the unit
 testing framework
In-Reply-To: <xmqqwmk3hzly.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	26 Aug 2024 12:07:37 -0700")
References: <20240823120514.11070-1-chandrapratap3519@gmail.com>
	<20240826173627.4525-1-chandrapratap3519@gmail.com>
	<xmqqcylvjhtt.fsf@gitster.g>
	<CA+J6zkQKc=NmBnuih9Y+2oMjQtVOhKxJ_RfOLGxvWxcBbMH+kA@mail.gmail.com>
	<xmqqwmk3hzly.fsf@gitster.g>
Date: Mon, 26 Aug 2024 12:26:36 -0700
Message-ID: <xmqqo75fhyqb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1D777114-63E1-11EF-8EF8-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> On the other hand, you should realize that every topic first is
> queued to 'seen' and only after it proves that it plays well with
> other topics in flight, it is considered to advance to 'next'.  So
> if you conflict with other topics that makes you conflict when
> merged to either 'next' or 'seen', you'd be better off creating a
> more suitable base than 'master' and then build on top of it.

$ git log --first-parent --oneline \
  cp/unit-test-reftable-stack..next -- reftable/stack_test.c

tells me that Patrick's "concurrent compaction" and "drop generic"
are the big two topics that touch reftable/stack_test.c file that
you are removing.  As the former already depends on the latter,
it may make sense to 

    $ git checkout -b cp/unit-test-reftable-stack master
    $ git merge ps/reftable-concurrent-compaction

to prepare the base, and then rebuild these patches on top of it.
There is another topic jk/mark-unused-parameters that touches the
same file, but the conflict it causes is trivial.

In any case, the cover letter is a good place to describe how you
prepared such a custom base (as opposed to "the patches in this
topic apply cleanly to any recent tip of 'master', as the topic
touches a relatively dormant calm area of the code base", in which
case you do not say anything).

Thanks.


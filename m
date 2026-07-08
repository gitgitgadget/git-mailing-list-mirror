Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3672A2F7F12
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543273; cv=none; b=Zpf+nztxtKusHJ/mvpwSE5c8OJow68ZkwtQSKpcQhvBuLjiiYN2c+j3rgOyj6U+J2mV//BP7hrndI8qMq7vT/gqfU4YBvHpjSYhLxDbhkWfQHv6KGkjOuRzDkhI+bPhJ08VZRmU3naHjH0sd2U8qpzcMxlEMeJAVLJViLC/UBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543273; c=relaxed/simple;
	bh=WNA8hZmDIsipFqFZvWKVMtudY0it8moD0sgT/sy5CkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oq8C87F3nYV2TAbAT0EGDv7vieiQySA+InNj9/8nYKck0/3dQDq4zl0GD2y0qQCqbYm8IgWabRlGyFskA8pbHuES+yUjwBNmUYF4HgN7XU2bJjNjYPf7Q/vOrCBF3IDm8NKR/UQk4Bx3m4mday0AcHMKLeVFbl0S/kZIN7iFt1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qzZXZZd+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cobQSrLe; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qzZXZZd+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cobQSrLe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 856BD7A00D9;
	Wed,  8 Jul 2026 16:41:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 16:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783543271; x=1783629671; bh=X4nEzE7O2o
	hMSpujqIRFQSXZCvN89bbgrtfoVQsEVTk=; b=qzZXZZd+bCZ4g+Fufl6RsEQ14b
	4F5f6z7Hj+BUYu4DmKsNIQZ/8T758b+Ll6ArA8oez/NGmbVLFnJ5mwyDyjtd/aAA
	ZXomealNe7LZf0YUL479OVC8Udlz2b79Ps+Of2K/hCXPmd3bvLSNxNH7s5mB9qky
	TCNGuYg0UAps6k/K8eNSMOTQ7B5U/6BRT8qJDLme1HPuW2rwig9yNepnMx8kkRfB
	uGO83Ef1WLpd/vIkDSZAv4vjj+fKPR/hvpRi1gyc4kTPkVAae1SkMOzaTJQdw1tr
	DddcrUh6g8upoOFetLgW460XdU9KpT2DXSubuWDk/joFHJAXOI9AnAYpzAvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783543271; x=1783629671; bh=X4nEzE7O2ohMSpujqIRFQSXZCvN89bbgrtf
	oVQsEVTk=; b=cobQSrLehD8sGJ1gBofMiMTGu65XThuw3+sDockRyfp/Lc8VgVS
	7PWwxudOPyIzPeNhDWtShS0Is7ippla3bFD7sT7ncyfN46J3lvkYEOHWMN/ji4wn
	gtwDi3jhHzCzOb9gLM40ufogHYfnWFhiK2aP2j0Lr9ppZwHrCiVw4cknHxmckr/R
	yL1bhaUZcPyykvk0GMUfxjNhNPP0o+SH3VD50jO6LUZFvujasKMetrQSWoRcqT+A
	RQN6/Iz5/FCs9wW5IxpmvNTzVlrmQEc16jZGBOXQYXoHyX6J7CdD9uodDh+28EIX
	5Ff+sc2YnVT+btrYKff2C98AApmbf/wUBDw==
X-ME-Sender: <xms:57VOaph8i-340XHBsQ6OXauKnHj-K1wbl1mGFAf09DPuEeOq3yhKMw>
    <xme:57VOaleURtQChZnn37nQD0qxprk0gVwDIQFT6UnO-TNrwwsBY7yR6X420UuYlXArp
    QZ4Loih7dL3niweM0NsYdGF47VVFwFIUCV_g9dpi5I6aFI_fx3c6fE>
X-ME-Received: <xmr:57VOamdbBTJ3hkQnWGnf4nSnFf41t4oJPOjshs40vtHyjstHUSQd1AiEiDjcvkm7dXaVVMYDqwttdHYNHMbj82ECsFwzPY3jYpo2G-A>
X-ME-Proxy-Cause: dmFkZTGLlq3GCpwMis+YTye1mUMCtgoEB8oLHmm/zc60nFvdMkfjMQuisJyZ9gYfAPuPho
    PLVsLIqNfYbHxK5LNUHJRytXKAOoA0IGmHj5aWZu3V9vDWBXKHRKjD4BIhl6AzvkXYytNc
    I0DuYDUrxCCEEB8r/jTWfNGbvmqsGdXj9J9jUEA9cezOIeUwjdV8rkzKZwj7DV3P1tPdgt
    hsRQU5eZ86rC4rPvRtAHP7HhaQwpsMTO9db+amor4wxwu0dta8xR/eOk7WKVBE1Gyv0UC3
    6TeEn57dF8DKAxqrhA9GqRiJokvK2M4sUZnyjT2RpAkd2sW0KKZC9bF9XaIS6Em5CQjYOt
    0HM3Mgl0HSgb8HqWxPSVYSVAHdGDd6/7sab186X7VoxPPTFXVKY1ZmvhU6ozNx8qG1giL4
    pQvgRRjNMhyIDxDx1sGHqqOT8t2LVzQ1ZAhV9+J5hWbOx7a7MxZtAH03rclXshJSqnMaM3
    2NUQWlAG1/lx3n/LyJrW2CxAQLUoXwxxPUCoUO9VzzdVDpUUfdLi1jSwaWxN+mCSWmzhHo
    kf0bKiK30r+L8djVvNhcijy6ALYPjARVkMMRrBp872mSrk+wgtvZrFtgR6Oq6pEsDKkrJO
    JZkJKuYKKTrS0phA6obDuWh7SXQVVo5aZ8mHPg1zQmMCzq9bxdkTr2rUzh+A
X-ME-Proxy: <xmx:57VOan_4JJpjSrTneuMvmGqYBo8ygnudh76B2IVOJITKY3NajrRe6Q>
    <xmx:57VOaqljdXptlJ-VWNSG1Hc7ahKDWkgb81Jfj1IUJOq4gIsHXK3YJg>
    <xmx:57VOah_G4hOQBIOD6k7vKFXKpgsd1GFkAR-1A48-ejM0eCTnbSiqag>
    <xmx:57VOagk_9SkWzw_574MXOJpfBY698sKGR3xFUQ31qAQh6KcY-MGUZQ>
    <xmx:57VOaldxIbDWrbbKzN8YwLqQp1J8705H7Flxef5MgW9NVca6lq-I-pNq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 16:41:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] t1410-reflog.sh: avoid suppressing git's exit code
 in pipelines
In-Reply-To: <20260708092448.35776-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Wed, 8 Jul 2026 14:50:05 +0530")
References: <xmqqechf8ryu.fsf@gitster.g>
	<20260708092448.35776-1-gatlavishweshwarreddy26@gmail.com>
Date: Wed, 08 Jul 2026 13:41:09 -0700
Message-ID: <xmqqv7aprz8a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> Piping git commands directly to wc -l suppresses the exit code of
> git, hiding potential failures from the test suite.

Correct.

> Capture the
> output to a temporary file first, then count the lines separately
> to preserve the exit code. Where the expected count is known ahead
> of time, use test_stdout_line_count instead.

Technically, the description is not telling any lies about the
solution, but the patch no longer does the caputuring or counting
itself at all.  Rather, it exclusively uses test_stdout_line_count,
which internally does the saving to a temporary and counting the
lines ;-)

The changes in the patch are mostly good, except for the loss of a
blank line that separates two test pieces in the last hunk (below).

> @@ -319,13 +311,12 @@ test_expect_success 'git reflog expire unknown reference' '
>  	test_must_fail git reflog expire does-not-exist 2>stderr &&
>  	test_grep "error: reflog could not be found: ${SQ}does-not-exist${SQ}" stderr
>  '
> -
>  test_expect_success 'checkout should not delete log for packed ref' '
> -	test $(git reflog main | wc -l) = 4 &&
> +	test_stdout_line_count = 4 git reflog main &&
>  	git branch foo &&
>  	git pack-refs --all &&
>  	git checkout foo &&
> -	test $(git reflog main | wc -l) = 4
> +	test_stdout_line_count = 4 git reflog main
>  '
>
>  test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '

Thanks.

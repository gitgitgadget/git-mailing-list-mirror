Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589D367F4D
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782848963; cv=none; b=UqI00iFwZzRf6kMOYpnIllj8/0KrG4qfEi7BYxFs4BWk7AZBpXLB4jqeco3v9LOCni1fZfEqgGvI5b9F62Wh/uj0aaVYCGNnBkS6h2REyA38nvvMOhHWXMQ/4yDncuV/Rwj4VoU0bQdRYH5RCD+sqJxeKpT4OZWcGcOcmOSoGSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782848963; c=relaxed/simple;
	bh=4UTimG4POjqrLCvtXjq4hNc4jUw21ngWpU4kuNADW9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EatjEo2d6s4fHBXsRwetS/UQc06o0g05tEGGRsZ7vLN7O5KgB4i3ageJawqFQ6eX4r4T9RSD1OFsp1oVNCyG/t+6d5kVilTyonqJyz66mZV3Xm3xKBJBxXbEIEUjH0L29pj2yncHpkwlvuS+HC8DQUWVHkAEcJzYV8FzYOlk9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j4ZsU2+U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aBFaj/GS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j4ZsU2+U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBFaj/GS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B1DAEC0112;
	Tue, 30 Jun 2026 15:49:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 15:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782848961; x=1782935361; bh=4kxSZs3LOs
	V2Wl8xzEk+txAjOAdL1S+70obQkuOc12s=; b=j4ZsU2+U/7qDZxMcdDGPQbGkcD
	d/EwnKTxEUSeaH6qbJrPS+CiuqBGhbPtNPW2o9ILU9fzDunQhSkhq0Sn/CAofA1L
	UjVG44HXsQzRMPsZyLVG6ea5lcnFeV2lBcpKsR96gR9m/O6Dv9aBXgc/TCRefqQW
	YisjKqehL/My/GFkVVKL6glm34JnpyMSkF/unxbJBPoDuDnPy7TjJHhBASttQCuX
	J2JwA4i6r0UkcQk+TAQvXyzPn0+qa2UW5Wtbnbz17Mi85pzx1xLlZ3bKZVVD9xtc
	+z6Kd24tq0XM/pxOZ7G/QT2lqo1QQNFE1EmAvdTLvuvU0wLcLNkn66HjrmWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782848961; x=1782935361; bh=4kxSZs3LOsV2Wl8xzEk+txAjOAdL1S+70ob
	QkuOc12s=; b=aBFaj/GSOCW9Bhr1veg7fIHStVr2DyTPX/ujCcw1gCiQ3h5pYaB
	VXJZI53jHC4Tu/svfESMQpV/EPY6ND/wQnG21leSeMv0EgV9act4CjlD3mTMrmu2
	sGxvMQOg4HisI0dKFbsC85F/FlemKyYEfLPoYc4CYESTfqvZl0OZzbX3tDfgakE0
	K+pKdoQYx8VI8xRgImOsDvnBvgmGKhyotP4TAJhiffUa80GwR2ApDQMUvhk5DZ10
	iuorULtjmrzhlemkXlSwL58v8xpXkOe8gBuqan+to1QVDW2WvW8CXHnOgRm/Ok7j
	KZPq+UxVBECXzMPvAtWtEQbR1Ywh3hhIqmA==
X-ME-Sender: <xms:wR1EarSwucbLAEmJ2DppbMzXOO5Yfw7LZVFK0QqCATsTp5SQnuy_BA>
    <xme:wR1EakPskyGkaAa3W7o-v53pRyEf7qhJMvAbfycnfuAuGZN9PgkFoCuIiuNU01eFW
    JO37Ku79G6DWYf2gULSqNQtXAkBmycoDnZhDNK9YXJHDK69HfQd>
X-ME-Received: <xmr:wR1EauPSgU7k8M5WUOr1sa7SGTHD0MC-YDJIrL1wE3jqpemMqRCLUu-v9-BKRwUa6lTyVMb4Bv4J70xo40lXbxoPhP2p2FDU13veZPM>
X-ME-Proxy-Cause: dmFkZTEX7jdcSpNBWfuRCsZFtreQOY5fUsSD/retXD7NdVMQQxHlsBXtoEKDlPMTBN4ybw
    TZU9m2T7BcS5Da7C46RtlOCZxt/ugfCY2cKOdm7cyf6sSeydb/Ih48En4R5T/5Bp5PMEse
    qJY+ZjBUwD3DU9HmEFHuGDdBNZICqQ0zES0YSwqC1+AaXvy6IT4J0JcouDGpwNW3lsCx91
    6lsG3wvO47qQFKR6H7wf4AZ9cTpGOPlq4IQ1uWiBMzU8Fn3SwAZMYyY8VQFfubXeizlURH
    BzPw5eCNjlMTKmJ0T1/qaPy9lRyFZf9+mUkoOjbjdFpyhh+Et7uZ/iHJE8kxnoOZ5im9BP
    Vw6qvZ3bKEQod/DUo5L0JWVPrnn6ivAjHaffNk7HDLMb7QAjYangQF1w1GUbGzwf23r6wg
    IuYfyux5fsc7bRbC+5fa3NPZT9pOniHzBYfNvi+7w8+pgwZwrW3e5WEf6wSiE8aJBmxOwu
    2kqrdWIPH77b1K+94CT6lR+GYpVV0nEi1WpfuB6Rlg2MxARI9hpkDjzlAHT/nwIcoJnSLm
    0e1PJLI+3KfsRvPdJiC0U3KyecTJWQ7d2Q1XyxGieGe8sd4A1zHSCJZ2b3wQ5ZyMrX99I3
    b1Lnn3vOJFmv4OBR0OC7zTdcymUXAGJkugxaW1CjZvV4mzTJEuICgZ7cV6dw
X-ME-Proxy: <xmx:wR1EaktAzTyC_fg8xT-bmiyH9PIm1uQjVHqrMBAjBZxE7R5YBUJxHw>
    <xmx:wR1EaoU9rQQFmJ3eDTFiIo8nUJaGEoVbcSOi2KNXOh7s1eM3Nn-1rg>
    <xmx:wR1EasswNrqkAnWKSEdIW9toaSw8pbn1bK5bgyvdV9hykgQWgz8Nkg>
    <xmx:wR1EakUy4GsERuzuCOnXkDqQTQzghopsx2gl--8lB8t-hrjv7rZLcQ>
    <xmx:wR1Eav8Sjq-pIlnGwpJ_-if4mpayBjt4L0SiqrBC7laod3hYDc694WBX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 15:49:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Laszlo Ersek <laszlo.ersek@posteo.net>
Cc: git@vger.kernel.org
Subject: Re: git-blame vs. abbrev
In-Reply-To: <b500479b-14c1-4fbb-a672-1d2cd4852601@posteo.net> (Laszlo Ersek's
	message of "Tue, 30 Jun 2026 11:15:17 +0000")
References: <b500479b-14c1-4fbb-a672-1d2cd4852601@posteo.net>
Date: Tue, 30 Jun 2026 12:49:19 -0700
Message-ID: <xmqqy0fvreps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Laszlo Ersek <laszlo.ersek@posteo.net> writes:

> Hi,
>
> when git-blame is passed the "-b" option ("Show blank SHA-1 for boundary 
> commits"), shouldn't git-blame *stop* reserving a commit hash nibble for 
> the caret that otherwise marks boundary commits?
>
> More directly, I find it inconvenient that git-blame shows commit hashes 
> that are one nibble longer (13) than my "core.abbrev" (12) setting; that 
> makes cutting and pasting commit hashes from the git-blame output into a 
> git-rebase TODO list cumbersome.

I never knew that the parser in rebase did not want to see a longer
abbreviation; shouldn't it take 16 hexadecimal abbreviation from the
result of letting the user edit the list, even if it initially gave
12 hexadecimal abbreviation, as long as these extra 4 hexdigits do
not break the commit object name?  That is a more serious usability
bug that needs to be fixed, if it is the case, I would think.

FWIW, even if your core.abbrev says you want 12, if two objects
share the same 12 hexdigits as the prefix, you do end up getting 13
or more, so a parser that insists on exact 12 hexdigits sounds like
a bug.

Just for the sake of aesthetics, I agree that when we are not
showing the boundary mark, it would make sense not to reserve one
column that we know we will never use.  But unless there is a
mistaken parser that insists on 12 hexdigits when 13 hexdigits you
give uniquely identify the same object, I suspect you wouldn't even
notice that the hexadecimal digits you see on the screen have one
digit longer than usual ;-).

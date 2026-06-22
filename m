Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C466225B090
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132287; cv=none; b=YWbjMEyukR8CuwCRBKjeatB5B90VoPfQ5UcG6jJRHt7mpEDEpUm6e5WVhz0DbpBjardNNv19tHj6EoHa5FraLeXlcfKcFJYh36kfOO/zAM423ui3XSgtzFh+gZqDkFAS9xV9jgpqwsfK1buENjFlx2CAeKKz7LyHLfOr0FPXS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132287; c=relaxed/simple;
	bh=fkS7BmwiU42XxY78M42n7rBMVOoqvwLDek9jMbbyn5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EiKD+GHsF9polM2TjTvjqyrxW406JvSSfWWY7O7gz7uGaTgHNikJzEBgsEj0tkRTTcBa0DKkUn1pfZvuQvs9pOrXw1liAzUqsuJgjOY94qTDKwkOtYBAd9rPnSjHBxOPsapKVleZA/0ULSGvuT9SNRVb3iM2YvsUdZKfrV16Pmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iHNNXveu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jak/U6DU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iHNNXveu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jak/U6DU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DB4B140010E;
	Mon, 22 Jun 2026 08:44:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 22 Jun 2026 08:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782132285; x=1782218685; bh=ibxVFVF208
	BNX9RmhBkxFjWmNxsrTCck7VOE58aYmMk=; b=iHNNXveu1j303StdtCPf0AcyY+
	3yRhoqdkSDeHR4v96JCea0UFlhNzyDyAK1I2FWbmOeI3Y4dnSOqkijHiXcFlCBTd
	rzy9tMZBH7yBIK+12dA4RA9U9lIqDvGjqw6gBEQFSeMSFzVh4ucVjkbcVEMVwMKq
	ktbMW9IyBohCarNuWb86756wPqfhhMEftepwUpfXuim8z/YYN4Ca9dF9e9eA2OCr
	E/xPEe5Oo/9gmW+lRBwVjZT44ROfzwiFWRA5McTHEdgqOrwXRn7lKMGGIgCCPtOJ
	I/xjBpJe04YayRtbbZecEn36LAYf9f1XxRtVUIIFPoepsa+00uJKlzaf1JLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782132285; x=1782218685; bh=ibxVFVF208BNX9RmhBkxFjWmNxsrTCck7VO
	E58aYmMk=; b=jak/U6DUCsaFzaf6cFJIRHKfjRvyXsCLt8wMDMOcq/08uMF7WJd
	pq7GAeTsZFKBZU22U91GOVe99P94NDOyaCF7bUP+xWymmZ5SkYyGDTeD9TYjb87m
	0EDWOdCswrSdDgLJ2NOXpDjbozpO+gB7qPl6HOLX90zDFdPVfIDIdpEclR/oniFm
	HjsHKnZvtTnaxDRjE1bgv8kkE/Y4/0EcAqsl5nntxwAjnR0AmS1G1+8brYMSHdj1
	0GH1MQa298OVBitggXHhgUuBeEHbK6/IvtfUvxh/YvYYW5KhFRnqv6x/H24tWVca
	OTf8qR5YmCe2O3TIsxcs5Q0NhWod+Cho/tQ==
X-ME-Sender: <xms:PC45au_SwJgmTRN1y1CuLEhI4oFUGxE4YoVxtJ2T8PD3A5MNs-3XyA>
    <xme:PC45altKH2FOQeGfzhBLlPSUTjCxZ2jmJrokAH_aUDiACUkynl-Uc5cm6uDRMNW2K
    DI6ixL38isI-3kPFdt6vpwGdbsreiM9CPa1q5zqniDG4ufXADWmkg>
X-ME-Received: <xmr:PC45apB47lobtr-zNeudIki2GRWyomq-ZyecvAkqyGljwo3Gfo76lr8ORUfhL9ZhNQyhaRRviYTQImT6m56do0FvuZbJVIVwXGMS1bQ>
X-ME-Proxy-Cause: dmFkZTEcROxEw1u/ErQW6ByuT2x2P19jWKUP+f4K5XT1O7WmbTDMTJLdqE6fiva8cPT8rh
    nT2vQWJ898Zi+D7ruKrCFZpssBTuNpGb4plllryuffUCQT83yi7T8q0HlC+riwVR7g8nNe
    s4RdVxbJxAv2FQE7O5aLhBsYIdGjhN+k6v9VPHveU/Srt5HHgCqEZWNACztdjslbMVYVsx
    4StKknKM7VXDQVHo/eL5t9jveDCHwJl85nOIAbJPKWUJXCmBGc1vxOZPILp2+sJxEfGot/
    mqqhJYR6x3e/dqMz2SL+3XlLnFvlHYTwaFZKK3FlKIUWHq/hMdn1pbX49wGBRca9i/i1OS
    1fAf21k2FUIfcfFqtWIXBnLsRoSsbdanYs3kvkoHARKNaMhoMlV/sbwV6HGuIHi+Y3gEae
    N7S+/i+NhsaXSifaMTh2HrgC272naz3NxbL8ZacpM6nC56/5GMsOGrSmAUD6EahMSLm3ea
    +v/KdbiVgpZnqYPb2EBAvwClz5vOLQgTi3SsF4FYSKMzS5nR4zoX1vM+Iyu2bUZONlS5IO
    HywikTsLxn9uNN+Lh0szivL7awDsfBjdEEMa8roc9CzqCarLyqGvwJEESn+M4crZHr3k54
    QvmMPPjElL6lYZAEDUt+4WtsuGBUofzEju/TFkspgMCNJnoL6Ubm5amgcbBQ
X-ME-Proxy: <xmx:PC45alXDutUpN9Q3YyHpzD7fuJRXktJjIlbXVD4JN6EAh9lCn7hUFw>
    <xmx:PC45avC-oEHtlAU65SX78l9XUf52kk3WVBfpEDsKCsRLRJHsf-D0mA>
    <xmx:PC45ag8609A9RPWJB76cLbHsPa2KvXoG5QCgJZSPrhkSbyYgBKDsXw>
    <xmx:PC45auFF2L-nuLMuXn2io7Qp-UG8tEKrGx7_Afd_gQWvUndeZKVp4A>
    <xmx:PS45amLSR8sKUlgBtUOfHZ27oxBmPgNPGh2pSksnftm-8F-Z2aAcEv38>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 08:44:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH v4] log: improve --follow following renames for
 non-linear history
In-Reply-To: <ajjU4w2B0NlZffw1@collabora.com> (Miklos Vajna's message of "Mon,
	22 Jun 2026 08:23:31 +0200")
References: <xmqqo6hglncl.fsf@gitster.g> <ai-aE83w02xPRlPr@collabora.com>
	<ajjU4w2B0NlZffw1@collabora.com>
Date: Mon, 22 Jun 2026 05:44:43 -0700
Message-ID: <xmqq1pdy4udg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miklos Vajna <vmiklos@collabora.com> writes:

> I noticed that merging 'mv/log-follow-mergy' to 'master' results in a
> (simple) conflict since commit 42d960748e (line-log: integrate -L output
> with the standard log-tree pipeline, 2026-05-28), this is an updated
> version that resolves the conflict.
> ...
> Please replace the content of that branch with this patch.

If there are changes of substance, polishing with new iterations is
welcome even without any code change (e.g., clarifying the proposed
log message or documentation to help future readers understand what
went on in this patch would count), but as long as the resolution
that is in my tree (as a part of 'seen') exactly matches what your
update contains (meaning: rerere will do the same correct resolution
when the topic gets merged to 'master' anyway) and the conflict is
trivial to resolve by hand for others, which seems to be the case
here,

    $ git checkout --detach master
    $ git -c rerere.autoupdate merge mv/log-follow-mergy
    $ git commit --no-edit
    $ HERE=$(git rev-parse HEAD)
    $ git reset --hard HEAD^ ;# back at 'master'
    $ git am $this_message
    $ git diff $HERE ;# shows nothing
    $ git range-diff master..$HERE master..HEAD ;# no change in the log message

I'd prefer not to see such a reroll.

Thanks.

Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80261991D2
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699264; cv=none; b=oaWM7fHcXfTGBSsodz5C3OdpHHbgzeylBp2jJ1gV4BaGoy0UgEZAaT3RlD3E2EYmZ+DNsGoUqeyMkYk9sf9tFbt0vKreApY1p8hKICSmMfoXqGoqrBZF1E5ihiICN6INN5Fql1uTC/mL8U8qCH0TIkpejjjBvFdtnbp4W8dkVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699264; c=relaxed/simple;
	bh=ZtSELPCFtFV0Vjg0Z86Pf6f8AiGppHGRN7/FMdZ/isU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g+hZ3jk0aw/uMlamJQTrhBPkEfhQBw6Ne5BNBWlNmSwIncgEofad/ohM3UjajfCirBzEnAZxMA1wD2XcXKB+PzQTscVmqe+rJBiEVtlER6BzjWbtYcDuvfks1/jttEN6iIMjwwgCvO+YVj0OyIBBZm05raknQPiJOE5Vw8nfZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=beASP+Zf; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="beASP+Zf"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BBFB92BC25;
	Mon, 26 Aug 2024 15:07:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZtSELPCFtFV0Vjg0Z86Pf6f8AiGppHGRN7/FMd
	Z/isU=; b=beASP+Zfbcl+ncvcbGszu2QoI9ok2e6NErTJk7uBaqqI1yBhwt+eb2
	K0jGqDWsJAMeqwAUrz4+kD5mfPeaCyhybS6E2SJu5iNSCXNF5ddiwRXgzn9ZKsZE
	OkZVU5eC8Cbzh2LOT3ondMKTyMEzlKJS5Sqxa0p8eVDDAC014xOAQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4BED2BC24;
	Mon, 26 Aug 2024 15:07:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 041AB2BC20;
	Mon, 26 Aug 2024 15:07:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v3 0/6] t: port reftable/stack_test.c to the unit
 testing framework
In-Reply-To: <CA+J6zkQKc=NmBnuih9Y+2oMjQtVOhKxJ_RfOLGxvWxcBbMH+kA@mail.gmail.com>
	(Chandra Pratap's message of "Tue, 27 Aug 2024 00:04:06 +0530")
References: <20240823120514.11070-1-chandrapratap3519@gmail.com>
	<20240826173627.4525-1-chandrapratap3519@gmail.com>
	<xmqqcylvjhtt.fsf@gitster.g>
	<CA+J6zkQKc=NmBnuih9Y+2oMjQtVOhKxJ_RfOLGxvWxcBbMH+kA@mail.gmail.com>
Date: Mon, 26 Aug 2024 12:07:37 -0700
Message-ID: <xmqqwmk3hzly.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 764BC702-63DE-11EF-89FC-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> I generally make sure to rebase my patches on top of the latest
> master before sending them to the mailing list.

This is generally considered a bad practice.  You shouldn't rebase
unless there is a compelling reason (e.g., API you rely on
disappeared and you need to reimplement your change differently, you
rewrote some code based on an old version, but the code you touched
have been enhanced so you'd need to rewrite the new part).

On the other hand, you should realize that every topic first is
queued to 'seen' and only after it proves that it plays well with
other topics in flight, it is considered to advance to 'next'.  So
if you conflict with other topics that makes you conflict when
merged to either 'next' or 'seen', you'd be better off creating a
more suitable base than 'master' and then build on top of it.

An effective way to do so is to mimick how topics like

  https://lore.kernel.org/git/cover.1724308389.git.ps@pks.im/

are built.  This one says:

    This patch series continues to build on top of 25673b1c47 (The third
    batch, 2024-08-07) with Junio's ps/reftable-stack-compaction at
    f234df07f6 (reftable/stack: handle locked tables during auto-compaction,
    2024-08-08) merged into it.

in its cover letter, allowing anybody to reconstruct the base with

    $ git checkout -b ps/reftable-drop-generic 25673b1c47
    $ git merge f234df07f6

before running "git am" to apply the series on top.  Because it
_depends_ on ps/reftable-stack-compaction, the resulting topic
cannot be merged to anywhere without dragging the base topic with
it, so such a dependency needs to be already fairly stable (e.g.,
have been thoroughly reviewed and merged to 'next'), but then the
topic will have less chance to conflict when merged to 'next' and
'seen'.

Thanks.

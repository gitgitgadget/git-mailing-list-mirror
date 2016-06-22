Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EC6420189
	for <e@80x24.org>; Wed, 22 Jun 2016 20:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbcFVUwB (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:52:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751121AbcFVUwA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:52:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7086526ECA;
	Wed, 22 Jun 2016 16:51:58 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QSljDJ8gsnY925aZ7i7Gt9yE6I0=; b=h4QMju
	xy8ppNApjPXQ4FC2LAzdsfqdJ/EN1lh4xwvBy1LEELjP2v1kigTUWYFfA6bdHtKV
	toKd2s9O8JHfqRbdsZT8GgAmRS5m2vmCevys7eSUqEIh83Kzs7Do5MBT2FHjl+Um
	uosAKPcakfrdMRza4VTBN+OeiFKdtR3u95pnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qLnDySCY8Xptq6R+ZSvjKmYgGPogyMrc
	SL1lxC/uWqLHYokgkg7g6K9fdNeAo9WKl+6wJbeJjV79bLTZGTylPtAuZjSSsLat
	iafjrLKJvSanq7e48uJlOo7sg6hhz9YR4rXZGbMRtbdJ+hDiZGcnUI5jF6AyOrzL
	mbz+AjY8fvo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 685B326EC9;
	Wed, 22 Jun 2016 16:51:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D584426EC8;
	Wed, 22 Jun 2016 16:51:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t/perf: fix regression in testing older versions of git
References: <20160622193904.GA1509@sigill.intra.peff.net>
	<20160622194013.GA1697@sigill.intra.peff.net>
	<xmqqmvmdkl3y.fsf@gitster.mtv.corp.google.com>
	<20160622204836.GA4628@sigill.intra.peff.net>
Date:	Wed, 22 Jun 2016 13:51:55 -0700
In-Reply-To: <20160622204836.GA4628@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 22 Jun 2016 16:48:36 -0400")
Message-ID: <xmqqinx1kkus.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28F9A0C0-38BB-11E6-8FEC-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I can see how this works for "git -C ... rev-parse ..." or any other
>> built-in commands, but I am not sure if this is sufficient when any
>> non-built-in command is used in the perf framework.  How does it
>> interact with GIT_EXEC_PATH we set in ../test-lib.sh that is
>> dot-sourced by ./perf-lib.sh that everybody dot-sources?
>
> I didn't test it but it should work because we are pointing to
> bin-wrappers/git, which will override GIT_EXEC_PATH, and stick itself at
> the front of the PATH.

Ah, yes, bin-wrappers/git is not the real binary we just have built
but overrides GIT_EXEC_PATH to point at the matching version.  I
forgot about that.

Thanks.

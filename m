Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B7A20189
	for <e@80x24.org>; Sat, 18 Jun 2016 18:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbcFRSUQ (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 14:20:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62005 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751959AbcFRSUN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 14:20:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3186524331;
	Sat, 18 Jun 2016 14:20:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vAsKXsuuVBA5/I6yQKobBcihvtk=; b=ENJQAh
	8KONeWTMSvND1qHijFwENg7ovLeiBbhnlH4+w9wRLZILlv3lmKWrkG/kacXB5BjA
	k6wxmmTZAVuUAUhprCk01dUzGuoZue96qd87UIqRTibCQbbzoWMh/vTl2QA8tvWo
	w2JPmxDEJF0LeLaM6xCEJU7IsW1eqzrlKUAh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qNQNvdRZvG1AwnWvXs1K6gP0DOVRVElG
	1MGtM/b2grxLagaNRreiTslzP/ea9V8nO+OkyTvdBQFKv9VmGvzCYEC2DaklK8ym
	gWg/5BXbu1lPPkAlucT9qopCFcfEgDbP2XP4E2XmOrh0z1KBeBZcL5gmz8RDL2/c
	kx8RjRWGQJQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A16C24330;
	Sat, 18 Jun 2016 14:20:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A72342432F;
	Sat, 18 Jun 2016 14:20:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
	<5764CBA8.5070303@alum.mit.edu>
Date:	Sat, 18 Jun 2016 11:20:09 -0700
In-Reply-To: <5764CBA8.5070303@alum.mit.edu> (Michael Haggerty's message of
	"Sat, 18 Jun 2016 06:18:48 +0200")
Message-ID: <xmqqziqixsti.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B9BF9C6-3581-11E6-B5B5-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 06/17/2016 05:20 AM, Junio C Hamano wrote:
>> [...]
>> * mh/ref-iterators (2016-06-03) 13 commits
>>   (merged to 'next' on 2016-06-06 at c8e79dc)
>>  + ...
>>  (this branch is used by mh/ref-store; uses mh/split-under-lock; is tangled with mh/update-ref-errors.)
>> 
>>  The API to iterate over all the refs (i.e. for_each_ref(), etc.)
>>  has been revamped.
>> 
>>  Will merge to 'master'.
>
> It would be preferable (though not critical) to use the promised v3,
> which I just sent [1]. This includes some minor improvements, described
> here [2]. This is also available from my GitHub fork [3] as branch
> "ref-iterators".
>
>> * mh/split-under-lock (2016-05-13) 33 commits
>>   (merged to 'next' on 2016-06-03 at 2e71330)
>>  + lock_ref_sha1_basic(): only handle REF_NODEREF mode
>>  + ...
>>  Will merge to 'master'.
>
> Please make sure to pick up the important bugfix discussed here [4],
> which is integrated into branch "split-under-lock" on my GitHub fork [3].

Good timing. I was planning to kick split-under-lock and any of its
dependents temporarily out of 'next', so that fixes can choose not
to be incremental, and dependent topics can be rebased on top of the
fixed fondation.  Even if we do incremental, [4] is not sufficient
material for me to write a log message for.

So people who reviewed what has been in 'next' can revisit [4] and
give review comments, while I could just pick up the history
mentioned there, i.e.

    git checkout pu
    git pull git://github.com/mhagger/git +split-under-lock:mh/split-under-lock

and we can start from there?

Thanks.

>
> Michael
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/297625
> [2]
> http://thread.gmane.org/gmane.comp.version-control.git/296322/focus=296883
> [3] https://github.com/mhagger/git
> [4] http://article.gmane.org/gmane.comp.version-control.git/297174

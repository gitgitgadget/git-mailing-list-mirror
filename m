Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B3C20189
	for <e@80x24.org>; Sun, 19 Jun 2016 21:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbcFSVSN (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 17:18:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751283AbcFSVSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 17:18:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F215024472;
	Sun, 19 Jun 2016 17:18:11 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EC4MM3h/2Lku5k1dzmiPVH2nBts=; b=nNzV7I
	3WzKbkieO3y99mwMCyvCOy9Jmb6sus51UKJUsz8olHFc7qX7KJb8BVuvjxVdSzoQ
	Q5DasT/9CrJnZL6B0Iy8e6Ae9XjeR8y3UHRd/MXeaLWrCMtKLgJjgeMsEfZGs9JW
	i2rLqMlMpL3MSCr9TYaAEguivQ2EQZePFgias=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZNhpH+NDc/+kXBYcah39ASqVd8TSeH52
	6yxSQqNYdrfe7U0KH0ssugm8U+qFCw3ETQ2oRizUqKq6DuyQ0yfD9QDWq/cjCys5
	LB+uzTX5PCJqoJT5fZx7E6xnYfIj4Ls51pGC+QnlWUSh84xIJm01U9deF1UmUFtS
	EQFuW7rVz/s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA5AA24471;
	Sun, 19 Jun 2016 17:18:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65D1524470;
	Sun, 19 Jun 2016 17:18:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	LE Manh Cuong <cuong.manhle.vn@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] git-sh-setup.sh: fix missing double quotes variables
References: <xmqqvb15vz3y.fsf@gitster.mtv.corp.google.com>
	<20160619180928.16255-1-cuong.manhle.vn@gmail.com>
	<xmqq37o8x514.fsf@gitster.mtv.corp.google.com>
Date:	Sun, 19 Jun 2016 14:18:09 -0700
In-Reply-To: <xmqq37o8x514.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 19 Jun 2016 14:06:15 -0700")
Message-ID: <xmqqr3bsvpwu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53A36B3A-3663-11E6-9714-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> LE Manh Cuong <cuong.manhle.vn@gmail.com> writes:
>
>> It's really a good commit message, better than mine.
>>
>> So must I make another patch or you will update the commit message?
>>
>> PS: This is the first time I submit a patch to Git, so forgive me
>> if I made any silly questions.
>
> I can locally amend by replacing the log message when I queue your
> original patch, now we seem to have agreed how it should read.
>
> Thanks.

By the way, here is the hits from

	$ git grep '^[    ]*: ${' master

All of them in t/t4100/* and contrib/examples do not need touching.
But others are in the same boat as what you updated in this patch,
i.e. "wasteful -- the no-op invocation do not need its $VAR
expanded".

contrib/examples/git-reset.sh:: ${rev=HEAD}
contrib/hooks/post-receive-email:: ${diffopts:="--stat --summary --find-copies-harder"}
git-mergetool--lib.sh:: ${MERGE_TOOLS_DIR=$(git --exec-path)/mergetools}
git-quiltimport.sh:: ${QUILT_PATCHES:=patches}
git-quiltimport.sh:: ${QUILT_SERIES:=$QUILT_PATCHES/series}
git-rebase--interactive.sh:: ${comment_char:=#}
git-sh-setup.sh:	: ${LESS=-FRX}
git-sh-setup.sh:	: ${LV=-c}
git-sh-setup.sh:	: ${GIT_OBJECT_DIRECTORY="$(git rev-parse --git-path objects)"}
git-submodule.sh:: ${GIT_ALLOW_PROTOCOL=file:git:http:https:ssh}
git-web--browse.sh:	: ${browser_path:="$1"}
t/t1014-read-tree-confusing.sh:	: ${pretty:=$path}
t/t1450-fsck.sh:		: ${pretty:=$path}
t/t4100/t-apply-2.patch: : ${GIT_DIR=.git}
t/t4100/t-apply-2.patch: : ${GIT_OBJECT_DIRECTORY="${SHA1_FILE_DIRECTORY-"$GIT_DIR/objects"}"}
t/t4100/t-apply-6.patch: : ${GIT_DIR=.git}
t/t4100/t-apply-6.patch: : ${GIT_OBJECT_DIRECTORY="${SHA1_FILE_DIRECTORY-"$GIT_DIR/objects"}"}
t/test-lib.sh:: ${ASAN_OPTIONS=detect_leaks=0}
t/valgrind/analyze.sh:: ${TEST_OUTPUT_DIRECTORY=$(dirname "$0")/..}

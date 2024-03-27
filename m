Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526001DDD1
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577473; cv=none; b=jYPsM3+dPlmP9LTtz2B1UDb9loUJiIAYNW+OT5HAIbDBIoPw9Tr/XaJy7vsvxj0hNBptxNvc7DWCJtCorU6oF7dmAF1Q9R5JzrySDrsdIctXyt/swMVhoDOc+5OMQGxCrL6wuA9ybf2Syy4jFn3+tpqc6o1p+dntK15qwhe9y5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577473; c=relaxed/simple;
	bh=pSd+Qnbq8Sja4Hv8qAvgDLUDrvRYzI3+EqshfGRZXho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jFJ4EXiwI+foIJODqSGIl+k5AL1Pj/zfXnwr4blZH7GsRpAtQd6B+vHs+WDmAgyihBkZAIHyKmBVp/iQmZLuhD0sFA3B2PIOXQwDhfaGCUz1pwUepSbVbQtsUsoU3f06vcgSCrEcdibZSPQ1eXcB5WdLxOyQfjohJJfvSkDwx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vG+8mF51; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vG+8mF51"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20C041E4861;
	Wed, 27 Mar 2024 18:11:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pSd+Qnbq8Sja4Hv8qAvgDLUDrvRYzI3+EqshfG
	RZXho=; b=vG+8mF51ZHbn0pzUDhT3HcVxjiZ8ARXfXReS9vvMhtTiYS/ikOByes
	IBBDqxdEBkPCcPyXuNee0SdN8tM67j302x0GvTxAJou1Pn7rzYy0TlDZwvP3U5uP
	Eqkhp1+WUCg2+chadpsGDJ9ohsh28EU8Cv6PZ7MMuYH9pJ8weBrg8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 134181E4860;
	Wed, 27 Mar 2024 18:11:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B0071E485F;
	Wed, 27 Mar 2024 18:11:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>, Jeff King <peff@peff.net>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/1] quote: quote space
In-Reply-To: <xmqqfrwlltjn.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	19 Mar 2024 15:56:44 -0700")
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
	<xmqqttl2qml9.fsf@gitster.g> <xmqqfrwlltjn.fsf@gitster.g>
Date: Wed, 27 Mar 2024 15:11:08 -0700
Message-ID: <xmqqsf0bz5oj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EAACAC30-EC86-11EE-A776-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> diff --git c/t/t4126-apply-empty.sh w/t/t4126-apply-empty.sh
> index ece9fae207..eaf0c5304a 100755
> --- c/t/t4126-apply-empty.sh
> +++ w/t/t4126-apply-empty.sh
> @@ -66,4 +66,26 @@ test_expect_success 'apply --index create' '
>  	git diff --exit-code
>  '
>  
> +test_expect_success 'apply with no-contents and a funny pathname' '
> +	mkdir "funny " &&
> +	>"funny /empty" &&
> +	git add "funny /empty" &&
> +	git diff HEAD "funny /" >sample.patch &&
> +	git diff -R HEAD "funny /" >elpmas.patch &&
> +	git reset --hard &&
> +	rm -fr "funny " &&
> +
> +	git apply --stat --check --apply sample.patch &&
> +	test_must_be_empty "funny /empty" &&
> +
> +	git apply --stat --check --apply elpmas.patch &&
> +	test_path_is_missing "funny /empty" &&
> +
> +	git apply -R --stat --check --apply elpmas.patch &&
> +	test_must_be_empty "funny /empty" &&
> +
> +	git apply -R --stat --check --apply sample.patch &&
> +	test_path_is_missing "funny /empty"
> +'
> +
>  test_done

This seems to fail only on Windows, and I have run out of my today's
allotment of time for this topic.

The earlier part that creates the directory with a trailing SP,
redirects to a file in such a directory to create an empty file, and
adds that path to the index, all succeed and follow the &&-chain,
but the step that runs "git diff" with "funny /" (i.e. the name of
the directory a trailing slash) as the pathspec produces an empty
patch, and "git apply" would of course choke on an empty file as an
input.

With the following band-aid, we can skip the test and the output
from "sh t4126-*.sh -i -v -x" might give us a clue that explains how
such a failure happens.  Unfortunately GitHub CI's win test does not
give us insight into a test that did not fail, so I did not get
anything useful from the "ls -l" down there (I already knew that
sample patches are empty files).

---- >8 ----
Date: Wed, 27 Mar 2024 14:41:26 -0700
Subject: [PATCH] t4126: make sure a directory with SP at the end is usable

If the platform is unable to properly create these sample
patches about a file that lives in a directory whose name
ends with a SP, there is no point testing how "git apply"
behaves there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4126-apply-empty.sh | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index eaf0c5304a..d2ac7a486f 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -66,14 +66,26 @@ test_expect_success 'apply --index create' '
 	git diff --exit-code
 '
 
-test_expect_success 'apply with no-contents and a funny pathname' '
+test_expect_success 'setup patches in dir ending in SP' '
+	test_when_finished "rm -fr \"funny \"" &&
 	mkdir "funny " &&
 	>"funny /empty" &&
 	git add "funny /empty" &&
-	git diff HEAD "funny /" >sample.patch &&
-	git diff -R HEAD "funny /" >elpmas.patch &&
+	git diff HEAD -- "funny /" >sample.patch &&
+	git diff -R HEAD -- "funny /" >elpmas.patch &&
 	git reset --hard &&
-	rm -fr "funny " &&
+
+	if  grep "a/funny /empty b/funny /empty" sample.patch &&
+	    grep "b/funny /empty a/funny /empty" elpmas.patch
+	then
+		test_set_prereq DIR_ENDS_WITH_SP
+	else
+		# Win test???
+		ls -l
+	fi
+'
+
+test_expect_success DIR_ENDS_WITH_SP 'apply with no-contents and a funny pathname' '
 
 	git apply --stat --check --apply sample.patch &&
 	test_must_be_empty "funny /empty" &&
-- 
2.44.0-368-gc75fd8d815


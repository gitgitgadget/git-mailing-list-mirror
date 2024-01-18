Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019F679CD
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705538785; cv=none; b=EttoNcztxMAMWBXkP87wEs0zGUpMZg3Nt7MAwpLuujn9Y6WEvkHjmryEAh1gmCoFXAmPDOnZmoOMqrWF7DptIUk3QpssSJ0cKfWjxL+EvRZhpYOD8gWHgHUspUh7Iw3AniZu0u0AH9qctZFv94PSsUu07kliRXnAqyVSaBZLQMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705538785; c=relaxed/simple;
	bh=nAYdK49YesM4TJcpy8n+KxJ7ecXYKcguoNN7taRN6ag=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=PPP1mGL18Iabijb90lNvgi7BiIUcPfNbS8KTGR1uZWDmzYpk2JHB51BxWKmOBCphmtuPSjP/HOz9OLBYyYO00ORZGVRdwPl/ye2mFJe1aUhWzgddA/+nI+vtGqHZSgY2OFzK35t2uqqtrXG/GgbD/UkjlD7et07qfBHSqLOO6yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RNOqGJXa; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RNOqGJXa"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FF3F1C4535;
	Wed, 17 Jan 2024 19:46:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nAYdK49YesM4TJcpy8n+KxJ7ecXYKcguoNN7ta
	RN6ag=; b=RNOqGJXawFu5w9M8pmBfnp6CbSOVDahvTvH5DpePc+CCmkZ36wcDd5
	lzlqITWkE5jHUbx++dA/16rlADZHF6IWi3YJuv3Yz5HPowv2pbsxIpxQCPr2RHG1
	aH7uICevHJrPd5LX6/CakN1QGsXGLODuj4SJw5NCmsFaelSGpeZXw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 973F81C4534;
	Wed, 17 Jan 2024 19:46:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A72C01C4531;
	Wed, 17 Jan 2024 19:46:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 02/12] remove REFFILES prerequisite
In-Reply-To: <624ad202305138c312e9db7d9cc590baf4e576ab.1705521155.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Wed, 17 Jan 2024 19:52:25
	+0000")
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<624ad202305138c312e9db7d9cc590baf4e576ab.1705521155.git.gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 16:46:20 -0800
Message-ID: <xmqqedeftqn7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FFD88250-B59A-11EE-A4BE-25B3960A682E-77302942!pb-smtp2.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> These tests are compatible with the reftable backend and thus do not
> need the REFFILES prerequisite.

May want to give a bit more backstory here?  After all, 53af25e4
(t1405: mark test that checks existence as REFFILES, 2022-01-31) and
53af25e4 (t1405: mark test that checks existence as REFFILES,
2022-01-31) marked these tests to require REFFILES and they explain
the reason for doing so was exactly because the reftable backend did
not have the notion of "the reflog for this ref exists" that is
independent from "the reflog for this ref exists and has one or more
reflog records".  If your work on the reftable backend during the
past few years added support for "already exists, but there is no
entry yet" state for reflogs, that would be great, but it would make
sense to explain why they suddenly have become "compatible with the
reftable backend".

Thanks.

>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  t/t1405-main-ref-store.sh  | 2 +-
>  t/t2017-checkout-orphan.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
> index e4627cf1b61..62c1eadb190 100755
> --- a/t/t1405-main-ref-store.sh
> +++ b/t/t1405-main-ref-store.sh
> @@ -112,7 +112,7 @@ test_expect_success 'delete_reflog(HEAD)' '
>  	test_must_fail git reflog exists HEAD
>  '
>  
> -test_expect_success REFFILES 'create-reflog(HEAD)' '
> +test_expect_success 'create-reflog(HEAD)' '
>  	$RUN create-reflog HEAD &&
>  	git reflog exists HEAD
>  '
> diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
> index 947d1587ac8..a5c7358eeab 100755
> --- a/t/t2017-checkout-orphan.sh
> +++ b/t/t2017-checkout-orphan.sh
> @@ -86,7 +86,7 @@ test_expect_success '--orphan makes reflog by default' '
>  	git rev-parse --verify delta@{0}
>  '
>  
> -test_expect_success REFFILES '--orphan does not make reflog when core.logAllRefUpdates = false' '
> +test_expect_success '--orphan does not make reflog when core.logAllRefUpdates = false' '
>  	git checkout main &&
>  	git config core.logAllRefUpdates false &&
>  	git checkout --orphan epsilon &&

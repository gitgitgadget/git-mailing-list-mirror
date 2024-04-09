Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F827156C6D
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704131; cv=none; b=MwMSAOU9TKtgtcYaoi6zYMa3QnAONXDWAC1ysrJzy52d+4truel5ccEgIerlyPd+3EiBXVTEL2pVeAjQHsPBx/t4yEsf6iJb9qSfMguisDG/kogc9YMgUuuv/IfOr3IGiAnEm5or5rXCprFYi7Piu2WMmvggy0GKnDDxEICIq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704131; c=relaxed/simple;
	bh=B8PnXNzRXKNecnFyhdXItsd/kWXAhzlbnyQf4XGlcco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FXgBn8/q/G8joTecGBaYtoOwIsyYLQIb3dtE9EB8gDgqPY7KxqdKoFBXRXpcXr4x6/TN5nRtqH1/v3W7Li41ja9kKTqErTtGvfsUBz7/NqEvrYseBsCT33Wt1KBIbriEnAR9O2en4Lx6m7CBqf9lSLW6GUKN6nf3PRV4D5vhX9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W6if7fOQ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W6if7fOQ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BE141D7E49;
	Tue,  9 Apr 2024 19:08:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=B8PnXNzRXKNecnFyhdXItsd/kWXAhzlbnyQf4X
	Glcco=; b=W6if7fOQ9W3pOAYLWwCQfUxQkfnqBpYBwq+BLVPSFryFjRemS03s2A
	Ygs8zdQ/39+rsyH+H9dANeDFPeF0c+P17+48iHCga74dglsmDNTV+BJFVt5isJTh
	Qhj1ZpQJke6sdW5UeYfxMJgBZgVgMpPV80ZHN+edRN177Q0v3xgKA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 029951D7E48;
	Tue,  9 Apr 2024 19:08:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 402C51D7E47;
	Tue,  9 Apr 2024 19:08:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] t3428: restore coverage for "apply" backend
In-Reply-To: <b45af37e3c0a22cc9e0514eb681300be0b968e02.1712676444.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Tue, 09 Apr 2024 15:27:24
	+0000")
References: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
	<b45af37e3c0a22cc9e0514eb681300be0b968e02.1712676444.git.gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 16:08:47 -0700
Message-ID: <xmqqzfu2yw00.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1F387A6C-F6C6-11EE-8F32-25B3960A682E-77302942!pb-smtp2.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This test file assumes the "apply" backend is the default which is not
> the case since 2ac0d6273f (rebase: change the default backend from "am"
> to "merge", 2020-02-15). Make sure the "apply" backend is tested by
> specifying it explicitly.

Hmph, doesn't this lose coverage for the merge backend, though?

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t3428-rebase-signoff.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
> index 133e54114f6..1bebd1ce74a 100755
> --- a/t/t3428-rebase-signoff.sh
> +++ b/t/t3428-rebase-signoff.sh
> @@ -38,8 +38,8 @@ test_expect_success 'setup' '
>  
>  # We configure an alias to do the rebase --signoff so that
>  # on the next subtest we can show that --no-signoff overrides the alias
> -test_expect_success 'rebase --signoff adds a sign-off line' '
> -	git rbs HEAD^ &&
> +test_expect_success 'rebase --apply --signoff adds a sign-off line' '
> +	git rbs --apply HEAD^ &&
>  	test_commit_message HEAD expected-signed
>  '

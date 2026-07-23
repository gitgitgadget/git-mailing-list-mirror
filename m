Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F5348465
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828165; cv=none; b=DbPHRGj4cplWoj84GwlfA5GdZ+n2xTevztO16ZDfli2edDsalBHCAW8Gz/EioLg+XyFmBI/Qxma3UY8ix9GPUbJdXieopkcmRT7tPojzKxuFUrkI2MtbZgGd0FYMndnO5gZB+D9UcrwGpyxfCQZj7Sn6UNubLLujGlpDjIvJptA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828165; c=relaxed/simple;
	bh=EXKMvn5AY88PpCcQfnOMEZFF7se/6eZIUUY2CCd99o0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H3a52GWSLBlxaUv/83JkgAQddq4d5JCzJ3O8qU/+063bfP+IidzcdT3skJM+wdS8J5jWEGjFbsPttQVHWzz6Pu4WUWPda8RHcldndVKRr67oZf1huuZJclf04dLVHzlXYQon2qjeabzz3l4m6gS1gPgTCRiGra5TcWjElNh31OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=w1e0Wnmm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sh2e1Y8v; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="w1e0Wnmm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sh2e1Y8v"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A43471D000D7;
	Thu, 23 Jul 2026 13:36:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 23 Jul 2026 13:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784828162; x=1784914562; bh=sxF+Pm8qVT
	hHUGhnTvyPBTIec7SGDmqJUWjqswhr/so=; b=w1e0Wnmm7vM5WXWtMMqGAmKW5g
	zbX2Yr8asZ2CgXc1je1oMFuf4GhmHZ6cwXq5qrBoHYD9KLGHoHvNdMyU61fLDSNZ
	lbiT3S0GVm8DYX/JtbTdn5eU9UzX9OQPrHaAmt70YaM5rqscBtJjfaDlh7JqU3xf
	FLgakQf1PG4AOlOxFSl46Iz/nQV8ZdN2s+NPWasP6RU2hLd+Uw+8S8CIN+PsZwsh
	ZRU41DQ1wdbUqf2vtx/jqdv0nGtzptPNMU+lTNjAuBk5RFyvhDjh7k/giymbP7b0
	1as3D0e4JjY/sJAD48qTonjyFBx45+O6g2J8DeI0KudSyNBFv7PscnZwx/yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784828162; x=1784914562; bh=sxF+Pm8qVThHUGhnTvyPBTIec7SGDmqJUWj
	qswhr/so=; b=Sh2e1Y8vscDhUh3nvnfyamYXCETNBMqftucXM4Bt2BNiWxJH6TM
	Ik5wCMYW98zo/1G7F9g247V7bUD0dA6kt8CD+P9ScoZqnAKCcgr9/0cSdfasRGrS
	hBHTZSg8LuB2Ij46foE1SJd6LfukfmtuZr4kQ+xWIykmRIu2UGeQzBX+sdo+kZ//
	hBWT4kmb5BCemtON2wa77i7uja3ZavjD4EP/TUE4s6JXlJfw4JRXDR+CEclejIjf
	69bAuBD38oTjdQqs3jTwu61mob9qIqIClY1mqciVc7rcf8nTR14fr6knf+KJGNEw
	o694pFmoyDrpoy1RkEujTcwYCa8aLecXbEg==
X-ME-Sender: <xms:AlFianiunkOESfKmNFoZ9TU0I_BYqeH26R2oSSkG4nC2DWnAcF6iBw>
    <xme:AlFiaq7_HF2l1-GscyjpWwDYGokXyClOzUndQm9CG0wMEAaKUQ5aPY3Y6O5ssvcRN
    PShExDGftKhAMUSEeqh3EmwK2QzWcjgavFCqIGjF_xwDqYe1fv1qg>
X-ME-Received: <xmr:AlFiavbDie52awNCPjSN7oxlc0Lfzkl73RKuKN_2oXZJUGB0VEXaXndOVXFLf3elnSGQaVAa_J2OLCCi7zjl9GQey6AdQ9erHA>
X-ME-Proxy-Cause: dmFkZTGilgBZtCyEMCMbgRYavXAm5P6oYk9JnpY/+NF5c+dfFynKNN3MH2pWXRKvkoU2ZG
    4N0w2Wzh7k8A1Dd9EmMKkp7vUA87Ym3jwoOFXfnwpZCGj0ik0J3gryWbuyNvloHVfww9C5
    XkRw+uJANHnK6DJ/UGJhhLjme4aEQq3CS/1/z8LVFzwFSUgEuIj4NsUbnPUCjs5cKLkHhe
    qQTDJ5ggI7YUuOgoW0StJfboZmtQjjcn9sYv9BT0arB05fcgEfDKlJIXDesspjcvbdkSQb
    P56Z2UINzT3MIgc2gwQdreAPo2OD0+XZISasgxQNZVECjjcTe8kUYiXzEYjy4Jb3c99VUN
    +rCD3gQwjnNlxrLDmAN3o8XcomH+D8FJA6rxxs+VxJE0KfRj+1WRCkuXTG3XNecwfpKX3b
    YjGUZZtihpYTDHc0sWiDzCo3FiTjMmxVKuhw+LfYoF1FUaW5r1krG627xlvsmaErmQOXZ8
    nmqD1AcC3N+0qlcC/egShrs0lpAmkH9/EeoxrueYH+T1btXXFsOTpEUtSdrnyoW09r6iLf
    osNvCsTj9RQBPRgUG04rQUUENTdrT2hxvLFV+8B11/X7NeJ5RdS6G4L8jIx8WpjoHfmq1W
    f+A/VM8GwoNVewYE03WNxwsLaHbUJaESktdxjvKN+PmEeB6IQfJqTK+WBrRw
X-ME-Proxy: <xmx:AlFiav6dINcx2fzd5-L7q2Bvuu-gSmsKX_jkRW0_Pn3qS2Dz6rRRpA>
    <xmx:AlFiaiA2EwZiqesUT0owSlRqPXEgNdn5Tlr56u1BHcQX3HFEARfsIQ>
    <xmx:AlFialclS4Imo3IhFCXv9iiAzRmL-prar8ZADV_ZQkl6npphp6PDhw>
    <xmx:AlFiahJY-DF-OI43Y1su-ziYA1FlOOcFyy7RnwD_5UdoYkSvU8uwaw>
    <xmx:AlFiarIpM-15uvD-pilN2prDMTTd87zUkM-YjDu3gNFSsLjE5hU4sEBe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 13:36:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Lucas Zamboni
 Orioli <lucaszam0@gmail.com>
Subject: Re: [PATCH v2 1/2] mv: name both source and destination when rename
 fails
In-Reply-To: <0d67da588bc86c5257ce366903ae58e171159b8b.1784812390.git.gitgitgadget@gmail.com>
	(Lucas Zamboni Orioli via GitGitGadget's message of "Thu, 23 Jul 2026
	13:13:09 +0000")
References: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
	<pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
	<0d67da588bc86c5257ce366903ae58e171159b8b.1784812390.git.gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 10:36:00 -0700
Message-ID: <xmqqh5lpk3r3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Lucas Zamboni Orioli <lucaszam0@gmail.com>
>
> When "git mv" fails at the rename(2) syscall, the error is reported
> with die_errno() using only the source path:
>
>     fatal: renaming 'src' failed: No such file or directory
>
> rename(2) returns ENOENT both when the source does not exist and when
> a directory component of the destination does not exist, and errno
> does not distinguish the two. Reporting only the source therefore
> misleads the user in the latter case: for
>
>     git mv a/file b/no-such-dir/file
>
> the message blames 'a/file', which exists, and gives no hint that
> 'b/no-such-dir/' is the missing part.
>
> Inspecting the paths again after the failure to determine which one is
> at fault would be racy, since either could appear or disappear between
> the rename(2) and the follow-up check. Instead, simply name both the
> source and the destination in the message and let the reader see which
> one is wrong:
>
>     fatal: renaming 'a/file' to 'b/no-such-dir/file' failed:
>     No such file or directory
>
> Signed-off-by: Lucas Zamboni Orioli <lucaszam0@gmail.com>
> ---
>  builtin/mv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index a82fc97a19..35e504484a 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -549,7 +549,7 @@ remove_entry:
>  		    rename(src, dst) < 0) {
>  			if (ignore_errors)
>  				continue;
> -			die_errno(_("renaming '%s' failed"), src);
> +			die_errno(_("renaming '%s' to '%s' failed"), src, dst);
>  		}
>  		if (submodule_gitfiles[i]) {
>  			if (!update_path_in_gitmodules(src, dst))

Makes sense.

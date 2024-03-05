Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119DA12D1E0
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677702; cv=none; b=lWNEsnHM9/CcEsc0YdraJRA26QYljFW/lXDA9h4PutS7P+FVokMw2x+a1/KJPYRcijBaHSutCKK9hjhwRLsc0ZnsY79fxVkp1pSEiitOnVk/TdITQVx97FyzlaTTzjmbR6hc/aWhoqj/WuBje8Xpux70IKFa9r6+K9xN2X+WUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677702; c=relaxed/simple;
	bh=VA5o4EjAEAaFlJTD6xX0jwxCmEpzo8S9q6hDyAiKukI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UzMwJvDVPwYfW0aRx6JBQVxj6wBQCD68qOCNEbzn/yjfp8tUYKQl9ywAcSde0KD5EINI9RFj+Ph9hrmdm5DhxvaJQ2DEw5Gut9z1aMwBG0s6bTRhAVwGk9yxVdL6SuOTCX/HqSIZCz1eV5Mw2r9oh8v1mUPfGpT9zyWTaBx1F9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pwKRKtQk; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pwKRKtQk"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B871E1FE41;
	Tue,  5 Mar 2024 17:28:20 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VA5o4EjAEAaFlJTD6xX0jwxCmEpzo8S9q6hDyA
	iKukI=; b=pwKRKtQkAmPUfZGVQWOnBC99hr4CrbwTUMaQmcAEi+hxY1TVsZr3eD
	zqyJHmXdeY06TsANpiY34IxF+nTYuSTwj+lGzJSc8oxZ5R+sOTciA6BW/V7YX87d
	gSJKABI6bCe6eG92tuTcY9rMjewoLhHFVH/9U2eYDq/YzAWNo3FAw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B157E1FE40;
	Tue,  5 Mar 2024 17:28:20 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 48A521FE3D;
	Tue,  5 Mar 2024 17:28:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 04/22] t/annotate-tests.sh: avoid redundant use of cat
In-Reply-To: <20240305212533.12947-5-dev+git@drbeat.li> (Beat Bolli's message
	of "Tue, 5 Mar 2024 22:25:03 +0100")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240305212533.12947-5-dev+git@drbeat.li>
Date: Tue, 05 Mar 2024 14:28:15 -0800
Message-ID: <xmqqplw8xqio.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A9CB0430-DB3F-11EE-9E92-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  t/annotate-tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index 5e21e84f3884..87572459e4b8 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -532,7 +532,7 @@ test_expect_success 'blame -L :funcname with userdiff driver' '
>  		"$(cat file.template)" &&
>  	test_commit --author "B <B@test.git>" \
>  		"change" "$fortran_file" \
> -		"$(cat file.template | sed -e s/ChangeMe/IWasChanged/)" &&
> +		"$(sed -e s/ChangeMe/IWasChanged/ file.template)" &&

Obviously correct, but 

		"$(sed -e s/ChangeMe/IWasChanged/ <file.template)" &&

might be a more faithful conversion (when "sed" looks at its ARGV[],
it did not find anything before, and it would not find anything
after this patch).

Not worth a reroll, of course, though.

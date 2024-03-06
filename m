Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DA62CA7
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709686804; cv=none; b=bxCX4xcRUdgI9Jt++IDTRbtHrcS4fYfKO8xag6HDfiB/SwxtYwR0siFzNpbfQg3iwpZLz4qi3OX3lDMkcTh96ycXHEcjgBg2Pss3YktYM6r0WJVqRALVS5USHv3EtACsjMlwFSRsgy3YukXMWx5opvusSvVnY+Uzb6qCj5k1RQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709686804; c=relaxed/simple;
	bh=vtoZHLleYB6ep4/s1CJPB4clO4NhHGy5uMATFxS4pWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d3sSYRuO3SwfbbDr5bKKdQGqGZZi1QirMKzQigYJKCHsoU5ZZc2q1zm7UrJarsqjOyTLY3k5J030uQFVRS1vMlvlqRJFpqPX3S2MsILKIRKk08ahNk11P+VlvjGtaMzcdfkMSoR4Ywrl4F+t4BSzYtLMp1lRvkuXtlg0F7AyLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KblLdT/4; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KblLdT/4"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D1DB519171;
	Tue,  5 Mar 2024 20:00:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vtoZHLleYB6ep4/s1CJPB4clO4NhHGy5uMATFx
	S4pWo=; b=KblLdT/4XjSCX/OwBSFQOS6/5JzK3wZDBZeEXHFjOtGYfD+TKhzs7E
	CT0bLyoFA/2F1lrmu0uYqjrNY8ONS+fgVN8Yx38d8yR5boTUVt+CEr0IrAi9lL8Y
	6Hdf6VLUuid2F0oP+3W/sRBUuGgJHg1ee4m8dpySNC/utlawpJTcA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B765119163;
	Tue,  5 Mar 2024 20:00:00 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 13E2E19155;
	Tue,  5 Mar 2024 19:59:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 19/22] t/t8*: merge "grep | sed" pipelines
In-Reply-To: <20240305212533.12947-20-dev+git@drbeat.li> (Beat Bolli's message
	of "Tue, 5 Mar 2024 22:25:18 +0100")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240305212533.12947-20-dev+git@drbeat.li>
Date: Tue, 05 Mar 2024 16:59:55 -0800
Message-ID: <xmqq8r2ww4xg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D9AFBBCC-DB54-11EE-BED6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  t/t8013-blame-ignore-revs.sh | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
> index 9a03b0f361ff..05213d13f30f 100755
> --- a/t/t8013-blame-ignore-revs.sh
> +++ b/t/t8013-blame-ignore-revs.sh
> @@ -25,11 +25,11 @@ test_expect_success setup '
>  
>  	git blame --line-porcelain file >blame_raw &&
>  
> -	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
> +	sed -Ene "/^[0-9a-f]+ [0-9]+ 1/s/ .*//p" blame_raw >actual &&

Isn't -E a GNUism?

At least,

    https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html

does not seem to have it (we may need to fix t6030 to rid its only
existing use).

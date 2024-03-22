Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9811854
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 02:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073578; cv=none; b=Ut8K0dLA7nqpQJPCw2K9VJAVyCk30ez76h35akyjA51uyXnOveMg8U8I6K0cU90DJeDQ537MZNvzOSzsgHeK3fk58D7yWsD1ggwgEGukTk08IFeaOBnUuR5LVk9Jx31acIZmcu5GGJJliMRVoLUm3fJ6CgrWxa5d91aA8a03s9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073578; c=relaxed/simple;
	bh=CJj/QdrN82cu6yK05C+ZOZJAsKGsZcnlqHv0dT00CPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pxDuGysqBH5lqa72+BYI514T1P96j/2WfxsTx2+Yp+21qveNO4iiFtpk8N8kindu1PKS1uWLZoGJCGFMA1+XnPIrxC9z03UnaAaUAQnByIVtvo8Qw0zIKpShKZ1KEdcEvvfMtIlbLqUsc6P8Hlt2Uv0fkbKNz+4sstW+Eupe/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eQH8kKy8; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eQH8kKy8"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BEF6E1F3E83;
	Thu, 21 Mar 2024 22:12:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CJj/QdrN82cu6yK05C+ZOZJAsKGsZcnlqHv0dT
	00CPM=; b=eQH8kKy8/HQqmXoaO5oOq6TmoIJ35Q6WyZt0vqgNiqxNrLfuOdjhrE
	UMNP4OS2nkdMOkT1zDUNMS4yiPW1YvDhAdtVruxDS9y3ca9QXjWMSZj7G/a+fh2U
	UTblrMJAT+hp1rwiea2kvaVKZdxm6dhmPZrmROczZC2LpmikJ6jwA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6BDA1F3E82;
	Thu, 21 Mar 2024 22:12:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 143211F3E81;
	Thu, 21 Mar 2024 22:12:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH 3/3] t/README: document how to loop around test cases
In-Reply-To: <ZfzncGTNVwR8BrhR@tanuki> (Patrick Steinhardt's message of "Fri,
	22 Mar 2024 03:05:36 +0100")
References: <cover.1711028473.git.ps@pks.im>
	<326fb7965036fccc1c23ad02f200251f6388e6dd.1711028473.git.ps@pks.im>
	<xmqqzfur8q5z.fsf@gitster.g> <ZfzncGTNVwR8BrhR@tanuki>
Date: Thu, 21 Mar 2024 19:12:53 -0700
Message-ID: <xmqqv85f3tga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B1C991C4-E7F1-11EE-A2EF-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Hum, good point. How about the below diff? Will reroll the patch series
> if that looks good to you.
>
> --- a/t/README
> +++ b/t/README
> @@ -736,7 +736,8 @@ The "do's:"
>         done
>
>    Note that while the test title uses double quotes ("), the test body
> -  should continue to use single quotes ('). The loop variable will be
> +  should continue to use single quotes (') to avoid breakage in case the
> +  values contain e.g. quoting characters. The loop variable will be
>    accessible regardless of the single quotes as the test body is passed
>    to `eval`.

Wow, simple and effective.


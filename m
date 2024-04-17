Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB78381BA
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382471; cv=none; b=nDt7/mVx3lgkwa1qli23w2hho6I+L3cXOr2Eaa1k2lZmeYt/MzDPWuCdI9r/X0SVsx2KBsW1xJ/067SaUnM0wEjU0Dp0SISzVrEKtX/9Rckrtu6w/9F6nS7Oap8cr00y+fB9vCMtsW+uLRXx+9XxkZNj3lOysfbf3145JSH6WoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382471; c=relaxed/simple;
	bh=1Km9PETWBA92YkZ9Xkeh7+d+cHP39h0prUSSkKx+f8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aMUaxBPOXLF4R0OBEvJmBcCBmkrc10V+Lnb8UelwGcoMjS/LFNbSU3m7hctHZlRpZObHv/ZG076b4lKWa6YIjR0yjNOPrDH9na1+hdoGqcoE0J1bKBZchMSH3+fu0PB4kIaijYqtwhROf45DBWWZzmxXIEU18cJTo2c9TQT4t+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uG8kPxjs; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uG8kPxjs"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3269A1DC96F;
	Wed, 17 Apr 2024 15:34:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1Km9PETWBA92YkZ9Xkeh7+d+cHP39h0prUSSkK
	x+f8M=; b=uG8kPxjswfZQReAo21H6SODGANGPhUFTS4Q7B2cSm2PMKsctzmiGgP
	WowG0U2svjjvSh70wK7nPng/QSpp7orwsmiUY8yo9qKhtXmKKWJrGa2crms6sfMa
	llO8aP/xxBpdbJJx5DyNY0N6Pdi1523HUUSd1+cs2bCSkie4szfLw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 28E541DC96E;
	Wed, 17 Apr 2024 15:34:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88AD61DC96D;
	Wed, 17 Apr 2024 15:34:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  blanet <bupt_xingxin@163.com>,  Xing Xin
 <xingxin.xx@bytedance.com>, "blanet via GitGitGadget"
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] midx: disable replace objects
In-Reply-To: <pull.1711.v2.git.1712554017808.gitgitgadget@gmail.com> (blanet
	via GitGitGadget's message of "Mon, 08 Apr 2024 05:26:57 +0000")
References: <pull.1711.git.1712495507815.gitgitgadget@gmail.com>
	<pull.1711.v2.git.1712554017808.gitgitgadget@gmail.com>
Date: Wed, 17 Apr 2024 12:34:27 -0700
Message-ID: <xmqqplun6aws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 818B3F20-FCF1-11EE-994B-25B3960A682E-77302942!pb-smtp2.pobox.com

"blanet via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Xing Xin <xingxin.xx@bytedance.com>
> ...
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
> ---

I think this took the review in

  https://lore.kernel.org/git/ZhLfqU9VNUW+2mmV@nand.local/

into account and is in good shape?

Thanks, both.


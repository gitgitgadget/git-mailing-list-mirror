Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E3DDD9
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711963775; cv=none; b=DU1smcxSPVJTwiP5AXikMf84LdWPTaPi+G1WUsDQG13+4Xem67KuW66ZwT6qfCedtVZiqXlk8hgCs1osIhlubS7dQlLTSsZ1yVSxSyAPVxECwY4lZgC0PJv3MXAMhyjElq1sSwtoAVXcvwN33EfLidoRo06EZwndAK2VuAf3Y0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711963775; c=relaxed/simple;
	bh=utDjJocFbLnK/HkWevh+msAzaUUM2KFELTximh61XlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=efLVtJGIVWTzbMev0gekCeeXCfWydC65k/4a8LXFvee+7ev3WK2WYQGOmaY58FSuj/oFT0WP0uCADS4QdxwHUA2jEXRi79w8t4klcWGufA0cuk6+G9Gqn4GPSExTKdBm+l+3DPH0hlTffWYur++cerXmvpyF2mW6Lk3EzLifu2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tQdGhNU0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tQdGhNU0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B76681E43F8;
	Mon,  1 Apr 2024 05:29:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=utDjJocFbLnK/HkWevh+msAzaUUM2KFELTximh
	61XlA=; b=tQdGhNU0eQ9knTyk7daqo2b1NOzODzYKwAD6PSxjdYN1TdsDfsOXK6
	4l7N9HIPR6MI6PSyUABDsXdbHTE5DSZpL2prj3/tbPKJDVwqluxFrUMnD0vs3Usu
	/WWJSCX1JV5wvsX7UFngXJVRrrnxqzh/vvOrvK8Rc/vBn0ZqhB1eM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A055D1E43F7;
	Mon,  1 Apr 2024 05:29:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBE3D1E43F6;
	Mon,  1 Apr 2024 05:29:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Emily Shaffer
 <nasamuffin@google.com>
Subject: Re: [PATCH 0/2] improve bugreports
In-Reply-To: <CAPig+cRFqddMqTxCENnknv3Agcq3_bxGmB1sQTmJNb=xNYg1aw@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 31 Mar 2024 23:09:02 -0400")
References: <35de2d76-a03e-4a36-9bb7-6b6ffa4ea123@gmail.com>
	<4f179986-6aca-405a-a122-d0dc058c60d8@gmail.com>
	<CAPig+cRFqddMqTxCENnknv3Agcq3_bxGmB1sQTmJNb=xNYg1aw@mail.gmail.com>
Date: Mon, 01 Apr 2024 02:29:30 -0700
Message-ID: <xmqq5xx1e8hx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 58704246-F00A-11EE-88A8-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> redundancy. In particular, of the three questions:
>
>    What did you expect to happen?
>    What happened instead?
>    What's different between what you expected
>         and what actually happened?
>
> the final one seems to repeat what the first two ask, and it is common
> when answering the third question for people to simply repeat what was
> said in response to an earlier question.

The third one may need to be rephrased, but I think it should still
be there.  The intent is to make the reporter realize how unhelpful
their answers are when they answer the first two questions with

 - I expected it to work correctly
 - It did not work correctly

They hopefully would realize that "work correctly" needs to be
elaborated in order to answer the third question in a useful way.
If the first two questions have been answered in a usable way, the
third one is often redundant.

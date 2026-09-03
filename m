Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6298350EBEA
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464770; cv=none; b=f5It3aX8qalld1oPENKcyDUffGa06FRg9obiKkqdwPNIoEt3u7+IYjs3HI6XbQgMIGLrp6GFPyyB7tePDBGKCWVkH0zjL1fK1wUEwf7pcqkjxPMZESVEMZUa34NOh1IFT+vL/BCAoCi/nTAiT+9smwfcks8I0GOljNJG0RZP5j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464770; c=relaxed/simple;
	bh=8/GrueIJUycIYpH1YdkPwMKnlApEaSb+IgLBIaSZMQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uyZBSn6m3q9JiQ0Rc8hZ9gF2w7JU8eBoqa90ILGWvfCekNz7OZNPfcUlw3vCYBE3mvb9S3D5Tpj3pRRNqxgAd+PukGryn1sboSguOHzfZ4uMxXT+sy6GEsLr/sLvX3XlnaZzHKlix8/YqZx/1/QqjEJ9Mn6iQ3OruFteyDvdpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=em/p9cmJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K7u9BW8E; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="em/p9cmJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K7u9BW8E"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40B337A01A0;
	Thu,  3 Sep 2026 15:45:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 03 Sep 2026 15:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788464753; x=1788551153; bh=KkLRMlo088
	RyZ9LALo1QkyWbBxzhOFbZHC6r57Qm/ew=; b=em/p9cmJ0jTUrK5n/3ASMSAlNY
	ZmOZHpU1BO/MxQW7tCK8F2MaOHqA+ozL7bn0qljsqy+iaf3qGyp5nkhfP0kd2gK2
	2QGTvZaaRM7oJmwbVR2ujOTgX/saNcT8PucbFcUO3dZlzPCGt0jia3NH9pip2FTz
	faVIKdKgzAZhSRGJz6QNZ1gvLBLIhUUSXl97M+7wKA+op0p5SlRQ/VkkeB/lc8hI
	e8PrUtFV6Y/zzI1SDyO+P6DZysiTqECAnBUXo8p7owcWF4yq1HZ0/i1CECf9HgzP
	hjzWyk38Dt5DM6VUAVVJjRQD+1TG4LtZXoefGUvlXX510UhY8xO2LhCfgPsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788464753; x=1788551153; bh=KkLRMlo088RyZ9LALo1QkyWbBxzhOFbZHC6
	r57Qm/ew=; b=K7u9BW8E4TxZf6YNtd9akvYKk9oV1a+mTwVramibuIIX/vgVb+O
	ssOpBuxbSGf+mkkI7sBa33WTdKvEl1SII5+M8FhGCCIjEewCd6nxYSRh3lmLlvgg
	4c0jEHqHi7Rm73dc+T8YfEnGXLk5O82Sj5detzE4hUAuwYGHLls5xfkAHF9jXyTz
	x7ypEmC9KnbHHJijws8ixM0qVHV88/p60TemA6NyrdDmvF8uIHBbGARMN2L2t0ol
	0mMVYTZwyff6egczk3kASgIQ2f1uRKgjyd4pIv082P8TVKEpwwrJYgGrnNblcEkS
	VMvtg9iCfPCOQb0YiWo1G9aBnuQGkWw8otg==
X-ME-Sender: <xms:cM6ZaiEjSv8W9_6x_jhj2vrM0GP61bErXIbK0bFb91OmCXIKSwtutA>
    <xme:cM6Zak3FLdTjXtHei0kXRp-bET9JJo-f_cV5n9hbV7AHaFflqxF2hnoFdQRvjwHHC
    8LGYTbEcMqEh11kMksgVEcL1w1l0TUBwtV4IEDXe24_eWUF-nz4nMFG>
X-ME-Received: <xmr:cM6ZasPs0VSHNnX7c1FSB9jzwXUb8r_k0B2dbKTdcUILWRdn8DFVPBWhYwKlhh0BZjhZsQA9NKDrT-sbY5F55PlZYGOU7Vzncg>
X-ME-Proxy-Cause: dmFkZTGFPiw1XQMSgZy/9gqC/ot1ouqYg8jVxoLjkhCZQqNqyxX4HKxqrDAN9HV+avEPYM
    wnJx5baHsXModqwOVAyVJSIA1kgvImv3TE78gkYFyD6q16d5NuLkhhHFmZx9+KroYHBkTS
    kzK5GgHr3N9rGe1JfQYsZZAnCPlN5UHyX/zsHxZLTpRFvYzWsmXsauQC5XaQ7ZOdvkg4dA
    t8UlDK3/P7+cMn0WIDst8xk3mgya3fDn5cGOjpKsmd2XUybLggl+d/nYTMzLrsyx5Ptjig
    RKQPTgz02XdMVox2boOhx/ofOTXlr9CbFKonrtsWbvVg2QefrgyiH2oK33xQtRYiLfTtIS
    oX/UcxH3sWC55avp9tFPVxJ6/D0amkUMBCk3Is4dm7YtvCHJL2J17yGNTT5iomndwKqDgt
    wGjz3CFzr9axfrqyq8U6X1TqxAyQfWaM60l2B/dA9+PQNWEK42CwzrrjH0qejYs4fRHet0
    esKjuflHz9+tilIBIDcT42F9EIJN71nqQbM9wCPsKIllmyMSdaj3m7r07ILRL3hAIc+4g3
    8/8xg4dDwDwFrZ+TTPssEipICe3R/ddZYIYVYP/sJm1MBN2/3M74Swecg8TFp7PPcMO7po
    LJeAqFwST+RnxQEDESXzccJSiDlBSuNEbMcmbVl3vV9kKXfEcdaYxjJUiqeA
X-ME-Proxy: <xmx:cM6Zar5a2RnkqQT-BmF0tWsgwPR8nHfJ3ITS-Ajm1WA3vtiAlYpCZA>
    <xmx:cM6Zau2ecwqmRh5nFZklHcwqHvtd2XOC05gVymSnXtncJLyEqU-ctg>
    <xmx:cM6Zakza8FMuH2z3QDxtxu3sLewQnpX4IrrM4dMiNkkTrbcPDhr53w>
    <xmx:cM6ZaguVgJD-nI5_KJOXi-DYfWHnTlDMayqVbCyhuwJUBsjRKnxC3w>
    <xmx:cc6ZaiRbOFCjUXImVAIMbQc79b74cvObOnOcLYDewavGZskptKEyepUH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 15:45:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4 1/2] stash: reserve exit status 1 for conflicts
In-Reply-To: <CAHwyqnW8sdnDcncpZpaMD8fmWaj+WJQxhA4G-Y+L5PTW=h3k6Q@mail.gmail.com>
	(Harald Nordgren's message of "Thu, 3 Sep 2026 21:09:52 +0200")
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com>
	<ff4322180294c784bcd5f4e92b35e4b334324ddc.1788373743.git.gitgitgadget@gmail.com>
	<xmqqwlt3h1oc.fsf@gitster.g>
	<002b1324-0f7f-45ec-9f67-624a41801ff7@gmail.com>
	<CAHwyqnVp6BVGx3+UCqBC_gOCuyq1c62uNi1f7Wyfpxd1KdyM9A@mail.gmail.com>
	<xmqqqzjab2ho.fsf@gitster.g>
	<CAHwyqnW8sdnDcncpZpaMD8fmWaj+WJQxhA4G-Y+L5PTW=h3k6Q@mail.gmail.com>
Date: Thu, 03 Sep 2026 12:45:50 -0700
Message-ID: <xmqqwlt29l01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> >> > Style.  Once one of "if", "else if" and "else" cascade gains
>> >> > {braches}, others should do so as well.
>> >
>> > I would love to have a linter rule for this, since I keep forgetting
>> > and it's a waste of time for others to remind me.
>>
>> Does our .clang-format file already cover this?
>
> I don't think so. When GitHub CI runs, it doesn't complain about
> mismatched braces.

A local "make style" while you develop runs

	git clang-format --style file --diff --extensions c,h

which tells the command to check only the parts of the system that
you touched.

I do not think it is used in CI.  

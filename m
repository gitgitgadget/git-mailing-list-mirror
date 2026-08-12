Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1321372ED5
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565126; cv=none; b=kns4uFtOMeV82HgURBJzef5EZHIgiAdEQKkYhC3qsRxGCreYMTyQqil29HOP2JG/teOO2Jk+1NlMvV3uKiRtyQqiJANlsF6IYWBIo58a7dFV6oCv7UeAXKHLCiG6TpPG0PYP79j6Uf+yNRXL4COUiBB2u+nInLfiJg1VpjNBwdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565126; c=relaxed/simple;
	bh=ApDZ7iEkW0yCuJ97dqmN2ZI/0XBeo/T2qiTK8dW4PYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i50a5Zc5Yj4gQLno7LiISaeMCgphRnMosG7csTz5vnyJE1KgzWFLjmS1iWVl1aaORa6wyQzE4bNYu7Wl8ngnx1nqc/MHwcSSSmb4Xz9T/ynIOX7WBjh7uv5+zkY6tkCp1nEBNYTkfB1NUo5/2UyzpqfhXAFLclZ6qmKedZHX8zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rUMCo9NV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I54KCQmq; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rUMCo9NV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I54KCQmq"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7FB1C1D001A0;
	Wed, 12 Aug 2026 16:05:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 12 Aug 2026 16:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786565123;
	 x=1786651523; bh=4Qq7ZHkZ2Zk3dfjRplui4Xbr9wbNAVDbBghAAodMcTk=; b=
	rUMCo9NVKYo7ymFxAXxrmHyseR740mBIL1oF74/tqw4LkceiE3FHSRvIb6fHaWU6
	/vlU0z+o/R4nc5+s6h0MXAMNfx1qmkrxedA0Lr+bkfYURyJE2PXJeX2L+yn+LYex
	oJUDRWLh5VNoGwIiNjkZ/t9bxbkEJrUR7budOAgZ0BfTzORO6KKve1fj+dxuVR0O
	w80M8C2hGqmHalMMu/4mmRKHl0affDGRqYLoXwNALHyh1gaQHtW+jHe5n71h0opF
	MJwOhuXZrvEdr2YJDtbIRCpMiJoyz2oq2j8LEs6noPVS/hqqCk5URSJL9xVwwm21
	EiYdOqKtj0Gt3RrC/OdRow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786565123; x=
	1786651523; bh=4Qq7ZHkZ2Zk3dfjRplui4Xbr9wbNAVDbBghAAodMcTk=; b=I
	54KCQmq8uZjLDppVJVLfrrGIh0t88TT7ADDpPJ2Me/w8W/1OrsgaljdePEHoLh26
	4LPvrx8VSfXyHPJ1y56N9ytExMV/1wWHo3IVFQeHwxVcBHOOkNYociWMBRtGGLkp
	6YOZ0e2GuBicIBmDklQwwHrfXy4DWfQu/j17Sb96iAUqpesa0FZmsL8c9Rm45WvH
	ZgxXp3TGV5yriOsYb6Jdj4kUUrR+7dFOjQGzOqyP0GjW2/XG1gOBt5J3sMH1+V3n
	6mrzji87YfpWfZLcMUinXz2GbYTb1MK6quHoWU/WR7avoDeV3VEXBYqmK+4O2rlC
	SXCthzL5NJVlPFE3B7DIQ==
X-ME-Sender: <xms:AtJ8akBWlMYcHFqc0wxnbaM3wr8anpnCrhKamioJ7T7VtVuXOKVelw>
    <xme:AtJ8atYf0_Dowv20LlafFFO6DPzrn6APbVXEhGprWhV2vZ-8UxrFZebI7-EyOe-WB
    O7c8FgwozSGHnOrs9owGJS0RA3yzaD70cT1G3JYPbVWOHOQ6VpScQ>
X-ME-Received: <xmr:AtJ8av5k2cj2EZp0sI7KeIMzqCpyBkq-FfgZtoCrfE6aZ7QzgkXfc5RULljRA3tFYN9fDDQMm4Ap2rn15XREPXZb37yYzF6NsQ>
X-ME-Proxy-Cause: dmFkZTEV4Jr6PDHvdVweMe6ZCp/hT5uVp91ge88+3VgFECRAa09eTZF1VUGovrJQifkdDQ
    JeayRvK708PM3K4sQrTTvulwKlJ1EJ/ytdWzLgqGDA/x6aJATqxtM9AfjjLkT1hBWpUTcT
    PMA21wKklFvCFiLGk/O47HQPaWX8p+/OMqCUDi4oNLaH9yClw0wc7ueP7FMKqCVFq+j+HZ
    cEa3O20ZNn8MpfXk7aWsyQqN9dAz8kzdrVLfIpfUZmaQeYC+ZCLPX33aGTBFWg1tARGGey
    MntD4kfkqkS3+ELO40x/glslPWB1csMZg6X+D4BpRmPUzL9IWDKsBOvQMqScaAwS9czkqs
    U8f3NJhEMo+vGqyiJRgLag5GEsTj960gwN7s4KAnU7plwa0ILeckQIRPfljMALETI3zN1N
    kSeWjE+kzWaJ1uDjCf6C4oKNfyX7yngD/Mlypcbm20mDT7hbqPqz6mJQ8Z6oLE40nNYIFg
    S1yLC7/cML+s2mP6nDq2AM6xd5ll3TnndXXz+WG0RT4s307M1iarBGFgK6OLiVc/5L0ZfC
    FU6qSE1M3GgOEIPTYWE6s9ceFJ6nRj0U3/CrZAfHP4k96y2SSTIZCB+iWm1+Z+oFAGpmlT
    WtR4j/PvtOlpL3u2yLjb61rb0gOVZAgY1LZzzwsQSKfrP7qqkKgnZ8B9dznQ
X-ME-Proxy: <xmx:AtJ8amZeFbnGUt-tD7YsPUBoBaaBrY8_scdFG9f3fVtFSHekFyP_7Q>
    <xmx:AtJ8amiSBrAFyd1S4gbdwebheZyDpy88kJun14GRBYOsU03n5Mp9hA>
    <xmx:AtJ8av8fMgbABE7Iupz-wVYJZrA_nLP489B7ybCDjWJQ4hC52wOJqw>
    <xmx:AtJ8apoBZKNJ3CLxAhBlJ3PMOxBLyVznESp4qTEbhHG71eOy23mT5Q>
    <xmx:A9J8asaUmBbTisxMNM9L-_sPbOf9NSldVT8hUNacevmPqtuS1Pjlv5YP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 16:05:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Kristofer Karlsson <krka@spotify.com>,  Kristofer Karlsson via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v8 00/10] commit-reach: terminate merge-base walk when
 one side is exhausted
In-Reply-To: <CABPp-BHuh_8q6Hy2-Bk7H6Chdb4+eeW1f4LZU0szZ4zU9Eeo+w@mail.gmail.com>
	(Elijah Newren's message of "Wed, 12 Aug 2026 12:25:23 -0700")
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
	<CABPp-BENLi7kBBu9QsN87aQY5C0kamzsKpXZTKYcHZk+WX11ng@mail.gmail.com>
	<CAL71e4NMdOeL0Mwngpw9qn=sSctFEVMPiYEiWQ=LT+Ct-mP02Q@mail.gmail.com>
	<xmqqwltvw628.fsf@gitster.g>
	<CABPp-BHuh_8q6Hy2-Bk7H6Chdb4+eeW1f4LZU0szZ4zU9Eeo+w@mail.gmail.com>
Date: Wed, 12 Aug 2026 13:05:21 -0700
Message-ID: <xmqqbjb7w1dq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Wed, Aug 12, 2026 at 11:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Good.  We can declare victory and mark the topic for 'next' now?
>
> Yes, I believe it's ready now.

Thanks.

Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B681194C96
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140548; cv=none; b=sYCoh1bllcgcP2gM6VNh9GNeRacj9MBQMK7KEPMoTQUXz6AHJcHx2NWJaX7HyFtBmOfXY4XWo8Ca9D0IwrrPL4VM4SK+HC4ToEWsmBwJgdADccLCQo+Hxxos+lZSpcoSaA5WD0hOekiB3L8VNv04toiP6B4KDzhRcRtO1q6OebY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140548; c=relaxed/simple;
	bh=o8H4NOaeijjrz4ahDbb4BLLZ4+fiw1aneupl7SN0sdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KSHDtHPLb5K5LdevpD8NrTpJOHlfQc9dLIrboxnPk8HCfAqkc13qjO73oMCw7KsaN0WvnG2vL/t8l8Fppjf1yb4an1LMgTaHe1MPcOT8G7om6qzfRH+9pQfKLuobvaKl6CbNIxa9GBDFztXPu74uNAgyKAP1vdLKW1H5oqx8B2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KObRqPUM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BUsYiGjZ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KObRqPUM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BUsYiGjZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A990B1D00180;
	Tue,  3 Feb 2026 12:42:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 03 Feb 2026 12:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770140545; x=1770226945; bh=WtUrdm/uup
	EATV9Cd/kbPLcXNg1diy51bqr9va4PQXI=; b=KObRqPUMFTwY9hWlpeJqfsNKdM
	5vJgb2kKJALeBbJVtOrFNa82Aie4DgpCCKp6k0z8LVWCPGQSuK2mvul0oGQPqhXC
	GmceBxx+uP/pvMx0RG7xVT+D1UF+RQqaMuxQlbli6p7haH1G5U94x9woYzdIc6ta
	lx8w/156HYNtt1U4Sw5uIdDcXvao0VpBKeUN81QpJmEZHcNjXqYTNyZzl+CoLTz0
	ZoVYY1xrhnOVmyQhO3G+JpEoQqu1/4BoKKCFWfXD/saNemldYNtHoub9B72MtYAs
	FedATlmbuqzx+ikIGuZMM8GP3lumf2zVoOPTOyOwUfA8sbFVdlyxnGsoLPmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770140545; x=1770226945; bh=WtUrdm/uupEATV9Cd/kbPLcXNg1diy51bqr
	9va4PQXI=; b=BUsYiGjZQzSLZsFpo/0LRMckXGNbsBAJbUR2HXRP5aV1Qy8oroz
	OZOCgmRE/bH7q56wUdBSwT6FgutCRBsRvwmoCzFrUaEdtDwD5UJFt+Lw43Kq6d0L
	vUwnn3jyHtBhn5dSyHVLGsTqT+OEBClXHNih6xMRID2EKGB2KbCEoLAewbDfrFXA
	uDoEcMAWuqaUFaHNwS+j9SkDzViL3ENP9uhM3ea5bEGRYcWOYejhKIBwiq1iBTSA
	2f+2BZykbAgJrx5c6qjrzPuZOjNtfWV7pj8oQS8huKd691Drf/hG4gvrNt+4jO7a
	TtnU4+93Nq8ygTNrrE70v793ZvNSpKkc8Vw==
X-ME-Sender: <xms:gTOCaaB8FyDQJzFr-PXB-NyCwxmkdBw56Yu3eLv0AJRxByhdUsEHOw>
    <xme:gTOCaba2pIJz5uVjbJGSVTOumlQtCi7fssREsgd_-83g9EKHomSFs3NPTPakQiGbU
    l42GzXEAX6CUU_pKZsSwrC4lRj3bstYdjGEof4QsAbn-aUOmEkMSw>
X-ME-Received: <xmr:gTOCaV7iI4N2w951X0LBnbmbTKSIY2JOwENvsZqQ2WqUW5MRiKmgyMPXGIHJzIss7Pi0PLwEhw6wLAuAz7jHyPEvHFGLPiwU1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdevleejtdduueeljeeugfeitefhteeltdefgeelheelleelhefgfeetkeeu
    ueejnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohht
    tghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehguhhsthgvugestghouggvsggvrhhgrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gTOCaUYA8cubeN9pSUWjKX98XkCDzUWqa25UmnSNoobW-_CCpFYhIQ>
    <xmx:gTOCaci-eYWjF_UqlvoVXhyy2XT7zp9vOXxyRT4ox1XvUNaIcoC1Wg>
    <xmx:gTOCad9EmopMrIEkIOyIOwJDKY_ue-2-A3vghTz03IR4vr7TXUIy9w>
    <xmx:gTOCafr0XNMICw8viD0VMPLxQYdZx0PDAYkO_M4JtYymFSl9hgFHOQ>
    <xmx:gTOCaWxAywT9_0kpK9RYvVd65A7LT1R3zKSGlCEXw6uXPPW9ZtNWuf8J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 12:42:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Gusted
 <gusted@codeberg.org>
Subject: Re: [PATCH v3 0/4] Change git-last-modified(1) default behavior and
 add documentation
In-Reply-To: <CAOLa=ZQEU7kD6DEj446Wj19XUQP_1bOXYK1xsg5rbjnw7W3sDw@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 3 Feb 2026 04:58:10 -0500")
References: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
	<20260120-toon-last-modified-zzzz-v3-0-9bffd4968b0e@iotcl.com>
	<xmqqpl72u7vc.fsf@gitster.g>
	<CAOLa=ZQEU7kD6DEj446Wj19XUQP_1bOXYK1xsg5rbjnw7W3sDw@mail.gmail.com>
Date: Tue, 03 Feb 2026 09:42:23 -0800
Message-ID: <xmqq7bstu3k0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Toon Claes <toon@iotcl.com> writes:
>>
>>> Changes in v3:
>>> - Rejoined the two commits about `-z and the two about `--max-depth`
>>> - In the end, drop `struct last_modified::recursive`. This ensures
>>>   the effect of `--recursive` or `--max-depth` depends on whatever comes
>>>   last.
>>> - Added a commit to rename `<path>` to `<pathspec>` in the docs.
>>> - Link to v2: https://patch.msgid.link/20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com
>>
>> This round looked reasonable to me.  Shall we mark it for 'next'?
>>
>> Thanks.
>
> I also did a round of review and think it is indeed ready for 'next'.

;-)

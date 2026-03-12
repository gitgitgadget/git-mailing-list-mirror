Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4FF3750D2
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342442; cv=none; b=X2AO9TrHcIZKWq8SlKbfllsHbQSim1zPRGaxhMO6oFxrw0tpR8loadhu+Ie/5LOFncfi1LCLA+efRcC6iWJfabRODbAiNDfi8WO9B/LMl88O8Qb03h5fvWOJp1pvqd1GTyEgMNlpw71TM1tjQRjkqewdMNhJkWTqe7LZQaMGx2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342442; c=relaxed/simple;
	bh=8lOd+2stY6AiuOg/ilzgxsqotMIuB6fguC9p4WREUAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BIexVRCJk00XXHbCYZ4zUhA7c8KBai5ggOGPY3NS0bWzS9/62wZeXR2+eo+kzOGvUUeDuVc6gexHWJ5pHXd/TtByxGSY5HtiZKcTYt/j75tiwGFZTNfciWQIw10QRTTqEi80BdbRTmNakt0I3elvjCA75EjgX5bHvC20jzdYpxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hT/Oxl/l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k4IhRGIP; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hT/Oxl/l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4IhRGIP"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id EEE7EEC0536;
	Thu, 12 Mar 2026 15:07:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 12 Mar 2026 15:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773342440; x=1773428840; bh=8lOd+2stY6
	AiuOg/ilzgxsqotMIuB6fguC9p4WREUAI=; b=hT/Oxl/lxej72SA+KKS2jk4KXQ
	hP9Yo4yKcerKUkVvgP5eJDX2oElv+BgYIfsqalAP+ZHzLBg1y9eUCol36kLZVoNu
	9TaMKBXT4q0cojQYkyJmnuDfp4gZ47WUwY12EZOVDvNM7Qci1cCzSycmuLt+mTCH
	YCIdy9uveDVshE/4LQ7sZpCkAfRA6+U/awA6OSPNg2C4zCXPgxWhXonhM6VBcCdO
	jq+Yaub+2oaXX2ESWil7u5Ma3L9Objb2Vx91QxWJeEl2CSAco8D5Uc3Th/V0AYNP
	s9O7hvz+1/Vc3OLF7rBXnGM8EOePBzNPA+eQ9Ydunr9DE89JcpVdcB4VeY8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773342440; x=1773428840; bh=8lOd+2stY6AiuOg/ilzgxsqotMIuB6fguC9
	p4WREUAI=; b=k4IhRGIP+2CPMFcyCKdIBt8lnqHiOoOJNXVeRXHRba5xwJM90G2
	brtzmFCZXsZ1h8ajghIPQNYUE84NYsoKXNevzjVwpAtKJ5ywquUumDZiyyLVNmj8
	S7wPNY6QHzeSeSRWGV49DsUkbL01ETZB6MxGCrk11gbLgcJ+68fKsCSEsacmEB2q
	UIKGey9JPEUqpBRr/fLEFQYOATNj2P+tZ3/LbefwgtAtVeEJ9toqhwefEn2h89jJ
	lCqGCXMa00X1ujd53ZeLcGAHqig0s3cvh/v4vAWCdUYbu7G8bn9UOUTdetQfF06Z
	IusGvaadYwuprOMHlYSrtmDhfqC7nTF0GsA==
X-ME-Sender: <xms:6A6zaYxl4dzMZ2U7AxhBXjDEwDjz3nZhP9E7tSpGllWaJxhSoEvBbw>
    <xme:6A6zaegIEpFST5OY9vQfLClNWFp9e5kRseFTzhmdCtX5eyReVOIrmw-D41pKKoBoX
    Tru4JC_xzbrHJt6cZqdV1_y-gwPQH0YxeP3eIUgTncyggDtLuDk>
X-ME-Received: <xmr:6A6zackW0klFJOETAM44KKmngMXPLDwnLYQJjl4d82PpZW-yv-ZhuzGTC84vmKI__FmL_TaM5YUnkI9fz2KQxL8nrazqF_rbsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghrshhhshhrihhvrghsthgrvhgrtddtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6A6zaci35wwrNOxqwI5peyzvnvSV5D3zCIDkjD2O40SNalFhebk7qw>
    <xmx:6A6zaY3E29Gx0zpVlrtLxRopu6Jys3gBV49rJkjvKV97HU0Sq58D0w>
    <xmx:6A6zadK9cpdq2-sC5b_TNAs7twV0hW92h38RZ5EkcFUy8tUCRaZVsQ>
    <xmx:6A6zaQza1x9urX-TKD9_WVLUDh2oBtdTavP-xyBGbtyk4m0SCRKVlg>
    <xmx:6A6zaZUsVLLHLqnT_EP5XBMFB5N-7OPEMCvW7RFRVsDWcRtTJw2wDsGD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 15:07:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Arsh Srivastava <arshsrivastava00@gmail.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6] unpack-trees: suggesting 'git checkout -m' with its
 repercussions
In-Reply-To: <CAOAgETOd7-vPpBK+8rhE-i_vpqw48gDBdc3QPm3xWOR4w3c7jw@mail.gmail.com>
	(Arsh Srivastava's message of "Fri, 13 Mar 2026 00:33:51 +0530")
References: <pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
	<pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com>
	<xmqqms0dghgk.fsf@gitster.g>
	<CAOAgETN-UVtee5OjjcLE45sRxajCkgF3nipBqXpec4JjN8+vfw@mail.gmail.com>
	<xmqqwlzgev16.fsf@gitster.g>
	<CAOAgETOd7-vPpBK+8rhE-i_vpqw48gDBdc3QPm3xWOR4w3c7jw@mail.gmail.com>
Date: Thu, 12 Mar 2026 12:07:18 -0700
Message-ID: <xmqqsea4eujd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arsh Srivastava <arshsrivastava00@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> write:
>> I wonder where this came from, as it is quite unusual to have a rephrased summary of what you respond to.
>> Is this LLM-generated summary that was copied-and-pasted without much human brain effort?
>> What is more usual is to quote the message you are responding to.
>
> Actually as suspicious as it looks the mail was written by me only and
> I thought that each line was as important as other and
> I wanted to reply to each point you mentioned
> Sorry for shortening your response
> next time I will make sure that I will make quotations direct.

That wasn't what I meant, and you are still top-posting X-<.

Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E33D2C3250
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761103974; cv=none; b=uRdjGRftZNRnV7amlVjmr+KMLPsNG00ZjSUx7/CIFOoYHtJTqLpTVHLTFK1fYxUkHm5zQUYb1KivX4Cxa4XUEV0tFS6HNRtf3+5Qz3/xH1kNi+Ni1DXsoOxkp3vLdu/ot23JVB0nuRXsVnFhGWWtVh8EanWAPtFd5KYF4KXB2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761103974; c=relaxed/simple;
	bh=yd5zqx0hKGO8+HwbUlYVCEPkx+zkTBAoRRYAMpRoo2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pUQZ9YTkcqpgXA/qhzugHem80tORwl7qeKfsF5VOseJdoYKYqc/yg243nRdrbyLT/lwO/r3gfPdotZUoI4Xb2tmPDcqVoki7xSBBNlSfrE/b/1Vq5de/SSLP6pxEORLQkk/DUIoLB1XbISEsfRDgtAAl8D7N1T8hKMke3qXOdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YUBqQVDP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ChAyhhL1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YUBqQVDP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ChAyhhL1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4611CEC00BE;
	Tue, 21 Oct 2025 23:32:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 23:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761103971; x=1761190371; bh=959ZNMBVdi
	KpTMo9yU/Q4r+zKe2+5fqN0qlUPFqVCME=; b=YUBqQVDPzNFk46AEwXZ3dhyM7s
	/DSG9Nt7zA86lcMFb0ofrzBUAn48boNAA5OdyM9G9La9z8OQqDmJAHT45h95SbAT
	bInEU3Vyzhebzi0iahstuxna0TvNUc/XJdB+Nzc6c1Zg4q0SZUDsS+kaoVF+AExJ
	v9BZpQtmAdWKoiwsjzQxchnOpw+YmiB0P7xXRB02dxqL1I58p7/xAg/a0ZieI/DD
	c16UNDutG5tjb6dA+V4fWo8HPGDyLeCubeNz23Uvx9k4nprbs6MRB6NS30iXcQyy
	bE+ZGfV52JS0r2ysKmSxUt32gxOPofpafwmU7Cx+tEuFfenDQk1TY1mvJCjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761103971; x=1761190371; bh=959ZNMBVdiKpTMo9yU/Q4r+zKe2+5fqN0ql
	UPFqVCME=; b=ChAyhhL1PGkVwKyd/PaJ5dkmUov5trvKBnlzp5yBczj9ZQmCGs4
	RLUFSJBXyQPMOURxqsGZaowf0Fv0YtnEZDZbCbkfovGEG3s6e7tdwIQiUwmmfDN5
	WMjsrF/t/uces2RTmATDeNBCRDC1NfbSLZ52Nm1jTTTXYqFeE1Q3S7cjtsWyfkq1
	rhNqeFmUXPspV8VnviJhn7PCO5YjBTrZD59cPAbTer72z3c066Jdu85a9uLXSO7Y
	YawOqURucBcyC0Y4UnUUmjWW1MiMlbrGpR0tXXfNRldBwvlXDLsqEWOPr/yATyM/
	DIb5FYAssGrDnFuP8uhRvHJTQz6mty52YFA==
X-ME-Sender: <xms:Y1D4aP_Kn0VtbXWqzWrpoZ2fFDVozfpz9dB7sDoM21i6adOoZltV9g>
    <xme:Y1D4aHbBJO43yg_VkKYUHV_a1de0Y5XYO6Cy4RLSYMNb1vIL36MZqYB15KQ6fjM8H
    4Pq9Ak1wulFLvJ1I2LDILlYqLT7-dmshG_5t9syLyDGwA1JwfJDreY>
X-ME-Received: <xmr:Y1D4aJdks0g_dJpdxbTPpGD-MUeSTCcFGB4zUcOPyS7qtaUkGINhUEBydFCdTWfFIYjNwAE5aKkZJtC0Izg-tglk1musfuqDirce>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepmhgrrhhtihhnvhhonh
    iisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:Y1D4aElWEyot0JACDvy8oFrXUgFOjaxdQ_EMshiAuMRym1biR9KF-A>
    <xmx:Y1D4aJ3KD_ykpUER8_4r_lu1AzkpcIH_s6oXNn1H4WEbEBMBrpPnBA>
    <xmx:Y1D4aNe7PgUciaQD5Wv9wzQ2BK6EX6CU_uuaIMi3qM7SME8DMrlRZQ>
    <xmx:Y1D4aDY1H_eE6hdDs1C-jKdUzLR3bwSZJKhsfMrWBkf5DwGVa9s_fw>
    <xmx:Y1D4aNvmKxjD5BkfE3cOcwjxRuI1r3mzpussVrrKd7poEsOv4oyj5-Br>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 23:32:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Sergey Organov <sorganov@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?=
 AVILA <jn.avila@free.fr>,  Martin von Zweigbergk <martinvonz@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v4 05/12] builtin: add new "history" command
In-Reply-To: <CAOLa=ZQSc0jHv9gK5T06GA_mprknucwCj5H_M2djZ-UWfRMbJQ@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 14 Oct 2025 05:07:03 -0400")
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
	<20251001-b4-pks-history-builtin-v4-5-8e61ddb86317@pks.im>
	<CAOLa=ZQSc0jHv9gK5T06GA_mprknucwCj5H_M2djZ-UWfRMbJQ@mail.gmail.com>
Date: Tue, 21 Oct 2025 20:32:49 -0700
Message-ID: <xmqqldl31uhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> +	const char * const usage[] = {
>> +		N_("git history [<options>]"),
>> +		NULL,
>> +	};
>
> Nit: We have pointer alignment set to 'Right' in our styling guide and
> also mentioned in our 'Documentation/CodingGuidelines'
>
>    When declaring pointers, the star sides with the variable
>    name, i.e. "char *string", not "char* string" or
>    "char * string".  This makes it easier to understand code
>    like "char *string, c;".

But there is nothing specified for an asterisk that cannot side with
variable name, like the one we see above.  I _think_ the "space on
both sides" is the prevalent style, but I do not know (although I
suspect you do---as the person with most changes in it) what (y)our
clang format configuration wants to do.  Can you make sure the tool
suggests the style that matches the prevailing style?

Thanks.

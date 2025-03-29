Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B84C6E
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 00:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743208767; cv=none; b=K5++tYVGWMH2eA2MM2D5TRUjFLZMG9FKE9lrKdERT87mYSwvPnZbueSPDXGCEdSp+AlSnRjSgogArL1b36Y7JDK7QMyjYgiRHt7nP3ZbehgA39L9H/PTjvJM8En8MWMqjHGixNosVcN9xlMd4Ve/R1zY9tw5kBLA39ekfC07GJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743208767; c=relaxed/simple;
	bh=4j7n0UE3fl9RsbjZT8OoITpg2kZ4Ywxf4rRszKskucI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WXAMGYtOHbbOFLF4NRbJGKTY2LFwF5ugQPMJjCGLMrxB53Ksua3A0Luyk9WwtBPkMyOWurNCRkjt7UT2bPfIvfIYwv2coEpCKajsZ6RoPC1MgtbVRg2JdVwuYRiJGm47XHp2PLkJ7RkjeHo4Lt3CTMARR0pZ9VP219FDlWEG24U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=twQ/TafZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WmZKTlV7; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="twQ/TafZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WmZKTlV7"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 719FF1383820;
	Fri, 28 Mar 2025 20:39:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 28 Mar 2025 20:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743208764; x=1743295164; bh=9o2sWQnF7g
	kJsAqHPLUI6tH8SSNuSoyWME/kNI0vVx0=; b=twQ/TafZxaWDo6gFFrFXWQSnKp
	KYBV44KJ7mZ10dmOp3eGIjvhkP4TwhSlqYru9gFqNPZVLcUwO6wEHwCuKO29w6ea
	Ko20hTxDEnir7XOfSqilgJEnh+537NAOpCL535KkAtzD73/OJucZl1icapq7DhPg
	YB1dp1aYSgiXcCy61QvlsxMOwjbggEqdCm74xNET9ZjiTbKmdbfiOqWzAFdUkq3M
	/pEl+OT4HUlbXAzO+rBoPRW45kLSfJjX64O8kCqEraMdMEWo8C+64ra4KH8pJhf1
	03zIQFKwBZEXwWPlSr9UdR8sOPi8E58qP4phiGZTrctNs+mbjXE8IlbTozAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743208764; x=1743295164; bh=9o2sWQnF7gkJsAqHPLUI6tH8SSNuSoyWME/
	kNI0vVx0=; b=WmZKTlV7RSbsrJZmrjvwGaY0Yo6CMxoEmwz/NkeSG9Ctty9Flbe
	BmLV8QjuGz0jipdYEZnpUd3osHvJrarrkqbyP8p/n9bTuGh6Y2RVycccDrxi50XP
	y7cj1m+UPLSrRp/20KCfAjyS6bv4fDwup5gcAq3fnKj51pILvF+H6JYnKxk82LwE
	42LykSo54IO7ia5KuB6sLOCyCVbcNCifKLodkS5vDcbBlzA0tCY/ZCsXVjOXT6yD
	ww2a8066fN7M4kFvqp1cN4AGpy8kRCzJmQsE2ff7Z8VRNYgNhyculhc9hi27qavB
	WiJJLv4O9ov1zsad7K2ic4GV9IqSbBn1qxA==
X-ME-Sender: <xms:O0HnZ908s-i9_zNt0DBImgy8lWhDDA7hGbtclxqNpfGSCjXecTqBnA>
    <xme:O0HnZ0GUsSZD5RCFhFyKZ5eD-90Mioj1YlB2ZKnS-7-DZ6CgRV4e_Nny9QaBlnxCb
    BzyEI2CW9ilgnsUfQ>
X-ME-Received: <xmr:O0HnZ97dGgbwwWISuRNQ8VEflqbEUd5VVS7Zi2XlbTWjZ8IA3S5U_yUTYL9bwTkXLAWWOyeCt2LXtvwPm-MZGNrkrINC-hH3xcM-6QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehphhhilhhiphhorghklhgvhiesihgvvgdrvghmrghi
    lhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:O0HnZ61XUQ6PngqFuUlIjGq4wJAGaCDFg83yCHe2GttGiXAY5yz0Ww>
    <xmx:O0HnZwGHJ0PLEDKao0-4qaGAakrgvKlpajkKs8s4BXec2hjWzrcHTg>
    <xmx:O0HnZ7_98e6iIrn6gpBLcLli96M0DfCtcqZ5gyLh1EUQP-KnF9bVWw>
    <xmx:O0HnZ9k1tCddoTl28a-WMs6AocpeP6Xt1lEPrgBueu9n8JZDTGsXHg>
    <xmx:PEHnZ3deLeocb6KKZ1J6DEe-mivO14KK0RBvFGZ7oXK25bBQQLQAkf2H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 20:39:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Philip Oakley <philipoakley@iee.email>,  Patrick
 Steinhardt <ps@pks.im>,  Karthik Nayak <karthik.188@gmail.com>,  Jeff King
 <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Chris Torek <chris.torek@gmail.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 00/10] Avoid the comma operator
In-Reply-To: <504e63df-77d2-4cd0-bdcc-bd9949d34ce5@gmail.com> (Phillip Wood's
	message of "Thu, 27 Mar 2025 15:07:17 +0000")
References: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
	<pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
	<504e63df-77d2-4cd0-bdcc-bd9949d34ce5@gmail.com>
Date: Fri, 28 Mar 2025 17:39:22 -0700
Message-ID: <xmqqtt7chdqd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Johannes
>
> On 27/03/2025 11:52, Johannes Schindelin via GitGitGadget wrote:
>> Changes since v2:
>>   * Made the sed construct in detect-compiler portable (thanks, Eric
>>     Sunshine!)
>>   * The majority of the feedback disagreed with the more compact format in
>>     diff-delta.c, so I changed it to the long format (thanks, Phillip Wood!)
>>   * The more succinct and safer, but less readable, cast in the loop
>>     condition of the dowild() function was replaced with the goto-based
>>     alternative I had mentioned as a possibility in the commit message
>>     (thanks, Phillip Wood!)
>>   * I adjusted the style of my compat/regex/ patch to the surrounding code's.
>>   * The -Wcomma option is now used in Meson-based clang builds, too (thanks,
>>     Patrick Steinhardt!)
>
> The range-diff below looks good to me, thanks for making our code base
> clearer.
>
> Best Wishes
>
> Phillip

Yup, thanks Dscho, and all who gave valuable input to polish the
series.

Will queue.

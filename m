Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A792ECD26
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936048; cv=none; b=BBMLl2Y5N6N8VoSYwo1gWQztI86aoi6Sb1vFKhxHFDNB8OUAMin93Ydeg9c0hqo9bPQAs7CjHljG9CSq7OD1q5+RI30W9xDeEnO1igwMOxA91HYfROTfFjIPG/5hXk+eyEFGI2B03Eq5OBaEPiOVWejepY4hqdfhOVgRAbEv/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936048; c=relaxed/simple;
	bh=JZ6XrFeu5Qdj7CL4Hl/9wcRLLYqAbnY+wVGUKfBabkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XP7IJViU6w0v7Kuf3c6wPsWbAXJ1gAUL7OD03H3yIcx6jiiE40hmBVBF7rSTGp/nKVx/H07GDCUw/NAz0f9gfKi0qHfwmZlEOiH6PsnrOVpY6KdwYEkMu+sXJIk4UtJz2IL/FJ1qqcigDXBiqfy3tumNfJ2eyijWFmX5R0nn2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2P/BM0Nh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WW9uowIA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2P/BM0Nh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WW9uowIA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 817CBEC0074;
	Wed,  3 Sep 2025 17:47:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 03 Sep 2025 17:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756936045; x=1757022445; bh=4lH5eTb0AF
	Npa/20uBEcamLOW04UKEA1866ouCkiF80=; b=2P/BM0NhoJkKJvt/l19E9R66Pz
	r0obURW+g0M+O/dIp/IBTXN6OczMxoa40+NK0lo9hTYmE/6Aw9tUpecxOKJpdkSA
	xQsghxRorqoJwk7OTdB+Ua2ra4tmW2awa/oAnnBZRw1rYptUnBN7VgF++L6p7znb
	M4tK5bLLm0k6bWlrUkLD4OWKURyGsSv+oqivHGh7cJK1pfAjvVV8Ac4xH6KGRjK5
	cmNh2eYc+a9U+QWKA2YKkanf6WHLQ1VS8Yd5NWmd4XJkFWNdOAS497grc2R4wz7B
	QX0yMlZox2W1rd+qKDoZvemko9U1TOsS9jd4uFaaEziU9QseO01zl8quY0Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756936045; x=1757022445; bh=4lH5eTb0AFNpa/20uBEcamLOW04UKEA1866
	ouCkiF80=; b=WW9uowIAagxVn+IU7QpKeQhMWZS8ow9FOo8hldwGSBmIfaQxbFb
	QtLtMtTEh3ZAH5WfQg3HqPH3XR+ZClfQsxFEYn5q0XBPYjA0m3UTBxuR5EQbhMUY
	HJvkaL5uk42WfGJki16IdKsWAAqfUqYoNIC20dF9GjCfzNTEMkHVY/eDCQtWfmT+
	/OuK5azTXv5mOiXX6Be4oTNbCvjzjoFGV6nRli7S+nXWQ/ydUso8myJ27kXgjiri
	7BI+kq8xvXZT6fNWAq0RrMSUZmUn+/0ThZFfmKkdj3EF23eKqiuXzCGgrgzvABOY
	a/hz1cqrvgwvr9xJjpQ6EdTqef3FupMy4Sg==
X-ME-Sender: <xms:bbe4aHMAUCGLB91nDymwNy65aIe42eVSb4B8_zBO1CK_65wGu1xHHw>
    <xme:bbe4aMiQZaFzq3M06F3TGRcy3XFI7a-g7VDoCRKsm9kd7nMFum3bUSkAcQeQD-pjg
    Z-LRhmN5RnF7z6WlQ>
X-ME-Received: <xmr:bbe4aC1j0rn5KN6KqdaI9-kn0r8Z9VIM8Ir96E_umlWpfADUAsB36utcdMz5PoCZi5RltPLcHRaCxeIGf8HP6PZXtyRvppVAvkpr4PI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhrtghpthhtohepjhgvshhsvgesmhgsuhhkihdqmhhvuhhkihdr
    ohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bbe4aOjda0SE5fWejN0DaSBdOAuJ8MotUfShEiQgf45QBKl-KUjPog>
    <xmx:bbe4aKc5whvtuhOrqqOJ0FyI7hMvP45Fvl6eqYCuK5W1MC8vzbhisA>
    <xmx:bbe4aJmpXdG6L6YoeFiKk5g1TWRIoFxOyHTdna4FYFMumpGa7J364g>
    <xmx:bbe4aLuSeW3ReOFrkvjTbbpYcuZ52aGk33BjrhQB8vIYhepig5OkDg>
    <xmx:bbe4aDdrfywg93Ff_es9M8DfFegSzsS-LKCEn4s9t6NPO_24hwGpVcSk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 17:47:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Jesse Hathaway" <jesse@mbuki-mvuki.org>,  git@vger.kernel.org
Subject: Re: git whatchanged
In-Reply-To: <0219828e-4f7b-418d-9d5e-87c0b5fbd4d1@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 03 Sep 2025 22:43:44 +0200")
References: <CANSNSoWZNx3j3eLAayW64iC+bvC9XfetV+wZAkK6Zy8Zm0DWSw@mail.gmail.com>
	<xmqqwm6fe2d9.fsf@gitster.g>
	<0219828e-4f7b-418d-9d5e-87c0b5fbd4d1@app.fastmail.com>
Date: Wed, 03 Sep 2025 14:47:23 -0700
Message-ID: <xmqqa53bdx90.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Sep 3, 2025, at 21:56, Junio C Hamano wrote:a
>> The "raw" output spews meaningless hexadecimal strings.  Why not
>> learn to use a more meaningful option, now you are switching out of
>> the command that is going away anyway, perhaps like "--status",
>
> * --stat
>
> Probably.

Indeed.  Thanks for correcting me.  These days I use --compact-summary
instead myself, though ;-)

>
>> which lets you see the extent of damage to each path, for example?

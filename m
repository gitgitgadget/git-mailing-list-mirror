Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB2A2BEC2B
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899055; cv=none; b=BvuNalYbZ0kHNKHf6g/mY/CQzrhD59CWkd1cnQkVphnMcsaG1KTsVbJ1mGJ55TxTfskh6clXRmD4LhfaxPlQ1DXKmn4uoLQzl/ViC/LVQkvKmayQjDFPQahUlv8+kOpD/er9LE7p66ffLLpXpy+ScbXWGM1Kkw2iEdQHLyPE2YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899055; c=relaxed/simple;
	bh=qI0kcXoxKgQ8KS7W70NvxeAwVFH/6OzUz3TlxJyFUQY=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MS3QfOfccfZ0GRPP9D8aRE1DO30NoI2ar/3MQNrVSjbEHeKmS4yDvpRex5wbxaCYFUbWtm86Ha8O6vyEC2elKAnVe9+fJRDbp5BYHGOiicaOc36MOTamOCXYNlX/FN7y96dewhr9sRUG0CDH8P/7E69KIT1Q6FRezjH9JUe9XkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=N54SiytU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BrK0/06A; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="N54SiytU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BrK0/06A"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5FBA914000F5;
	Fri, 31 Oct 2025 04:24:12 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 31 Oct 2025 04:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761899052;
	 x=1761985452; bh=kRXfixYhd7pjnYnuegoqAwhuleHZe0OGAZHScMuTwJo=; b=
	N54SiytUEKHwSiSWkyefuqJAnCm7Sgc7Ex4nyNeiBggnJsN/Ape1qS1QN1hh4RW3
	1XI9CMO0dnXZIYxF13W7Q/I1SczZcC5EgLyLzlaQH3C4koRKd0HUZBkczUjoxVHb
	OnxjVEfaIfRa45c6C2UwfQ510lGT0gKHgISaSTfodge0yzxci1xak6dOAF4hJgWL
	E9VJ2VKlQjcZ+nLEkn0cyORZQvU8EY3Z8ySJB6W5sVKAO/V2i1l4Qafjcrb8+MUf
	z+XoQMauQhHqOchRKyR1bq+pNGmC943gcv1jLoQx91uFn82lf80rp9Nd54lvTO7I
	j67778yIEp91JmcovCfYgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761899052; x=1761985452; bh=k
	RXfixYhd7pjnYnuegoqAwhuleHZe0OGAZHScMuTwJo=; b=BrK0/06AmS3168iel
	sif0QyvuWaSdvgucTbqN2HiIKHaIQka2Ed7isAGwMUhR5a3rV31T+4I/YbFi43yu
	BMWYzky2r6Eo0xeFXaxmfw528g+l2yRmTHltvIfSJu5+1tgWFOLO/gvjNLL0vX5p
	1EgfeANiUERiqNJ+mK9l/nIswSv3N/m2TqZNHJRqIh5Fn1Y4cZp2hsgJWl8GnayP
	aR8RJWJ6A/lthXFMKNAsnWSdj9DKA+zIIkdplypnSYYBQXVn9rGhDFJ+8VlJd6K0
	23dQkZbTu6NJaYhpBIdEaCVKVKOIjMj9efheyDsAkXsxRzuBuw0FeBdrqSNGaYK0
	A9O7Q==
X-ME-Sender: <xms:LHIEafdFqx2fIcIohq0tfZ7xAzFMdgeA_qVjstyXYDCR-et2zu5DJrU>
    <xme:LHIEaQCICxATMOS6_LJvJ_jtcz2UtZoAULxBnvVsutm4sd50AGgRsHdQcSNUGfBQC
    npxc6hNm4eW2_-uz_vZW6M9LjeR5KbQPG_mdZx2V-uHqLuCDlSNHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeltddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprhdrshgthhhuuhhrmhgrnhhssehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LHIEaeIYPy6N7VFqllJ70zVtjiDNKQHFxbgEK7m_dwWVV7Day-5HxQ>
    <xmx:LHIEaUHtanWuj6uyiC3IRAPlinkuUXRZ_pE25pc5sriJWhnzqc4vrA>
    <xmx:LHIEaWToYQ_6CYkUlDVT_hdR8Q_cEn-JTSCcQmQhbzheYMpkNclbaA>
    <xmx:LHIEaQG2QRUtodDW887TCBAoDL3GI3okB9alu9HDYnWLFHapSc9gig>
    <xmx:LHIEaUxIm8XKMK6DD5gRe678Wav82-qM3fqHfSPRmnUxosTUMxlKQFcY>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 25A401EA0062; Fri, 31 Oct 2025 04:24:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-58HFYM_TrJ
Date: Fri, 31 Oct 2025 09:23:51 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Remke Schuurmans" <r.schuurmans@gmail.com>, git@vger.kernel.org
Message-Id: <57ab19e2-9cc0-45bf-a3fe-c268c540a672@app.fastmail.com>
In-Reply-To: 
 <CALnivwfp+WTN3VKY1LQ+04OX0nwPSfKx4zyZDsCDeXg8ubEPqg@mail.gmail.com>
References: 
 <CALnivwfp+WTN3VKY1LQ+04OX0nwPSfKx4zyZDsCDeXg8ubEPqg@mail.gmail.com>
Subject: Re: git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025, at 09:02, Remke Schuurmans wrote:
> 'git whatchanged' is nominated for removal.
> If you still use this command, please add an extra
> option, '--i-still-use-this', on the command line
> and let us know you still use it by sending an e-mail
> to <git@vger.kernel.org>.  Thanks.
> fatal: refusing to run without --i-still-use-thi
>
> ;) I still use this one.

This command is being removed because it was supplanted by git-log(1) a
long while ago. Both commands use the same machinery, just with
different defaults.

You can replace it with `git log` in this way:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more
use for `--stat` or `--name-only` rather than `--raw` if you are only
reading the output (not feeding the output to another program).

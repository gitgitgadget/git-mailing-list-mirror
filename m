Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210A1DDC3F
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368538; cv=none; b=aejTqFXoW5TmzvUc4lWn42VWQ5NjcPBIC7BoMSWRGF4nmS3QdkbKSHWlu2PfFidVe8JyszyDgxVWqC7j9a8HmjnwuwYboR+lWet5G7b6ERlMOS6da+rwXEZTN9nyVfHcuc6k8fGxrTzEk/rr/CCFHDFOrUwOJm8/8P1SMqTRq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368538; c=relaxed/simple;
	bh=5OJ6QVl41v9oOdEQyvLYFDo+4QelLWu7+dkTY2gvH+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LKdZTgoE8IhYT1wdqHod0dlfBCH6uLSbK9LglYl4DpDB8HUh3w1vaCsNuKffe1kXo9ipKD4WnKN/UjH8hOokCIqJ+I0oIUvt0mVB7PDO3Ng75lJr0OTplQkmqeLg/P11TYuiTnUDdkkuW1JfMICm9MiFMfB+3NBhY3R1SYZWIZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mIjK8V+A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EyeCYIJl; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mIjK8V+A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EyeCYIJl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DAC701D000B9;
	Mon,  8 Sep 2025 17:55:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 08 Sep 2025 17:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757368534; x=1757454934; bh=ufc77C7SLW
	Rrj+ZNIDmK8wQic0/OasUoPdbwVf96g8k=; b=mIjK8V+AOcxQscz40gMp3Ro442
	3ArCQjmzfDZaFHLFZ64eWhB26K6krEQq03i8UNoCWgpOr2jvAMFRMb0CwGWMc23U
	zg9w/Wv9dB8t3Ip7B1KRCIub9VdEPkFdmtNWbq1Dp/bxfjFBwLiCOH82ht6XbTPX
	+ULgiGBBVNA+HBubVS5ULqqHndjUQu0PnYEjZLn6DEtMSctHPlzqoeSD/MBkvPGH
	sgvXpKN4U7oMIXExiVGAWg4v435rTS6U4VaH3l7/x3DX2M1qLbIS4p1NEiN0STFF
	SqkIZ03NdzykL8rdFya99runLGBO/+GvnM8otUplW1nUe5nVKBOFWibtAR+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757368534; x=1757454934; bh=ufc77C7SLWRrj+ZNIDmK8wQic0/OasUoPdb
	wVf96g8k=; b=EyeCYIJlBtKLh9jyYUf9U+n7qemuarDJt6ijkoNovBPUfMvWxvJ
	nKrp3bzdyFTL4uM32Z/5P3udqQAvdzFCXyVCanbq8tEjVIN5BscCkrVZbMhy+NPN
	YfzGSRoBqPrGaTZoboGIrRlemxRHhAjFZvQo2QNQRrS679Yd+/fohnkOzBP4kP/M
	8vwxuRHsb5o5wc2rvByn1rpgmbIHKUzyfFaDh5TyWOZkvHCHP7bql9gCvztPsqr6
	kxgwRVqS2+bhG/+1NlA3Jwe8J0qtca+ywDtFbPwQTKfLgEg+aY5gT2JIVeEWc7FC
	KAf/6CuYaHtmU59Nqr1okDHvYE2lE7QybmQ==
X-ME-Sender: <xms:1lC_aA64IoWjdxu3aqR1tpr1anQ6rBZOS7A6KXwetciqcU6wSijA1Q>
    <xme:1lC_aKVM0PpgMzE58iV2wGSMpIKBtBAqYhOMieNIYnYQdu0pfHzj-739g6SYglUTH
    YpyII74eg09xM1mCw>
X-ME-Received: <xmr:1lC_aP5PlpHO6sOQmTZxhCw0spfXGFrQFi3pYXHRlRxKEiRhdO16Z242gQQeIMLp2EBxURipJWy3eqvU-ErcgnKGYKkoydTjZfgoK9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:1lC_aFoSfHF0WNEE1hcJ-6ux_u9-JxAdSPZNoXUdkbF_9RrMeafhTg>
    <xmx:1lC_aCnLeFDKBhxYOGSMajRDYdIQiTwBMtRt_N8exG9oEVt1nFrzTg>
    <xmx:1lC_aBPNya8SupY2Eta9Z8g34jZp7iIggUcVZ3-2gsb6IdK3A7qsNA>
    <xmx:1lC_aGNnfa2rogapkEBANye5NKLYRx-ZLp8zs1PyTuTXSkNXXjWL2g>
    <xmx:1lC_aBRVwJvFWstXbDzrYKIqbDKnB5BmEeQNeqNL3DbLZrnvVMtGnaRy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 17:55:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/8] git: allow alias-shadowing deprecated builtins
In-Reply-To: <20250908211141.GB1327610@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 8 Sep 2025 17:11:41 -0400")
References: <cover.1756480827.git.code@khaugsbakk.name>
	<cover.1757345711.git.code@khaugsbakk.name>
	<eec01cbac16596c5e117843ae86956e1f66ec097.1757345711.git.code@khaugsbakk.name>
	<xmqqcy80wu0y.fsf@gitster.g>
	<20250908211141.GB1327610@coredump.intra.peff.net>
Date: Mon, 08 Sep 2025 14:55:32 -0700
Message-ID: <xmqq348wwqwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> cmd_struct were not the right spots. OTOH, it would probably not be that
> hard to just do:
>
>   static int is_deprecated_command(const char *cmd)
>   {
> 	struct cmd_struct *builtin = get_builtin(cmd);
> 	return builtin && (builtin->flags & DEPRECATED);
>
>   }

That was exactly what I had in mind.

Thanks.

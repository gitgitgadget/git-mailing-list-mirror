Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C54F846A
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773277364; cv=none; b=uHJag1mBxWZAD4BuoMGtzb0Wfb3B3vMikIMPdcdJxtHoV2agTO/D6ifrBfukb2ARWH3hUAUGdnQ21z8eAYILzLaSaLbpTfndM96Dr9CHl1Rqxfe8FMR68Xc7jEJ14LGJSnM66XPLvSTwjBpXxy9yuchoS3GCmtle8sWKcJxwZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773277364; c=relaxed/simple;
	bh=D6L6hSC1N5sXEIEbdDGNJnsJn5PIMNtzNnVvrQ2JMIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F5BEn/FHyu6v4vN4Wk5TQcyx44TKsKmZLLJh+LVz8uPMFC7cBbbsz7U2SkyWPUfwunoN+cVhOue7Gw+TS8SadVNgn60NTUtHi/LnlwiWfw6ymbuEopm1cYSXZpvNWgp4/kqx3bHgIExSr8o7+U2AnS3X+FiRb62PRy+SJrDWPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XByFlVhe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VIKL9CDA; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XByFlVhe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VIKL9CDA"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A8C71D000CA;
	Wed, 11 Mar 2026 21:02:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 11 Mar 2026 21:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773277362; x=1773363762; bh=jnmyalkn/M
	qehfDuPuU3Q3D3u310duXCakezdc/lb38=; b=XByFlVheVN7/fGZUW33bJOkqog
	KaBobcqjTfmhjFjmf8US0eKT1kQ1i23SVyb9ZNSmgPw6XrCnE3bb2j/Ki3TLz/wJ
	5SFRC22rZ6Xa/U9W2QZclWykuBQfDWIo6OIgko93Fe4N4AtQ+zjneQyLhq5NMtpk
	xeiofv6XSFnpD6oFjsuW4RmSEBkAxpXiiuHa0HSpyz/kDWuCtyw2oPSFFIqUUp+z
	aLxeW9Ge8anZu+xgIuugYbgfR1/XfHW0ehhRQg2fHsXXGAOY/W2YAGaQgpqbs7Nc
	OiepAqjPzo14nnLXIjtF+/fFH7QCNMbK/9URvteYTJ7H7IfQIpy8OAayaUIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773277362; x=1773363762; bh=jnmyalkn/MqehfDuPuU3Q3D3u310duXCake
	zdc/lb38=; b=VIKL9CDAj56I4nZfg33yDhhnup/wEa1pLwZBnCXzwpoCyyIjJ/Z
	YuGbTtQPjwUIv9k+Gib4OUoreQUd2zm0xnFy6NfrkplCa7O5ZZPo0Smu1Qg8Y78J
	5Pu4FzhRjeQ7R5/cVCo6OjJYL+BrT5HHkY+KE2NdAlXKUeAvZ4ptjL6BLhXNgjWt
	0MEja8epg+xok+M+Igi2GTdwlnkAeOWtV5I5v5WzIycYZuGFsQXQUaAaCOqtnS3i
	CldLLJp76JBkhheM8yoLjc+cB+2EdoMW3W7cxzo7pWxFh23VDRZznvVgoZnb5jEb
	Dtgvfd53ngpxrRbHoHkvTppLLa1T8ssTybw==
X-ME-Sender: <xms:shCyafVUoEV2p8uDxVBhghnax4gI8Tl4PK9E4UuzY3sWhXoVx5AftA>
    <xme:shCyaZ1OQnixIWVbiFX4XqsdRClUd8c5MmEaj6J58tNBXJio11aurG7InzxJLrh7A
    _lBzVu6_MCeSoRQyuyyxwUQBKIdxyDneTu1MRaCJqfvH102VyczAg>
X-ME-Received: <xmr:shCyadpi3FCulE0XHSxeo5P45iNakzlF3-kc5vcznrE4RZ94z5qj44T_LUjm_7puVqPyU5_DY1sc1WNh79p2jrU79d-x1b6DVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprg
    hrshhhshhrihhvrghsthgrvhgrtddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:shCyaQVhTSqxEzp3RHUPQVVDaLltVgGL-wH2vRz8mE3aMDSOSfv_qA>
    <xmx:shCyaYahbZZN_1tRUxCG84B1ZZ6LIu8aOXzpIzSgiVfFXU9OYALUWg>
    <xmx:shCyadeJofni-FZxdpQg0sOGTaG8CXmgqiZ5uC3i7MJG5R3yav8e8Q>
    <xmx:shCyaS02rWPuG7qNbt0_2QfviIK56tVuR_jCy2wWjojEim71EDxlhg>
    <xmx:shCyadpQU93DYrZR4FLYxKZSNepGqBmGMuE9dg8SyRH6_H3KMtHR151L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 21:02:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Arsh
 Srivastava <arshsrivastava00@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 0/3] Advice on checkout dirty files
In-Reply-To: <pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com> (Arsh
	Srivastava via GitGitGadget's message of "Wed, 11 Mar 2026 17:49:26
	+0000")
References: <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
	<pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
Date: Wed, 11 Mar 2026 18:02:40 -0700
Message-ID: <xmqqjyvhkggf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes:
>
>> advice.h: add ADVICE_STASH_BEFORE_CHECKOUT enum value advice.c: add
>> "stashBeforeCheckout" to advice_setting[] and implement
>> advise_on_checkout_dirty_files() function
>> Documentation/config/advice.adoc: document the new advice key
>
> Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com
>
> Arsh Srivastava (3):
>   advice: add stashBeforeCheckout advice for dirty branch switches
>   advice: add stashBeforeCheckout advice for dirty branch switches
>     [GSOC]
>   unpack-trees: suggesting 'git checkout -m <branch>' with its
>     repercussions

I still see that [PATCH 3/3] literally removes what was added by
earlier patches.  ADVICE_STASH_BEFORE_CHECKOUT is added to
advice.[ch] and stashBeforeCheckOut is added to
Documentation/config/adivce.adoc in [1/3], and then they are removed
in [3/3].  If your final solution does not involve such an advice,
then do not even add it in an earlier patch, only to retract it and
replace it with something else in a later patch.  If the reason why
that "something else" replaces the advice is because it is a better
solution to the problem you initially started to solve than the
advice message added in [1/3], then just go straight to that
"something else", without adding and removing the advice mechanism.

That is what "perfect logical progression without detours, change of
plans, and fixes earlier mistake" is about.

In other words, please do not throw a drunken-man's-walk series at
us.  Pretend to be a perfect developer.

The final series accepted by the project will have to stay in our
history for later developers to see in "git log" output to learn
from, and a series being clean logical progression is a must for
that to happen.


Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1E1F78E1
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737492720; cv=none; b=diqgfLE6YraI/2+SqWNBOpnhOseNg862jcqHtEDlFeXUC6Avq4vZh5aPpYpAP5F++0JDRsnRqSL3Ddic+ofMrc9dJtz9HufsKiRp1xOo7Do8528OQMVdzIs97lA3zgCVp8ipkqqChvDm5MBlzqb/jgj/mpUZ5D2JoSQT511+/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737492720; c=relaxed/simple;
	bh=4FwFfkCw8mew3NUGCatmxoPjj7A+d+DZYaVGkNQEb+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HguPrOvKGzoRQY4/MasVxNvr8kQ+OpHVAVFda9dvhYgA5jFzsnMQhgPMn8z0YqQtU89o1C7fQC86gnnekx2idfnELnqsJ0X3qz6si08YSRP9clG0cj//SUQeAF6dmBarYwZ63L2+YmnAY5RWuoyn0l5t73ClZwmNlNhVe7A2kow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hctJlozO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R6LDjIS6; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hctJlozO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R6LDjIS6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A3032114015F;
	Tue, 21 Jan 2025 15:51:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 21 Jan 2025 15:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737492717;
	 x=1737579117; bh=FV3sQJ0RMZ94JpzgklzXqEOuFA3AcmJcruY1RgAy7tw=; b=
	hctJlozOeIKq2HfOXz2oxUxT7WZ9fMiH90Sq27VCJWwkoU0WWvRI1jPZQQrBBJE8
	cQlBxwpjJdBI/cua/6tB2hNyH/SYqRUDm4691Xvuvlm7VOrGX1i3Wm2abDWhIS92
	X7jfu25UoxxzWykTn4tLsLxExzc9ps6eLnBMZQSf203ImdKOHrTE0g2G+ppw0c4+
	ol1HT0E+mzy17/zOd4eS8we1g5MdGPDyDMxKovAqmIL/pKeQC2Pm5ZmjN/b8q2fp
	cMP19Dy+MpOQc0HJXLx6q06QsED3zoyngeWauPRHF4ommS/6YEp9vjqYdFgHp87F
	3U+ou9ENJ8zFEpttUV5FAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737492717; x=
	1737579117; bh=FV3sQJ0RMZ94JpzgklzXqEOuFA3AcmJcruY1RgAy7tw=; b=R
	6LDjIS6IaxYuGWzWTyVj5Vi89U17m+7fbk4Rfn84ZFZzrRQK5jcf28KvS4jXhhwQ
	2TvndRhZKD10nQHBohKIvT6cmIQLP5uOSpJ55jNaGbBYbFVr0/cJsXtlKqCUWsy9
	RPY6v4CTK7JFwkEhCKG86QigKzi1Gvd76v0FGiMq0dQAz6ZVtGY+juosQqxkajyz
	VTDNXRfqJPBRmgJ6lm1w55XNSzObL4IxmJOgSqTFKYviFjH6VqTAEyAwAsKx6XsD
	nN4F6A4zaHpFkC/UPLx8Wh5vhG9JvaHd98TPB0FpbdcY9/BVmVjCoQ0Pkv4dBP89
	XMNQTuv5Y2zH/edxU6s9Q==
X-ME-Sender: <xms:7QiQZ0IgPYoE3g2wQ048jpznOMYrOUEeMDLzSWmBc1OJIScYdyLGwg>
    <xme:7QiQZ0Ik0AfvtaZhoX17CGhS6FNqrpR3n1ZMIDlnjlHrDYoObEf0brLwXTlJKinN0
    kfS2ftxkMuJu01nkQ>
X-ME-Received: <xmr:7QiQZ0sUa_Sy0L0e75q8Jyvp7mNrLw6pqUwD-HDTewhRrOo_a6lWUDsqoIQWXNT1UVtpEsZQDIAkxOKDUN2QiBryuVoOQ0Xci9LK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnoh
    gslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7QiQZxZy2kmCRBWahCxZKhcIVBeSkrQj9kHG_SpXzMfhgnblTGvA9w>
    <xmx:7QiQZ7YbDjGylFzZmQ7Boasv7m038P_R-6Ov5oQaMnwIbhhJIb3jVQ>
    <xmx:7QiQZ9DslXCpTs_FAB2caMkzF0CZ1z84FLL10No-T-gRZdUQcVugfw>
    <xmx:7QiQZxZG9sTpmPulEAioE6GecKTXf_QYj9cdis-iTlGd7lpZsO3-hA>
    <xmx:7QiQZ2wn6V27-jVupJiuoFYtwDTzDZ6PvTYw2lQ-CQlcZ13oOdIsBe-C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 15:51:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] grep: document negated line-number, column long options
In-Reply-To: <CALnO6CBUbmZaL1NuG2RxrvuxbUexKdtKfgYi2jTDY3QEa9NQkA@mail.gmail.com>
	(D. Ben Knoble's message of "Sun, 19 Jan 2025 18:17:03 -0500")
References: <pull.1878.git.git.1737066042014.gitgitgadget@gmail.com>
	<xmqqy0zanzdw.fsf@gitster.g>
	<CALnO6CBUbmZaL1NuG2RxrvuxbUexKdtKfgYi2jTDY3QEa9NQkA@mail.gmail.com>
Date: Tue, 21 Jan 2025 12:51:55 -0800
Message-ID: <xmqqjzanzy8k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

>> $ git grep -e '^--\[no-\]' Documentation/
>>
>> An example entry (this is from blame-options.txt) looks like this.
>>
>>     --[no-]progress::
>>             Progress status is reported on the standard error stream
>>             by default when it is attached to a terminal. This flag
>>             enables progress reporting even if not attached to a
>>             terminal. Can't use `--progress` together with `--porcelain`
>>             or `--incremental`.
>
> Fair enough; I dislike the `[no-]` formatting because it is harder to
> build into a search pattern (I have Vim keybindings to search manuals
> for long and short options that it breaks), but I will probably live
> with it and adjust my search patterns rather than complain further.

$ git grep -e '^[`]*--\[no-\]' -e '^[`]*--no-' Documentation/

tells us that we also can write the above more like so:

	--progress::
	--no-progress::
		Progress status is reported ...

which may make it more palatable?  I didn't count and sift the hits
into two bin to see which style is more prevalent, but it may not be
a bad idea to consider unifying into one style.

> Sounds like you would prefer a re-roll that does something similar for
> `--[no-]line-number` and `--[no-]column`? I suppose I have to
> wonder—for which Boolean options is it worth doing so?

Ones that are not marked with OPT_NONEG all take --no- variant, and
while going through the list of options we may realize some of them
should *not* take negated forms.  They all commonly share that
"giving --no-opt countermands an earlier --opt or the corresponding
configuration variable setting", and any "--opt" that has its own
corresponding configuration variable should already have the variable
documented in the paragraph, the body text may not have to be updated
at all in the best case (in other words, the only change required may
be to add lines of "--no-foo::" form next to existing "--foo::".

Thanks.


Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13027FB38
	for <git@vger.kernel.org>; Tue, 27 May 2025 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366322; cv=none; b=UVxjXyCXpr6S/AdKFw+UGkX0K6/S3dxd/M/4oNQC2jt5G2GKuBz2+a9u7pnXGIMVBmuQZNkc2eNy49cCEs3j2/3p0fPmaF9EoUvN7TPhN0xSyFTFS6FZeXsH0tEcn//nmKg7bNV36DK3hcK6TIRb7gJlJiBrR5+XXfJB+R2eRs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366322; c=relaxed/simple;
	bh=1PUEeThKkx4IKl3QswTCw+L/h7E+fOuNsAZK1VTc4zM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C8JhSvQGjJAhNXODTQc9OWZNSyeutkF7pzaA2ELQ7V+0qkYFPj3m0LS5HpIJn1Kdi0aZ1AXGuiugt7lzICc8W/hOZIawHHKPMIe97QlBGDtI0NJGtyy051NE+elBwFJtqvX1vD0bG4fPpVTorRTrJugcYx7XVKCUA842Vs4kcI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OBmVvbuj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDTCNXeW; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OBmVvbuj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDTCNXeW"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B693F11400F6;
	Tue, 27 May 2025 13:18:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 27 May 2025 13:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748366317; x=1748452717; bh=b4cGvRoCH2
	M0l9ukf7PNMwpuTUukwOFb86yrojiOsDU=; b=OBmVvbujVcH+dmSEMAPsvlc1KG
	8rYVn1NsH6rVf2tP8ApFAah8T769O6eRPWi5bt/u+otLuSa8lcPg7MpdM0ONc7O5
	9DsP2rE/DTLELE6XTCurgwAki7VYadusPNsKQFgADWTOgIGhLnLQVo2fGtaAkFLi
	c1pBNR5BcmfYrV5Qs32QnIB909kXFiMEEz9X8UnI9/ft3h7G/6j+tPD5zCg+gZCJ
	Yoa+U1Q25pdMGmiDts/ofVtBbvjlT5WgsyMClSGp1e0nNOGjMvzxuiXhNODxzCfo
	iYnxmht2Yo2DykkIGyIzmk6RSBjS7uA2E9eJZOOdSzbUbxtrnYUwpDrpzKRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748366317; x=1748452717; bh=b4cGvRoCH2M0l9ukf7PNMwpuTUukwOFb86y
	rojiOsDU=; b=QDTCNXeWQIJ05jLiVx1Z2TeUNRVAUpQ4qEw1NBgJM8NqgSW+ZI3
	O7tQmLcqc+Cmpn3wvJC89Rbo+5Vl8hxOa2Jh75uvhScDEjPuzn7+nokJHTvTlgkC
	6epJIqyvzJidePauQkHdtVKIo8A2xJz/yNrdzD5bmWNcztZ9alQpzWyEIFQi6xZE
	GgEbvHNIOb1dYmlMuTAZOMvPNf4naic2DUpKGjuVL9Oz/FJl8y8kRK75SB4SUg0p
	pO8ajLFvEGUpATLhQlYZGabjnSNOLrAA2jnkvngv0ogKpI0VXytSN75XU9LePuDn
	CMMlyyHaSPxmZYxcRTkMl7z9e9eJLmk1lZw==
X-ME-Sender: <xms:7PM1aFLCE1M5vPAlnEJvlJtt7lhkqX4vuMG2cUeXlyhW3Si7uA8C7Q>
    <xme:7PM1aBKFjadR-53OUuRqgLrwYSjXfka92N9z1GjFxpacfX5VOF3ytsBQ2el6LZhLp
    9G2c9FrB2b5Xr3t0w>
X-ME-Received: <xmr:7PM1aNssyLzUgMs8DnzmYZ58HdtynLRL2jPwKfKEi-RHOPC9q-fP_KSAb_Gmgp_pXu5FBVgrFOUZZDHDpwBobKj1kiYiFgzKSPr7jXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdelieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7PM1aGZHT8L4A6SD-AUkoy4K_DC2NhwPqtIX-qRd0O4owP8BXFWWRA>
    <xmx:7PM1aMbOMniErcKy_joYjL1zTrYyw6ktY-g9fLWhvfMBdb0QIT7BEA>
    <xmx:7PM1aKCK1qaDhDUq3OsDm0a2Xn-7u-m3gXhg_oq2ThgceA-tn2yfeg>
    <xmx:7PM1aKZXAsjaAEyagrcc3CMqjfOsRPqxQMs4DRSCX6InjjEcxeCHhg>
    <xmx:7fM1aK6vXMJBVlTpRfBHNY0iaFG_MgwimMWmtsuQFLH-C12B2ieXLn7R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 13:18:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
In-Reply-To: <66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com> (Phillip Wood's
	message of "Mon, 26 May 2025 15:01:04 +0100")
References: <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
	<66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com>
Date: Tue, 27 May 2025 10:18:34 -0700
Message-ID: <xmqq5xhmvuol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Kristoffer
>
> On 24/05/2025 22:35, kristofferhaugsbakk@fastmail.com wrote:
>> diff --git a/builtin/notes.c b/builtin/notes.c
>> index a3f433ca4c0..ca4782eca19 100644
>> --- a/builtin/notes.c
>> +++ b/builtin/notes.c
>> @@ -180,6 +180,8 @@ static void write_commented_object(int fd, const struct object_id *object)
>>   	if (strbuf_read(&buf, show.out, 0) < 0)
>>   		die_errno(_("could not read 'show' output"));
>>   	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_str);
>> +	/* strip trailing whitespace introduced by blank lines */
>> +	strbuf_stripspace(&cbuf, NULL);
>
> It doesn't make any difference at the moment but I'd be happier if we
> stripped the trailing space from the commit message before commenting
> it out.

Yes.  I had the same thought.  If Kristof does not like the fact
that one automated source of information consistently indents its
output lines, even an empty one, and if users may have legitimate
reason to place in the final output a trailing whitespace in the
comment, it is better for the patch not to close the door to the
others.

In this case I am not all that sympathetic to the idea of the patch.
The consistently indented lines makes it more clear from which line
to which line came from a commit log message; running stripspace
would break them into paragraph pieces.  These editors that complain
probaly can be fixed?

Alternatively, if it bothers users of certain editing environments
too much, perhaps the indent code in the output phase of "git show"
should lose the indents for empty lines uniformly, shoudln't it?  It
probably should be a fairly isolated change, like the way how the
expand_tabs_in_log bit is handled in pretty.c; give another bit and
teach pp_handle_indent to return when that bit is set and the
payload it was asked to show with indentation is empty, or something
like that.

> Should that be " \$"? What you've got seems to work with dash but I'm
> not sure if it is POSIX compliant or not.

"2.6 Word Expansions" ends with this sentence:

    If a '$' that is neither within single-quotes nor escaped by a
    <backslash> is immediately followed by a <space>, <tab>, or a
    <newline>, or is not followed by any character, the '$' shall be
    treated as a literal character.

Taken together with "2.2.3 Double-Quotes", I'd read it as blessing a
lone '$' at the end of double-quoted string as a literal dollar sign.

Thanks.

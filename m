Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08930C616
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906906; cv=none; b=Y6KsvvEeDka1EbguqaNlrwKC9S7MKDVfSZpnfWphWbJosTr1KdbewdaRGyQIxcfJlu/SHXLBFjTaR2yoXXFEA8vmM7b1TtN0RpMyh50BgAcHWgNujieW+CIF/OqLb2iyFOsHA/tT5wFidpCbZIsLK5pdAPMnqKcNf5d6tf4Yvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906906; c=relaxed/simple;
	bh=Xv3jnB8dXwYkb2biwtUNwttH+nOU7uh5AmIJO+sKT60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j476d5fAi7xGtuagvJ0w/Y2yPVjASB2ZyZdlehT2UlcXkOaIAkfzhGrWv60vHTiGHyfMTHh7rWhaR1utA8RnTIABpn8d52rGnQ3IrlZ0fY+6V77vOQ2Zqv1EZcKmVsTc1IPMLFwAVzsagV0qf4fdavcAvE4jnc2Vj+WwcMskYWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cIj5r7WJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CBWLxvAT; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cIj5r7WJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CBWLxvAT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 644C11D00036;
	Fri, 26 Sep 2025 13:15:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 26 Sep 2025 13:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758906903; x=1758993303; bh=Xv3jnB8dXw
	Ykb2biwtUNwttH+nOU7uh5AmIJO+sKT60=; b=cIj5r7WJlfoJ4ngNOV86LMBPz0
	mJ7KSK6TTlDVuw/tfXO3VU2xa6EJiseN2VZx/VH8eNhGR1R7RiL0fGqLq5cmw8JO
	AIwZESGTSf4lIk2SuPuRYAbV/o66S5DiE3d6bv8h4wxhFRBPmDm5cCDo8Lad/Thu
	CXaPHXrQ55Zn6hGee7mdpg98it9DcFEmMpxYY7n7+Lk7K3w2Y+WzO71BSHeLQYSf
	xbNkg2VIn2e9k3VuOeGgURJrcSoLzeFAbCCZK3eoljn2VnBmczheUfNt+Y0bNnTN
	Ed+zoZ8ONEs0CULH2JPVVN62iHbYzFKAC6FIyQlktE96EgpFKcBesiNjKp/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758906903; x=1758993303; bh=Xv3jnB8dXwYkb2biwtUNwttH+nOU7uh5AmI
	JO+sKT60=; b=CBWLxvATZ3/t1CRpOY9hB3y7d7nPS4E0xwNCojjy1claO+BqheD
	WYzVxVaA2WOaGJ6nZbe6cWZ4SdpgGcUHiMvrwl2ggXqr4vgvJNMjL7WFeLm34gLy
	5J4tYZ6eCjOjeFrDWDfPjwc0TExhCEoo5LQUVQkP2alWdpeDmCQu1lwhN3CpwCX7
	r/bXJJX1Ds/MZyfPBrMl421sJBlCSODbHVBUSYuAATRREgXeid5FgnloRVDqN4HM
	4Z5Pk6v23XOrDt5BPm3J9+Wf+JdX02x+RkBL9WWpGFJcbBtUwcVqftFZdyz/XcrM
	zgVnaqMD9YUWoocf6XWJVAK+s2QeUDz79wQ==
X-ME-Sender: <xms:F8rWaAQafTUKB3QPf5adki6EpLeRJFqkVZENMPTZecjQQd27QQtflQ>
    <xme:F8rWaBftxJYqeLTO6DT9WiDJIxs8m_ktAiKy0VxtAVsKv3TrmDATpIFZmJ8kOq5rt
    gtoXYmIUm75rMZXBpv57BVjExnrMOzB_jVdm-zXyXv7LuUNRoeW_g>
X-ME-Received: <xmr:F8rWaHr30uq97y48bBQrGE47muiwl-7sM9ATZlePwq7ugML6859fmdk7gV6J_WMNp9GZb0YHDz4zqu2vTT4o5QFYbjDZ8-BZH-56>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeiirg
    hrrgdrlhgvohhnrghrughosehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvggrughm
    ohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:F8rWaK9qkFr_soC26sGSMZVATUn7RdjJocp-nsuVS45ObD6MNxscXw>
    <xmx:F8rWaLd1INFeVQiFyZN9MBcjpDINJvQp1xXZQZ1cr5Kuvt5UpUJZbA>
    <xmx:F8rWaMKnePpFuwhvlDcnmrustRFdQr_2c4PdOp83K4XFH-ciFyZgpQ>
    <xmx:F8rWaDgw-PzLe4358Vt7KXL6UYp90J8sHtAlffZDSZGNutiQhI4jwQ>
    <xmx:F8rWaHc7byXGBU94QamTExKj9d52M8Y2gUJ-rEoxWSl0AzhfCVJDf-9D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 13:15:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: ionnss via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  ions <zara.leonardo@gmail.com>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 2/2] libgit-rs: add get_bool() method to ConfigSet
In-Reply-To: <9e53f617-1b17-4d36-9c35-fc86c0ddfb19@gmail.com> (Phillip Wood's
	message of "Fri, 26 Sep 2025 10:58:04 +0100")
References: <pull.1977.git.1758800669.gitgitgadget@gmail.com>
	<a5904a2ac00ea6de142344272b45f6b4697b4f98.1758800669.git.gitgitgadget@gmail.com>
	<9e53f617-1b17-4d36-9c35-fc86c0ddfb19@gmail.com>
Date: Fri, 26 Sep 2025 10:15:00 -0700
Message-ID: <xmqqy0q1b0ff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 25/09/2025 12:44, ionnss via GitGitGadget wrote:
>> From: ionnss <zara.leonardo@gmail.com>
>> Add support for parsing boolean configuration values in the Rust
>> ConfigSet API. The method follows Git's standard boolean parsing
>> rules, accepting true/yes/on/1 as true and false/no/off/0 as false.
>> The implementation reuses the existing get_string() infrastructure
>> and adds case-insensitive boolean parsing logic.
>
> It's nice to know that someone is using the rust bindings. The code in
> contrib/libgit-rs is intended to be safe wrappers around the unsafe
> functions in contrib/libgit-sys which wrap git's C code. I think what
> we need to do here is add a binding for git_configset_get_bool() to
> libgit-sys and then wrap that in libgit-rs. We don't want to start
> implementing the parsing separately as they'll inevitably end up
> behaving differently to git. For example what you have here parses
> "00" or "100" differently to git.
>
> Thanks

Thanks for paying attention to an important detail on the design
criteria.

As this is a binding to allow Rust programs to access the feature
implemented and offered by Git, I fully agree that reimplementing
what Git does in an incompatible way in Rust would not help the
targetted intended audiences at all (that is better off done in a
project that aims to reimplement what Git does, like gitoxide,
targetting native Rust solution).

If I were not paying attention, I would very likely have missed the
misparses of number-as-bool, distracted and blinded by the prettier
and nicer syntax the language offers over the original in C X-<.

Thanks.

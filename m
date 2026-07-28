Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57673432313
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253348; cv=none; b=OL2lFXbfni7FFfXSszvV0EkR/lSYJQzqk/OSK7LHXItFnrCWmpOEHmleGevQaDO7jZLGIPrxDMLNwseJp1Q+IZHWCEQPPRWze2P70qkJRDBwFhgMJdbdhavQeRfz05EJRPyiiNZkv+3MUw/9qAjizbGgpvlN067MQF7D3U5TVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253348; c=relaxed/simple;
	bh=WYB2UQAeIa8rPvFWsOxq2WBKIRX8v0MoUisIqETopds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sS9hd+1Ge97AbDrlCAh8CujmK9k6wnjE7kcwQ4/mczBbIBgTF/qbOx4D45M/HjMjBA11+0eA+czikw6uDuD1C9klj0qbyOmGTiPU/Y7PwwdM8rXkjVoUai+NyAr2OCv0kWmXJo1152GuqV681vGQ68ldWkMMBuXrFWLsEnQeVdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gO5fKvIA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aH3/fU14; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gO5fKvIA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aH3/fU14"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D2F8EC0347;
	Tue, 28 Jul 2026 11:42:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 28 Jul 2026 11:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785253345; x=1785339745; bh=7VParmwDM1
	N4xvHCcRX3rY7yWQNmRbHeMTfgdbTSbvs=; b=gO5fKvIAoggH3Uck6HlDjjs/XP
	q7vRjWHiL4ODnFYfClix5Dwg/DSciCPzgsrLMyTFBZAWjc8KK/dZJ0xQ9tmDsk7B
	3u1PcWhLechjQyDhqMIiXkmKfzF5lUvKNnu1hdjdwRJzFDgIS4wKkToQsqvCLbP0
	fXBarsVVj2fprIU4LKh84tClZvZ77o+eYQZEPVJ1k2ztTQm0ndoRPFggNszi4PGs
	dfNIuxsj3Qci+QRpwM+LcN0v7edzm1/QUUVIAIIWMN6lFopeQDnfGcClk3brSo3X
	Yp1VKyLa63jj3wAsjNcbX1g4ZLBiuHukSfmT/yAWx9lIGKp1seV3zjcbMItA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785253345; x=1785339745; bh=7VParmwDM1N4xvHCcRX3rY7yWQNmRbHeMTf
	gdbTSbvs=; b=aH3/fU14igNkKgjZmzMs3JlI+V6fY8KIWwZ5Ud16tELRfFWtSr1
	R9Z7UrN19dHCy/gZGlmQTmOldCqiWAsOJtSz45A3ekg509JaosRsj+W1JymoGEo5
	sZhHdQc21FNlZP/ct+gjzG/iGs1ZJQ0GDQD3BlSIPV3yP9jxWovNwWYEaoFSMOXj
	EQaAN4P2ph2qUpX3fGsyI+tgJSyyl0wNZtNAQEfltjN6l9AmxyoGlTFY5iKoMyub
	872bv2WF3X/SrB9bXr8eZgoekbfIXRqRA6FQC79hp48VXO1gktfwF8jvUgZZwLmD
	j7A6vVZKs2xCgux3JScJlNAkcZqvTxRzdXA==
X-ME-Sender: <xms:4c1oakbDA7Ht_StM-DoDPCVUFPk77bnFy2H6m1xaOOIRAhzDetOn6Q>
    <xme:4c1oambJwduGBgF6o1dbLhAyohrfO57-Qti3O_tybi5xaGRwuxPqEvfqPeFPOc0Dc
    QmDnzZ9BTkv-FQvvxpjEUbfelwcsmIv_mQCbCejivWoAUctleNE>
X-ME-Received: <xmr:4c1oaj9yZjg9K6HFvTasvhUrKxUc18rq6PHVqAz2F0fTznFIqJ9EGOZcm8us0s2f9APJql9kEDME_vm1EyWEiNDiDDAXmNko5g>
X-ME-Proxy-Cause: dmFkZTGHW987C6XBhtn04gJBqA2iM5nhuYunZ7W1H2pURQqcL6xzhOYCYXcGMJm4r1l9jL
    QCeQgG32WxR7g/G7U/JOgEwQLsBje4CRxIeVs1lh0kPalotEq8y0Uv4oSoUe9i7sNlX8Tg
    p6Ky3N+qRcV/pGCbVOBq3ySXF525ELolPXgBWZYnmC9q2pfSglbLfGDKDs2OSd5Ryl1oC0
    iirWFVTGDoDnCnz/TDx2wIi75Y0RWHc25qrue1OTzTueAAFqueaJ8u9TxXupMLgWc0xfMb
    t+PuiyhaHvR+i95sg/y7bmtolc4hqH81NgRAuNi9/t/irbSxr3Zj6rPssiDUbRgUf0iMjp
    BG3nwmJe4TnZNIeja8PGpiDv+zHglevcechEc5aMOYjIZ8jEC7v6vPBraft3Rs8G1WA8gm
    g2tweAAoFVy0wdAIbSbCSqZQEDbpeWqGGJJ/Dtsn1+lYUrw2F1qRVTzGh/p4E+ly3sGW4h
    sY3uR3F8O5b50ZyjkOyfBCq5TTd6teDyGHvrlkS4HUuMKQO+6avyT+AY0qau/5gWxcbBtu
    PiynstdslrGnTH2dlCg+kM+lPVYUtppjxcQBkFEL0t3zBQ6IOmKmN2WHI4f26/XbBMYoky
    DMeFwGiLYFl1aaTU+Vhj70W/axG76dqXXIo+/sxTgPSmXEMMamLofGfpHaXQ
X-ME-Proxy: <xmx:4c1oathMd9v19k6WBpGnUQX6wWSFGJeJpnf5T04JoNqfdsnoZoMGgA>
    <xmx:4c1oarf9NnU4Jh4BQYngLGFOpXkAgOA1GEJGVpXoQigXumxPJawV0A>
    <xmx:4c1oasq-pjUuNwwfTmUhWSE1WX3gKyF5j6FoAguieRJiJzXdV24Akw>
    <xmx:4c1oaoDLiz36RL0b234_hdF3q9w0iXJxDF2Rjgwc2iNF4RS5MGWBEg>
    <xmx:4c1oao89uEu1wBEq91uKN_T03h0D4QZDm-6VUsdmXKxxYgP7amtYQXfX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 11:42:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Emin =?utf-8?Q?=C3=96zata?= via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Emin =?utf-8?Q?=C3=96zata?= <eminozata@proton.me>
Subject: Re: [PATCH v2] stash: add 'reword' subcommand
In-Reply-To: <xmqqbjbsmkom.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	27 Jul 2026 10:00:57 -0700")
References: <pull.2180.git.1784190706028.gitgitgadget@gmail.com>
	<pull.2180.v2.git.1785149687514.gitgitgadget@gmail.com>
	<xmqqbjbsmkom.fsf@gitster.g>
Date: Tue, 28 Jul 2026 08:42:23 -0700
Message-ID: <xmqq4ihjf7ds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if the reflog API needs to be extended before we can
> implement this properly.  I imagine a set of functions like (there
> may be others)
>
>  * refs_reflog_replace(ref_stash, idx, &reflog_data);
>  * refs_reflog_edit_in_bulk(ref_stash, num_edit, reflog_edit[]);
>
> will become the foundations of such a feature.

On further thought, I think this fits pretty well into the general
architecture of the refs subsystem.  Both backends would need
refs_reflog_edit_in_bulk() in their vtable, while the single-entry
edit can just be a thin wrapper passing a single-element
reflog_edit[] array with a 'replace' operation.

If someone is interested in implementing this, there are a few
tricky details to be careful about:

 * With delete/insert, indices drift.  In "insert at stash@{5},
   replace stash@{10}", the second instruction targets what was
   originally position #10, which becomes #11 after the insertion
   at #5.  Pre-scanning the reflog_edit[] array in user order to
   annotate each element with an effective '.idx' value should
   resolve this, or something along those lines.

 * Multiple reflog_edit[] elements may target the same '.idx'.  In
   "replace stash@{4} with 'hello', replace stash@{4} with 'bye'",
   stash@{4} should end up as 'bye'.  If a backend sorts
   reflog_edit[] by '.idx' (or in reverse, as the files backend
   might do when copying from largest index to smallest),
   processing must produce the same result as unsorted execution.
   The sort needs to be stable, probably keyed on effective '.idx'
   and tiebroken by original array position.

 * A reflog_edit[] array with "delete stash@{4}" followed by
   "replace stash@{4}" asks for an impossible operation and must
   error out.  Swapping the order (edit then delete) is technically
   valid, though it feels like a user mistake.  I am undecided on
   that one.

Although "git stash reword" needs only 'replace', edit_in_bulk()
could consolidate existing operations like "reflog delete", "stash
drop", and "stash pop", and help clean up refs_reflog_expire().
Even if initial support is limited to 'replace', designing for
'delete' and 'insert' upfront saves us from a future rewrite.

As for "git stash reword" handling multi-line messages, the
flat-file reflog format pretty much expects single-line entries.
Since "git stash push -m" already squishes contiguous whitespace
(including newlines) into a single space, "stash reword" should
probably follow suit.

That is about all for now.

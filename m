Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B8219FC
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680822; cv=none; b=okNSdbGoM5LZg3/tVy/WcupdK1P1KezyDz6IVPZuz7GQ5OYPoT3pDDGhOFi2SNRarIB9iu7lF8uOPsYh/UD5rog2Z1eFD0GjMZZ95IH3ewr/ZhJAWmJKqloedVYWX0YkVaiff/ANQv5/iwfsQLZNAU+5f7RKmPXslySGXp3blHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680822; c=relaxed/simple;
	bh=ctJcSDR2AbBHvNwYK/fQvx4ik9T37shgGRwzFbxUuWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sw6j7mSLFPvllI4yypR/bjJwlgZj1HIy73MgnswgWfLZsJaLWcDqzvonMaLq6aqJOmdj9rjQiNi5hiw9KY4UAr2QSSfxKB1f4Fd+U/BkssOCw7BpmAP+ZSLgUMEk/pdVqZSJ7ViA8puBeodOIlAwKw1ulQ2INt43Nh8s3aP18Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T944PYr9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A/KmnUpc; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T944PYr9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/KmnUpc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CD4FEEC00DF;
	Mon, 16 Mar 2026 13:07:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 16 Mar 2026 13:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773680820;
	 x=1773767220; bh=XK7KV/9DsQGk8SmtmB/xm9ga1FT4Sg+uKjRaasOxrNU=; b=
	T944PYr9nE7S7tyxixdOZIV6IEMyrdsWoYmwWfqBKFP+4uOjQGlKBSrl7ZNxdsiC
	BHlizi4RZLFOhjFU1mPe32ylzf6wyFODZSxdEL1ImoKu+sCbdJNHjiWCnKL/CVRh
	J7fq+t9U7hKuyw4PoWTibi5eXvznnoNIQyW8jAIYJyMwTPkUVgblkNwHrCB2I/mj
	6TeRTkspoN2GpZm7hVT0cXTGPLvu1tk9ZK+XgDuMHR2M6vc+CWQCOps2Wv7MyJtY
	x32gjpOFaLdtVVrmQPZc227mEf/9qeZlZcbg3aZGRGodTlVAhqZap/nYdH4GNdl2
	Zq7GE01iu5a4U3KeQTNDmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773680820; x=
	1773767220; bh=XK7KV/9DsQGk8SmtmB/xm9ga1FT4Sg+uKjRaasOxrNU=; b=A
	/KmnUpcuup46lflZOF0ui5wV91voVaXMLbyXaNPI8cqnPfM9fsPNGikAybaSpJRi
	F6ZkGgD4910KdHM/d8D0LJI9ebWKYjPnStFV+RyE44g7teD/z1BAOZ1VIzbTSVpQ
	o9cVv6yAIIghynSXR7atW6mgbBpe2/b/w6nJGGukjU2Gkfot3ltDfZngEpTfxiuR
	MAXMPJthV3khAfzB9J0PUdNHZBaWF4rohbUVwV6b1r98abYyJPCwlPNItnd9KSMn
	DxFMWFwMVjdHa/g4bMZeh4IJJCQnmIoXiXyQOTzv3TFQq3wYPYi6mF0EX5RhKQMB
	diD1Sl9ZEr8BGiUPMiTOg==
X-ME-Sender: <xms:tDi4aceELrJAjRIwxrDXLg9xVnKg5T02gat8mlwkpqFbm94swVrUOA>
    <xme:tDi4aVE5ur10pFxvM8__wYxeawEJMZmMxSAWvdt9J50m9GgqUHTQuKf3erdhk4IDS
    KWa9w435IFNtL6solk63wRYSntu2I3bKz_4aAaeywYOx52hikk7ow>
X-ME-Received: <xmr:tDi4aV3Ah89fWFkhyVxnQ_z8nFnOf_WZMjlr8yvJD8ph-_QYiQ7pH7Tw7CdmRUmmkB19InTQPCc5pOjIiV1XOt3SRyLd1If_NA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tDi4admf_dQnKrA0Zgzx4C7bZLuHjSYzm_nuqiFRu9FTBHh7WkruyA>
    <xmx:tDi4aV_Cu0x2l6sKdFSvZ0f0kg7jsBvR7bdS3ieiUkbgnviK9DU0jA>
    <xmx:tDi4aSp2I_JcNsUIDLCaI8FVTSmgx6V8la5-jFWmvbG5-Q1vpD2THg>
    <xmx:tDi4aelTNKaM-zLiGPf3lJRS47Wft43kBK5xUSXqWlyQPU0wnalgDQ>
    <xmx:tDi4aU3r9_--3j2Za_wY_ucW__afk_qSnpvlYUzV3TutqLDhZMuqqX3F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 13:07:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] remote: use plural-only message for diverged branch status
In-Reply-To: <75c85249-1cff-425a-8e77-98d55215c324@gmail.com> (Phillip Wood's
	message of "Mon, 16 Mar 2026 10:49:26 +0000")
References: <pull.2239.git.git.1773479526823.gitgitgadget@gmail.com>
	<xmqqqzpmwdyi.fsf@gitster.g> <xmqqtsuiuugy.fsf@gitster.g>
	<ca6e021e-0301-496d-8bd1-b646487ccbf6@gmail.com>
	<xmqqjyvdvo7t.fsf@gitster.g>
	<75c85249-1cff-425a-8e77-98d55215c324@gmail.com>
Date: Mon, 16 Mar 2026 10:06:58 -0700
Message-ID: <xmqqms07putp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 15/03/2026 02:08, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>> There can be more than one form of the plural string though. The gettext
>>> manual has the following example of the Polish translation of "file" for
>>> different numbers of files [1]
>>>
>>> 	1 plik
>>> 	2,3,4 pliki
>>> 	5-21 plików
>>> 	22-24 pliki
>>> 	25-31 plików
>>>
>>> ngettext() handles that correctly, translating a single string without
>>> an associated count will not.
>> 
>> That is a very interesting example, and a valid reason to have me
>> retract the #leftoverbits that led to the patch being discussed.
>> 
>> But wouldn't that lead to an awkward conclusion, i.e., hits from
>> "git grep '[^Q]_("[^"]*%[id]' \*.c" are potential bugs that need to
>> be updated to use ngettext().
>
> I think it does - maybe we should suggest fixing these as a miroproject 
> for GSoC and Outreachy? It certainly looks like there are plenty of them.

That would be great.  It needs a bit of thinking, the required
change for each of them is quite small, and there are tons of them.
An ideal candidate for a microproject.

Adding it to the list of microproject ideas is a good #leftoverbits
as well.

>
> Thanks
>
> Phillip
>
>> Of course, we need to exclude messages like "the error code %d was
>> returned" and "you have a bug on line %d", but there seem to be real
>> errors in randomly selected hits from the "git grep" output, e.g.,
>> 
>> add-patch.c:						 _("Split into %d hunks."),
>> archive-zip.c:		return error(_("path too long (%d chars, SHA1: %s): %s"),
>> builtin/checkout.c:	    die(_("'%s' matched multiple (%d) remote tracking branches"),
>> builtin/credential-store.c:		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);
>> builtin/describe.c:				_("found %i tags; gave up search at %s\n"),
>> builtin/fsck.c:		fprintf_ln(stderr, _("Checking connectivity (%d objects)"), max);
>> 
>> You can notice that I started from 'a' and stopped very early in 'b'
>> ;-).
>> 
>> Thanks.

Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F824291F
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803241; cv=none; b=Aj9BT5zq7QKn39sTowp3memq62ecHtaOE/GXbs4lJnR1vV36WRBNfRuiHcve8/sFi6+HN+6jgv4J5XPbwrfsYYmNHHiOVpDIizg8zfxeGnT/2zda1TQ/hVEwVx0EDGuSIbs8uktmYNpZgmwP2eRGbhGGhSKXw+dAb9QHA3247iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803241; c=relaxed/simple;
	bh=S9UUaCTGMNQ+bW99kWVxGzTraxM72ArwmIT4eotyuDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oo0gPQ1s27nSpzf5hNxi5Po5R7oR0Do0ie0c10u/9jwQqsFeELDJS6stJMnfboWyVOS+DTDHnbou+SCtzvjBk8hnXoyn909pZP8oVeh+qnEqKcZs8T9ZA3peupz30Sq4k5/9UUi5hL04r4gh3l7KCxNwG208QP3Irso/1fHPsR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VdjYgEah; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eF9W/yE0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VdjYgEah";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eF9W/yE0"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3777D1382CF5;
	Wed, 12 Mar 2025 14:13:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 12 Mar 2025 14:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741803238; x=1741889638; bh=pU8hXamP0c
	3cVY6Abu7XD10zsaGj1YbjtFyAe2qZSd8=; b=VdjYgEahn1dywmcljGTjKCOREZ
	+KmsFuYIOP3ubd3KwJl4lVHuajwxN75SMCyzpfv7zV0Wm1c1oZzIWH7/xUrM07G5
	/EkiHyw6xrlZbFfXUfclUhSc2k/YqgnVzEfftXiOKykLde7aSKfViBHl0IZSwEij
	WG0DndPpIF4D8uh0HdYTKaaf1dyZA67joCOHWQhi/twpt4nJ9qEbo+Ep744mEDKH
	5u3oAm4EA1dgC0yhOydDZfY6up5aKr82SHNKNaLMWoLggtFM4uYqekvAjSiHG1DK
	R4iIHeQ+4srgRgbXofeScUL8N/G2WCTTNP38ed/6oRnCX0lTuaE0yAqFJ6uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741803238; x=1741889638; bh=pU8hXamP0c3cVY6Abu7XD10zsaGj1YbjtFy
	Ae2qZSd8=; b=eF9W/yE04DWf8wzG0e6LU5Ye7u0w24QWWfBhAzZxwzHK4rS6Kcv
	u7T7UwKEWfSfJjg4xA0+3Yh3g3ZZJviqqUkSLmhG0Gk0tdcdgwt/bk34mpIrXlLK
	QZsn5i2Mel8bSgc5U2OHKP311ZP8cy88X5OT++mXLits403LrVx+fcsbMzL2+qgu
	FhyeqD3Aomp4qXWJa/wFpQN387RdUdA6moHtdEE+6uoe12scXkXSLsKtpGBG0laX
	ZBtIN6G/nPAmPye3amnG3/os308T5o6+emf6mXB+dPmRJT+h2caIF+GqzgDCEq7z
	uFA0lxsfTyv4esytyF/vHHXRDNSdLuEnpoQ==
X-ME-Sender: <xms:5s7RZ8irEZfMx6H6091GH5v1bw2Oia72wmu_PQ5iMRKs3TjYp0vQTA>
    <xme:5s7RZ1DwMUebAZdFvN-9W2bc3Nlo0tIXcI2xlQf39AlK8H6vEr4yngKUlUHbpYBQq
    dKOVqIpVrMM48Vv1Q>
X-ME-Received: <xmr:5s7RZ0GKSw-RAmzBMkg5L0awgczDYf5XUM8RqOdIcDR4o0MJZU-3qSs14ZoDCNaQZe-3nanmdkCrYsbpLwTITqw8nckSWRWKAQhl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghonhhtrggtth
    esrgihnhhprdguvghvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:5s7RZ9SvL3ifCGnWdA9pPo0Dci0yFlpvoKjIyfTxNvfui48W-4S1IA>
    <xmx:5s7RZ5wZ-i87ShHEfKezMj_KE2pX-N252OshYNqCVSdswxI8e5r-Tg>
    <xmx:5s7RZ76rNYXAymr5YayfUbzveBsz4xX81dInQJ0MT4M2S2cJ3XTjqA>
    <xmx:5s7RZ2xl7Hljm0GSaLwACpUMDo5ht6nPhLsltWggG9HbCpNqrJ8gww>
    <xmx:5s7RZ7u1BJxuXn9zz5BtfHQTptsjmwFFBzUoTE8QpZrRmtwjojR8uGgd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 14:13:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aryan Pathania <contact@aynp.dev>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [GSoC PATCH] t9400: prefer test_path_* helper functions
In-Reply-To: <r5572ospfh3d7nwniod36jcy5ikv5pkmiwtqj25ll7p5ts3zay@okbxrhy77iyv>
	(Aryan Pathania's message of "Thu, 13 Mar 2025 02:34:52 +0900")
References: <20250308090358.25429-1-contact@aynp.dev>
	<Z86LrOEhH3CJOIey@pks.im>
	<r5572ospfh3d7nwniod36jcy5ikv5pkmiwtqj25ll7p5ts3zay@okbxrhy77iyv>
Date: Wed, 12 Mar 2025 11:13:56 -0700
Message-ID: <xmqqplimxgkb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aryan Pathania <contact@aynp.dev> writes:

>>This isn't quite equivalent: we've been checking that the path is not a
>>directory before, but now we verify that the path doesn't exist.
> I understand. I could not find `test_path_is_not_dir` or any equivalent
> function in `test-lib-functions.sh`. Maybe we can keep this stronger
> check. I'll mention in the commit message of next version of patch.

That is exactly Patrick suggested (go back and read it).  I agree
with him that the updated stronger check is an improvement and it
deserves to be explained in the commit message.

>>We tend to use `test_path_is_file` rather than
>>`test_path_is_file_not_symlink`, but I don't mind it too much.
> I believe `test -f` is equivalent to `test_path_is_file_not_symlink` and
> is a stronger check so maybe it's fine.

Don't believe what you think you know; if you are unsure, check to
verify before you base your actions on them.

    $ >this-is-file
    $ ln -s this-is-file this-is-symlink
    $ test -f this-is-symlink; echo $?
    0
    $ test -f this-is-file; echo $?
    0

And if you are not unsure, then learn to be unsure more often ;-)

I do not see any reason in the part of the code Patrick commented on
to insist that gitcvs.ext.main.sqlite file must be a regular file
and not a symbolic link to another file.  Both test_path_is_file
and its original before the patch, "test -f", would be more appropriate
than test_path_is_file_not_symlink, which was specifically invented
for use in t3903 where the tests used both files and symbolic links
to make sure the operation being tested would not confuse one with
the other.

> Sorry for the trouble and mistakes.

No need for that.  This is for both sides to experience to learn to
work well together.

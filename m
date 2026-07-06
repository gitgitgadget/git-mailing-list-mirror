Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA7A3E9C2B
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783370578; cv=none; b=Ut0w0Xt+/rpSeMY+zD42rPWSy2R1I0B0fBoJB9HjW2JkeXEYHRConB6JTKvbdNFoG75tiyEvhguQyCClDG9RHxGp1aoFhnQM0isdsXylq8cwGFYJIKGur2cnyA9p7ICTUPV//5qdUeccX7MYjXYQxczGInlNQsMZ/5XjcRWaJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783370578; c=relaxed/simple;
	bh=heUjv3OOIEEoB1dP5lLITfeuyLJ8KVsNFxS0dDVNze0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XUT+XM5W5q88cEZU0rIRg7q6oracUIkWr7osP3ppwWPaUqiZIF8sWk5KcpEg72L0g3sTasjmS03DZKb2I19ZsITewiJ42z5ur6ux6V36kPbfTvJLys4HK5YpfWUKp6Da1pMbnxT5U3ioOc4U1g7gUh6C4UIadJ1PN0HVJ831Z+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X4sTo8Rd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f+N0PbaU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X4sTo8Rd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f+N0PbaU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C3152EC00CA;
	Mon,  6 Jul 2026 16:42:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 06 Jul 2026 16:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783370576; x=1783456976; bh=gJRz1IktxC
	a7rVUeX5qP0cXe96wFa5dU9SxzcgAcmGE=; b=X4sTo8RdmEh8RdXiYbjYrfQpAN
	0W8aOSgX0Tn851H9VWsVslT2nAVPttPB5tkSfxVH7+PtZjtFLbWb6dn7eFblahLu
	PqCh2E3Z/YYyFlmlCgmS1h4iqkx0jdeT6eeEpSAqOGFFe6MW1rmWdrABs4nT76tR
	UcR667MrBh2UaFPHHe17Q55pMURiGquXXyQ8RSb9VOzCvjBFMkFshnwLbR6ABI24
	iAxISzEiYhOrEeG2VSgHH39oKA3BuYTaB9L2+WuPwJJi+3Hzg+ijHr6EqCznemsn
	Q/92yBTeF71ieLz8/P5igagkjaNyKiWKDehT10mbrjVgdlhke9BOjUbI8r3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783370576; x=1783456976; bh=gJRz1IktxCa7rVUeX5qP0cXe96wFa5dU9Sx
	zcgAcmGE=; b=f+N0PbaU4x4pCUpxP0iMvVEV8PXf775O/uN3rh6LLOridZcDBdO
	1VDXW9g15nKwnWlytBllRsMq/IaKm4qdA4kEsfS3kN05fJZ0KCXJ4/9nstXK6Z/O
	5mSlsBqAl6NoUjwNNhfUxrJPTYDxkjjDYXqpT4JIZivHPwNiyy7BoAW9RkiC3TgZ
	0U9jHapzFzNhlK3er0SreJsV6Qjdf9K69r0CoFC5l0svOGipveLYPwCJbp0NFUSW
	qBM9nKLKMIi/NWwZ26/W3Gar8Tc7RfgDsosu77LR7ESfnNSYKUnkO9pveLCt15m0
	hzJ8zbMDV03Qn3entLpEqk4JFdHVTzls9Ww==
X-ME-Sender: <xms:UBNMas37BV0LWGDn5VpeVFqhL0XTcdJzJKUE9-ZZpglWaWBUABIplQ>
    <xme:UBNMauEk8UVDiST5B-85oMmunKBrthsdfIFeI2pxlsIyYomAZnYQlMiVyWaLsNYcF
    O8uWs6orQ6Yyih8z0niAUhcqXD0kubP4pohzOuUDJweqDdMAvM>
X-ME-Received: <xmr:UBNMap7nJPoa-2Te9qJ8cDm8CwjfUBrJwuQXyytg0I356cELnOPyUVo9mTUI-n0Nds8rzZJksVqOnStb_WD2SCHgrXVrVy7Ym0eeIuY>
X-ME-Proxy-Cause: dmFkZTFviHDwqJHlNtIV4xWStrsvAa/6uCr3sMysvHfXiuU5ciqfGca4vMltsc0XQ/HU5M
    q+lRXs6PZU6mor+CiompOGuNEA3zPvFoixGvCe91DMXALq4S/8qtn+2PtGJ2XnwY+2q0QH
    xc2vrubWfP2qaKJEinu2rhcqCckjzD8J7oOzF60zGy50gJlR4S/cGWvt3wyilrEi5wrojG
    iwv/E09gn7FIVANa/EjtY9FXMESav6cNMDPKZDUNHpjEY20nsVAoxcJ1ZagjWPKJ02Yf/G
    7kxzFqlToh9sT+bYC+GudPDigcqxU9sElgYB/5o5UsTrwZso3M3I44nx2OZzSqVhzij9Lp
    J1B/nvUiYs4ugC1hO8lc3T5Y1IzC7vNupnNvKD9fNKE4cIy67h1V3lNf770t1IvMcHY6jX
    EJSJ13mJ1n2CRlbYsacoMbaeQ+sIKZR3UbMiAD3DUpl/J5rpk8pDVxOSF++a6zcJ9t3FfV
    KdFHZRefbZAZBjHCV4ReInLnmmn5AYSWUUov6Cdz/CxaOFZhhGklZrgeaJi3LLspfxnBkb
    1OZ85pGqBCmgSNAHuJ1xKBw+Fof2MH45kxU/VgKlPWkLcpZqMBaCiTKMXSPmRrYbqpYvSG
    BNISGoKoQUhvJCOqpG9bfA2mu/5SchowL8018cKiX0fnoiF7FpkRLmX2shEg
X-ME-Proxy: <xmx:UBNMakuglgweXTI9Sfzcm2YkkKVYX3Ugafaq6kLam8nKGW6HGGlK7w>
    <xmx:UBNMaq7Xiiz0CAEq504kwdgb6q8_RttuzmqRDItFhw7qKir_b7nNKA>
    <xmx:UBNMavV24rvU2AuzXrRMzhaj11KrMKKHPThvvy0ZFfgUHpiVn_wZRg>
    <xmx:UBNMas_XEx7j958pBDaqA7hFq95gGDHOy9D-PbINMR3WPCkTFEyNiw>
    <xmx:UBNMalZ_vHZ9GBAWswK-E08tCveS87JkmmuGd7Bpuk87jQjV23CIl-ow>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 16:42:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v7 0/5] history: add squash subcommand to fold a range
In-Reply-To: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Mon, 06 Jul 2026 08:50:44
	+0000")
References: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
	<pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 13:42:55 -0700
Message-ID: <xmqqse5v97e8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Adds git history squash <revision-range> to fold a range of commits.

What I saw in the range-diff looked all reasonable.

>  3:  811e393ab4 ! 3:  cf3346a1cd history: add squash subcommand to fold a range
>      @@ Commit message
>           Add "git history squash <revision-range>" to do this directly. It folds
>           every commit in the range into the oldest one, keeping that commit's
>           message and authorship and taking the tree of the newest commit, then
>      -    replays the commits above the range on top. fixup!, squash! and amend!
>      -    commits are folded like any other and are not interpreted, so the
>      -    squashed message comes from the oldest commit, or from an editor with
>      -    --reedit-message.
>      +    replays the commits above the range on top. The squashed message comes
>      +    from the oldest commit, or from an editor with --reedit-message. As that
>      +    message is reused, a range whose oldest commit is a fixup!, squash! or
>      +    amend! is refused, since the marker's target cannot be in the range.
> ...
>      -+git history squash <revision-range> [--dry-run] [--update-refs=(branches|head)] [--reedit-message]
>      ++git history squash [--dry-run] [--update-refs=(branches|head)] [--reedit-message] <revision-range>

>      ++static int reject_fixupish_oldest(struct repository *repo,
>      ++				  struct commit *oldest)
>      ++{
>      ++	const char *message, *subject;
>      ++	int ret = 0;
>      ++
>      ++	message = repo_logmsg_reencode(repo, oldest, NULL, NULL);
>      ++	find_commit_subject(message, &subject);
>      ++	if (starts_with(subject, "fixup! ") ||
>      ++	    starts_with(subject, "squash! ") ||
>      ++	    starts_with(subject, "amend! "))
>      ++		ret = error(_("the range begins with a fixup!, squash! or amend! "
>      ++			      "commit whose target is not in the range"));
>      ++	repo_unuse_commit_buffer(repo, oldest, message);
>      ++	return ret;
>      ++}

Nice. I often see myself getting rescued by the corresponding sanity
checks in the sequencer.

Will replace.  Thanks.

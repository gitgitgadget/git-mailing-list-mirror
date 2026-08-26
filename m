Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883445A2AC
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761372; cv=none; b=AUjoNxhCQch9xkHekasagf7xYEKtcQwICbrLU5J54AGpQEm5iLrJU3/+2abr7iu4pDIa0on0/xvTcKr63EYIpBL9NhGnOL1sQRtVNZFOlPcmyUwJFllRcxFYU2TwT7TWQKVMX/gZjjrez867kK4Y1wv/A0JjvRx5Dj6NlpIXa2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761372; c=relaxed/simple;
	bh=Z5y7jdeKdX5FkJGOKY8LsOz3z6WOCjC97kExxdz5Cvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S+2olZ1dG7/86KLrz9F28h1XoMVFKtrM8Q1h5f37L7+9GExgS4MX4yRK1oHUsi8oGGhHYPMoJ/cxtSOCsZAZ/rFHiJ+xPBobYfJqzUgS+raswJEDWrfIV8GjkseMHH5Ckqm3EbX6vH6mPEhIHwNoBxXPkO+dkpjBVzOvcIBr1xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rWla6VNf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QYS8UKt5; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rWla6VNf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QYS8UKt5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 929371D000FF;
	Wed, 26 Aug 2026 12:22:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 26 Aug 2026 12:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787761364; x=1787847764; bh=nwapp4Uq6T
	3vLjyKO9wwI6Ex1YWFAxmUEbVB7UYdPHI=; b=rWla6VNfX4M2BqxzyomdZwT48j
	eQMHJNRnEEVFIVf7SPVDyE+5vjTpfEIrVErKf/lSj/H/GItM+NVuJ2g46JktcSFW
	HlseA/Vc9NDf+FM3BpHONldvTW4q913293922GyUVI+zzCeexuCaLj9UoULNmQfm
	Bt8uU8RCQlZGvxMPMDLSCqJ7v64RviUBh+bvAaDBrz7xKlqET+lvirVrWuQL9tUf
	Zmuh8DcD0Vn6hz4Tjjp0BRQhdkzjulpSVbwgMW8X9CUdqUd6hU0rDmsP4zX7OJ3f
	VYBfOi41Xv7Shvuyo8m8KajE8jqnYC8jl/7FPAVmMsbNnj0y7FBKogmbfFRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787761364; x=1787847764; bh=nwapp4Uq6T3vLjyKO9wwI6Ex1YWFAxmUEbV
	B7UYdPHI=; b=QYS8UKt5vFRAc4pqJD5F+TbIEQD7j2HLKgFBzhBRwrQGUhP8/VC
	PpvBUiZQx0Hi/b4hgLg1iLM/jQWXQBcvKXGmXlGbC+GBUkpwMkmV5/0wfW9omUNy
	NtIQCSzkxrmQ/i4AXNBPWpjhInq6iSqQtKWzU/CtI2/gNVCDax0bIcOl2X6Ur5gG
	1n3zAadIox3Cjzd58bhukbJ0piuhn/PSV2p/mhYLkIQE5e4fQA9t/sDMG/G3yM5r
	rXOXnBpVm2Yehf7r1SdMP80ibSeNpxqoVRcAZolDdzHolX5Qz3+YqJNdXoIusFPe
	zEiAH0dBjiQquTDsoo5r+7e6B4QEV3lQw8A==
X-ME-Sender: <xms:1BKPath5Cud-UfT9qsaHIGo0wd7uBKdq8I9KJ48PiafJGIAloz-Yiw>
    <xme:1BKPajgbr_E8r2DZURZSGsTeuiOYtmG9KHOgOBAQHBszTF7r6--MNGcjvP085tSla
    RwoyzJeNdcVLEl9-saS_wiODYhlIIxZV1pX_nXWgyXId3dnkYDZqg>
X-ME-Received: <xmr:1BKPatKjuBaARIglTBChSnNqXs3pAEMk4hv7vtBpBR83Xi_wGiqfiqq_Rhrthn29gZnhN5GFY4InQCGaOtNGZnzDjqOKZKIMLA>
X-ME-Proxy-Cause: dmFkZTETYdkPET1U2PXnSODT/aaSru/4yvmNnPTVXrTxHhTcVCmJ+DzmgnL2QLpmOR/28S
    am6jBnfTZIsWs6hWk5fmPXXlnkh+SPUR9B8MHiOndKsAXDZyDd6gVVPb52K0OhdJLfHp00
    YXQSHQ6EYW49iqsqdedT1xIGw9zh7YIIQLQeD6UhAUi94GZFD5mUMeBkmBfEDDhoywndWU
    moxbetGFPRlfM5XPMz/DgvNgA6SXOTAXlXS1+rj3HWvWAanUMZHH9KNutE+gTaCoXOAkls
    4HCuNaRTIGJgf59MUNHxA4i3Zb1xkbRyYZm2CNHXheVJbmT8O23Wj3Gj+DbElqVETSsJX7
    d6ERdJbIwF5LmKFyJRZKKDe2ME8KD7ZYVOrIpqGfR6XwiA8gYOmUa8KfUFnyoRK7qA4bMD
    bZG3arwlUkRA6NNTLdnPuSd7NuCSBD1rtjo1aswI9WsSMRPmFpQP53ZXg3cvRx7SWH4nCC
    kJhxSyh7dsOucDbQcuj/G0rllyRVLojW0bnV9bU7ycAHYVkc5OialIIc1SKbem8N2e5SOz
    dSVVvH+oVFnVS64od8HFXMZizO1uBm1emeJSAPsDkQtQMHmBbuRCzhzmJPYkI3erlqb/k8
    goUf0xnQElumrJNCff9c0tXIzqAGDqTnzVbERmBNc2mgoYy5UFfCV9Eg7lZQ
X-ME-Proxy: <xmx:1BKPaiHGYLUer3pxk0kXeXiYUwbsu7LvmFFRxvaugQ5ELZ5YRTz3Cg>
    <xmx:1BKPahRK28Zwgc4mT5D_YgdXgt-VOzGkAQvhWFnc4XaPMl91Hz7jRg>
    <xmx:1BKPaufDzUnYY5pZe6wkOHTHiBTaxxd3hdpL727WqlvAtQm6Okbjlg>
    <xmx:1BKPagpOVX4ROsJkeNi1DLxt3RvBSdlUxZh-QRxZy0pgMtC3sJFbAg>
    <xmx:1BKPatUHJvQWycFBES5BafvpPBaT0856CcBjclEHNqI3--ANU0IGiihC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 12:22:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH] commit: refuse to amend during conflict resolution
In-Reply-To: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Wed, 26 Aug 2026 05:21:21
	+0000")
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 09:22:42 -0700
Message-ID: <xmqqzey8j1gt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ...  However, with the merge backend of rebase we have to
> be more careful, since it powers interactive rebases and
>   - the interactive machinery internally uses `git commit --amend` for
>     `squash` and `reword` directives
>   - users are expected to `git commit --amend` after hitting an `edit`
>     or `break` directive
> So, we need to be careful with rebase to only reject amending when doing
> conflict resolution.

True.

In addition, in any and all of these scenarios that lets the user
deal with conflicts in his or her working tree files and record the
result of conflict resolution in a commit, we should reject not only
"git commit --amend" but also "git commit <paths>", shouldn't we?

It may probably be better done in a separate topic, as the guiding
principle is slightly different (i.e., "recording the conflict
resolution is about recording the state on top of the current HEAD
and never about updating the state recorded in the current HEAD" is
the theme of the current topic.  "recording the conflict resolution
is always about the entire tree" is the other topic), so we may want
to leave a #leftoverbits marker here.

> A few files under the rebase-merge/ directory provide us the necessary
> information:
>
>   - stopped-sha is written only when the rebase stops and hands control
>     back to the user, so its presence marks a genuine stop -- as opposed
>     to the sequencer's own internal `git commit --amend` while applying
>     a squash, fixup, or reword, during which no stopped-sha exists.
>
>   - amend is written only when the rebase stops with HEAD already
>     pointing at the commit the user is meant to amend: a clean `edit`,
>     or a fast-forward `reword`.  Its absence at a stop therefore means
>     the commit did not apply, so HEAD is the previously-applied commit
>     rather than the one being rebased -- exactly the case we refuse.
>
> So for the merge backend we die when stopped-sha exists and amend does
> not.  This covers a plain conflicted pick as well as a conflicted `edit`
> (both leave HEAD on the previously-applied commit), while still allowing
> a clean `edit` or `reword` stop and a `break` stop (no stopped-sha).
> stopped-sha is unlinked at the start of the resume loop, so a resumed
> squash's internal amend is unaffected.

That is a sound reasoning.  Nice.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A1A27A11E
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756244314; cv=none; b=E/mp4iejwQ/C5WDoRcR09AKX9pyiwriR+RDbt/I5raM/s5o97D839i69PIfAPYpkOjfp0VQX3CTLeWP3/61QOVddC7fqNTw7Sqhn470a4cmhetjjMQKbtHlLNuK+wblEKa5Gkm1tcr1ym7W83VQICEhnM/MteuENivACgZLWcV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756244314; c=relaxed/simple;
	bh=t4NVhy945hlAPrFlQLlpVg72LCChRbaDEsBm0c23mTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G8Ki6wuwTqHjHE9bk6ZTLANn8lzXa40eId9a+KkJL7tpb0NkHjaemcxpoTUhNan/A6snlOnF2UPsRFMvdoJe2KoO637daC93H0x8qCYXGhjepHGd5gVvz/hHEuGBQTvdb4rRpw9tvpdWdV/Ep8vkpVZ0ZWN6BpJLLXbqZ3a408k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GRXLAAmJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GWq46tJL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GRXLAAmJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GWq46tJL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0224714000EC;
	Tue, 26 Aug 2025 17:38:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 26 Aug 2025 17:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756244310; x=1756330710; bh=q3EldbYpV2
	95+p1NHdmLvF7xE91m5KeyYko3bgL3IVs=; b=GRXLAAmJOW7jy+2mtbo5aLCvUq
	QCvLcrMKdlzU+nJBCFSR9wbx3pt5wP/VxAafI3ZcQ/3SnJpeKYo1fLw4Ttl6qK88
	BTWwZJD9bGvwcG5QU1bji5skAlPthAIMFQdf70onuz/kJFKBRFWobvdg8zRuj2oQ
	3XQw9C2lMbQk1xXQddJgB3Ylr4WLdt0rjm7i5Jb1r3A/dAOgvC38sokWqveWRBp5
	1hF7Oe680TSNPVX3J77yHNbE+MqRFQzcN2SffFZHm/6pD65nEZA8getIGyDqiZA2
	jkAyBDz33K54GbBRFt0ekZ2hDL4afII15XoIqmTW+em5D35w3SRO5oY6Vpfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756244310; x=1756330710; bh=q3EldbYpV295+p1NHdmLvF7xE91m5KeyYko
	3bgL3IVs=; b=GWq46tJLve8xXfyE4obFuHUaKVrsztUIPCDCsedRGrvBm/MuB0W
	fuvbUUoMr6HXr3omjv5az6bUzJoraYQAiak1hmUOW7+86IXzfDnz+CQzGdY4auIT
	YZSKAcexehBRDlVAIDMQG9WXK9QyU4ZY0vX5VNr4b1xEMfEr2BomxxaJBB0lPHr6
	Ey0HUOqRnlZFyqUKEtuheS5DW+xo4CYCYVXK/YGoEDESfwqiQ/UNeQd6lvQ4oULQ
	CsPRa/dkBmO0pxyNmkM6SbjRuk1eRTqHeQTgCk0FPAbWxDSWxBTznS3BAJy1MSA1
	1pNCLRXKs73FAPOfzynuT87PqAwXSmgCZVw==
X-ME-Sender: <xms:VimuaOGuQUp_8MRSM2fblyyxH776JxpacQIAYYnj_kC7k8XU3P3sIA>
    <xme:VimuaJ6pa2Q6spp_d4A-ay_1Edh2ftgAVC2pT60TfOMHuQFlhenKtBlMJXPC56BfD
    xgr4_eihB8J0SH6iA>
X-ME-Received: <xmr:VimuaEs6A7eEYpksXNDn27Wm_AwMhYExBz9oxlBvt8Ky-gixa253_g49Mj5h49zIC97JPoex4xw5VpQdbMNQ-LebZDbCEpLp4C2d7tc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeifeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VimuaK5pJEe5DaeIhNv4B2_esxxmwBOeiteTB5oe-kqGX0ifOZiLQA>
    <xmx:VimuaPWgcaDpBL1INhGg5qBj5kPVQYnSzalOG-pTmjDMa535jji-BA>
    <xmx:VimuaM-5xManUzvDMQfYOCg2a6zp0G5jzHQGEnJthwzwfYYJoEhATg>
    <xmx:VimuaLn9s0jtIMNTjo-8BnLc9fGY1W3vO6qrJvu_xDIrMRXN-7JmiA>
    <xmx:VimuaITV4Yr3Lon783k-_Bbk3CJxgqqEgJmhcrATU3eR64z6e9lBC13p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 17:38:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 2/5] doc: git-checkout: clarify `git checkout <branch>`
In-Reply-To: <b8873c4529caeddc85879efd122e5a57278352f0.1756148933.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Mon, 25 Aug 2025 19:08:50
	+0000")
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<b8873c4529caeddc85879efd122e5a57278352f0.1756148933.git.gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 14:38:28 -0700
Message-ID: <xmqqldn5ix0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> - "To prepare for working on _<branch>_..." is confusing to some users:
>   it makes it sound like these are steps that the user has to do, not
>   steps that Git itself will do. Reword it.
> - Use "changes" instead of "modifications" (which Git normally does)
> - Mention that `git checkout` will fail if there's a merge conflict
> - The current explanation of `You could omit <branch>`... is confusing
>   to users (what are the "expensive side effects"? what's a better way
>   of getting the same info?). Be more direct and mention that `git
>   status` is likely a better option.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-checkout.adoc | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
> index ddda891c0ff7..a3edb95973a2 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -30,11 +30,12 @@ See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
>  Here's a description of all of the modes:
>  
>  `git checkout [<branch>]`::
> -	To prepare for working on _<branch>_, switch to it by updating
> -	the index and the files in the working tree, and by pointing
> -	`HEAD` at the branch. Local modifications to the files in the
> -	working tree are kept, so that they can be committed to the
> -	_<branch>_.
> +	Switch to _<branch>_. This will update the files in the working tree,
> +	point `HEAD` at the branch, and update the index. Local changes to
> +	the files in the working tree are kept, so that they can be committed
> +	to the _<branch>_. If the local changes conflict with the changes on
> +	_<branch>_, no changes will be made and the checkout operation will
> +	fail.

Do we expect readers to truly understand what is to "switch to branch"
without explanation?  IOW, I am undecided if the lost "To prepare for
working on" is a good thing.

Usually with "changes on _<branch>_", people mean quite a different
thing from what the above paragraph refers to.

Imagine that you are on a branch that you forked from 'main' some
time ago, built a handful of commits, among which there may be ones
that touch file F.  You further have local modification to file F.
Now you want to switch to another branch.  That branch, since it
forked from 'main', never touched F.  Your local changes do not
conflict with "the changes on branch" (there is no changes on branch
to conflict with your work, as F stayed the same).

To improve, "with the changes on _<branch>_" should be phrased more like
"with the differences between the current state and that of the
_<branch>_" or something.

>  +
>  If _<branch>_ is not found but there does exist a tracking branch in
>  exactly one remote (call it _<remote>_) with a matching name and
> @@ -44,10 +45,9 @@ exactly one remote (call it _<remote>_) with a matching name and
>  $ git checkout -b <branch> --track <remote>/<branch>
>  ------------
>  +
> -You could omit _<branch>_, in which case the command degenerates to
> -"check out the current branch", which is a glorified no-op with
> -rather expensive side-effects to show only the tracking information,
> -if it exists, for the current branch.
> +Running `git checkout` without specifying a branch will output the
> +tracking information, if it exists, for the current branch, but it's
> +slower than getting the same information from `git status`.

I do not think "glorified no-op" is a reference to "status".  At least,
when I wrote it, I didn't mean it that way to compare this glorified
no-op with "git status" [*].  It is a reference to "even though you are
invoking the 'checkout' command, you are not checking out anything."
The side effect is to see the tracking information, which is "rather
expensive side-effects"---compared to doing nothing, anything is
expensive ;-).

I strongly suspect that running "git status" is much more costly than
"git checkout", simply because the former has to do a lot more than just
peeking the tracking information; it internally runs diff between HEAD
and the index, and between the index and the working tree, and it also
has to find and list untracked paths.  Both commands compute the
tracking info by calling the same remote.c::format_tracking_info()
function.

Other than these minor points, the new text seems a definite
improvement.


[References]

 * https://lore.kernel.org/git/7vk3shm5d5.fsf@alter.siamese.dyndns.org/
   is where the "glorified no-op" came from.

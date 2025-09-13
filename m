Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E94F212D7C
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757796980; cv=none; b=EfbdzB68218hye7n/e1OnjI1Mv6dKf6EEBgYZIDyrwWhttjPQ8NFebj/B9fDnATFPbmegAFU+5Vosz6fLRhKc/vlJKoCi7NmUZ9ezYHiX7d9J2agasKqwn85dXbQ7x5zW3Z3MDgo9akahA2Jc49mgRmNOM8VbqM1WWQwt33m//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757796980; c=relaxed/simple;
	bh=U1jf13NyobGdv5MIpo2kH3paTRRfQBl57ozeN7ObrCc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nXsmxJLgdidGuStD50a+AISxv3+dlelIxs4NAyuHO9L7DtdMiVJlBmczb1HKfHn+9kj5S6ccYOSHiSeexB/L3ndXBeT+EVmc/x9Pf/SVJP3NnBS0JwA0hC28VGP86V26bXL+2MYuzO/btwuEe8wIk2mJp8K4ca2oZHA7ZueZPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gMPySf7I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O84iopzL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gMPySf7I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O84iopzL"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2DD611400078;
	Sat, 13 Sep 2025 16:56:16 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sat, 13 Sep 2025 16:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757796976;
	 x=1757883376; bh=dg3jjsqZbsq8MTmQbJhnVgNFRPcGtOLIO+XuIweJK9c=; b=
	gMPySf7IuiZ7aCEPW1XKKpznRDTBFVJo44XQ6t5RgIaLNz8MdQNbrd67NlZgOUOg
	aoyIE+0W/AmUDuMki3gNKL0st+ybma1KYFYnd8ile3scrx+aFnq7+QhK8qFWW5L7
	Qoyanu5FbdZQ6RTXn8nEPMbYNpzjCOymQRRR0t7IeelHktOvDVSW8FT4NC4kUYmv
	Gv9lJF766tkTSp1iwrodaeYCx/FbNri3u72F9RBXVFQeCiFJ7hutS1rQDZotQxVC
	naVUp0r7bsWIm3YSonvgHtFxERNpjhKmxZ9GNEq2oP+EATtZXU+9eZqhtchCMTom
	y+AjkApIGYS2ucvPLeHdyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757796976; x=
	1757883376; bh=dg3jjsqZbsq8MTmQbJhnVgNFRPcGtOLIO+XuIweJK9c=; b=O
	84iopzLXmnEMa9M+0AJ8K0vIN4kqJ5OoOXiJk0DPFWZ2CkEo0VG/XeceV69dgpr8
	fb4Ikjcq05A5BQW/AoJxG6Mnkc2DbTiLUO4QM1bnA0Twom/7jbAsg9SilDZf9shn
	/7pHa0Rujh6YhigyGlISa3KcX4CJtnWAhZ4Udv2lFqVcyFGjwozxVN4978BN9xeE
	qSbMc0TFenPvyMula6evIYjcbZZzvRRZIZQDPbgG9JnaTyC1tW9PKmCnTRG9PP5s
	T1YnutZUPneRAko+k3N3uqKkiLsTnXkv04JFiWjHTSmmOuG/g7AgGPhy+Q0qzXEd
	RrgCZjMk2N+3G1Ibie+Tg==
X-ME-Sender: <xms:b9rFaGEfFAfjr5Akb18Ujsto59b7_CkCywuhVTCqIjsgKvDCTcPa4TI>
    <xme:b9rFaHWeJGvJTZEBOUPN6SasNqzOOyPXhdImB4Ufx9Kr_ZIXras8bNogalRpsDhIa
    Fl3bs2kqQ1z7eOP5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefvdelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghgrsghrihgvlhdrshgthhgvrhgvrhesihhnrhhirgdrfhhrpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:b9rFaPo3AKMkyrxXsty9Qme55YYj6DKouNGFI56nOtyeUwmTOsKV1A>
    <xmx:b9rFaHm5E1bU-xTu5JbADlv6oDghpPWSU4116aGwzxN4nYAXB1p4eA>
    <xmx:b9rFaOjvBUD850F3wpMEJ3Yt-1dPjGahZgWhjpFoX6b5Ptt1utC8UA>
    <xmx:b9rFaHfwtDoGtyGBwJeB6aQWezyNeYCw7lTLdu9IYEms-Dx6LpDkkg>
    <xmx:cNrFaKEXFPKMkdnEWArRWbeKGKNBcJwbngTwnjsxZLzUwmqif_X90uNt>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CB8011EA006B; Sat, 13 Sep 2025 16:56:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGvZemVQfBlV
Date: Sat, 13 Sep 2025 22:55:01 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Gabriel Scherer" <gabriel.scherer@inria.fr>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <be510685-3be1-4f71-806a-6b580bb1cf21@app.fastmail.com>
In-Reply-To: <20250913141327.2775228-2-gabriel.scherer@inria.fr>
References: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
 <20250913141327.2775228-2-gabriel.scherer@inria.fr>
Subject: Re: [PATCH 1/3] checkout: provide hint when failing due to another worktree
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Unrelated: I found it confusing that my `co =3D checkout` alias did not
work with this fresh-off-the-press Advice:[1]

```
$ ./git co master
fatal: 'master' is already used by worktree at '<path>'
$ ./git checkout master
fatal: 'master' is already used by worktree at '<patch>'
hint: Use --detach to avoid this restriction,
hint: or --ignore-other-worktrees to ignore it.
hint: Disable this message with "git config set advice.branchUsedInOther=
Worktree false"
```

But it did for this older Advice (which is in my installed git(1)):

```
$ ./git co -b .. @
fatal: '..' is not a valid branch name
hint: See `man git check-ref-format`
hint: Disable this message with "git config set advice.refSyntax false"
```

It=E2=80=99s because aliases are run as a subprocess from the `git` in `=
PATH`:

```
strvec_push(&cmd.args, "git");
```

[1]: Chain of events:

1. Try to trigger the Advice in this series
2. ... but it doesn=E2=80=99t
3. Is the code wrong?
4. Wait, I=E2=80=99m using my alias (which I always use; I don=E2=80=99t=
 think about it)
5. I test with `git checkout`: it works
6. ... so aliases don=E2=80=99t work with Advice?
7. Test an existing Advice that I know about
8. ... but it does work with aliases
9.=E2=80=9315. ...

It was part of the process.  I didn=E2=80=99t *decide* to get hung up on=
 it. ;)

On Sat, Sep 13, 2025, at 16:13, Gabriel Scherer wrote:
> From: "Gabriel.Scherer" <gabriel.scherer@inria.fr>
>
> When checkout/switch fails because the target branch is already used
> by another worktree, we now hint that the user could use --detach or
> --ignore-other-worktrees.

The commit message is supposed to discuss what the code does without the
patch in the present tense.  What the patch does is in the imperative
mood.  Refer to `Documentation/SubmittingPatches`, =E2=80=9Cimperative m=
ood=E2=80=9D.

Maybe there should be a paragraph which motivates the need for an Advice
and these two in particular?  You could also concievably advise removing
the worktree. :)

> Note: this error can also happen on rebase, which unfortunately does
> not support --ignore-other-worktrees. We do not show advice in this
> case, and leave 'rebase --ignore-other-worktrees' to future work.

After reading this I thought this was not handled by this patch series.
But you add the this option to git-rebase(1) in the second patch.

=E2=80=9CFuture work=E2=80=9D suggests to me something ranging from:

=E2=80=A2 there is another patch series that deal with this; or
=E2=80=A2 there are no plans to do this (but it could be done in theory).

>
> Signed-off-by: Gabriel Scherer <gabriel.scherer@inria.fr>
> ---
>  Documentation/config/advice.adoc |  3 +++
>  advice.c                         |  1 +
>  advice.h                         |  1 +
>  branch.c                         | 13 +++++++++++--
>  branch.h                         |  4 ++++
>  builtin/checkout.c               | 12 ++++++++++--
>  6 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config/advice.adoc
> b/Documentation/config/advice.adoc
> index 257db58918..9ee64f44ea 100644
> --- a/Documentation/config/advice.adoc
> +++ b/Documentation/config/advice.adoc
> @@ -27,6 +27,9 @@ all advice messages.
>  		Shown when a fetch refspec for multiple remotes maps to
>  		the same remote-tracking branch namespace and causes branch
>  		tracking set-up to fail.
> +	branchUsedInOtherWorktree::
> +		Shown when the user attemps to switch to a branch
> +		that is already checked out in another worktree.

This maintains sort-order which is good.  It is also consistent in all
points with 95c987e6fad (advice: make all entries stylistically
consistent, 2024-03-05) for what it=E2=80=99s worth.

I also think the wording/formulation is great.

>  	checkoutAmbiguousRemoteBranchName::
>  		Shown when the argument to
>  		linkgit:git-checkout[1] and linkgit:git-switch[1]
> diff --git a/advice.c b/advice.c
> index e5f0ff8449..5c9b763472 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -50,6 +50,7 @@ static struct {
>  	[ADVICE_AMBIGUOUS_FETCH_REFSPEC]		=3D { "ambiguousFetchRefspec" },
>  	[ADVICE_AM_WORK_DIR] 				=3D { "amWorkDir" },
>  	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	=3D { "checkoutAmbig=
uousRemoteBranchName" },
> +	[ADVICE_BRANCH_USED_IN_OTHER_WORKTREE]		=3D { "branchUsedInOtherWork=
tree" },

This too looks like it should be in sort order.  If so you are inserting
at the wrong place.

>  	[ADVICE_COMMIT_BEFORE_MERGE]			=3D { "commitBeforeMerge" },
>  	[ADVICE_DEFAULT_BRANCH_NAME]			=3D { "defaultBranchName" },
>  	[ADVICE_DETACHED_HEAD]				=3D { "detachedHead" },
> diff --git a/advice.h b/advice.h
> index 727dcecf4a..6b11df945b 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -16,6 +16,7 @@ enum advice_type {
>  	ADVICE_ADD_IGNORED_FILE,
>  	ADVICE_AMBIGUOUS_FETCH_REFSPEC,
>  	ADVICE_AM_WORK_DIR,
> +	ADVICE_BRANCH_USED_IN_OTHER_WORKTREE,

Correct sort order (if there is one).

>  	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
>  	ADVICE_COMMIT_BEFORE_MERGE,
>  	ADVICE_DEFAULT_BRANCH_NAME,
> diff --git a/branch.c b/branch.c
> index 26be358347..76aa2cbf44 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -844,7 +844,7 @@ void remove_branch_state(struct repository *r, int
> verbose)
>  	remove_merge_branch_state(r);
>  }
>[snip diff]
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index f9453473fe..e4b78f4a05 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1582,8 +1582,16 @@ static void
> die_if_switching_to_a_branch_in_use(struct checkout_opts *opts,
>  		return;
>  	head_ref =3D refs_resolve_refdup(get_main_ref_store(the_repository),
>  				       "HEAD", 0, NULL, &flags);
> -	if (head_ref && (!(flags & REF_ISSYMREF) || strcmp(head_ref,
> full_ref)))
> -		die_if_checked_out(full_ref, 1);
> +	if (head_ref && (!(flags & REF_ISSYMREF) || strcmp(head_ref,
> full_ref))) {
> +		int code =3D die_message_if_checked_out(full_ref, 1);
> +		if (code) {
> +			advise_if_enabled(
> +				ADVICE_BRANCH_USED_IN_OTHER_WORKTREE,
> +				_("Use --detach to avoid this restriction,\n"
> +				"or --ignore-other-worktrees to ignore it."));

I don=E2=80=99t know if `--detach` will =E2=80=9Cavoid=E2=80=9D the rest=
riction.  (In fact
`--ignore-other-worktrees` might be the one that *avoids* it (turns it
off)?)

Technically the only point of being-on-a-branch is to be able to advance
it.  You know that.  But does the advice-receiver?  Because they might
use the hint to get what they want immediately.  Then later wonder why
all the work they did on the branch =E2=80=9Chad no effect=E2=80=9D.

> +			exit(code);
> +		}
> +	}
>  	free(head_ref);
>  }
>
> --
> 2.51.0

No updates to tests were covered in another email.

--=20
Kristoffer Haugsbakk

Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32A31FECD
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301110; cv=none; b=d6E3s+OLRIqmUR3hkjGjOOgzqpfHOj1sKOnCzhehfn27Rt3oNjMFfC2GA+MQoT0Pg7y6YqtkX8aaMqprAuSFMONPn21VrqhfkYSX8OM3P95KQFl2cENfW5WLZ9kKgWTaBy9HqsdkePypEdNYgdrAaAxQ+jt6xfifK1RJgPOtS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301110; c=relaxed/simple;
	bh=F3dYpXDyi/QOuVUUgC5Nhlra5OJ+GKTk8/9TMCi3BhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VYMlhXw7m/PsPgEyOnMxgouy10BKhPx2SvvI5P687WqaM1qybob5PaAYgWnwcrH5zDgbWB/zvozgERlFhwElRvTI3TYMtlZgvjm0PIMruHBjIXbdiuZqC7WzZYHmaNlT1WT/3LfLmjBzU7/D48UJN1z6i0kwbLmJt5k7Qnw8qQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K+DFlBTD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VlnQGcBY; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K+DFlBTD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VlnQGcBY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 589F2EC0179;
	Fri, 19 Sep 2025 12:58:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 19 Sep 2025 12:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758301107; x=1758387507; bh=YvgIyG0fcY
	EUURVstGJ8AH484F76Nx/Gw8t98+cnCAw=; b=K+DFlBTDPmRMmRokBuFufUT0jk
	UQZh3TGDfjJtwo4c8ZpeMkg3bJr6Wo5QPSVGkIkvILobFLTY0TgaFq28btoiIQY8
	c/MjiZf/eTNBs3UhOHgTVCFGgv8y79LOxa3zOYd4OGJlsytI8ZEMa1KQxZnfZD0+
	GtNbx6otfKBFQrA9OsD5iTXBsvxDFdq/GOpiMq8l9mYL77KWp7M8D2YW2AAhNnHN
	c5HDKgQhJnsABFKVmBViMT795WV8hKx3yEfr95ZPEFhPlLSCmyF1wVmnIIMigVjx
	i0uWTHUKyIfS0ZiH31rC/HLgDteh435/RO80UmAx7ef4F6k84rd5NpsYcrqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758301107; x=1758387507; bh=YvgIyG0fcYEUURVstGJ8AH484F76Nx/Gw8t
	98+cnCAw=; b=VlnQGcBYVqoc/X1YWTrzpRx7I3gL0rhwXxcZfQP2W/xTNy+bJ/i
	woZawU4fztL32wPmJT03mrERG8FuC8FyAcIpkec3F8026QSuI4gxo1W9mg0Mb1JH
	M5Q0s0dHAZ/WhuwDBTGKM39mEBec1D9i3u75xbpjBEvSf3FfkFD9Wo2jWS3N4Wex
	SJ2MYd+S4mlG8AN9a/ITqs7W6H2znv3uPH1VPN5eiZRNbfPO/MdKEugkniUB6+Bf
	roeH53LZ7PuKRaUW2fTM7QVSWzOXZJGy2e8KYo00g4zk9k7UD/Cz8QTQCM/dSHwX
	rd1UxVRpByj7d2VEyQ6lkH+ZaTCObrD9IPQ==
X-ME-Sender: <xms:sovNaFt2EE5TC16WsPoz5X9kq0DHu-5rt-5p09c46xHgMX8yStuXpQ>
    <xme:sovNaJ-5TrBO1lQZZ9eHImPGc7hPteS5klGYWESCNYFDn-ALTr5cIkaXdLOVjQ2xG
    9DGvI9bkXMzpazSpg>
X-ME-Received: <xmr:sovNaPMMf1JJOmUAgB2IhTeZ1j_Z8BGXatAL3lSbVioBba3MFM5V28xmCAdDvmjo2rHRIGVSVOOLil1LjkbUU1BpYRhtRieqOpv6-vQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegleejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejueekleeghedtgeehvdfhfeevgedttdeigffhveegtdehheegfffgkeffleek
    ieenucffohhmrghinhepshhtrghshhdrtgifpdhrvghvihhsihhonhdrtgifnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhrtghpthhtoheprghpvgesrghpvgeftddttddrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:s4vNaHGS1CQ2B-1pWWB8EzAudyLpqtRsDJWHPzZgL9qMLDa6uxMf6g>
    <xmx:s4vNaNQ5PKzXXxcLUicUOcb0wlEgEzi4na5z7vX_hOns_xRnL2wdEQ>
    <xmx:s4vNaEtfQu8v1Tfop_9OU_nH_6w52u1uCH9cLI7LQFqcL35ec1qnRA>
    <xmx:s4vNaFI2dVsEReVXC0QrFooK9ULGF4sP316D87f3hX1PFp6tu-ZNuA>
    <xmx:s4vNaO9pjg2XkE5h-m2hQvZZ7g5055N5fa4FVQ7qxgIbLlsykfxM8cVK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 12:58:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Lauri Niskanen" <ape@ape3000.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt" <ps@pks.im>
Subject: Re: [BUG] git stash show -p with invalid option aborts with
 double-free in show_stash() (strvec_clear)
In-Reply-To: <xmqq4isy77qr.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	19 Sep 2025 09:00:12 -0700")
References: <CAMCKZdV+ASXAhYXaTdtB=7YZprCxFUjwEsqQP7i_ccOwx8Lo6Q@mail.gmail.com>
	<1321ff39-6f09-426a-aa75-939ef4e1ad93@app.fastmail.com>
	<xmqq4isy77qr.fsf@gitster.g>
Date: Fri, 19 Sep 2025 09:58:25 -0700
Message-ID: <xmqqldma5qha.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> So there are two ways to fix this.
>
> The easier, more performant, and closer to the original design
> around the revisions API is to do this:
>
> diff --git c/builtin/stash.c w/builtin/stash.c
> index f5ddee5c7f..b6312b1b70 100644
> --- c/builtin/stash.c
> +++ w/builtin/stash.c
> @@ -1016,6 +1016,8 @@ static int show_stash(int argc, const char **argv, const char *prefix,
>  	}
>  
>  	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, NULL);
> +	for (i = argc; i < revision_args.nr; i++)
> +		revision_args.v[i] = NULL;
>  	if (argc > 1)
>  		goto usage;
>  	if (!rev.diffopt.output_format) {
>
> A less performant but may in the longer term safer alternative is to
> change the caller-callee contract around setup_revisions() so that
> the later "unused" slots in the argv array is NULLed before
> returning to the caller, i.e. instead of leaving
>
>     .v = { "show", "--no-such-option", "--no-such-option", NULL }
>
> in the revision_args.v[] array, teach setup_revisions() to leave
>
>     .v = { "show", "--no-such-option", NULL, NULL }
>
> there (again, we cannot do anything about .nr that is only available
> to the caller).

For completeness, here is how the other approach may look like, but
I have made my share of off-by-one mistakes all over the place over
the ears, so somebody else needs to lend an eyeball and check it for
sanity.

----- >8 -----
Subject: revisions: do not leave duplicated cruft from setup_revisions()

The API contract between setup_revisions() and its callers is that
the function gets <argc, argv[]> parameters, parses what it can
recognise, and leaves the remainder in argv[] (shifting them to the
head, and return the number of arguments left.  The caller then is
supposed to look at only the early part of argv[] it passed to the
function, up to the argc returned by the function.

Because by contract the caller is not supposed to touch the
remainder of the original argv[], the function left them intact.  If
the incoming parameter were

    argc = 3, argv[] = { "A", "-p", "--unknown", NULL }

and only "-p" is what the function understands, the function would
return

    argc = 2, argv[] = { "A", "--unknown", <unspecified>, <unspecified> }

to the caller, and it is fine as long as the caller would not look
beyond what it is allowed to see.  In practice, these <unspecified>
slots has the original pointer given by the caller, which meant that
the same instance of string "--unknown" appears at argv[1] as it
got copied from argv[2], and argv[2] is not cleared.

Recently however this bit us when the <argc, argv[]> pair is
prepared in a strvec instance.  When trying to clear the strvec
that was passed to setup_revisions(), because some later array
elements are duplicates of earlier elements, strvec_clear() ended up
freeing the same string twice X-<.

We could fix individual callers (in this particular case, letting
strvec_clear() touch the original array .v[] beyond the updated argc
returned by setup_revisions() is a bug in the caller), but I see no
good reason to return argv[] array after modifying it without
cleaning up the later slots (other than the fact that the callee
saves a few cycles because it does not have to bother cleaning array
slots that no caller is supposed to touch, that is).

Teach the function to assign NULLs to the slot the caller is not
supposed to see to help avoiding this class of bugs in the future.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c       | 6 ++++++
 t/t3903-stash.sh | 5 +++++
 2 files changed, 11 insertions(+)

diff --git c/revision.c w/revision.c
index 6ba8f67054..93948e7dc6 100644
--- c/revision.c
+++ w/revision.c
@@ -3174,6 +3174,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		revs->show_notes_given = 1;
 	}
 
+	/*
+	 * NULL out the leftover args we did not understand, which has
+	 * shallow copies in earlier slots in the array.
+	 */
+	while (left < argc--)
+		argv[argc] = NULL;
 	return left;
 }
 
diff --git c/t/t3903-stash.sh w/t/t3903-stash.sh
index 0bb4648e36..dd70deb3b3 100755
--- c/t/t3903-stash.sh
+++ w/t/t3903-stash.sh
@@ -69,6 +69,11 @@ test_expect_success 'stash some dirty working directory' '
 	setup_stash
 '
 
+test_expect_success 'controlled error return on unrecognized option' '
+	test_expect_code 129 git stash show -p --no-such 2>usage &&
+	grep -e "^usage: git stash show" usage
+'
+
 cat >expect <<EOF
 diff --git a/file b/file
 index 0cfbf08..00750ed 100644

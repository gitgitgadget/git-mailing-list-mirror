Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A5854781
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791679157; cv=none; b=TFwmPEFvepDIndmr/OcXTAilCNADefahyUOBLF0Gn3Sc9JR4XBMwFV6Dx5euuTIcKNSWaxKMZwWHqAPETW3EImOTYZ6+Ub6eRb+iuduYvo3EUZ43VoPVwbDGXUr2+IYRLV17bBwy+iTNuNb1wLiweiUTNX5GU7f5UCVhrAJ/fCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791679157; c=relaxed/simple;
	bh=QqRagf0wyXmehuErfp/JSggyD28G6LBs4TGLs+8aLgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPFYO/Z9+K6dxG5a6H4gBV9AQULdFqu6jgJmb4WxeOUi1jYBFEaYkDZNxWvKuBiRuzGYKO9unRKtITPJIWTo1VL5fuEYnw7I/ulbdJdcs2Zuz9EH4mtoo8itW3spN+FVF/q04axfesUcDAgXBVHRwluHzx3dR4T0sXjsehFupzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jmZXd7LZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ui4Ul2mk; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jmZXd7LZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ui4Ul2mk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D68CD1D000B6
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 20:39:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 10 Oct 2026 20:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791679154; x=1791765554; bh=e0QSS/EyVv
	0rXxs+YyvUPMIdOFTfSr/Y/eh+Toti3go=; b=jmZXd7LZokpUup+KZYDgpU4alW
	S12wo37vyodKkADNO1rrmSNpKV0jCCGy4O2I0WH5SEZVW8AY5qUXZ+DhwRTjLOnq
	gND78H0BNZUBfgNIs5KPbmnxnzU7G5UucrvXdpEv9yT9AacYXIEi9a9PPeBZz+RT
	Fwkjg5hY4+pnE7z5gEanTe6aS2vcizu3RzYdse+NGi8oJU5QIqMcGyVqoDMqYJXu
	NgwUNlO1cTUKYnulUylYQmXsc+Ueo/GvqPORimA+r3BEleJs17jgDOlaOMY4JB1b
	0g98DQqnyYwRmbuf2ij2i/jhwdbnIp5gapEBHMzJ2V7qx6H699hHljvRH2/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791679154; x=1791765554; bh=e0QSS/EyVv0rXxs+YyvUPMIdOFTfSr/Y/eh
	+Toti3go=; b=Ui4Ul2mkLXD9UpksVT1J1PFR6Y8eOnwEDL+yWL3XvGOi1Pu6mUK
	o6aHeI86x3jiGzp4ySFH6MIPg3+R6Hp09IgHg83acgDKw25J6h6bOfkHY4YsTvAf
	8RE+m8tHYgjnX2Pq7m6asSwywBg4nBp+qc0JiLMnuKGIbqaE3eURbCdBh587BMt1
	8luLst0OlVib0wHDh7rSz8DefB55cSnatopAtRXUut7OuYW0SQbHPwttwdPVQgIl
	/wNc4nTwCq5OxNdf8d3BVVNcc6B7qVWv8onV6rRq1HMh6bId/OPLbgbwkUPqFqTP
	NGRi0ZDP4dnkKv6wlzCrHgtGZy8ELR+7buA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791679154; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:nzccmek9tNvMCEP8TQIOXcRuS+scXw1+FAI0N3KTPSEUCK2
	QFZpTxq9+ZGqlylmBXmZdkLicM7EhXECJ+pJnz1RHKIfjOUFw2VhD72eWLCagCaw
	TEK64m3ZAmTAVzbBSDR5O2lIaX47YNhi775rfUXbsk4tnmAsjd9bqDxKSdNZtuGa
	SywxXOaGqtkSPTAjEJKsttbqDKHIb85iEE5h1aHz6+kd4gLqMCUJX05iVJoGMvFq
	vbCwHYa4nUBipju8Xr0ha1411bmuS11d2VrsaNViFYyiOybovrq2UTsF+ZJnXCcE
	78K0HRkKty4SKQzagAzzWn/xIJ+DDEz2AYqFFAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jzTo27p4YSBFq3HT+jFjlXVOd5UofmA0f+ByB0jufW8=:QqRagf0wyXmehuErfp/JSggyD28G6LBs4TGLs+8aLgg=;
X-ME-Sender: <xms:sdrKamj6S_1UOkTOM78k94GClQtW70I1y2ncuyEA1ucA7Si8ZJpAFQ>
    <xme:sdrKant84rLHBJ3_7rLaavwLiDpo8l7A7nxE2WP4d-9i_T-7t1E7K61skanSkRzF8
    2tRHElLo4uuK_nqvs00hbAYBbHQZKLt8QXHsPrJQBy4-SWG9Cvu7PE>
X-ME-Received: <xmr:sdrKasRWXlmn06g8YIZyFVHMf8DFCbE2M7WCSVEiDzw8uru9uZb65jgbJFaHCjXrCymCvxW0XRCCeozMZffhcjfcofp2Or1YXaUd>
X-ME-Proxy-Cause: dmFkZTF0ICx6T3rcKGvQ1tPkjS9PEltycn3Q6+6TOknjvABu31/5Emx61Bom9zybgQ9wFp
    Iho2PUGpfTEJvH6Z4vT36AZL+Mm0lemX7grxjyo+TvwF74cFFZEyebSVttGfZ8+HJtdt9f
    mZmKwqOil55RXv+eygxMvAxmJuczozrAg/ObcOyt58Tx3bIUjYCseeQramKquLa0CoxKRO
    dNHxtjb1fzDdTRf0rSneDkcekJouqGoa7pu3sXDZlhtOKAIugwT7emc33kfz34nd63wOp2
    lFsiuOKC7+JNmrpcXi4CeLPaHWuICFhE5LhQ8IrjjSj8GFWmNZsjlM1JsH4YcESLO9o5jz
    eYv5fbU7kwyisURS0ghRPBGyWpEXq7qHeDDvwYrg1DWt0brNGlMIwHPfFlbcNJ4JnnGPYi
    TdSWmk6VFE8wF7vB0/IDSl7M06PwCjzvgTvztqua40HF5O9Yi8021wtk+CRwuX1Anb1jhH
    i9EQKZEyXp8ENQCaSNv4hyOP3Vcq9yhE8CkKdX1qSb2NjgA7e4AII/+YOHUpbIP7/voOAH
    HpJubnqq6+j9T1DRaoA4sFhpPCXEIHD9c5LxCdpxbevQUQgSCvZwMQq3L8OwwBKJe2qCK2
    Ai/ej829nvqVqBlh3fGtMIKE5rVepSMtr+YEvHgNRS/5X8rm4Ekosm8M0v+A
X-ME-Proxy: <xmx:sdrKaj1pHBZS14ww9m8N3eUZLw8ki6TF1YmpuiSxDr89Fx4kL-rfKw>
    <xmx:sdrKapv4u05YFiF-f_PUxHpGZEKdl-j27-GFPL0-kAhZpm3EK7A0OA>
    <xmx:sdrKahgXsY61M6jTgEzYKEQsb6yIBnZdtDDIS42n_JHqenxaK21YFw>
    <xmx:sdrKai8j04mAeRfz93LPFnawmolyNn736fE0zSBcKRyonsJN44MFuw>
    <xmx:strKakv7Y_0iM62AUB89G4VAMi89wbZ5sk71I-E8vx84D_PbNMETGHZ1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Oct 2026 20:39:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Phillip Wood <phillip.wood123@gmail.com>,
  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v7 1/2] rerere: wait for MERGE_RR.lock before giving up
In-Reply-To: <3dc3d02f12a3118ac9e270c19960815f6b8170cb.1791627204.git.gitgitgadget@gmail.com>
	(Thomas Bachem via GitGitGadget's message of "Sat, 10 Oct 2026
	10:13:23 +0000")
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v7.git.1791627204.gitgitgadget@gmail.com>
	<3dc3d02f12a3118ac9e270c19960815f6b8170cb.1791627204.git.gitgitgadget@gmail.com>
Date: Sat, 10 Oct 2026 17:39:11 -0700
Message-ID: <xmqqqzhxf4uo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
> index 3a78b5ebb1..30e827f32b 100644
> --- a/Documentation/config/rerere.adoc
> +++ b/Documentation/config/rerere.adoc
> @@ -10,3 +10,11 @@ rerere.enabled::
>  	enabled if there is an `rr-cache` directory under the
>  	`$GIT_DIR`, e.g. if "rerere" was previously used in the
>  	repository.
> +
> +rerere.lockTimeout::

$ git grep -A4 -i '^[^ ]*timeout[a-z]*:' Documentation/

tells me that all "timeout" configuration variables are measured in
milliseconds, which justifies the choice of milliseconds as the unit
for this new variable too.

    Side note.  Only one of the other ones has unit in its name
    (i.e., credentialStore.lockTimeoutMS).  We probably want to give
    it a synonym without MS suffix to make everything uniform.
    #leftoverbits

> +	The length of time, in milliseconds, to wait for the rerere
> +	lock when another process holds it, typically a background
> +	`git rerere gc`.  Value 0 means not to wait at all; -1 means
> +	to wait indefinitely.  Default is 1000 (i.e., wait for 1
> +	second).

OK.

> +     When the time is up, the command fails as it does
> +	for any other lock it cannot take.

Is it necessary to say this?  If we invent a new lock on 'foo' whose
behavior is to wait for N milliseconds and then proceed anyway,
ignoring the lock after the timer expires, we should name such a
setting differently from a simple 'fooLockTimeout'.  This would make
it easier for users to tell the difference, perhaps using
'fooLockBreakTimeout' or something similar.

In any case, we should ensure that we do not have to single out
'rerere.lockTimeout' and describe what happens after the timer
expires.  The timeout behavior on locks should be consistent.  That
may be slightly outside the scope of this topic, but since none of
the configuration variables whose names end with 'timeout' say the
above, leaving it out of this would be a good first step.  We can
leave a '#leftoverbits' task to describe the overall rule for
timeout settings for locks (i.e., "if you still cannot take the lock
after the timeout expires, you will give up and fail") in some
central place to make it clear that the same rule applies to
everyone.


> @@ -882,12 +887,19 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
>  
>  	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
>  		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
> -	if (flags & RERERE_READONLY)
> +	if (flags & RERERE_READONLY) {
>  		fd = 0;
> -	else
> -		fd = repo_hold_lock_file_for_update(r, &write_lock,
> -						    git_path_merge_rr(r),
> -						    LOCK_DIE_ON_ERROR);
> +	} else {
> +		/*
> +		 * Another process may hold the lock for a while, e.g.
> +		 * "git rerere gc" while it prunes rr-cache, so wait for
> +		 * it instead of dying right away.
> +		 */
> +		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
> +							    git_path_merge_rr(r),
> +							    LOCK_DIE_ON_ERROR,
> +							    rerere_lock_timeout_ms);
> +	}
>  	read_rr(r, merge_rr);
>  	return fd;
>  }

OK.  Very straight-forward.

> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index 7bb601e117..7bd92235dc 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -242,6 +242,59 @@ test_expect_success 'old records rest in peace' '
>  	test_path_is_missing $rr2/preimage
>  '
>  
> +test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
> +	git reset --hard &&
> +	rm -rf $rr &&
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	{
> +		( sleep 1 && rm -f .git/MERGE_RR.lock ) &
> +	} &&
> +	test_must_fail git -c rerere.lockTimeout=5000 merge first 2>err &&

The backgrounded unlocker sleeps for a second.  Is the idea that,
even in a heavily loaded CI environment, the backgrounded unlocker
will have a sufficient chance to sleep for a second and unlock while
the 5000-millisecond timeout waits for it?

> +	wait &&

Is the idea behind this 'wait' that the 'rerere.locktimeout'
implementation might break in the future and we could reach this
point before the background unlocker has finished sleeping for a
full second?  And we want to ensure it has exited before proceeding
by waiting for it ourselves.  If that is the case, perhaps a comment
is warranted after '&&', such as:

        wait && # just in case the background unlocker is still active

or something similar.

> +	test_grep ! "MERGE_RR" err &&

It is a bit unclear what error message this is looking for.
repo_hold_lock_file_for_update_timeout() is fed the path to
MERGE_RR, and eventually calls unable_to_lock_message() to format
the error message, which starts with "Unable to create '...'" to
state the path.  Is the idea that this message will contain MERGE_RR
as part of that path and we will catch it if we failed to acquire
the lock?

This deserves a short comment to clarify that we are looking for the
lack of "unable to lock" comment, if that is indeed what is
happening.  Or make the string a bit more specific, such as:

	test_grep ! "Unable to create.*MERGE_RR\.lock" err &&

or something along those line.

Should we ensure that there is no leftover pid file by removing it
before creating .git/MERGE_RR.lock, by the way?

> +	test_grep "^=======\$" $rr/preimage

The merge still has to fail (which is ensured by test_must_fail in
the earlier step) and leave the preimage of the conflicted state,
which makes sense.

I'll stop here, but you can grasp the principles used in reviewing
this test and apply them to the remaining tests to ensure they are
clearly written.

Thanks.


> +
> +test_expect_success 'merge fails once rerere.lockTimeout is up' '
> +	git reset --hard &&
> +	rm -rf $rr &&
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	test_must_fail git -c rerere.lockTimeout=0 merge first 2>err &&
> +	test_grep "Unable to create" err &&
> +	test_grep "^=======\$" a1 &&
> +	test_path_is_missing $rr/preimage
> +'
> +
> +test_expect_success 'rerere, forget, clear and gc fail on a lock they cannot take' '
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	test_must_fail git -c rerere.lockTimeout=0 rerere 2>err &&
> +	test_grep "Unable to create" err &&
> +	test_must_fail git -c rerere.lockTimeout=0 rerere forget a1 2>err &&
> +	test_grep "Unable to create" err &&
> +	test_must_fail git -c rerere.lockTimeout=0 rerere clear 2>err &&
> +	test_grep "Unable to create" err &&
> +	test_must_fail git -c rerere.lockTimeout=0 rerere gc 2>err &&
> +	test_grep "Unable to create" err
> +'
> +
> +test_expect_success 'rebase --abort fails on a lock it cannot take' '
> +	git reset --hard &&
> +	git checkout -b lock-held-abort third &&
> +	test_when_finished "git checkout third && git branch -D lock-held-abort" &&
> +	test_must_fail git rebase first &&
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	test_must_fail git -c rerere.lockTimeout=0 rebase --abort 2>err &&
> +	test_grep "Unable to create" err &&
> +	test_path_is_dir .git/rebase-merge &&
> +	rm .git/MERGE_RR.lock &&
> +	git rebase --abort &&
> +	test_path_is_missing .git/rebase-merge
> +'
> +
>  rerere_gc_custom_expiry_test () {
>  	five_days="$1" right_now="$2"
>  	test_expect_success "rerere gc with custom expiry ($five_days, $right_now)" '

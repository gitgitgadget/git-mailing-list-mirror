Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3776441619
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109725; cv=none; b=iWuxxORAHdt17tU52euXvqpgrNztnKz+bsSdI3v8Ei+fHPGeGoimRyzB6rByxwbS/cYopQtC0UwzFzH/Y/i/ssJgo7K4sQXB5M5soqilnt52B/TVj8VSJ1e0bey3cx//a/M+IvvDD8FGkhTo58uRY5kKvvIjBG4j88awh9jhIXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109725; c=relaxed/simple;
	bh=gYKFVxeIIAPCg8+HX29oBAIPEredR25yLLJDy/kNa4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR7i38ihiLFlaJbFbVqtSeZ5sg0ikp9LC+OctYUJBo2zAZeGlx8bgrHlo3IVH1qqMCUwhTlZrm9W+Sio8H1oqOWnWN+S9g/szUsAo/yUpWfoR2xp7xFZ16k5o5Rz+UdjW/18hPsjT8O7OCZPSBungsTFAoCu4yvMupqiesEBH6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mkg4TKdZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KP2Mrc3K; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mkg4TKdZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KP2Mrc3K"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 609847A00C9;
	Fri, 11 Sep 2026 02:55:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 11 Sep 2026 02:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789109713; x=1789196113; bh=RLK9SRmuQI
	5uY2/nt7fkd95Vcvxt+i07pE0skf0FFVE=; b=Mkg4TKdZOhZCuhwmKicPjS9OaC
	OeRJHgxXZHWhxzzcGBFbS3kvNt27yhTHeepH5MVr7n03hcjSyUtv/qFWEl+uvYNA
	Wrie7x+bkN0BUhcCYA1jMkJ4m0r8ER3KA0zLbqQHgakQ8MleoAGexd+T3M2OvJpu
	n7jWdranVYVtnWhVMZJZtJANsb93LyFpzjxsDh9jLTGwyMKUovp5WVZBHsow+hHb
	6yAVxa+qzN4tZB8vRTU3zMGk+yWvSCN6ZtMTdzRduJ09ppZbIZ/FEcu/2j0mEJMs
	a5RAN2y4074aqXM7jQuKV1J0hCrc6RdaTczWU1xAe+lisoZK6dUOhjNf+Bew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789109713; x=1789196113; bh=RLK9SRmuQI5uY2/nt7fkd95Vcvxt+i07pE0
	skf0FFVE=; b=KP2Mrc3Kx+HfB1zGAvqRVSdaJKJrCvuw6PHyJDTcepY83GApq+h
	CeSwhK7f/+iEAeaE/fGmZw7wEkFjyAvGBOKygjDuZLHJTHe8QGXqJhlWNNnd6Y9Q
	pWOAfUUhAEolhmJvGXmFmiua//x9xDXaqr+Du8l/mYOG+huvNeKMHFPMqjIsKI0g
	J1n51GPWCP99qyHkZnAollHWmMnoO0MUJD1u/l+uziu3kP77wBCxoNbJBxO+6NxY
	OegUruCE+/l46zCpx6iVdYSKtc+XiDcrufLVEVtJDTwvEGuySXFeKh2rlIz8GqXR
	prjBWcwzr/nJIkPiC6mAtYTZByTQ50z8K/w==
X-ME-Sender: <xms:0KWjanjk1_qxr21Qc_qUgU6wl7IaSTLJbaKcubgFqwdG9TeciDK8sQ>
    <xme:0KWjamQbnnJwua57jetEMnOWpDHD1HMjMtnsmvVRe5kgAbj3gxC5jbNF0XGJwhBGz
    3WLZyLs3rkVFLLZze8ETr6ida3iRmSoWxJA4T4xAnCvERi9yYGN2A4>
X-ME-Received: <xmr:0KWjapVdYb1TaheurLTzLs2Xql3FsWAFzrZHSpktMxiO322Oc_kfUaYcUdJiz9dSm1WdWA>
X-ME-Proxy-Cause: dmFkZTEV+JttoCnA4V+/Z0K905orRh+b6OEc7ploZuEr1gjifMLJ/49pzYntwFHzj7xSYj
    vU/5kI2IMhZ/b4moFvB0QYVaT6ZbIAa5p1q7P4gdx/uH0xpYPiIlEIeBCxddhuaDlvwdjX
    YJiwg1i4iFMXQ5WyG1dKxNKvHuMbk+IvSrItabIxW6TJ/1S5Nh/vFcDAekj0NSPin6SnyO
    EpzR7ggeUuUQC3x+ooYVx7WZfMbC+RjJiMYzCSXpg//6TdfsnqwGcwXRfOHFTLEnc/FE+L
    ZHvdYegDNyJ0iAA1HWiewmP74ak/72guaUxC7jvDZeIv2/FaN+ACWTlt0I+t3uKmwVPrpv
    kDWccQPVL6bJWc4dPrCK3u63K7byi69waWYbvsb1uhUWTOuR8oRXFi+e4KfbHmAOFfZnjv
    3aV0XdW19RSs9yVSjrPPfFvybOagLUVfUso5csvchhWDy05Y2Byrr2Cj2Lna1Q3ikqVa+/
    0SxtJCGkWwCt4hp6v5cBf3GsgC/aqASxtpV5j9Q7Q9WUFlZlGrZ7Vedtoz+ZUwi8J3prm+
    rlMpQmckhi1IfRq2DKpe2F5MTzPaphBdHOa8EhbCi4bC55B1y3OL8Vv6DVsSWVlnuhRdh/
    XGXaxn7Mw4RbpAwpKd8e+Mzaa+j3QMmNnfsI5xeSi+60xMDEZlVHouIzc+Bw
X-ME-Proxy: <xmx:0KWjaqQklCZe4QdVtcpAZiQ_Dt5CpibuXbO5Ff_OpsNam75ZzonwDg>
    <xmx:0KWjajnG48waMZWJ5m8JxnjWwQV59wMKpyWVXG6yvjv5dYEhUyjUHw>
    <xmx:0KWjag78611szxBiwWni1kHkpmH0XO_BwEetwXlNUO2qkuD3vVqn4w>
    <xmx:0KWjaphBsfaaCVE6d8HtPP9Q1K3ShkIk9iwLiWHbzxmVE66RuVRT6A>
    <xmx:0aWjaml-460Qq2UE9XEbmwvyPQY-v57ChCdD2YmL-b72cmbEWUvCwKke>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 02:55:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0a330957 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 06:55:10 +0000 (UTC)
Date: Fri, 11 Sep 2026 08:55:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tyler Cipriani <tyler@tylercipriani.com>
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] push: check pushed ref for --force-if-includes
Message-ID: <aqOlx5dlprfc0bdO@pks.im>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260910230506.1631656-1-tyler@tylercipriani.com>
 <20260910230506.1631656-2-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910230506.1631656-2-tyler@tylercipriani.com>

On Thu, Sep 10, 2026 at 05:05:05PM -0600, Tyler Cipriani wrote:
> "--force-if-includes" ensures, "tip of the remote-tracking ref is
> reachable from one of the 'reflog' entries of the local branch."
> 
> But check_if_includes_upstream() uses the local per-branch reflog based
> on the destination branch rather than the branch being pushed; using
> ref->name vs. ref->peer_ref->name.

So... in a `git push origin foo:bar` we look up the reflog for "bar" and
not "foo"?

> This can cause confusing rejections or unintended data loss.
> 
> Using a command like:
> 
>     git push --force-if-includes --force-with-lease origin src:main
> 
> False rejections: when src is an up-to-date branch, but main is
> out-of-date or nonexistent, then the includes check will fail telling
> users the remote ref has been updated since the last checkout.

Hm. "up-to-date branch" in relation to what? You mean if we had commits
A, B and C, with C being the most recent commit, then "src" points to C
and "main" points to B?

> Data loss: when src is an orphan/out-dated branch, but main is
> up-to-date, then the if-includes check will allow the push, clobbering
> the remote main.

Right, here "src" would point to B and "main" would point to C.

> Find local reflog using ref->peer_ref. When using a refspec like
> HEAD:refs/heads/main, we resolve HEAD. If HEAD is a branch, use that
> branch's reflog.
> 
> But if HEAD does not resolve to a branch (i.e. a detached HEAD), then we
> reject the push. HEAD's reflog is too broad to tell us if the history
> being pushed includes the tip of the remote. Rejecting a detached HEAD
> already happens today (if the same-named local branch lacks the remote
> tip); now the detached HEAD state is explicitly rejected.

Makes sense.

> Skip deletions:
> 
>     git push --force-if-includes --force-with-lease origin :main
> 
> ref->deletion is set after apply_push_cas (which triggers
> check_if_includes_upstream). The ref->peer_ref name is "(delete)".
> Instead check with is_null_oid to detect and allow deletion.

This part feels a bit off to me. Deletions are the most risky operation
that we can do, so why would we want to just blindly allow them? There
may be good reasons for this, but if so those should be documented as
part of the commit message. It would probably even be sufficient to say
"it has worked this way before, and we don't want to break that case".

> diff --git a/remote.c b/remote.c
> index 00723b385e..326af76eeb 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2806,7 +2806,29 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
>   */
>  static void check_if_includes_upstream(struct ref *remote)
>  {
> -	struct ref *local = get_local_ref(remote->name);
> +	struct ref *local;
> +	const char *name;
> +	int flag;
> +
> +	if (!remote->peer_ref)
> +		return;
> +
> +	/* A deletion has no local history to check against. */
> +	if (is_null_oid(&remote->peer_ref->new_oid))
> +		return;
> +
> +	name = remote->peer_ref->name;
> +	if (!strcmp(name, "HEAD")) {
> +		name = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> +					       "HEAD", 0, NULL, &flag);

Shouldn't we pass `RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE` here?
Otherwise, the function will return "HEAD" even if it could not be
resolved, and we don't want to recursively resolve symrefs, either.

Also, is it sufficient to single out "HEAD" here? It could for example
be that the user passes "HEAD~", an object ID or really any other
revision, and these should probably not be considered reachable, either,
right?

Maybe we should instead verify whether this names a local reference and,
if so, resolve potential symrefs to their target.

> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index cba26a872d..0c02151747 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -396,4 +396,69 @@ test_expect_success '"--force-if-includes" should allow deletes' '
>  	)
>  '
>  
> +test_expect_success '"--force-if-includes" should allow forced update when using differently named branches' '
> +	setup_src_dup_dst &&
> +	test_when_finished "rm -fr dst src dup" &&
> +	(
> +		cd src &&
> +		git fetch &&
> +		git switch -c newbranch origin/main &&
> +		git rebase HEAD --onto HEAD^ &&
> +		git push --force-if-includes --force-with-lease origin newbranch:main
> +	)
> +'

Nit: missing empty line between these two tests.

Patrick

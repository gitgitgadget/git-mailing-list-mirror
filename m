Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D591D432D
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792130217; cv=none; b=AA6tW3jQQhGQZD4tIklsJRra3TfoXtnZHmGEwYb9dzVWa/a/g7FiRUZjf0xxoSYu5xu5uiwwcq9SAPwDK9TOdsAOwfhfUlLrT3MRr+g8TW2q75XvFpQUUBpmI5WQrdgWQOSSvzJ6fL0y+IIaKlMXu9pbYYKSgmYc5Y7IRX0lm9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792130217; c=relaxed/simple;
	bh=iTK9caZIAZF4iKkmIm/RVwba+PMXNoi2gYvhjLtm9bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tamvHZhR1TIxAB1MB1x9+47UKqrJu133Eb5niwLUVtw6xONGjaRkdJPg1KBppdzmWLWugNnrDhKZVIATJnVd5xGFcUDFXXjXPB6b64Hyl1vTE/PeThqGC2+of6vt3kT58iNzCJr5hMFX08bnPN/G7K8Ph1ds2gplS7YchVKDLb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=olqkIG6N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xlnYvLEy; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="olqkIG6N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xlnYvLEy"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 832A7EC010E
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 01:56:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 16 Oct 2026 01:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792130214; x=1792216614; bh=Vm1vdCc5TP
	kuz5EtH4Di4lLyD2vjWYXfrJQNxZxOMC8=; b=olqkIG6N+ly6gBDcOXofd2Y+Np
	9pO8hKVgzTjr7nfiiKQRtYo6yXKvwMY79gYkEgGvLYFO9Q+owuhHHw01dHp3Xgrn
	QG2a/+RaVL0cwqp5PBuQhvxxZHBz/Sq/ptMU8M+cZVVFIjTSaCBLbiEXS8g9GVjw
	9NpviexztpDReU3V2dI0nNU/Tgc97YKDEOTYyC29QTM8Ja9upSyKw8Yjg4HmN9i+
	Nxx70bhLCAlwBxicOL37nmLzlFdqNbJddTz/tEep8Sjbk5kr+u3w18jWDyxomWAd
	dqQejqEQn87+7EHgP8VPEMqPA+Qyqqnnsf/1Z4fjzx1KoNCd7TvBLUNim/FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792130214; x=1792216614; bh=Vm1vdCc5TPkuz5EtH4Di4lLyD2vjWYXfrJQ
	NxZxOMC8=; b=xlnYvLEyn3rAfsqrPKAof28wUgR5f/afKNp90/hp/sW0P4EL+Qp
	0rht1z3y6XGcqJ3XRGFecHFfb6UVetwrXaV/TSgX/86/sR6szYL8aBoywHSOnlO9
	ccfEOo8zgynkn0CDdK+4wY9rC6BbeEmvmz491PkWSsgHZzA7NCtBOHKeL4zk/lIp
	b/d9ZrJj7XDNj5UbXVduHYV1bZpDMNC6UQ3Hz+mMe+7bkmoc5y46vQMH6Fbyve+L
	SqufoqSINYHVRqxn3neKwthODj1appFlURiI2RGIvd3HsdTXcFhyO6pFEd75+CgO
	+/8hTwxT4QNIzrb67FmJS7zuLpxSpm3jRbw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792130214; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hHe4+8dZLLatscCNBgzrI7xr9+wI9b5qgB3xBikoL7ymMlM
	qwR9McBFmQXcycH4sIaZ7trzVv/1h++fab8aGOMhToK1T0Vp9nJV2rz3J91g0ldI
	VrB0jjCsD/ErEeIU8IQtjLCH5efmJTKKxqj9rqD9V+5lv9792yvXP6nEUK2fYcO7
	2VUIpMYXrDlTQFbh3zAiqH7zTuRJZZchFMqfmBEg8AVFF424ste6rnzt3LgEYcpi
	3BdUqPwzKiFc8pJefYYk5FgYDY4jqdlp7+zKoDcXJRoIioixpVHRL6n9lVmlxBJP
	x8GVcmCAE8D9l+I41fFnvzg2NEwpv4KlytUBvww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:uRRDB32ZS1fpsvl0FW6Ci9rf4pKIX7AZhikWBF8iOfk=:iTK9caZIAZF4iKkmIm/RVwba+PMXNoi2gYvhjLtm9bw=;
X-ME-Sender: <xms:przRauCVBvnXJys-xBCb1berionJt-Fu5sXc3PqufOmk72FkPnoGdw>
    <xme:przRamUeFTZ2fNla3LvOBsVFFg8ydvQTzCuQxe453-IGv7F2zpwmQbf00KLyh470f
    5LIhNne-fmR1q-h9ujcOAq08Lz1_7BHjebP4csgwJgDp2mPX7RAWQ>
X-ME-Received: <xmr:przRasDkqUhB835RF_mHKXjBnBdHdLlDFlgPbpUjYOV6OrfHSAAfdA>
X-ME-Proxy-Cause: dmFkZTE9e0OH8yhR6BeDvODq6afdnl/sr/ECxiZ/EOvjAlLuGg44Gyh2YZcBggtZo3Xfsc
    1nepJmO0HpIVo4S8DSVZm07g2bbe128gsGCbbk0DY9kj364fhpZaXAmTX0Y96DQyMiI0zI
    7NjLKCn8bzMWA6Bdt85lAI7kKac6MkLNHIfwq1FM7dHDOKjB1L9tfpeEzyPXR2vkBNPHw2
    iw8d9KrSSUgzhjNHrhn7QMHipK/m7se9EPMKycBCw+7bvuFPjheqhxG1ibemn0NHHjjmA5
    mnjMASOmEHoEJ8ZJhdLBldzjIgxJtXRNaqncuw4B+mHP5BjzIb1w34m1etaWn18k5Od0eg
    bQ+f6Jl2Jkn1aym1QjcniLip7f0l89SA2b1K0G8tJiiEppDEVBJbcrtm0j/3n2hk2vrvSP
    QU+wHtOwD2GjpZu0Ec4GeMqeLHa17CV1o4Pmy/rBC5X6UjtY/MT8v6rlKTKEJEiJ1fLvb8
    cgbvICgqD5+KXYCGa50ioKNYyd1uOpDog0vH6XQw4pEsWB5BeKtNdib3WfIFw229eR+eqX
    a+jk9EAfk10RBLHZgtD8aJcCIaHpwKo1gCawCMlnQwILa/helOYoX6W58RKIdd7LJTHRZ1
    NEveyFFsfiiJiaygRzM0y1M5SG1rJYytyBumU0o1s1TU+uqNAAxT/fhCfKKw
X-ME-Proxy: <xmx:przRap8zcUM-65d4DIwVLUHN6MkFEHmw5Ot9LqZtetJq17WjQzGcXQ>
    <xmx:przRajHoEmztiF_y7VbzXPdDs8nZvpt8eaYeE_pohzmiZvDCg5iIqw>
    <xmx:przRanPJAacEiKUlqNpiBsW9xRmdzZGSj8iz1zQZ4Tm5RvDnlo5kOQ>
    <xmx:przRateq1skbCdz2XA8RfsrheNyNPO63DrzGXd9xB-6FTOubduY0BA>
    <xmx:przRak-HE6jV38gKJzy0oevnvqN2oW6y0Zlk-VXRqg0-65Y3np50ZD1c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 01:56:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2489f0fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Oct 2026 05:56:51 +0000 (UTC)
Date: Fri, 16 Oct 2026 07:56:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Szymon Wilczek <swilczek.lx@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] cache-tree: do not die when the index is locked
Message-ID: <atG8oVH1otZRVtf8@pks.im>
References: <20261015214242.1196722-1-swilczek.lx@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015214242.1196722-1-swilczek.lx@gmail.com>

On Thu, Oct 15, 2026 at 11:42:42PM +0200, Szymon Wilczek wrote:
> `write_index_as_tree()` locks the index with `LOCK_DIE_ON_ERROR`, even
> though we only need the lock for the optional write-back of the updated
> cache-tree. As the comment next to `write_locked_index()` already notes,
> failing to write the index here is fine.

Giving a bit of context here would help the reader to figure out what
the function even does. Namely, it's two different things:

  - It is responsible for turning the index into a tree object.

  - And when that succeeds, it will also rewrite the index to populate
    the cache tree extension.

The first part is what must succeed, but the second part is allowed to
fail without impacting the result.

> Since 356ee4659b (sequencer: try to commit without forking 'git commit',
> 2017-11-24), `try_to_commit()` calls `write_index_as_tree()` in-process
> right after the pick has updated the index and written
> `CHERRY_PICK_HEAD`. Before that commit the `die()` happened in a `git
> commit` child process, and the sequencer stopped cleanly with its state
> saved. Now, if a background `git status` holds `index.lock` at that
> moment, we die before writing `rebase-merge/message`, and a subsequent
> `git rebase --continue` refuses to run:
> 
>     error: you have staged changes in your working tree

This is the symptom that you're trying to fix and should come first in
your message. Commit messages typically describe the problem first
(this), then explain cause of  and context around that problem (your
above information about `write_index_as_tree()`) and then finally how
you solve the problem (the next paragraph).

> diff --git a/cache-tree.c b/cache-tree.c
> index b8cbb5da22..1bea880912 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -809,11 +809,15 @@ struct tree *write_in_core_index_as_tree(struct repository *repo,
>  
>  int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
>  {
> -	int entries, was_valid;
> +	int entries, was_valid, fd;
>  	struct lock_file lock_file = LOCK_INIT;
>  	int ret;
>  
> -	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
> +	/*
> +	 * The lock only protects the cache-tree write-back below; if somebody
> +	 * else holds it, compute the tree without updating the index.
> +	 */
> +	fd = hold_lock_file_for_update(&lock_file, index_path, 0);

An alternative would be to supply a locking timeout, but given that
writing the cache tree extension is entirely optional I agree that this
here is the better fix.

> @@ -828,7 +832,7 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
>  
>  	ret = write_index_as_tree_internal(oid, index_state, was_valid, flags,
>  					   prefix);
> -	if (!ret && !was_valid) {
> +	if (!ret && !was_valid && 0 <= fd) {

Nit: This may just be me, but this reverse notation always confuses me,
and I think writing this as `fd > 0` feels more natural to many. Anyway,
I don't feel strongly about this as this may very well be subjective.

>  		write_locked_index(index_state, &lock_file, COMMIT_LOCK);
>  		/* Not being able to write is fine -- we are only interested
>  		 * in updating the cache-tree part, and if the next caller

And here we explain that it's fine if we fail writing the cache tree
extension. Makes sense.

> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> index 0964718d7f..4b7547e108 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -286,4 +286,17 @@ test_expect_success 'cache-tree is used by write-tree when valid' '
>  	test_grep ! region_enter.*cache_tree.*update trace.output
>  '
>  
> +test_expect_success 'write-tree succeeds while the index is locked' '
> +	test_when_finished "rm -f .git/index.lock" &&
> +	test_commit locked &&
> +	>uncommitted &&
> +	git add uncommitted &&
> +	>.git/index.lock &&
> +	git write-tree >actual &&
> +	test_path_is_file .git/index.lock &&
> +	rm .git/index.lock &&
> +	git write-tree >expect &&
> +	test_cmp expect actual
> +'

The test looks obviously good to me. Nice that the issue is this easy to
reproduce.

Thanks!

Patrick

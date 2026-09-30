Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0228D502560
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784197; cv=none; b=POEbpz+0YMpSdpk62NidjU+Eo2HYFppg5qB3AnaOJA+iZhJaVgbrHxYgRhiLSpU05y4SyCzbX0nhBS6L/UiCVHc4kudQlntOzfloSU+8K3nJd/IKzd4rZJRhR3fnjHk3JolG8UNlUI2ThgUgnqx+1j4x8dFzW4XKWLiUeYti9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784197; c=relaxed/simple;
	bh=EhQhYS+CoRt+5oy1BRYUJYANbg9WouwoHLTjXA9jgDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWxHlKyyQe84hTqbawr+QJKQXu1sOORfFfPqz0GjIYnq44a8REfR8vpFFYa5fV0EPZVACqHMb5gv2GMXnmBpWhC6DLIZbrgeva2siCWMtL123qbiBJPVmi4/U7FzEUYy5BPLuwfXyQJFM6UOcAoi97fQD3lcQiOJWPJsmLf+SAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L5pCf7V/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uUPS/HWF; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L5pCf7V/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uUPS/HWF"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id DE33FEC02A6;
	Wed, 30 Sep 2026 12:03:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 30 Sep 2026 12:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790784191; x=1790870591; bh=2Fr5t+NM72
	4O5oeshJIdBr52mS9y/6HKWd1QpSW2F9w=; b=L5pCf7V/lKExoHsZjQxDEZS+4t
	PYdv8VfzUEwq0Bb6ughmdsQ4QM8Mc8eqP1erv0AlL3jxZ6AuyHsJB+Jnbj5dFFLb
	a1rLUD7avKXzO9VVk56u7CjdHLFeozbSahxsbCQGc72xSS5IjjpfjCkiHOFtnmX0
	GNHJRfHzA0FvE84UXs4tWGuRdp/2guK4YVTMr4LQTZzVddrFcPSzoOS776TLmSZj
	Lq+RvYwAm457ZEdbzjrPOC/SoJLwfKjBaUnsFw6dy037m8qlHUvR81G+EYSlPKNa
	ttax++CIj243GOkyIrXBvzl1C/686x+YiV1wuIa12YTXxeYdhxqwdoXLca/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790784191; x=1790870591; bh=2Fr5t+NM724O5oeshJIdBr52mS9y/6HKWd1
	QpSW2F9w=; b=uUPS/HWFBmUkWdLlY3+jU85xfIeBfj+AgScT+pw7iR9VAQFH021
	JJKxtLyOo0tlCubmrnydm2MlrraPpB0nnjo2gbN1r9qUOQ5SFIJW6YdKNPhDVKm/
	854GqTzNzzV97dzEDVpQvqeIlgNkeJ1KospyQ1XyLl0kir8kSKYqrtHURDT1GWh4
	9QGEXbA0T1T/H1SIUtKpHRJr2xEzBnmwYdrtT/3Nwab5sZZPdCtYgXWVRO0q6Zj7
	ErvAw7Wj+noUEHVsPKzqwsLXDVgKdOoPYm10UxDXI0zW8RNEGVa/VN6851N+puuU
	cQ5vbWIYEkm+CT+bmfs/46qGbYtSzIeH7dA==
X-ME-Sender: <xms:vzK9ap7GIUCg6K6k9b_9SxVXHQKrs6zbbGT6rYvA-tnXVdHAk2IwDQ>
    <xme:vzK9auV8TXaXq32QXJPzJWWq0FysPPJHPTlvByx78uoCT1VEzZX3Qy-zFk3hKY9eQ
    fWeYDVqzH5oSJLXx3xrTdztDUpit5n1ByEEnDmvlY-K5MuHbZAioQ>
X-ME-Received: <xmr:vzK9at3zzerpPp3nuBu7F4G34wKBZKYv1fhZfLUVXGmFX65mAU6SNQ>
X-ME-Proxy-Cause: dmFkZTFgN/9YbfLZhW4QN1kBQsLKAEcNQqwK4hX8ZmP16ZeV/T1Nr1/5km2quo57j7DQ1f
    u2a09diqxFMKNNV3mlJGr2EKbfqTkiMvYcVrTmopnOQhikLyeE90QtHvoYQLOklybpphEw
    RdQecvhf/6HM1Phpt+yqNCSOIhkXoPr4aJ6RIYcUafQlHQVeJEw46px/Xjj3s4Mo4etIv2
    x7mLQTmBC0w4k3REar5oqg1qJCKHe0rM/Pe4MeYfvfF4S+FQ40Zd1CueGFClytlVv3h6EZ
    ktf2YbEDUJr7YAcYdgDF9LY2GEDyWD+rvyUjMaw//iZfo56uZh+A+0xIgQowYF6zsPa1H8
    sCcdjrIOZ3SsY+qTqE5omAj5SuywhihW9kDKxQEF/puUVQH4Rrf7/+HlOJ4TOXQ8pZ26Op
    AQIDVjMx4JCImCdkJW3xty7iskaiZzvaUoIImhsk/+kA13gIabrcf+6ZZD8iHvI41KjYVR
    Kg8psfG/qsUAaWbNwebqH13RuIuWqLEBicTtxVvLr6KuJpbpheWe4rgiOvEpQIna3eKwDl
    VdnwGb2Mp3nrve6dxjTdFcRGC0sJNjKPQ8XPTEdo+rKG94Q2E5UQUmBx79KpGUpXY/TAtt
    X3MjO9Jm2hyr0EG0V1rUjJp8kk5dVxxQ3hlhJWfouBHRzi/28BgRWR6QnQOA
X-ME-Proxy: <xmx:vzK9ar3mT2HZAkxtQCDIHSxhJNlz0VG3EQl5jBrwqS6BPwQrry-bsQ>
    <xmx:vzK9ag-I8D4hZAnF4D08Kbc-N7yVyaRciqSZGITMmBIMS0g2_lbUEA>
    <xmx:vzK9ao3pDGF4vmwybMnAvXPY3rzAHwusx-pFc8N1I1hNL4UO7xZWmA>
    <xmx:vzK9at8oI-5ZFw3JClekvuESJ0JiOmlTTYJdLF0OxXrNf2kM9aoh0w>
    <xmx:vzK9aqf-CVXawTPuq8R_Tl8ga7eF4MxMbUMBG40NNmH-rRHknPwco3_7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 12:03:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf169b46 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 16:03:09 +0000 (UTC)
Date: Wed, 30 Sep 2026 18:03:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 3/4] setup: introduce new helper
 'is_git_directory_verbose'
Message-ID: <ar0yutZ9ksSvaVmM@pks.im>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20260929102513.712181-1-kaartic.sivaraam@gmail.com>
 <20260929102513.712181-4-kaartic.sivaraam@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929102513.712181-4-kaartic.sivaraam@gmail.com>

On Tue, Sep 29, 2026 at 03:55:09PM +0530, Kaartic Sivaraam wrote:
> diff --git a/setup.c b/setup.c
> index e9a9ecda19..a0fb68f7f6 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -347,7 +347,7 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
>  	return ret;
>  }
>  
> -static int validate_headref(const char *path)
> +static int validate_headref(const char *path, struct strbuf *err)
>  {
>  	struct stat st;
>  	char buffer[256];

If only we had structured errors.

> @@ -356,14 +356,23 @@ static int validate_headref(const char *path)
>  	int fd;
>  	ssize_t len;
>  
> -	if (lstat(path, &st) < 0)
> +	if (lstat(path, &st) < 0) {
> +		if (err)
> +			strbuf_addf(err, _("could not stat HEAD at '%s'"), path);

Shouldn't this also include `strerror(errno)`? Otherwise you're still
not that much wiser what the root cause of this is.

>  		return -1;
> +	}
>  
>  	/* Make sure it is a "refs/.." symlink */
>  	if (S_ISLNK(st.st_mode)) {
>  		len = readlink(path, buffer, sizeof(buffer)-1);
>  		if (len >= 5 && !memcmp("refs/", buffer, 5))
>  			return 0;
> +		if (len == -1 && err)
> +			strbuf_addf(err, _("could not read the symlink HEAD at '%s'"),
> +				    path);

Same here, we should include `errno`. Other sites should probably be
updated, too.

> @@ -396,9 +411,71 @@ static int validate_headref(const char *path)
>  	if (get_oid_hex_any(buffer, &oid) != GIT_HASH_UNKNOWN)
>  		return 0;
>  
> +	if (err)
> +		strbuf_addf(err, _("HEAD at '%s' does not point to a valid symbolic"
> +				   " link or an object ID"), path);
> +
>  	return -1;
>  }
>  
> +/*
> + * A variant of is_git_directory that gives additional
> + * context via 'err' about why a given suspect is not
> + * a valid git repository.
> + */
> +static int is_git_directory_verbose(const char *suspect, struct strbuf *err)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +	char *objdir;
> +	int ret = 0;
> +	size_t len;
> +
> +	/* Check worktree-related signatures */
> +	strbuf_addstr(&path, suspect);
> +	strbuf_complete(&path, '/');
> +	strbuf_addstr(&path, "HEAD");
> +	if (validate_headref(path.buf, err))
> +		goto done;
> +
> +	strbuf_reset(&path);
> +	get_common_dir(&path, suspect);
> +	len = path.len;
> +
> +	/* Check non-worktree-related signatures */
> +	objdir = getenv(DB_ENVIRONMENT);
> +	if (objdir) {
> +		if (access(objdir, X_OK)) {
> +			if (err)
> +				strbuf_addf(err, _("cannot access object directory '%s'"
> +						   " set via $%s\n"), objdir, DB_ENVIRONMENT);
> +			goto done;
> +		}
> +	} else {
> +		strbuf_setlen(&path, len);
> +		strbuf_addstr(&path, "/objects");
> +		if (access(path.buf, X_OK)) {
> +			if (err)
> +				strbuf_addf(err, _("cannot access object directory '%s'"),
> +					    path.buf);
> +			goto done;
> +		}
> +	}
> +
> +	strbuf_setlen(&path, len);
> +	strbuf_addstr(&path, "/refs");
> +	if (access(path.buf, X_OK)) {
> +		if (err)
> +			strbuf_addf(err, _("cannot access refs directory '%s'"), path.buf);
> +		goto done;
> +	}
> +
> +	ret = 1;
> +done:
> +	strbuf_release(&path);
> +	return ret;
> +
> +}
> +
>  /*
>   * Test if it looks like we're at a git directory.
>   * We want to see:

It would've been helpful to move the function up in a separate commit.
Like this it's hard to see what exactly has changed.

Patrick

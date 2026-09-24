Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B6412279
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287922; cv=none; b=kkKA4sOYBsx+ZZbqKwfNFyoAd65mACqEkXAzcEhLhT6QuCdc58tSsVIJ33kfohfIaQLaWtwEPw0vQQGZuBhXcrlmBo/mawvIA90z5qgZE8ooeKxAnnrZ0UCeP3gRnlPMnOeG31H3RJ89QLYsY11qqfDVkfOPaVFUUDqfPxt30U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287922; c=relaxed/simple;
	bh=v97r6usXIUGNLt2iEPNgBV6r0CJgtjrJ9VDYq0xgLFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TF181boXag/vt5TImlSwcUkGbgYVI7SErLgr483dMp7FdCUPGsIKSXTSNye4pghntUj8ffI9jG7y/V1nXXZfGI2n6BiWCAVIHaTEuAfeGXwDP7kfRtPJJKnc8sOGEK8bZfEN5gBALFl0FEAs3xEfIpLm87UVTK1vH5kge5OvnEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WdNK7fYu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BVhIdjHz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WdNK7fYu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BVhIdjHz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 94BC6EC0190;
	Thu, 24 Sep 2026 18:11:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 24 Sep 2026 18:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790287918; x=1790374318; bh=fhHP6AYfel
	e9HfLIiAkAiRubgcES5VNoqqxsvsGdaqo=; b=WdNK7fYuDlQ3Il3Sh0UcY5T3xK
	9XAoGx496C3QGc8wyZKDaJdrXaFuyTeYK1mKawyGp34RlAyTF+tUZVNWOSD4pERP
	AJ+C+jGg1hheqqgyS6b+nCujgwjEoJR3DFZME2YMBDiN3nMRhysaaF0O2GtPMBj3
	AWGt8RUdYtTa+d6PztVy06xS0X1ZPYjd9JY9qo21tvbzQ5wAqAJfD7iygVGo0g2R
	Dak1pDcOFnFDgY6XhqaLV/K7hNLcPKzZwUHB/AVZjUZsPHzTg8TZPJWaRPVLzifJ
	y+CO8S2EGJVbC5JAkXseMobhmk/h4Fh6XXDw3SjFz0aQPFmVdh46B17vF2AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790287918; x=1790374318; bh=fhHP6AYfele9HfLIiAkAiRubgcES5VNoqqx
	svsGdaqo=; b=BVhIdjHzOzOG6j7zA2oN0mY7aWUxEuDr18ExmMuKQOV79Y31qoT
	kVjRByHm6NwG5MAXaPj3sbISPqDkW4dkEypE99180NoaTgPMvC/pq1YJfETPaVGt
	ApLZ9xU4KgXPUhSEXeKef2U1UNBWe4tHga4WJeNG3bJmNTa9rTCyQ/BnUnF35AHb
	AZTr6pP+CGBy7depH9Q8/0GuaF7esIL5aIlRfB4bepV40eK/HvyJJ+ongS+0YPk/
	fAiz9eeLFQ5wRBdYX9DKqmociVkrypamrizp+1w+XWeERMdaQIANI0QyGMmSngN0
	8FQjAdzK4huYIQTIiB10FJnr8kLhsTawEoA==
X-ME-Sender: <xms:LqC1anTrNFZkZsAVxcOLjIh8rKBL47aGTFmVoqQYRy8xMFE2nwSpYg>
    <xme:LqC1avw4MUrG-zbvua6zyo4_EKVuhYwuGtGtbcOr_ZrvSkWwhkV5Zb8JDMuwYLGiO
    s7rWW9aFV_TWCLje2G442p8xmnQmif9WuAChsSxEpnPlruphPA7G5ah>
X-ME-Received: <xmr:LqC1ah25YU4FJt6YH9JpUiJmb3wXawT-UzWm_uJTAz68MiW8oIPiDOMTd6vf4CPi2kGCkWuVriDeXqAonIK4nROMZU3GZ_nIq2G4>
X-ME-Proxy-Cause: dmFkZTGsuz0xjYQZldCG2JVJc8537B7EEt0wn02u0RlIH8/OU5cL2bUw16UzALitUUNtN1
    AZmKPKpiAPRehGk8zikDT0s1FxWk0HXOojqX1dhwv2lLrdhrKEhLnF0c/F7oSUoCWwh9Ac
    rpK7WG5lP+i5kzhSgg4CQqwUsvJZ5i0EiF/AquwAY4msSZ/+eF5lWlTC6g5Bovxk5Q0U1x
    nLoUI6n2RPRsKkEwilGbEEYPelsDTILc60Yp017xwJk2HxuLY5Y3rjO+fE6u6i1annzTF3
    +85cXrc+1j/qjPSQ2eDLLk91XDtuJ0TQaEqcBsYm9SR9qMRfcK7dHtcfbz3+7t31gtawnw
    y/ivZsICpXQ22OLui1r9l770LZ+QGscjqlVwhOAEwFwP3Xq+7r0ecf0erHZVlC1OBuoVnW
    YhBv0bRNB12oXKaQPMSDeaOTJ7PhI1tYy9jZH7hy7sdHlk/0qaVN3gMGz6byIEzHhB8r0j
    3NgFY8dxt+qzDeOr/JF7Z4F9x0fAB7k255jf/cDFUJmoak0BAIafVwNLe8bofdzsRzkRVX
    lDX64o3TosSn7HD4bnaQJ7MFBfTc/n4VS8ZFVgS/cSWJRxpUKOqoBrZcl9dBS+xngZ8fo6
    Xh1RVvPiQJKnHOoiqQUg/Wd37EbzQfnkvmF32KIn+VoQ/Kme9P7g4cmhDr5Q
X-ME-Proxy: <xmx:LqC1al7tx9EQTeq4_vWYPaJd7pHwtRol-MYxhkqhwIT3GvrXXLt2Vg>
    <xmx:LqC1asW6S_WBkR6O_MMsGEl2bRT31KEbPkMkUvHip3_I7udflkQH0Q>
    <xmx:LqC1asDRPc3TTXccFl1Rf22YApG4VAhGxvOsPd5Il7QmCu2FGy42jA>
    <xmx:LqC1aj7ir1ISit0Kl1qRnvM8JyP91llLRlLSWeNN-DUZS0Dd8RT1hA>
    <xmx:LqC1apWFv0nUdw195VY8jlOVqMhe50VU5IE_tJMYS5ux3DC9iXe5S0Ki>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 18:11:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [RFC PATCH 2/3] setup: introduce new helper
 'is_git_directory_verbose'
In-Reply-To: <20260924120502.2642141-3-kaartic.sivaraam@gmail.com> (Kaartic
	Sivaraam's message of "Thu, 24 Sep 2026 17:32:20 +0530")
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
	<20260924120502.2642141-3-kaartic.sivaraam@gmail.com>
Date: Thu, 24 Sep 2026 15:11:57 -0700
Message-ID: <xmqqcxu2z4cy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Introduce a new helper is_git_directory_verbose() as a
> counterpart to the existing is_git_directory().
>
> is_git_directory_verbose() also populates an optional
> string strbuf with reasoning around why the given suspect
> is not a valid git directory. This strbuf in turn can be
> used to improve the error reporting which is currently blunt:
>
>   fatal: not a git repository
>
> This is not helpful as the user does not get any hint about "why"
> the repository is not considered valid.
>
> Call-site(s) will be made to use this helper in a follow-up commit.
>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
>  setup.c | 152 +++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 112 insertions(+), 40 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 0d157ac254..b3b53a1cfc 100644
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
> @@ -356,14 +356,32 @@ static int validate_headref(const char *path)
>  	int fd;
>  	ssize_t len;
>  
> -	if (lstat(path, &st) < 0)
> +	if (lstat(path, &st) < 0) {
> +		if (err)
> +			strbuf_addf(
> +				err, _("could not stat HEAD at '%s'"), path
> +			);
>  		return -1;
> +	}
>  
>  	/* Make sure it is a "refs/.." symlink */
>  	if (S_ISLNK(st.st_mode)) {
>  		len = readlink(path, buffer, sizeof(buffer)-1);
>  		if (len >= 5 && !memcmp("refs/", buffer, 5))
>  			return 0;
> +		if (len == -1 && err)
> +			strbuf_addf(
> +				err,
> +				_("could not read the symlink HEAD at '%s'"),
> +				path
> +			);
> +		else if (err)
> +			strbuf_addf(
> +				err,
> +				_("HEAD is a symlink ('%s') but target"
> +				  " lives outside refs/"),
> +				path
> +			);
>  		return -1;
>  	}

All of the above (and below---ellided) look fairly funny way to
indent them.  If you are trying ot match the style used in the
existing code around the same area, I wouldn't complain, but I
didn't look beyond what is visible in the patch.

> +	}
> +	else {

Style: "} else {" go on a single line.

Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1F1A0AF0
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709099; cv=none; b=Xtlur5faoq5EdzwtlGa2Rq6SlElOxUkrfpjgoGynznGwZlItL6Vqp31b4IvpQKOWwBgyKVOuVweu8/3Ff97nWMqJAdlz2EqIleasDNQP+64hMe8fq0c146jSaBMkg3a6nrD7DV449bv4jZioARbPgDIExrO/HgPLNdXNXMI9phs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709099; c=relaxed/simple;
	bh=8l8ok+trWZ+ivqqufijIMk0Q3g/uHB8Lra6pSjygNAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdxJN4/R/fUz6dBt+vPFcx6GuC+Mq9k71imqEajRWhvPkGCVf8z37pgYysArlU7E+dSHMY0dC5qT4mm04DGyzlwJW0WxRL1WpeL0anKRHt8n6LLlJyaq3Ogv735ps/I76QUFZ0SdhsA3v9eVqKeRtxu5U9RccA/DHs/fYdYnMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=w06Y+/7O; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="w06Y+/7O"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e2772f7df9so560077b3.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 11:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729709097; x=1730313897; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=njU8drYd+TFPYaeSjvAbBSUVHI0Cs1tf2Fw9CKTEinw=;
        b=w06Y+/7ORRlbBX5ldgxTsu8+0qexP+GnnEtEt0OH1k1prZqP/L4RQ1jZdBoWRnpQhu
         nA4TYHJsxfN1yftrb26o+vbMFtWPKVDUDhFGTLPTlnuMLqphnStIkJPagKDLwmboXke9
         B90UjyuQ81G86I4WWsbxys7IqkSBvYJCcB/zY3K7ZQAS/SyEHkIsAriUPD13Uit5nFLa
         pVxveN95C0ZFMrzXfeqCRUlKPoBmtB+aDuJkL82kYKbVcK7DsOxA634FxywtVF/Jxx2d
         o958T147cF31m0liv/VJDzFd9q+VNjAvjQ5GLwTA0h8ZxDb3OmiaeGewVpAzpY5jaV9/
         YJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729709097; x=1730313897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njU8drYd+TFPYaeSjvAbBSUVHI0Cs1tf2Fw9CKTEinw=;
        b=XdH2Y5+h9+p8R+sknP2BGLx69VoVsiysJHHcSi1ae9aSy9QLEKspr5XMKKGcP4u1Jm
         RG1KfacdKHx3VWhOQyjAwFtz8SrpOE+JBtG02SVOVv1Z2z2JsE7oJ4jpzTME8L8LJSHu
         14ZhvMQbITC8YS3LqI8YWAqq9RmrnUCKdWgjS+9OHfvuP8Su/8/oWbZvCD/7Oc0ximYY
         MpMpfntEmPzib9ITz3xGJw+DgWkCnYKwHcbcdoSRnewk3l+fYJDxv177AtQBXBEjkJkZ
         QhiZlDpqDymFHDZqtYEzqZYzOxHjYDsLRIWJZkgxHbL1aXjNJDUAscFrqYsPJWgv5Vu1
         1MtA==
X-Gm-Message-State: AOJu0Yxyos8rEe0fGhy4eftD6i4ePUBY10hY3LQ8i5+O3X89904F3DwL
	ntD25LX6ZTvXUSFcCJ4MblrmAmOqNb8kn8rEQz2ddTPliqj22mT7eZ5Kho/9Xbo=
X-Google-Smtp-Source: AGHT+IFdkFdZnWYFUFrXyKEIAZLCGlCOQK1o5fQ3oWnnEYO8cIwZAPLgtwQ/l/0DLaHMCYTfdr6xSA==
X-Received: by 2002:a05:690c:38b:b0:6e3:d688:e3e9 with SMTP id 00721157ae682-6e7f0fadd6amr32044067b3.31.1729709097108;
        Wed, 23 Oct 2024 11:44:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f53b8sm16197937b3.20.2024.10.23.11.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:44:56 -0700 (PDT)
Date: Wed, 23 Oct 2024 14:44:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com
Subject: Re: [PATCH] sequencer: comment checked-out branch properly
Message-ID: <ZxlEJ+44M8z03VOj@nand.local>
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>

On Wed, Oct 23, 2024 at 07:27:58PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> `git rebase --update-ref` does not insert commands for dependent/sub-
> branches which are checked out.[1]  Instead it leaves a comment about
> that fact.  The comment char is hard-coded (#).  In turn the comment
> line gets interpreted as an invalid command when `core.commentChar`
> is in use.

Nice find. My first thought when reading was that this was a regression
from 8b311478ad (config: allow multi-byte core.commentChar, 2024-03-12).
But thinking about it for a moment that is definitely not true, as this
has probably never worked since core.commentChar was introduced, and has
nothing to do with what range of value(s) it does or doesn't support.

> † 1: 900b50c242 (rebase: add --update-refs option, 2022-07-19)
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  sequencer.c       |  5 +++--
>  t/t3400-rebase.sh | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 353d804999b..1b6fd86f70b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6382,8 +6382,9 @@ static int add_decorations_to_list(const struct commit *commit,
>  		/* If the branch is checked out, then leave a comment instead. */
>  		if ((path = branch_checked_out(decoration->name))) {
>  			item->command = TODO_COMMENT;
> -			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
> -				    decoration->name, path);
> +			strbuf_commented_addf(ctx->buf, comment_line_str,
> +					      "Ref %s checked out at '%s'\n",
> +					      decoration->name, path);

Makes sense, but the following command turns up a couple more results
even after applying:

    $ git grep -p 'strbuf_addf([^,]*, "#'
    sequencer.c=static void update_squash_message_for_fixup(struct strbuf *msg)
    sequencer.c:    strbuf_addf(&buf1, "# %s\n", _(first_commit_msg_str));
    sequencer.c:    strbuf_addf(&buf2, "# %s\n", _(skip_first_commit_msg_str));

I imagine that we would want similar treatment there as well, no?

> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 09f230eefb2..f61a717b190 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -456,4 +456,20 @@ test_expect_success 'rebase when inside worktree subdirectory' '
>  	)
>  '
>
> +test_expect_success 'git rebase --update-ref with core.commentChar and branch on worktree' '
> +	test_when_finished git branch -D base topic2 &&
> +	test_when_finished git checkout main &&
> +	test_when_finished git branch -D wt-topic &&
> +	test_when_finished git worktree remove wt-topic &&
> +	git checkout main &&
> +	git checkout -b base &&
> +	git checkout -b topic2 &&
> +	test_commit msg2 &&
> +	git worktree add wt-topic &&
> +	git checkout base &&
> +	test_commit msg3 &&
> +	git checkout topic2 &&
> +	git -c core.commentChar=% rebase --update-refs base
> +'
> +

Seems quite reasonable.

Thanks,
Taylor

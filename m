Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34321C2B3
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XUMacnsF"
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E6F9F
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:31:55 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66cfc96f475so32619316d6.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698701515; x=1699306315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjDf7HWMpZxJXw9GPdqBrE3VJK6ek/X4qLGw4arxOZA=;
        b=XUMacnsFJ+qBjwRDq9BZI1FbbCbR8jdEdfqMHsxoBxS3ay69DQpziI/00cIJmwex5F
         yE3V8iz8Ua0OvtlC+0qY+KKqM3HDQcDP7Q9wdRe8WMnB4moZJMFeTu/EaTwChYGRrrMb
         Sp1sElZ1Sp63lU49eUOf9j/wnE3FtXjU4zuHIxh50zOtUJgNV/xEqtHJAs3fcsNmFRH8
         h4BdjrWRFmuEztOc5lFSILULQo4SXgiMp5JMKf6qPiokSl+1+bVyjMRgIztsFrBMlPXy
         gH1QCUkzA8RggoSc5ZkCqLST7GTZ3C9myxn9Y0qAFMJmBUChvQ3iRb7VcQkgMD4SHiPu
         E56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698701515; x=1699306315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjDf7HWMpZxJXw9GPdqBrE3VJK6ek/X4qLGw4arxOZA=;
        b=opTlJTBMbxRLgDQJxDfG/6VKvOAUhVN+jIZnDYRapboZVn8Ph47t+kmUnGude6/knY
         GWWPnjDR1Kn4RiIybOrm31xJx58nzHDZYUgCLk3tksOk8CJ1gVWj8uvw0oU4iT//O60z
         N8NRREn782flxUfY16w50Hb7Gycfx6HkKI/hbO2Wa2SApB3rgolf2u9NFi4fUyVzh39m
         7eo5irz8RtRfKBkjnBCON83dEQG9RZ+zYFwHqw0DFcV7uKRbeGItT8GVM9UrURuqhs3N
         osQlncssRxAtp3YLL57fAa3i0xP9C7dVCVERCyLixvFadFsEcxH6mDEyUJAk2Js4+8fX
         5AnQ==
X-Gm-Message-State: AOJu0YxVE7dP0vmpXxmDSCQVYqhYxB2b42AJhyYNFtoMfOQl/tWge2Zb
	JQpM1H/tpwIEc3hKOyx8c9CN3C8Oe3xzWIMTR5Uajw==
X-Google-Smtp-Source: AGHT+IG18d04UudhBu+fJyWYkJg8/izFr0auOMhBJ0shhiySGVDhtcMOM91ptXd+1YFETtFBnqjmnA==
X-Received: by 2002:a05:6214:246b:b0:66d:1d92:c694 with SMTP id im11-20020a056214246b00b0066d1d92c694mr15767640qvb.58.1698701514874;
        Mon, 30 Oct 2023 14:31:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cs11-20020ad44c4b000000b0065b29403540sm2534383qvb.127.2023.10.30.14.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:31:54 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:31:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] commit: detect commits that exist in commit-graph
 but not in the ODB
Message-ID: <ZUAgyW+4dCcKRck8@nand.local>
References: <cover.1698060036.git.ps@pks.im>
 <0476d4855562b677ced106a4cc7788b46434cf21.1698060036.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0476d4855562b677ced106a4cc7788b46434cf21.1698060036.git.ps@pks.im>

On Mon, Oct 23, 2023 at 01:27:20PM +0200, Patrick Steinhardt wrote:
> @@ -572,8 +573,21 @@ int repo_parse_commit_internal(struct repository *r,
>  		return -1;
>  	if (item->object.parsed)
>  		return 0;
> -	if (use_commit_graph && parse_commit_in_graph(r, item))
> +	if (use_commit_graph && parse_commit_in_graph(r, item)) {
> +		static int object_paranoia = -1;
> +
> +		if (object_paranoia == -1)
> +			object_paranoia = git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);

The same note here about object_paranoia versus graph_paranoia, but
otherwise this patch looks good to me, modulo one typo below.

> @@ -842,4 +842,31 @@ test_expect_success 'stale commit cannot be parsed when given directly' '
>  	)
>  '
>
> +test_expect_success 'stale commit cannot be parsed when traversing graph' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		test_commit A &&
> +		test_commit B &&
> +		test_commit C &&
> +		git commit-graph write --reachable &&
> +
> +		# Corrupt the repository by deleting the intermittent commit

s/intermittent/intermediate

> +		# object. Commands should notice that this object is absent and
> +		# thus that the repository is corrupt even if the commit graph
> +		# exists.
> +		oid=$(git rev-parse B) &&
> +		rm .git/objects/"$(test_oid_to_path "$oid")" &&
> +
> +		# Again, we should be able to parse the commit when not
> +		# being paranoid about commit graph staleness...
> +		GIT_COMMIT_GRAPH_PARANOIA=false git rev-parse HEAD~2 &&
> +		# ... but fail when we are paranoid.
> +		test_must_fail git rev-parse HEAD~2 2>error &&
> +		grep "error: commit $oid exists in commit-graph but not in the object database" error
> +	)

Thanks,
Taylor

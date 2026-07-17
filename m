Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3436C9F4
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329545; cv=none; b=IRAo/h6jLUy/GRY0ukclFn83W4O7WzjbrjlbblaH3Bp63peS5EhYt1rMxhUhfrF6EFxrdGdUXL/Nim0Fk+pKqVt6HkkvXC8eeOKcfRuay0QrFiCXV1elQ7gAd5K+edRz+u+o/DfFV8BBVPeg092+jTIw5BIcpwgLCvbKtDjcans=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329545; c=relaxed/simple;
	bh=Gkph2zczPMnuC5a6OlZdruqkvtsCryOYJy4s3+VptJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcYoa9/xMpvWqCE2IScs569uec3B0ZCFyHyD2Sh3wXpOzy3cxY63XzSB1HKguUZC/aGYtYEpPNUAxvffLcKC2oIMiUZkzuTjsg5iPDpWAfVRRxk5EoRB6V6C6BhKICpAr7IE+tDJCmlCrNDGiA0gjymbKrblSxnf2wINGEMNiVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=U7gha3Om; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="U7gha3Om"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664b05d408bso4342812d50.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 16:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784329543; x=1784934343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kj3Df91zBbKuiMoJ1dxZ9cpjYppgS61xA7wrb6Yg/Bo=;
        b=U7gha3OmZ9GsTCZ5sMi2nRCqsrMZBkHccz62vdBVhgi8XRAGaYpA8nm+4NWoQJaQq0
         Lf3PWg6qEUiMgWHGDk+tlVHyRz3pJdptRCCNiJvGS0P3W+bdLmF46iYww2myYHQJQBVg
         NFnabhX+9ba55l4Qpj9idlfa/6bLbeDPCDFOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784329543; x=1784934343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kj3Df91zBbKuiMoJ1dxZ9cpjYppgS61xA7wrb6Yg/Bo=;
        b=CdH4keBaqxGVs5s7yrLhmJd7wWr/VCjdn/8iwzjuVrrXC7pf619rrfQYLkpYgadMX+
         M8MuEf77fUDEKBoKVIqtHtHJfv+v0N8rtz52TYae4KGB5OZmeKrKRUX4PfE7SDAGzpgE
         QQ7IyEdi9dUCUxIuHTUvOG2GphfbIQCCZeWl9yR03dxLhq2OX/Wepx5p0kAP7FF/rOhT
         YA7eSEJmisViru5kMpmDK5NMeM2s6GnyUyrEiWL++P4eMFDcKWXtft6zXipc3twvvDXM
         zrBeDH7H6/XJ/ocLpGoWEXCXCxaiP9Z1CiUH5Zdu0xW7u7RXfNNXvd/8Nn6WR4PkAieU
         FYfQ==
X-Gm-Message-State: AOJu0YzyMIJsIEvtfQ5PdV5UKPgGbSXJ544Ntrb7F9vHH2/R/RR+nzwC
	DslicVj2qZoS2KVNLT1IeFlx2v7PpfNwUCKXc8uXAyHGKtV+QlloTuFd6jCIYzP8y5hJAi+XDJ9
	wIVIl2KkCgA==
X-Gm-Gg: AfdE7cn8l/LTpo/LeG+ybABNOg5L44iWc5gHIDZrJ/zu7DHDuF+7a5hbw8oj7UYxbC2
	MawV81ZdSnS9pzfZmi06OdYxu/tlbpKNa5uWm/wsOTWJs9mjsgnk8Llgqx5hVZEFS5/Jmwq1vYO
	XMRCSIK+3W4mKitjXapWlAJjfocSTVU42ZeB1U5t5T3Y+KCo1+pCQUNL/gZoz3djeMHieuHijvY
	OMJFnnRwSeeDQieJMtx2Y/UM6xSAG+OlURq4lKY5WbaxGFyc+K16rTX14V+KJw7fyJsTCXl8MU7
	j9Q/UDIDLFsSBeDCYoXt1jszCa2tU7lmx2Yi5jUZGeG6SIDOJh6HTVpJy18S6oHZbHkxLLSpJoK
	e9prGlw12xU5N0pTOtGqAzmBHG2R5CNG8Ylzx9/Xb+rpeD5aIVTOfMMg3B1bpZNgVShEflbCEB2
	2jzxrDDznu/un0lanl5LqPXZlX3Hrp9Hi4SuAERo2//fpMo3j6NSka5+8wQBwUEZwT102uOg==
X-Received: by 2002:a05:690e:4399:b0:667:f270:93d9 with SMTP id 956f58d0204a3-6683bd82616mr954207d50.51.1784329542568;
        Fri, 17 Jul 2026 16:05:42 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6683b8cc782sm2587669d50.20.2026.07.17.16.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:05:42 -0700 (PDT)
Date: Fri, 17 Jul 2026 18:05:39 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Gusted <gusted@codeberg.org>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] last-modified: check pathspec against Bloom filter
 first
Message-ID: <alq1Q55ezuN9ZI9j@com-79390>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
 <20260717-toon-speed-up-last-modified-v1-3-410418f18614@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717-toon-speed-up-last-modified-v1-3-410418f18614@iotcl.com>

On Fri, Jul 17, 2026 at 05:47:01PM +0200, Toon Claes wrote:
> When git-last-modified(1) starts, it builds a list of all the paths
> matching the pathspec it needs to find the last modifying commit for.
> For example, every file and subdirectory listed by:
>
>     $ git last-modified -t --max-depth=0 -- src/
>
> As it resolves a commit for each path during the revision walk, it drops
> that path from the list.
>
> To avoid diffing trees for every commit, Bloom filters are used when
> available. For each remaining path, the commit's Bloom filter is checked
> to see whether the commit changed that path. The Bloom filter says
> either "no" or "maybe", and only in the latter case is the diff
> calculated.
>
> git-log(1) does this differently. It does not expand the pathspec but
> checks the Bloom filter against the pathspec itself. This way, commits
> not touching any path matching the pathspec can be discarded as a whole.
>
> Apply this same check to git-last-modified(1). In a previous commit the
> function revs_maybe_changed_in_bloom(), used by git-log(1), was made
> public. Use this as a pre-filter in git-last-modified(1). After this
> pre-filter, paths are still checked one-by-one to only find those which
> don't have a "last commit" yet.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>

> ---
>  builtin/last-modified.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index 5478182f2e..e8ee610404 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -272,6 +272,9 @@ static bool maybe_changed_path(struct last_modified *lm,
>  	if (!filter)
>  		return true;
>
> +	if (revs_maybe_changed_in_bloom(&lm->rev, filter) == 0)

Nit: please prefer 'if (!foo())' over 'if (foo() == 0)'.

> +		return false;
> +

I don't think this is safe with '--show-trees'. The original pathspec
does not cover every entry in 'lm->paths', since the function
'populate_paths_from_revs()' also adds ancestor tree entries.

This can be reproduced by adding the following to t8020:

    test_expect_success 'Bloom filter with --show-trees' '
        mkdir d &&

        test_commit base-a d/a &&
        test_commit base-b d/b &&
        test_commit touch-a d/a &&
        test_commit touch-b d/b &&

        git commit-graph write --reachable --changed-paths &&
        git -c core.commitGraph=false last-modified -t HEAD -- d/a \
            >expect &&
        git -c core.commitGraph=true last-modified -t HEAD -- d/a \
            >actual &&

        test_cmp expect actual
    '

Without the graph, 'd' is attributed to 'touch-b' and 'd/a' to 'touch-a'.
With the graph, both are attributed to 'touch-a'. The filter for
'touch-b' lacks 'd/a', so the new prefilter skips its diff even though 'd'
changed.

I think that the conditional is otherwise correct, if guarded when we
know that 'lm->show_trees' is false, like so:

    if (!lm->show_trees &&
        !revs_maybe_changed_in_bloom(&lm->rev, filter))
            return false;

The cover benchmark uses the same --show-trees plus narrow-pathspec
shape, so I think its output should be checked before interpreting the
speedup.

Thanks,
Taylor

Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142A32940D
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222762; cv=none; b=GtBA8at95IjDq5jAYaw3FEghE5XmgvWuUgGsjE2N60P7DN23VRTBIOqiBIMuN1ujgZ6th0C5GTIymnU6ZBuGWt4fDc8VKlaVyFuidIWvkgGfJtIbL/Tqcwdn0OUyGoupXYjGOVsscT8cRRzyqmwY4KIGdDQeXUQOYFpq/5PYVes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222762; c=relaxed/simple;
	bh=evGLA2qmf0195qHo4J/MOQOjWldaqXdoUwN0fHmMoFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmZ31edrCyRXzTpNY4gybWv0LlnyW5zDFrhtisqO21k5leNCyibr84shyfwiRxhHWO1PRCSQ+oDImOQTzguqTimMELEUbsUlzNOjcUHMCWvXLGSonX8ham86EkGf9uBGzLW83AYwhuzlWXTCU9n7/W0NpB6eSCJ7ia9gc+s9iEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6PA+5Qu; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6PA+5Qu"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-260f1664fdfso1418436fac.1
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723222760; x=1723827560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WMlku6qXbMWG3aUY9NFYRKQ3waUlIq5fZMFyo3qRa2I=;
        b=S6PA+5QuuIGRE0sOsqXiIulx19Y4WfKPK4myEVyJAIz4bKQx7yKJvJkcEVfIKRP1UM
         iDF4XuQjH1am16A2nUXoBn5ivqkk2OoOEShe719G9ZQPRWgXL7B5CEO1NvLhkq4xRfzJ
         88V0MES5HtuDXsJAvrftuuUcCaEx4tOkjL740gOYx1IfVAyee2W1cvg3P9D2XXDEwjvL
         Dg3U8/QIiMxfKvaWZMhfgiwXfnmvGAAtsVhYu2IzwwRO1sLK/bfKnboLlOtqU/uItEWH
         PH2dEs3pzXbIaDCkQ9Uceac1x3hMjBh5Ay5f66i01996MDR+C+2M1LRLymu2jL4nCu04
         Wk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723222760; x=1723827560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMlku6qXbMWG3aUY9NFYRKQ3waUlIq5fZMFyo3qRa2I=;
        b=cmbrYwh3W8DyEcsHlVsEtbD4Qwo07/lItkuxTf77K9NNKz5NsQoBLaGk9c4gD/1Q67
         nVhEyw5GHL59Kj617JRUBSkNBGFOMy8h3e1cK5x8SmQZoXWDDe4sjtl+dhbWCSCeSehj
         wnGOM2Gj6JG/aDgC6DZlF4AhqDwQLyUtDRF86oYWREqp3ozRjPq3IGFAXEuZ8HEifTP5
         SdjSRmy3SIVbsfDECdfOVOytijA8FZuwio6yqEWyxfILQx9HhKrJMR01NZq4/R/tmF2T
         KoPtedcCfT7BJdz4lsZz4FKUh1wWVQZCC6oCEfY2UQc+062fSCuhJeu35qN9kEZAdGJi
         pjPg==
X-Gm-Message-State: AOJu0YwZjqzm+zhuzCV84bVBPx/PgpoO4oJCqOml49LIpO67ZXaE06+F
	FJin/b/tR4stEX8srSrwdQF2vKGTPxR5BSB2AZaDPw0q4wwv7PH1YQam1g==
X-Google-Smtp-Source: AGHT+IHy9RD99Dkr4aYOgouXTHO86+s62SnbynGkH5TMQmqfrJUC34J2wG1qJUKf9r9VMP9jPKQIQQ==
X-Received: by 2002:a05:6870:46a8:b0:25d:fc34:ba6a with SMTP id 586e51a60fabf-26c62cbe04amr2595660fac.26.1723222759745;
        Fri, 09 Aug 2024 09:59:19 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-26c723040f9sm5763fac.54.2024.08.09.09.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:59:19 -0700 (PDT)
Date: Fri, 9 Aug 2024 11:58:31 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/20] path: expose `do_git_path()` as `repo_git_pathv()`
Message-ID: <xl37sjpibmamkxdmpvfy44sijseuk5doizdlbnuodnbd6pdhxj@dws5e4wdu5lg>
References: <cover.1723013714.git.ps@pks.im>
 <7ce3278f649ce70453242e5458d28c5fd54576ba.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce3278f649ce70453242e5458d28c5fd54576ba.1723013714.git.ps@pks.im>

On 24/08/07 08:56AM, Patrick Steinhardt wrote:
> We're about to move functions of the "path" subsytem that do not use a

s/subsytem/subsystem/

> `struct repository` into "path.h" as static inlined functions. This will
> require us to call `do_git_path()`, which is internal to "path.c".

So in other words, functions leveraging `the_repository` in "path.c" are
going to be moved to "path.h". Since these functions depend on
`do_git_path()`, we need to expose it. Makes sense so far.

> Expose the function as `repo_git_pathv()` to prepare for the change.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
[snip]
> +/*
> + * Print a path into the git directory of repository `repo` into the provided
> + * buffer.
> + */
> +void repo_git_pathv(const struct repository *repo,
> +		    const struct worktree *wt, struct strbuf *buf,
> +		    const char *fmt, va_list args);
> +

Out of curiousity, do we have a preferred convention for how functions
accepting `va_list` are named? Searching through the codebase, I don't
see a ton of consistency, but I have noticed examples prefixed with "v".

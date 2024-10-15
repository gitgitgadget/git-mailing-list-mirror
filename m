Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682F51581F3
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008864; cv=none; b=MkljwSZ5SlZwzozK+114lMQBe/AhM0iZVb5HRDuDxQ5aubpkkk0936b19S4CU9AKIzxso/gPflre8umffUiHhjnD+iwZ94lyddvCnPW0c3aYJ+FT2D/n0BtrBZjgCS1L+IowG05ePaponpJYHQQZU4s50WlkVZl0XDbLFinZTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008864; c=relaxed/simple;
	bh=tsVun3SSlxxIKCthOai90o5Bs9z0pQ5tPF/9tnRr/AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COq73KdErRYz4tjB1UbaI78D3jyc3ydmQqeuEm2Vr1ylWFOS7hfVBzftaqafzRWm9Jc42gJit9NyY/2RlUmxtc/HzZ2hwj542zK1nwH9RDOO6xoW7wg+B4Aws17ZD7yh3ZQFyV4EtOyWZnAIFWsKFWkHTWUJs4dIg/cptpVCTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFrCBYtP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFrCBYtP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c693b68f5so57627735ad.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729008863; x=1729613663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ubmlQtV4qIXTQy2CaCBFb0Jou/o4fnbrJ6O+vFNG+9k=;
        b=nFrCBYtPgdm9V9vk0bbPvlx9MX5z8kjKzhFg/W6AmPLFu8VT2HqV0qFlAlGqLLq5XF
         iK14vb8aUf/tT88VnV3/tZuRCwnMqTMvxQNzajGnWbN1iPrV+OWEZnVpxShqzo+OiuHl
         RvZlE5RQNgpd0TSpKWaSzq/kBhMy8v1cOz55MBkC4m03dYswa3uIzlkJaN0JrwjB7jPn
         WCawsaMvEnPv6i4MkbLnp6Un6DBTT78MiUW3mbO5qdnECrjmUnVZUQqZVgsbUFfI/+H6
         jqBs1aB7x/aAd2GAtebsClBy0dSoDOoG5atAWuT1GXP2lzBxyOZOPWk7B7XGOCmzVcGk
         7xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729008863; x=1729613663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubmlQtV4qIXTQy2CaCBFb0Jou/o4fnbrJ6O+vFNG+9k=;
        b=nK6tYN6uox32I9JHmAdIu1Mza9Q+PcA9HcCElORwHNEh3zikQxc10HZ1Xat5tBmieD
         0aWH2dtEdTU/U+sKUKVyZtLQoZMooUMFJkDJVjvtCT3+ZzSzhhyknrbb0wmf3yCTVyc7
         lTdRR6zpKIvirHAzaHEgDRdwcCZ77n2aWPmJt5C+0NEM+/qIzaq/8FxYKarbzy6AH37N
         EDMvaZ6ahWkvoevlFw+Xk0b0XxbfY+gYZBDWkxlHybHK/x3dbJgrSYXRLu+STkyqsTpQ
         ykLR2f9PeBmoZG9fzXSF7/OPyfCM/S1L9+oD3k6vrSqghiuuQVjulp5YRSFtqWgscJsR
         e3VA==
X-Gm-Message-State: AOJu0YzDKRGp0+ldGJ1XAPQs+q4lBhUnnMKLDOuu1OM9LqPdbPKMORyM
	rcLPpic1BEA6XmsJ5HQ7ie/3qoT2Ytf0VSMhiLWGB/BHYEUTh3Bp
X-Google-Smtp-Source: AGHT+IFLiDBa8xkFCocsEcsMr5Brq4b2K0CQS4M2ko2MsfxpgmGTJjxILJmYbjJg63QiaLMsCTjEhA==
X-Received: by 2002:a05:6a20:21d4:b0:1d9:a1c:7086 with SMTP id adf61e73a8af0-1d90a1c7235mr154239637.44.1729008862437;
        Tue, 15 Oct 2024 09:14:22 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773a2fc7sm1454471b3a.54.2024.10.15.09.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:14:21 -0700 (PDT)
Date: Wed, 16 Oct 2024 00:14:20 +0800
From: shejialuo <shejialuo@gmail.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] builtin/mailinfo: don't rely on "the_repository"
Message-ID: <Zw6U3NLlxCFoszMq@ArchLinux>
References: <20241015144935.4059-1-five231003@gmail.com>
 <20241015144935.4059-4-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015144935.4059-4-five231003@gmail.com>

On Tue, Oct 15, 2024 at 08:01:24PM +0530, Kousik Sanagavarapu wrote:
> Change builtin/mailinfo.c so that it doesn't have to rely on
> "the_repository" anymore - hence also allowing us the remove the
> USE_THE_REPOSITORY_VARIABLE guard.
> 
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---
>  builtin/mailinfo.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index 828b2b5845..9463a8780a 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -2,7 +2,6 @@
>   * Another stupid program, this one parsing the headers of an
>   * email to figure out authorship and subject
>   */
> -#define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
>  #include "abspath.h"
>  #include "environment.h"
> @@ -52,7 +51,7 @@ static int parse_opt_quoted_cr(const struct option *opt, const char *arg, int un
>  int cmd_mailinfo(int argc,
>  		 const char **argv,
>  		 const char *prefix,
> -		 struct repository *repo UNUSED)
> +		 struct repository *repo)
>  {
>  	struct metainfo_charset meta_charset;
>  	struct mailinfo mi;
> @@ -93,8 +92,7 @@ int cmd_mailinfo(int argc,
>  
>  	switch (meta_charset.policy) {
>  	case CHARSET_DEFAULT:
> -		mi.metainfo_charset =
> -			repo_get_commit_output_encoding(the_repository);
> +		mi.metainfo_charset = repo_get_commit_output_encoding(repo);

This is wrong. We cannot simply pass the "repo" here. As [1] shows, we
will pass "NULL" for "repo" when running "git-mailinfo(1)" outside of
the repo. There is no harm when using "repo_get_commit_output_encoding".
Because this function will check whether "repo" is NULL and it will call
"repo_get_commit_output_encoding" and then return the default value
"UTF-8".

But what if the user has set up the "i18n.logoutputencoding" in the
config file? We will ignore. There are no tests in the current codebase
for running "git-mailinfo(1)" outside of the repo. But we should care
about this.

[1] <d59b85b529865793c652d983d71a9fbb7e16b3e3.1728594828.git.gitgitgadget@gmail.com>

>  		break;
>  	case CHARSET_NO_REENCODE:
>  		mi.metainfo_charset = NULL;
> -- 
> 2.47.0.73.g7a80afd5fd.dirty
> 
> 

Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494CC27FB05
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418949; cv=none; b=Xt8cESI5qht9HZ9/8YqzMmZ3sQhd4cxURfyqGia1TZ6P5zwtqeAP1MDPyB6ea4O9Z47ycIKqeTi0kFD1HZeLjXwfjM91fV0Y0sQpfpWIePJiEUXW/MJg4bYywWZ08rzWaOHG5v4nOPujwK3fK20JQmhhYgoPErjJbH9WObhJL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418949; c=relaxed/simple;
	bh=eEYESBjYkvPEg68kQDP/RFL1ft7v4OfrB0JFkn3/3Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts0FgRFFNgFvdXSa5SITdb8AlZxZPaqFwIRdfoVvJfQs1gwjU6BhZ8P0lJDkRbPHf6rVQPud/3qtwunZFO4DZ1baAjElVnr50VJy4A4kgSKO+ACtAQtfDGP73CdwciH2V/nZezA/O8mpFeeocSAVFmte4niHiRIzC2ugwrtdHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkDICgA0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkDICgA0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231ba6da557so177485ad.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747418947; x=1748023747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zvGPLNZDZuTI1DePmj+hkl38eh8GqOqDADss6SvnWTI=;
        b=hkDICgA0QBEDOPfhTfnCtU3s1Sllt8m/gOy+uJ7NfusKlf25NdN9CEgQ9B1ALt5rPW
         IaQ5NOmcYeKQZmNu5n3M03wM/gARv6sYy1zSYdN9vRhWBDhNkXExnCJi3uxnI0J8X1wf
         ZQIKY2hmZ8ivA6pSOkDFH1DkZdj0E77FG7vwLS67LqnDlizP8tTmPZDPta1Whl6kPKGl
         YT4g2N8HJXH7hFLMvAgMk5re8UqpdjZtozX/+upSDcdGMkDQ57RkJ+MEU0WgB+Bw153H
         Ztz2Y2ZOzMf9wAdZKOApFKgUHQpL0s6nvT5GttbPpZNTGrZhVGJH3NJl6/x3wra6ki1w
         uDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747418947; x=1748023747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvGPLNZDZuTI1DePmj+hkl38eh8GqOqDADss6SvnWTI=;
        b=Vt70ePdvvDBK2Fgmpi2m4xHWLoq4Vn0TY9wrYyLswGuwaKJ0ShYfTgJoMuevn7CxHD
         kd6gGKYLswN6byMEGKCjWamwKk8WriNt2kYfbbfnFVmZ/akxP1R4owIbfM8Lva+QhNiJ
         xvxR+c1haDAVSdO+lhpGYG0U3eVyJ6zQUMawgvezDouTYYk/xjbUY5ar8pLnzryCJbbc
         uKuRz4V6QWak9EeTZ5SxzIT2Av8dkRPtDl6e/zjRHmPWyfHvlYET8SfEsBnqDiL+XMo7
         USSh5PHXXe9GbiUwpOjIJmxI0qra7daL/sO77Qxv95hvCvjKieiSnTsaPGiintq8A49A
         TJEw==
X-Gm-Message-State: AOJu0Yz//iOSC7llZW1ZIBGoBasVNvbvJqWAlpTqtVzb2e85Ox9rOg/O
	b/Nf8J/yKu+AVEnfAmGBx9NssGQRuGvQg5LgjqdTQJ/ZEPDSDhqkF2P0LxJBCGlPIg==
X-Gm-Gg: ASbGncsdfX/CAtqGCfb4ndbQxKDyZTqQ1nsVJxIL8MxF7TWe2QnPA2ORyt+ZbeLfVyC
	ieb8HLPFRgEQHsvL9imSnkTG12J7pHsONhMR2nHOYca1nrwW0/gQFkYyAtjjOyB7TtQjHtKSFKq
	tQuZbmn3ySkksNty/odX+r2RnbJDIZp/Xko3VLoDDznB5Boj3mZZaPw2rohaVWgTowLo+ia5OC/
	U0U4Rnrt7VXGuJcbE3+LDO/8kwy2OoVn4bcT8bYAdeu4Bqj77doiKiih20EB0tgXCnBHay76saV
	1kmeqN8UupJn4KNRrn9TSbUZ/vXYwXS7WCvDN0W3DBuXa+FW
X-Google-Smtp-Source: AGHT+IGSgp2F7xHz96e4H/yvseCajiZhjRLEKsEZUbE0UpdFjt20p0peAM67Ga3RSCKlsEqQPdXxEw==
X-Received: by 2002:a17:902:f68d:b0:21f:465d:c588 with SMTP id d9443c01a7336-231ffd2aef5mr199975ad.14.1747418947109;
        Fri, 16 May 2025 11:09:07 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:8ff7:6c9:7fc9:b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adc3a8sm17398145ad.79.2025.05.16.11.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:09:05 -0700 (PDT)
Date: Fri, 16 May 2025 11:08:55 -0700
From: Emily Shaffer <nasamuffin@google.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Docs: Correct cmd_psuh and Explain UNUSED macro
Message-ID: <aCd_N-QeIi9hwnWd@google.com>
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
 <20250416061450.25695-3-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416061450.25695-3-jayatheerthkulkarni2005@gmail.com>

On Wed, Apr 16, 2025 at 11:44:48AM +0530, K Jayatheerth wrote:
> 
> The `cmd_psuh` function signature in the documentation,
> was missing the `struct repository *repo` argument,
> which is standard for built-in commands.
> This commit corrects the signature to include the `repo` argument.
> 
> Additionally, this commit adds an explanation,
> for using the `UNUSED` macro to prevent compiler warnings.
> 
> This helps new contributors understand,
> common practices in the Git codebase.

For this commit and others, take another look at the commit message
guidelines in
https://git-scm.com/docs/SubmittingPatches#describe-changes - this
commit message recaps "what" you are doing in the diff, which isn't
necessary because the diff is very simple to look at :) but it only
briefly explains "why". You did a good job explaining why in your cover
letter, IMO - but your cover letter doesn't live in the code base
forever. Your commit message does :)

> 
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/MyFirstContribution.adoc | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index ef190d8748..b463d42f63 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -142,7 +142,15 @@ command in `builtin/psuh.c`. Create that file, and within it, write the entry
>  point for your command in a function matching the style and signature:
>  
>  ----
> -int cmd_psuh(int argc, const char **argv, const char *prefix)
> +int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo)
> +----
> +
> +We also use the UNUSED macro to make sure we don't recieve compiler warnings
> +for unused arguments from the function cmd_psuh.

I think it's a good idea to mention that this is temporary - since you
are removing UNUSED in the very next step.

> +
> +----
> +int cmd_psuh(int argc UNUSED, const char **argv UNUSED, 
> +			const char *prefix UNUSED, struct repository *repo UNUSED)
>  ----
>  
>  We'll also need to add the declaration of psuh; open up `builtin.h`, find the
> -- 
> 2.49.GIT
> 
> 

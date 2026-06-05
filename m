Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061830C14C
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667378; cv=none; b=mEy0ty5Gx/YOGkVanzMeS844vmsKas3umRJsNSV98WAze3/llTtWI2WxbBhKDFylPAbZIPbYEsQ6qWxoPNN2zX6hTWi1CjpX7GdYex36MpY0EjQL1OomApyFU+klCLsx54I4WCFpYYOFUxptE5JMw+TN9DwkVaEUHka04+YCUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667378; c=relaxed/simple;
	bh=36hsg5To5YWEDq/SFE1Vo4SlG2jezc7K/fzXafdDokI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqcCsyR3NJm0H7PrN2+orrY1nNmxqAS08cicBl2lZVyScsSnjBsVoRjxxXyYa6Pfrq9Ccrz6aZYS6MgcmHnVWpzag5DDW8H3r+9KI9zfPEJfv2yWwFHECVjQkG7MfNVW0Li8wqX5/AaHkTpmHvU3lCIJ1ey7XjPz1E4lktiWi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPXxJRIH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPXxJRIH"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso22850225e9.3
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 06:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780667376; x=1781272176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iovJzfELEanLQ49k0t/u0UllRRWctpVuzoMy2MM2p9U=;
        b=OPXxJRIH2c5KQw35mQmJ6FepxHEWCaR4BAnwV0ENi1UsiL2JOiAvJPO/Idrxc+45i5
         3wLT9hlykMS8LL/rQY8gEaKgDwNQxXjzRTuFb/fZ71bH/pY3vguWyKZMgWRa0+gfU/GP
         m3SlDLzOv4AhzNq5E5cbeyZV1h1KL8VKvH9A2NH0VehlO+O4zdZRvdBHzNX76VEHdKvb
         4WglcPxqKge/tO3yqAc5Jfsr8I0hNngPFxuqDqqco4V1rhzYgIYqBIEpdw/d8Jghz9ew
         8oNAuv27CzwPskN5e9e5r/455lG8Dwj/uQ3/QlkWAZjsYgviOKD7TnXG+yP4jx+xQwOD
         DQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780667376; x=1781272176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iovJzfELEanLQ49k0t/u0UllRRWctpVuzoMy2MM2p9U=;
        b=gyJrrb4QHxQxG1+MGadaSrcGtKVuC13uneTNvcjlUi1mc2douRYkGHOU99rcmxv5vr
         omANYfA1buE6A112cwF5g3QArks55gGCVExD9I0nFZt7Gp/hNeKKKjc8IK4FlLgQGQZO
         1qy6qPQYtPfP5V1lATMA+oNExknfoAqNbckwu5tKDdo8PHzkKnUjh7aSZip5NL7XYQZU
         oBKZKFd/rQiLiaKa7TP3Up4LwjDTVDvMC1bP6KUlAwWDgCPexp+v2/2Wj0hmHtAYavHR
         O/Rpjtmd45Z5/n0UKBR08E/w2qylB+8z42hDeE6+vlkMqnexBFi5ozWaUErMj1MnQphJ
         UDGA==
X-Forwarded-Encrypted: i=1; AFNElJ/+/oyzoP60fSCu0yvmkGKmSeOWuWj1PcnHkbdYkVNqEwf0CecqLFS+EjNr5ufqCavLbxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZGAs7ljVmk7PhZnWlc6wlAEx/Of3shJN4G4ND3nlEYGQ+W1IC
	pnEQNisNrFh3YYTFPZtq+SY9dJJIhJl89dercEk/2ckRvgC/ZWf8fKnD
X-Gm-Gg: Acq92OE07n0zl1VWcIy8pG9GKum/wlEbN3iIgY3Tb3gKjL8vRJz/jAHJjN7VQXiS4eM
	BhMgerhS6Wp3mlG55vtFHlsuudgOJ6Lg8znGxTaWkXM8vQA7oJIfCPzBcl3tyC9jwWFrvS2c9iA
	/SaTP/f0FKy/RWsi6+CfyLoqRmnM2p8YsnyeLDaqLlNRdF8MHED22DzOXuKuKj3mcCl+yEIToSD
	atC62lp0vFNa49dz9Rjnt73bTa+C82uiRDtdOOpiUJ93acQGSLu4oFCctatOabpWa3JpoD9Gsn9
	LMtmqu1o+MgFyeAOYpwccsco95VfzLV06xe7k4wjxQIuPt5T0i5dgSWM00Ad5NwoDNNm8c+S2cm
	pwf9W2zYOdK/Qm6/aq1uHHpsq4B9efmntZELehLIpe+sk605EO5jL9kE7VpJiY0P+6UQfidOGkE
	JgY5+MutQ4uJW2+ijNgfrH6M1UxbwWzjB3gHkYt7u3s2t8yS9gAWdpbFVfL47nEVMWT3CCEgGvG
	P7uKp0XGrouxTzM9rXpH+9e
X-Received: by 2002:a05:600c:c0d0:b0:490:c2a3:abae with SMTP id 5b1f17b1804b1-490c2a3abf2mr41979295e9.34.1780667375761;
        Fri, 05 Jun 2026 06:49:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm26177513f8f.0.2026.06.05.06.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 06:49:34 -0700 (PDT)
Message-ID: <71675174-c477-420d-a656-d72dc7037d73@gmail.com>
Date: Fri, 5 Jun 2026 14:49:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v12 2/6] branch: let delete_branches warn instead of error
 on bulk refusal
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
 <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
 <6c95e4e77cf555194b83eab92c7564e6b639f500.1780477479.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <6c95e4e77cf555194b83eab92c7564e6b639f500.1780477479.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 03/06/2026 10:04, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a warn_only flag to delete_branches() and check_branch_commit()
> so a bulk caller can report not-fully-merged branches as one-line
> warnings and continue, instead of erroring with the four-line "use
> 'git branch -D'" advice that the standalone "git branch -d" path
> emits. Default callers pass 0 and are unaffected.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   builtin/branch.c | 26 +++++++++++++++++---------
>   1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 12711b29cf..93d8eae891 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -192,7 +192,7 @@ static int branch_merged(int kind, const char *name,
>   
>   static int check_branch_commit(const char *branchname, const char *refname,
>   			       const struct object_id *oid, struct commit *head_rev,
> -			       int kinds, int force)
> +			       int kinds, int force, int warn_only)

We've already got two boolean parameters, lets replace those with an 
"unsigned int flags" parameter rather than adding a third. That way we 
can avoid having to comment each argument as you do in a later patch.

Thanks

Phillip

>   {
>   	struct commit *rev = lookup_commit_reference(the_repository, oid);
>   	if (!force && !rev) {
> @@ -200,10 +200,16 @@ static int check_branch_commit(const char *branchname, const char *refname,
>   		return -1;
>   	}
>   	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
> -		error(_("the branch '%s' is not fully merged"), branchname);
> -		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
> -				  _("If you are sure you want to delete it, "
> -				  "run 'git branch -D %s'"), branchname);
> +		if (warn_only) {
> +			warning(_("the branch '%s' is not fully merged"),
> +				branchname);
> +		} else {
> +			error(_("the branch '%s' is not fully merged"),
> +			      branchname);
> +			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
> +					  _("If you are sure you want to delete it, "
> +					  "run 'git branch -D %s'"), branchname);
> +		}
>   		return -1;
>   	}
>   	return 0;
> @@ -219,7 +225,7 @@ static void delete_branch_config(const char *branchname)
>   }
>   
>   static int delete_branches(int argc, const char **argv, int force, int kinds,
> -			   int quiet)
> +			   int quiet, int warn_only)
>   {
>   	struct commit *head_rev = NULL;
>   	struct object_id oid;
> @@ -309,8 +315,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   
>   		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
>   		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
> -					force)) {
> -			ret = 1;
> +					force, warn_only)) {
> +			if (!warn_only)
> +				ret = 1;
>   			goto next;
>   		}
>   
> @@ -995,7 +1002,8 @@ int cmd_branch(int argc,
>   	if (delete) {
>   		if (!argc)
>   			die(_("branch name required"));
> -		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
> +		ret = delete_branches(argc, argv, delete > 1, filter.kind,
> +				      quiet, 0);
>   		goto out;
>   	} else if (show_current) {
>   		print_current_branch_name();


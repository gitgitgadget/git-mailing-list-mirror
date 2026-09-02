Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73BA4A9D6D
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363569; cv=none; b=IxoYMX2U8vfkZb9/UoykgaUkBqgDDmswSl4aSrb0T71pqpfeY1spGYibf9TPncGb9RO3BPLpEY1sv0zoiRuTEMeNCSbVRPa3mFt6m7cXbIlFUKI4TjBGhoAyI0L2kv/730+3gXGqR/w2sFxv0jtxN/aHu1hbFmt9DMud2/P0uM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363569; c=relaxed/simple;
	bh=D+p4G8EA0MtLf6yP7HVuHDys+hheK1ETTf1G95/kOwY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FUngPt9j5QPg55F0mh2ggxfXOYHqxqxFhqbuJ8xLKSv5r6EcD6fuNN8ixdmvEVJlwTZ8X7nB4UsECHaAJ0Hwn9rEmOWGmQbLUJxiXfzU/igrtnw7DKOkxe/5g7GqIPzZSKTWb0+m+m7wLwo975tOt4jOyM5+yW6J+8FHkFfSbbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5UilAr+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5UilAr+"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b965570d7so10116345e9.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788363565; x=1788968365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oLnp6Kd+9jKIVgsYP8ivP6bCQZ6IXFBlyljPa0B2m2A=;
        b=M5UilAr+80WVAiXmWRLnxZOgOY1u64WJBYboU3L8qIRTgm4Atxl2dCLBOr4m7qkD83
         VDdOuqGQpF/YRTIqmYs+UM3esJ2JMc9TK/uhHTx11z9s+bmsonFzk5KLYKnZq34LhRzr
         0tOoLU3te9kIaggR/mE3tn4OuQj9PweEzazWJ/rc9wMNVz2L1o7kb3Lk5nWM2FXgz/Qf
         CjGJ0J54/jPbuTEfb1GCxFBO7LE190so/JL9IEauRgJtGB2xiIhNfXZBL4jyLUIwGvc1
         l186pVLoe0oaWaHwlOAYCnRhodYnJRey3nX+BXkM2N95WoClBlSBIPI8dFNBZuwxm4cB
         Ng0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363565; x=1788968365;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLnp6Kd+9jKIVgsYP8ivP6bCQZ6IXFBlyljPa0B2m2A=;
        b=X3d87o1F2J41EPB/4YdGsBO8kL9hHwAr7STDFmeynsshVW4FWMiujDh/+hWHmUMdbp
         taOdNvItkkHclijTiavbbVydIlO4qx62Xo4G7krjBphYVt1gGSet6kMYdYmsf+IXAXua
         f/6j5l4VqXIcXqUbW72160in8N1GOLUP3e3BeiCx+jW6bbZx1uJLXN9w35eziUFuaEDU
         f5514CYG7v4x5dBMQbh9SXCpJAVM1cRZamvZ/X7Tn7wK9S9rzpFO+5TzkXRQIaQS46TV
         KfAeXO037F4TYC7ABeiS77Q0NFwT3ULsTAiytpjTlCGa5G2sxT1fNbm637ECy1QYQEiK
         q6FA==
X-Forwarded-Encrypted: i=1; AHgh+RpBmx1DhJJH1FTdS1IIk3mGY+E8ZXOAm6kWscCqz/0GAtlz+vtTRaRKSBRgr6sD6G5MLGY=@vger.kernel.org
X-Gm-Message-State: AFuF++mvDCEsaI7VbaCSKa+X9fEO5zuFluh8EWw6wBClX3mLgQys7nXO
	6+ONOrXku2mDC7E6bdpZ60hqRC17X+w81U3ieij5nyvmUEdfo37M5qOx
X-Gm-Gg: AR+sD12cxQKcQLH/TNHxofoWRgVy1rZVFCZI9wmOSN4Hb/kgrva3yP/fBcm/VfFW+Q7
	R3gE7l3YQpGSm4pY969w1FkvBAfMgEnD9pRNi4dS7RPmEuesB8+w/w5rFYt5nuqd6aXYPm/k1PQ
	xBOd5Dwzg2MkPMFPIHxJh/rttolhUWTV6TklAlI3GEKU2FeG/Fh6LopudItbxbskCCxZZC40alS
	rexbAbxGWKrrMGmZ/XD1eTH7/EMUtm3pAM5YSx5cpPAmnxF0T7TFGcSXFVEQAtCIQEiwPqGP0hn
	1hlotaHut1dcOcafAPIEgD5BQqC3phXJo2sTgmyIUnWYQZgWJeyRqzrp+TayO8tdy2cTTHNzMgM
	QXcyudXLz7RPQHpeYIY1QYU9gNmYufMYt84aE8B9TSwFQ78VJts9DhPn+DYEXd64zZCo6A3EWDD
	EH6MZ0yBRWEM667os9HH/Jjo3lsB00Y/yMcjGQeZYDMWMyBGVZ2+jlJq9zzg8fY9RdW/7q4Nb4Z
	heUL8iUq1R4xzsjDyOkccQfEeaPlyLcGykRY5d7Ph0=
X-Received: by 2002:a05:600c:3f06:b0:49c:ee1c:d582 with SMTP id 5b1f17b1804b1-49cee1cd69emr12007875e9.14.1788363564639;
        Wed, 02 Sep 2026 08:39:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eea5b4sm7275212f8f.27.2026.09.02.08.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 08:39:24 -0700 (PDT)
Message-ID: <050c4aee-8e90-4063-ae70-551ad4f53746@gmail.com>
Date: Wed, 2 Sep 2026 16:39:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/5] commit: reword the empty-commit rebase amend error
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
 <pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
 <c4511a98875a402a59e3109fcfe3839c2564753c.1788301481.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <c4511a98875a402a59e3109fcfe3839c2564753c.1788301481.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

On 01/09/2026 23:24, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> When a rebase applies a commit that becomes empty, it stops and asks the
> user to decide whether to keep it or drop it.  HEAD still points at the
> previously-applied commit at that point, so amending is refused, with:
> 
>      You are in the middle of a rebase -- cannot amend.
> 
> That message would suggest that amending is not allowed during an 'edit'
> or 'break' stop, which is misleading, plus it lacks the specificity that
> might help the user know why their particular case is a problem: the
> commit they intended to amend became empty and was dropped, so amending
> would affect the wrong commit.  Reword the error accordingly.

I agree the new message is clearer

Thanks

Phillip

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   builtin/commit.c              | 2 +-
>   t/t3404-rebase-interactive.sh | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 01b79185e7..9b6eaa3c72 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1332,7 +1332,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   		else if (is_from_cherry_pick(whence))
>   			die(_("You are in the middle of a cherry-pick -- cannot amend."));
>   		else if (is_from_rebase_now_empty(whence))
> -			die(_("You are in the middle of a rebase -- cannot amend."));
> +			die(_("The now-empty commit has been dropped -- cannot amend."));
>   	}
>   	if (fixup_message && squash_message)
>   		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 3588e16543..81f4844950 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1880,7 +1880,7 @@ test_expect_success 'correct error message for commit --amend after empty pick'
>   	) &&
>   	echo x>file1 &&
>   	test_must_fail git commit -a --amend 2>err &&
> -	test_grep "middle of a rebase -- cannot amend." err
> +	test_grep "now-empty commit has been dropped -- cannot amend." err
>   '
>   
>   test_expect_success 'todo has correct onto hash' '


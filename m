Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A61CFAF
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719542685; cv=none; b=nJswLZ7ibP5FtGSM4cpdfqTeQ9HocbFcdLqm7kqxr5uUqlFVR9g4oVAMswal1r+bjXWB/CsU1l6tbCM+eOs4WMHE/ignBOWa/FDng2hGPvt46/nAohsGNgAGp5yE1p93ZZ6yO9hQ+X2Fm8eWRC9RPHyJTvDpw4cGBddy4tenG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719542685; c=relaxed/simple;
	bh=1fGyZcUtcRoVPYjXLp5PjByRcZylP8Vc88B02GyeVeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnIQwbwloSi5keEpa0+V+MbT85ud1668JogJ/g1wtn2pm1JmlSuXI2y3fHNjuVfII3TnYZRO8w2szuI6Pzug/j+sNNRNZu+YNLvbmu4DJiBag2Gdyfzij1G/kJk9zokNM0K5XVT1PnPVwGoaF0F/m1WQ7YqPbKdPo4BXz8oY/Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDqsQlce; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDqsQlce"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6325b04c275so1072837b3.3
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 19:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719542683; x=1720147483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJaZII+6U29vO10b4JBDFjQC+fwZyWt7AXA9DM4XXrg=;
        b=YDqsQlcewAU3c6yTqwjPtn75MrGlv9gxK10raKBZ9O7j8pj0kRRSNRhTFtGMjj6Fgv
         vWPZErghNTdBOwUqssMXXLtSx16q7mAJDVXG3sdpXnivMkMQDXk2xZzbnVV0MsKxm0Kf
         Imp41BvkB6M+p4Lk7w+du27kczZ5gIeWTEa941jyLMSjTIM/8T1dfg7SWoLgcH+TEWht
         3mW4Cb8wVkgEqrJDQwfDe4+0WloqtwbjlM7sA8NV3tQIKgFxi7zQrgFeMRugk0TG24T/
         BVSgCEMx9dwZNulos+xU6DPZ+S5ljN+zWwNVStv2hG9uj9jyWSCS+JhUXNLNMJ9Etntc
         ot9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719542683; x=1720147483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJaZII+6U29vO10b4JBDFjQC+fwZyWt7AXA9DM4XXrg=;
        b=fehuxUNVpNc7eO0w6qLrsXoWVXMAzLR1bgEtAUgwQVXxT53AEYDwhCGpqEMWV6iD44
         d9YXRn+YsgXyUtXREi/dpreyTeU2Nofthhw1YMl1nlak9ee/wAy5CLyNiEZGxzVd0L9L
         J+j3pjpQhmwWcDtu2r9ws+jccXGSx6Zrs9FTJ9DJSnuVikKiaDbCplUnwy4oanySwNyW
         ISFcsVjNbnRcprQtyr2ZVBzZe3IjgYt4lxS4TYFw068Em0mgspdINvEvy002pq/8uCPR
         TAEfX9UMWJT3QZFmqHInsT1vnenwExhXQZmyyboHCRiPmWYJmCKdPm2qRGKi7vFeKHNH
         SNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfbY2WshLKmDmcTkSHLXIJoQN5UyktV0nkL8iO8qwJ0G8od1560L1cXpS9Kz3mzI6ZzEoTlYWNdME8McY5NSAl8Mha
X-Gm-Message-State: AOJu0Yx/0ZR2zrFr3Y9p9xA67a7IyVkH7p4AS9hpLm5X1tsGaR78jPE0
	VKx/BpwNlEHaQ+mupcjRBsNQGnbnXlxnowvvPOubBic8NDDXhFYL
X-Google-Smtp-Source: AGHT+IFkSuYy/dj48i/RSEdGxnayMpvy95tEM8m6Pem+SZCxQJdigxB+bNTjx7IWXvhDs/nbQ8vOgg==
X-Received: by 2002:a05:690c:845:b0:631:2740:3882 with SMTP id 00721157ae682-643ace05438mr125828747b3.51.1719542683345;
        Thu, 27 Jun 2024 19:44:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:5cca:8078:1e70:3d3c? ([2600:1700:60ba:9810:5cca:8078:1e70:3d3c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9a23b71asm1868827b3.50.2024.06.27.19.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 19:44:42 -0700 (PDT)
Message-ID: <6db979ed-3d08-4ac4-b1c6-65a76939de35@gmail.com>
Date: Thu, 27 Jun 2024 22:44:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] merge-ort: fix type of local 'clean' var in
 handle_content_merge()
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
 Elijah Newren <newren@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
 <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
 <034b91db1d2ed78995b52c014de313744972ff40.1718766019.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <034b91db1d2ed78995b52c014de313744972ff40.1718766019.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/24 11:00 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> handle_content_merge() returns an int.  Every caller of
> handle_content_merge() expects an int.  However, we declare a local
> variable 'clean' that we use for the return value to be unsigned.  To
> make matters worse, we also assign 'clean' the return value of
> merge_submodule() in one codepath, which is defined to return an int.
> It seems that the only reason to have 'clean' be unsigned was to allow a
> cutesy bit manipulation operation to be well-defined.  Fix the type of
> the 'clean' local in handle_content_merge().

> @@ -2184,7 +2184,8 @@ static int handle_content_merge(struct merge_options *opt,
>   		free(result_buf.ptr);
>   		if (ret)
>   			return -1;
> -		clean &= (merge_status == 0);
> +		if (merge_status > 0)
> +			clean = 0;
>   		path_msg(opt, INFO_AUTO_MERGING, 1, path, NULL, NULL, NULL,
>   			 _("Auto-merging %s"), path);
>   	} else if (S_ISGITLINK(a->mode)) {

Even after this removal of this cute bitflip, there is one more
subtle use still in the code:

diff --git a/merge-ort.c b/merge-ort.c
index 8dfe80f1009..569014eef31 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2629,7 +2629,8 @@ static char *check_for_directory_rename(struct 
merge_options *opt,
  	new_path = handle_path_level_conflicts(opt, path, side_index,
  					       rename_info,
  					       &collisions[side_index]);
-	*clean_merge &= (new_path != NULL);
+	if (*clean_merge && !new_path)
+		*clean_merge = 0;

  	return new_path;
  }

I had to think very carefully about this cleverness to be sure
that this conversion is right (and I'm only mostly sure). When
(new_path != NULL) is false, then we definitely set *clean_merge
to zero. Otherwise, we set it to 1 (but only when it was already
1 or -1). Technically, this does change the behavior by not
squashing -1 into 1, but that is less likely to be an existing
value of *clean_merge.

There are other uses of "clean &= collect_renames(...)" but that
appears to be fine because collect_renames() never results in an
abort state (returning -1).

Thanks,
-Stolee

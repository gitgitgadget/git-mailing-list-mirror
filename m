Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59F145351
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131211; cv=none; b=RE9bp3zoOknm3wxSTX+KZsh9FVwPgpp+cGFf2/S1++Q7cSXAwt6Y3OCa1LirP9kNbX5FCoUT53Klu09fLhHv5iDy10zWmrUS3aNEq/uM20N81p9o9O1jkr+bjv0fZdN3pdEJM0JNjpunhS846k0Fzz+qRtSw7Ol+Z2FQzQNsOJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131211; c=relaxed/simple;
	bh=M0Xlb9l/NEjYxJWE6SkNEjMZzXDo8VS8DghI5UYuQ6Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n7NZSMN1oyAXr5YmEonNf4OfpEufNRaCHF+ZbLJk1ZlzKAbCEkjDXXARAlnyDnLqkYGQZ7GE6XglvMejrOWA5Mubr04IkaO0x5TjG3qZQnBaKwcTZgdg1MnN1dxfbk6Ma02y3T8PKIkOMHBLs/rrmWmCk2CFUKYzP9WS1RfalfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVpoQUVP; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVpoQUVP"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d1094b5568so65266631fa.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 06:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709131208; x=1709736008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WqjpZRmV7SbgxpVgXVLhwrgxAFPg5oC3icRyfG+GQBg=;
        b=mVpoQUVPHKAjPR/cl4UJwUwrqrSfG9qrLfvP0SNO/9WE5/PqcQv0QuLKIFiQSyT+ND
         PqCogqNN2757yzZ1E92pwGUFjzutUZENOeVb5RTsU4t1+ITrQX7mpD5/hCDttMVcvbbQ
         Y3f/DURcKaXx8f50L9m6UecV3jlL3vIkldgyTQkNKu4kCQ71TYnG2qD4yRtP7u/iIGdy
         iMYxgNYp6kAl18aorax6cDC2fWv69ikqBSNzhfzgC3s7dWEUH3ImznFafka9Hq9Xm3lz
         a5TJ8s2oV9L6ljPx9LdgrRARSAcJHS8pHm1+5CN2I/6TMAFNWEjKx8wsTpALBzf0a6Wz
         j47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709131208; x=1709736008;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqjpZRmV7SbgxpVgXVLhwrgxAFPg5oC3icRyfG+GQBg=;
        b=cgmg8/ljMHqbnO6VFDwB399kb7q6gj/yO3V2dElJXtJIk97Rw/D9jf12RREzBo/oy+
         QphIWHVWcZAIPMwg+bIWX3mpllbf0LGM0UGHZDPInWF4SORP3VUB9cJ0cIZn2HR4mtO1
         NJlTJX8FHGTJTspg49cIygYYjxeKFALUJRcpmEEMIVQaTbJ0QfK6I2tAq5dCmVGuOiqM
         ufbz8mIVx0C2Ybkh4CS42yoQLELxiO3BFHgF1ItQeyPSSnqcM71bWga5aMBr9iISRFmz
         OZLAARHMmWuf5XWULEczBg28EOueKq5p47kIYTfDrNIaFOxr+PYkr7O+aZDMTrUH/R5t
         CBQg==
X-Forwarded-Encrypted: i=1; AJvYcCUdRkBpFsYBu5LdkgdSmAj6ZQPoWsV2npMJN6h2WCv9WGFYRuBy5BhbtdkmMu59Sg+UlotZP8LDvW7l44fkeWv8BlJZ
X-Gm-Message-State: AOJu0YyJUOcHHGE71XLkQ+lT/OHOWHiZVzM93ygBAbmZlAAvUPxQ2vf2
	lt/yTTm4negU8ghewaviFqP4BZqytL+D7UKQTT6URwRPB6qbLPzr
X-Google-Smtp-Source: AGHT+IE42hJ979w1byZFG4PTveeDeaqVWeFQ4c9zMKdS1lC/HYIVdq1WyXQag7y/3egcMToTaPRV2g==
X-Received: by 2002:a2e:9009:0:b0:2d2:d85f:79e3 with SMTP id h9-20020a2e9009000000b002d2d85f79e3mr897024ljg.21.1709131207720;
        Wed, 28 Feb 2024 06:40:07 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id bq1-20020a5d5a01000000b0033e053577b7sm525701wrb.80.2024.02.28.06.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 06:40:07 -0800 (PST)
Message-ID: <3875a0dc-6ef2-4bd3-9852-c180043464c3@gmail.com>
Date: Wed, 28 Feb 2024 14:40:02 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 0/2] Implement `git log --merge` also for
 rebase/cherry-pick/revert
Content-Language: en-US
To: Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
 Michael Lohmann <mial.lohmann@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>, Michael Lohmann <mi.al.lohmann@gmail.com>
References: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
 <20240228-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v6-0-8ec34c052b39@gmail.com>
In-Reply-To: <20240228-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v6-0-8ec34c052b39@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philippe

On 28/02/2024 13:54, Philippe Blain wrote:
> Range-diff versus v5:
> 
> 1:  c9536431d1 ! 1:  363657561c revision: ensure MERGE_HEAD is a ref in prepare_show_merge
>      @@ Commit message
>           (2) obtain the oid without any prefixing by refs.c:repo_dwim_ref()
>           (3) error out when MERGE_HEAD is a symref.
>       
>      +    Note that we avoid marking the new error message for translation as it
>      +    will be done in the next commit when the message is generalized to other
>      +    special refs.

Looking at the change below, the new message is in fact marked for 
translation. I don't think this matters (other than the commit message 
being confusing) as the translators will only see the final version of 
the massage.

>           Helped-by: Junio C Hamano <gitster@pobox.com>
>           Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
>           Signed-off-by: Junio C Hamano <gitster@pobox.com>
>      @@ revision.c: static void prepare_show_merge(struct rev_info *revs)
>       +			&oid, NULL))
>        		die("--merge without MERGE_HEAD?");
>       +	if (is_null_oid(&oid))
>      -+		die(_("MERGE_HEAD is a symbolic ref?"));
>      ++		die(_("MERGE_HEAD exists but is a symbolic ref"));

The new message is marked with _(...) so will be translated.

>        	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
>        	add_pending_object(revs, &head->object, "HEAD");
>        	add_pending_object(revs, &other->object, "MERGE_HEAD");
> 2:  1641c4be81 ! 2:  749abadc04 revision: implement `git log --merge` also for rebase/cherry-pick/revert
>      @@ revision.c: static void add_pending_commit_list(struct rev_info *revs,
>       +				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>       +				oid, NULL)) {
>       +			if (is_null_oid(oid))
>      -+				die(_("%s is a symbolic ref?"), other_head[i]);
>      ++				die(_("%s exists but is a symbolic ref"), other_head[i]);

The second patch updates the message and this new version retains the _(...)

Best Wishes

Phillip

>       +			return other_head[i];
>       +		}
>       +
>      @@ revision.c: static void prepare_show_merge(struct rev_info *revs)
>       -			&oid, NULL))
>       -		die("--merge without MERGE_HEAD?");
>       -	if (is_null_oid(&oid))
>      --		die(_("MERGE_HEAD is a symbolic ref?"));
>      +-		die(_("MERGE_HEAD exists but is a symbolic ref"));
>       -	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
>       +	other_name = lookup_other_head(&oid);
>       +	other = lookup_commit_or_die(&oid, other_name);
> 

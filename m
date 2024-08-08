Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE698189F27
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111707; cv=none; b=ogxd7bPOHzBz9WhLgqd+JFSdB1smTr+yyz9jE7xlHQxsm7MX76P2C0WudjAG3yWypKBIbrgGeowQEwswTO9LWSDGPpF4xFbzIeK2aLDnsj0FX6/lQDRB8Z93awqid69ECwnU34qlzU5Ij1Mu6qhZBL93rBh60JocUpQkIR3SGeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111707; c=relaxed/simple;
	bh=LkIiTTLfbkt8L7xfLK83WNxipypDbYZNe2G1fllE/Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y2AyUujtj/V7w9c8GsPRC5VdyY5WQmBTN8BOoqoQRextVPTq8c48KXwVzd1GxWBqOWCHWuT0xQRvB3tevFUhl0PIziWcX28eL8y5t38pDqapARDjztTPiS7eXZXhBqQQawzJz0YKABhli2FARAt8mtyroOPBCwlHASxiRXniGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ1uAS3u; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ1uAS3u"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so7898785e9.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723111704; x=1723716504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JnMThn2YbdbiYq87IO8Q/2FLlhbtpFx0zjFaA7HvZgs=;
        b=iQ1uAS3uTWufjrkLgRlkQxKcD+r8EKPzHvKQvPatKbpE2RmuZRMKdnioBDSA1VSJ6l
         MYI2gYaRNTeFgde7sdqKWscnM2sO35ER4t8kQmaBZp00/eWDhDk383YiSoyALfKN0C41
         wolfHWf/wUbogb3fS3SeoZaauSYimAzgmNnDYkLYlfMDGLKEh29UtFRelT9Giss1Z6UD
         ln/pykWxAhrfsoIHMbcpw+mBxx2joVFzC/FXXvT8wZv9w618EFYXvneJHNaKKnhHMeWU
         SRAXWJ/qX1vnPrQaXyrmCDJf5yxRcm8NT7AW5Wr+lSxDd6u0Am20nFMV+VHHq4VYa1q5
         v9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723111704; x=1723716504;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnMThn2YbdbiYq87IO8Q/2FLlhbtpFx0zjFaA7HvZgs=;
        b=rfnK4gEe1wN8rMDjcHxN4g0D7A50Tq7/QHWn8PJt4KyCJ9NiPXis4gLzSgaFOOTlr6
         9bN5IMMvEnDzLC7Tx3nOLGFEP8b1iZ7M7ytOwvPEu3QK/xAyJ57vEUvltUj0plUw5cG7
         rIFF4V+7PrU1/VZBh6M78kyfhmUrC2psgdYfrIOVPWy0rmDJr6SfW39TtyKAMmXlX5E7
         nh99PjYnGE6UUUbfliVfdu3jmPG/fKMK0rU+7f5DaXl/7c/Q8riNP5Ri+OflFblvx4l1
         zu853XJ8+pwhxyhZK4i8UlTK5EsMUsbQQqpqKMpveb5TAz2ptrJiGLl1pYgKt7t4IG+e
         sH3A==
X-Forwarded-Encrypted: i=1; AJvYcCV3IzYbbnPCEe3NPydzfDIANBexummEJLgeJ3afh0o0fyVRXBt3PEuJTzAP5u8z0iBBu/9ddSSDufsN84OMKKYOLP+V
X-Gm-Message-State: AOJu0YwQ75WdX5jDtLDOogASJxAhEnbI1ADsth8LTtLSyIXNDHMRcNNv
	hyZc0DXYe+JTlzxo3X813FIqpbcMIzJr62w7Aj3t23jpw7tIPRyk3jyEzQ==
X-Google-Smtp-Source: AGHT+IGjXEHjPDkvkOfSkimNL3ytlXH1GmcVll/o/UOBZNoAgph4K0f0r1D1PT3wLwCZABt/GkTtow==
X-Received: by 2002:a05:600c:524b:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-4290af4d238mr14232675e9.35.1723111703749;
        Thu, 08 Aug 2024 03:08:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d7:1301:c687:6ca8:8709:4b85? ([2a0a:ef40:6d7:1301:c687:6ca8:8709:4b85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2716f333sm1378228f8f.43.2024.08.08.03.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 03:08:23 -0700 (PDT)
Message-ID: <e0685657-369f-4211-8518-cc41aa28dcb9@gmail.com>
Date: Thu, 8 Aug 2024 11:08:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 15/22] sequencer: release todo list on error paths
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1722933642.git.ps@pks.im>
 <df4c21b49f86d6e1e9d2b28375ab6465ffa4339a.1722933642.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <df4c21b49f86d6e1e9d2b28375ab6465ffa4339a.1722933642.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 06/08/2024 10:00, Patrick Steinhardt wrote:
> We're not releasing the `todo_list` in `sequencer_pick_revisions()` when
> hitting an error path. Restructure the function to have a common exit
> path such that we can easily clean up the list and thus plug this memory
> leak.

This looks good, I've left a couple of small formatting comments below 
if you do end up re-rolling.

> @@ -5506,11 +5508,14 @@ int sequencer_pick_revisions(struct repository *r,
>   				enum object_type type = oid_object_info(r,
>   									&oid,
>   									NULL);
> -				return error(_("%s: can't cherry-pick a %s"),
> +				res = error(_("%s: can't cherry-pick a %s"),
>   					name, type_name(type));

This line needs re-indenting to match the changes above.

> +				goto out;
>   			}
> -		} else
> -			return error(_("%s: bad revision"), name);
> +		} else {
> +			res = error(_("%s: bad revision"), name);
> +			goto out;
> +		}
>   	}
>   
>   	/*
> @@ -5525,14 +5530,23 @@ int sequencer_pick_revisions(struct repository *r,
>   	    opts->revs->no_walk &&
>   	    !opts->revs->cmdline.rev->flags) {
>   		struct commit *cmit;
> -		if (prepare_revision_walk(opts->revs))
> -			return error(_("revision walk setup failed"));
> +

This whitespace change is good as it means we now have an empty line 
between the variable declarations and the code, the others I'm not 
fussed about either way.

Best Wishes

Phillip

> +		if (prepare_revision_walk(opts->revs)) {
> +			res = error(_("revision walk setup failed"));
> +			goto out;
> +		}
> +
>   		cmit = get_revision(opts->revs);
> -		if (!cmit)
> -			return error(_("empty commit set passed"));
> +		if (!cmit) {
> +			res = error(_("empty commit set passed"));
> +			goto out;
> +		}
> +
>   		if (get_revision(opts->revs))
>   			BUG("unexpected extra commit from walk");
> -		return single_pick(r, cmit, opts);
> +
> +		res = single_pick(r, cmit, opts);
> +		goto out;
>   	}
>   
>   	/*
> @@ -5542,16 +5556,30 @@ int sequencer_pick_revisions(struct repository *r,
>   	 */
>   
>   	if (walk_revs_populate_todo(&todo_list, opts) ||
> -			create_seq_dir(r) < 0)
> -		return -1;
> -	if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT))
> -		return error(_("can't revert as initial commit"));
> -	if (save_head(oid_to_hex(&oid)))
> -		return -1;
> -	if (save_opts(opts))
> -		return -1;
> +			create_seq_dir(r) < 0) {
> +		res = -1;
> +		goto out;
> +	}
> +
> +	if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT)) {
> +		res = error(_("can't revert as initial commit"));
> +		goto out;
> +	}
> +
> +	if (save_head(oid_to_hex(&oid))) {
> +		res = -1;
> +		goto out;
> +	}
> +
> +	if (save_opts(opts)) {
> +		res = -1;
> +		goto out;
> +	}
> +
>   	update_abort_safety_file();
>   	res = pick_commits(r, &todo_list, opts);
> +
> +out:
>   	todo_list_release(&todo_list);
>   	return res;
>   }
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 7eb52b12ed..93c725bac3 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -12,6 +12,7 @@ test_description='Test cherry-pick continuation features
>   
>   '
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   # Repeat first match 10 times

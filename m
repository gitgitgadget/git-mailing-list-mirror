Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA1122FE0E
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175603; cv=none; b=cbq/5ZmmAXYaWL7EjhezHXLpLGBKneHk9DVCAFnIneazkc5AllWCZvy7VyFaKCUvV00uayO/yZ3Xw87StCXOQ4paNU6O0WxT0ay2Fh1YZL5GDBxgq/1yT5x0tXA3RcBH/WVVOzcq5JJAAJ7F7e3yEdcQ7hBFoonNlKOJfCNWBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175603; c=relaxed/simple;
	bh=0NsI+ZyIRtjnKvnH4Wvu3kscj85hk2L/kVBiD8l4ewc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IEPg2j1NLGEU8Wwc1RpsOpav/Cm9xfRoDoz4eFsbzp6LO1tLI7F6VrmgwxJZOEJiaHHXBMPhkaSqUX/SYPHR0S7oO1350aHpNcGvc3IyNu3b0kh22RctSyhbLbX2XiPNVUNDFzZFIHA+Hy3OzQB2tcmCjKSiGtJ8P/nfkVHC2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M84hHchB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M84hHchB"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d7a5e77b1so1307485f8f.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776175600; x=1776780400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aB7aMiouecPtkSS6RdW283OaNe+t7lG/bWSzV8W/z8o=;
        b=M84hHchB4vMMpiC2mTbSUPsAKuEyh1PG+K5LeG1EHB8Q67VAEr7XPy5v9lpKu9lfxj
         RTiMMQynb0BgtCoR5tQXtKiHx1PhL2QREz9h3cTH4FKuC78/w/vtAlWfzsULG2Vhhg/y
         0ZS7wjMDjXqaeMLU7Onz71s2f6Rb72gNDJ3lxm1L0lgbju8LRIDUZ+JM7Il6tdyjnYst
         ZnMV1BLih5/PXqP0GEClSdrlJMIg9Nmnb58UqSaxCtpAWSr7olFDp09AcN1VhVWas/PB
         gnKGSotRo3/xzPBGzi2I7E1TUaL4jTRM8/SQ1Qn/z609MxKlKBl68KF/nvffUBBxfn7C
         C+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175600; x=1776780400;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aB7aMiouecPtkSS6RdW283OaNe+t7lG/bWSzV8W/z8o=;
        b=m7oQgcXxD0ZtEHGrqLyG+vetL4xUocif247Dx8gk3HCpDr3xuJNYTfNG4QqtfQ5L0l
         VYxg3BlijZRMUzB84s+bHyxynKnJpETtI5D1CHxZtv61EZgVUBHxwTeJUJXloOCFrzlk
         uDszuZ6wexRCh9/hory8xKMeKS6sR1UIDytd6HsrMEMz9HmLlZjw2SCGQwL9hPbAIKNK
         k70a8/FRiwiXbY0iK0iiBdnnoNOWhyPbxR8O8AxYeV5c/bb3OJeSLrx2Y1+Pk77AEhkE
         3bIkVB4YOmUEQhHj6PYiYqSsNC3xmvna0RaELznI7wOgbdmZl8g2OaHWstDpn5O0wiFQ
         g4+w==
X-Forwarded-Encrypted: i=1; AFNElJ9DaHUqyfvPs2RQF7ti8PCbUH5k3FAOok1eO4LH6vb1kZneTREyTPOGGZ5HS3V9K4Ypki4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdHD94Uc0U9HZHs0ySv/4Rwqlt6gFrnGPMqW7cLqRDKTYWc6+b
	m+Pou/eOaw34L2NpOCiLTVvaFm65D6ITwGZUGJxemORfeXWLtvlyQLpO
X-Gm-Gg: AeBDiesbZd8euWm9O8/q9swy9JlZ24+ooBsJvEjZPBT0sLROEovopxdU/QuYMZIHvdo
	JOwTb13gie+KQty+/dOFj4cNMDe2phxxdmC4nxvodjYeU7GZTLskxRcC9GnubMHMSroEe+1Z+6Y
	hytel7s9eJ8Tdp+O6Qt8ipeiowQFGx6bTdJClBDZdchEiud8mtPCB26GLZ8pjzN8Vlifg7BWhLv
	0OSZrnJa8NafSFwyD0eijd/C7tvPrgJfZ4RLrwnWi9LnvFzRc13LzECSzBhFiV7SawIa4K0aWnQ
	tFAHf9pBX0IGwHRuQRKPJaXGQzIrpjIDglaxEJ9va8L4PNUqqQEMqGx9sihE7EmLcwO/teTh5Kr
	6R4RMtQT0O214Kd/w3cuOASoYwbpHNU0q6CAzix/61knaJjdCp2TDeNZxLicRyVbU5Q8sKEb6/J
	Ftf9iyc+zkSTcI02cyxoppQFGm3w3cYnds+EuUStlas4/iIEWIyfpbMP0C75q5lJT/EX3zcEtp6
	YQ=
X-Received: by 2002:a05:6000:1619:b0:43b:97d8:9a40 with SMTP id ffacd0b85a97d-43d595c4e3amr23302486f8f.17.1776175600213;
        Tue, 14 Apr 2026 07:06:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5061fsm43567169f8f.30.2026.04.14.07.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 07:06:39 -0700 (PDT)
Message-ID: <ebb65b1d-879f-4d9f-b25e-fe1c58a47ff7@gmail.com>
Date: Tue, 14 Apr 2026 15:06:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v12 3/4] sequencer: teach autostash apply to take optional
 conflict marker labels
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
 <pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
 <4593745e90d7c897463fcb4835ecfac70a088b8e.1776171585.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <4593745e90d7c897463fcb4835ecfac70a088b8e.1776171585.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 14/04/2026 13:59, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add label_ours, label_theirs, and label_base parameters to the autostash
> apply machinery so callers can pass custom conflict marker labels
> through to "git stash apply --label-ours/--label-theirs/--label-base".
> Introduce apply_autostash_ref_with_labels() for callers that want
> to pass labels.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> [...]
> diff --git a/sequencer.c b/sequencer.c
> index 780628aab4..c2516000bd 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4732,7 +4732,10 @@ void create_autostash_ref_with_msg_silent(struct repository *r, const char *refn
>   	create_autostash_internal(r, NULL, refname, message, true);
>   }
>   
> -static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
> +static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
> +				    const char *label_ours, const char *label_theirs,
> +				    const char *label_base,
> +				    const char *stash_msg)

I'm confused why to need to provide a message when we're storing an 
existing stash that already has the message that we want to use.
> diff --git a/sequencer.h b/sequencer.h
> index 5d3bc83314..b0c891d3b6 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -237,6 +237,10 @@ int save_autostash_ref(struct repository *r, const char *refname);
>   int apply_autostash(const char *path);
>   int apply_autostash_oid(const char *stash_oid);
>   int apply_autostash_ref(struct repository *r, const char *refname);
> +int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
> +				    const char *label_ours, const char *label_theirs,
> +				    const char *label_base,
> +				    const char *stash_msg);

Do we need a new function, or can we just update the existing callers to 
pass NULL? In the future I think we'll want to pass better conflict 
labels and updating them now to pass NULL makes that easier.

Thanks

Phillip

Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B1C29E0FD
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835579; cv=none; b=BH52dgKEB6wPzbkApz9ZlEn8kalE+VT3uBJwx0R1sBOiYOpJBf0EPnn0ZRP4eci61i9PY0OmhBbiKR7A8A9J6cDrAjpqAk0feVNQif46XMxtIp4MtpaH9szhfKc6kRNNQ7/zt0jFEUx07qL1p5DjGCp9p7QYcehld+gQHWqs2Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835579; c=relaxed/simple;
	bh=fzp+jYY1oEI+5jZUbeiCL8OL3MmQyQo8nq2Caz35s10=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uG2xVnpNDVKLDogAAYArR698Sa+K2WEG/WMxxsKFpwaLNnwcFBskVKaASQqbMAyZKvWJGG6JYyX0nPZVjQcQ+sjVAwdvNOQkuYpj43Al3XriVjr3hWQtUUguskkHL7BiIPmviQX0wJgKOlwcL/tD1Ag3W680SdhtZPSODHgCqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cL1vXZM5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL1vXZM5"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfbd17589so1529420f8f.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775835576; x=1776440376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4TCm897jaRhwp+AUci+qu87E+eGqX7XMg/oWi27/nM=;
        b=cL1vXZM5CSTbjeDnffjOlx5j6BQjQcWPrwWUJcq+a1Q0G2wt29nhtnALv9WsddK5lD
         lW4J9JfunW4T+W8cVLrJx8kDvZsBQWDbUQV6kEPFzxKu3NdSb0J4rn3WBNYuEdfnQNTX
         zs3ECsVBRKI0ExEz2m2eEYOnqdiRv2dZCtcZ2et2iwcLs4MGj374oxYtYu7k9/ItKIhF
         sJxNeoq521d9thTOUAfsu4sf+a12Le8ACbsNgWVd8rxktJtwKhGLt9dsAkboK7KfuWgZ
         IY6a3H9Zvedl7ayleAbFHYiqs11VYMTOFEIh85V0LvcVn09E4UNqCv0XzRk9KxmF4In6
         jAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835576; x=1776440376;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4TCm897jaRhwp+AUci+qu87E+eGqX7XMg/oWi27/nM=;
        b=sGq4kNgDsDGJ3HYC9mg0ydzt5syfauI7//zQ+CLIURqARlwl2oHYk150PyhrmWkkBh
         RZmaXl+OHHAxAJ3R+S4dwWgdbxbEv82uyZzFfeu5v+qMFnLHBzyC6Rd5hBoifC4OFQPz
         DB/vHl4Cdi/I3+9z40abDhNhH4rzTV76hYw9/iSH2sYenW5aM0Up+r0a4ww6oxTndg1h
         l5vDdUP+65nN5vGbJlOxiASKJpr7c6ajZIkzfrbBgbkNZQvrzQcA0gXTnEV61Pggu40T
         Xdn9po0yjHgi8KH6H1pSq5IDsUWgpHM+RGARYQEe9rucJERQouHXULVPzaTAsTSC/X60
         bnUw==
X-Forwarded-Encrypted: i=1; AJvYcCVAGxYjROqLrQPP0l/L7YFud6yp3IzY6Gb9sZ+X1rnOAwcNC0V+UzsMiofyK6HqvLMbJmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+XvvzVBOEXsmkyFYvdrnnjxycJiO/TC0IJTJ6WMOyZKNFv2Kq
	F0htvhXUoar9FCJ8uwb/Klkq8rOHqCtO2AvDtz+MkC/TzfDqDgmMxKQQ
X-Gm-Gg: AeBDietACjf6aQjrQ02QRrevBawIq1H01k8tGHVafJADKQ59BUSASJlk0NJUNhJNaJk
	pM4YAXWypQWsXMg085Ba+MUZ98pd962uZkOjwA7hP1IXXkey08LYBlCwDsMdz0atisl51dhGYpd
	h22qQ2hWQKxBauan9Wd8ZYmeUC+iX627SEVtPsqWdSjowvXz5G3t05bA60D2xcEmQukawT1T4od
	6AhUZaZflkibGc6vkMDoqSzB1yLIa1FiW6jSEjhv3RwfQSaV47ZgP7QkwAxp2wPBgY/+FVvuvdf
	AmI4n1CTxf5zdQqYjQQVgJdIonsU0fXGfOuEL9ZpThNm0qoQ9EGiy5es+MYY/PoxMBtI8SuPV0f
	TfFNqqyrenon2NYzJE1LvudmVz2oHA+j1EebocLAbWXPTHQ1NlA7icEuORl/kWObjJIKNAP6tcW
	nqquGZ7k/YvQ2Ifc4IQY8mombdF9vI+ukLAIpBjCaoDzgPiSL3ObzbRxGY3d4J1gIZc9ZY76Bru
	vs=
X-Received: by 2002:a05:6000:208a:b0:43d:50c:6f2a with SMTP id ffacd0b85a97d-43d642aba5dmr5420269f8f.29.1775835575861;
        Fri, 10 Apr 2026 08:39:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46a85sm8277642f8f.24.2026.04.10.08.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 08:39:35 -0700 (PDT)
Message-ID: <a93e990d-f702-4edb-958d-eab11dc5c663@gmail.com>
Date: Fri, 10 Apr 2026 16:39:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 3/4] sequencer: teach autostash apply to take optional
 conflict marker labels
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
 <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
 <78300e0e9a8beb7ffb28a38a5e203556b2df9d56.1775762235.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <78300e0e9a8beb7ffb28a38a5e203556b2df9d56.1775762235.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 09/04/2026 20:17, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add label1, label2, and label_ancestor parameters to the autostash
> apply machinery so callers can pass custom conflict marker labels
> through to "git stash apply --ours-label/--theirs-label/--base-label".
> Introduce apply_autostash_ref_with_labels() for callers that want
> to pass labels.

This looks good. In the future we could use this to set some better 
labels for "git rebase --autostash" but that does not need to be part of 
this series.

I'll leave it there for today and take a look at the last patch next 
week. It would be a good idea to wait a few days to see if anyone else 
has any comments before sending a new version.

Thanks

Phillip

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   sequencer.c | 34 +++++++++++++++++++++++++++-------
>   sequencer.h |  3 +++
>   2 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index e500a94a59..e28d30ff7b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4729,7 +4729,9 @@ void create_autostash_ref_silent(struct repository *r, const char *refname)
>   	create_autostash_internal(r, NULL, refname, 1);
>   }
>   
> -static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
> +static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
> +				    const char *label_ours, const char *label_theirs,
> +				    const char *label_base)
>   {
>   	struct child_process child = CHILD_PROCESS_INIT;
>   	int ret = 0;
> @@ -4740,6 +4742,12 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
>   		child.no_stderr = 1;
>   		strvec_push(&child.args, "stash");
>   		strvec_push(&child.args, "apply");
> +		if (label_ours)
> +			strvec_pushf(&child.args, "--ours-label=%s", label_ours);
> +		if (label_theirs)
> +			strvec_pushf(&child.args, "--theirs-label=%s", label_theirs);
> +		if (label_base)
> +			strvec_pushf(&child.args, "--base-label=%s", label_base);
>   		strvec_push(&child.args, stash_oid);
>   		ret = run_command(&child);
>   	}
> @@ -4784,7 +4792,8 @@ static int apply_save_autostash(const char *path, int attempt_apply)
>   	}
>   	strbuf_trim(&stash_oid);
>   
> -	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
> +	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
> +				      NULL, NULL, NULL);
>   
>   	unlink(path);
>   	strbuf_release(&stash_oid);
> @@ -4803,11 +4812,13 @@ int apply_autostash(const char *path)
>   
>   int apply_autostash_oid(const char *stash_oid)
>   {
> -	return apply_save_autostash_oid(stash_oid, 1);
> +	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL);
>   }
>   
>   static int apply_save_autostash_ref(struct repository *r, const char *refname,
> -				    int attempt_apply)
> +				    int attempt_apply,
> +				    const char *label_ours, const char *label_theirs,
> +				    const char *label_base)
>   {
>   	struct object_id stash_oid;
>   	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
> @@ -4823,7 +4834,8 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
>   		return error(_("autostash reference is a symref"));
>   
>   	oid_to_hex_r(stash_oid_hex, &stash_oid);
> -	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
> +	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
> +				       label_ours, label_theirs, label_base);
>   
>   	refs_delete_ref(get_main_ref_store(r), "", refname,
>   			&stash_oid, REF_NO_DEREF);
> @@ -4833,12 +4845,20 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
>   
>   int save_autostash_ref(struct repository *r, const char *refname)
>   {
> -	return apply_save_autostash_ref(r, refname, 0);
> +	return apply_save_autostash_ref(r, refname, 0, NULL, NULL, NULL);
>   }
>   
>   int apply_autostash_ref(struct repository *r, const char *refname)
>   {
> -	return apply_save_autostash_ref(r, refname, 1);
> +	return apply_save_autostash_ref(r, refname, 1, NULL, NULL, NULL);
> +}
> +
> +int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
> +				    const char *label_ours, const char *label_theirs,
> +				    const char *label_base)
> +{
> +	return apply_save_autostash_ref(r, refname, 1,
> +					label_ours, label_theirs, label_base);
>   }
>   
>   static int checkout_onto(struct repository *r, struct replay_opts *opts,
> diff --git a/sequencer.h b/sequencer.h
> index 570f804457..2c4ff17c4e 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -236,6 +236,9 @@ int save_autostash_ref(struct repository *r, const char *refname);
>   int apply_autostash(const char *path);
>   int apply_autostash_oid(const char *stash_oid);
>   int apply_autostash_ref(struct repository *r, const char *refname);
> +int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
> +				    const char *label_ours, const char *label_theirs,
> +				    const char *label_base);
>   
>   #define SUMMARY_INITIAL_COMMIT   (1 << 0)
>   #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)


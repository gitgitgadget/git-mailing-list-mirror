Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0799A33F38A
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835571; cv=none; b=jkKlrLQ+IJtxPiICIH1bab4+NKHxAEreakQIU+VA9jO2mPRHWbWmN6DBobnO85BDHqAuHjf+jDLBhaGzFln1fDPrEh1Z9y27BFf6nqoYyoU0pbViwi3M/zo7WRU844WmK+sZ2sRHjQc5aO9IKtdd6SPwUW61XCMbfGfK/bOMbhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835571; c=relaxed/simple;
	bh=GStdbbel6oIryaTlY2cGajE6pKI8Nj9vYD4C5FNkg6A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cOC1op24oitdeaGcasFfgexh09DZ75JUJCQWKOM973yoF8zNYST++RI03UVJuZMW3p54l3UQ4+Z1p3kRwdYQ1TLf00SmuSaRPOsAcp8bUz2ZIk+Y7kJYiL6U5GBtZ7eb3mWC2L9hlUZpb2I5dkHeRWto5Sze6Q9310Ujja2xpic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi/8/tCN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi/8/tCN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso21276225e9.3
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775835568; x=1776440368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWkqU4bihxoYRionuAhy1pZzB7mi7YIrDCClxbAv3OI=;
        b=gi/8/tCNkzsYY93GuZyJdgrWVGfFeBvVA2eSzBV1j8hfpjdyJSOwWUAFuNBuBJSSQi
         w3G89vMXhQw10p6QW7Mj0Yc0/QvfsrZ/HGQnV47Dqazlsee8JDUlFQ65Pk/+/Anymp6Q
         aj/XS68IQsIyOydQZrHAzygmpXBOFqpQQtqckQz3PXl/vBOS4sedme+ICO9C2j5Dbyec
         TOvhG4BDK5YEU9XF/pVv+2bMNRenF67jdJp1xsPMYJDKa2k4e054hk0rc9r3vz9vCy8X
         02NgQAOqpPCGdIqozlXTZw5+6iRkQqFHr1JzmRD+cweDFKHzaK3jmEmi5kiJnvnctC7V
         21rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835568; x=1776440368;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWkqU4bihxoYRionuAhy1pZzB7mi7YIrDCClxbAv3OI=;
        b=gqjThwm/J6ERszfv79yED/P/RWlVXu4+YATuOZ2jF9xmSCFoVROPCvDSa7OWvIBUsP
         r7Qpr2tl7E/bGtctOoZRm/linfcSiXyUlcMXzMQqTzDHrfoyVghVRm9FszwQomYHPzY/
         vKUITS4MVwhebV+QrmlcmJ0Ue35cLRkWz2D/vS5KlwU8zJ0q6TnhtRlnJRwObu1LHWkN
         VXMFx8+i6iSdCemdxxJbtTABojsM2Kemabe88MSNyf8w0tCXh8HbbSUDUadPKFZse64C
         CDyF+N+Mgq11keEf+F8xA/I6hw1aEk3D/iv33gAyQH3ZPTHIe7RymccBJdeZCGFGmE14
         em+g==
X-Forwarded-Encrypted: i=1; AJvYcCVhGqodkqHGzxXBrE7GSTo1V31Z1JLpQy3fhhzaUaiCk+J8r/fuUlnG3vv5v3qVXao1jxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ltmskTiBbTbBOP7vp+yK6qCAKLdPTj9P8/Mqvrps7EHLP0fu
	GosVjNC0hr7ozmohD8giuYTmwI3BVWKQZg1497AbXN27xwvXncSryUSZ
X-Gm-Gg: AeBDieshXzV0xJw6+JUDBpBELDnq8Ff/yH6oGkmJTpO69Mdxr44uLIrTQJYikAl846U
	e3qfo95HAS/Ttn2IO0xcxzoc7hX5yAy3wyPR7UIu+fSRyaVJk1d8FyHB8AM0bIy40uJqKPlfa9P
	o+8LH6Jdxea0/e3ESHAc9Hf4z7pFxK+HVh2dDR+1otm613lSAPQA39JiRAGyp26fsr3dxvpXAVI
	IrxKofuje6R8v8JovO919jTW6QJI4GA21qD8TZUnA9wsPzSIRjKSFHlGIOuEj3+VIu6tQIKuby9
	WbpwOdY4FKiiTapIJgq7ttIKjN1soJ3Q5m2R2x/AibguaHHesVdUFVWDsU09EPE9vvjIeI109rG
	JNwYmUgLpHUwdhwyLHhtrNdLhInXf0o/Yf5QYMhh6GKFSPmCRk6azdcTF6g2jsSQjHS21i92xX/
	Pzt+Cmt2Mh1ejYDJzR1UTtgfl1v6hDaMdMP6eEjgKHMIbiIl1J63HNhexXtiTjGjJrSvoFnAITI
	8JVupm1EpMNQg==
X-Received: by 2002:a05:600c:890e:b0:485:3dfc:569 with SMTP id 5b1f17b1804b1-488d683665dmr32570215e9.16.1775835568171;
        Fri, 10 Apr 2026 08:39:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d68585sm39277695e9.1.2026.04.10.08.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 08:39:27 -0700 (PDT)
Message-ID: <f8902ea9-8b18-48b2-9daa-08c7324e60f4@gmail.com>
Date: Fri, 10 Apr 2026 16:39:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 2/4] sequencer: allow create_autostash to run silently
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
 <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
 <86cf68d0240ef90ce941cc162ada658a5058795b.1775762235.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <86cf68d0240ef90ce941cc162ada658a5058795b.1775762235.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 09/04/2026 20:17, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a silent parameter to create_autostash_internal and introduce
> create_autostash_ref_silent so that callers can create an autostash
> without printing the "Created autostash" message.  Use stderr for
> the message when not silent.

Why do we want to change where the message is printed? It is not 
necessarily a bad idea but it would be helpful to explain why we want 
that particular change.

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   sequencer.c | 15 +++++++++++----
>   sequencer.h |  1 +
>   2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index b7d8dca47f..e500a94a59 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4657,7 +4657,8 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
>   
>   static void create_autostash_internal(struct repository *r,
>   				      const char *path,
> -				      const char *refname)
> +				      const char *refname,
> +				      int silent)

This could be a "bool" and the users could pass "true" and "false". 
Apart from that this looks good.

Thanks

Phillip

>   {
>   	struct strbuf buf = STRBUF_INIT;
>   	struct lock_file lock_file = LOCK_INIT;
> @@ -4702,7 +4703,8 @@ static void create_autostash_internal(struct repository *r,
>   					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
>   		}
>   
> -		printf(_("Created autostash: %s\n"), buf.buf);
> +		if (!silent)
> +			fprintf(stderr, _("Created autostash: %s\n"), buf.buf);
>   		if (reset_head(r, &ropts) < 0)
>   			die(_("could not reset --hard"));
>   		discard_index(r->index);
> @@ -4714,12 +4716,17 @@ static void create_autostash_internal(struct repository *r,
>   
>   void create_autostash(struct repository *r, const char *path)
>   {
> -	create_autostash_internal(r, path, NULL);
> +	create_autostash_internal(r, path, NULL, 0);
>   }
>   
>   void create_autostash_ref(struct repository *r, const char *refname)
>   {
> -	create_autostash_internal(r, NULL, refname);
> +	create_autostash_internal(r, NULL, refname, 0);
> +}
> +
> +void create_autostash_ref_silent(struct repository *r, const char *refname)
> +{
> +	create_autostash_internal(r, NULL, refname, 1);
>   }
>   
>   static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
> diff --git a/sequencer.h b/sequencer.h
> index a6fa670c7c..570f804457 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -230,6 +230,7 @@ void commit_post_rewrite(struct repository *r,
>   
>   void create_autostash(struct repository *r, const char *path);
>   void create_autostash_ref(struct repository *r, const char *refname);
> +void create_autostash_ref_silent(struct repository *r, const char *refname);
>   int save_autostash(const char *path);
>   int save_autostash_ref(struct repository *r, const char *refname);
>   int apply_autostash(const char *path);


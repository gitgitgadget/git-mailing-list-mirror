Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69672EA151
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059238; cv=none; b=A/OwEtXlDDT55RqdKS5lkifTcoSB+F7Jg/J7Lpq+GNAy+wYUh7SLHTKgEEI6KYwrv6RUs+HuZLSDJ1PCEAS5tIiNgjFk2LzjxW+MHZ9W3zofD3AeLGTV245465B1OC5AZBCE5kvlzjw4oi7WezQuIf4RsodGMBHFGGERRB6mnAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059238; c=relaxed/simple;
	bh=uLh+kejsRzFec8cE9lwb463aH+9es466vMYxcKUSqsw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z3pA+QGLkhc/jMBBcZMLB0ZblLj5fj2PHpN99sWeTFoAX8NA7SedCwBobDWXBQfHYXbeR19XAxCS72Sj+vgPhreRwIrcMswCUYumoVNjvaL3mLtnxn7mYUc/Kvps1s6FgFbaUin73k2/rsBnJCom0NVz8Z0D58uGyu9gpg1Ep48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJuS8EaX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJuS8EaX"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66c24b42efbso4158163a12.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775059235; x=1775664035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eiQL4UVyKuYu4iQQHxVdgF713Id06kPm2B0p3nLn19k=;
        b=pJuS8EaXggCWfu/Cx7jAaHIyFFVhXz7KAWFGiU9m1Je8naF/g50ssI/WoaIHRBQMU2
         kFi42JqlCDob2TnPOSl8adAH3TCZhZg5rXyqv9LKzc18VFqw3xHgj/XUNrNuXDGZJm/J
         ixM2ApoLsfLUrnKLD1iYsvNJK/XmJJurWa4CKqtGbg9yKxhMce256ba3bwBz0UQf2r88
         arw6YW8Zi5TbnaCE9Xp/0gA3wuhBHS6JKh/IOOdp1pPvGRf/4/wu4z3ez2GnyFz4w/s1
         //RCmMP87Gb/1SxdBGg3jZkXN1ZcsPZDsFnaAeU6vxB9tyvdkq8qujMAcCORtxbB/nqP
         Jn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059235; x=1775664035;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiQL4UVyKuYu4iQQHxVdgF713Id06kPm2B0p3nLn19k=;
        b=Gn0ckSRhSwQv3sPntwSu/bznYanXF5KSB9laWE6BqLfGZSYdKZq7rNnI5uq1N4fi/9
         DFzZyK7Y6WcZ4ljLXJQ7zW1TO2RNgDtfo2RG/g/2LLKpeSYR33GnYLb8qrKFLvsiKYp1
         tfYtUAnK+nBVHPRXpuZYkvBglCwM9VBJKsbfqmpLRyk+ipdFyHnjXB6qABPpVWVdSYo+
         i3CWQcCzMfQShZ/yftcVwjSOMx4kB2V4KHY0OZ/tRbI2a3bqnmadi0Ikm8uAxAlfDlCx
         nEqxnFi89XJMOWfM0tJnaaC5yzguiDzdLWIuh5hT75xoU5cNo6fvDsza4l+pcrz/s+Z3
         9FbA==
X-Forwarded-Encrypted: i=1; AJvYcCUVZtwA6mohRaNMeQBQh37iydEETv6M9mdZZFJfJazoswQ3vuOaQec2x+KgGZAI3CgzGIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoN7lZqzMz3pWUcvVVld0eEg/qBZAE7lLa577hPNiB8osxHjcY
	tTUHE2ydeyxBFHklDZJmTj0oa2rUMytyJWzLMvQzT7iZo/NxpVnvhB1e
X-Gm-Gg: ATEYQzwwsLStZdJIldiqN0EpgEM69GFKq8wFYR5C1kIJUwe+3FggYxYLThNfiZ8ScBW
	x7n3ApTqwqOl0Bh0w8ByYAgjXBtKG3j6qngtZiNZYUk3ahnjAiO8MeM/SZMWTuxc3iVgqQZFh5m
	mRk74YICGldbO12bMtjq4qmstMTSNHjIkrxNksFp69JugnYXAy3JdS+j+Pd8QmGv6OXnqBc7KQe
	hUUydCYkG6U3s7VlHgeRHh/Y7UvrLHM+bccwhacxe7miu83+5wEj3+TmsWujSQDV9/jdv3KMx9v
	adWaSsRUh1i0IOaSc6Zyj0cZllnw9+sNbxWO6al+s4+OrKO9CrSKUIIJgQFHrJ3Fm0KI3ewZotG
	QMJD+lrQjdkelQm3ewcJU20IYOmgbBKCnem3HUdSjxOMsXkcOgnyYb52TgLGB0ccXcLtF6vP1X8
	fVxIh8KSNtWYgHBGPfp/nryreUM9WDn/Y6oi/LaF97uqar+VVog76vN5E740v1bZDbct4m4p1x3
	yhu2WQWxXs=
X-Received: by 2002:a05:6402:52c6:b0:66c:17d5:c18f with SMTP id 4fb4d7f45d1cf-66db0af2c64mr2186070a12.21.1775059234835;
        Wed, 01 Apr 2026 09:00:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:392a:d0de:96a3:bdc9? ([2a0a:ef40:7d8:fa01:392a:d0de:96a3:bdc9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b75ba9395sm4760193a12.14.2026.04.01.09.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:00:34 -0700 (PDT)
Message-ID: <87a54698-396d-4de8-bd9d-cd72f8d1e8df@gmail.com>
Date: Wed, 1 Apr 2026 17:00:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 6/6] xdiff/xdl_cleanup_records: simplify INVESTIGATE
 handling for clarity
Reply-To: phillip.wood@dunelm.org.uk
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Yee Cheng Chin <ychin.git@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Jeff King <peff@peff.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
 <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
 <fd14ccafc494aeda4bb9d05b83ac09f35bec8b52.1774890003.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <fd14ccafc494aeda4bb9d05b83ac09f35bec8b52.1774890003.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/03/2026 18:00, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Make it clear that INVESTIGATE is turned into KEEP or DISCARD based on
> the result of xdl_clean_mmatch() which reduces actionX[i] into a
> boolean value.

This patch changes the diff output. If I compare the output of

     git log --diff-merges=1 --diff-algorithm=myers -n1000 origin/master

with git built from 702083c4820 (xdiff/xdl_cleanup_records: make setting
action easier to follow, 2026-03-30) and from 7ff1460b62f (xdiff/
xdl_cleanup_records: simplify INVESTIGATE handling for clarity,
2026-03-30) I see the diff below. I think the problem is that
xdl_clean_mmatch() depends on the action arrays and this patch modifies
them because it converts INVESTIGATE to KEEP or DISCARD. We can probably
work around that by using a local variable rather than modifing
actionX[i].

Thanks

Phillip

diff --git a/tmp/p-sub-KADADDFP b/tmp/p-sub-PDCNCAOG
--- a/tmp/p-sub-KADADDFP
+++ b/tmp/p-sub-PDCNCAOG
@@ -4258,14 +4258,15 @@ index 6485cb67068..0ff2e45aa7a 100644
   		ctx.progress = NULL;

  -	ctx.to_include = packs_to_include;
+-
+-	for_each_file_in_pack_dir(source->path, add_pack_to_midx, &ctx);
  +	if (ctx.compact) {
  +		int bitmap_order = 0;
  +		if (opts->preferred_pack_name)
  +			bitmap_order |= 1;
  +		else if (opts->flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))
  +			bitmap_order |= 1;
-
--	for_each_file_in_pack_dir(source->path, add_pack_to_midx, &ctx);
++
  +		fill_packs_from_midx_range(&ctx, bitmap_order);
  +	} else {
  +		ctx.to_include = opts->packs_to_include;
@@ -50839,7 +50840,8 @@ index 41b0750e5af..acaf42b2d93 100644
  -
  -	if (opts->in_place)
  -		outfile = create_in_place_tempfile(file);
--
++	read_input_file(&input, file);
+
  -	trailer_block = parse_trailers(opts, sb.buf, &head);
  -
  -	/* Print the lines before the trailer block */
@@ -50848,8 +50850,7 @@ index 41b0750e5af..acaf42b2d93 100644
  -
  -	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
  -		fprintf(outfile, "\n");
-+	read_input_file(&input, file);
-
+-
  -
  -	if (!opts->only_input) {
  -		LIST_HEAD(config_head);
@@ -58880,12 +58881,12 @@ index 776de5356c9..84a31084d38 100644
   	odb_prepare_alternates(odb);
  -	for (source = odb->sources; source; source = source->next) {
  -		if (packfile_store_freshen_object(source->packfiles, oid))
+-			return 1;
+-
+-		if (odb_source_loose_freshen_object(source, oid))
  +	for (source = odb->sources; source; source = source->next)
  +		if (odb_source_freshen_object(source, oid))

Thanks

Phillip

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xprepare.c | 34 ++++++++++++++++++++++++----------
>   1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 471d9567c9..1f2e8c6b4b 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -329,24 +329,38 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	 */
>   	xdf1->nreff = 0;
>   	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
> -		if (action1[i] == KEEP ||
> -		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
> +		if (action1[i] == INVESTIGATE) {
> +			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
> +				action1[i] = KEEP;
> +			else
> +				action1[i] = DISCARD;
> +		}
> +
> +		if (action1[i] == KEEP) {
>   			xdf1->reference_index[xdf1->nreff++] = i;
> -			/* changed[i] remains false, i.e. keep */
> -		} else
> +			/* changed[i] remains false */
> +		} else if (action1[i] == DISCARD)
>   			xdf1->changed[i] = true;
> -			/* i.e. discard */
> +		else
> +			BUG("Illegal state for action1[i]");
>   	}
>   
>   	xdf2->nreff = 0;
>   	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
> -		if (action2[i] == KEEP ||
> -		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
> +		if (action2[i] == INVESTIGATE) {
> +			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
> +				action2[i] = KEEP;
> +			else
> +				action2[i] = DISCARD;
> +		}
> +
> +		if (action2[i] == KEEP) {
>   			xdf2->reference_index[xdf2->nreff++] = i;
> -			/* changed[i] remains false, i.e. keep */
> -		} else
> +			/* changed[i] remains false */
> +		} else if (action2[i] == DISCARD)
>   			xdf2->changed[i] = true;
> -			/* i.e. discard */
> +		else
> +			BUG("Illegal state for action2[i]");
>   	}
>   
>   cleanup:


Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5F136672
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751013275; cv=none; b=ZtAuej7vRjHlLMrgai8s/gh7X4H/EexwW2oTV8dp6lyAGtqS88cnVbJWpw5EXVklZ/QCv6fwnci8ryo7r1Gerz0YrDv+Ip8T8rl4wG+yI9ygMWbaVHRE61CywKPsOe30gQhdcS2CkOAtHQ3v7DUspcfb5QcwbPbN6knHoIYoxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751013275; c=relaxed/simple;
	bh=qJz+jMvhfOhFxqVvetSFGNYEnlX3muCbAG8xKsRtD4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRDp4IhnMuoCkJ8GCFnSpQx0axOWuZ0HuE1WgBPyG+NTS5+Xhxj7NWmRpGTfnNzEQ+qXn3JCu0EM8NreqhqTU1YA64avuy0a20jGau/7dWZQBsTzvxXTBycnqrEz1MQEbkVPWBEdENz3BQyvZiUeHe3X4NWvDwudx2JOHVkRfyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYOI43ls; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYOI43ls"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1876487f8f.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 01:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751013272; x=1751618072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=391gO96RlJP8Gs63TjlsLHUQ9NjXJfPZ+J46RTnkpPU=;
        b=OYOI43lsnIKuCeKCKziFDPRtmvqbkzki8juI4DvpY2kCau3KIiB3pTOyx+SkFHNUL2
         qBZxKMgSKVzIOwaFOwhUS6J1RfgkeHxQcOLhj5vB/hy94q0CFUTQS+xch1bN9GwEqqAF
         Z/7+JiF/RFV83Gl1FZNYu1vgqfbPkUo0D0RENDtSepKMqXP0IEbI3ffItwM912M8Tt9J
         C4vhjuanUtL49qvY0nU9LhFnf6ZZK9oZfBJQrqzMy45K2GhdD4MatGcdrEsGI70oJrSg
         L8oLMlbuOfwdTelmHNHyDYC90do4qToUmU/NjVeVLUAErMUc49GFG1/i5h2E+fMB/Kex
         QhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751013272; x=1751618072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=391gO96RlJP8Gs63TjlsLHUQ9NjXJfPZ+J46RTnkpPU=;
        b=W77Tgw2dxkz9DT7RXN9EVuouhIWQLA6+iVTDOTYYDMuS3sDMNadm6CZe3EsPtAAAIK
         OUCQFVluDBWmtQeqeFp5+dNT7ihJrrQMsmL4qkHh7CPbViBPhB36I+FTn0KqUgrGyfJ7
         CYjDl3uMDcNY5LOOBWnCglJca8Hvs9qKy9M/X1EZaZFzdHHqLQcTZ/vOI/jaBzoGE1Xb
         GTfCxa+csuW+PWfRRhECGO7lOspynHqcUo6RiemJSoRG63uhz6O4BDS8pV93BqpkxElX
         yq45XQYPiA0JJHui5KDslDJS1IpblFycOAXT6R2GAPxQqGvj/FKSOLP5oMZa1UBIaoR+
         Cidg==
X-Forwarded-Encrypted: i=1; AJvYcCWoHfkKNKl9pCERHDC+fOJRBLBUOaaZDfdz3ob8iYnV5Ch5pVuCn1/KGUpgn6ArX+rys/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM4CGP1GPnpS4s9G3osFhh0KT3IbV4ebsP2XVhtJkgat6HSw+L
	QGiyFcc/h4h6MPZ8OtzsLgppg7QEuOarOZyzSnngZxofwCFYuf/lp5y3
X-Gm-Gg: ASbGnctT5Kuj65V5FX5o3RBnXRzrWsMAMOs6WjTiRz9dKRSoaDq+TyjCLYLvuMt7GsT
	fH/2V6kWDRPJDkAY8EC330/LqmfoA55aj8zl5XY9+cXph051DqNLn6S35g95T41Jna2ePEcAI0S
	SivQ7FJBmF9/6v1VIeBvVDOzmi/Vfn2dJwpdHbFb8Cm+KkLgDUPCytqcvepOtuJe4QcrjbWHUvz
	JiRigHFXVqXCKwoJAG2UGoKQe5wBjWDNQSRqK4lZAv6+S7VkxWl4nry2BtG1yBxSRbQ7BreK8vE
	/mnnL4wk0M2fNTBK3jSOfCtDojPs3ZpIWDJUEtRld2JLvQhdpkpT+unmARpQrTJT+G1vPnihXZm
	zpwHw4Oh3dNh4yJArV35UEd7mLh/dXXbbY9p7WtLgYeG/wcPu
X-Google-Smtp-Source: AGHT+IGSl+FHPyibz/Sb2JZRUdHO4mukS5Qb0TK87lABog/2O8FTeiM+evUnwdk2o+APL7eBwGPKFA==
X-Received: by 2002:a05:6000:2893:b0:3a4:d9d3:b7cc with SMTP id ffacd0b85a97d-3a6f316232bmr5603405f8f.28.1751013271595;
        Fri, 27 Jun 2025 01:34:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a306a01sm45834475e9.0.2025.06.27.01.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 01:34:31 -0700 (PDT)
Message-ID: <91982162-b138-4bb1-81fd-6f9185801c99@gmail.com>
Date: Fri, 27 Jun 2025 09:34:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH v2] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org,
 shyamthakkar001@gmail.com, kristofferhaugsbakk@fastmail.com,
 gitster@pobox.com
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250626221631.457725-1-ayu.chandekar@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250626221631.457725-1-ayu.chandekar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ayush

On 26/06/2025 23:16, Ayush Chandekar wrote:
> When core.commentChar is set to "auto", Git selects a comment character
> by scanning the commit message contents and avoiding any character
> already present in the message.
> 
> If the message still contains old conflict comments (starting with a
> comment character), Git assumes that character is in use and chooses a
> different one. As a result, those existing comment lines are no longer
> recognized as comments and end up being included in the final commit
> message.
> 
> To avoid this, skip scanning the trailing comment block when selecting
> the comment character. This allows Git to safely reuse the original
> character when appropriate, keeping the commit message clean and free of
> leftover conflict information.

This is a good explanation of the problem. Maybe this is another reason 
to consider removing support for commentChar=auto [1]

[1] https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g/

> Background:
> 
> The "auto" value for core.commentchar was introduced in the commit
> 84c9dc2c5a (commit: allow core.commentChar=auto for character auto
> selection, 2014-05-17) but did not exhibt this issue at that time.
> 
> The bug was introduced in commit a6c2654f83 (rebase -m: fix --signoff
> with conflicts, 2024-04-18) where Git started writing conflict comments
> to the file at 'rebase_path_message()'.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> ---
> 
> Thanks to Christian for mentoring, and to Kristopher and Junio for their reviews!
> 
>   builtin/commit.c           |  6 +++++-
>   t/t3418-rebase-continue.sh | 14 ++++++++++++++
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index fba0dded64..63e7158e98 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -688,6 +688,10 @@ static void adjust_comment_line_char(const struct strbuf *sb)
>   	char candidates[] = "#;@!$%^&|:";
>   	char *candidate;
>   	const char *p;
> +	size_t cutoff;
> +
> +	/* Ignore comment chars in trailing comments (e.g., Conflicts:) */
> +	cutoff = sb->len - ignored_log_message_bytes(sb->buf, sb->len);

This finds the "Conflicts:" line. I was surprised to see that the string 
it looks for is hard coded and not translated, however the sequencer 
(also surprisingly) does not translate that message either so it should 
work.

>   
>   	if (!memchr(sb->buf, candidates[0], sb->len)) {
>   		free(comment_line_str_to_free);
> @@ -700,7 +704,7 @@ static void adjust_comment_line_char(const struct strbuf *sb)
>   	candidate = strchr(candidates, *p);
>   	if (candidate)
>   		*candidate = ' ';
> -	for (p = sb->buf; *p; p++) {
> +	for (p = sb->buf; p + 1 < sb->buf + cutoff; p++) {
>   		if ((p[0] == '\n' || p[0] == '\r') && p[1]) {
>   			candidate = strchr(candidates, p[1]);
>   			if (candidate)
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 127216f722..ccfe77af6c 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -328,6 +328,20 @@ test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebas
>   	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
>   '
>   
> +test_expect_success 'no change in comment character due to conflicts markers with core.commentChar=auto' '
> +	test_commit base file &&

If you used an existing file (F1 or F2) like most of the rest of the 
tests in this file we could avoid creating this commit and save 
ourselves a couple of processes.

> +	git checkout -b branch-a &&
> +	test_commit A file &&
> +	git checkout -b branch-b base &&
> +	test_commit B file &&
> +	test_must_fail git rebase branch-a &&
> +	printf "B\nA\n" >file &&
> +	git add file &&
> +	GIT_EDITOR="cat >actual" git -c core.commentChar=auto rebase --continue &&
> +	# Check that "#" is still the comment character.
> +	test_grep "^# Changes to be committed:$" actual

I agree that it is a good idea to anchor the start of the message, but 
I'm not sure it is helpful to anchor the end of the message as we don't 
want the test to fail just because an unrelated change adds some 
whitespace to the end of this line. I'd be tempted to drop the ':' for 
the same reason.

Thanks for fixing this

Phillip

> +'
> +
>   test_orig_head_helper () {
>   	test_when_finished 'git rebase --abort &&
>   		git checkout topic &&


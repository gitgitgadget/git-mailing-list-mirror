Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7445331EC1
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784998293; cv=none; b=dWnqpjPxeRIztyIP4u4U2Gm/r0CxKTltW7qttuAGhQ54hOB5u/felLhLXNn0Vbi0AG8naiM7BCNv4gdh+JupwmaNA1fFfffvvNvS2O7N15gntNPYjeK8n3FW0y7qA2A4nEIrVNqcgT0bq4x0C8qeqCpICwggG+BlVaLXZs9HcUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784998293; c=relaxed/simple;
	bh=8WRM/onvFHKUhLTEUGrH7/AYQk4AezAHEWCfmrOs8Dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c4F5C5pFbAfdxlqrH8CSLjHsZY/aOwSR2w0MO8MmZr+iNN4+UdSvZkZPi0jKy7r/GZ+zgyEUNdRik5ysAbS1otGvgCf8UGvm951mevbtFL0vX3de70RDqzcLvXlC/xBz2vKLzZab3YINu7iLWHlClkhgo1C2VIOkknXhTZcur/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vrSEaZXT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W3VvOt4U; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vrSEaZXT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W3VvOt4U"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E9B99EC0104;
	Sat, 25 Jul 2026 12:51:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 25 Jul 2026 12:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784998290;
	 x=1785084690; bh=zBRhtNLE7pQIvoCoIhRAyPm6iztq9R2U/xJ6Vc/ki7E=; b=
	vrSEaZXTqL04GLfy+C0mb5C34B2D4QaJGn12F0s9oHRFmvZgwSZNy7jcX84ieTPR
	eNWvmgt3RwjOIk2nbobEuFLxsxA/HDLxGdH1mf9sm5uEtemU5K0lHyTNr4FUHLo8
	7XBqGqqVRJlFRwhFJhpyxGhwdedzefCIfspI0JvZ+mdhjjIE4qfLDfevvos7EtPA
	IUy67QHeIwn9DIFcE74UBJr7EBNdKOneqs4/haJuEwTvR+nzaOAlN9OFd/heyDvL
	51ruvUmHOc6NTbvd8Rl3DF4fYXPPl0zmCm0SkdOO3XAfJX5D3UbCPysAdjn3WnQx
	Jp7utW6aNoCQcF3t1FnBMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784998290; x=
	1785084690; bh=zBRhtNLE7pQIvoCoIhRAyPm6iztq9R2U/xJ6Vc/ki7E=; b=W
	3VvOt4UI9TECgV9X4Tpjsc5w6if/14u/z/qWIdPjSXv5Td68KmOakCYUpXG6Ogu8
	4CfqdMErBOvIHo3GuoCdaapLwxuNk83OFTPtmyXe2Hi6jtRS6BprXoN+RIGry5BU
	CgOXq3XEatW7CNKRUSMTKLYNE14pKXNLHYxBG38E9Bf6H1bfdBDAQtAkYYBZwMCC
	nPnwHQ4uMGOoJJFmxs+9eXdMHPWSHNxln37G1g0EMftmW8o397mxmg/J0gabAgwm
	g5TEZ0q/5oMHXpjC2SkJshM/OjySnYsG9x8eHL1Tqo/4h0sH2cygSzC7w2w+E+SE
	isqqQ5e3QhOuAAOgWwHAg==
X-ME-Sender: <xms:kulkahlLc9SDXe2jBpq70HDg-cSFgg82J6pCCs0NVQl5n8pwVWyjDg>
    <xme:kulkavFzafJSDei-ihJI5m5GpSPStxe5iEsaBFAX28jEiPTQI-vQ-EgXrBTAsOWKP
    lLwhv9ZHTWx_Xu3lljrlwMpO_nDcuDQWBBsXGy0IHwYun6bxkxUXg>
X-ME-Received: <xmr:kulkap6_gMD0SYFpqwIxBUhp4T6pHQ0L1fXaLZmqTZ2-KvpeC1f05nffCdRJeMJrTVDrDqlwHwdV6kHOu3Wint_DrsbyiIAeaA>
X-ME-Proxy-Cause: dmFkZTFRA7BNtVt9lZ5wdMZUsR63+orpkZiDMnf3ygfwVQ4EnMQPuHm+KdcGyLJqxaocy8
    xDbO2215AmbfrDjVVof1G/oPPVxYj3CCLm1v6Mjnu/+ooGcYLKgDqhl6Q19WrQLBWxwvZD
    5N6+gSOPcUkLD9c/tg/C6CAjUw00hK/mMAAf0JwUXaUP8VnS0LutDyLpxJnRzDI6xINB4p
    UoOZKwqN5NqogAFaUsBRxSXCeyvfeN1BzkxvgrgpUVGvtl5904R+NQezz8MoOOXQcgFQQO
    f85cAswQGxHHypdLDo19y/R0eXy2gtQmWkCX8KjVxlq4C3YrZc+wBJZ/oFfDZ4UencXbie
    x8WdOUZ+5/IVJ3FT71z7b2jVZk2EadzFgZiO3cNXp8mOPb62ezSaVKoP3v6Vz34rWUqndp
    62qhHN3PaqUezEYNInC+tYi+NOqEiVfE9/ad6kSxI6j4kiIDRoDM2F1RQoyvyW1sxm9m5S
    S2T4w1JaxyYAynyV9V/JiPHLvnhlXw4vBnYOcZtVXPKJwiLDepbctVjSq4vUr6Tk9YN/Se
    mgwMFoxbyQcerLKcqMDe4fWQzteJaTeEC04ejpORv1ZgC0RlnwZ4qbvzrtB8OkgFf/qE/0
    blztAJI7llaiXzWJZ8aEYmKMJ6dcEdswcwC0x1k47auYoATIrefvpiPmIUvg
X-ME-Proxy: <xmx:kulkann4UNsJpgkgJ2lHHzuWc0Pnvp4Uh8XLBnEfVqiXTM0yXIat5w>
    <xmx:kulkaupV92UpDCb08cTsLwIg_N_HnohZGX7Ifh_AglDYHOLCW2xImQ>
    <xmx:kulkamswhROXSJ-xkzSWNHnbi1qn4_gfwWeQagqWpcE_VZ6XMgQ2kw>
    <xmx:kulkajEbtNl2FQjqP632-8bQgkc0_acAprrktPLd4cSFuzLUMg5RKw>
    <xmx:kulkauIiLQbTMDJEpj8_Yc5ZQuJeC43RRQQq6W5Pft5jc_preghm8Ciw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jul 2026 12:51:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Marc Branchaud <marcnarc@xiplink.com>,
  =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,  Eric
 Sunshine
 <sunshine@sunshineco.com>,  Matthias =?utf-8?Q?A=C3=9Fhauer?=
 <mha1993@live.de>
Subject: Re: [PATCH 1/2] worktree: don't read out of bounds
In-Reply-To: <8bc69c6b80ed42888327331b1567cecf7225ea7e.1784978348.git.gitgitgadget@gmail.com>
	("Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget"'s message of "Sat, 25
 Jul 2026
	11:19:06 +0000")
References: <pull.2187.git.1784978348.gitgitgadget@gmail.com>
	<8bc69c6b80ed42888327331b1567cecf7225ea7e.1784978348.git.gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 09:51:28 -0700
Message-ID: <xmqqbjbvypv3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Matthias Aßhauer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> `worktree_basename` tries to read from memory before the passed `path`
> string, if `path` is empty (or only consists of directory separators).
> That results in unexpected nonsense data being returned to the caller,
> which can lead to issues, such as `git worktree add ""` recursively
> deleting the current working directory, including `.git`.

OK, so you do want to handle a case where path is something silly
like "///".

> Stop reading out of bounds in these cases to avoid that behaviour.
>
> This leads to `git worktree add ""` consistently exiting with the
> message `BUG: How come '' becomes empty after sanitization?`, which is
> still undesirable, but at least it doesn't result in data loss anymore.

OK.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 4bc7b4f6e7..d8188035db 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -297,17 +297,21 @@ static void remove_junk_on_signal(int signo)
>  static const char *worktree_basename(const char *path, int *olen)
>  {
>  	const char *name;
> -	int len;
> +	int len, len2;
>  
> -	len = strlen(path);
> +	len2 = len = strlen(path);
>  	while (len && is_dir_sep(path[len - 1]))
>  		len--;

These two 'len' variables should have clear names to distinguish
what each length represents.  Rather than introducing a cryptic
'len2', give it a more meaningful name, and rename 'len' as well if
necessary.

I suspect that it is to remember the original length of the 'path'
before stripping the trailing directory separators?

> -	for (name = path + len - 1; name > path; name--)
> -		if (is_dir_sep(*name)) {
> -			name++;
> -			break;
> -		}

When 'len' is 0, the original code sets 'name' to '&path[-1]' and
does not enter the loop.  However, '*olen' is set to 0, and 'name',
pointing before the start of the string, is returned.  If left
unfixed, callers pass it to xstrndup(), strbuf_add(), and the like,
reading memory before the start of the string, which is horrible and
worth fixing.

> +	if(len) {
> +		for (name = path + len - 1; name > path; name--)
> +			if (is_dir_sep(*name)) {
> +				name++;
> +				break;
> +			}
> +	}
> +	else
> +		name = path + len2;

Style:

 (1) Missing SP between 'if' and '(len'.

 (2) 'else' sits on the same line as '}' that closes the 'if'
     clause.

 (3) When any one branch of an 'if'...'else if'...'else' cascade
     needs a pair of braces to group multiple statements, all other
     branches must use braces as well.

Taken together:

	if (len) {
		...
	} else {
		...
	}

As for what the patch intends to do, setting 'name = path + len2'
when 'len' is 0 breaks when 'path' consists only of directory
separators (for example, "/" or "///"), no?

In that case, 'len2' is positive (for example, 3) while 'len' is 0.
In add_worktree(), 'path + len - name' evaluates to (path + 0) -
(path + 3) = -3.  Passed as size_t to strbuf_add(), this wraps
around to SIZE_MAX - 2 (approx. 18 exabytes), leading to a buffer
allocation failure or a crash.

Rather than calculating 'path - 1' out of bounds or introducing
'len2', worktree_basename() can simply keep 'name = path' when 'len'
is 0.  Using an integer index loop 'for (int i = len - 1; 0 <= i;
i--)' avoids pointer arithmetic before the start of the buffer
entirely, I would think.  Or am I missing something?

Thanks.

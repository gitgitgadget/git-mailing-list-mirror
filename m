Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879640D56B
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147629; cv=none; b=F+wB/b+zBaVcVeAx1Z86oINZpL9pBwahQRrvuHTK6qe63a2DTYHp1uLRfXmgN4ToYAzrBeuSOFsp35ifmJ15ZmqNumT4xhPuONNW/iAZ3yjtYaJcw1KvpYMBYgZY4Wm804xdn2lCi9tCRezHuCqkybakhqkloEf6czYYfoy+izE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147629; c=relaxed/simple;
	bh=XNJKMVFSdZS6AURddwPYzhKSy1AQYUaE4oPMgWJ8Lgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M168lrGfgEqIvrzY1oB8KTJCrvQcWRvuF+fY37PL999xM8AtngESPZ3P9B0ONLNQ2pnWpBgVknjCSncjNWuf/SIwbPMZK8WjcMrRBPMImcWci7T6z7UeWEkvoqtfcLvDluEp/4UCorViCxiOZI5PbGcDTzUYWVGs75IOmaN8OOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mtwrmALL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UP/+Kqr6; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mtwrmALL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UP/+Kqr6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D708140017B;
	Mon, 22 Jun 2026 13:00:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 22 Jun 2026 13:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782147626; x=1782234026; bh=4Kj8u7yig1
	uA2nkzjIhFVlepHzFixWJoNoJo4G0KJew=; b=mtwrmALL2TDv2/LUUyWy8Bjisg
	VBijpVNVszo0brBnbNiwop9YKBjhR2M9mZ27Tf31ur/VLCADIl8vOLUcbBnw2TvJ
	k4adnhIR0ey2Zd94Cdey62vRjiciwYwDaM88CZU/5nzbWf669g0KWxbYxe8eV3Ct
	4jm+xUgVUXn8yFtWOWbxgdNGtkl00lDpWq3xGITtPvFLgObikTl1xKhXxJJ6jsKp
	cFvTXeEotLe/XZgBzR1ZIimdC/x5gFRENTsrHp6jlv7Ei1sNCV7wgAKLzY9NGDnA
	RnhREpTkIQZSZwK+fru9X2xXExayxn6aE86E7wAcmfOTfccXgM43pRHDoXZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782147626; x=1782234026; bh=4Kj8u7yig1uA2nkzjIhFVlepHzFixWJoNoJ
	o4G0KJew=; b=UP/+Kqr6lSxnTd+1Wt4U4DtUtHI7UnMdXHLA0UTJ7XdLmxqSP3O
	0KZBr+jNsRWu3PDlw5EE5vUpwisN0dbYfzGA8Jm4duLmnF9I7xG1W4IKHPHaeXG/
	LviXWdShhmiNJQJhYJ7u9yO0Bv7CFbk7Pz9Ea3SvOGPROj9Cpvw/k0nfNTPICp3Z
	5qVz1ZHxrineqgZLrwU6nMKpH55IWq2CUJaRlN982JGfuRFCiolMIvbUqRaQqwtT
	YGNXWbjmWxe65gWA/lSSCuifZp9NNxtqT/udMp8l8VFMpDS6jQzpQjJf4eulwhLx
	I0jULpAqWp6sekd7IeXrALvotQ+Tj+4zmRA==
X-ME-Sender: <xms:Kmo5asdqu4_YT3pwNSdLr6YIVf9_cU6OmxcWgffiag1UGZEPkgtcpw>
    <xme:Kmo5alEnXLH0_35t88aMkRFBMcRUdag4kl9-pi7vwjiprEf2aITcsWfo3zdyIjmMI
    J1QvzpVTexBlzzVmf04xnS10h8Yavj3zjl91dqrOcielMk5Yy_ZZA>
X-ME-Received: <xmr:Kmo5al0WTm8hBKO7S42K0YxbO22h_SMBXMtaKgnW_3wB9mD1KhcSzOc96DbVnr5CuLUiapz9_N1ISvuB6SLYaCeJI9HYW2bLnrCRC_4>
X-ME-Proxy-Cause: dmFkZTFh46HDPZxyuhNhgSiXJjRy7+frJd8K6gYejkvUcoZJSPrjOBk34o81uiok1BMH9D
    0omXbFtTldgnL7f82TV1r3O3ns1selnQ1KL/ETdEf7/5lL5kY0PPfj0/Q2PojZIfgIGycO
    LHjBvMdtIcW7bTdwNxiY1/ETjoDtqwC2iPllu5ZrbbEiEieyYEsCTxqkzEMs7k5R29Cz9g
    mFiJtq1gtw1WvXabldcvnGZIKwoT5AvkJwVhVTi/6MUQNktHRqLUBKA4BC9gYBI/JW5klQ
    2r9QY5IH1mtwjTsnHi7P2qgUpxL7QxmY2agBLkBSjocvVVvIrYYc026Nf5AJM0urtxxegl
    iPW3krGQzuzh3FwqpoBHeZW7Cxpq1A0SM6BNrREWmTw97RGA4YMW4X2ZDvwlEsrOpRF4T1
    MnTA6Emu9upEZt/LU0hGzcMpImgx+gwb2zfT4kZQ4qWLPUxAhl30CwGzGXXe2+7iy4IR3n
    HACO97jUPET/DciXmpjT/ru2R37iSjFzlQOpjIpn02Tiq7gCt+dqLZmsoDFTh/cRuqffH3
    BBNSgt++d4nrdcPo2Q2yuYcchyC7rsiyWTIY/Len0M1CAzLdYARQCAPqrMW5MyNOhF3I6D
    ahf6Kd4xbJ9MYX/MJiJmkNDiK7fNm3ZWgjadLHUoEe8XpXhZbvdgA0I0hwmA
X-ME-Proxy: <xmx:Kmo5atk9tFXDg-4JBB-DeHT17MiJ9dZy9nDMbmZzzgDdRO5sDcYP4Q>
    <xmx:Kmo5al8IcdTRCGsjgvwWMVXq_buS_ivLZGdQDhFWDItaxfmXGnAMrw>
    <xmx:Kmo5aipENh9ETfo-Sa2x3hGJcVcZzeBjlfdW34FJoslDQHIieE492A>
    <xmx:Kmo5aukJSqQU6d2TkOJSbGucIJnMyO3DhLUw9VZjvT7e64yL61wHag>
    <xmx:Kmo5ak0J4K0baQtp4Pky4CEiH43FdjCNuTnQOsiiic-tFAVpJtiPaD7o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 13:00:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 1/2] sequencer: factor out parsing of todo commands
In-Reply-To: <d27dddff93144f7b6d7fc89719bdf53b6856c9fc.1782117361.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Mon, 22 Jun 2026 09:36:03 +0100")
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
	<cover.1782117361.git.phillip.wood@dunelm.org.uk>
	<d27dddff93144f7b6d7fc89719bdf53b6856c9fc.1782117361.git.phillip.wood@dunelm.org.uk>
Date: Mon, 22 Jun 2026 10:00:24 -0700
Message-ID: <xmqqpl1i1pef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Move the code that parses todo commands into a separate function so
> that it can be shared with "git status" in the next commit. As we
> know the input is NUL terminated we do not pass a pointer to the end
> of the line and instead test for a blank line by looking for NUL, CR
> LF, or LF. We use starts_with() instead of starts_with_mem() for the
> same reason. This results in slightly different behavior when there
> a CR at the start of the line that is not followed by LF. Previously
> such a line was treated as a comment rather than an invalid line.

Meaning that the input validation is tighter than before?  I think
it is fine in this case, as I do not see a reason why anybody wants
to use a lone CR as comment introducer.

> +bool sequencer_parse_todo_command(const char **p, enum todo_command *cmd)
> +{
> +	const char *s = *p;
> +
> +	for (int i = 0; i < TODO_COMMENT; i++)
> +		if (is_command(i, p)) {
> +			*cmd = i;
> +			return true;
> +		}
> +
> +	if (starts_with(s, comment_line_str)) {
> +		*cmd = TODO_COMMENT;
> +		return true;
> +	} else if (s[0] == '\n' || (s[0] == '\r' && s[1] == '\n') || !s[0]) {
> +		*cmd = TODO_COMMENT;
> +		return true;
> +	}
> +
> +	return false;
>  }

I notice that the order of noticing concrete comments and comment
lines are swapped relative to the original.  There is no inherently
"natural" order between them, so the change is perfectly OK.  I just
got confused slightly while reading it until I realized that is what
you did.

>  static int check_label_or_ref_arg(enum todo_command command, const char *arg)
> @@ -2716,29 +2737,23 @@ static int parse_insn_line(struct repository *r, struct replay_opts *opts,
>  {
>  	struct object_id commit_oid;
>  	char *end_of_object_name;
> -	int i, saved, status, padding;
> +	int saved, status, padding;
>  
>  	item->flags = 0;
>  
>  	/* left-trim */
>  	bol += strspn(bol, " \t");
>  
> -	if (bol == eol || *bol == '\r' || starts_with_mem(bol, eol - bol, comment_line_str)) {
> -		item->command = TODO_COMMENT;
> -		item->commit = NULL;
> -		item->arg_offset = bol - buf;
> -		item->arg_len = eol - bol;
> -		return 0;
> -	}
> -
> -	for (i = 0; i < TODO_COMMENT; i++)
> -		if (is_command(i, &bol)) {
> -			item->command = i;
> -			break;
> -		}
> -	if (i >= TODO_COMMENT)
> +	if (!sequencer_parse_todo_command(&bol, &item->command))
>  		return error(_("invalid command '%.*s'"),
>  			     (int)strcspn(bol, " \t\r\n"), bol);
> +
> +	if (item->command == TODO_COMMENT) {
> +		item->commit = NULL;
> +		item->arg_offset = bol - buf;
> +		item->arg_len = eol - bol;
> +		return 0;
> +	}

And the extra stuff that are only relevant to a comment line is
naturally processed by the caller.  OK.

Thanks.  Looking good so far.

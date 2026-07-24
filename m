Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F93B47DC
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927942; cv=none; b=AjkXEkBcKiSiwCFhg/bxe0B4Y7R+TuS2TjOD3tYgQSW0Uyp8z8EiF4ZmI3w4gD3xFObiq7oFPgvNAkG8zeJzci3z+aB1RLnTflEu7fZZ2h0Nj8t7dJChY5MmvlLZ2W5iN6DO+ZIB+sTFNmJ617HoGz8qcVz2Dif6CoaX9QLC/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927942; c=relaxed/simple;
	bh=9eI7D829HJ/impolzU4ODbHwSbcz99xcgKh8AUFFdLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jwD/QyzhRCF5YLv7dg+C99e0eHTPRG1d6ltyPAsy4nAjG9Vx2AVHvHOf9lGCgnfsoi2K4PxKJ1ZjE6W8cWPsX3LZvUnaf/e9OCXA77t/SIIOAresv/jcc7DVtP9Sp6dMJzodGN8eCwPRY7EZ9yqe5PBGPzGOc5eV/Rfu/jivQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BH88P2Ai; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L4XwWdaD; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BH88P2Ai";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L4XwWdaD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 12AD31D004E5;
	Fri, 24 Jul 2026 17:19:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 24 Jul 2026 17:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784927939; x=1785014339; bh=IvjKviuQEd
	aoD8YzEbegqZvCKdLHK0w3703ywQ85P/s=; b=BH88P2AiPDhziix3OEMgnlIUvb
	k4UxV4+LhGQP7BMLdWqfv5cgbutaPtAYGIdLYOLWl/ALCaxa23BrM8Y4k4ZmjsA5
	OHKhFRErelSF08n7yTEoEpVTak9rzFIc10Cbaaxh3t+x9uL6FwGxpLFKd/U412n8
	00j+PqHMByyjXN+Ez0LsHhusT5lCN+AREFzaB2fpUaobkogT5zfZzM7yROC5gOfk
	gjXmQIFFZjGXei/SUZkBgLiZ3dqeoVUC7+XaxY3ppM7bq/Ed/G5NTQyUcdkojm/5
	KpLzqVEIwlmLi1rK/gKsWrWqrpm2MNr++nZ9Tb2alJoGY7klzeLnAW/Bokdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784927939; x=1785014339; bh=IvjKviuQEdaoD8YzEbegqZvCKdLHK0w3703
	ywQ85P/s=; b=L4XwWdaDa5YPeVxwq9xrO3jAvxOKiKNkTZiDuqamdcpYfsXOSmR
	jPTUKLmIn4fANUKVZoBGHcXRzlz/WnounjTov8ZZn3LGylfUQLY1DuIDHsqrVTxJ
	6yXKYQxQjB+o5twg2gaJisk+udWX36bRGqGKLdUY4vbrdLvoahrpWEuteSrMRUYy
	Pq/Kgpm+/vp0mDsbusiVUsLIoEZm7JIHyvkBYUfbSAvp7KRFYlkgRKImQlVXU3MA
	6y5l6LRQZHSn1c9h8pUsDo1iJS+He8aLDjxRH2gzogPJ9FnxrYLFZjkzpk43oU58
	MuS1c5wYLiRPAzQbhvo1HNBcadyl5mXR53A==
X-ME-Sender: <xms:w9Zjalf48TQpVrM0hYkbtxDDUe2AhnD6B42fvyCyI3AN40FygEJAuQ>
    <xme:w9ZjaqreKgSxc_uN62e_86nDZIKnY8Qmn6xnais_ezHuOFV2FnnJj8AVI7SXmAuc0
    vX8UJzoceacca9KeaakhHQbov_KVcV_pAJjGXYHRmvljUcqoAf91A>
X-ME-Received: <xmr:w9Zjar6Sgy-XSL3pg5d5VGOjZ8FWOFaHyhBaHilNu7JHALIc1CEm87m1S3R2sDhZNLZOJvPWir_FyBsWc7wTMZvbaZ7Po7NV2g>
X-ME-Proxy-Cause: dmFkZTEORePahuiV8R6nR4gbI1Hzjm9+shvx15XvR6CBzHwO0j3CFADekr8JnvLA6FW4ya
    /FQqBw7UMOaQQgrvSovNIH28xXddzrnd2lf9oePDiCx/nI60+hJJ8iK0M+h0Muf8ZoRZ9z
    u+he0eyfbnu6V82Ufk6vRUxlJtNVSJsZRBw3v2DWZ1C/oA4UURfP+1H3WZDdro3FfgNIi5
    cKi/qHMhit4gE8CIH6HSk+ln3KYLPErsg5OeiPt2yjemEhpu1A9hEaozseUnvHuiLPTmIe
    TixTOAlxGDudlu7X3XIT3DGePICsRKDEwTWmP+dci+AkCdy4+NMYga56YaF/3RGAnoquUn
    wWsSZgUTH02A43tbGFIjAWB+gEULes/1L463dwWiuh6djvwI96EY+E/6g6nNM9DyK/AG/d
    xd4LEh6Z8xXU3kYmnXu6lWTtI0Q+JpLdK39X3FtWQwX+/4N7q3tlG+zKI6KxS32m8IXdhb
    bsph0duw/EbiWj8WYEpco5h/0nOjzMw9JSDqLgIWhzXRUC3xTaukKWsiBAtUxh/+hsurWb
    61xuMhDIqJ7XzBTrfmd0G4OXoJ4MeyXV01AiJmWWpCiH6UNttiuYxxTt9jNbq2WJU+U+Sx
    NlfuB1219/p9b1MvQ5ml43AZlGVHhrqrKbKr0uFrOO6EzcCkEDcRGdNIe9Gg
X-ME-Proxy: <xmx:w9ZjaoqyzmRDs1bOJ2AM4u6LsUJ_ZD0IgUQuKGHuvAuPc3SnieB83A>
    <xmx:w9Zjalh8A04ON3R4bFCBIyC6xX5dqvLWXvxYdBkw4E2KY8ViBRBTjw>
    <xmx:w9ZjaqKC5FQ9Bf4VUNX8CWRtn0HmKvmXwV--CMPlqcMkTeNOyJk5gQ>
    <xmx:w9ZjatA01Mnnn1n0BKDhCe_RQwMx4Hjoanq_KGxt5SAR2YWVcQhP9Q>
    <xmx:w9ZjamrBN4jCYrd3LSDzSwoiTlOPIeCb8sFDpOTzCY2ezYHP7A9neWej>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 17:18:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] rebase: remember fixup -c after skipping fixup/squash
In-Reply-To: <7c8075ff2675976821a1ee979f86c7c46a35bd15.1784304378.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 17 Jul 2026 17:06:37 +0100")
References: <cover.1784304378.git.phillip.wood@dunelm.org.uk>
	<7c8075ff2675976821a1ee979f86c7c46a35bd15.1784304378.git.phillip.wood@dunelm.org.uk>
Date: Fri, 24 Jul 2026 14:18:58 -0700
Message-ID: <xmqqtspo3x31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>  	return starts_with(ctx->current_fixups.buf, "squash") ||
>  		strstr(ctx->current_fixups.buf, "\nsquash");
> +}
> +
> +/* Does the current fixup chain contain a "fixup -c" command? */
> +static int seen_fixup_edit_msg(struct replay_ctx *ctx)
> +{
> +	return starts_with(ctx->current_fixups.buf, "fixup -c") ||
> +		strstr(ctx->current_fixups.buf, "\nfixup -c");
>  }

It is a bit annoying that "git diff" decided to consider the "}" at
the end of the otherwise unmodified function to be the one that was
added X-<.  But thanks to it, we can see this mirrors the previous
function to check if we have "squash" anywhere.  I wonder what
diff-algorithm was used to produce this result, but it is an
unrelated tangent.

It is a bit surprising that we do not carefully parse each line to
identify a 'squash' or a 'fixup -c', which would make it unnecessary
to guess whether the current line is what we are looking for or if
the desired string immediately follows a newline later on.  Still,
this patch inherits that pattern from the original code, so it is
not a fault of this change.

>  static void update_comment_bufs(struct strbuf *buf1, struct strbuf *buf2, int n)
> @@ -2148,9 +2155,14 @@ static int update_squash_messages(struct repository *r,
>  	strbuf_release(&buf);
>  
>  	if (!res) {
> -		strbuf_addf(&ctx->current_fixups, "%s%s %s",
> +		const char *fixup_flag = "";
> +
> +		if (is_fixup_flag(command, flag) && (flag & TODO_EDIT_FIXUP_MSG))
> +			fixup_flag = " -c";
> +
> +		strbuf_addf(&ctx->current_fixups, "%s%s%s %s",
>  			    ctx->current_fixups.len ? "\n" : "",
> -			    command_to_string(command),
> +			    command_to_string(command), fixup_flag,
>  			    oid_to_hex(&commit->object.oid));
>  		res = write_message(ctx->current_fixups.buf,
>  				    ctx->current_fixups.len,
> @@ -5391,8 +5403,8 @@ static int commit_staged_changes(struct repository *r,
>  				 * message, no need to bother the user with
>  				 * opening the commit message in the editor.
>  				 */
> -				if (!starts_with(p, "squash ") &&
> -				    !strstr(p, "\nsquash "))
> +				if (!seen_squash(ctx) &&
> +				    !seen_fixup_edit_msg(ctx))
>  					flags = (flags & ~EDIT_MSG) | CLEANUP_MSG;

If 'fixup -c' is anywhere in the chain, we would need to offer the
user a chance to edit (similar to having 'squash').

It is a bit surprising that the 'squash' detection, for which we
already had a helper function, was open-coded here.  I also notice
that the helpers (including the new 'fixup -c' one) do not insist on
having a space immediately after the verb 'squash'.  Should we add
one above?

Other than these minor nits, this looks good.

It is a bit disappointing that, with so many users who crucially
depend on the proper operation of 'rebase -i', we have received no
review comments on these two patches so far.  Perhaps summer is a
truly quiet and slow season ;-)

I will wait for a few more days and then mark the topic for 'next'.

Thanks.

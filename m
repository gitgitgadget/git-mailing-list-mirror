Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD33B4417
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926882; cv=none; b=ZadkkFK80JH7lKaw9ebAwYSFx+ymUJLjhlhBAEDGjrEVB7Ko1ENBzGuWbtj8WoeUJRB+mv6uJ+y0Qmg40W0i3R3KEmYMZom4HZOLVnWGGWvUJgo7duO0vdp/dS8Lv4v6nOFPo1xQx5Kk2GDyRluuRjXVEK8BNqxJtX7l9XkrHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926882; c=relaxed/simple;
	bh=UwITQAgF3xRaw0a/RMu1o3hSq1N+e+Fj8tNHw40CuAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M7OG/ZxRFsLzwj/zcUUOygMxUNDfMLzRA18qkTbAkvkAbEzhwMK23FoXfYAPtIexmG/Mr9SoYBRtFd4ARduCGJvuU94LkT2Ht6HbpqtJjMO5nSNBHHbbp8rWqUblueuICHDKlIsHco1gSy3LNrYqFYXpGdRBebdXXEGF0LeWkL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rvORHa7W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DJUohX/z; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rvORHa7W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DJUohX/z"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 20CBE7A0227;
	Fri, 24 Jul 2026 17:01:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 24 Jul 2026 17:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784926879; x=1785013279; bh=m33GQnxt6v
	TxeNo+gSdem5xVU7eiVckMHB8OIi7h1a4=; b=rvORHa7WHt75lVHYTjRsoYATtd
	I+h83Ekbw+klJ5GvV4n0F92oP8bK/axdrH1KEedqLgSrcM0WuL8xg3iHndKdvZmV
	qRQSVEkqAlaX2N6lEGaHk3H9IQRlHdIU5jaZ/M0lVryFr/cNU6EOnGq0kWPSACax
	pxsiBmXOfswhhC0XU0uf50NJ4MLNc+CruT1g9gujT+xDknO8JdmMp4Zoea4qrkGk
	S7IbpT/rlllJt651j/Ip4pmiQvs9tbeS8rYSRV//i/9h6mIVdJqS/dVuHPX6q+Yp
	yJwJVwUlUSQTb7woabja5+Iux3a3l1Uz7Sl0GN5j48a7DbDY/ZEa0WrmBl8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784926879; x=1785013279; bh=m33GQnxt6vTxeNo+gSdem5xVU7eiVckMHB8
	OIi7h1a4=; b=DJUohX/z/71IuTO68rccpertL23obAAoPFQ2aK3vpOpL7gTUr/7
	1fPUfDiuzUOqYh39hyLF8XnKPFiWrVUbtqgmhbvcJszZUYBqvjJkeWFEqkYzP7MK
	hjiVh3RAIa4tZB7jSoqi/vaMMGqF9u/b1mRlQ1S7mckW3d/MZXCHENDg4VyOIXct
	ZteTX2qM+HWnHq2aG6cNIpeQpHNLX+vlEaw9u78THdprtusTquAAupNMSntPsflT
	EYCGObuOGhcJ93gKZyTL83gUGNaIkenpJSP7YhSj62sZ0sYWNAdfTtdEayhJmmPf
	eOuM+EOeMQZ4dw1ciMwGRsLwYll6jZkO6+A==
X-ME-Sender: <xms:n9Jjat5PUw4SedN10i1bSllEMF9kxJgjqsTbFwWeyNQmCUtNXlgqQg>
    <xme:n9JjaiVttMmxunusa7__8N0XMI6pdHOcSRVfWkhi9thCidIt_cQ1TvX6t3QeP6dNa
    4TpJd_fT0kXqavVb2_fggnC9lHGnkw3QsqHWQyqi3V-qy-ZONxQEw>
X-ME-Received: <xmr:n9Jjah2_e-RfxlFPiwl-OATysDWYVqKYvHOzMcjacXc6sv5zv0mVCoED67ynhDEbh-0igAch_iyYgj8sBTNq9lIDspSiyyp4mA>
X-ME-Proxy-Cause: dmFkZTFU8ckoGooC60R6xRqit73l4caCfWgXUtJNzLPW9LqVoRIf9DcErwKoLLQ31aExn3
    JIa+wK1q0JnHoWBt5+LV9AT1NOAVBPpSB+SRtmqi22Mth8TzwJdfGM//oLGeFFL5ZN6G0W
    7k7fpky7h3RH6LN+SX8GqRKl8Ayq3yhkEDsTUNcyT9Y9E+3h9JUOjw/nV5jUMgV0ByMJvf
    Z1xwoSJmV+xJvLet5X1OszWJsESIgbT4itsCBjjZgpc3yeEvmCWTfLEf0TRPt/X7X9Nw21
    9SR6Yhwy2i31LurM24ininzeHZJ3ZU/7gtTa3iEJwgT2dBFvBDhHmZHZvVeF+JgA4t5gpJ
    SSpSrG2/GWfjJ9I7eu7y6yM2RvqsvwbR1XUSnjNG/U+VMif3xeyj2e1i3bYJX7qkx4gEf6
    m2rewsY1lD4N6yGewo/zBvfxVW+HRyfCUAKtd+UKIW1EwWBoiuSRYvZMpCjtesfP2BqRSz
    PfK2pjOnaNjuC2Hk8uuIDvJAiy8JolwJT6NInvjbMfa34ZZOwxuRALgdtORZIH9u6pgyIY
    KT0WyYQKmT1gzua7DF95EcqykSNwKH+vFUNydzU96EdkTHc9WvOUlE4pome10NOFUt501x
    Es+dh4zOcT5Q9WH9X3ZzlsHkJBYrFolhHdVWrD6lY//vxMQNV690l2mgel6A
X-ME-Proxy: <xmx:n9Jjav3w6rM5-jcxu8LAz86vXh6n3_NM5Eo-LfafWjn0ULatjLgxqQ>
    <xmx:n9Jjak9lKamJPSuwHcwBwEe7gF6FV7sn3i8bNI1HynbAkrFACKDbaw>
    <xmx:n9Jjas2dCikUYgGf-xTCcFf0FvlLloQOUiaSl0MCRtt3soikXRu0Dw>
    <xmx:n9Jjah9oGrBwybkR9GNzhjjFAVZrfsAS04Fwm43Owz-CU4rwQLP_hA>
    <xmx:n9JjaqUXe1JfFE0yz3PvY3T-ALJLyRan0V3m0vs8uf13FIBTJgALJ1Pr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 17:01:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] rebase -i: fix counting of fixups after rebase --skip
In-Reply-To: <c37a518486a8fa9832a6dbbe6048cda70af87d73.1784304378.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 17 Jul 2026 17:06:36 +0100")
References: <cover.1784304378.git.phillip.wood@dunelm.org.uk>
	<c37a518486a8fa9832a6dbbe6048cda70af87d73.1784304378.git.phillip.wood@dunelm.org.uk>
Date: Fri, 24 Jul 2026 14:01:18 -0700
Message-ID: <xmqqbjbw5cgx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> @@ -3281,7 +3281,13 @@ static int read_populate_opts(struct replay_opts *opts)
>  			const char *p = ctx->current_fixups.buf;
>  			ctx->current_fixup_count = 1;
>  			while ((p = strchr(p, '\n'))) {
> -				ctx->current_fixup_count++;
> +				/*
> +				 * Older versions of git accidentally
> +				 * inserted blank lines when a fixup
> +				 * was skipped.
> +				 */
> +				if (p[1] != '\n')
> +					ctx->current_fixup_count++;
>  				p++;
>  			}
>  		}

If we hit the LF at the very end (e.g. "fixup A\n" at the end of the
file), strchr() would have moved p to the newline, and p[1] will be
'\0', no?  And because p[1] != '\n' and wouldn't current_fixup_count
be incremented again?  It might be safer to check p[1] != '\n' &&
p[1] != '\0' to avoid counting a trailing newline as an extra
command when reading legacy files.

> @@ -5353,6 +5359,9 @@ static int commit_staged_changes(struct repository *r,
>  			if (!len)
>  				BUG("Incorrect current_fixups:\n%s", p);
>  			while (len && p[len - 1] != '\n')
> +				len--;
> +			/* Remove trailing newline */
> +			if (len)
>  				len--;

So we removed all the non newline from the end, and the loop would
break if !len or p[len - 1] == '\n'.  And in the latter case, we
also drop that '\n'.  Which sounds right.

Thanks.


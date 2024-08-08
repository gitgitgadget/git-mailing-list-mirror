Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECECE190676
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137154; cv=none; b=a0vv3a4TsKij38/MvEsrZLz/oxp7CsPXz0eHjlGZWa7v4DwcsNJ/YSW6nV4fCarop9UjzZby4bSkLetje97o+69Z2s08A4s8gMwmdIC26dkOVkCbcblBhFLeVOCYS3+Ne3XRaR/FezS3Y4iAVWgYEoAeEO2pg3ni2qhEP3Ow/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137154; c=relaxed/simple;
	bh=+mcFhTAsAHRbChlWNH2+FOUVcWxuh/Lsd60mmT5bujE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JyWyibSpVMAK9BDBl3499SuB+NP/tGsgEytazbGvS7Ln+usycJATVexSLAG+n8lFnEeZXTeFgw094YncS9inwWSEucyYNHQj+6kgG+jn8yFwOu1j1lZsuAZU+tXG3WSb2VguoamsE1mmVvDa5fbVvCx+EiZEKcCuAvqJZf0Y9Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DQVuJ88R; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DQVuJ88R"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7454923A50;
	Thu,  8 Aug 2024 13:12:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+mcFhTAsAHRbChlWNH2+FOUVcWxuh/Lsd60mmT
	5bujE=; b=DQVuJ88R/IWlgH0f28jGXaxIuoNlwWby6C83HdOrVm1lzbXHHbsCps
	wT3vaZUuJ1wLo2d8flZLwTvPneaImxIVncVnH1WhCnME5jEXnxz7SuHoAhTSS9fu
	5qsLhZWZZJQfGem2GeXNJgyaIk6F6vuhZMBl9PSb6FWEP02dY0LVg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C21523A4F;
	Thu,  8 Aug 2024 13:12:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 866EA23A4E;
	Thu,  8 Aug 2024 13:12:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  James Liu <james@jamesliu.io>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 08/22] config: fix leaking comment character config
In-Reply-To: <8fbd72a1002d1a285847c62b5524041927a7b4d4.1723121979.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 8 Aug 2024 15:05:07 +0200")
References: <cover.1722933642.git.ps@pks.im> <cover.1723121979.git.ps@pks.im>
	<8fbd72a1002d1a285847c62b5524041927a7b4d4.1723121979.git.ps@pks.im>
Date: Thu, 08 Aug 2024 10:12:26 -0700
Message-ID: <xmqq34nfhrb9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 63E6A96C-55A9-11EF-ACAC-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/config.c b/config.c
> index 6421894614..cb78b652ee 100644
> --- a/config.c
> +++ b/config.c
> @@ -1596,7 +1596,9 @@ static int git_default_core_config(const char *var, const char *value,
>  		else if (value[0]) {
>  			if (strchr(value, '\n'))
>  				return error(_("%s cannot contain newline"), var);
> -			comment_line_str = xstrdup(value);
> +			free(comment_line_str_allocated);
> +			comment_line_str = comment_line_str_allocated =
> +				xstrdup(value);

If you are to follow the _to_free pattern, you do not have to
allocate here, no?  We borrow the value in the configset and point
at it via comment_line_str, and clear comment_line_str_to_free
because there is nothing to free now.  I.e.

			comment_line_str = value;
			FREE_AND_NULL(comment_line_str_allocated);

I still think the approach taken by the previous iteration was
simpler and much less error prone, though.

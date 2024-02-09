Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891121350
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515641; cv=none; b=l/xlIPjDEgNiU5SFp3Mi0IiwzbgU2gMs8f++ht+uP8coO01CE4TcMH3md2NoRD+P/UZ0Qj71TsWsV3EjWmMq8xinnaLBhfErn91f0MZjFt4Sd+z1MByyU4/nxSzhoUnvLag7VZ3nop0mrJ918iGz9JZpGpucIsRHYOS6g/hAkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515641; c=relaxed/simple;
	bh=a1oE0HOO2dZPi9yeuE2tMbzHoj0r4lRUjckmwZd01sM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HE5mVoQ2mRmKtckBKWdn27weOv2oMAhj0Esitlr5Sl0AjkFwkLu7/pmBT87HShcxPMX08pMpsIUL/aXCSB5sCio07PltmUMVg/a7zKLMLfTFLHssP/xF7rJaGXjl4v480Oej7w5be16bCeoY6OsdrQJIXTKQNxVjJxcOYSpXFVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EHpv6JNV; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EHpv6JNV"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 54F1E1C76E;
	Fri,  9 Feb 2024 16:53:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=a1oE0HOO2dZPi9yeuE2tMbzHoj0r4lRUjckmwZ
	d01sM=; b=EHpv6JNVW+m0i+ZUAHk/Pd2kgeBuDhGfhxUkO4N7GMjVB337J02aOg
	iVf/ijYR2DvidyVIJ0PY0fC0NMsyKMFgS+iBqMGrJ40AWZydzY72RY7tbUY0Tz30
	l3dMwCL/I6tP5vyiDWoxVPXFTZtMX5u3sB76vJmWjcOYSyNmVcpII=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CEEC1C76D;
	Fri,  9 Feb 2024 16:53:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5F4701C76C;
	Fri,  9 Feb 2024 16:53:55 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v4 12/28] format_trailer_info(): append newline for
 non-trailer lines
In-Reply-To: <a72eca301f7f9016ef3a8063f79790ce00f41ffe.1707196348.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Tue, 06 Feb 2024 05:12:12
	+0000")
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<a72eca301f7f9016ef3a8063f79790ce00f41ffe.1707196348.git.gitgitgadget@gmail.com>
Date: Fri, 09 Feb 2024 13:53:53 -0800
Message-ID: <xmqq8r3te232.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B8797574-C795-11EE-9397-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> And before we made the transition to use trailer_item objects for it,
> format_trailer_info() called parse_trailer() (which trims newlines) for
> trailer lines but did _not_ call parse_trailer() for non-trailer lines.
> So for trailer lines it had to add back the trimmed newline like this
>
>     if (!opts->separator)
>         strbuf_addch(out, '\n');
>
> But for non-trailer lines it didn't have to add back the newline because
> it could just reuse same string in the "trailers" string array (which
> again, already included the trailing newline).
>
> Now that format_trailer_info() uses trailer_item objects for all cases,
> it can't rely on "trailers" string array anymore.  And so it must be
> taught to add a newline back when printing non-trailer lines, just like
> it already does for trailer lines. Do so now.

Very nicely explained.

> The test suite passes again, so format_trailer_info() is in better shape
> supersede format_trailers(), which we'll do in the next patch.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  trailer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/trailer.c b/trailer.c
> index 12cae5b73d2..0774a544c4f 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1125,9 +1125,10 @@ static void format_trailer_info(const struct process_trailer_options *opts,
>  				strbuf_addbuf(out, opts->separator);
>  			}
>  			strbuf_addstr(out, item->value);
> -			if (opts->separator) {
> +			if (opts->separator)
>  				strbuf_rtrim(out);
> -			}
> +			else
> +				strbuf_addch(out, '\n');
>  		}
>  	}
>  }

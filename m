Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9B94D37A0
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832282; cv=none; b=RITRsfo/mxIUFPSOpcIwK8ikPon5ieVj8U986bqGAuMDu4BMcrye+MeeV09JXJgNdWG/rR80TdQUftoHKvdN/4owfhEp7HFQkk2TKATpp9n0Ty6KJpe4ErvkRYKM4LU1TVWSLurxMdjaa/OGuHaxEc3420SakrkR8VovE08C7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832282; c=relaxed/simple;
	bh=7vKSiAT36ppkysO8+L/3pDEIy0dKgL/5gZuhkDGQ1NU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BXvvm1K2cmcP1ZJT80ZRhpPNkoTKNF9cQ/uheqO2Yflt7bCjHWa3JesPY8z3r0mrjSd3LXeKq/wXDF2WC3zkJW9jB2raXkxgGseydVTsJG+dD++OQlBXWpvhSYwYMEIujNkHkHCn7bq62Fm36utcYc58YnTeqPd8AXYI+CHhj68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O8PTZ/US; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cBMJ8tEr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O8PTZ/US";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cBMJ8tEr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4ECC0EC0854
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 15:11:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 12 Oct 2026 15:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791832278;
	 x=1791918678; bh=qbKtPaWzh5Lxe1/7qmC9RTU+1BI7VkJ4a/S2gZA3RPs=; b=
	O8PTZ/UScsr5y29b/xtmRdQ3KCdwb8C75SsLBfwhCHJOR/jdEviYhTK1ckC4MzJd
	jQYs7z7ge/if5McEWrQ5tSRlO9HOMkIezwnG4b2gao6E5mtjYKOrHSNSiSwIcqQb
	1tiQSLL43tEYDJCXqO31/tdISSSV61ZerPQ6z/5nO8FB2+138E0UU3d08yhoStm9
	YNEYoZzMeU6wbtMEtd65SouWOXs0qMt2vNpISeM5ef668CYXoejvqafnM1B5gENu
	YX2eAP2gq9zcSwlbLMWZ0JrsVYj+0L+X6wRBkK+q6EIQ6irlZA5gekp7xCNflTme
	NLa+4Ta0PW0nP137cAuozA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791832278; x=
	1791918678; bh=qbKtPaWzh5Lxe1/7qmC9RTU+1BI7VkJ4a/S2gZA3RPs=; b=c
	BMJ8tErD4Ry+4EH6BQWdxekw0MrXXghgXBjcLXzSLNhkoVrp3cVHpk0IyzIdZwON
	rcxQNCKYj4pYGYLJR4WbyenaS9T3YtF7QYAAex5UAkQqyVANnhOEMcJM1ZppOEb5
	a8g4OfrxrX9QFGZxXxXpbknJMKUj+sGvidk+HOHl/0zIeCt7cz2d4zw0MPQTQZgu
	ngo/8MXgfv2+zk5VjpqylRyY90iLYnG4KnRC19i2CxHbx+ro0/noeWOJD3JUktiQ
	iWfAaBBXwxxyw/MTYDPTLcda/BF349UPzHwyhfW6VyTCP3ar3v03o5idJtDS8PhK
	FRuGA7lTVH5fq/Wt8s3iw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791832278; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jBLzJlMm59m7TBTuYbVVDdNU/wW+tiyTnyshRE0b4n2oQzF
	gOI6HlhgQW1zIsEnIp1iyptn1234NtEABXyllRi0F/fkpyPpUFb10gjTPLsG4Kea
	IXiDbe0lTX5e08RgpxG+m8/T51Js6/v4ibsmavyxw/dVFKC/5+MQbzW4xMekS4A8
	iv2q4p707QW61zGOER+GG4AuqlGaZGpT6iLMMFuyI4Gxk5axSRJcABT6HVJsP7LS
	RVrw15ccY0toWSa+B4PwM2mCggKsCJxSyWrQPA5/0iKYF1JewlRlefHTFeHCHtBj
	kDe2gDkMXVjZ08BXc5m3G/njLq84mu0ff3h7emg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:S+hl9JdTkIbN/evmvoLPMdZsGsOSpU/u+FzzPEpl17s=:7vKSiAT36ppkysO8+L/3pDEIy0dKgL/5gZuhkDGQ1NU=;
X-ME-Sender: <xms:1jDNauX_hbCL7ElesooL9YV-Cr2TOLx8FykBu7oOf_3xHqfgZL5q8w>
    <xme:1jDNahlzQG2GPO0oWbhE3E8kbScQVI_dOiqEh9mKxUiwGFuUSWy5Wj_JcRcuAFqPL
    PQC3EpGiXIyfrFCYRui55704JrpQaKkwRQk6Hui2Y8Vpe_ukzLBaQ>
X-ME-Received: <xmr:1jDNanaFz6Iss_ZNGlpbLzKhhCEF0D_dYcMvcbRwmwEbLd9dDAbJxhuRn8b239Tn1ETQuAm_948OdiIb-uz1Gj5ZlWlFaK-119BZ>
X-ME-Proxy-Cause: dmFkZTGkpqEn0WCOfSunoTlw0lh/KEgunIX+lOpgzHCiADhIAYrtp/t4wfcleUOybOW+rq
    HuAhdO/7/QZCNpen1rU5O0nEuDaWJOQ/b4wzBz465jMvLm/IoEmcNMb1KEA4M4Ix+DM2F1
    I9CK8r6J3O30Iiwj0uvPqJR4eg/DyJqdN8ME+5ekRAAwY8O15Uw7zrdSpGsBbBDu076x2L
    POq5XBTTD8uEIMZPL+hrU0fMLvPDmiEnaUA817TVUySMduZZFDqdKOYyYDy3ztxgZtSyw/
    Ex1eVyQJBWm+7KHZnOV8j+PK2zlFMFRUm4WzUYDc+tIQ/O/2K8dXtfEPWNm3SKc2ObW4pl
    uQt8UnR4iBRSorRSuiqTOvVNY8be5n4kAdJUKgAcMKEqY6IPxya2UfgDuiUfKRGoTcBur1
    EV6HI80zepGi8wUViADyAlKXE2O3wGBb+k+K+fAG+ioTzNM+UgQM0K2P2ztxUkVb63Pcxj
    I57j4RR5Q1tcScNGTBVpH+sdsU6eHRRR839bdgzdgeU6OJ3FzoMme8lWehoLHh9gWAHksZ
    CxIG+ixjdh9DuRpRVC1IdxU+5BbRf2Es3JeMYIy1sHtj8L1NCoIl3uKMHZegDQSZfAT8XX
    N9H1rMCqDueuNlJGZNHi1afDuIpgOh8BIUPbEFFa/DC2PD4YkqGERGldLg6Q
X-ME-Proxy: <xmx:1jDNakPlK_qxGxkl0dEAK0GoRZtRY-xsJDdGgsNrKGFIb3WCtEd6Mg>
    <xmx:1jDNakYFsBUswQ4GPVADuic-BkNncGdT5xlR_EvHOGR0dbc8uUEwkA>
    <xmx:1jDNaq1wzT_fGRGw9yiElN0xYTQkqQZLFTGTGEr02rCw8t0UCRX_jA>
    <xmx:1jDNaid7GytwsNK20yYGjshfC8L_pzUs7POklrOJuGdlIRRhtugsiA>
    <xmx:1jDNatYp3AHTX3YDzva40oRB_0-xRvyUNxwQ9IapFcEYtBEkmuzRV5QJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 15:11:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  curtis.allen.smith@gmail.com
Subject: Re: [PATCH v3/RFC 1/1] read-cache: do not trust a size change when
 conversion is active
In-Reply-To: <20261012175638.3712-1-tboegi@web.de> (tboegi@web.de's message of
	"Mon, 12 Oct 2026 19:56:38 +0200")
References: <xmqqwm1no29m.fsf@gitster.g> <20261012175638.3712-1-tboegi@web.de>
Date: Mon, 12 Oct 2026 12:11:16 -0700
Message-ID: <xmqqik3668ff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> "git status" can report a file as modified while "git diff" and
> "git add", which both run the clean filter, agree its contents are
> unchanged:
>
> 	git init t && cd t
> 	printf '* text eol=lf\n' >.gitattributes
> 	printf 'one\ntwo\nthree\n' >file.txt
> 	git add . && git commit -m init
>
> 	printf 'one\r\ntwo\r\nthree\r\n' >file.txt
>
> 	git status --short      # ->  M file.txt
> 	git diff                # -> empty
> 	git add file.txt        # -> updates the index
>
> Note that "clean filter" here means the "clean filter" and CRLF conversion,
> and all converting of a file in the worktree into the index.
>
> Problems that have been found in real live:

"in real life"?

>   Tools that rewrites unchanged files in native line endings e.g.
>     javadoc, code generators, formatters and some editors change
>     the size of every file it touches.

That is not just size but contents are changed, no?

>   Editors that insist to replace 4 space with a TAB,
>     even if the file is changed manually forth and back -

"back and forth"?

>     Using a clean filter that changes the TAB back into space when
>     committing will cause the same confusion.

This also changes size as a result of changing contents.

> `git status` and `git diff` disagree because ie_modified()
> in read-cache.c concludes that a file is modified
> as soon as the size has changed.

"when size differs, without looking at the contents"?

> Signed-off-by: Curtis Allen Smith <curtis.allen.smith@gmail.com>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>

How is the collaboration going here, Have you taken over the series,
or are you two working together on the topic (or I take that your
intention to CC Curtis is to work together starting with this
version)?

I am wondering if we want co-authored-by or similar when we lose the
RFC status.

> ---
>  read-cache.c    | 25 ++++++++++++++++++++++++-
>  t/t0020-crlf.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index c4cf08a3a3..9aebe4c394 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -9,6 +9,7 @@
>  
>  #include "git-compat-util.h"
>  #include "config.h"
> +#include "convert.h"
>  #include "date.h"
>  #include "diff.h"
>  #include "diffcore.h"
> @@ -438,6 +439,27 @@ int ie_match_stat(struct index_state *istate,
>  	return changed;
>  }
>  
> +/*
> + * A difference between the size of the file in the working tree and the
> + * size recorded for it in the index proves that the contents changed
> + * only as long as the two are byte-for-byte comparable.  That stops

"compatable" -> "identical"?

> + * being true as soon as the path is run through a clean filter:
> + * rewriting a file with CRLF endings under "text eol=lf", for example,
> + * changes its size in the working tree without changing the blob Git
> + * would record for it.  For such a path the only way to tell is to read
> + * the contents and convert them, which is what we already do when only
> + * the mtime changed.
> + */
> +static int size_change_is_conclusive(struct index_state *istate,
> +				     const struct cache_entry *ce,
> +				     struct stat *st)
> +{
> +	if (!S_ISREG(st->st_mode))
> +		return 1;
> +
> +	return !would_convert_to_git(istate, ce->name);
> +}

Wooo, that is surprisingly simple.  Even attribute look-up is not
free.  How much overhead are we adding to the case where no clean
filter is involved, I wonder?


Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1F9484247
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821387; cv=none; b=bVNct+83MX5CRRz5efy8NCjFvUL6IPT+KInVvAZIPLnLjtHMgmk1ChXf8uog6PMZqRofIf2XIlxyljkmVxy/q431vR5NeBEmvYzY8dvYD41Ag3tuwwknOxZfhfup9SKm0gxqErqTLeVD8+PA95/29IpNHBcstSKAAqBs62bofTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821387; c=relaxed/simple;
	bh=rv5Y2n573lU5FNMxSDghM6DbaxomhmrOGUdWzfbAIOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1xnLiwZh28MpSJ51wxVcGt86Uko4Vq10t/7HxnUddv1xIKMtGMIEi/9P2LUV26TQ00aadn8WZcbpUDW8jw565R9UtnP5Xp1LHg5unPM8kzJjK1qugSHsyW+xCd727XyUAeA9t/MtiBGHY7d8olD7ofjIncsumHqDFLgJTof4hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ELiwSp8H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q4OMbqyu; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ELiwSp8H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q4OMbqyu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6DE8C1D00077;
	Thu, 23 Jul 2026 11:43:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 23 Jul 2026 11:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784821382; x=1784907782; bh=Lwh3e96A9p
	tccaKIu6QctRbTn0FgOPpImt6C7iwA+lc=; b=ELiwSp8HjcG07XEvw/g/yOvHt6
	EUaGF/88QfkVDZJlOGJg15GGskSPlGKsPGBr0SsKVbE8z2Qxdtk2IMUj4DSCIWpq
	4OaCScovEHbWEGpbWkvDmxiTmVKXT0Z3C7gCY3g6MI2vfzdZaqK++lP0PlujISvG
	KKS2i9vzt8Uoj1B1/MjbBlbwV3Z7CNIIEEIsU0tOw2MOtCl9rP53Wbd/TQLnBUNk
	l5zFpym7nO8hYNOVfTmuayq7Je3jqCjjsJ6WyEZUNy6TsRhuUJLiT/XYivOLd1Y7
	ag8AgCmFnEoTsBW9292AR47RvO2mJY4+AWgLonN+KNCljTL8WFm4OBlMMklg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784821382; x=1784907782; bh=Lwh3e96A9ptccaKIu6QctRbTn0FgOPpImt6
	C7iwA+lc=; b=q4OMbqyu7ZEfg62NWEOVgZWe3cbY7BB7/JY3KV0yz6jUgkXJJZy
	XrzoKr2LBaYAz6tolDKOV6U6gXded+HDnyuVZd9hz150Yo77jKnqvwglvX8bbZ8g
	+0VRd81sQbgoAkquFpD2fatpzwaRWQQdTtGVE9SCrVjfY+kQmd3a/ycNmaYaEtE5
	RIhk0fUPM33t5trFkk6ra4TzrJ/fW05FCSqhHXazn6uTR4N8Mv4XWTHxesQj9Vx5
	IsLHmbhXZqI+5gYs+WDCyGrYHXYkiZPQd6M/CfqJ+BRaO06vlOY1N9EDo4HWY77Z
	9qHLc7mXWWrOB2vDo+dqGIrdTtDH1hdY3UQ==
X-ME-Sender: <xms:hjZiarnxx0-lRdn5tvEq4wBIBvtguBcCxcw_MGMX9DC9rXuP-xstQw>
    <xme:hjZiamQZrJGkj28z3ZJR_Q_Q5vgfpTYC4iluht3LOH5w7ULuz596Ew4hBHWAf8H35
    9uweR_oy0I94foWt-RQ_3ToSHEPlP7OCjt--3iMjCTS6jyZzuDcs7c>
X-ME-Received: <xmr:hjZiavCvxPlmvukgy9e6Y-Ie-dTyMm1Olt8TfWvXjSgLlbLXQXQtMCBysXjpcsmNqEb01vrTyzmVqFsx3AZCpEpnWMyQ6lb2zQ>
X-ME-Proxy-Cause: dmFkZTEY4WSZ7GU4sw20TPRzC6/fppkdqyiE31zxnUzYLPn6h26G7twaJIFFPrUKTX2hpC
    za0iHwIEfBQnNxQAmbruWs6y4/n7cSyu/UN8nmkxuL2+JmHnIRFae9Nr6lRFVONR+EaUgE
    DMK+fxBczTQXYC3fNvggkX5CkbIdVDVJuq2KePap+XbYnEvVmThTvk6OuWml/HBWlqV01V
    QmUMCyKE2BtBuu7zmgRBxwDYqN7exrrzGSCPUOyiha1sdmrR13FyhRRz5RdDvHQ8l/EPee
    t0Fu2Qp/i7Dktuvz1Nr7f1iQQPUP76CYwTSg7vFZ+S2cYEYOS/qHPpAjpuM3jNGFeBK1ou
    5kE2yaJ57u8y9cxnec4p0RWktH5L3ny7ZQgsQ09X1DXbKCnWIxu8hSCZoHqNOZC1oNhYdw
    hNdNzuHZyPJ+4NfiRf/7mwaMblgHmt3T7vIXZQSFNcbku+8gB0/vcYLA+v79ByGjQmD9RD
    D8Hm16V2Rm9568djv+GZaG7JnLDjU5Zs0mnhCj8LBeW8422nPz13XcG0cSGEZbOVKWgBmu
    LnCzD6I5eyugAoF/ieSy29OKBapwe63Qknz8JPYAbrSAF5Z/Sl2hLweqK7nJFykFG1GpkP
    +aP/y/SJuUJDeIYbSw7C/HLLP1OOUYa82JldtHTVwNIxtv+E1HMxf37fsRKQ
X-ME-Proxy: <xmx:hjZiatQM20ggroE7z9tC5V3zIn8CRxMuPcN28o4u_sQifofaJncU7g>
    <xmx:hjZiatppnOirKjJf2Kdzsk_v-RdurbF1qOFrUU-h7P8JhpZwOv2wgw>
    <xmx:hjZiavxuPD3Fv2o7SpDaqfpxVeOFHT5Qdz2ovMwZm2Xxj8dYX0MIAQ>
    <xmx:hjZiaiKzlKRlM-Hv6wOCsE4dVLqfmesMYOZYsSpW_JhaF58WfvV4_Q>
    <xmx:hjZiajiLN553csIa0HJJ1H-J7fSoH1ZVqNEriZUDvzChZcFsVx2n1y36>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 11:43:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Friedli <adrian.friedli@mt.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH resend] builtin/clone: fix segfault when using
 --revision on some servers
In-Reply-To: <20260723144318.69007-1-adrian.friedli@mt.com> (Adrian Friedli's
	message of "Thu, 23 Jul 2026 16:43:18 +0200")
References: <20260723144318.69007-1-adrian.friedli@mt.com>
Date: Thu, 23 Jul 2026 08:43:00 -0700
Message-ID: <xmqqmrvhlnjv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Friedli <adrian.friedli@mt.com> writes:

> Fix a segfault when a server advertises more refs than requested when
> using the --revision argument.
>
> Signed-off-by: Adrian Friedli <adrian.friedli@mt.com>
> ---
> The segfault can be reproduced by e.g.
>
> git clone --revision=refs/heads/main \
> https://dev.azure.com/public-git/sample/_git/sample

The following two paragraphs' worth of explanation deserves to be in
the log message:

> In the good case the server respects
> `transport_ls_refs_options.ref_prefixes` and in `cmd_clone()` the linked
> list `refs` returned by `transport_get_remote_refs()` only contains a
> single item, which is the ref requested with the --revision argument.
> Both `remote_head` returned by `find_ref_by_name()` and
> `remote_head_points_at` returned by `guess_remote_head()` are NULL. The
> guard in `update_remote_refs()` skips a the affected code because
> `remote_head_points_at` is NULL.
>
> In the bad case the server ignores
> `transport_ls_refs_options.ref_prefixes` and in `cmd_clone()` the linked
> list `refs` returned by `transport_get_remote_refs()` contains many
> items, amongst others "HEAD". `remote_head` returned by
> `find_ref_by_name()` is not NULL and `remote_head_points_at` returned by
> `guess_remote_head()` is not NULL but its field `peer_ref` is NULL.
> Because `remote_head_points_at` is not NULL the guard in
> `update_remote_refs()` does not skip the affected code and
> `remote_head_points_at->peer_ref->name` is accessed, which causes a
> segfault later on.

Usually, our commit log message begins with an observation of the
current behavior.  We would probably start the log message like
this:

    Servers are expected to refrain from advertising excess refs,
    honoring transport_ls_refs_options.ref_prefixes, when

      $ git clone --revision=refs/heads/main $URL

    contacts them, but when talking to a server that does not (e.g.,
    <<the URL of the problematic repository goes here>>), the client
    segfaults.

and the above two paragraphs would flow perfectly after such an
introduction.  They clearly explain how the client gets confused by
unusual server behavior.

The above write-up makes me wonder if there is a valid case where
guess_remote_head() should return a non-NULL 'struct ref *' whose
'.peer_ref' member is NULL.  Unless a non-NULL head that is a symref
is given, in which case we firmly know where their 'HEAD' points,
the function seems to pick a randomly guessed ref out of the given
list of refs (supplied to its second parameter) and return a copy of
it.  However, there does not seem to be any check to ensure that it
picks a ref with its '.peer_ref' member set.  This may break other
code paths that consume the value returned from guess_remote_head()
in the exact same way, no?

I do not know offhand if that is the case, but if it is always wrong
for guess_remote_head() to return a guessed ref with NULL in its
'.peer_ref' member, perhaps that would be a better location to make
this fix.  What do you think?

In any case, can we also add a test to prevent this fix from
regressing in the future?

Thanks.


>  builtin/clone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 9d08cd8722..bd0c6f5d56 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -557,7 +557,7 @@ static void update_remote_refs(const struct ref *refs,
>  			write_followtags(refs, msg);
>  	}
>  
> -	if (remote_head_points_at && !option_bare) {
> +	if (remote_head_points_at && remote_head_points_at->peer_ref && !option_bare) {
>  		struct strbuf head_ref = STRBUF_INIT;
>  		strbuf_addstr(&head_ref, branch_top);
>  		strbuf_addstr(&head_ref, "HEAD");

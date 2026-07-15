Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AD048C8DC
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138211; cv=none; b=GSMFHxEQtTBJy4C/TWDA0rVwTMUkGLPimSV0+PzRybBxR/JeUPD5gRwkWROGzu1YOlD9m/dJcwFdzGSpDh3oKrN+nfB1gkznfrN9BnW1iOc2pKNDxZG3ddD0wW36l1I82KObToKbnktzUjvFGzl1Yn+Jmdl/UnzbdcErluynCCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138211; c=relaxed/simple;
	bh=Hr5pcmUBOcYWQWqkLKj0nLULnfIvjPnEhXcvU1iu1VY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AgDdDfURPn1o1o5H8qhvqD7C55CEuu5qpgONocbRpPBP+ch9LGrrkmBacsDNbLMXwUe9s7UPsGDhpj1E6Xqszl8fTa54JQAAi7ZVRiKliM0m8rB5T9Nm+6+c90DG0bCOt58wN57n0FBQ6BWVRq35kwGUgb9e+rxyymPM0adgm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ETAxd6eM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CWFdK9hM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ETAxd6eM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CWFdK9hM"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D6397EC0173;
	Wed, 15 Jul 2026 13:56:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 15 Jul 2026 13:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784138208; x=1784224608; bh=pShT6Lg1UK
	5iGgmNNE+lEHwzpU+wCLrIe84wDavzxZ0=; b=ETAxd6eMEZ5/qGMPjdFRM1edNU
	wRndUMxZQaYb5dJcxoGy7O+V0EoHLfWYu5s3lm5mvrMRGGXTgSqrmUS3IVS2QZkw
	20c8iFJJ6qEjnFnX9IbSHzV43vNfY5onE3ZHReuiACOtZrYArop/NjBegzGpbGKg
	9Gk9H0txK97FKNzmiZ+n303E6J2tH83bSkG3CxMiMo8guChG8w7bcVMiVwxljtt1
	8q0J5L44QHZLSJfQq40xz4LS4P//EyxdeV4+MWyEMWHxLeXjOtVdUhMwi07wKJj2
	3qMSMef4CGeL0dT8T+MC3VT38ZCdJdTC0i275EKDqxQOhd6nYol98GLz59AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784138208; x=1784224608; bh=pShT6Lg1UK5iGgmNNE+lEHwzpU+wCLrIe84
	wDavzxZ0=; b=CWFdK9hM1Fl3v100HZmbP/apQCxuY+gn7NplRz6A4tBysbq7IBm
	5i6ldsMmAyfEGAg4YY0m5Ad/ZNnsT50jf54AN8QCScqbKDIGgpdgk4rDVNa+XH/x
	MhRQYSgzcnhaGymeDvP1LurJj5zdMSlqQRLm5PukTXFKJfqbZtP8+sFMxNDu12gh
	k0BcOZvgEMuTYJA6tdTqN8uaxTYeik+2GbwdrgDzpkqFkDf4RUi6mwVdhNxAv++N
	rNbY6QR7AzKtCauLkOuky4Va3Si+HVZnu/c7y9W5wnydD8gXs5YyqiTeQ8OfUIvv
	toKJsap1NQaADo70QNnYYykH+mxdIuILI/g==
X-ME-Sender: <xms:4MlXagf27rasDWkJt_pUM7CJRBfpgy6yuhfYl35tp7tDLwq1L_RPnA>
    <xme:4MlXauzxCO3OHPpVjcsVwEOomF_XeBjktsKbfISAbQVNdWQQ2jOqxSlJX9wYNgMyw
    HixNDNxw4svX-IGxNH2E5s-B0ewKACVyJ_15xSN2t2FSLhuRngeSQ>
X-ME-Received: <xmr:4MlXal9CXxcnnmMkRKZL2xBPV88C9BuTDY6O14OeS9Z5YAM3TXlI2YgNxFhx7zbIhsZ1YdOv_rb6IkRR4Vgw1pKgOe8xiu_cLfsR8Tg>
X-ME-Proxy-Cause: dmFkZTEKH9Rj2f4iq/SDe8d01tMKFhnS/S37rkmzL0ZX+bKaD2Eh34qZfdUb8VxxCDXkVt
    SHJRdO3ISt8nf5C76QqTE6O++CY5nmBD4dfLXUfql8W49dTS5N4lh/I2VjCBabG45JpQXa
    Uhz2vxU8+BTY+gfKtZLVL29xdihZwiO+DaTsMgFBW+MA3nPWRsQLMbyRHZNXHHwFgrAkxv
    aVx0330kNz/+33kgqav8VQ3I6gVYNWxhqcH90+g5ywpuIs9y6/PifpZuRpHv6fB2R/7fQl
    50pxS5e+9Ikylp0S57F3fOySjX0C+Np4mVnaXjjfsfIg3IfhgomVWzkdUAduhSH7PYoPBu
    pnSCcg7a3PKrvwYxKWLfMeCdy9I+CFxEN3/zfZTJkpHrI9fO7oJ+/tRua988rgjdwaoIFm
    usPZJNpIfu1V4xHFAyUmurOhrMSKt8QQrmt0WnNd5lqMa4sKkYrMD8x0BjRMmf51kId2/d
    LxcP5nWTa5xCUZwQMtZ/shR9MrGll2Opsdllr7IScFavr9pQ3p24ezE3oiYotv95cGdOO+
    W0LRC73kNqD3j1gY/7gGBm8hHj5icYG/abAjmOdZWGQheiwUP1af3zJtrU3amscf70OeNk
    4HAHrTM6CcWVpCX4xRDQRicl1tUQ5JNs+NZxztbCe3Y47HSakXjTh2tdqymQ
X-ME-Proxy: <xmx:4MlXasydOUs1RScWEdO4I2j6_MKVvBzEcBg6diFvB14G3Tn559JUMQ>
    <xmx:4MlXatpPe4f2qG8gJw0kdYGR5zyzaQI4Z5OVNQU1QR2oS8vj1A0cQQ>
    <xmx:4MlXalpTOfv_kmr_Z4-m_D9NLDTyjgiFVRPx7smtX7DpCbIT5ZCbUg>
    <xmx:4MlXalDCA-_-bd1ermKmV3LKMXpDzqMDihxEqrasAx_1XD6j2DClGw>
    <xmx:4MlXahmaQcpIcPpQrRPRXe9osBJg736DzErKrH-R8d8Qg1OPWRHwvOpU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 13:56:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  chriscool@tuxfamily.org,  eric.peijian@gmail.com,  jltobler@gmail.com,
  karthik.188@gmail.com,  peff@peff.net,  toon@iotcl.com
Subject: Re: [PATCH GSoC v18 13/13] cat-file: make remote-object-info
 allow-list dynamic
In-Reply-To: <20260715-ps-eric-work-rebase-v18-13-34d7adb051bb@gmail.com>
	(Pablo Sabater's message of "Wed, 15 Jul 2026 11:52:21 +0200")
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
	<20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
	<20260715-ps-eric-work-rebase-v18-13-34d7adb051bb@gmail.com>
Date: Wed, 15 Jul 2026 10:56:46 -0700
Message-ID: <xmqqcxwonnkx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> The static allow-list in expand_atom() is hardcoded to only allow
> "objectname" and "objectsize" for remote queries. This works because
> up to this point all servers will either support object-info with name
> and size or they do not support them at all, but we cannot expect that
> in a future different servers with different git versions to have the
> same object-info capabilities. Therefore, the allow_list needs to be
> dynamic depending on what the server advertises.
>
> The client will now:
>
> 1. Request the protocol option that the placeholder refers to (i.e.
>    "size" when "%(objectsize)").

"when" -> "for"?

>
> 2. Filters the request in fetch_object_info() dropping any option that
>    the server does not advertise.
>
> 3. After the fetching, the options that haven't been dropped are the ones
>    fetched and supported by the server, these supported options are
>    mapped and remote_allowed_atoms is populated with the placeholders.
>
> 4. expand_atom() checks remote_allowed_atoms with the same behaviour as
>    the static allow_list had.

I am not sure I follow the above entirely.  Could you add a
concrete example to the commit message?

For instance, if the client wants "%(objectsize) %(objectcolor)" and
the server only supports 'size' but not 'color', the filtering in
step (2) prevents the client from asking about the color, requesting
only the size instead.  When the server says the size is 42, step (3)
uses that to substitute '%(objectsize)'.  Would the end result then
be "42 %(objectcolor)"?

> -static const char *remote_object_info_atoms[] = {
> -	"objectname",
> -	"objectsize",
> +	struct string_list remote_allowed_atoms;
>  };
> +#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD, \
> +			    .remote_allowed_atoms = STRING_LIST_INIT_NODUP }

Hmph, is this list expected to change over time?  One-line-per-item
format would be more suited for updates if it is the case.

> @@ -683,12 +675,12 @@ static int get_remote_info(struct batch_options *opt,
>  			   int argc,
>  			   const char **argv,
>  			   struct object_info **remote_object_info,
> -			   struct oid_array *object_info_oids)
> +			   struct oid_array *object_info_oids,
> +			   struct string_list *object_info_options)
>  {
>  	int retval = 0;
>  	struct remote *remote = NULL;
>  	struct object_id oid;
> -	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
>  	struct transport *gtransport;
>  
>  	/*
> @@ -736,15 +728,12 @@ static int get_remote_info(struct batch_options *opt,
>  	CALLOC_ARRAY(*remote_object_info, object_info_oids->nr);
>  	gtransport->smart_options->object_info_oids = object_info_oids;
>  
> -	string_list_append(&object_info_options, "size");
> -
> -	if (object_info_options.nr > 0) {
> -		gtransport->smart_options->object_info_options = &object_info_options;
> +	if (object_info_options->nr > 0) {
> +		gtransport->smart_options->object_info_options = object_info_options;
>  		gtransport->smart_options->object_info_data = *remote_object_info;
>  		retval = transport_fetch_object_info(gtransport);
>  	}

This is not a new issue, but if the caller does not ask for
anything in object_info_options, no call to
transport_fetch_object_info() is made here.  This is so even
though we went through quite a lot of work, including the
connection establishment and teardown below.

By failing to contact the remote side, we wouldn't even know if
the objects being queried actually exist there, which is
probably even worse.

>  static void parse_cmd_remote_object_info(struct batch_options *opt,
>  					 const char *line, struct strbuf *output,
>  					 struct expand_data *data)
> @@ -839,6 +843,7 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
>  	char *line_to_split;
>  	struct object_info *remote_object_info = NULL;
>  	struct oid_array object_info_oids = OID_ARRAY_INIT;
> +	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
>  
>  	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
>  		die(_("remote-object-info command too long"));
> @@ -851,32 +856,57 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
>  		die(_("remote-object-info supports at most %d objects"),
>  		    MAX_ALLOWED_OBJ_LIMIT);
>  
> +	if (data->info.sizep)
> +		string_list_append(&object_info_options, "size");
> +	if (data->info.typep)
> +		string_list_append(&object_info_options, "type");

And if the request is only for "%(objectname)", an empty
object_info_options is given to get_remote_info().

>  	if (get_remote_info(opt, count, argv, &remote_object_info,
> -			    &object_info_oids))
> +			    &object_info_oids, &object_info_options))
>  		goto cleanup;


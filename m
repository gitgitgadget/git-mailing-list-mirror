Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C917F748F
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720072200; cv=none; b=AWh1qU/fFPJfJm8+RyfjMPIgEn1p8wlmvPIbj9yWRNDknt2+yI4FlCrw1PMxGtF7AGqQIvf59F+gsQbPz++Bo9yhM0sAFnQj6G+Td1HVjeBY3Gufv0u0/MpgKoKD/GcxbVL1nvANj8RcUMrwnIhxSpQpAOzZenCcN+V/9AcssBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720072200; c=relaxed/simple;
	bh=MawoediQHVrdKa9nEN845hwlv/vFqHGmd+AvmQEL55M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eIbIEkP+57PCgr4zwjCzmQYVGVZDtlMKK8HoxAzZMgfZ6unhAK66eHz/I3ONY8D8zV74RDUYST/ABqI/8ZoQwZBcUoqCFW9l0iHm8HFoFq/bks7gCShyiV+20Vv+JFh1pZu/M2Qw1vEs/lmRvWTKIQgpzOWT2CkxDrRjYdmtbN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6jCtpIo; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6jCtpIo"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so153745a12.0
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 22:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720072198; x=1720676998; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EI8Ae/jL37cJKO3RIN7gpqk1H3XxvAlOIC9CCTNaTOM=;
        b=h6jCtpIo2UfkguxnGX2ZaCGJJO1ljiBqiYmcDRkE9vc6NJnNRLdAUHa+xhDyMjE278
         R1rgmQEINaZh0cgQAd0xWpG4jTV+sKn1jEr+Of8uDaw5/NmvS0UdYf0uy3RGRPo9gexZ
         KUfo3yex99JDUWjPMTbLBoIjUtuo6I1lTkg7ezRnfx1U4jkwum2k2yJz/3c9ifMLwmUW
         znoEIynkBehtGpPISUflM3ie2AsjmtGdoiCmUeNKNrnp3751eoZW6Eb+RwQ+sjIPj0uR
         7ivn/NauyImqSUZu+KMDEUYDb40G6CubJZRSgKfYr/TJD69dEArh7XyXkQWIZUYQw52B
         KyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720072198; x=1720676998;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EI8Ae/jL37cJKO3RIN7gpqk1H3XxvAlOIC9CCTNaTOM=;
        b=oKNxL3KCDVd75i4pdRGLwfLXDy1GQX8moSWYcleep0L5EV+AQ2f88UZt8ssGSnLNZN
         j7LZJjcCNLunKo6V2RWGJm3xbR5noePV/vE5TDFDsLKjwUQw3ox5vVbipfTZkFS5MrM0
         nUvc/JqZP9AY5Y52kYQ5xGfJ7K69rgJZycBLUPgXQzsL+8e/sixHQOMac/SQ9tVrMTr2
         u6H31YYkJNywtQ86aQIsTSHJHHevrHI7pI0G2et36BEpk2RzwA5Fe57q6XxsXoumTSou
         V9peqycJxJwlRQge+i6CFJllRVKN68gWiX+7+GUY9SkssF2ac6uKpeOxLYUTs3Ognhio
         de8g==
X-Gm-Message-State: AOJu0YzDr22olewlB1IpsRJrw51DJo+OoEe1kzdrI4WZRFcs89Tcb02N
	OSHAaKkQD32aV+RE/0EoWqa4hfMuP5+K+rx8+3vDSsNL1cK2nESuYafusg==
X-Google-Smtp-Source: AGHT+IH5eYfh3pWx3ygtHaCh2V7PxejhJ5zVVnx1H+/AjiOmxQ4mN6f32fwQcTkuvvGR84aUrjrzUA==
X-Received: by 2002:a05:6a20:8426:b0:1bd:22fe:fc9f with SMTP id adf61e73a8af0-1c0cc90bdd8mr605451637.46.1720072197799;
        Wed, 03 Jul 2024 22:49:57 -0700 (PDT)
Received: from localhost (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15388bdsm113699845ad.168.2024.07.03.22.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 22:49:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] http: allow authenticating proactively
In-Reply-To: <20240704001748.746429-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 4 Jul 2024 00:17:48 +0000")
References: <20240628002742.3421311-1-sandals@crustytoothpaste.net>
	<20240704001748.746429-1-sandals@crustytoothpaste.net>
	<20240704001748.746429-2-sandals@crustytoothpaste.net>
Date: Wed, 03 Jul 2024 22:49:56 -0700
Message-ID: <xmqqo77d7lkr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If we're in auto mode and we got a username and password, set the
> authentication scheme to Basic.  libcurl will not send authentication
> proactively unless there's a single choice of allowed authentication,
> and we know in this case we didn't get an authtype entry telling us what
> scheme to use, or we would have taken a different codepath and written
> the header ourselves.  In any event, of the other schemes that libcurl
> supports, Digest and NTLM require a nonce or challenge, which means that
> they cannot work with proactive auth, and GSSAPI does not use a username
> and password at all, so Basic is the only logical choice among the
> built-in options.

Nice explanation.

> +http.proactiveAuth::
> +	Attempt authentication without first making an unauthenticated attempt and
> +	receiving a 401 response. This can be used to ensure that all requests are
> +	authenticated. If `http.emptyAuth` is set to true, this value has no effect.
> ++
> +If the credential helper used specifies an authentication scheme (i.e., via the
> +`authtype` field), that value will be used; if a username and password is
> +provided without a scheme, then Basic authentication is used.  The value of the
> +option determines the scheme requested from the helper. Possible values are:
> ++
> +--
> +* `basic` - Request Basic authentication from the helper.
> +* `auto` - Allow the helper to pick an appropriate scheme.
> +* `none` - Disable proactive authentication.
> +--
> ++
> +Note that TLS should always be used with this configuration, since otherwise it
> +is easy to accidentally expose plaintext credentials if Basic authentication
> +is selected.

OK.

> @@ -539,6 +552,18 @@ static int http_options(const char *var, const char *value,
>  		return 0;
>  	}
>  
> +	if (!strcmp("http.proactiveauth", var)) {

If we choose to make

	[http] proactiveauth ; nothing else on the line

an error, we could do

		if (!value)
                	return config_error_nonbool(var);

and lose all the "we have to make sure value is not NULL before
feeding it to strcmp()" checks below.

Or 

		if (!value) {
			warning(_("http.proactiveauth set to true???"));
                        return 0;
		}

if we wanted to be more lenient (which is more in line with how we
treat unknown string value below).

> +		if (value && !strcmp(value, "auto"))
> +			http_proactive_auth = PROACTIVE_AUTH_AUTO;
> +		else if (value && !strcmp(value, "basic"))
> +			http_proactive_auth = PROACTIVE_AUTH_BASIC;
> +		else if (value && !strcmp(value, "none"))
> +			http_proactive_auth = PROACTIVE_AUTH_NONE;
> +		else
> +			warning(_("Unknown value for http.proactiveauth"));
> +		return 0;
> +	}
> +

Other than that I saw nothing puzzling or curious.  Looking very
good.

Thanks.  Will queue.

Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6D6E602
	for <git@vger.kernel.org>; Tue, 21 May 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284992; cv=none; b=TM88KtaA5n2M8+yLcZm85eE0GxP3TV9iUzKUN/hzD+oC8u6K014Qhj3tk9r/7Bwiaw7j19PB/trTeimcouccoh9yf4gytWw4LUPe102rlkNDK9ry3fOMRPAMotJyQYG2jMPwUXexthJJhJnbDbOHueaHWQ1yYOmh8MrvrziGFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284992; c=relaxed/simple;
	bh=lJS6/A+S9AOUDWEd/BoK1PRjYtjgfLIuOP7VL+g86ew=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOlXojVxIQZfOU2nKmhZu6yuSWcAa5P2PEL2bktiLaP4y4cZQW+nIXG8QrBFnHRP3hTkjRrvlbQ2SrnVbBeqS+wwHtmJ+MAV3gtxwSIfmtQbZTZTnrXakz9zRc9zwNFI0fInJiS+NkzvAsAQzwI7FyLmpt6JZ3EUh4uTl1gnnGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWEZyqX4; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWEZyqX4"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9d70d93dbso1460165b6e.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716284990; x=1716889790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O0a/sjr3otb+AlWs4SGIEXNTjL0eHcgIY28YITWhVK4=;
        b=kWEZyqX46ofLnodweO2AkILDG+zxfer0xXxI/89ATtfA5xHdi+qUZIvMJCVz0LGSfJ
         P+YYPEhX98bnkbN99wv7dfv87p7nb49g5xsUShWIhtDRTOlriVObZYGWIZrjpXf32f+T
         IcYUbAifOGbBYa+8UdyJzCSZ/1aq3ldpmlHxd21l2ehqW1bbeZvIUPn1rPXNgoTm7SCR
         VisQnGG7bjr4zof4G9KbONo2eGvtcbFe0edJHgyXEaA8l2CKMnzUpHIlqQoP3gN/N/9v
         uHfdznbFDjokyLDjKqjqRkx09dvPdi9BYXm0paIB028S9ZIp5l4/gFfCq7SLyd4gqQc/
         /dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716284990; x=1716889790;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0a/sjr3otb+AlWs4SGIEXNTjL0eHcgIY28YITWhVK4=;
        b=uYTArNWNBftCLfrjRlHG5uXVFkAqYMuX/nitbcc9DEa2VeHnVBR4b+omy+AGCxW+Q5
         NXtpZH2ZaOcQSOhbqrFap2+d1uijqx5XTIAFK1fDewvVI/qzFnw2tKiIjKAW+bL7ukgi
         F46aaplXKJau9dypgyc8lXZyM2pzYqTvEciKLtHCr5+9sGo3jHanfR2NDjLqzyr/6Rwn
         J6lXGDramJZ5hTN3fY+mW6NuJNIc/dEVIvw8RNdJcvzKYEUt2IgWyL3b4VNg5y4qMf4A
         fVLj7VmhfIf/XMUTv4A7JJ59VqHomXyYyNnkraYp/VvlO8wIbf5Srl8qPOGCdtUGctWZ
         9+gA==
X-Gm-Message-State: AOJu0YybresK6Mlp4UlsLNvayGf+m1jwV6BkJYmdNS+EiXsDr/Va1tv/
	1Il822Rq3Hh4yW7FMcJYi0ktnc9PiCIvWmwobM2QYoZBBJOklObJ5ve0Dv7gQnDsGgkok7yctbx
	WSuF8Lb5P5xzrs/48msf6fLhedHs=
X-Google-Smtp-Source: AGHT+IEALdOGgbVvZ48lQoia8whDcjyhY7Aj6fDPkSXnO7HDoIHjsZBaMnIGG24t9BZWzy092gyDDROkUIpJZ6mir08=
X-Received: by 2002:a05:6871:729a:b0:23c:a6f8:9362 with SMTP id
 586e51a60fabf-24172a76ff6mr37708222fac.13.1716284989630; Tue, 21 May 2024
 02:49:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 May 2024 09:49:48 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZkXpcvF6dxGr6qmj@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com> <20240514124411.1037019-7-knayak@gitlab.com>
 <ZkXpcvF6dxGr6qmj@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 May 2024 09:49:48 +0000
Message-ID: <CAOLa=ZQW-cCV5BP_fCvuZimfkjwAzjEiqXYRPft1Wf9kAX=_bw@mail.gmail.com>
Subject: Re: [PATCH 6/6] update-ref: add support for 'symref-update' command
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="00000000000024091b0618f3bd43"

--00000000000024091b0618f3bd43
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, May 14, 2024 at 02:44:11PM +0200, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Add 'symref-update' command to the '--stdin' mode of 'git-update-ref' to
>> allow updates of symbolic refs. The 'symref-update' command takes in a
>> <new-target>, which the <ref> will be updated to. If the <ref> doesn't
>> exist it will be created.
>>
>> It also optionally takes either an `ref <old-target>` or `oid
>> <old-oid>`. If the <old-target> is provided, it checks to see if the
>> <ref> targets the <old-target> before the update. If <old-oid> is provided
>> it checks <ref> to ensure that it is a regular ref and <old-oid> is the
>> OID before the update. This by extension also means that this when a
>> zero <old-oid> is provided, it ensures that the ref didn't exist before.
>
> It's somewhat unfortunate that the syntax diverges from the "update"
> command. "update" also has essentially the same issue now, that we
> cannot verify that its old value is a symref, right? Can we fix that in
> a backwards compatible way?
>

I think Peff mentioned [1] of a way. So we convert the existing

    update SP <ref> SP <newvalue> [SP <oldvalue>] LF
    update SP <ref> NUL <newvalue> NUL [<oldvalue>] NUL // -z

to

    update SP <ref> SP <newvalue> [SP (<oldvalue> | ref <old_target>)] LF
    update SP <ref> NUL <newvalue> NUL [(<oldvalue> | ref NUL
<old_target>)] NUL // -z

this should work, I think. I will play around this and add it in. Please
let me know if you can think of a scenario where this breaks.

> It would also be great to explain why exactly the syntax needs to
> diverge.
>

Yeah makes sense, will add it to the commit message.

>> The command allows users to perform symbolic ref updates within a
>> transaction. This provides atomicity and allows users to perform a set
>> of operations together.
>>
>> This command will also support deref mode, to ensure that we can update
>> dereferenced regular refs to symrefs.
>
> Will it support deref mode or does it support it with this patch?
>

Will rephrase, in this patch itself though.

>> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>> index 16d184603b..389136dc2f 100644
>> --- a/builtin/update-ref.c
>> +++ b/builtin/update-ref.c
>> @@ -98,6 +98,41 @@ static char *parse_next_refname(const char **next)
>>  	return parse_refname(next);
>>  }
>>
>> +/*
>> + * Wrapper around parse_arg which skips the next delimiter.
>> + */
>> +static char *parse_next_arg(const char **next)
>> +{
>> +	struct strbuf arg = STRBUF_INIT;
>> +
>> +	if (line_termination) {
>> +		/* Without -z, consume SP and use next argument */
>> +		if (!**next || **next == line_termination)
>> +			return NULL;
>> +		if (**next != ' ')
>> +			die("expected SP but got: %s", *next);
>> +	} else {
>> +		/* With -z, read the next NUL-terminated line */
>> +		if (**next)
>> +			return NULL;
>> +	}
>> +	/* Skip the delimiter */
>> +	(*next)++;
>> +
>> +	if (line_termination) {
>> +		/* Without -z, use the next argument */
>> +		*next = parse_arg(*next, &arg);
>> +	} else {
>> +		/* With -z, use everything up to the next NUL */
>> +		strbuf_addstr(&arg, *next);
>> +		*next += arg.len;
>> +	}
>> +
>> +	if (arg.len)
>> +		return strbuf_detach(&arg, NULL);
>> +	return NULL;
>> +}
>> +
>>
>
> There's an extra newline here.
>

Will remove.

>>  /*
>>   * The value being parsed is <old-oid> (as opposed to <new-oid>; the
>> @@ -237,6 +272,55 @@ static void parse_cmd_update(struct ref_transaction *transaction,
>>  	strbuf_release(&err);
>>  }
>>
>> +static void parse_cmd_symref_update(struct ref_transaction *transaction,
>> +				    const char *next, const char *end)
>> +{
>> +	char *refname, *new_target, *old_arg;
>> +	char *old_target = NULL;
>> +	struct strbuf err = STRBUF_INIT;
>> +	struct object_id old_oid;
>> +	int have_old = 0;
>> +
>> +	refname = parse_refname(&next);
>> +	if (!refname)
>> +		die("symref-update: missing <ref>");
>> +
>> +	new_target = parse_next_refname(&next);
>> +	if (!new_target)
>> +		die("symref-update %s: missing <new-target>", refname);
>> +
>> +	old_arg = parse_next_arg(&next);
>> +	if (old_arg) {
>> +		old_target = parse_next_refname(&next);
>> +		if (!old_target)
>> +			die("symref-update %s: expected old value", refname);
>> +
>> +		if (!strcmp(old_arg, "oid") &&
>> +		    !repo_get_oid(the_repository, old_target, &old_oid)) {
>> +			old_target = NULL;
>> +			have_old = 1;
>
> This one feels weird to me. Shouldn't we return an error in case we are
> unable to parse the old OID?
>

Yup, that was missed, will add a check. I also realized that at the top
we do `old_target = parse_next_refname()`, while it makes more sense to
do `old_target = parse_next_arg()`.

>> +		} else if (strcmp(old_arg, "ref"))
>> +			die("symref-update %s: invalid arg '%s' for old value", refname, old_arg);
>
> When one of the branches has curly braces, then all branches should.
>

Will change.

>> +	}
>> +
>> +	if (*next != line_termination)
>> +		die("symref-update %s: extra input: %s", refname, next);
>> +
>> +	if (ref_transaction_update(transaction, refname, NULL,
>> +				   have_old ? &old_oid : NULL,
>> +				   new_target, old_target,
>> +				   update_flags |= create_reflog_flag,
>
> This should be `update_flags | create_reflog_flag`, shouldn't it?
>

Definitely.

> Patrick

Thanks for the review.

[1]: https://lore.kernel.org/git/20240426204145.GC13703@coredump.intra.peff.net/

--00000000000024091b0618f3bd43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bf8f15588aba736a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aTWJqa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzM1Qy85SFZ1b2I5YjIrdVlaMlRCb3RmczNWaldqbAp4Q0lKUjVOSHB2
ZHVJM1BjV2s1WFhaMFhLdEdXVDIzSThvWisyOEQ1VjVYRFhqZXczaEU2ZS9NbXNXWUVYcDFJCm42
RmIvWXFJSElCNG4vbm9ZMGRCakpCUVlsbjE2UUN5aWpLWDk5Wk5hWStpUzBKc2xOalNZNlgzaHcw
SGtONWkKOTFjcTNPbWFNbmgwWFd2Y04rMEZwb3FiaEJaTEpXV1dqNXc2eE5vSEE3WHpYNC9QNXpF
L3YwSXZoaytHT0ltVQo4NEVOMTVHaENXOGQxbDJyS0xEMUxDNW1KMktqQWtkNzJDZjF6ZmkvS0xT
cnlud2JwejlpMHZxSVl2ZDQzTktjCjNrZGxlT3VjRFViZUdqeXZtVmQ2QkZwd2xqbDQ2KzN2R0JP
TWJpQk9HZm1YbFhJNHVkNzczY25LVE9VZWVzSWMKMjBvMXdnOHhObGhCVFlQbmppYkkyN1pLSyt1
Wjc1UXBMRU5RaFUrUGVPZ0xEWTVFaWR3SmVhZGRwV1lGc1p1LwpJTUNZZFhZZ3E2bmFRK0RuMWpz
WXVhNFFTeEdkYjNVWmVFOFY4QlBXd2MremhLL0U3ZlJLRWRKY243eWhTL3ZtCjNSNUdkVHRXaVJW
MHdBMVVGdEhFZGFvdGREc1RRSzRWbFZaeWVSRT0KPS9IVGkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000024091b0618f3bd43--

Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214D199FCC
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984438; cv=none; b=ioNkzRrzs7DQSnmam5tpSdT6eEqGL14QaH/siNZmukIBjuO+lc06vscDD+h+xEpBBYWjLvKt1ACWDCLUun6Sf1eIsE4bzNjjXyTs1hR7GtTUyVVIfm00bLPMCcgJk4ByZpd14sOfuBQ+OirzlYH/W9WNt9CaLgTRG3EGdd9vrjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984438; c=relaxed/simple;
	bh=uKVOPUkTj09Hpj480amZthcsh9AHrnViNyd3AyJfn9M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syQUwyJ4JKEIrzKXhqEW2TtTVTrkPXkP9ECkEXPa9ak1GGiXL0lBlkG4kcqngOFTjzxIscplO9iWhcg0UNVBrf4HMeSq9vtJ7pVg63NIFIGyCeCRIoSSbRnq5A61GDnYswZuB6ZCIyfTAizq4s153giYbBMFqAMcuYN6T+Pb8ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddhpLV3V; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddhpLV3V"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5e1b35030aeso2790121eaf.3
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725984436; x=1726589236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ytZQZsKvYkNsUOYW2/dTiOudJI9+ZJEF9wfLLEpM7+Q=;
        b=ddhpLV3VQBdYQNdi6ghghlwA/XYDbJNHDpg5DuKMo5pBnuYuJrbRJGLrG4SfEJ6DDI
         K8ak1dxex4BEz1LaBsFCEaDRWgqMFcHtiQjR5Z/QYlzGmBcbuRSs3hTM2qjBBYMMHZ9R
         B4TZMDMfV/PlgQ5A7s0jlEkSsFVHfwVjG9uoedJZD8j8MXifZ89wib19xHgBjgKlqe2+
         F33h30TL+n2rD4RRc3FZYigukPCKYbtJtUdJd6lR8JhShs9/2DDESjPyelyzg//BEefW
         s+tt3G8Vp1oathRJv2U5yV0w3sap1dCxChFoZYG+wP/UBBjB+xfykVob7tlV3EW9icoY
         G+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984436; x=1726589236;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytZQZsKvYkNsUOYW2/dTiOudJI9+ZJEF9wfLLEpM7+Q=;
        b=d0K+yZJrFzd9Yl2JfQ87r1GicLtY6BA+yRWu6IvGN763wwHQvr19H1x0u9YlbqH7vb
         U4Dbk1ktU+Kqrl+YSo8CpgLcpTrs+kTEp5rCNywJC9dLRyucZYia+ZNZbuulSGiQnjZu
         jRWnwAlQMTXXoUEH47ncL1QrI7anMbsadom48uzisQFwpzCZk0JfWSPhh+OqjY3tRI7i
         BHxni3HeVFbabF5NrPa8dGdH5qUlipO9jl3zT6tiWOTh8Dh20Pk+IcytvSbk70urzh+0
         3jdX7NqXNyYOgy5tm5rB0APhDUj3Yc1rll9WiDuDArWhxxpIkJxwvwslK6Uy9nLkTg+m
         JWGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzLxeUWBmflL1bV7h8AbvWgpnSa8odMbXkPat+1C6RW8aM1LdEMpQNAa7maWfAS3g4O8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RhJrLVPOSbGp+tbs2GDdMBTPxm/jRpWAAxa8Wql6WXTVAI2U
	Z4VuuAvB3Wp+N9bB2EvrIQ2TKDR+68WfmKebG3GGjvkfR4e4yfUuvlmR9mhkQQng14x7yztUOqp
	vtOXZYn9ltEJr0vKiZ1AXlu2byMc=
X-Google-Smtp-Source: AGHT+IFr+wASK13AjBvljjbOKTZhQE/m3Oou9HzsNnSqmGTSfMiPr4qNgxkFoqvZvUkFUWTmw3/Y2xfWOXY9q3gUj7E=
X-Received: by 2002:a05:6820:4b0e:b0:5d5:9ffb:b9de with SMTP id
 006d021491bc7-5e1a9ce849bmr15420668eaf.4.1725984436092; Tue, 10 Sep 2024
 09:07:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Sep 2024 09:07:15 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Ztb_HqLg-WvwA2I0@ArchLinux>
References: <Ztb-mgl50cwGVO8A@ArchLinux> <Ztb_HqLg-WvwA2I0@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Sep 2024 09:07:15 -0700
Message-ID: <CAOLa=ZT8N7TRSVNhqGrjskMTTFgO16Q4VKMVM1LPHtEorkT6cg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ref: add regular ref content check for files backend
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000033aacf0621c611c6"

--00000000000033aacf0621c611c6
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> We implicitly rely on "git-fsck(1)" to check the consistency of regular
> refs. However, when parsing the regular refs for files backend by using

Nit: s/for/in the/

> "files-backend.c::parse_loose_ref_contents", we allow the ref content to
> end with no newline or to contain some garbages.

The 'no newline' reads a bit odd, perhaps, "we allow the ref's content
to end with garbage or without a newline."


> Even though we never create such loose refs ourselves, we have accepted
> such loose refs. So, it is entirely possible that some third-party tools
> may rely on such loose refs being valid. We should not report an error
> fsck message at current. But let's notice such a "curiously formatted"

s/such a/such/ since the next line uses 'refs' in plural form.

> loose refs being valid and tell the user our findings, so we can access

s/access/assess

> the possible extent of damage when we tighten the parsing rules in the
> future.
>

We could also rewrite the last sentence to make it a little more clearer
as "We should notify the users about such 'curiously formatted' loose
refs so that adequate care is taken before we decide to tighter the rules
in the future."

> And it's not suitable to either report a warn fsck message to the user.
> This is because if the caller set the "strict" field in "fsck_options",
> fsck warns will be automatically upgraded to errors. We should not allow
> user to specify the "--strict" flag to upgrade the fsck warnings to
> errors at current. It might cause compatibility issue which may break
> the legacy repository. So we add the following two fsck infos to

I think Patrick touched base here and I agree with his comments.

> represent the situation where the ref content ends without newline or has
> garbages:
>
> 1. "refMissingNewline(INFO)": A ref does not end with newline. This kind
>    of ref may be considered ERROR in the future.
> 2. "trailingRefContent(INFO)": A ref has trailing contents. This kind of

s/contents/content

>    ref may be considered ERROR in the future.
>
> It may seem that we could not give the user any warnings by creating

s/could/would

> fsck infos. However, in "fsck.c::fsck_vreport", we will convert

I think we can also rephrase this first sentence a little better,
perhaps:

    It might appear that we can't provide the user with any warnings by
    using FSCK_INFO.

> "FSCK_INFO" to "FSCK_WARN" and we can still warn the user about these
> situations when using "git-refs verify" without introducing
> compatibility issue.

s/issue/issues

> In current "git-fsck(1)", it will report an error when the ref content
> is bad, so we should following this to report an error to the user when
> "parse_loose_ref_contents" fails. And we add a new fsck error message
> called "badRefContent(ERROR)" to represent that a ref has a bad content.

I would rephrase this a bit, as:

    The "git-fsck(1)" command reports an error when the ref content is
    invalid. Following this, add a similar check to "git refs verify". A
    a new fsck error message called "badRefContent(ERROR)" to represent
    that a ref has a invalid content.

[snip]

> +static int files_fsck_refs_content(struct ref_store *ref_store,
> +				   struct fsck_options *o,
> +				   const char *refs_check_dir,
> +				   struct dir_iterator *iter)
> +{
> +	struct strbuf ref_content = STRBUF_INIT;
> +	struct strbuf referent = STRBUF_INIT;
> +	struct strbuf refname = STRBUF_INIT;
> +	struct fsck_ref_report report = {0};
> +	const char *trailing = NULL;
> +	unsigned int type = 0;
> +	int failure_errno = 0;
> +	struct object_id oid;
> +	int ret = 0;
> +
> +	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
> +	report.path = refname.buf;
> +
> +	if (S_ISLNK(iter->st.st_mode))
> +		goto cleanup;

Since we iterate over all refs, we don't need to check the target for a
symbolic link. So we skip all symbolic links. Makes sense. Would be nice
to have a comment here.

[snip]

--00000000000033aacf0621c611c6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 69d68aab5eec6c0e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iZ2JxOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK25xQy85QUNINmVFUS9VTnZXeGZkZURsa2tLdEFYbwpSYzRFYSs0cnZa
Y09iMjV6bVJwalYraG93UTlMa3ViYmVsQ0VCeXdyYTROd0xEdENUZVA3SWdEYndIYk13YXlaCkpK
NGtPOTRXVFNTTjJSTVVpMUdsY2syYXJtaTZVNHVmUUh1bXlHNFBHVWpjeVhWUXBSdFlEZmpNNk9P
RnRlZUYKRG5uWm1HT3lTaGZrN2FoeVdoMFdpN3RzT0FVa1R1SWxkOVV5WU5vb2R6ZGl3ZGJRZGpT
VUdrQWM5T1ltZnJMOQo4YlFSYldaSlpxMGgrKytzQzBWdXIzS1lqQmZZdzhpMFlQamJFWDI3OGlz
RHVGR3A1THdOVTF4QTAwNUxuZldFCk1iSUpDSTJBQmNaZzBxZHlhN2VJM2R1RVYyOFliLzF2NHNj
Q2xCdHZoNjRCSEcrY2dNTld2VlpKWlBlM0Z4QjYKVHdrbUMrNXJwV1B6ZTFyRGt6aHdrVHVtWWVz
bE5CUDlpb1lJZTE3SGRXazd1eERuejFTNldqVnZOVnovSEZSUgpEZU9nUFVjWFdaVkw3WVdPSW9k
UVRBOFhYUDZkYWdjR291bFgvaXN3U1R3ZktpTnZSRFpWeGovR0tIa2hKMFRQCnRiczJibGJ1a1g5
Tzc0RVA4Zk1OWXVFRzdFcklGVzhRVzhlU1RaOD0KPWtTS3IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000033aacf0621c611c6--

Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71F516A369
	for <git@vger.kernel.org>; Wed, 29 May 2024 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971369; cv=none; b=O3JiGJtKjTNwJegsdVKTMaAl7Chr4Qp9bte3i1kQIfshJkQrSWGbNw+2PlxiiWRg8puy4ndfvWKMB9kShenzZPxwIwf5fnerunx5fhJgTvGehE2Rs6bHdyimCJsY5iyG10y0uOtAqJt3t/TwWEWbXtZeoPVVgLGLTvA3MaHGQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971369; c=relaxed/simple;
	bh=+52k/EZZOyZxAxbmR8QmknTexDodDlXBbVda62ujTCQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ez3aZ93YYjsLqJdmW1EdrJgAEMGelZ/Ljmz2OKVcmuFj2G90zusb12sGj+R6IFuhbiK4rTvBp+u6uU3VMFM4xrs6ZWxuxfTi2yD1sDgLDBQE78cvj4S0/EJYMCOa9d1LLFikI1w51udEaJvU5WTXq7k6EKA82E7/PMw5B7Z74fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5SJqQQX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5SJqQQX"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e96f29884dso17806741fa.0
        for <git@vger.kernel.org>; Wed, 29 May 2024 01:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716971366; x=1717576166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWFfNb+whm6QZkO+nbY8+Xj4XDOmy0ohye6CoiS6SEI=;
        b=c5SJqQQX7dLN0dPbLn6l9vTUGtEX8pPHfYOBmPHy033I0cNPisNkHx/2rsXFRpdTWw
         WJmz26g7JQcUj/RP6qDwoT+Uh3eTlWEFoaVUNcS6exXFV3eJea7ZhlrQIlGpUN6dD48k
         fZOqPQ5HnP56gWemyAi2ogbtN2+o+eTrJKkkQT4yKaKbfdsGDykMyNhpm1R8g/F1GWW6
         3OyDA9Meev44Qz0Jfvro7RGf17TvJHrKFBsfgvgO0AkUyMfV5ly3Tq+Qn6FKreKnnrLh
         Nd7ja8eJHnHEToIB7m7teNzPxhfa/0qUONwSDnjciflbOgXa9eTDH7SssV8OtX9kr+fJ
         5ZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971366; x=1717576166;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWFfNb+whm6QZkO+nbY8+Xj4XDOmy0ohye6CoiS6SEI=;
        b=TjMf2Ok8xPSUFuCtcFG75O6y3AVEIQ6DaE4YBzdIxUpXjRKqmWDB+Ygu3fqo3U+Ezh
         8Z7IKXAwS/VWrchEjKRVQT+rkGIlljTLkh4XhRSfqRiQHzk4VJcxmqoidMuWM9EpoeWQ
         Hc4m8oqeAtA5Yy0ArFmU2R3zwRSiaIzqOzM7u8NAhT15Mf7236szslLvmMQSIjXmUIrs
         tJs36kW3mzN0MgqH5LhM//6JPkCGygXzD/UnVjuWZ6CVyhCNOk19BfCe3UittdweK7kv
         V7s5Ej94OfDzDq6IVKWTcdfglaKDI04A96S34r2e30xefXppU/vXDCr33hE4gp5z14vt
         YLoA==
X-Gm-Message-State: AOJu0YySY9UQEwFHr7VbvwFZUpAi28mPFKR8g3GVCH/k/g7oQruYVYFF
	sgMLAFaKldjYkP+r9ooD2EP6NsmUvJ+wATNbQjictMLj1XXKgvnXUy55gfCpjCiD9PkMopRp9Zw
	jsvO+b5AEvlmSooOfoTHWj/HqueRI8vkzh7fN8Q==
X-Google-Smtp-Source: AGHT+IF91geVDRHnuhsaA0QCdjh7G+9Yp1UoxaQviBNCN2nl45dmFmlO2LJBPafnm0Sx0rIGaigtUEhAxqiXEE3R2ao=
X-Received: by 2002:a2e:88d0:0:b0:2e6:ccfd:fae1 with SMTP id
 38308e7fff4ca-2e95b096c66mr85782391fa.17.1716971365604; Wed, 29 May 2024
 01:29:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 May 2024 04:29:21 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqplt9h4yq.fsf@gitster.g>
References: <20240514124411.1037019-1-knayak@gitlab.com> <20240522090326.1268326-1-knayak@gitlab.com>
 <20240522090326.1268326-7-knayak@gitlab.com> <xmqqplt9h4yq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 May 2024 04:29:21 -0400
Message-ID: <CAOLa=ZSMox99eZ=QmkucN+M+SxzFkQ3ivEzOfa-SZ=kKtEtcMw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] update-ref: add support for 'symref-update' command
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000005638090619938cc5"

--0000000000005638090619938cc5
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static void parse_cmd_symref_update(struct ref_transaction *transaction,
>> +				    const char *next, const char *end)
>> +{
>> +	char *refname, *new_target, *old_arg;
>> +	char *old_target = NULL;
>> + ...
>> +	old_arg = parse_next_arg(&next);
>
>> +	if (old_arg) {
>> +		old_target = parse_next_arg(&next);
>
> Now we have an allocated memory we are responsible for freeing in
> old_target, obtained from parse_next_arg() ...
>
>> +		if (!old_target)
>> +			die("symref-update %s: expected old value", refname);
>
> ... and here we know it is not NULL.  We use it to grab the object
> name ...
>
>> +		if (!strcmp(old_arg, "oid")) {
>> +			if (repo_get_oid(the_repository, old_target, &old_oid))
>> +				die("symref-update %s: invalid oid: %s", refname, old_target);
>> +
>> +			old_target = NULL;
>
> ... and then we overwritten the variable, losing the last reference
> to the piece of memory without freeing.
>
> Perhaps squashing this in is sufficient to plug this leak, but there
> probably are other new leaks around this code.  I ran out of time so
> I'll let you take care of the rest ;-)
>

Yeah this indeed was missed, I think having the
`TEST_PASSES_SANITIZE_LEAK` flag set, helped catch this leak and another
around strbuf.

> Thanks.
>
>  builtin/update-ref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git c/builtin/update-ref.c w/builtin/update-ref.c
> index 76d20ca0f1..7d2a419230 100644
> --- c/builtin/update-ref.c
> +++ w/builtin/update-ref.c
> @@ -297,7 +297,7 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
>
>  		if (!strcmp(old_arg, "oid") &&
>  		    !repo_get_oid(the_repository, old_target, &old_oid)) {
> -			old_target = NULL;
> +			FREE_AND_NULL(old_target);
>  			have_old = 1;
>  		} else if (strcmp(old_arg, "ref"))
>  			die("symref-update %s: invalid arg '%s' for old value", refname, old_arg);

This definitely works, but keeping it consistent with the rest of the
code in this file, I think we can do:

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index bda37c161d..82f461d6f8 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -298,7 +300,6 @@ static void parse_cmd_symref_update(struct
ref_transaction *transaction,
 			if (repo_get_oid(the_repository, old_target, &old_oid))
 				die("symref-update %s: invalid oid: %s", refname, old_target);

-			old_target = NULL;
 			have_old_oid = 1;
 		} else if (!strcmp(old_arg, "ref")) {
 			if (check_refname_format(old_target, REFNAME_ALLOW_ONELEVEL))
@@ -313,7 +314,8 @@ static void parse_cmd_symref_update(struct
ref_transaction *transaction,

 	if (ref_transaction_update(transaction, refname, NULL,
 				   have_old_oid ? &old_oid : NULL,
-				   new_target, old_target,
+				   new_target,
+				   have_old_oid ? NULL : old_target,
 				   update_flags | create_reflog_flag,
 				   msg, &err))
 		die("%s", err.buf);

This works, since we anyways do a `free(old_target)` at the end of this
function.

--0000000000005638090619938cc5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8be300c82ad1799f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aVzUxOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1melRvQy80enJVMDRtdEtid3RFM0xzK2E0ZGFJSVFUQwpzbDdpQmM5VnJT
dDVURVFjVmpwSURTcHhYN0dkSUtIdUtlMGJPUGxmUzJWbW5xVUNBUkNVd3NSNHZtSXZQNkxOCmRX
TlN0VDVpSmpPSHZlNEF2N2R1THVLRDdzQkFMbGcyaU1pZ2pvSld3TFpwSFVLMjc4WDBibVZBa0N4
RmQ4cjAKWXNYcGY2c093djV3d3JUajdyejRwYzVHaVh3aTcwa0w5UWVZNlZ1ck5aMmtPNW5pei8w
dS9KbVNuMjFucERpTAp5eU50ZWxzSEtNSVQxS2paaUxFUEVob0w5eStkVmhldkt6QjhsMk9vMjh0
OVZQLzZSSHovQUJ6QWxLYVBpeG1iCnZtZjhBR2lxMkJyM3BvbVB5dWQzTnBvVnA2NW5YM2t6NWlE
RGEva3I2dVNxY2wwNXpERXFaRTN6VkcxMFRoZncKdnBxTFNWc0tOc1RjNWlLV0lKUFJEaTVWeDly
ZHppQW00WWYrV0NNM053ZytPeUxqcGVIUmF3S09BMVcxMDlDYQorbklwclFDVkJuMW9uSnpvbVlP
VEhUWDBvaFFmaUdickR5UXdZeW9qaGNjNTlRZkVyMXZCcWtNb1hHZFg3em9DCkpLa0xXUnZKUGxR
YUpoUlFmd3N0azZaN3NUWnIwWU5wdFRRcXU2Zz0KPXJ4Rm0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005638090619938cc5--

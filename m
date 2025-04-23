Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7475D28B50C
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428089; cv=none; b=MkjsKxAELn05rgrodnrMHXC2NIW+fVEDCn2tDRkNfYPHq/srPb7d09Ts9wJb/Lb2S7Mw3ndMSd4HUvJrWnaHWaBUTtjA9GXdRGoi5VJzlFtpP9RCa+A/22qODwUdFR8Akl81Wewl3by1BpQevNzuAZwuIveGfGyQvvXF2blWfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428089; c=relaxed/simple;
	bh=Jyx9MC//68aKlq7bbAcryETwJ9EelbmGQyfy7HUyJac=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=E6HX7zCqv8fgumu5zpnDKfuu9LpYBDTLVJrrRapK9y/AwtnbGB2MGerCLzQMnYEa0IEzK6Wac6+jochJxWbUReKlfz0mpgwlGv/8M6EwAwWs13ViRQn2Yan3qeJsxqKADc3Imh1YhXf7UNUtVKaYcXi2LeDfgkSGJgXByN98Qnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DK42IElQ; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK42IElQ"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5259327a937so48177e0c.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745428086; x=1746032886; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2Gsny1PWlJkf3q1Hwv2NnfCYhEQ/eGbSylHCMyzkks=;
        b=DK42IElQHJNn959UwDxTISLz8EzmloAEk1SDDYChKtI4RMHcCqQOPWNthe3yDN/NQw
         DbOxpgTmqVLkhl3qlnMbxpCN/Fu6QzWkd6jrWL/tswrcPKvkcXnDGYLnZuvu9GdHU5Nc
         DQYsA/Tmk+7Q5s424PlPzo9n/HD/GfATkubM0MvXZeTvk0WwslKUK3kd0GK3r4elJWCY
         RTWrBb+mnqAYqgUDR9wmoscV3henQ8RFSdEoEsapDf+FAJEb614DZbvFX9EvA/dCEh9k
         18v7cwLAMBdM7Z2MwQUXfyy3eVv6LOvsa8zXU86vm/YJYjG1FttwynwttN50fqAu+exP
         3M7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428086; x=1746032886;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2Gsny1PWlJkf3q1Hwv2NnfCYhEQ/eGbSylHCMyzkks=;
        b=UDGHyCNHWv3Bdn7BE4l640yJrqjyTlUyC/Uod8MFlYEtNLSO7P/LHAvucG7ibmTWKW
         V8uMItjXGI8Bit1mpHU532JTLiezPEJL0Uyx1MrukFteuv3WzwJGiEZnVgWIOICi00W3
         AuL+eNF8fer+EgAnosJsmiI4fPVw5n/SV/VV8BgIKbVmd2dce1qnkvKHnZLFknl+j0mU
         sjMEtAAkpaNAzvR7tM+G8yU7p9jxDUUpbbrVHaFyYyeqTtRM71cnzGmJ4KqyimasJIDB
         ipQihfPIJSOLcPWeVXNnHvaz1AkvmFZuxWQmKI6nSadzheNWZh5tIRKk2KeJY5ANl1j+
         RUEw==
X-Forwarded-Encrypted: i=1; AJvYcCUv+tgr0Ip7qzxSLObS+eLVMgXjJQZXfQJSHLeZN5JFQpMU4w2bCjkYpNTU3L3HQ8L85Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFkzEU2Vr7wrCrzmS6yyrzMnF7H00nOMJVowJNSbyOOyg0o0w
	OqPnTNnUW/VxbauA3sSL9YYANwUoK/lF+kdzkxy3A2XXDBOH6ghZwy6To+jVDUavXFexgWQdtky
	7K/zGxu4cSbF4fulf50lAujqW0g6HP/3b
X-Gm-Gg: ASbGncujGjX7Un+oVN7K9c9Ymrhnkdp9mWBdMi+p57M7YvY70qvOKYSX60OyMod4ZjN
	WWMi8kV3sxniGbx7vJxgffTr7v1rMBSsh29GTJZFCBiGliT3fuZ3zv6GyPjRy/mDWFcLwgyEGoR
	bYV91HNdG8uLn1xC62WHg4AYknyu7k9PQynLtvEu6auMSYICCg06PX6dUo
X-Google-Smtp-Source: AGHT+IHA3JwW7cTsR1LkiOlEeNFxiBUuXta0QQaRwVVtFg61m+SvDyhCBiw5JTaB1fPqTwFs+omkK1INg3rkewxGJjM=
X-Received: by 2002:a05:6122:d04:b0:51f:fc9d:875d with SMTP id
 71dfb90a1353d-52a76b4e6b5mr71430e0c.8.1745428086113; Wed, 23 Apr 2025
 10:08:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 10:08:05 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 10:08:05 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-7-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im> <20250423-pks-object-store-cleanups-v1-7-81f8411a5d08@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 10:08:05 -0700
X-Gm-Features: ATxdqUHpjZL8tOLYH6m9MchgkvRm397deKTy0eD3iPgl9vxcWhj85I0gUyeyGr0
Message-ID: <CAOLa=ZQh+agLJYEGWU2O2=iRnJy94y9Cud3XRVaGVHC4YdbBZw@mail.gmail.com>
Subject: Re: [PATCH 07/13] builtin/index-pack: don't fetch promised objects
 for collision check
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000de9d50633752543"

--0000000000000de9d50633752543
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Any packed objects indexed via git-index-pack(1) are subject to a
> collision check. This collision check has the intent to determine
> whether we already have an object with the same object ID, but different
> contents in the repository.
>
> The check whether the collision check is really needed is performed via
> `repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK)`. \
>

Nit: this was a little confusing at first, until I saw the code. So what
this means is that the collision check is only performed, iff
`repo_has_object_file_with_flags(...)` returns true.

I think the confusing part was 'is performed via', perhaps:

  The collision check is only performed, if
  repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK) returns a
  truthy value.

But it is okay as is too!

> But unless
> explicitly told otherwise via `OBJECT_INFO_SKIP_FETCH_OBJECT`, this
> function will also cause us to fetch the object ID in case it is part of
> a promisor pack. As such, we may end up fetching the object only to
> check whether the fetched object and the object that we're indexing have
> the same content.
>

So us fetching the object is pointless, since we only care about the
'does it exist' part and not really what it contains. In that case,
shouldn't this be s/same content/same oid/?

> This behaviour is highly dubious and more likely than not unintended.
> Fix it by converting to `has_object()`, which knows to neither reload
> packfiles nor to fetch promisor objects by default.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/index-pack.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index f49431d626b..805b7aa1e28 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -892,9 +892,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>
>  	if (startup_info->have_repository) {
>  		read_lock();
> -		collision_test_needed =
> -			repo_has_object_file_with_flags(the_repository, oid,
> -							OBJECT_INFO_QUICK);
> +		collision_test_needed = has_object(the_repository, oid, 0);
>  		read_unlock();
>  	}
>
>
> --
> 2.49.0.901.g37484f566f.dirty

--0000000000000de9d50633752543
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b04ce79df25d16ae_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nSkhuTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlI5REFDWGRwL093dUg5c0V4cDZYeE54dW9xa3RhaQptWk9FR2VjNXZZ
TU1PUklweFZNeXJBV3UwSlBvR2doNGJIdXVuNDlyNDg2Q2s1MFdBdktkaXVuT3NXcXRyc3BsCjEw
OVgwUGMwSG5tMmhsRWEwcVdnTFpDc2FmM243WDNDNzc5N25TM2dPTkZuTEhFakN0bUtkZlJveEZR
NXZoU1cKM2Y5UE1PbW1zcmF0eEhHWHlORU85Z2dJZVd5cXA1R3JFekNhNEFkcnpRZEptazVLZ2kx
WWQ5OWV5aFJTeHJ4eApqTHNXZTBrc2pzaW9WeTZ4YWs1bVc3NUVzdnp6NnBJK1RxeGVPMmJFYzZ0
K25sS0hiSGtqK24rRzFwZjYwdVdlCkpWdjBrc1JqQk4yTzR2NzdVWjZOci94VGl6RG5Bd0hXMEdx
YWM2Z3BjM0RScVR0clZaVm9KMzMyOEYwNkxPUTUKTW5obzEwY0VMM2lLOXNjaUU2V2QrVXFWeXNF
Q0RCL1hOOWdORGZnbXlBNTV5SzlhOGZiWkN5SGM0ckQ3c2F1ZgpOSGJTMTN3Wi9DeE15d0pPUEd2
Q0JPV0pYQk1nKzFHdG9JeSsrcnJJbzBvbEhHSkplVEk0U2hJZjltenBOM2dXCnA0QzVWWEQ3aXpz
WGNoODR1czZ2SXorWXdnQlp6YWE4dHlTQVdRND0KPXoxOHoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000de9d50633752543--

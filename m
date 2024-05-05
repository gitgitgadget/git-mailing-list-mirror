Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131DF1CD38
	for <git@vger.kernel.org>; Sun,  5 May 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714921843; cv=none; b=sCS5UgQx8pdYgc0xxD3u/K8V4NpdtvyNiC3XoC24hj+Zs63vDunmTXypwrnOTSwmqk8pnZf2abuaPp5qnIj6xEYdVVZIuodOZgvowxslqrbKYAj04yft4Eqse+RHrs+W6BhxEWri1AVFQ42aoVUhyg3nbBqxxA/G22yGwprl36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714921843; c=relaxed/simple;
	bh=Tf0kThXcCzlRFQjfHgeTtM8lI3UUHWzDKwLG2YM6w9k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H88EGG2DWzmRZ02T3LjGlvuk6+8KG7l3DUccCCjOgkBSGmfPA82PuG+HRy3u/fLzF9WHmKNi8w2plyUpaTDm/8gVhVJPjXFMuheicqz+cgYQnsCEP1tFf7Pjg6CTqnCgdE2R7QTfBWA2coiNuO+35nhMi4ib0Klk+fF3uVZ4UDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTs6Nzo8; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTs6Nzo8"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23d621abfb7so529693fac.1
        for <git@vger.kernel.org>; Sun, 05 May 2024 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714921841; x=1715526641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mw8jPfddufVKIzGHd8rkx9Of6kAKmQZyRa1N1mZq0/g=;
        b=jTs6Nzo8/JWSbiUxvSnWZbBUXFDM5YnYsxr72T3d0zPY34/++HBqsW2MSDexsV30ZY
         wy0LW7yDlRG3sZ+oMn0uR9b6WHa/8pgFrN4e/AjFrRKThut/LG4sCxS1ZHpTgOVf3FPj
         Emna/JUzN1gaMDYGkC+cB8Jf4JtkIWXMIJP1Q1Az+88Yeg27oVRPI4kNpuv5u6O1vYqz
         uFCXb5qVS2Sjt+TDTlWTfPmyNdyZcyGoPmtjPjRg5V23hq6yVRLw/RYSw0/KvfDlx4Wd
         UJlmE6xRDA13ZjK+92xir/twXekzEcPpF6Ode5APze7iyR8NJTPPFTUfNVezpC6LxL3T
         15Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714921841; x=1715526641;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mw8jPfddufVKIzGHd8rkx9Of6kAKmQZyRa1N1mZq0/g=;
        b=HzfS/PeIVviR8DbxL2j68Bb5fq/plWMSvwsHzqV4rXA6N6DFQs37he40RvxRxIqG0K
         /MMjWGtcXBO91YF5trSwMLYcQ+jdvTPwN++D74TvdAFiZP3aZAOipLDRz86XWqm6Ak7d
         NSxXVFRlhnPlBONiCpaJmR3O9i9fkReQs4NdyH2waskv1uRGGfWlQf7K3D2cwPTK4Qoo
         gxHDKkXcimb3TSnjtv9uaipW+epNGmQIuX0+CucqXlXyzgeeqqnrrsyGbadeMMVTtj9G
         Kaldz8GePkvU0DnV0aYhYtPN0AW103jUdnlpCFQdICFmOlX4ttwVZDQbH09Usu0g/DjA
         TrBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9AAC1oULEfioKk1mHZwRPXxeS0aTK8KGqRI7ORrSTI8oecGMX3sLYViEUZvr2km7rTlU5bjWrkQ4dOizzu3YJSk0Z
X-Gm-Message-State: AOJu0YxL0HGzQ/lzwt5giPMBDqfSTtflb+YtNn5aWLEITBSN1pBB0JIj
	wdAUp0AARdk49VvGivDjQ4l4ZzQDVc64rJ1vZHdHM9cfpT0vduvgSkyeLqCgAIO4VkCyRIpK1gA
	aXAmcCCkLfDi9HEkgUrFgfL/5VcY=
X-Google-Smtp-Source: AGHT+IGRRm+L5tz9hQk9J4NvAbT/PqSp/FJI3qQaIvBCGBVLqALklK5EEfpYbVJxxaXKfvLE3i+miAInK6wPcFq1OXQ=
X-Received: by 2002:a05:6870:911e:b0:23c:516a:833c with SMTP id
 o30-20020a056870911e00b0023c516a833cmr4736574oae.13.1714921840912; Sun, 05
 May 2024 08:10:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 5 May 2024 08:10:39 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <37875fc1-19d5-40bf-9d92-bf6356e2049d@gmail.com>
References: <20240501202229.2695774-1-knayak@gitlab.com> <20240503124115.252413-1-knayak@gitlab.com>
 <20240503124115.252413-2-knayak@gitlab.com> <37875fc1-19d5-40bf-9d92-bf6356e2049d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 5 May 2024 08:10:39 -0700
Message-ID: <CAOLa=ZTRg+eg+ExWYvcxkHEiX=W7BJ-tW8Ssq+ViHaUh7P8CKQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] refs: accept symref values in `ref_transaction_update()`
To: phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com, 
	ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000254ddd0617b65bc7"

--000000000000254ddd0617b65bc7
Content-Type: text/plain; charset="UTF-8"

Hey Phillip,

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 03/05/2024 13:41, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The function `ref_transaction_update()` obtains ref information and
>> flags to create a `ref_update` and add them to the transaction at hand.
>>
>> To extend symref support in transactions, we need to also accept the
>> old and new ref targets and process it. This commit adds the required
>> parameters to the function and modifies all call sites.
>>
>> The two parameters added are `new_target` and `old_target`. The
>> `new_target` is used to denote what the reference should point to when
>> the transaction is applied. Some functions allow this parameter to be
>> NULL, meaning that the reference is not changed.
>>
>> The `old_target` denotes the value the reference must have before the
>> update. Some functions allow this parameter to be NULL, meaning that the
>> old value of the reference is not checked.
>>
>> We also update the internal function `ref_transaction_add_update()`
>> similarly to take the two new parameters.
>
> The documentation for the new parameters looks good to me now - thanks
> for updating it. I'm confused about the assertions though as I mentioned
> in my other message [1].
>
> Best Wishes
>
> Phillip
>
> [1]
> https://www.lore.kernel.org/git/7ca8c2c4-a9cc-4bec-b13c-95d7854b664b@gmail.com
>

Responding here since this is a newer thread.

This is done because in files-backend we split symref updates (see
`split_symref_update`) and add a new one for the target reference. Here
we pass along the update struct. This update struct is memset to 0 and
this is after the checks we do. So the 'new_oid' here would be set to 0
(null oid) even if the 'new_target' value is set. This made more sense
in the earlier set of patches, but probably a diff like this should work
for this series and can be amended later as needed (in the series which
adds the symref-* commands).

diff --git a/refs.c b/refs.c
index 3645b805c1..20d26da372 100644
--- a/refs.c
+++ b/refs.c
@@ -1238,9 +1238,9 @@ struct ref_update *ref_transaction_add_update(
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		BUG("update called for transaction that is not open");

-	if (old_oid && !is_null_oid(old_oid) && old_target)
+	if (old_oid && old_target)
 		BUG("only one of old_oid and old_target should be non NULL");
-	if (new_oid && !is_null_oid(new_oid) && new_target)
+	if (new_oid && new_target)
 		BUG("only one of new_oid and new_target should be non NULL");

 	FLEX_ALLOC_STR(update, refname, refname);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3ce260d07d..a718164798 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2328,8 +2328,9 @@ static int split_symref_update(struct ref_update *update,

 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
-			&update->new_oid, &update->old_oid,
-			NULL, NULL, update->msg);
+			update->new_target ? NULL : &update->new_oid,
+			update->old_target ? NULL : &update->old_oid,
+			update->new_target, update->old_target, update->msg);

 	new_update->parent_update = update;

I think it makes sense to make it fool proof and add this, I'll wait for
more reviews and re-roll in a day or so.

Thanks for following through.

[snip]

--000000000000254ddd0617b65bc7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 48e5ee32be9d4fe2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZM29Xd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0N0REFDR29zbXQwNnpnNWpBUmhEek9rQTJmRU9IVQpmN1Q1Q29tTmIw
S3VlZHV2eHZJUU53bFdFbXJEQXlOSHJTVFhWZjF3Rk9vb2llSXcydm1tUXY5L1A3VjQ0ZTlxCjVj
bUQvN2R0Wkp5N1hBWXNDNVdiWklucGFRRVNTOG9peDc2OER5Qnc0RHZGNTlINmVPQmVyUXNqTVhF
bmlrdWYKT1pkaWxNWXhzUSszM2dMT1huMjdQejQ2b29PUmEvekV4NHRkQklMcWxtOXNrUWN5cHgy
WVNyOHVVeE9IN2VYaQpnbS96WEVUcHNwUFM2Um1NOWxYb3FjMWhOOGtnWlhXTGk1ZmdRR1FuclZn
c3Voa3hVRENQSHhPY05uSGdMemI3Cmw2L2FzVUxWbm5ob3FBNGI2ZVExMy9VYTBmVFhXbXFmaFdT
bUw3K0I1ZSthamFia2pRcWxlT3BjenV6NzBydE0KSE4yenR2NjFSTTVqRjZNYzBFRUpUdkRyNDBa
TlJMMTJGNE9XVmhSdC82Z3FXbnppeHQ2N2Yzc1c2eUhTSVRwawpIeVFLN3JNVE1ScnM4Tm92blJh
ZGZmWGwwMG44K28wTUljaXBNbmFGYVkvKzhFc0pUdU9JcjJlY09WTEE2dVNECjdxUzI3UkRlcVpX
WTdzWmtkZTRxN2NlcGFoRVBlTkZlSlp6dExWMD0KPWV5bHIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000254ddd0617b65bc7--

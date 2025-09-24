Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374CA29DB6E
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739235; cv=none; b=FdVIoYtVH+phSOSdyDuK3QTDCa6MzTOKpOieryrsaGl8Fp3aMzFh9H0wQ0rjCC0ikXfuKNfedDKxh0owDjM6wadjS6x+wxAo0QqhiHdzf8XX+xI8jp8LJt1JG2+JA9IW7ZHvVe2gvCMzYh8DvXrUtVHIgChzK39/wqhKLS5f+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739235; c=relaxed/simple;
	bh=3sRDxK/1Cwfc+yx6D9LpEGZaJhZtfaE1HR4Orq8LfmY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbilYk0sII8EeVHp+BvDc3kflRnSoxtizyf8HtsleUZMeJq0DZWQaRq+I4GqLeVZjIA8ahYe+RUerPPpBvE1etsN0OmTsaFM6nIbSPKtxyl9nqs3fpCMLfcYu2BTkAEBoTjnDHKc4ER4bscokmss316bZlUS6/bJ+YSKtv8Vtm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0f9ej3F; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0f9ej3F"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-905b08b09f5so22374241.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758739233; x=1759344033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo9SZnTJyIzAia4/kBRoybnDzrZ9N4BcBGvC+neUrp0=;
        b=Y0f9ej3FMcmAUc3tGj8JyxYZQj2Evx53QetO2Zoc5MTNEfvt/xRaNR+tqIZ5vmwFO6
         n7UKWBomM9+O3E6J11vJ4vHQwuGyVsgaCuYTFY7uPtm7RnND+orBq7LSoLFHuQIeXmED
         TgeeVgoURnoyJ6SNaJp09ry6eEgOUZLJse/pxWoeaMaslnxQIP9gC2wn11xqym+BisXl
         b85ANPPTtV4tTGTnNNFJ66wKZXPV+o8a3ClUZGXtXRDPlP9obYXFXv+TOLqUbWC0njID
         bqK2kIA/YOySeuD0iit18E4eqHIlJHiF1So3lI2GfGftGsplUOE7kMxFjazyKwFRK+nF
         avJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739233; x=1759344033;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo9SZnTJyIzAia4/kBRoybnDzrZ9N4BcBGvC+neUrp0=;
        b=c8GmocE5zZ/3BlbnpOTyb/Uui281LrsPzmkN79P5GEpGzsj6YtSOH0Jz659QIamKdG
         c2t68wdT6Pt7zSggRJ0fqqztmbQX1C2e9XygIcr8JGtqRBv85j1sShF0+8E3VXC/40la
         NrhRM4qx77vZHWkBzncAmht4ZVcb6SAwOclXH31vTGzSVRqk5iBSn1PFoQMsSO50hxyO
         ZlJsiul8uNk1bBeM0WagLDVf04zbgprkDRFxQl4Cw8lPEzBrnCmJytAARjXZb5kUmwfo
         x0WSRkDsYh3SrR8M6sPxbXW5Eo5lxF4ZnJgZUHJCA0TVkbTxONZDqhrjaEOZKPQXzIuV
         YTXw==
X-Gm-Message-State: AOJu0Yw1ZuVJpo/17Ax3XiHuFlnQag2ev1IzXRJuj9jdadCLdQUQMs9n
	79v1I+bMJWoVkFUYFDgh/UFxOrCs+DurlTKTTFbu7GyzoVS9v3xrYM/dN/QtIKAaVPOG5FXZFgQ
	p9SrNfaL+HbLmdy8Sz5oBZl6ZU9LL0yU8cJor
X-Gm-Gg: ASbGncvPH6wDSaOqv52FUKW6xx6InNTJTWKiVChb63RMIncNn7CW/6w9UHVM7y4G0yv
	ndJ7QufOvnh0pE/PlscvLNFE0dR+MHPiLhUAvWAaCl0o9svt+DRNmxVLwQgts4wnu9+a/Sx+548
	t8kPxWlB1ycOSqmAm51kEke4KZFlBgh5becargvzYCe6peGznyqjVQ3IroYkTRT0BVA/DfP6yaJ
	LUT2EoKwG1/9a47KLLk7WCg5xI/RBhsOgrLvXeeAw==
X-Google-Smtp-Source: AGHT+IGdIgbfKekwY8OHYthygEwAdU21mDH/7XC5ZKRQwYOp8ulnROF4e1aRCMBmxAxsPxYSIdwg9oZwwBXxbxiRDGw=
X-Received: by 2002:a05:6102:161e:b0:4de:d08f:6727 with SMTP id
 ada2fe7eead31-5acc776fb05mr525298137.13.1758739232723; Wed, 24 Sep 2025
 11:40:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Sep 2025 11:40:31 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Sep 2025 11:40:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aNOHqEq5qxXrOCX7@pks.im>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
 <20250918-228-reftable-introduce-consistency-checks-v3-7-271af03eb34d@gmail.com>
 <aNOHqEq5qxXrOCX7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Sep 2025 11:40:31 -0700
X-Gm-Features: AS18NWBOIw-sQi_loOwz40TkNTZFerEKjbp-q-GBpoX3oEQB1weq01mctZFWa0g
Message-ID: <CAOLa=ZQ641MncC9ACm9jfjx0WtQ+nK2shtyucQOxd08LDXDzAw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] reftable: add code to facilitate consistency checks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="00000000000038322e063f90639a"

--00000000000038322e063f90639a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Sep 18, 2025 at 10:11:48AM +0200, Karthik Nayak wrote:
>> diff --git a/reftable/fsck.c b/reftable/fsck.c
>> new file mode 100644
>> index 0000000000..785e4b43e8
>> --- /dev/null
>> +++ b/reftable/fsck.c
>> @@ -0,0 +1,112 @@
>> +#include "basics.h"
>> +#include "reftable-fsck.h"
>> +#include "stack.h"
>> +
>> +static bool valid_table_name(const char *name, uint64_t *min_update_index,
>> +			     uint64_t *max_update_index)
>> +{
>> +	const char *ptr = name;
>> +	char *endptr;
>> +
>> +	/* strtoull doesn't set errno on success */
>> +	errno = 0;
>> +
>> +	*min_update_index = strtoull(ptr, &endptr, 16);
>> +	if (errno == EINVAL)
>> +		return false;
>
> strtoull may also return ERANGE. In general, shouldn't we abort whenever
> errno is non-zero here?
>

Yeah, that would be much better. will change.

>> +	ptr = endptr;
>> +
>> +	if (strncmp(ptr, "-", 1))
>> +		return false;
>
> Better:
>
>     if (*ptr != '-')
>         return false;
>

I did use that below. I think I missed changing this, will do.

>> +	ptr++;
>> +
>> +	*max_update_index = strtoull(ptr, &endptr, 16);
>> +	if (errno == EINVAL)
>> +		return false;
>> +	ptr = endptr;
>> +
>> +	if (*ptr != '-')
>> +		return false;
>> +	ptr++;
>> +
>> +	strtoul(ptr, &endptr, 16);
>> +	if (errno == EINVAL)
>> +		return false;
>> +	ptr = endptr;
>> +
>> +	if (strcmp(ptr, ".ref") && strcmp(ptr, ".log"))
>> +		return false;
>
> Yup, makes sense. We don't do so ourselves, but in theory it is possible
> for tables to have a ".log" suffix. If so, they are expected to only
> contain reflog records.
>

Yeah, I missed this in the previous iteration, but realized while
reading the spec that this could be possible.

>> +	return true;
>> +}
>> +
>> +static int stack_check_all_files_in_dir(struct reftable_stack *stack,
>> +					reftable_fsck_report_fn report_fn,
>> +					void *cb_data)
>> +{
>> +	DIR *dir = opendir(stack->reftable_dir);
>
> I think it would make sense to move this function call close to the
> conditional.
>

Fair enough, will move.

>> +	struct reftable_fsck_info info;
>> +	struct dirent *d = NULL;
>> +	uint64_t min, max;
>> +	int err = 0;
>> +
>> +	if (!dir)
>> +		return 0;
>> +
>> +	while ((d = readdir(dir))) {
>> +		if (!strcmp(d->d_name, "tables.list"))
>> +			continue;
>> +
>> +		if ((d->d_name[0] == '.' &&
>> +		     (d->d_name[1] == '\0' ||
>> +		      (d->d_name[1] == '.' && d->d_name[2] == '\0'))))
>> +			continue;
>> +
>> +		if (d->d_type == DT_REG) {
>> +			if (!valid_table_name(d->d_name, &min, &max)) {
>> +				info.error = REFTABLE_FSCK_ERROR_TABLE_NAME;
>> +				info.msg = "file with invalid table name";
>> +				info.path = d->d_name;
>> +
>> +				err |= report_fn(&info, cb_data);
>> +			}
>
> One problem with this is that this is racy with concurrent writers. We
> don't recognize the "tables.list.lock" file, and neither do we recognize
> "0x*-0x*.{ref,log}.temp.XXXXXX"-style files.
>
> Would it be a better approach be to instead go through table names as
> loaded by the stack? The reftable code already knows to prune unknown
> files anyway, so I don't think we should scan for any other files.
>

I actually had a more structured code here, where the idea was:

- For each stack
  - Run stack level checks
  - For each table in stack
    - Run table level checks
    - For each block in table
      - Run block level checks
      - For each ref / log
        - Run ref / log level checks

But we move some of my tests to be runtime checks, leaving this as the
only check remaining. We could still do the first level of what I
mentioned above. The only reason I didn't was because we wanted to check
all files in the stack dir. But I think this is much better, having
unknown files in the reftable directory doesn't affect the repository in
any way. So I would argue perhaps that we shouldn't even care about it.

>> +		} else {
>> +			info.error = REFTABLE_FSCK_ERROR_INVALID_FILE_TYPE;
>> +			info.msg = "file with unexpected type";
>> +			info.path = d->d_name;
>> +
>> +			err |= report_fn(&info, cb_data);
>> +		}
>> +	}
>> +
>> +	closedir(dir);
>> +	return err;
>> +}
>> +
>> +static int stack_checks(struct reftable_stack *stack,
>> +			reftable_fsck_report_fn report_fn,
>> +			void *cb_data)
>> +{
>> +	struct reftable_buf msg = REFTABLE_BUF_INIT;
>> +	char **names = NULL;
>
> This variable is unused.
>

Leftover code, will cleanup.

>> +	int err = 0;
>> +
>> +	if (stack == NULL)
>> +		goto out;
>
> Why should someone ever pass a `NULL` stack?
>

This should be safe to remove.

>> +	err |= stack_check_all_files_in_dir(stack, report_fn, cb_data);
>> +
>> +out:
>> +	free_names(names);
>> +	reftable_buf_release(&msg);
>> +	return err;
>> +}
>> +
>> +int reftable_fsck_check(struct reftable_stack *stack,
>> +			reftable_fsck_report_fn report_fn,
>> +			reftable_fsck_verbose_fn verbose_fn,
>> +			void *cb_data)
>> +{
>> +	verbose_fn("Checking reftable: stack checks", cb_data);
>> +	return stack_checks(stack, report_fn, cb_data);
>
> Nit: having this extra function call to `stack_checks()` feels a bit
> weird as it could just as well be inlined. Is this preparing for a
> future change?

Yeah, mostly the idea was to break things up into layers as I mentioned
above. Let's make it simpler for now and we can make it nicer when we
get around adding more checks.

>
>> +}
>> diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
>> new file mode 100644
>> index 0000000000..5e13ac9f02
>> --- /dev/null
>> +++ b/reftable/reftable-fsck.h
>> @@ -0,0 +1,42 @@
>> +#ifndef REFTABLE_FSCK_H
>> +#define REFTABLE_FSCK_H
>> +
>> +#include "reftable-stack.h"
>> +
>> +enum reftable_fsck_error {
>> +	/* Non regular file in the reftable directory */
>> +	REFTABLE_FSCK_ERROR_INVALID_FILE_TYPE = 0,
>> +	/* Invalid table name */
>> +	REFTABLE_FSCK_ERROR_TABLE_NAME,
>> +	/* Used for bounds checking, must be last */
>> +	REFTABLE_FSCK_MAX_VALUE
>
> Let's add a trailing comma here.
>
> Patrick

Will do.

--00000000000038322e063f90639a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fcf1a3b2ca3197f2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qVU94MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMmU1Qy85M2FGNnkxTEtaTXVFYitvMGNNempRZ0c2Ngp6ZE94UWZJd1ly
VXMzN3RWQnB3d2VkN2JLLzdGdEF1b091MSthOVp3aGkxSlRrVnZydHlwNTJhdTFnZWl4K0tBClhE
bzltSFVscWxEQjF5djRZVGZXMDdhLzRxSm5EVlM2MWVYbzJreFdvL0MxREJJYXJaY0l5cjNqL1Ax
dDUyQjQKeTE1L3d3S0pOWEY4RzNncDRQelk1b2VLRjc1aThWSlIrQ05acDZ6SStsRWlMSVd4NS82
RDZJRThjcWI1a3FaTQpXTlkvYTFOM3B1Um16TEp3bzIzVTQvbmxDb1BSdFJQTGRKaHRTWXRNQXUv
d1cwWXNUUEJHODJzVjh2RVNZOGRKClJDMUdmWEh4Y2xGeXFsVEdBTkhhbFdJUnJ0bXlaZUNzTTB0
S3NVQlRJQ3VzYnB0cUdpQXE5bUNzcmVhUXJpYVkKVmxWWjZKRG1VMGwyUENhaUthWmFpdlh5R2RD
MW5XZ3QyZzFQL0x1U0pyekk4WTFVMmtyblRFRHpkTC8yU3I3UApEeFVkWTRERTlETHpTWHIzZnMw
UHNHMzdOQ2ZDVWlIL2VzRm5TcjdCck1hRzZXVUZOajc2dVdHaXU4aTdIRWEvCnMyZWg1Z0V5N2Yx
UW5NZWErcE9QQnhBeFRXeWVCaUNDaWJvZWVvVT0KPTBLRVcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000038322e063f90639a--

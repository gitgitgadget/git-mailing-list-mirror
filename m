Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF0621FF24
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425763; cv=none; b=DckJHoKV34xDXpauOPt1eDxjalOWQDwhyE13pZKvUZUlKhaFVQmm6XyvgNO7O7/oTRotWwKKrvX8cY+6+ttzpzQws8hUwepcUwaLfV3fjQAuYjaHWw0d7JBQzrAwtVDhCS4R9Pu7Azbj05x1YgfqZFuFgwG91OtryzBM16zqnjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425763; c=relaxed/simple;
	bh=0nItfDm4xY6b2EJXoan/LiBkpfo7BbwuVEHcXMO3ZuA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4ZH0wUy+L0TjEd/s9ewhHzfz5tMClfFj52yml54siVYpmSecOC9zQvAeaBfZvh8j/teQ7yxs9TUfFA9QTA4JCXH/jLEsu8sR92Fbx59u/wOcFfkJJPpOFJLcE14wkgly8qYBGLk+KayukdTAw8V+4nL0j4AAa/fTCY1CNCVURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWi4J70W; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWi4J70W"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-545e265e2d0so4538670e0c.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 06:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757425760; x=1758030560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EEVTCYvBqwy8xA/05HbSAT9mg6PxFmxCmCozud7mSUk=;
        b=CWi4J70WMms3e0wcZ8JYFzEOPUpoRyOpDI+0x7Mmf/gm6KJ0ETD/sQW4lu1O70WuMP
         cdr3/hiN0i2Q9x5nplFGgWuJEJ+5OOwiZPOOlRH4oS9oJ7GdjOcGwDBvoE2+SqIqxINX
         IPPULarJ5VcZ/qFYoz1LVIOJSZh9YaqdBBuHvIUUU620QxVtMDSlLQlttGOoKXKM8tHf
         DO/yqcBr5YcCzeBOAwftRePx6tGzBJKVUQ4KxxckGC8yxcd5LY+YgA84wL0HcqWor3Oq
         QdjfP5p1kQ60NCsE1CkqzYN+JsDBqv4DVJwRido60oz2x8cPcFTt/h/9bc3yYbuN5gaz
         v9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425760; x=1758030560;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEVTCYvBqwy8xA/05HbSAT9mg6PxFmxCmCozud7mSUk=;
        b=hO4EZTxdWn47d7YBfTcCaa+EB3cDoUnvNPdbVBMzHHU2K9LMkJ+mCQta3NY5Kso7ZA
         rQm0Z9iE0jHc8M6q/Hw4Tu95IxQGcmDbEEw9vzU/0kPKr/YiVrIlN3CmIKemN7jdX1DA
         BVVS/KNi7lFMxXrJ8VGTCGSb73rCaGxu1r54Csod+S5nzoWhgqR+clBzqCATotv3wf8U
         TsFA43AnRPgONjVU5CdUHvOwBxatbEqhk0vwkqGTDIfzJaYApG4GBtYwJOlf2v8RiIwI
         mRwmgxqKed8pOTCqXKXsvCpPQsdAvOWS3q4kfXdX+6N0DUMVqCtFeDJixlkbMCu4Vgf5
         8lwQ==
X-Gm-Message-State: AOJu0YxUEe4ejK40p7O/cGYHotb8DI3tbqOGqH38prRUKuPl14l9uQc7
	14P5XWNK4d+Pu3+UoUrCGzlMwfY/RQVcTN6vTX4yx+u/gsS4CFFv+mlPx04SqNxjFOreFsIZTos
	2ben/3sCsb/EPpaZI1rnCpSstEM1C7gc=
X-Gm-Gg: ASbGncv6qbydHHwGEa3my/3n2fO6yaU2JWf6CAptLRz9IqCjcTwrQ0wSxF307wN2tfm
	js4AtvL0T0cbNeZydsLihiShOsPdabxMxz/s1/zvyML2H3bb53XbXA78mh4WGX0Z4hKlEYoGTM6
	JQuVi8yvMMhG8NxG00avqwR06i8LgWGqN6RCcFEAdW58SJe6PaNZLr6G1pP/vNEIGFsHzt7Wk5N
	lTeTUbzlsGt27au
X-Google-Smtp-Source: AGHT+IFz2fda0hE3rNtPihQVAef8VrJnkmZWp8Uiucfxww6s10n8+N/n556oawzDUhOJTnXZRSI/UNTN4P1je4PfedQ=
X-Received: by 2002:a05:6102:5f04:b0:524:4800:77a8 with SMTP id
 ada2fe7eead31-53d1aeacabbmr3401135137.5.1757425760278; Tue, 09 Sep 2025
 06:49:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Sep 2025 08:49:18 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Sep 2025 08:49:18 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aLhx-HdIMCB3c2WK@ArchLinux>
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
 <20250902-228-reftable-introduce-consistency-checks-v2-2-4f96b3834779@gmail.com>
 <aLf3MaKHZSQfnBlT@pks.im> <aLhx-HdIMCB3c2WK@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 9 Sep 2025 08:49:18 -0500
X-Gm-Features: AS18NWCqmPEDSsFM0RI-P0_9Bc0A5dx9jC9TBMGFmf46bJCSGRHbfxHdcjVoQNw
Message-ID: <CAOLa=ZRzEY7VTcRTLz1u6=A5Mz0XFOhqNWK4s_wr1WOP==B1rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] refs/reftable: add fsck check for checking the
 table name
To: shejialuo <shejialuo@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="0000000000002947df063e5e9294"

--0000000000002947df063e5e9294
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> On Wed, Sep 03, 2025 at 10:07:13AM +0200, Patrick Steinhardt wrote:
>
> [snip]
>
>> > +static int reftable_be_fsck(struct ref_store *ref_store, struct fsck_options *o,
>> >  			    struct worktree *wt UNUSED)
>> >  {
>> > -	return 0;
>> > +	struct reftable_ref_store *refs;
>> > +	struct strmap_entry *entry;
>> > +	struct hashmap_iter iter;
>> > +	int ret = 0;
>> > +
>> > +	refs = reftable_be_downcast(ref_store, REF_STORE_READ, "fsck");
>> > +
>> > +	if (o->verbose)
>> > +		fprintf_ln(stderr, _("Checking references consistency"));
>>
>> This line is duplicate across both backends, right? Maybe it's something
>> that we can do in the generic logic?
>>
>
> That's right, it is duplicate. If we want to remove this, we need to do
> this in the "builtin/refs.c". But I wonder whether we should do this in
> the first place. Should we rather add more detailed information just
> like the following code for packed backend?
>
>     if (o->verbose)
>         fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
>
> Instead of just using
>
>     Checking references consistency
>
> Could we use
>
>     Checking reftable references consistency
>
> However, I also feel strange about above, :)
>
> [snip]
>
>> > +/* Represents an individual error encountered during the FSCK checks. */
>> > +struct reftable_fsck_info {
>> > +	enum reftable_fsck_error error;
>> > +	const char *msg;
>> > +	const char *path;
>> > +};
>>
>> I wonder whether it should be the reftable library that decides on the
>> severity of each generated finding.
>>
>


I think I did rush while agreeing to do this change and didn't realize
the complexity of it.

> That's an interesting question. Let's inspect how Git handles the
> severity. When defining the fsck message id, we need to specify its
> severity like the following shows, this happens at compile time:
>
>     FUNC(BAD_REFERENT_NAME, ERROR)
>

This is used to create the enum of all values, but there is a
complimentary structure `msg_id_info` which holds the mapping for each
message id to its error category.

Both of these could be extended at compile time by including the errors
from the reftable header. But to do this in a backend agnostic way, we'd
have to receive and re-expose it via `refs.h`.

> And we could set the configuration "fsck.[message id]=" to change the
> fsck message severity.
>
> Then let's think if reftable library decides the severity. It means that
> we need to use the API from reftable library to update
> "fsck_option->msg_type" at the runtime. And it is bad because the fsck
> infrastructure would be highly coupled with the reftable library.
>
> So, I don't think it's a good idea for reftable library to choose the
> severity. Instead, reftable library should just provide users with error
> types and let the users decide the severity.
>

So while there are ways to do it, it won't be simple/elegant and I'm not
sure it'd be worth it.

> Thanks,
> Jialuo

--0000000000002947df063e5e9294
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 557abc6e991ea99_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qQU1GMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mei9hREFDak40WjJSbitsOGQ4RWdpVHIzZno4OTJaeQovbXJtSkk4Tjkr
OUpXZWxVaitDRXF0RkppV0FZSEZPRlhjZU0yMFZHSWZWc042L0VRWWw0TTg4bTJrV2ttOVlUCkZZ
eTF1b1JTbXpwSnFock1DWFFRQkM5MUY4NzNoa2llZU1SN2tvaitSb2VXNEdkd2E0ZGgrUk1JZHgr
bk5pcDMKWk5vbURrSXZhcHdkR3ovVU9ac21qQXN4UkVmWVhJYlJLWTU2a3JqeGNpYmNxRmZuNkdZ
TXhIYzZwZVFZN1hrNwptUEVsQ3lrWnRpUTN5Y2NEQmRBNHJZU2F6MlluUEdLNnZqRURDNkNLcGx3
R1JUdnFaRmpZb3h0a2prTGFWeEVCCmFUZDZpUnRnQzQvbzF6V3dXWit5OUtpQjVlck1KeXYvMDNI
RDJqQ1lVN005RHhJbXludklnTWFoM05GSXJYVDAKZE5ITVpEdUZpTVZmdkFwS0tMOW1saUM4Z2FB
bkFGdkVhMm14VmQxMlBpeXNqSEpkUGFDWFZzbzZXWEF3Mk95MApEMWZ6TUNZSWxTT2pyYnYxUldZ
Q0NUY3ZCa3BONWxDK3B1TFRKdEVpUE1FSDJwRnVTeE1vdlJWdlpWRzlFa0FpCmFDd2xKUWtWVmtS
ZlJra2I1UkloNDMzc2NVQTF0akNwYkZ6NVFHST0KPTFqdzQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002947df063e5e9294--

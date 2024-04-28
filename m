Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B1773533
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714334281; cv=none; b=UkU51rmlE197F8dnm5j4tMphR5PdcGELXD4FCTZxN14thJjoZt37smlY45GteJi2B3oLOtdTgjdeFj4CK8m7DF/3pyfmR2dRB9u0ZxQm+uoOlJ2+Yvo0tUg7tXQigQCsM/C+kwYlAYEtvajdBFNtO61sOIw0ECm4jlN1o+hTfxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714334281; c=relaxed/simple;
	bh=n8J9MQgo7kRos0BA9y+UQ/rli6CQocQ8BoiEmqVwxJ0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UabjqW0tn9afZ4N97BCRyEERZHdldJPGnvj/32cxwP5sMvl5oT4n12kilSnb0nENb0QZePUiu2crQlzthBFvqotj3U6ZN4NVPGMUxcm53G/gpp5vaVSF6f3PTYcCgEBnqJUFs9uaIJcCm8Q1v4JywTU1G7mXbbg2fEhCsHqQMV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLbCzzA9; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLbCzzA9"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22f01274622so2231106fac.1
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714334279; x=1714939079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2j4izfLkAgpb02QvXknhtEgu1j7h8Jg6aocOMyh18Dc=;
        b=JLbCzzA94ZymGXKTZym6nHhhxzccuUmjAlVmvzaOuczXWgkKX4nEyoht1S0on+RhnB
         S0hJd1qgP8vioRvPIy72vFjdSuAyV6xW1xobL58+Gszm/SQ6xSFsunG8+gXkpUqwyxJe
         BhnsVwQ95mqMkYIaBJW3Bu13VMDMMyFU+YYxdEvseJx0RW7U4JeKtCJB/J796l2rlezy
         MxS68HbXQzvkihQAzEIcJV4fOV//7VG5ct0p91dW8kkAXHz4sHNtOMpXwREscHUN3b+D
         JYnsxf5S9B6jq3SxYhowMPRyFVFDtXBr9tfRSQE5FbO9+m4CXGb20rfkiQZTEuK6BBbw
         4G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714334279; x=1714939079;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2j4izfLkAgpb02QvXknhtEgu1j7h8Jg6aocOMyh18Dc=;
        b=bBbpqGd8Svp+ykkzIz824+TAcpxUN2gq45F9D5+Qfof4+PEPWueqLYCYRLffO8/KGI
         5leEGiZ74hCRNvFczIFoLI5TncRdAjU2DSYJG+nG+jYyPFphkipCZyK9/HzYP4h1iweO
         l/TYX6v0OpgOTsnMnD3Oln5zCi3ebvaE040Qz84j4tRFIwpYVSmMB28vAIHHPgRlMxk1
         EZ79bKEUvbR2UlQfGFB1cxFEwI6KT4lpR07pKybtayB7USKCqB8WveFVRbVjWDxHjzxT
         KPjFjMyemwms9zXuQHm5FCF+pnL+XKQQZFb9F1BYE+YXXWFxxjKPXWxmC289jl/anO4W
         z4uw==
X-Forwarded-Encrypted: i=1; AJvYcCWiKYQEkxllsbM7n6XoPlA8QRFkHoDms/a81BKjERkGs8jxwyZjqQADegwePkJ7GD0t0fvr0ieX2/2u0uF0iHwxOElW
X-Gm-Message-State: AOJu0YwdJ4WFGu7JtcukD8dMAv+3D9wSpdyRyWABdnLvspf7SIWJSyW/
	yl4Ve00W7mXUq7291HCJt+OzWMT4Fhdnz09MT9CVLnErYPgQCSZbzvkhsd2ON/yl79HoSjLVciF
	vQ39jviGnc2BS97Rh34N30IEhuYA=
X-Google-Smtp-Source: AGHT+IFGFkJn8GiJNw4nVtf8MWgo9BBg5c+hF6Lmq4F1Y0ajeicmPkC388KpgYxWKujNGB8iTe1QdVkeAbHY3p75JSQ=
X-Received: by 2002:a05:6870:8091:b0:22e:ce2e:4506 with SMTP id
 q17-20020a056870809100b0022ece2e4506mr6045298oab.37.1714334279113; Sun, 28
 Apr 2024 12:57:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 28 Apr 2024 12:57:58 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqmspf9537.fsf@gitster.g>
References: <20240423212818.574123-1-knayak@gitlab.com> <20240426152449.228860-1-knayak@gitlab.com>
 <20240426152449.228860-3-knayak@gitlab.com> <xmqqmspf9537.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 28 Apr 2024 12:57:58 -0700
Message-ID: <CAOLa=ZS8wZD88B2CFYUOKX3BkHAoWgA65qYJXV+83v-s=A-woQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] files-backend: extract out `create_symref_lock`
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000bbbb8806172d8d49"

--000000000000bbbb8806172d8d49
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The function `create_symref_locked` creates a symref by creating a
>> '<symref>.lock' file and then committing the symref lock, which creates
>> the final symref.
>>
>> Split this into two individual functions `create_and_commit_symref` and
>> `create_symref_locked`. This way we can create the symref lock and
>> commit it at different times. This will be used to provide symref
>> support in `git-update-ref(1)`.
>
> It is a confusing way to describe what this patch did, though.  If
> you truly splitted create_symref_locked() into two, you would have
> functions A and B, and existing callers of create_symref_locked()
> would be changed to call A() and then B().  I do not think such a
> split would make sense in this case, but the above description gives
> an impression that it was what you did.
>
> In reality, an early part of create_symref_locked() was made into a
> separate helper function that can be called from callers other than
> create_symref_locked(), and because the helper got a name too
> similar to the original, you had to rename create_symref_locked() to
> create_and_commit_symref().  The existing callers of it are not
> affected, modulo the name change.
>
> Perhaps
>
>     Split the early half of create_symref_locked() into a new helper
>     funciton create_symref_lock().  Because the name of the new
>     function is too similar to the original, rename the original to
>     create_and_commit_symref() to avoid confusion.
>
>     The new helper will be used to ...
>
> or something?
>

Thanks. I agree with what you're saying. I would also s/Split/Extract
perhaps because it drives the point better.

>> -static int create_symref_locked(struct files_ref_store *refs,
>> -				struct ref_lock *lock, const char *refname,
>> -				const char *target, const char *logmsg)
>> +static int create_symref_lock(struct files_ref_store *refs,
>> +			      struct ref_lock *lock, const char *refname,
>> +			      const char *target)
>>  {
>> +	if (!fdopen_lock_file(&lock->lk, "w"))
>> +		return error("unable to fdopen %s: %s",
>> +			     get_lock_file_path(&lock->lk), strerror(errno));
>> +
>> +	/* no error check; commit_ref will check ferror */
>> +	fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target);
>
> This was a bit puzzling (see below).
>
>> +	return 0;
>> +}
>> +
>> +static int create_and_commit_symref(struct files_ref_store *refs,
>> +				    struct ref_lock *lock, const char *refname,
>> +				    const char *target, const char *logmsg)
>> +{
>> +	int ret;
>> +
>>  	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
>>  		update_symref_reflog(refs, lock, refname, target, logmsg);
>>  		return 0;
>>  	}
>
>     Offtopic: we might want to start planning to deprecate creation
>     of "symlink refs".  Linus originally used a symlink for
>     .git/HEAD, but 9f0bb90d (core.prefersymlinkrefs: use symlinks
>     for .git/HEAD, 2006-05-02) made it default not to use of
>     symbolic links.  As long as we preserve the ability to work on a
>     repository whose HEAD still uses a symbolic link, I'd hope
>     nothing would break (#leftoverbits).
>
> Let me rearrange this hunk to show the original first:
>
>> -	if (!fdopen_lock_file(&lock->lk, "w"))
>> -		return error("unable to fdopen %s: %s",
>> -			     get_lock_file_path(&lock->lk), strerror(errno));
>> -	update_symref_reflog(refs, lock, refname, target, logmsg);
>> -	/* no error check; commit_ref will check ferror */
>> -	fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target);
>> -	if (commit_ref(lock) < 0)
>> -		return error("unable to write symref for %s: %s", refname,
>> -			     strerror(errno));
>
> The original in create_symref_locked() created a lockfile, called
> update_symref_reflog(), and called commit_ref() to commit the thing.
>
> The "no error check" comment is about detecting an error while
> writing into the lock file.  It came from 370e5ad6 (create_symref:
> use existing ref-lock code, 2015-12-29).  Because the fprintf() call
> was immediately followed by commit_ref(), and the code assumed that
> commit_ref() will check ferror(), we do not bother checking if the
> fprintf() call fails to write the contents correctly.
>
>> +	ret = create_symref_lock(refs, lock, refname, target);
>> +	if (!ret) {
>> +		update_symref_reflog(refs, lock, refname, target, logmsg);
>>
>> +		if (commit_ref(lock) < 0)
>> +			return error("unable to write symref for %s: %s", refname,
>> +				     strerror(errno));
>> +	}
>
> The new code lets create_symref_lock() to create a lockfile, and
> does the rest here.  commit_ref() does call commit_lock_file(),
> which eventually passes the control to close_tempfile() and a
> write error can be detected there.
>
> But the point of this patch is that the creation of the locked
> symref file PLUS writing its new contents (which is done by
> create_symref_lock()) can be done way ahead of the remainder that
> eventually does commit_ref().  So it smells a bit[*] dubious that we
> still leave the error from fprintf() ignored in the "early half" in
> the rearranged code.
>
> 	Side note: it is a "bit", as it is unlikely that we will do
> 	something to clear the ferror() from the (FILE *) in the
> 	meantime.
>

You're right. I would say that perhaps it is a bit more than a 'bit
dubious' since `commit_ref()` being called after, is no longer a
guarantee. I'll go ahead and add error handling here.

>> @@ -1960,7 +1973,8 @@ static int files_create_symref(struct ref_store *ref_store,
>>  		return -1;
>>  	}
>>
>> -	ret = create_symref_locked(refs, lock, refname, target, logmsg);
>> +	ret = create_and_commit_symref(refs, lock, refname, target, logmsg);
>> +
>>  	unlock_ref(lock);
>>  	return ret;
>>  }
>
> This hunk shows the "original function was renamed; there is no
> other changes visible to the caller" nature of this rearrangement.
>
> The extra blank line is probably a nice touch.

Thanks. I'm sure it's not the best idea to introduce whitespace, but this
felt more readable here.

--000000000000bbbb8806172d8d49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7c06baa3de14c33d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZdXFrUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkpuQy85ZmN1Zzc4REN0WVY1Y1lwNnh6Nmc5aTVybgp4VUZwMlpRMnZX
b1RKRjdRdjBPWXNCNEY4WmpOYm5FV0poT1ViWjRmMTlrUnBrSUppNTFTQWxvQTN1QmdQOE9DCjJr
ZlpMdUhUTnhGeWNreS9JVTBsMitJcTFkdEIvRFRoT1FuYlNBRjYzekwxRTRKT1F3QWpPdWw0blhB
L3lmaDMKcDB6MWF0Q1g4WXl1NnhJQzZIdnQ0T3N1TXFUYkV1YmlLSzEzSVdRSVV4S2hXRVFCQ1hX
S0x3QU0rRDUrWWl3QwpUUHREbE4yaEt6MVZENWtPVEp2cUNZSktKb0g0RUVlWW1jc1pWVzFZWmFZ
aW9XUnpzaWVSUkxqYkVrVHUyMWExClN4d05raEJVVlMra3NFVkVhcitCWDRNcmlRMDNIY0dILzBX
SnV4V1dFb0JDT0pIRytDRHBhaGZCbFE0Zm5HV3oKNkZRUmdBR2hBcTRBTlBJeWFGdCtqZHdlVkkr
cEF4d2JSdHpTNW9OaGFMNWdQVEwxSmtBZUxJZjRtU09EbHRiMQpBSkpKbWJPV3ovL05VQTd3ek9h
dWRHUWpWMUtJQXdVaGppS0pRSk4xVmt3UFlweUtYbXd5V1dnR2V1eUt5MzZRCjhUQnJMUDBVTXUx
UlRncjZ5R1N4b3gwblV6bENtNSt4S2VTK1d0dz0KPU9weEUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bbbb8806172d8d49--

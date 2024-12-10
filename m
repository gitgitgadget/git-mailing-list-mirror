Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA923ED4B
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851365; cv=none; b=au6h/i6qShHEIAriQowLxSY2dLNB7opIXc9aOG+kdNONx0jqsnIuoEN+um0qOS+i2lPHYvTBOepAmw5Deof6rWxUpvYAMPAKn2sZqARXLBQqSi0rPPqR7UjPFH8CNwaUqi7h4VOaU7HE/asiVUxiKoTCc5qdoWkddPptrctnju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851365; c=relaxed/simple;
	bh=8HbZobCUVI35bFMCkomsCQCO2aOAZw+SvBCIoRXxAIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6kGvYeYL1r2vVfxPGYNSyaTCPiajqDzpxdNdSrG8cEqSYxi6EtF9kN+kOwJvr3cT0I2RxNWEH0lSZVlSnrg2lmeYVBpnOYskvuUlhcH+32c7cp8lj6svNJ+e9N1ZcFX7SB1TXqoe5BS1yfnmTJ4dGs9pMVPdurBCT4Vc5agR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wmf3+r4s; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wmf3+r4s"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so8553528a12.0
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 09:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733851362; x=1734456162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9/CmsRIuVwlEwvdX4c7bOjov5IQmaoLLCEzuyF0mO8=;
        b=Wmf3+r4s47qyuXIkq7u9H1pjPCI4+FPfOpU6CSpryUhaIR+1Uw+ylXc1gmEJ9EqrET
         2Euu+sm64ovg67Dz8F8/us0x4bKo7yfUWu/Z9918vxIk6AcB/0BFjecANZjTeEepikad
         3deRPuu1kuT/scGj+3zle2m1R2+/62eUiAORI/ER5rXx9lX5/SW1suKqtBiPf9hOQpVc
         KI4K2FALD04iZaepckbHIqirtQKZvX8T3ylfGmsDDsSLS/RtOziHpshjWLyvjMXcH2Hn
         VbjPCSJQbg/+Vn4iCuoXxqBQL4Odl9JBkhPwQKcpKubOu1tyyExg7Rpf0bfg+ksNulYV
         2LZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733851362; x=1734456162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9/CmsRIuVwlEwvdX4c7bOjov5IQmaoLLCEzuyF0mO8=;
        b=CMbRDlNkUFOCPfMHwiPMhtGnDjjq1pOsPUObfXaKDonb/odsDMhtt6+dULJRmDCpPK
         HLRpVvASQWDP6zqy/KHf9ykT4DalQ4kcPf4RN4OFtnaRNC4hySYIflZnCQ8AbtB1GkCc
         +cZ/v/JocH8bnYiYa3rq9fBFtLKpunHqA+XmEnCmnESnORdAXjVTYnyjWNpmy0qYr5Uf
         g808Y9nPH7gFMXEQX/kmcWcCmszGNiGhqkpNxJ018gxKsOM2JLAepafsKJSeVUN/c7Xk
         zTqwBG73C87fv2fdeNAIR4pC2EgszmZ7hlwk6rptaRR/amGDxTMY3/xS1S5wIu0JtsXi
         knvQ==
X-Gm-Message-State: AOJu0YypXf+PeZc2CLS4KUVNW2w1TTWcnIocR9awwpqfboulDc2ao877
	r4ELQtFTU5eS7lxqiOMNFU08B6xH7pCMJcoezByQJJXr/3aBpOiQlUFb/g9Rt8dWw5gFBOi8SXI
	Vcbio251oG8FNyMrJSQOjZmDNhc4=
X-Gm-Gg: ASbGncve4D9WIjkfdc9h/qnPayxFTHYhcBcVn2+THuvpchgcP9uk8I9Ffe+doF2Veof
	de1U7x58ELq2RkHIqP9ApJg30S5MvyVFkVKh5Kg==
X-Google-Smtp-Source: AGHT+IEK2sVqZuy97P2YMqXHuK7/udJU0iwkZAEJfBFDqIYrKojDmetyrK0dKxBZrWc/M6v8wu4dfqFXxYAH5SJDGio=
X-Received: by 2002:a05:6402:2688:b0:5d2:7199:ae6 with SMTP id
 4fb4d7f45d1cf-5d41852f3dcmr6329127a12.9.1733851361869; Tue, 10 Dec 2024
 09:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-3-d4bc37ee860f@gmail.com>
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-3-d4bc37ee860f@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 10 Dec 2024 18:22:29 +0100
Message-ID: <CAP8UFD0UAWib-GceEQi+ZzbosRcvSRbq-DuMLVVr9xuf8C03ow@mail.gmail.com>
Subject: Re: [PATCH 3/7] refs/files: add count field to ref_lock
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 12:11=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> When refs are updated in the files-backend, a lock is obtained for the
> corresponding file path. This is the case even for reflogs, i.e. a lock
> is obtained on the reference path instead of the reflog path. This
> works, since generally, reflogs are updated alongside the ref.
>
> The upcoming patches will add support for reflog updates in ref
> transaction. This means, in a particular transaction we want to have ref
> updates and reflog updates. For refs, in a given transaction there can
> only be one update. But, we can theoretically have multiple reflog
> updates in a given transaction.

Nit: Giving an example might help understand where multiple reflog
updates can happen in a given transaction. Alternatively pointing to
an existing doc that contains such an example or explanations might
help too.

> @@ -2572,18 +2588,25 @@ static int lock_ref_for_update(struct files_ref_s=
tore *refs,
>                         goto out;
>         }
>
> -       ret =3D lock_raw_ref(refs, update->refname, mustexist,
> -                          affected_refnames,
> -                          &lock, &referent,
> -                          &update->type, err);
> -       if (ret) {
> -               char *reason;
> +       lock =3D strmap_get(&backend_data->ref_locks, update->refname);
> +       if (lock) {
> +               lock->count =3D lock->count + 1;

Nit:
              lock->count++;

> +       } else {
> +               ret =3D lock_raw_ref(refs, update->refname, mustexist,
> +                                  affected_refnames,
> +                                  &lock, &referent,
> +                                  &update->type, err);
> +               if (ret) {
> +                       char *reason;
> +
> +                       reason =3D strbuf_detach(err, NULL);
> +                       strbuf_addf(err, "cannot lock ref '%s': %s",
> +                                   ref_update_original_update_refname(up=
date), reason);
> +                       free(reason);
> +                       goto out;
> +               }
>
> -               reason =3D strbuf_detach(err, NULL);
> -               strbuf_addf(err, "cannot lock ref '%s': %s",
> -                           ref_update_original_update_refname(update), r=
eason);
> -               free(reason);
> -               goto out;
> +               strmap_put(&backend_data->ref_locks, update->refname, loc=
k);
>         }
>
>         update->backend_data =3D lock;

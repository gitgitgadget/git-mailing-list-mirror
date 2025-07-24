Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093F25F78F
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352494; cv=none; b=DSD1EhtTy9Gn4ZJvrsBNYdJF2h9XCPWNZ4Zk9X+tIOWl9W+h0GrUDHMCGe8kbyhINtzm0XnH2bJKNK8tNk2sVuSVqCB0guO2KF+K5JUcNK4djfOp3PepzN/10EAfC+dkR6laEHhxOxm2iqErm2oB1j0xCvd+rTPC7XqekrCfQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352494; c=relaxed/simple;
	bh=pifkXWt3hFCcIPE0NEqif2ssZHsks5wp3XztdOoz7A4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=e0ne2+cv9QFNfx2864PL3QQ0GgiK9IHorLTDItKvdhUYAqzArjZy58Z2KmCOIqqPKp8MhXMy/uH211UT1G31YtIRoZhvtTKmVhGrxhJfediWH7fpOyobJMzQCil5FNQBwfqdjMnhTQ2NLOWsedtQS4dmu40bCoLtMXILsO//zPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIHwOB/Q; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIHwOB/Q"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4e9a109035bso630477137.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753352491; x=1753957291; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uf2sthMqMbRjmIr6GplmCrfQw6GxJgRBFz5IS26C5g0=;
        b=NIHwOB/QdyXpHvZianR2YJcwiqorEkHqcEhrn0VNf5o6L0UT+UnNWLtEZhJsYKdRmL
         cUD6TkfK/X/Y8+B8/zT7O9OtQoxMLhqCmGgZtwDOSTpM3Wfk+RdyzzjowMKgT/yme0rm
         +HZlMZNa0sWmk6kf5Eow3FH4t6QhqW/EiAUXRmQbeR49O66v06U9hzf40hO3VedRQcyo
         iq+Jagmx8q5XyZXSQ7gq1U7aVxDRGLUv/FtDlTS2HeuFE7MMHhI3yaxslDDfTgCBtjxs
         uRvLH5e2JB3i0QTZlsspWkkPaIqCOvXZm+zYNV/2JUJz8pTPCiS/H/mGvVPgngtT7ztg
         Tc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753352491; x=1753957291;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uf2sthMqMbRjmIr6GplmCrfQw6GxJgRBFz5IS26C5g0=;
        b=YL+wLC3F4cTzCYWEBI6929PteS0LwtDIqjXq1NFOAIDr8XK8nIspaV4G8LqIaALdVL
         QUKIb9K1INtIcaKaEIExq29Hwi3qjKsm+4HT+2WFpK4WEww1nZbcdT0TGMFaxVpnSCFp
         AOIby2bVEawTdjbarW/i+YCcE3q/zJRZyse3F8JoRns02b8b8iW95BZqwxsjSeI1gMMQ
         kaijmfQ/KEC3UbQugea5M7HcC5J+yBrDyJcDXmQqz4NL/0+jdkGPBAnOC4bBJf0rKG7V
         MBOHVJL9vElu2FwzSVc1Czbri8NOr52kxp9SPBFlqCevWTEqe/Lk8MsGNYTte0PeA+eS
         RvMg==
X-Forwarded-Encrypted: i=1; AJvYcCVdnF/g3PZWvwB5rZkrcAtHy2Kjzk+hvLa5Q925l/x+xNCx0bBfk8Y7DMUXaIhj4YK9GXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6pZEARiUYiBav5NgZHdDnvRlUwZvnpR60AR39fV12LwKxKOyG
	MJSNDhIV0Iv2yL7V3yHdYqZqSsT/DQ9kdVo1uUbn4MyaL48cNWBPvUU9yq82lTQRjEoHc8TJcqH
	YBW/LWah0OQEFd9lvIi250JWkmweQTd4=
X-Gm-Gg: ASbGncsaIWTyyW87mfEUcdLvaCtmy1hmrsBN5StOE+phFlzEMk1Qb2ZMWsdFaofZowq
	tZyXJ1FyB1SHsmNpo8qvQifzXC512aDglzV2yBmM/ieFiGhGKFcM4RwYuqUuEKJureDiEEdinId
	HZp6ehHuEQjSTfwMIDQUAWDlqwRLw4fIZJFDTed+baJVwPmhbXmbgZ3xbHDqub95muUiyepcFZx
	45dLw==
X-Google-Smtp-Source: AGHT+IHLV7xwTfdAg+1mZu/dvO0Ak8s9tclcDYdehOpbtqIbNNN7pQcfMf8wDSY3qxGAlifYdnzbmBzAueRwH5DHPFI=
X-Received: by 2002:a05:6102:38c6:b0:4e6:f86b:143c with SMTP id
 ada2fe7eead31-4fa14fbdea3mr2922776137.1.1753352491303; Thu, 24 Jul 2025
 03:21:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Jul 2025 03:21:30 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Jul 2025 03:21:30 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250722-pks-reflog-append-v1-7-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im> <20250722-pks-reflog-append-v1-7-183e5949de16@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Jul 2025 03:21:30 -0700
X-Gm-Features: Ac12FXyyF12pplNwUiG8beUSk9VMvAamyVkAC53X00UjOGDhq33tsk293Wk6NFs
Message-ID: <CAOLa=ZTRGyypAMcevy2+CMbKQWe5PFqZrv9m5mOeaOAJSDV4kg@mail.gmail.com>
Subject: Re: [PATCH 7/8] refs: stop unsetting REF_HAVE_OLD for log-only updates
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000692611063aaa3044"

--000000000000692611063aaa3044
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/refs.c b/refs.c
> index 64544300dc3..c78d5be6e20 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1384,11 +1384,6 @@ int ref_transaction_update_reflog(struct ref_transaction *transaction,
>  	update = ref_transaction_add_update(transaction, refname, flags,
>  					    new_oid, old_oid, NULL, NULL,
>  					    committer_info, msg);
> -	/*
> -	 * While we do set the old_oid value, we unset the flag to skip
> -	 * old_oid verification which only makes sense for refs.
> -	 */
> -	update->flags &= ~REF_HAVE_OLD;
>  	update->index = index;
>
>  	/*

So we no longer unset the flag, this will ensure that the provided
old_oid is propagated correctly.

> @@ -3310,7 +3305,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>
>  int ref_update_expects_existing_old_ref(struct ref_update *update)

Nit: Wonder if we should update the comment for the function to reflect
how this works with reflog only entries.

>  {
> -	return (update->flags & REF_HAVE_OLD) &&
> +	return (update->flags & (REF_HAVE_OLD | REF_LOG_ONLY)) == REF_HAVE_OLD &&
>  		(!is_null_oid(&update->old_oid) || update->old_target);
>  }
>

Okay this is check now says, if this is a reflog only entry, we don't
expect the reference to exist.

Nit: I wonder if can make this a bit more readable, perhaps:

  int ref_update_expects_existing_old_ref(struct ref_update *update)
  {
      /* reflog only entries may not match on-disk status of a reference */
      if (update->flags & REF_LOG_ONLY)
          return 0;

      return (update->flags & REF_HAVE_OLD &&
          (!is_null_oid(&update->old_oid) || update->old_target);
  }

I'm okay with the current version too.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 89ae4517a97..d519bb615fa 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2493,7 +2493,6 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
>  	 * done when new_update is processed.
>  	 */
>  	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
> -	update->flags &= ~REF_HAVE_OLD;
>
>  	return 0;
>  }
> @@ -2508,8 +2507,9 @@ static enum ref_transaction_error check_old_oid(struct ref_update *update,
>  						struct object_id *oid,
>  						struct strbuf *err)
>  {
> -	if (!(update->flags & REF_HAVE_OLD) ||
> -		   oideq(oid, &update->old_oid))
> +	if (update->flags & REF_LOG_ONLY ||
> +	    !(update->flags & REF_HAVE_OLD) ||
> +	    oideq(oid, &update->old_oid))
>  		return 0;
>
>  	if (is_null_oid(&update->old_oid)) {
> @@ -3061,7 +3061,8 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>  	for (i = 0; i < transaction->nr; i++) {
>  		struct ref_update *update = transaction->updates[i];
>
> -		if ((update->flags & REF_HAVE_OLD) &&
> +		if (!(update->flags & REF_LOG_ONLY) &&
> +		    (update->flags & REF_HAVE_OLD) &&
>  		    !is_null_oid(&update->old_oid))
>  			BUG("initial ref transaction with old_sha1 set");
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 4c3817f4ec1..44af58ac50b 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1180,8 +1180,6 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
>  	if (ret > 0) {
>  		/* The reference does not exist, but we expected it to. */
>  		strbuf_addf(err, _("cannot lock ref '%s': "
> -
> -

Huh. I'm the author of this misshap. Thanks for the cleanup :D

>  				   "unable to resolve reference '%s'"),
>  			    ref_update_original_update_refname(u), u->refname);
>  		return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
> @@ -1235,13 +1233,8 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
>
>  			new_update->parent_update = u;
>
> -			/*
> -			 * Change the symbolic ref update to log only. Also, it
> -			 * doesn't need to check its old OID value, as that will be
> -			 * done when new_update is processed.
> -			 */
> +			/* Change the symbolic ref update to log only. */
>  			u->flags |= REF_LOG_ONLY | REF_NO_DEREF;
> -			u->flags &= ~REF_HAVE_OLD;
>  		}
>  	}
>
> @@ -1265,7 +1258,8 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
>  		ret = ref_update_check_old_target(referent->buf, u, err);
>  		if (ret)
>  			return ret;
> -	} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
> +	} else if ((u->flags & (REF_LOG_ONLY | REF_HAVE_OLD)) == REF_HAVE_OLD &&
> +		   !oideq(&current_oid, &u->old_oid)) {
>  		if (is_null_oid(&u->old_oid)) {
>  			strbuf_addf(err, _("cannot lock ref '%s': "
>  					   "reference already exists"),
>
> --
> 2.50.1.465.gcb3da1c9e6.dirty

Looks good overall. Thanks

--000000000000692611063aaa3044
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 462dd1ee43aaa778_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pQ0NTa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md2JGQy85VmpTYkoyTk5PNXFWbE8xbjU3T3hER1NEVgprb3VQdTRDWkk2
R0tLZE0xRlJSRlNjejJlTzdtUEx5ZFlkMlpEeWsxVnlLRm9hLzdoUzRwVitFK2xPa3p5anJaCkw1
ZzlTMmpUOWJwZnBYLzZBcnVobGE3MHFFTEdBdDBsS0pGR2VCa0xNb2l0aHdjZkUwUFRmcHBOVSt3
WEZnVUkKQUEvWVVGVzJVUjZsRFdZRTNMVGRHN3FHNkRkcm0vRnE2eWxxSHFya09lUlZpR0ZsMkM5
RjdhQ3ZFN3NNQnVtLwovUTVVZEJQdjh6ZmdSazhaZXpEZkU5YjVoV29EcDlCOFBER2dFVXhvSHFt
dEdvakRXY2s0ZXA4WlN1VDQvTUw5CmVjT00xNzBnVVJPYWh1NDNTQnlPajFDeS9tTnZwcGpMUDJm
WkdNNjBYTUlYL1VnclgwdDI5QTF3Q29MSkFteksKOGRxNkRGa3dlSlA2TjVGLzltcUZIeitON2Nw
TGpNZHV3NmZXWjl1SWVPN1ZDT0NJak1XZUhnM1UveGZUeGw5dwp4djNUSEEzcjZ3ZncxUTFseTcv
SDh1N0dMY1VpSHBOU0pINkhVd1JyNUVncHBSQTRDTlZwMkhMZmJ3YTVJMzhjCjJkWHZjcDhNdHI0
bXlpeStKYlRHUlpPK3JTSWpQZ2p2N1RWakJRST0KPUxGRmkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000692611063aaa3044--

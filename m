Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69D23B62B
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350113; cv=none; b=B6aJCDL3GNlUZBO6ym3cg1X4QjOb66V8G6jflIosb4BM4kVE4wN6DOMl7xoW5z8YQTT+ZcHpyL6PWltuBgRHcm44Bxj7/Wkj5kXquVQmiFX3s6O1BICDBFxUjhcuTWJIQWXYeOplntB9PSyTL90X1bIsyplpBuCoW721xU6JQSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350113; c=relaxed/simple;
	bh=vV+Ab+Ez+VPoZE7aiKxhleLIypHJovmCKXtiQAwx5BU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=DTnA6f1LoDWBX8wZ3YcMHyw8Eu93gdJk9gnInb74TGi/sm+ZVNanuXRNwXHFKxPys4sDhTXrAfN4HcByiaFAVvY3gkatzkOytBgxkMhBteLLOkOHKUOkitVV0wEZV3R3Fsz1TMSUc8vxi99B2xH/twcI5LrUCc4IZGyThyVZ1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiGaF3W2; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiGaF3W2"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5379498da7eso1183502e0c.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 02:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753350110; x=1753954910; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1Fgql3Ttij6rIqPo9WcUDKe7CalG7esj5y8dNT8NwE=;
        b=DiGaF3W2vHBhMBomWeXUfDEobKaxvfO2tx10bWQAuycbq19aaDyGyxM8OR4r+Yr6rx
         Bne7DjF8hgwRTjRt4Tj76J7BPgvNcL4ccpI9MoPJxcRNmdDUqQklMx48755m06cYmOF/
         kecF8qw2224cxV7N+fhnxH3DTA0WO8wYHKsTYBk0Y1QAtO0LTHsTNbV+dDMWz0oaDEZg
         snwYS72iid4+g6vFDK7MNv5tZMJbtaYVUpONDL/Z9GIm5vM0LLvoEt47rcVp/Wd0o+sm
         I8D9G8wxzz7Pm1j4z+6l7YVM9IqA15+eTS7GEJqiH3NdPgDNrxKa0piwbogVCIN5l+Xj
         y8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753350110; x=1753954910;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1Fgql3Ttij6rIqPo9WcUDKe7CalG7esj5y8dNT8NwE=;
        b=CzMV+RFJ1BRA36Hh+BxS1NXF5GCwiu5HWl8tsPJbvPiI5XlHX2GKd/Q1MLxy7Vmqd6
         zGT1joPZdtCSkArHn70LWg4hBWBL02IpewNKysQTs7trbATQHW8TEHbiSMy699vsb/cg
         eu0qPbNHuQlyEynFj9hDtyrREFGr1R4f4MibT9LUKs8I2mbfj7uih4ANzFaXcKK/vd10
         e+IPXY7DbrsrlqhpXzx7SSHPfDp3f3XSxeNZ6yS0Mq5VZkhWIVLtAm2poR0ZMxkx4KSv
         OjQLaulXZwhgjmRnyZVFnTW9EWRkDzF9/wSeYQ51eRIwoH0gMjAa4/OXRPjqJckHz0H3
         AAIA==
X-Forwarded-Encrypted: i=1; AJvYcCXHV7O5Ep3RBiXpEU1omyAp1x+lYC/z5alCoP28x7STuom5lDJaKoofUjC0wFqPFjogsk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBscnew14qFSeHkrJmtWTFZNIM3gO8YGIBp3Yeex9TGpNyugLz
	9TruyGFPwJ/ltS04R0bhqM1O5CavPa4xj2IPQ2+S7M4RokPzd6g7ecf4uqrXSk+wW4R7F2Gc7Wn
	HxYCEm7alcu75SX1Gnfe5/qjIOnrf2q2/j47X
X-Gm-Gg: ASbGncsSMSRoc6Kd3pS0lqymurAtxmU6N/+bPDf9BkHF86CO36mXOnI4KkaIgh31xSn
	GKXFNDR24pRB7728ybGOIAlJwp61HGmCNnKQAvAXmK3GRUiYOxoJ1feiutlItpTa6E/ziAJFysW
	+rAIl4S79sQfRScNOlU3Orp9FkIcKmgTaILpDnHHQwL4gxs6C3VAp+YZfN1HgSOjp793w49/H6J
	IDGPA==
X-Google-Smtp-Source: AGHT+IF7rqrPm47Os10go1omFrRPeSnmA/+7k3/2gpi+fL9PX8xEtHGLeflCYxOAneU9dQps8XyFtpVUwM5H8EOufQw=
X-Received: by 2002:a05:6122:458d:b0:530:7e05:2029 with SMTP id
 71dfb90a1353d-5385500d234mr344726e0c.6.1753350110411; Thu, 24 Jul 2025
 02:41:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Jul 2025 04:41:49 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Jul 2025 04:41:49 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250722-pks-reflog-append-v1-6-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im> <20250722-pks-reflog-append-v1-6-183e5949de16@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Jul 2025 04:41:49 -0500
X-Gm-Features: Ac12FXyprv_AhWpz0oUeVpdnqTJ9ZcKWvazzdyBQIF5OgTYlVtGmg_RrOpUumrw
Message-ID: <CAOLa=ZRQj+-WShOn8vQL_fnrPy12n3KB1jrarmJ8Mvz8DnQ-Fg@mail.gmail.com>
Subject: Re: [PATCH 6/8] refs: fix identity for migrated reflogs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007f9a8a063aa9a27e"

--0000000000007f9a8a063aa9a27e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When migrating reflog entries between different storage formats we must
> reconstruct the identity of reflog entries. This is done by passing the
> committer passed to the `migrate_one_reflog_entry()` callback function
> to `fmt_ident()`.
>
> This results in an invalid identity though: `fmt_ident()` expects the
> caller to provide both name and mail of the author, but we pass the full
> identity as mail. This leads to an identity like:
>
>     pks <Patrick Steinhardt ps@pks.im>
>
> Fix the bug by splitting the identity line first. This allows us to
> extract both the name and mail so that we can pass them to `fmt_ident()`
> separately.
>

Well explained.

> This commit does not yet add any tests as there is another bug in the
> reflog migration that will be fixed in a subsequent commit. Once that
> bug is fixed we'll make the reflog verification in t1450 stricter, and
> that will catch both this bug here and the other bug.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 188989e4113..64544300dc3 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2945,7 +2945,7 @@ struct migration_data {
>  	struct ref_store *old_refs;
>  	struct ref_transaction *transaction;
>  	struct strbuf *errbuf;
> -	struct strbuf sb;
> +	struct strbuf sb, name, mail;
>  };
>
>  static int migrate_one_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
> @@ -2984,7 +2984,7 @@ struct reflog_migration_data {
>  	struct ref_store *old_refs;
>  	struct ref_transaction *transaction;
>  	struct strbuf *errbuf;
> -	struct strbuf *sb;
> +	struct strbuf *sb, *name, *mail;
>  };
>
>  static int migrate_one_reflog_entry(struct object_id *old_oid,
> @@ -2994,13 +2994,22 @@ static int migrate_one_reflog_entry(struct object_id *old_oid,
>  				    const char *msg, void *cb_data)
>  {
>  	struct reflog_migration_data *data = cb_data;
> +	struct ident_split ident;
>  	const char *date;
>  	int ret;
>
> +	if (split_ident_line(&ident, committer, strlen(committer)) < 0)
> +		return -1;
> +
> +	strbuf_reset(data->name);
> +	strbuf_add(data->name, ident.name_begin, ident.name_end - ident.name_begin);
> +	strbuf_reset(data->mail);
> +	strbuf_add(data->mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
> +
>  	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
>  	strbuf_reset(data->sb);
>  	/* committer contains name and email */

Nit: This comment is now stale

> -	strbuf_addstr(data->sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
> +	strbuf_addstr(data->sb, fmt_ident(data->name->buf, data->mail->buf, WANT_BLANK_IDENT, date, 0));
>

I was a bit stuck on why we use `WANT_BLANK_IDENT`, since we explicitly
(since we do a split_ident() and that would error out if there is no
name/email) pass the 'name' and the 'email' here as non-null values. So
this seems to be the only option for the enum:

enum want_ident {
	WANT_BLANK_IDENT,
	WANT_AUTHOR_IDENT,
	WANT_COMMITTER_IDENT
};

Since we don't want to extract author or committer information. However,
in fmt_ident() we only use the 'want_ident' value, when either 'name' or
'email' is not set. I found this a bit confusing, perhaps a simple
change of name from 'whose_ident' to 'fallback_ident' would be much more
easier to read and understand. Anyways, this is not for your patch.

>  	ret = ref_transaction_update_reflog(data->transaction, data->refname,
>  					    new_oid, old_oid, data->sb->buf,
> @@ -3017,6 +3026,8 @@ static int migrate_one_reflog(const char *refname, void *cb_data)
>  		.transaction = migration_data->transaction,
>  		.errbuf = migration_data->errbuf,
>  		.sb = &migration_data->sb,
> +		.name = &migration_data->name,
> +		.mail = &migration_data->mail,
>  	};
>
>  	return refs_for_each_reflog_ent(migration_data->old_refs, refname,
> @@ -3115,6 +3126,8 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  	struct strbuf new_gitdir = STRBUF_INIT;
>  	struct migration_data data = {
>  		.sb = STRBUF_INIT,
> +		.name = STRBUF_INIT,
> +		.mail = STRBUF_INIT,
>  	};
>  	int did_migrate_refs = 0;
>  	int ret;
> @@ -3290,6 +3303,8 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  	ref_transaction_free(transaction);
>  	strbuf_release(&new_gitdir);
>  	strbuf_release(&data.sb);
> +	strbuf_release(&data.name);
> +	strbuf_release(&data.mail);
>  	return ret;
>  }
>
>
> --
> 2.50.1.465.gcb3da1c9e6.dirty

The patch look good. Thanks

--0000000000007f9a8a063aa9a27e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ab24b6666ecd1ad4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pQi85c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMDNtQy85NWVZL1RYMTRLZjhydkhKcmdTRGlHbW9tdAoxRzdSVUYxMEpY
Mk14MEFjc2hPbzJ1SEsrWnpTK0pXekJqNk5rMmtUNWVwOEVvc3FuZmZIUGdhOGdZN29KVWQ4CnlD
eHZnU3M2MFVubzBVcXlsaGY0UE5Ya1N3b1JvN3o0VG53eDJrbFNCQVF5RHlLcjhaUDZHT0lSbG5X
KzBMNFIKdm9FbjVwbCsxTThRQjVtalk0UkZ1ZFlTalo0RFFMNDk0UUVvOXlWdVU0VkcyOVMxSXBh
VUN6alAxbElhT2FZbgp3U3hoanZ0ZGtKMTNCckFoR05UT2laSDFXNExjc21KZVdlOHNITk5TZ3Qy
dGNqOVJwQlBod0gyKzFKWFBTekxLCmQ5ci9pTitJMFhoTFlsaHBWdHBKS0JyUEVwVFNYYnNLa3hl
aHdpRVkzV1lnQ05ZWjIrVTgwc1k2cU1jWW1sRHIKdkxKa25BdE1qYUl3bjdJL1ZQeDRKeXJlMTQ4
NHNqNTh4WGxQY0g1NTQxUCtoM3pNV1EzWE5wRy9IZ1NlUjVORwovUkY2THFWT3phRUdnUkI2K0Jp
NFg5S3cyam45a3pWcysxekZobXRSRFN0RzZVRDVqVHVYeGRTUXNQTWhkYmwrCnBWdlJLZklQUVdC
NmtLREtlMlZlNlhjZzYrMDZaaGVEc09VbVp4UT0KPVFNb2cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007f9a8a063aa9a27e--

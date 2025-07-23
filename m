Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C31A930
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300040; cv=none; b=gpCC0bLoxlqAhO7Ad8JGduxDqySqoan6+TF3zzBc0gbNLWq7+SM9+ky89OuNz9N6xLMWf2sqIGHHASlzFqRpa8HQDXtam9bJWBrUJkwzHBOV84Q3bEag9YPj7gm8Zgc4b9FKgCoxbYYNJDektIfkK6FsDomafmD49WCZ13k5zSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300040; c=relaxed/simple;
	bh=fGkJmBnQ2el0W5I3VuhThSvu3hiJmYi3OS7MviXZ0S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0vNnoMewWs3vVJ5VKKE4f8UhX7eE1xBH4+/AqlmwjtZlPfv0ozxg7qAdWRDN6dkY68eb8A1Dt6qfL8X/34VRKtJBE4iVibE/HhYt4LJ6S95VkSrmMZ53iCbdCATQMsTvSjCxGBTsIooXAX4PgdD2NYYJrg0PfbDqRUq4RvtG+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVPutlOX; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVPutlOX"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2ffa1b10918so186434fac.2
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753300038; x=1753904838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SOmsyzK9gc5wkQBBgznnwq5VPW6Xrc2DeuCbOCqgfsI=;
        b=bVPutlOXr6wHwD8YK6pMhSSlnbbBqYDNlCDCnBV3sDaramQfmtB3LRSYwIbTslxDH3
         Imp0lohXDhK7lvT1TqXH+cv8XjCDyaTahe7hV6v9YlmSJB+MHF6VzxaygJaAU+tVaa50
         cbmIpAn1vQ8mUx3jCYGLTFJNQ29LlC0HKY2dJJcXi+CB5pz4E8OCGdeGzpqMW6qz+mlr
         zUPX+GbO9sMCa1wn1o/WnnLVopjvyElS7/A98X/gNRF7bfRU8tS1EGjCwrO4c6f4yVJt
         7pwNhATy/4JIhjAzGFD47ldnmWxputyC6bmKWx89sfj/V42xP/7sNqkOTYiPNMqAJdOk
         3W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753300038; x=1753904838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOmsyzK9gc5wkQBBgznnwq5VPW6Xrc2DeuCbOCqgfsI=;
        b=qUkzJcn/V0GHyPXH2q6jbwZCnoTw/Slokdz5vdYYmKG8fXI5UXFvnqVuBvwTEVowkt
         znHCnNRMlGkuMVEyTsO76KJDgPPbl38PABMNd5wBzUJneHk+OJFgqC1Ud10+wh5CiCmi
         dhTx1cvmg/GtDD/Ted0yqtnN2nnflQN0EtHzpADanQaJ0MfSQRfqTqBgPV4PfvPAukYi
         2kbcmAdXgHQrq2eBEw/lGPs4WMySPiODDye0C4CECbCZi61CUiE2tTtdVw7C/BcY8d8Q
         aXZy+9uFDzLfili6YcRffgQ9nUPAtlexv4V1UspKGm82R3kE7KJLHi/vC5LncoLLQJv/
         1CuA==
X-Gm-Message-State: AOJu0YzOnY+mTg8/a+KRI61a4rkybgNFFd2vOOGqhpzdmUmZA6M+RGd3
	j/Tzg+eXQSZ1ZZZy9G11+Ke0c3/3LRDBA9axhQRQPyzR8kt5gRgvIb3F
X-Gm-Gg: ASbGncvmHpMr/EQlaAzpgdiyzaquzKNu8uigw6qliOM7SjiDdq991KHKNHNksoLp0cd
	zsp6ryLSgOJ8hHSvVwQ0iD4/AVZ0waAhu6s82pgS2nv/J3igNNkBcjcRPYnXfzP9AJTxa647ksf
	fSq2/RKOYBVlMpSO7nhCHUpKydiscW8RavNCwgO3+wGVNrHNGGsF9RD5anVNJhMtHYru+tSudQp
	7kmaduHT6iFV0n2ObtsFb5NU674ZaMLBe5eceC5PIIGCVdG3JN1Ir5RwMZdSEGImAvryoiHIGNs
	I5HlLWcAjmpYmnpB5en2PFM7zKh8ZDV2n3vMAlCe/rwmqj8JTtdIaIGPamro47JobZ3HQ5jj/xQ
	Dnj4Yd/Ih8QeSUuk=
X-Google-Smtp-Source: AGHT+IENxzmm3dNLwEamUY44J+8LQyR34qguNRQ1EzQtrkYI1kbykH7INF82s15+ARGXfBlWbxS4QA==
X-Received: by 2002:a05:6870:8552:b0:2d5:296d:4ed4 with SMTP id 586e51a60fabf-306c72caa18mr3201829fac.28.1753300037465;
        Wed, 23 Jul 2025 12:47:17 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-306e1ec0005sm15466fac.21.2025.07.23.12.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:47:16 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:41:27 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 6/8] refs: fix identity for migrated reflogs
Message-ID: <tg72v5vgu56b6akawy7sfapi2qtrmy7q3uruhersy4dtzkpvju@wamlylndp3xv>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-6-183e5949de16@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-pks-reflog-append-v1-6-183e5949de16@pks.im>

On 25/07/22 01:20PM, Patrick Steinhardt wrote:
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

Ok so IIUC, the bug is the result of passing the full committer info to
the mail field in `fmt_ident()` and leaving the name field unset. To
properly address we need to first deconstruct the committer info into
separate name and mail components and pass them separately to
`fmt_ident()`.

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

Ok now we first deconstruct the committer info.

> +
> +	strbuf_reset(data->name);
> +	strbuf_add(data->name, ident.name_begin, ident.name_end - ident.name_begin);
> +	strbuf_reset(data->mail);
> +	strbuf_add(data->mail, ident.mail_begin, ident.mail_end - ident.mail_begin);

The name and mail components get stored separately.

> +
>  	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
>  	strbuf_reset(data->sb);
>  	/* committer contains name and email */
> -	strbuf_addstr(data->sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
> +	strbuf_addstr(data->sb, fmt_ident(data->name->buf, data->mail->buf, WANT_BLANK_IDENT, date, 0));

`fmt_ident()` now receives the expected information. Looks good

>  
>  	ret = ref_transaction_update_reflog(data->transaction, data->refname,
>  					    new_oid, old_oid, data->sb->buf,
> @@ -3017,6 +3026,8 @@ static int migrate_one_reflog(const char *refname, void *cb_data)
>  		.transaction = migration_data->transaction,
>  		.errbuf = migration_data->errbuf,
>  		.sb = &migration_data->sb,
> +		.name = &migration_data->name,
> +		.mail = &migration_data->mail,

I was a bit confused at first why we cared to assign the name and mail
fields here as it didn't look like we actually use them, but it looks
like we do this to release the the underlying strbuf as we don't free it
from `reflog_migration_data`.

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
> 
> 

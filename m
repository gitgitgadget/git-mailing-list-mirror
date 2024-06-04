Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF35238396
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514891; cv=none; b=E7NDUYmLQSBiMWIRHHGQZXmzjfRptJK7eItJft/CBml9D9042ExmbjjkBH7Jxdgxt/15alN4XQA0pLOUzuzqF1z7Ih5iwbsyGOmK1v3yxLHbQB7e9ZtKfOsh8BZH5EBa2+dno1Rf5L6Y1QlegYQfKYqAcazbMi8WweqnrjkAuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514891; c=relaxed/simple;
	bh=xZfFz8hziZs7m6zz4+DsTT1Rn8SeMw3V8mnH5mO6PgU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE1p17Q0fpCjg+sSQjwZ7PY0Paatv0eOlJAods+TBZ9pRiEMqLKqLd3ImZ2UxGWE+9QQcuORO2eOcSx0GPiE3lG8gf7rasuZzSd6NZ20K7lDRlmfYYXveeBZRyxTU4M/9rAEqUFvTFXlZgqk6M4fmRkSiBL6SeTIjmPg/C+CCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSS/mAsN; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSS/mAsN"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-24c0dbd2866so2536673fac.0
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717514889; x=1718119689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s38beWmJxmvllPZyygVvbUC3i1qjgQqBeV6TJLp1CQc=;
        b=nSS/mAsNM9DimMAyovfQVw6/izdQfl+L1O/YOVOnGxj3//Ren6HB0/U0UOApyLw4et
         6rVRZgbfmaLulzzENjA2Pawn3xc4Eelr5Bp4hV+xk3jO8ztII9iWZVwcRxVkl7DLOOHM
         bVmWzR0Xd5HX01LN7H4zpLFgniMXFqre5gaqJpWmXUwdI2nsQ1isYi7PaZA92jDZS3+8
         yeC0HYqrrXmwbxH4NzYw/075gpHXRsE1SRbuzSHPuDE/WE072KVJIlZ9XOjLVFPci+yd
         +OP7bw8dyiOQOJMfNv7j1oW4whC2q1XtxbmWi5rXw2Yh9hWYQgDAJmtZvR2GeJk0qDbG
         eKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717514889; x=1718119689;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s38beWmJxmvllPZyygVvbUC3i1qjgQqBeV6TJLp1CQc=;
        b=scOf0IhTKc/97xltD9XB5vSVCk1GE5FXF2SXcgHSyQY8PSJLr4/G78XfpsFIK4QOXo
         AaonhQpFq8VcIuf/Z4/IX1eIQvcDf6lfoIU9mMCMz+XlUplvLjEcC04Rd4+oopsxMgvq
         yUOx2FJWUfAVsJtjx8DR5Qs+bBPHM/1nPrg+c82aNPzkMZx8M7iXV824v09hN2v0zXuV
         +CUEn707j335hzPhRLIZ37QhiXPVIuAU1N+utWnqQ6iIhpuASzZWJT2nzXUVn2B8JlHf
         aik04RcM3uzzsSkYrNoWz7opaje/4zzHT4+nRbdsv1w8Adeam6+AZkrFL78eQ/xfHUn8
         +aDA==
X-Forwarded-Encrypted: i=1; AJvYcCW+oAUF+W5n1zg+125z+AnydQSjmdqnhLtoKnrG8pgXPVObcKwexn/HrOJWwlNop2mYMUh3WdY72T9ikc3vp/s7nTcT
X-Gm-Message-State: AOJu0YynQVbwnp3CZKmZEl9Ap9uHE6Bg0S72y1BwTPamRRs2qfBuubLR
	1S12/IVW7K4zwfcevUGXonQE+3a/5V86oyAGqR/Jxebwk6Qc2WSCm9xRAe/AhwuHDD8gx2ZrY7u
	uUMn0w8gQx6qZTJTwmOfPBzdWfeBxG5Uy
X-Google-Smtp-Source: AGHT+IHyd/1wYrTLOjrYSdrxsRGyhvlnjkFOEwuz9oI39gY038oxyPj/9fWBYzelAxpIwyrhRPeAYrLrbyg1lNdoVW4=
X-Received: by 2002:a05:6870:a413:b0:24f:dc4e:5585 with SMTP id
 586e51a60fabf-2508b830e09mr13978547fac.6.1717514888496; Tue, 04 Jun 2024
 08:28:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Jun 2024 15:28:07 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <1f26051eff8b7c18bb7114803454611272f84e19.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im> <cover.1717402363.git.ps@pks.im> <1f26051eff8b7c18bb7114803454611272f84e19.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Jun 2024 15:28:07 +0000
Message-ID: <CAOLa=ZS_2gH4Ob-OTpwFARmmNivW9QXHf5de_ybw2swLwhb79g@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] refs: implement logic to migrate between ref
 storage formats
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000d36764061a121819"

--000000000000d36764061a121819
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
[snip]

> diff --git a/refs.c b/refs.c
> index 9b112b0527..f7c7765d23 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2570,3 +2570,308 @@ int ref_update_check_old_target(const char *referent, struct ref_update *update,
>  			    referent, update->old_target);
>  	return -1;
>  }
> +
> +struct migration_data {
> +	struct ref_store *old_refs;
> +	struct ref_transaction *transaction;
> +	struct strbuf *errbuf;
> +};
> +
> +static int migrate_one_ref(const char *refname, const struct object_id *oid,
> +			   int flags, void *cb_data)
> +{
> +	struct migration_data *data = cb_data;
> +	struct strbuf symref_target = STRBUF_INIT;
> +	int ret;
> +
> +	if (flags & REF_ISSYMREF) {
> +		ret = refs_read_symbolic_ref(data->old_refs, refname, &symref_target);
> +		if (ret < 0)
> +			goto done;
> +
> +		ret = ref_transaction_update(data->transaction, refname, NULL, null_oid(),
> +					     symref_target.buf, NULL,
> +					     REF_SKIP_CREATE_REFLOG | REF_NO_DEREF, NULL, data->errbuf);
> +		if (ret < 0)
> +			goto done;
> +	} else {
> +		ret = ref_transaction_create(data->transaction, refname, oid,
> +					     REF_SKIP_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION,
> +					     NULL, data->errbuf);
> +		if (ret < 0)
> +			goto done;
> +	}

I was a little perplexed about the first scenario being
`ref_transaction_update` and the second being `ref_transaction_create`,
I then realized that this is because the latter doesn't support creating
symrefs yet (changes in my series kn/update-ref-symref), makes sense to
do it this way.

[snip]

> +int repo_migrate_ref_storage_format(struct repository *repo,
> +				    enum ref_storage_format format,
> +				    unsigned int flags,
> +				    struct strbuf *errbuf)
> +{
> +	struct ref_store *old_refs = NULL, *new_refs = NULL;
> +	struct ref_transaction *transaction = NULL;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct migration_data data;
> +	size_t reflog_count = 0;
> +	char *new_gitdir = NULL;
> +	int did_migrate_refs = 0;
> +	int ret;
> +
> +	old_refs = get_main_ref_store(repo);

Should we add a check to ensure the `old_refs->repo->ref_storage_format`
and `format` are different?

> +
> +	/*
> +	 * We do not have any interfaces that would allow us to write many
> +	 * reflog entries. Once we have them we can remove this restriction.
> +	 */
> +	if (refs_for_each_reflog(old_refs, count_reflogs, &reflog_count) < 0) {
> +		strbuf_addstr(errbuf, "cannot count reflogs");
> +		ret = -1;
> +		goto done;
> +	}
> +	if (reflog_count) {
> +		strbuf_addstr(errbuf, "migrating reflogs is not supported yet");
> +		ret = -1;
> +		goto done;
> +	}

Isn't this restrictive? It would be nice to perhaps say "git refs
migrate --ignore-reflogs", which could make it possible to not care
about reflogs. But maybe that can be part of a follow up.

> +	/*
> +	 * Worktrees complicate the migration because every worktree has a
> +	 * separate ref storage. While it should be feasible to implement, this
> +	 * is pushed out to a future iteration.
> +	 *
> +	 * TODO: we should really be passing the caller-provided repository to
> +	 * `has_worktrees()`, but our worktree subsystem doesn't yet support
> +	 * that.
> +	 */
> +	if (has_worktrees()) {
> +		strbuf_addstr(errbuf, "migrating repositories with worktrees is not supported yet");
> +		ret = -1;
> +		goto done;
> +	}
> +

Same as above.

> +	/*
> +	 * The overall logic looks like this:
> +	 *
> +	 *   1. Set up a new temporary directory and initialize it with the new
> +	 *      format. This is where all refs will be migrated into.
> +	 *
> +	 *   2. Enumerate all refs and write them into the new ref storage.
> +	 *      This operation is safe as we do not yet modify the main
> +	 *      repository.
> +	 *
> +	 *   3. If we're in dry-run mode then we are done and can hand over the
> +	 *      directory to the caller for inspection. If not, we now start
> +	 *      with the destructive part.
> +	 *
> +	 *   4. Delete the old ref storage from disk. As we have a copy of refs
> +	 *      in the new ref storage it's okay(ish) if we now get interrupted
> +	 *      as there is an equivalent copy of all refs available.
> +	 *
> +	 *   5. Move the new ref storage files into place.
> +	 *
> +	 *   6. Change the repository format to the new ref format.
> +	 */
> +	strbuf_addf(&buf, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
> +	new_gitdir = mkdtemp(xstrdup(buf.buf));
> +	if (!new_gitdir) {
> +		strbuf_addf(errbuf, "cannot create migration directory: %s",
> +			    strerror(errno));
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	new_refs = ref_store_init(repo, format, new_gitdir,
> +				  REF_STORE_ALL_CAPS);
> +	ret = ref_store_create_on_disk(new_refs, 0, errbuf);
> +	if (ret < 0)
> +		goto done;
> +
> +	transaction = ref_store_transaction_begin(new_refs, errbuf);
> +	if (!transaction)
> +		goto done;
> +
> +	data.old_refs = old_refs;
> +	data.transaction = transaction;
> +	data.errbuf = errbuf;
> +
> +	/*
> +	 * We need to use the internal `do_for_each_ref()` here so that we can
> +	 * also include broken refs and symrefs. These would otherwise be
> +	 * skipped silently.
> +	 *
> +	 * Ideally, we would do this call while locking the old ref storage
> +	 * such that there cannot be any concurrent modifications. We do not
> +	 * have the infra for that though, and the "files" backend does not
> +	 * allow for a central lock due to its design. It's thus on the user to
> +	 * ensure that there are no concurrent writes.
> +	 */
> +	ret = do_for_each_ref(old_refs, "", NULL, migrate_one_ref, 0,
> +			      DO_FOR_EACH_INCLUDE_ROOT_REFS | DO_FOR_EACH_INCLUDE_BROKEN,
> +			      &data);
> +	if (ret < 0)
> +		goto done;
> +
> +	/*
> +	 * TODO: we might want to migrate to `initial_ref_transaction_commit()`
> +	 * here, which is more efficient for the files backend because it would
> +	 * write new refs into the packed-refs file directly. At this point,
> +	 * the files backend doesn't handle pseudo-refs and symrefs correctly
> +	 * though, so this requires some more work.
> +	 */
> +	ret = ref_transaction_commit(transaction, errbuf);
> +	if (ret < 0)
> +		goto done;
> +	did_migrate_refs = 1;
> +
> +	if (flags & REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN) {
> +		printf(_("Finished dry-run migration of refs, "
> +			 "the result can be found at '%s'\n"), new_gitdir);
> +		ret = 0;
> +		goto done;
> +	}
> +
> +	/*
> +	 * Until now we were in the non-destructive phase, where we only
> +	 * populated the new ref store. From hereon though we are about
> +	 * to get hands by deleting the old ref store and then moving
> +	 * the new one into place.
> +	 *
> +	 * Assuming that there were no concurrent writes, the new ref
> +	 * store should have all information. So if we fail from hereon
> +	 * we may be in an in-between state, but it would still be able
> +	 * to recover by manually moving remaining files from the
> +	 * temporary migration directory into place.
> +	 */

This also means that the recovery would only be possible into the new
format. Makes sense.

[snip]

--000000000000d36764061a121819
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6192d35e79e501b0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aZk1vSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEgzQy85S3ZBN3pKdVQrSVJpMlBoZWh2QVdFTVI2dQpSQVVpNnUyQ1ha
b2laZkp5SGxpYWc2R2dzNkR2bjRRaURqYjFtaUIwQlViOHM2Y1RsTFhaNmNzSVl0VEpFMTFCCmRu
MjVQUmpic1FKcjlIcE8vZE1LRG9MQUpxMjRRWjdrOGQ4UVcyMG1LU0N0WG5EWWhLZXNqVFFrUEhy
NnlLdHEKU2hFV25rRTNIS2dJWmM4eVFVOE82SXR4U3pLYUtDMXBwRGQ1NU05aFpyZ2lackJmWkpT
bjdvMFRmZ3VJQWQ4NgpHZFB2elNnSnlmeHpYcER1WkxCWFZlSDh0eU9ka0VzRi9jc1dMSkxSTHZx
K295Vm5udHd3YXkrdVZkdnRjblhBCnV4SE1KbkM5R3lzKzRqMkVibEc0ejFSUkl2TDk2ckF1ellL
ak9kRStNd2xrQXRoWWJ1K2o2a08zMWpzTGZhOVoKRzBwU3JIdzZXbE5iOFZEUEpUVFRlQk53SUkz
aDl1UlVHN1Z2Vk8xRVc0SWJmTGYzOTA4djlITDduOUVIVGdnTQpWYUVsNTdkakdSemduVW1LQWhR
QVBxbFVwZ0x3QTI2eXpQdHM2SDJHUEpwUU9FMHBncEVlYjQ5ME1oMjF0ZUFJCnZCdjl1WUluMkUy
dHI4QThEQlQ5WDNxMENkZkFMSGgyUmd4Z0hlcz0KPW1ac2wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d36764061a121819--

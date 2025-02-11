Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C722C9A
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254160; cv=none; b=e6qPhfJERPJSORl2qqJlY4ujKhgIACR3LcuA/52gd3SkmeSWDx+yMSmuhNnOzDU5F1VdqxmbKRqk9YOdwuNq7kGzpnB9td2fBGty875LQj18712HnXAiZVzV3U2KL+SdGUnpBY/D3PARrUrl38r+/RbGeFfZUm83GHAeJ3iBxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254160; c=relaxed/simple;
	bh=86YlGr83bq0agNwrAQgVdtRu5s4qtbTnNYwQuTdiSo4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F97asdTW5/1sSv52y/4gyEhUKFMm3Q2FkLo1TT/dXlyROssKCQ6YhYTN7eNY9hZQft+r1iNv/wKh0FOWimYoQ9il5Q/nEHjNOXIOH0jOSHY/FZS3C5GJQVOrVW5/H6RzSFnjw/QvFu6YvL26mMAVGOir+jCpSbloMtaKWZBUnzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U921VKfM; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U921VKfM"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-520349fc3ddso801685e0c.1
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 22:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739254157; x=1739858957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ciBWl8l9H+tRmRT59uxXT2TFhlnOzSwSwlKTQp73n2I=;
        b=U921VKfM/OqqyA0MAc61hbsHBDXPn9orsrw1H5yKTpyqlkNt2UEkXLwN0RIY4NtkeU
         AJ98zpbanZmFkrS9Iy5wj3n91La73XkKUYLr7SmEUdnWFmhSb/11XMEfNJDKTSeQG+4H
         uX5pYr+zEAlOJgvixLVtxm8GT2BTK9+kfhO04l+t9nR+C2qOnVHshB9wjyj9gGtAaQkU
         iOC+MPbabLYic3nYgRiqWHYillqtNsxmg6B1N8oS/x1pkF9i24khFHq08roWljN5tSXn
         sy10ngt8eswTVha+m47IhhFA4W2RZmQMOYCs5xFxuD8SFaJXIoDQop7O1ug2C9fYv/0X
         0I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739254157; x=1739858957;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciBWl8l9H+tRmRT59uxXT2TFhlnOzSwSwlKTQp73n2I=;
        b=Sc6x5B1qpzj8AjuCVkP2vl+Xcj63+cdkLtZCLr/CqeMafModXbPObW+oTwnnXsBpSO
         jYJFeKQyLum7CbZJjUFulXtSynvTtUqCu9lHaiv+C1KGPZAk/0jxWSHhXd59ePK8NgKF
         iTDVi4O2sa6FqwJ3ucRBWPwUn4hn40hpbBoAcfC33gU1HSfb3eKTfmoqT87OdzZ83PV1
         eJxjSWjpPdD86thAE+g2GxIYXurIFnrvPn2/hBe/yW86rxi32LZ6wzg5etsdgz3dQDUs
         JPZHYJ2NixdTCvfH5Zt9cxfqQri8O3t8OBMv9fBKwNx1xNubIuxSl8SSl+zDthLPJfPE
         lMQg==
X-Gm-Message-State: AOJu0Yx8d+VY1aere/ZEa1hEBRZGu/49lDOkEE4j3b/Zh6eYlK5Sn7to
	X3TgFWktZYCWmsiusMVzLa+hlpcUMv2biExec/x04/5QQhN9+kllpyfx2x6YxVm3WF0uV0pvBnt
	Aa7a56E+m3bFtl16NEsimzM4foSZsHKFk
X-Gm-Gg: ASbGncuV7ckpF+/HJ3AqlfmjAbPvu3Cho2an3vxuW2hQGOKpeMRbAomJn7tDh0mrfO8
	b4wwl4UePzRwZBLoCTLfft1A+yh2TiTnF+Jn0LdcbBz1bRgnYkvGWmDHASm+ayjWsYhJehWu+3s
	nfgp0dS4gtaNlbewHe1UzgBVJ/ZprDiQ==
X-Google-Smtp-Source: AGHT+IFuBIo9LV2i/lFFX4lPLrSIaQ4rMrvfNVY6C0BbQci1VQ8YLrreNW4ICrGFQJe4rqgi2egiPekyY01L0q3k3GY=
X-Received: by 2002:a05:6122:251d:b0:519:fcf2:ef51 with SMTP id
 71dfb90a1353d-51f2e12026dmr10212478e0c.5.1739254157454; Mon, 10 Feb 2025
 22:09:17 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Feb 2025 22:09:16 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <llz32al6tgghs73odbryc2324vks2pf3uyawp5dls5wgop7or2@bumahbjibtgz>
References: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
 <llz32al6tgghs73odbryc2324vks2pf3uyawp5dls5wgop7or2@bumahbjibtgz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Feb 2025 22:09:16 -0800
X-Gm-Features: AWEUYZng5zuGyiF7cbioaGw7kFk1LrPe7LHy4ifeScHsTmvVnGLs2cyI069OqIg
Message-ID: <CAOLa=ZTGTr_3Xe2mLZ9wYB6oo++TuLUN-OQ2Cpv9Fokgc77UcQ@mail.gmail.com>
Subject: Re: [PATCH] builtin/refs: add '--skip-reflog' flag to bypass reflog migration
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003adf6e062dd7aa75"

--0000000000003adf6e062dd7aa75
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 25/02/07 12:57PM, Karthik Nayak wrote:
>> The 'git-refs(1)' migrate subcommand, which transfers repositories
>> between reference backends, currently migrates reflogs by default as of
>> In 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
>
> s/In 246cebe320/246cebe320/
>

Thanks.

>> While this behavior is desirable for most client-side repositories,
>> server-side repositories typically don't use reflogs and the migration
>> of these entries is unnecessary overhead.
>>
>> Add a '--skip-reflog' flag to the migrate subcommand to make reflog
>> migration optional. This is particularly useful for server-side
>> migrations where reflogs are not needed, improving migration performance
>> in these scenarios.
>
> Just to clarify, does a repository already without reflogs see improved
> migration performance with this `--skip-reflog` flag? Or is the improved
> performance soley due to repositories with reflogs skipping that part of
> the migration?
>

Since we iterate over all reflogs and add them, the perf gain would only
be for repositories which already have reflogs. Will modify accordingly.

>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> ---
>>  builtin/refs.c          |  3 +++
>>  refs.c                  |  8 +++++---
>>  refs.h                  |  5 ++++-
>>  t/t1460-refs-migrate.sh | 17 +++++++++++++++--
>>  4 files changed, 27 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/refs.c b/builtin/refs.c
>> index a29f19583474518ee0942ea53c39cbdf9661c5e2..30be0254c14dd3d07693d70c25dddc9990756e9c 100644
>> --- a/builtin/refs.c
>> +++ b/builtin/refs.c
>> @@ -30,6 +30,9 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
>>  		OPT_BIT(0, "dry-run", &flags,
>>  			N_("perform a non-destructive dry-run"),
>>  			REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN),
>> +		OPT_BIT(0, "skip-reflog", &flags,
>> +			N_("skip migrating reflogs"),
>> +			REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG),
>>  		OPT_END(),
>>  	};
>>  	struct strbuf errbuf = STRBUF_INIT;
>> diff --git a/refs.c b/refs.c
>> index f4094a326a9f88f979654b668cc9c3d27d83cb5d..5e8f5c06fa68d16c93ee11edd9742995eea994b6 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3035,9 +3035,11 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>>  	if (ret < 0)
>>  		goto done;
>>
>> -	ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
>> -	if (ret < 0)
>> -		goto done;
>> +	if (!(flags & REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG)) {
>> +		ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
>> +		if (ret < 0)
>> +			goto done;
>> +	}
>
> When the `REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG` flag is set, we
> now skip over all the logs to perform the reflog migration. Makes sense.
>

Yup, thanks for the review.

> -Justin
>

--0000000000003adf6e062dd7aa75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fc3604b1d4c56389_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lcTZZa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1I1Qy80bGxXaEUvNldFbXAwdVhVYWpGNmFtTHJxaword2N5OUEzUkV1
SEpSOFplS091S0RzckN1MVhGT3N6REdJTFVzSm5IZHBYTzhJMFJaQzBQRWV1YmJXZkx5TnZKCnZT
a09yUWp2MlpVek40T28xQ0xOejA0dVdGZW5FTEVQOE1qcFhvaGlnZVlRcmdMVUd2YTJ2a1d6Tkhm
T29hQkYKRkRWMlZMY1NLU1FsSTRpU0d2YXd3WEQwWFlKSWx2R2QyME03V1NMVVI1WGZaZXl6SDRY
ZDRzd2VqV3BaNEVCZwppZFBiYlFBZEltM1VQOWdMQ0ZrQjNIdFJORlZLV1Z1V3JuMjFOczZ3eEps
U0F0cGdQV3VieFpNZDBFMldGY1hoCkllejV6eG0ycEUwTTBjdDZVQzNlSTdpZGJhSG9VOExFQjdJ
QU12aHVUc1B6aUpzNUtVSjBMYnRsclFNbVdpaVAKL0prdDJWRWpSdHBKUitJMVcvejA2NmhZOGlS
alQ5dERyV21TSkJVRkxncWEvdUlLU1VUVndvR25FaFBLaUVzMwp1SEllRkRoOTNOWVlnQkRhQmhD
UXRCalBDaHNwOHNtMGxHaHM2RmRHNUFyQjYzWUZ3K0FnTVQyaFhlNmpISjFLCnpVTFdIOWFMT0dj
MUk3NUpuNmF5dHNYUmNqcVduc0xuMXBxN2RvWT0KPUdpYVkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003adf6e062dd7aa75--

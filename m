Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0535A29C335
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751540067; cv=none; b=cuOTgtv2Itp/vXnJK31LKAKtW8L4+w6FkzFGT9GHGSnOWfbvSRGqwyRXlDEGXR66IuvaYMrqrqNARywryEX8yCw4ndvUd505fVJsCTjcsqjUMZDtbNxLh+2gmu8H/NPH/xtYijZVyna5Vnrst6kN2GmmgZgDro5gJ/aBCId/qLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751540067; c=relaxed/simple;
	bh=qEvManTxCfJDOWEHb2boYdNCHANYCiRw0lDBbjNvLbs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvOEMCSRcVZSE5JtZSbNtmuNxgY6Tscghhan0Agy+2fYVi3tXpZJYRWhjhlMQS0ljAQY2PlUrc+Ri2frOzGujvcQCn4hGoeUuQq9Q4Hm65w+5HnldnpHRsFakqkOiugOrrb15kLKGf3pWmYUdilRXEFfLcllmxZIQVcCjU684+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATbArwN0; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATbArwN0"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-53164bd0df3so2375962e0c.0
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 03:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751540065; x=1752144865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=prdwDpjpCtAeZzYzmdh8boxn3lJbWvoSHzmpL1QvVxE=;
        b=ATbArwN0saC8qcMc9Hmwy++Ptrbhzz2iGgYWGXsvm9Te8QeG41jLKNfsvN+WeofRvg
         6aWRHjNfFllkr5RDA25AfrOjHQHJxpM9Ex1BvQQV5SbSEDGY+WpeEn5UBxgAzRBtegYz
         sfb6x9y93JM9tY1ZwwF85g14FlWXsX/8VjL+KDxwooMTFSm/fsgsk3491/rNdQwrvO6D
         g8SOMtIeHZRxsPFSMcDbNSFOiRCW/9eRAcLa2MV0dUvSe09lW/H0PqzoUKByLjnTTH+l
         1yydchMS0buHAWv0uFRWJ1vWDHlRc2KZG3RmjUno7SuSKByBFAXzMrO8YoCynFsHv7zq
         7BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751540065; x=1752144865;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prdwDpjpCtAeZzYzmdh8boxn3lJbWvoSHzmpL1QvVxE=;
        b=GiVu/xpKLw3J87Q/vqyg3MmG1Ng4HvM6FxvdymIB8McxLldNpzIpxqGb0Dw5uFy59X
         xEEqnT7bvBsWHuD6pNbeD3mHaYj55h3d9kDGlbc8uHHJ4ztj2Wu7SxV9yy08tWPj3jb7
         JoURtt8KN5oxQvVg6gT2EEPmu76YZW07zHvfoIqof6OjDoqtKq1nwCN3PRTfzZX9IV7T
         1xS4XXoQ2Ti9AELuxztdNIovMUbhv2ploPHJcaiPVLwfe2o5t4O51V+dGyxwp7UN7TZj
         4RaUbPc/HjWwu2tgqsWSc9a5uHQAShmp7nW0cpeeUKwpl+SJS8t0vfyRzikd5iczab9C
         2sEA==
X-Forwarded-Encrypted: i=1; AJvYcCUuWsEUmBW9c6zVr3tDw0eQkrMX0WfLHDd20u8BHpUd6mEeodJjoScVhICPirCU2JFp9aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJCDnypENK0aNpfjccxblEvA1p0FWPeEph67wCvgL1btJtIR+
	reyenY3WAxgc5pkyRkdZxEOcPNMuy3jILv9WbsBcRwmRhmXQYpUsk9xEFLL7gPogyesKhPoOQZ7
	mK3SzWP4CGxLuDYyHmWhoRivnyhX+wN4=
X-Gm-Gg: ASbGnctb9ri/M/ZlbDl9DxIvonysFMXtRpddDbg6OvCIUw7gZgutUiL5AbTfb1s0TXn
	k6GRxAGfqcWmYub0CZu6WU9ZdCGZUNj8CkN4Z4CgucZDDNTrX1wfDAYUSVwhdotGX1+rrA6NND1
	PhgDkZuwvitb9wV1ZZo0tvLKFkPdycbvdz8zYERLMybTzX
X-Google-Smtp-Source: AGHT+IFbdfX/o10c76vA6VtXKEh5PkpbvtEg0a7QBxMutq14a6YzWWZLybFGQaoylEoE0/Dv4hAlxh7iHOIgFNo9VAE=
X-Received: by 2002:a05:6122:1e01:b0:531:1904:203a with SMTP id
 71dfb90a1353d-53457c4b8dcmr4575952e0c.0.1751540064776; Thu, 03 Jul 2025
 03:54:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Jul 2025 12:54:24 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250703-pks-reftable-default-backend-v2-1-5a27e72a8c5e@pks.im>
References: <20250703-pks-reftable-default-backend-v2-0-5a27e72a8c5e@pks.im> <20250703-pks-reftable-default-backend-v2-1-5a27e72a8c5e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Jul 2025 12:54:24 +0200
X-Gm-Features: Ac12FXwnHwP-HvYGcSAsruioE4eEoqSrqxGC9OQ1XDFHB9ZZx7il2o3duGPOy6E
Message-ID: <CAOLa=ZTJOqqr25Sj0YSAc9rDmar2qZiVD3H+K6qhdN3qKdqbGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] BreakingChanges: announce switch to "reftable" format
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com, 
	Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005f302c0639043311"

--0000000000005f302c0639043311
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The "reftable" format has come a long way and has matured nicely since
> it has been merged into git via 57db2a094d5 (refs: introduce reftable
> backend, 2024-02-07). It fixes longstanding issues that cannot be fixed
> with the "files" format in a backwards-compatible way and performs
> significantly better in many use cases.
>
> Announce that we will switch to the "reftable" format in Git 3.0 for
> newly created repositories.
>

Nit: This commit does more than announce the switch. It also adds in the
changes to use reftable when WITH_BREAKING_CHANGES is set. Would be nice
to call that out here.

> This switch is dependent on support in the larger Git ecosystem. Most
> importantly, libraries like JGit, libgit2 and Gitoxide should support
> the reftable backend so that we don't break all applications and tools
> built on top of those libraries.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/BreakingChanges.adoc | 44 ++++++++++++++++++++++++++++++++++++++
>  help.c                             |  2 ++
>  repository.h                       |  6 ++++++
>  setup.c                            |  2 ++
>  t/t0001-init.sh                    | 11 ++++++++++
>  5 files changed, 65 insertions(+)
>
> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
> index c6bd94986c5..614debcd740 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -118,6 +118,50 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
>  <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
>  <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
>
> +* The default storage format for references in newly created repositories will
> +  be changed from "files" to "reftable". The "reftable" format provides
> +  multiple advantages over the "files" format:
> ++
> +  ** It is impossible to store two references that only differ in casing on
> +     case-insensitive filesystems with the "files" format. This issue is common
> +     on Windows and macOS platforms. As the "reftable" backend does not use
> +     filesystem paths anymore to encode reference names this problem goes away.

Nit: s/anymore// makes it clearer, since reftable never used filesystem
path.

> +  ** Similarly, macOS normalizes path names that contain unicode characters,
> +     which has the consequence that you cannot store two names with unicode
> +     characters that are encoded differently with the "files" backend. Again,
> +     this is not an issue with the "reftable" backend.
> +  ** Deleting references with the "files" backend requires Git to rewrite the
> +     complete "packed-refs" file. In large repositories with many references
> +     this file can easily be dozens of megabytes in size, in extreme cases it
> +     may be gigabytes. The "reftable" backend uses tombstone markers for
> +     deleted references and thus does not have to rewrite all of its data.
> +  ** Repository housekeeping with the "files" backend typically performs
> +     all-into-one repacks of references. This can be quite expensive, and
> +     consequently housekeeping is a tradeoff between the number of loose
> +     references that accumulate and slow down operations that read references,
> +     and compressing those loose references into the "packed-refs" file. The
> +     "reftable" backend uses geometric compaction after every write, which
> +     amortizes costs and ensures that the backend is always in a
> +     well-maintained state.
> +  ** Operations that write multiple references at once are not atomic with the
> +     "files" backend. Consequently, Git may see in-between states when it reads
> +     references while a reference transaction is in the process of being
> +     committed to disk.
> +  ** Writing many references at once is slow with the "files" backend because
> +     every reference is created as a separate file. The "reftable" backend
> +     significantly outperforms the "files" backend by multiple orders of
> +     magnitude.

Perhaps something about how reftable uses a binary format and could save
storage space.

> ++
> +Users that get immediate benefit from the "reftable" backend could continue to
> +opt-in to the "reftable" format manually by setting the "init.defaultRefFormat"
> +config. But defaults matter, and we think that overall users will have a better
> +experience with less platform-specific quirks when they use the new backend by
> +default.
> ++
> +A prerequisite for this change is that the ecosystem is ready to support the
> +"reftable" format. Most importantly, alternative implementations of Git like
> +JGit, libgit2 and Gitoxide need to support it.
> +
>  === Removals
>
>  * Support for grafting commits has long been superseded by git-replace(1).
> diff --git a/help.c b/help.c
> index 21b778707a6..89cd47e3b86 100644
> --- a/help.c
> +++ b/help.c
> @@ -810,6 +810,8 @@ void get_version_info(struct strbuf *buf, int show_build_options)
>  			    SHA1_UNSAFE_BACKEND);
>  #endif
>  		strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
> +		strbuf_addf(buf, "default-ref-format: %s\n",
> +			    ref_storage_format_to_name(REF_STORAGE_FORMAT_DEFAULT));
>  	}
>  }
>
> diff --git a/repository.h b/repository.h
> index c4c92b2ab9c..77c4189d5dc 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -20,6 +20,12 @@ enum ref_storage_format {
>  	REF_STORAGE_FORMAT_REFTABLE,
>  };
>
> +#ifdef WITH_BREAKING_CHANGES /* Git 3.0 */
> +# define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_REFTABLE
> +#else
> +# define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_FILES
> +#endif
> +

Okay this makes sense.

>  struct repo_path_cache {
>  	char *squash_msg;
>  	char *merge_msg;
> diff --git a/setup.c b/setup.c
> index f93bd6a24a5..f0c06c655a9 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2541,6 +2541,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
>  			repo_fmt->ref_storage_format = ref_format;
>  	} else if (cfg.ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
>  		repo_fmt->ref_storage_format = cfg.ref_format;
> +	} else {
> +		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
>  	}
>  	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
>  }

Shouldn't this change be instead made to REPOSITORY_FORMAT_INIT?

diff --git a/setup.h b/setup.h
index 18dc3b7368..c1b765043f 100644
--- a/setup.h
+++ b/setup.h
@@ -150,7 +150,7 @@ struct repository_format {
 	.version = -1, \
 	.is_bare = -1, \
 	.hash_algo = GIT_HASH_SHA1, \
-	.ref_storage_format = REF_STORAGE_FORMAT_FILES, \
+	.ref_storage_format = REF_STORAGE_FORMAT_DEFAULT, \
 	.unknown_extensions = STRING_LIST_INIT_DUP, \
 	.v1_only_extensions = STRING_LIST_INIT_DUP, \
 }

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index f11a40811f2..186664162fc 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -658,6 +658,17 @@ test_expect_success 'init warns about invalid init.defaultRefFormat' '
>  	test_cmp expected actual
>  '
>
> +test_expect_success 'default ref format' '
> +	test_when_finished "rm -rf refformat" &&
> +	(
> +		sane_unset GIT_DEFAULT_REF_FORMAT &&
> +		git init refformat
> +	) &&
> +	git version --build-options | sed -ne "s/^default-ref-format: //p" >expect &&
> +	git -C refformat rev-parse --show-ref-format >actual &&
> +	test_cmp expect actual
> +'
> +
>  backends="files reftable"
>  for format in $backends
>  do
>
> --
> 2.50.0.195.g74e6fc65d0.dirty

--0000000000005f302c0639043311
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3a446d35a7401c5b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1obVlWNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMG12REFDRVllZTNhcXBBaGJmVjhHMmZMWkpyUUZaQwpHNFpRcTNDQVJk
RE1QK1drWlJVZWNxT09xYlhKV05QZm8zMVpNN21hemEvblZYWjhFYlhBMVpnOEhjRW9FZkc1ClNK
ZUxCNmdLY3YwZS9jVnNpeXNVa0pWVy9JM2VHQnJmQW1hTUNWV2J0N0lZVTVUbDMzaHZ5R0NiSDhB
ekZxZzgKTjJvWVZWU1hKcXcvdGEwWGM2d2RzaGRvbXl5dlp4NnBKbUVBSWR0K2phTXpnS2ErTlhv
Q3crUjJqTXYzbGRkbAo2RFJHYVdsMWJ2KzMrM0FjSFpWZ0xCVEJhV3lyVE5PbzYzK0x6Wk0wRmtI
NndtcmdVbDRGcmhZdnlJSVNuMTA5CnBNMFQ5ZFluWTZYZ2ttY3JtWUZzWFNNSExnZ1JaTWpSeU9n
aHlPcjQ3c1dtRWlaeGFKbTFwVjNTbk5OcHZjQmIKd25peWtaVGRSWm84UUZCY3JWNjBTWG12c1lY
MzVEUStHSGI0c0VoMDZ3V08vZUQrd1Y1ZlNzeThVR2xpemRtQwpxZlJoQjRISWs3QUU4TFMvdm9K
VnpPdldtaDhRdnFLSFEzL3o4d0FDeFVkL1VYcWZ3WlZkWVlpTERZNnFCcXlGCnlTS24wOWZQN3du
U3dmc1grcVBhNUM4ZEFFSDFobk5PR09CdE5nQT0KPS9QUWcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005f302c0639043311--
